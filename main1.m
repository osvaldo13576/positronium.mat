classdef main1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PositroniumdotMATMdulo1UIFigure  matlab.ui.Figure
        RadiomorfEditField             matlab.ui.control.NumericEditField
        RadiomorfEditFieldLabel        matlab.ui.control.Label
        OpmofolgicaDropDown            matlab.ui.control.DropDown
        OpmofolgicaDropDownLabel       matlab.ui.control.Label
        ErosionarButton                matlab.ui.control.Button
        DilatarButton                  matlab.ui.control.Button
        ColorDropDown                  matlab.ui.control.DropDown
        ColorDropDownLabel             matlab.ui.control.Label
        PginaTIFFDropDown              matlab.ui.control.DropDown
        PginaTIFFDropDownLabel         matlab.ui.control.Label
        GradienteDropDown              matlab.ui.control.DropDown
        GradienteDropDownLabel         matlab.ui.control.Label
        MximoEditField                 matlab.ui.control.NumericEditField
        MximoEditFieldLabel            matlab.ui.control.Label
        MnimoEditField                 matlab.ui.control.NumericEditField
        MnimoEditFieldLabel            matlab.ui.control.Label
        Param2EditField                matlab.ui.control.NumericEditField
        Param2EditFieldLabel           matlab.ui.control.Label
        Param1EditField                matlab.ui.control.NumericEditField
        Param1EditFieldLabel           matlab.ui.control.Label
        FiltroslinealesynolinealesDropDown  matlab.ui.control.DropDown
        FiltroslinealesynolinealesDropDownLabel  matlab.ui.control.Label
        GammaSlider                    matlab.ui.control.Slider
        GammaSliderLabel               matlab.ui.control.Label
        ContrasteSlider                matlab.ui.control.Slider
        ContrasteSliderLabel           matlab.ui.control.Label
        BrilloSlider                   matlab.ui.control.Slider
        BrilloSliderLabel              matlab.ui.control.Label
        RangodinmicoSlider             matlab.ui.control.RangeSlider
        RangodinmicoSliderLabel        matlab.ui.control.Label
        outputTextArea                 matlab.ui.control.TextArea
        UITable                        matlab.ui.control.Table
        CerrarButton                   matlab.ui.control.Button
        AplicarButton                  matlab.ui.control.Button
        GuadarButton                   matlab.ui.control.Button
        ButtonGroup                    matlab.ui.container.ButtonGroup
        DireccinButton                 matlab.ui.control.RadioButton
        MagnitudButton                 matlab.ui.control.RadioButton
        YDirButton                     matlab.ui.control.RadioButton
        XDirButton                     matlab.ui.control.RadioButton
        MostrarhistCheckBox            matlab.ui.control.CheckBox
        InvertirCheckBox_2             matlab.ui.control.CheckBox
        AplicarSegButton               matlab.ui.control.Button
        SegmentacinporhistogramaLabel  matlab.ui.control.Label
        TransponerCheckBox             matlab.ui.control.CheckBox
        AplicarfiltroButton            matlab.ui.control.Button
        ParamsfiltrosLabel             matlab.ui.control.Label
        RealceymejoramientoLabel       matlab.ui.control.Label
        SeleccionarcarpetaButton       matlab.ui.control.Button
        Tree                           matlab.ui.container.Tree
        SeleccioneNode                 matlab.ui.container.TreeNode
        Node                           matlab.ui.container.TreeNode
        UIAxes5                        matlab.ui.control.UIAxes
        UIAxes                         matlab.ui.control.UIAxes
        UIAxes2                        matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        folder % Description
    end
    
    properties (Access = public)
        pt1 = 0; p1
        pt2 = 255; p2
        formatos = {'.png','.jpg','.bmp','.dcm','.pcx','.tif'};
        %%
        img_true
        dcm_true
        %%
        dir_select
        output = "";
        files
        imag_index = 1;
        images_number
        main_matrix
        mod_matrix
        altura, ancho
        color_tipo
        minimo
        maximo
        tiff_pages
        main_image_elements
        rgb_index =0;
        tiff_index=1; 
        hist_on_off = 1;
        main_fig;histog_fig;
        lines_main;lines_mod
        histog_fig_mod,
        histograma_figura
        rang_dinam_editable = 0;
        
        Px 
        Py
        %% 
        brillo = 0;
        contraste = 0;
        gamma = 1;
        %%filtro
        filtro_fig
        fspecial_filtro = ones(5,5);
        filtros = {'Filtro Rnd','average','disk','gaussian','laplacian','log','motion','prewitt','sobel'};
        gradiente_metodo = {'Seleccione...','intermediate','central','prewitt','sobel','Deshacer'};

        %% segmentacion
        seg_min = 100;
        seg_max = 150;
        seg_invertir=0;
        seg_mask
        
        
    end
    
    
    
    methods (Access = private)
        
        function updateTree(app)
            app.SeleccioneNode.Text = app.folder;
        end
        
        function app = setNodes(app,node,folderContent)
            %Delete dummy Nodees
            node.Children(string(node.Children.NodeData) == "Dummy").delete;
            %Delete nodes with . and .. caused by dir command
            [names, nameFromFolder]= pruneFolderContent(app,folderContent);
            folder_node = folderContent.folder;
            pathToMLAPP = fileparts(mfilename('fullpath'));
            %Check if node is top parent
            isParent = false;
            if isa(node.Parent,'matlab.ui.container.Tree')
                isParent = true;
            else
                %     parentNode = node.Parent;
            end

            %Create some Empty Folder texts when opening a folder with no
            %content
            if isempty(names)
                if isParent
                    uitreenode(node,'Text','-Carpeta vacía-','NodeData',fullfile(app.SeleccioneNode.Text,''));
                else
                    %%uitreenode(node,'Text','-Carpeta vacía-','NodeData',fullfile(node.NodeData,''));
                    uitreenode(node,'Text','','NodeData','Dummy','Icon',fullfile(pathToMLAPP,'ico','waiting.gif'));
                end
                return
            end
            for idx = 1:length(names)
                if isParent

                    directorio_n = fullfile(folder_node,names(idx));
                    nodeChild = uitreenode(node,'Text',names(idx),'NodeData',fullfile(app.SeleccioneNode.Text,names(idx)));
                    if ~isfolder(directorio_n)
                        [~,~,ext] = fileparts(directorio_n);
                        if (ext == "")
                            % verificamos si es un archivo DICOM
                            try
                                dicomread(directorio_n);
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','x-ray.png');
                            catch 
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','document.png');
                            end
                        else
                            if any(strcmpi(ext,app.formatos))
                                % si imagen
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','photo.png');
                            else
                                % no imagen
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','document.png');
                            end
                        end
                    else 
                        nodeChild.Icon = fullfile(pathToMLAPP,'ico','open.png');
                    end
                    
                else
                    %%
                    directorio_n = fullfile(folder_node,names(idx));
                    nodeChild = uitreenode(node,'Text',names(idx),'NodeData',fullfile(node.NodeData,names(idx)));
                    if ~isfolder(directorio_n)
                        [~,~,ext] = fileparts(directorio_n);
                        if (ext == "")
                            % verificamos si es un archivo DICOM
                            try
                                dicomread(directorio_n);
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','x-ray.png');
                            catch 
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','document.png');
                            end
                        else
                            if any(strcmpi(ext,app.formatos))
                                % si imagen
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','photo.png');
                            else
                                % no imagen
                                nodeChild.Icon = fullfile(pathToMLAPP,'ico','document.png');
                            end
                        end
                    else 
                        nodeChild.Icon = fullfile(pathToMLAPP,'ico','open.png');
                    end
                    
                end
                if nameFromFolder{idx}
                    %%uitreenode(nodeChild,'Text','','NodeData','Dummy');
                    pathToMLAPP = fileparts(mfilename('fullpath'));
                    uitreenode(nodeChild,'Text','','NodeData','Dummy','Icon',fullfile(pathToMLAPP,'ico','waiting.gif'));
                end
            end
        end
        
        function [names, nameFromFolder]= pruneFolderContent(~,folderContent)
            names = string({folderContent.name});
            nameFromFolder = {folderContent.isdir};
            % se eliminan las carpetas con los nombre . ..
            idxDots = find(or(names == ".",names == ".."));
            names(idxDots) = [];
            nameFromFolder(idxDots) = [];
            
        end
        %%

        %% Histogramas, histograma acumulativo, ecualización acumulativa
        function [hist] = histograma_fig(~,imagen,altura,ancho,color,fcolor,UI_AXES)
                binLocations=(ancho*0.40)*(0:1:255)/255;
            if contains(color,'truecolor')                
                [counts1,counts2,counts3] = deal(imhist(imagen(:,:,1)),imhist(imagen(:,:,2)),imhist(imagen(:,:,3)));
                hist = altura-(altura*0.40)*[counts1,counts2,counts3]/max(max([counts1,counts2,counts3]));
                hist1= area(UI_AXES,binLocations,hist(:,1),FaceAlpha=0.6,BaseValue=altura,FaceColor = 'r',EdgeColor='none');
                hist2= area(UI_AXES,binLocations,hist(:,2),FaceAlpha=0.6,BaseValue=altura,FaceColor = 'g',EdgeColor='none');
                hist3= area(UI_AXES,binLocations,hist(:,3),FaceAlpha=0.6,BaseValue=altura,FaceColor = 'b',EdgeColor='none');
                hist = [hist1,hist2,hist3];
            else
                counts = imhist(imagen);
                hist = altura-(altura*0.40)/max(max(counts))*counts;
                hist = area(UI_AXES,binLocations,hist,FaceAlpha=0.6,BaseValue=altura,FaceColor = fcolor,EdgeColor='none');
            end
        end

     
        %%
        function [punto1, punto2, pos1, pos2] = slider_2(~,x,pos1,pos2,UI_AXES)
            x = round(x);
            
            if x <= pos1 
                if x < 0
                    pos1 = 0;
                else
                    pos1 = x;
                end
            end

            if x >= pos2 
                if x > 255
                    pos2 = 255;
                else
                    pos2 = x;
                end
            end
            if x>pos1 && x<pos2
                d1 = abs(x-pos1);
                d2 = abs(x-pos2);
                if d1<=d2
                    pos1 = x;
                else
                    pos2 = x;
                end
            end
            hold(UI_AXES,"on")
            
            punto1 = plot(UI_AXES,pos1,0.000001,'v','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','none',HitTest='off');
            punto2 = plot(UI_AXES,pos2,0.000001,'v','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','none',HitTest='off');
        end
        %%
        % function [lines] = get_lines(~,x,y,ancho,altura,UI_AXES)
        %     x = round(x);y=round(y);
        %     if x > ancho
        %         x = ancho;
        %     elseif x<1
        %         x = 1;
        %     end
        %     if y > altura
        %         y = altura;
        %     elseif y<1
        %         y = 1;
        %     end
        %     %%
        %     lineX = xline(UI_AXES, x,'Color','y','linewidth',1);
        %     lineY = yline(UI_AXES, y,'Color','y','linewidth',1);
        %     lines = [lineX, lineY];
        % end

        %% 
        function [main_matrix, altura, ancho, color_tipo,minimo, maximo, tiff_pages] = get_image_params(app,directorio,tif_index)
            tiff_pages = 0;
            [~,name,ext] = fileparts(directorio);
            image_name = [char(name) char(ext)];
            if  contains(image_name,'.dcm','IgnoreCase',true) || app.dcm_true
                metadatos = dicominfo(directorio,"UseDictionaryVR",true);
                main_matrix = dicomread(metadatos.Filename);
                main_matrix =  uint8(255 * mat2gray(main_matrix));
                maximo = max(max(main_matrix));
                minimo = min(min(main_matrix));
            else
                if contains(image_name, '.tif','IgnoreCase',true)
                    metadatos =  imfinfo(directorio);
                    tiff_pages=length(metadatos);
                    metadatos =  metadatos(tif_index);
                    main_matrix =  imread(directorio,tif_index);
                    maximo = max(max(main_matrix));
                    minimo = min(min(main_matrix));
                else
                    % imagenes a color o BN jpg pnh y demás
                    metadatos =  imfinfo(directorio);
                    main_matrix = imread(metadatos.Filename);
                    maximo = max(max(main_matrix));
                    minimo = min(min(main_matrix));
                end

            end
            app.UITable.Data = {};
            tabla = struct2table(metadatos,"AsArray",true);
            % [tabla.Properties.VariableNames', table2cell(tabla)']
            tabla_data = [tabla.Properties.VariableNames', table2cell(tabla)'];
            %T = struct2cell(metadatos)
            %tabla_data = cell2table(T)
            app.UITable.Data = table(tabla_data);
            main_matrix = uint8(main_matrix);
            ancho = double(metadatos.Width);
            altura = double(metadatos.Height);
            color_tipo = metadatos.ColorType;
            
            
        end
        %%
        function [main_fig,histog] = make_fig(app,matrix,ancho,altura,color_tipo,rgb_index,hist_on_off,UI_AXES)
            UI_AXES.XLim=[1,ancho];
            UI_AXES.YLim=[1,altura];
            fcolor = 'm';
            color_tipo_m = color_tipo;
            
            if contains(color_tipo,'truecolor')
                %% habilitamos la selección de color 
                app.ColorDropDown.Enable = "on";
                
                %%
                if rgb_index ~= 0
                    app.RangodinmicoSlider.Enable = "on";
                    if rgb_index == 1
                        matrix = matrix(:,:,1);
                        fcolor = 'r';
                    end
                    if rgb_index == 2
                        matrix = matrix(:,:,2);
                        fcolor = 'g';
                    end
                    if rgb_index == 3
                        matrix = matrix(:,:,3);
                        fcolor = 'b';
                    end
                    if rgb_index == 4
                        matrix = rgb2gray(matrix);
                        fcolor = 'c';
                    end
                    color_tipo_m = 'monoRGB';
                else
                    app.RangodinmicoSlider.Enable = "off";
                end
            else
                %% deshabilitamos la selección de color 
                app.RangodinmicoSlider.Enable = "on";
                app.ColorDropDown.Enable = "off";
                
                %%
            end
            
            hold(UI_AXES,"on")
            main_fig = imagesc(UI_AXES,matrix,"HitTest","off",[app.pt1 app.pt2]);colormap(UI_AXES,"gray");

            if hist_on_off == 1
                histog   = histograma_fig(app, matrix, altura, ancho, color_tipo_m,fcolor,UI_AXES);
            else
                histog   = [];
            end
            UI_AXES.PlotBoxAspectRatio = [ancho/altura, 1, 1];
            UI_AXES.YDir = 'reverse';

        end

        function [histog_fig] = make_new_fig(app,matrix,UI_AXES)
            [app.main_fig,histog_fig] =make_fig(app,matrix,app.ancho,app.altura,app.color_tipo,app.rgb_index,app.hist_on_off,UI_AXES);
            if app.tiff_pages > 0
                app.PginaTIFFDropDown.Enable = "on";
                tiif_items = string.empty(0,app.tiff_pages);
                for i = 1:app.tiff_pages
                    tiif_items(i) = "Imag.  " + string(i);
                end
                app.PginaTIFFDropDown.Items = tiif_items;
                app.PginaTIFFDropDown.ItemsData = 1:1:app.tiff_pages;
            else
                app.PginaTIFFDropDown.Enable = "off";
                app.tiff_index = 1;
            end
            
            % lines_main = get_lines(app,round(app.ancho/2),round(app.altura/2),app.ancho,app.altura,UI_AXES);
        end


    
        function [xdir, ydir, magnitud, direccion] = gradient_var(app,grad_index)
            % grad_index 2-5
            metodo = char(app.gradiente_metodo(grad_index));
            xdir      = zeros(size(app.main_matrix));
            ydir      = zeros(size(app.main_matrix));
            magnitud  = zeros(size(app.main_matrix));
            direccion = zeros(size(app.main_matrix));
            if contains(app.color_tipo,'truecolor')
                for n = 1:3
                    [xdir(:,:,n), ydir(:,:,n)] = imgradientxy(app.main_matrix(:,:,n),metodo);
                    [magnitud(:,:,n),direccion(:,:,n)] = imgradient(app.main_matrix(:,:,n),metodo);
                end
            else
                [xdir, ydir] = imgradientxy(app.main_matrix,metodo);
                [magnitud,direccion] = imgradient(app.main_matrix,metodo);
            end
            xdir = uint8(xdir);
            ydir = uint8(ydir);
            magnitud = uint8(magnitud);
            direccion = uint8(direccion);

        end


        %%
        

        function img = filt_rect(~,lado1,lado2,centro1,centro2,tamano,invertir)
            centro1 = round(centro1);
            centro2 = round(centro2);
            img = zeros(tamano);
            x1 = max(1,centro1-lado1/2);
            x2 = min(tamano(1),centro1+lado1/2-1);
            y1 = max(1,centro2-lado2/2);
            y2 = min(tamano(2),centro2+lado2/2-1);
            img(x1:x2,y1:y2) = 1;
            if invertir == 0
               img = img == 0;
            else
               img = img == 1;
            end
        end
        
        function img = filt_circ(~,radio,centro1,centro2,tamano,invertir)
            img = zeros(tamano);
            centro1 = round(centro1);
            centro2 = round(centro2);
            [y,x] = meshgrid(1:tamano(2),1:tamano(1));
            img(sqrt((x-centro1).^2+(y-centro2).^2)<=radio) = 1;
            if invertir == 0
               img = img == 0;
            else
               img = img == 1;
            end
        end
        %%




        function [] = reset_realce_mejoramiento(app)
            app.BrilloSlider.Value = 0;
            app.ContrasteSlider.Value = 0;
            app.GammaSlider.Value = 1;
            app.brillo = 0;
            app.contraste = 0;
            app.gamma = 1;
        end


        function [] = reset_gradient(app)
            app.GradienteDropDown.Value = 1;
            app.ButtonGroup.Enable = "off";
        end
        
        
        
        
        function segment_mask = segmentacion_mascara(~,matrix,minimo,maximo,rgb_index,color_tipo,invertir)
            if contains(color_tipo,'truecolor')
                if rgb_index == 0
                    segment_mask = zeros(size(matrix),'logical');
                    for n = 1:3
                        
                        segment_mask(:,:,n) = roicolor(matrix(:,:,n),minimo,maximo);
                    end
                end
                if rgb_index == 1
                    segment_mask = roicolor(matrix(:,:,1),minimo,maximo);
                end
                if rgb_index == 2
                    segment_mask = roicolor(matrix(:,:,2),minimo,maximo);
                end
                if rgb_index == 3
                    segment_mask = roicolor(matrix(:,:,3),minimo,maximo);
                end
                if rgb_index == 4
                    matrix = rgb2gray(matrix);
                    segment_mask = roicolor(matrix,minimo,maximo);
                end
            else
                segment_mask = roicolor(matrix,minimo,maximo);
            end
            if invertir == 1
                segment_mask = not(segment_mask);
            end
        end


    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            movegui(app.PositroniumdotMATMdulo1UIFigure,'center')
            app.GradienteDropDown.Items = app.gradiente_metodo;
            app.FiltroslinealesynolinealesDropDown.Items = app.filtros;
            app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            app.TransponerCheckBox.Enable = "on";
        end

        % Button pushed function: SeleccionarcarpetaButton
        function SeleccionarcarpetaButtonPushed(app, event)
            folderTemp = uigetdir;
            if folderTemp ~= 0
                app.folder = folderTemp;
                updateTree(app);
                collapse(app.Tree,'all')
                node = app.SeleccioneNode;
                node.Children.delete;
                %% uitreenode(node,'Text','','NodeData','Dummy');
                pathToMLAPP = fileparts(mfilename('fullpath'));
                uitreenode(node,'Text','','NodeData','Dummy','Icon',fullfile(pathToMLAPP,'ico','waiting.gif'));
            end
            figure(app.PositroniumdotMATMdulo1UIFigure)
        end

        % Node expanded function: Tree
        function TreeNodeExpanded(app, event)
            if isempty(app.folder)
                collapse(event.Node)
                uialert(app.PositroniumdotMATMdulo1UIFigure,"Seleccione un directorio primero.","Error");
                return
            end
            node = event.Node;
            if isa(node.Parent,'matlab.ui.container.Tree')
                folderContent = dir(fullfile(node.Text));
                setNodes(app,node,folderContent);
            else
                folderContent = dir(fullfile(node.NodeData));
                setNodes(app,node,folderContent);
            end
            expand(node)
        end

        % Node collapsed function: Tree
        function TreeNodeCollapsed(app, event)
            if isempty(app.folder)
                return
            end
            node = event.Node;
            collapse(node)
            node.Children.delete;
            %%uitreenode(node,'Text','','NodeData','Dummy');
            pathToMLAPP = fileparts(mfilename('fullpath'));
            uitreenode(node,'Text','','NodeData','Dummy','Icon',fullfile(pathToMLAPP,'ico','waiting.gif'))
        end

        % Clicked callback: Tree
        function TreeClicked(app, event)
            app.img_true = false;
            app.dcm_true = false;
            app.fspecial_filtro = ones(5,5);
            if isempty(app.folder)
                return
            end
            node = event.InteractionInformation.Node;
            if isempty(node)
                return
            end
            if isa(node.Parent,'matlab.ui.container.Tree')
                app.dir_select =  node.Text;
            else
                app.dir_select =  node.NodeData;
            end
            %% verificamos si app.dir_select es un directorio o un archivo
            if ~isfolder(app.dir_select)
                [~,~,ext] = fileparts(app.dir_select);
                if (ext == "")
                    app.output = "[!] Es un archivo sin extension." + newline + app.output;
                    app.outputTextArea.Value = app.output;
                    % verificamos si es un archivo DICOM
                    try
                        app.output = "[!] Imagen DICOM detectada." + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        dicomread(app.dir_select);
                        % Continúa con el procesamiento de la imagen...
                        app.dcm_true = true;
                    catch ME
                        error_lectura = ['Error al leer el archivo: ' ME.message];
                        app.output = "[x] " + string(error_lectura) + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        % Maneja el error según tus necesidades.
                        app.dcm_true = false;
                    end
                else
                    if any(strcmpi(ext,app.formatos))
                        app.output = "[!] Imagen detectada." + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        app.img_true = true;
                    else
                        app.output = "[X] Archivo no compatible" + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        app.img_true = false;
                    end
                end
            end
            %%
            if app.img_true || app.dcm_true
                    app.AplicarButton.Visible = "on";
                    app.AplicarfiltroButton.Enable="on";
                    app.GradienteDropDown.Enable = "on";
                    app.GuadarButton.Enable = "on";
                    app.MostrarhistCheckBox.Enable ="on";
                    app.BrilloSlider.Enable="on";
                    app.ContrasteSlider.Enable ="on";
                    app.GammaSlider.Enable = "on";
                    app.AplicarSegButton.Enable = "on";
                    app.MnimoEditField.Enable = "on";
                    app.MximoEditField.Enable = "on";

                    delete(app.main_fig)
                    delete([app.lines_main,app.lines_mod])
                    [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.dir_select,app.tiff_index);
                    app.mod_matrix = app.main_matrix;
                    [app.histog_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
                    [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
                    %%
                    app.seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
                    delete(app.filtro_fig)
                    app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
                    %%
                    app.Px = app.ancho/2; app.Py = app.altura/2;
                    reset_gradient(app);
                    reset_realce_mejoramiento(app);
            else
                    app.AplicarButton.Visible = "off";
                    app.AplicarfiltroButton.Enable="off";
                    app.GradienteDropDown.Enable = "off";
                    app.GuadarButton.Enable = "off";
                    app.MostrarhistCheckBox.Enable ="off";
                    app.BrilloSlider.Enable="off";
                    app.ContrasteSlider.Enable ="off";
                    app.GammaSlider.Enable = "off";
                    app.AplicarSegButton.Enable = "off";
                    app.MnimoEditField.Enable = "off";
                    app.MximoEditField.Enable = "off";
            end
        end

        % Selection changed function: Tree
        function TreeSelectionChanged(app, event)
            %selectedNodes = app.Tree.SelectedNodes;
            app.img_true = false;
            app.dcm_true = false;
            app.fspecial_filtro = ones(5,5);
            
            if isempty(app.folder)
                return
            end
            node = app.Tree.SelectedNodes;
            if isempty(node)
                return
            end
            if isa(node.Parent,'matlab.ui.container.Tree')
                app.dir_select =  node.Text;
            else
                app.dir_select =  node.NodeData;
            end
            %% verificamos si app.dir_select es un directorio o un archivo
            if ~isfolder(app.dir_select)
                [~,~,ext] = fileparts(app.dir_select);
                if (ext == "")
                    app.output = "[!] Es un archivo sin extension." + newline + app.output;
                    app.outputTextArea.Value = app.output;
                    % verificamos si es un archivo DICOM
                    try
                        dicomread(app.dir_select);
                        % Continúa con el procesamiento de la imagen...
                        app.output = "[!] Imagen DICOM detectada." + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        app.dcm_true = true;
                    catch ME
                        error_lectura = ['Error al leer el archivo: ' ME.message];
                        app.output = "[x] " + string(error_lectura) + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        % Maneja el error según tus necesidades.
                        app.dcm_true = false;
                    end
                else
                    if any(strcmpi(ext,app.formatos))
                        app.output = "[!] Imagen detectada." + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        app.img_true = true;
                    else
                        app.output = "[X] Archivo no compatible" + newline + app.output;
                        app.outputTextArea.Value = app.output;
                        app.img_true = false;
                    end
                end
            end
            %%
            if app.img_true || app.dcm_true
                    app.AplicarButton.Visible = "on";
                    app.AplicarfiltroButton.Enable="on";
                    app.GradienteDropDown.Enable = "on";
                    app.GuadarButton.Enable = "on";
                    app.MostrarhistCheckBox.Enable ="on";
                    app.BrilloSlider.Enable="on";
                    app.ContrasteSlider.Enable ="on";
                    app.GammaSlider.Enable = "on";
                    app.AplicarSegButton.Enable = "on";
                    app.MnimoEditField.Enable = "on";
                    app.MximoEditField.Enable = "on";
                    app.InvertirCheckBox_2.Enable = "on";
                    app.RadiomorfEditField.Enable = "on";
                    app.OpmofolgicaDropDown.Enable = "on";
                    app.DilatarButton.Enable = "on";
                    app.ErosionarButton.Enable ="on";

                    delete(app.main_fig)
                    delete([app.lines_main,app.lines_mod])
                    [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.dir_select,app.tiff_index);
                    app.mod_matrix = app.main_matrix;
                    [app.histog_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
                    [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
                    %%
                    app.seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
                    delete(app.filtro_fig)
                    app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
                    %%
                    app.Px = app.ancho/2; app.Py = app.altura/2;
                    reset_gradient(app);
                    reset_realce_mejoramiento(app);
            else
                    app.AplicarButton.Visible = "off";
                    app.AplicarfiltroButton.Enable="off";
                    app.GradienteDropDown.Enable = "off";
                    app.GuadarButton.Enable = "off";
                    app.MostrarhistCheckBox.Enable ="off";
                    app.BrilloSlider.Enable="off";
                    app.ContrasteSlider.Enable ="off";
                    app.GammaSlider.Enable = "off";
                    app.AplicarSegButton.Enable = "off";
                    app.MnimoEditField.Enable = "off";
                    app.MximoEditField.Enable = "off";
                    app.InvertirCheckBox_2.Enable = "off";
                    app.RadiomorfEditField.Enable = "off";
                    app.OpmofolgicaDropDown.Enable = "off";
                    app.DilatarButton.Enable = "off";
                    app.ErosionarButton.Enable ="off";
            end
        end

        % Value changed function: BrilloSlider
        function BrilloSliderValueChanged(app, event)
            app.brillo = app.BrilloSlider.Value;
            app.mod_matrix = (1+app.contraste)*imadjust(app.main_matrix,[0;1],[0;1],app.gamma)+app.brillo;
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            %%
            reset_gradient(app);
        end

        % Value changed function: ContrasteSlider
        function ContrasteSliderValueChanged(app, event)
            app.contraste = app.ContrasteSlider.Value/100;
            app.mod_matrix = (1+app.contraste)*imadjust(app.main_matrix,[0;1],[0;1],app.gamma)+app.brillo;
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            %%
            reset_gradient(app);
            
        end

        % Value changed function: GammaSlider
        function GammaSliderValueChanged(app, event)
            app.gamma = app.GammaSlider.Value;
            app.mod_matrix = (1+app.contraste)*imadjust(app.main_matrix,[0;1],[0;1],app.gamma)+app.brillo;
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            %%
            reset_gradient(app);
        end

        % Value changed function: RangodinmicoSlider
        function RangodinmicoSliderValueChanged(app, event)
             app.RangodinmicoSlider.Value = round(app.RangodinmicoSlider.Value);
             val = app.RangodinmicoSlider.Value;
             app.pt1 = val(1);
             app.pt2 = val(2);
             [app.histog_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
             [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
             drawnow nocallbacks
        end

        % Button down function: UIAxes2
        function UIAxes2ButtonDown(app, event)
              % P = get(app.UIAxes2,'CurrentPoint'); 
              % delete([app.lines_main,app.lines_mod])
              % app.Px = P(1,1); app.Py = P(1,2);
              % app.lines_main = get_lines(app,app.Px,app.Py,app.ancho,app.altura,app.UIAxes);
              % app.lines_mod = get_lines(app,app.Px,app.Py,app.ancho,app.altura,app.UIAxes2);
              %%
        end

        % Value changed function: ColorDropDown
        function ColorDropDownValueChanged(app, event)
            app.rgb_index = app.ColorDropDown.Value;
           delete([app.lines_main,app.lines_mod])
            [app.histog_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);

            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.Px = app.ancho/2; app.Py = app.altura/2;
            
        end

        % Button pushed function: AplicarSegButton
        function AplicarSegButtonPushed(app, event)
            app.seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            app.mod_matrix = uint8(app.seg_mask).*app.main_matrix;
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);
            %%
            
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
        end

        % Value changed function: MnimoEditField
        function MnimoEditFieldValueChanged(app, event)
            app.seg_min = app.MnimoEditField.Value;
            app.seg_invertir = app.InvertirCheckBox_2.Value;
            app.seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
        end

        % Value changed function: MximoEditField
        function MximoEditFieldValueChanged(app, event)
            app.seg_max = app.MximoEditField.Value;
            app.seg_invertir = app.InvertirCheckBox_2.Value;
            app.seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
            
        end

        % Value changed function: InvertirCheckBox_2
        function InvertirCheckBox_2ValueChanged(app, event)
            app.seg_invertir = app.InvertirCheckBox_2.Value;
            app.seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
        end

        % Button pushed function: DilatarButton
        function DilatarButtonPushed(app, event)
            estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
            app.seg_mask = imdilate(app.seg_mask,estruc);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);

            app.mod_matrix = uint8(app.seg_mask).*app.main_matrix;
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);
            %%
            
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
        end

        % Button pushed function: ErosionarButton
        function ErosionarButtonPushed(app, event)
            estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
            app.seg_mask = imerode(app.seg_mask,estruc);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
            app.mod_matrix = uint8(app.seg_mask).*app.main_matrix;
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);
            %%
            
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(app.seg_mask), 'Parent', app.UIAxes5);
        end

        % Value changed function: MostrarhistCheckBox
        function MostrarhistCheckBoxValueChanged(app, event)
            app.hist_on_off = app.MostrarhistCheckBox.Value;
            delete([app.lines_main,app.lines_mod])
            [app.histog_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
        end

        % Value changed function: GradienteDropDown
        function GradienteDropDownValueChanged(app, event)
            value = app.GradienteDropDown.Value;
            if value == 1 || value == 6
                app.ButtonGroup.Enable = "off";
                app.mod_matrix = app.main_matrix;
                app.GradienteDropDown.Value = 1;
            else
                app.ButtonGroup.Enable = "on";
                 [xdir, ydir, magnitud, direccion] = gradient_var(app,value);
                 selectedButton = app.ButtonGroup.SelectedObject;
                 if contains(selectedButton.Text,'XDir')
                     app.mod_matrix = xdir;
                 end
                 if contains(selectedButton.Text,'YDir')
                     app.mod_matrix = ydir;
                 end
                 if contains(selectedButton.Text,'Magnitud')
                     app.mod_matrix = magnitud;
                 end
                 if contains(selectedButton.Text,'Dirección')
                     app.mod_matrix = direccion;
                 end

            end

            %%
            [app.histog_fig_mod,]=make_new_fig(app,app.mod_matrix,app.UIAxes2);            
            reset_realce_mejoramiento(app);
            
        end

        % Selection changed function: ButtonGroup
        function ButtonGroupSelectionChanged(app, event)
            [xdir, ydir, magnitud, direccion] = gradient_var(app,app.GradienteDropDown.Value);
             selectedButton = app.ButtonGroup.SelectedObject;
             if contains(selectedButton.Text,'XDir')
                 app.mod_matrix = xdir;
             end
             if contains(selectedButton.Text,'YDir')
                 app.mod_matrix = ydir;
             end
             if contains(selectedButton.Text,'Magnitud')
                 app.mod_matrix = magnitud;
             end
             if contains(selectedButton.Text,'Dirección')
                 app.mod_matrix = direccion;
             end
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            reset_realce_mejoramiento(app);
            
        end

        % Value changed function: FiltroslinealesynolinealesDropDown
        function FiltroslinealesynolinealesDropDownValueChanged(app, event)
            value = app.FiltroslinealesynolinealesDropDown.Value;
            app.TransponerCheckBox.Value = 0;
            app.TransponerCheckBox.Enable = "on";
            if value == 1
                app.Param1EditField.Enable = "off";
                app.Param2EditField.Enable = "off";
                app.Param1EditFieldLabel.Text = "Param1";
                app.Param2EditFieldLabel.Text = "Param2";
                app.Param1EditField.Value = 0;
                app.Param2EditField.Value = 0;
                delete(app.filtro_fig)
                app.fspecial_filtro = randi([-5,5],5,5);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 2
                app.Param1EditField.Enable = "on"; 
                app.Param2EditField.Enable = "off";
                app.Param1EditFieldLabel.Text = "Tam.";
                app.Param2EditFieldLabel.Text = "Param2";
                app.Param1EditField.Value = 5;
                app.Param2EditField.Value = 0;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(2)),5);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 3
                app.Param1EditField.Enable = "on"; 
                app.Param2EditField.Enable = "off";
                app.Param1EditFieldLabel.Text = "Radio";
                app.Param2EditFieldLabel.Text = "Param2";
                app.Param1EditField.Value = 5;
                app.Param2EditField.Value = 0;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(3)),5);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 4
                app.Param1EditField.Enable = "on"; 
                app.Param2EditField.Enable = "on";
                app.Param1EditFieldLabel.Text = "Tam.";
                app.Param2EditFieldLabel.Text = "sigma";
                app.Param1EditField.Value = 5;
                app.Param2EditField.Value = 0.5;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(4)),5,0.5);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 5
                app.Param1EditField.Enable = "on"; 
                app.Param2EditField.Enable = "off";
                app.Param1EditFieldLabel.Text = "alpha";
                app.Param2EditFieldLabel.Text = "PAram2";
                app.Param1EditField.Value = 0.5;
                app.Param2EditField.Value = 0;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(5)),0.5);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 6
                app.Param1EditField.Enable = "on"; 
                app.Param2EditField.Enable = "on";
                app.Param1EditFieldLabel.Text = "Tam.";
                app.Param2EditFieldLabel.Text = "sigma";
                app.Param1EditField.Value = 5;
                app.Param2EditField.Value = 0.5;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(6)),5,0.5);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 7
                app.Param1EditField.Enable = "on"; 
                app.Param2EditField.Enable = "on";
                app.Param1EditFieldLabel.Text = "len";
                app.Param2EditFieldLabel.Text = "theta";
                app.Param1EditField.Value = 20;
                app.Param2EditField.Value = 45;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(7)),20,45);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 8
                app.Param1EditField.Enable = "off"; 
                app.Param2EditField.Enable = "off";
                app.Param1EditFieldLabel.Text = "Param1";
                app.Param2EditFieldLabel.Text = "PAram2";
                app.Param1EditField.Value = 0;
                app.Param2EditField.Value = 0;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(8)));
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 9
                app.Param1EditField.Enable = "off"; 
                app.Param2EditField.Enable = "off";
                app.Param1EditFieldLabel.Text = "Param1";
                app.Param2EditFieldLabel.Text = "PAram2";
                app.Param1EditField.Value = 0;
                app.Param2EditField.Value = 0;
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(9)));
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if value == 10 || value == 11 || value == 12 
                app.TransponerCheckBox.Enable = "off";
                app.Param1EditField.Enable = "on"; 
                app.Param2EditField.Enable = "off";
                app.Param1EditFieldLabel.Text = "Tam";
                app.Param2EditFieldLabel.Text = "PAram2";
                app.Param1EditField.Value = 5;
                app.Param2EditField.Value = 0;
                delete(app.filtro_fig)
                app.fspecial_filtro = zeros(3,3);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = gray);
            end
        end

        % Value changed function: Param1EditField
        function Param1EditFieldValueChanged(app, event)
           app.TransponerCheckBox.Value = 0;
            value = app.Param1EditField.Value;
            
            if app.FiltroslinealesynolinealesDropDown.Value == 2
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(2)),value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 3

                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(3)),value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 4
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(4)),value,app.Param2EditField.Value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 5
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(5)),value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 6

                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(6)),value,app.Param2EditField.Value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 7
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(7)),value,app.Param2EditField.Value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end 
            
        end

        % Value changed function: Param2EditField
        function Param2EditFieldValueChanged(app, event)
            app.TransponerCheckBox.Value = 0;
            value = app.Param2EditField.Value;

            if app.FiltroslinealesynolinealesDropDown.Value == 4
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(4)),app.Param1EditField.Value,value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            
            if app.FiltroslinealesynolinealesDropDown.Value == 6

                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(6)),app.Param1EditField.Value,value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 7
   
                delete(app.filtro_fig)
                app.fspecial_filtro = fspecial(char(app.filtros(7)),app.Param1EditField.Value,value);
                app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            end 
        end

        % Value changed function: TransponerCheckBox
        function TransponerCheckBoxValueChanged(app, event)
             delete(app.filtro_fig)
             app.fspecial_filtro=transpose(app.fspecial_filtro);
             app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
        end

        % Button pushed function: AplicarfiltroButton
        function AplicarfiltroButtonPushed(app, event)
            if app.FiltroslinealesynolinealesDropDown.Value <= 9 && app.FiltroslinealesynolinealesDropDown.Value >= 1
                app.mod_matrix = imfilter(app.main_matrix,app.fspecial_filtro,'replicate');
            end
            
            if app.FiltroslinealesynolinealesDropDown.Value == 10
                min_max_median_filters(app,1)
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 11
                min_max_median_filters(app,2)
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 12
                min_max_median_filters(app,3)
            end
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);

        end

        % Button pushed function: AplicarButton
        function AplicarButtonPushed(app, event)
            app.output = "[OK] Se han aplicado los cambios." + newline + app.output;
            app.outputTextArea.Value = app.output;
            
            app.main_matrix = app.mod_matrix;

            delete([app.lines_main,app.lines_mod])
            [app.histog_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.histog_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);

           
            app.Px = app.ancho/2; app.Py = app.altura/2;

            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);

            %%
        end

        % Button pushed function: GuadarButton
        function GuadarButtonPushed(app, event)
            app.output = "[...] Intentando guardar imagen"+newline+app.output;
            app.GuadarButton.Enable = "off";
            app.outputTextArea.Value =  app.output; drawnow limitrate
            directorio_guardado = uigetdir(userpath);
            
            if directorio_guardado == 0
                app.output = "[X] Guardado cancelado"+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
            else 
                [~,name,~] = fileparts(app.dir_select);
                file_name = char(name);
                new_imag_dir = fullfile(directorio_guardado,[file_name,'_',char(datetime('now','TimeZone','local','Format','d_MMM_y_HH_mm_ss_ms')),'.png']);
                if contains(app.color_tipo,'truecolor')
                    if app.rgb_index == 0
                        imwrite(app.mod_matrix, new_imag_dir);
                    end
                    if app.rgb_index == 1
                        imwrite(app.mod_matrix(:,:,1), new_imag_dir);
                    end
                    if app.rgb_index == 2
                        imwrite(app.mod_matrix(:,:,2), new_imag_dir);
                    end
                    if app.rgb_index == 3
                        imwrite(app.mod_matrix(:,:,3), new_imag_dir);
                    end
                    if app.rgb_index == 4
                        imwrite(rgb2gray(app.mod_matrix), new_imag_dir);
                    end
                else
                    imwrite(app.mod_matrix, new_imag_dir);
                end
                app.output = "[OK] Imagen guardada como: " + convertCharsToStrings(new_imag_dir) + newline + app.output;
            end
            %%
            
            

            
            app.outputTextArea.Value = app.output;
            app.GuadarButton.Enable = "on";
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create PositroniumdotMATMdulo1UIFigure and hide until all components are created
            app.PositroniumdotMATMdulo1UIFigure = uifigure('Visible', 'off');
            app.PositroniumdotMATMdulo1UIFigure.Position = [100 100 1349 718];
            app.PositroniumdotMATMdulo1UIFigure.Name = 'Positronium dot MAT - Módulo 1';
            app.PositroniumdotMATMdulo1UIFigure.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.PositroniumdotMATMdulo1UIFigure);
            title(app.UIAxes2, 'Imagen modificada')
            xlabel(app.UIAxes2, 'Píxeles X')
            ylabel(app.UIAxes2, 'Píxeles Y')
            app.UIAxes2.Toolbar.Visible = 'off';
            app.UIAxes2.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes2.YDir = 'reverse';
            app.UIAxes2.XTick = [];
            app.UIAxes2.XTickLabel = '';
            app.UIAxes2.YTick = [];
            app.UIAxes2.ButtonDownFcn = createCallbackFcn(app, @UIAxes2ButtonDown, true);
            app.UIAxes2.Position = [399 224 561 479];

            % Create UIAxes
            app.UIAxes = uiaxes(app.PositroniumdotMATMdulo1UIFigure);
            title(app.UIAxes, 'Imagen original')
            xlabel(app.UIAxes, 'Píxeles X')
            ylabel(app.UIAxes, 'Píxeles Y')
            app.UIAxes.Toolbar.Visible = 'off';
            app.UIAxes.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes.XTick = [];
            app.UIAxes.XTickLabel = '';
            app.UIAxes.YTick = [];
            app.UIAxes.Position = [960 439 377 265];

            % Create UIAxes5
            app.UIAxes5 = uiaxes(app.PositroniumdotMATMdulo1UIFigure);
            title(app.UIAxes5, 'Filtro')
            zlabel(app.UIAxes5, 'Z')
            app.UIAxes5.Toolbar.Visible = 'off';
            app.UIAxes5.DataAspectRatio = [2 1 1];
            app.UIAxes5.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes5.XTick = [];
            app.UIAxes5.YTick = [];
            app.UIAxes5.Position = [295 248 119 106];

            % Create Tree
            app.Tree = uitree(app.PositroniumdotMATMdulo1UIFigure);
            app.Tree.SelectionChangedFcn = createCallbackFcn(app, @TreeSelectionChanged, true);
            app.Tree.NodeExpandedFcn = createCallbackFcn(app, @TreeNodeExpanded, true);
            app.Tree.NodeCollapsedFcn = createCallbackFcn(app, @TreeNodeCollapsed, true);
            app.Tree.FontSize = 10;
            app.Tree.ClickedFcn = createCallbackFcn(app, @TreeClicked, true);
            app.Tree.Position = [11 248 286 425];

            % Create SeleccioneNode
            app.SeleccioneNode = uitreenode(app.Tree);
            app.SeleccioneNode.Text = 'Seleccione';

            % Create Node
            app.Node = uitreenode(app.SeleccioneNode);
            app.Node.NodeData = 'Dummy';
            app.Node.Text = '';

            % Create SeleccionarcarpetaButton
            app.SeleccionarcarpetaButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.SeleccionarcarpetaButton.ButtonPushedFcn = createCallbackFcn(app, @SeleccionarcarpetaButtonPushed, true);
            app.SeleccionarcarpetaButton.Position = [12 682 157 23];
            app.SeleccionarcarpetaButton.Text = 'Seleccionar carpeta';

            % Create RealceymejoramientoLabel
            app.RealceymejoramientoLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.RealceymejoramientoLabel.Position = [387 192 128 22];
            app.RealceymejoramientoLabel.Text = 'Realce y mejoramiento';

            % Create ParamsfiltrosLabel
            app.ParamsfiltrosLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.ParamsfiltrosLabel.Position = [579 61 82 22];
            app.ParamsfiltrosLabel.Text = 'Params. filtros';

            % Create AplicarfiltroButton
            app.AplicarfiltroButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.AplicarfiltroButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarfiltroButtonPushed, true);
            app.AplicarfiltroButton.Enable = 'off';
            app.AplicarfiltroButton.Position = [655 11 100 23];
            app.AplicarfiltroButton.Text = 'Aplicar filtro';

            % Create TransponerCheckBox
            app.TransponerCheckBox = uicheckbox(app.PositroniumdotMATMdulo1UIFigure);
            app.TransponerCheckBox.ValueChangedFcn = createCallbackFcn(app, @TransponerCheckBoxValueChanged, true);
            app.TransponerCheckBox.Enable = 'off';
            app.TransponerCheckBox.Text = 'Transponer';
            app.TransponerCheckBox.Position = [572 12 83 22];

            % Create SegmentacinporhistogramaLabel
            app.SegmentacinporhistogramaLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.SegmentacinporhistogramaLabel.Position = [573 192 165 22];
            app.SegmentacinporhistogramaLabel.Text = 'Segmentación por histograma';

            % Create AplicarSegButton
            app.AplicarSegButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.AplicarSegButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarSegButtonPushed, true);
            app.AplicarSegButton.Enable = 'off';
            app.AplicarSegButton.Position = [660 133 99 23];
            app.AplicarSegButton.Text = 'Aplicar Seg.';

            % Create InvertirCheckBox_2
            app.InvertirCheckBox_2 = uicheckbox(app.PositroniumdotMATMdulo1UIFigure);
            app.InvertirCheckBox_2.ValueChangedFcn = createCallbackFcn(app, @InvertirCheckBox_2ValueChanged, true);
            app.InvertirCheckBox_2.Enable = 'off';
            app.InvertirCheckBox_2.Text = 'Invertir';
            app.InvertirCheckBox_2.Position = [575 134 59 22];

            % Create MostrarhistCheckBox
            app.MostrarhistCheckBox = uicheckbox(app.PositroniumdotMATMdulo1UIFigure);
            app.MostrarhistCheckBox.ValueChangedFcn = createCallbackFcn(app, @MostrarhistCheckBoxValueChanged, true);
            app.MostrarhistCheckBox.Enable = 'off';
            app.MostrarhistCheckBox.Text = 'Mostrar hist';
            app.MostrarhistCheckBox.Position = [14 173 85 22];
            app.MostrarhistCheckBox.Value = true;

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.PositroniumdotMATMdulo1UIFigure);
            app.ButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupSelectionChanged, true);
            app.ButtonGroup.Enable = 'off';
            app.ButtonGroup.Position = [775 115 171 104];

            % Create XDirButton
            app.XDirButton = uiradiobutton(app.ButtonGroup);
            app.XDirButton.Text = 'XDir';
            app.XDirButton.Position = [10 36 58 22];
            app.XDirButton.Value = true;

            % Create YDirButton
            app.YDirButton = uiradiobutton(app.ButtonGroup);
            app.YDirButton.Text = 'YDir';
            app.YDirButton.Position = [92 36 65 22];

            % Create MagnitudButton
            app.MagnitudButton = uiradiobutton(app.ButtonGroup);
            app.MagnitudButton.Text = 'Magnitud';
            app.MagnitudButton.Position = [10 9 71 22];

            % Create DireccinButton
            app.DireccinButton = uiradiobutton(app.ButtonGroup);
            app.DireccinButton.Text = 'Dirección';
            app.DireccinButton.Position = [91 8 72 22];

            % Create GuadarButton
            app.GuadarButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.GuadarButton.ButtonPushedFcn = createCallbackFcn(app, @GuadarButtonPushed, true);
            app.GuadarButton.Icon = fullfile(pathToMLAPP, 'ico', 'save.png');
            app.GuadarButton.Enable = 'off';
            app.GuadarButton.Position = [198 172 75 24];
            app.GuadarButton.Text = 'Guadar';

            % Create AplicarButton
            app.AplicarButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.AplicarButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarButtonPushed, true);
            app.AplicarButton.Icon = fullfile(pathToMLAPP, 'ico', 'aplicar.png');
            app.AplicarButton.Visible = 'off';
            app.AplicarButton.Position = [116 171 76 25];
            app.AplicarButton.Text = 'Aplicar';

            % Create CerrarButton
            app.CerrarButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.CerrarButton.Icon = fullfile(pathToMLAPP, 'ico', 'icon_close.png');
            app.CerrarButton.Position = [279 172 77 24];
            app.CerrarButton.Text = 'Cerrar';

            % Create UITable
            app.UITable = uitable(app.PositroniumdotMATMdulo1UIFigure);
            app.UITable.BackgroundColor = [0.502 0.502 0.502;0.149 0.149 0.149];
            app.UITable.ColumnName = {'Propiedad / Descripción'};
            app.UITable.RowName = {};
            app.UITable.ForegroundColor = [0.902 0.902 0.902];
            app.UITable.FontSize = 11;
            app.UITable.Position = [959 4 393 421];

            % Create outputTextArea
            app.outputTextArea = uitextarea(app.PositroniumdotMATMdulo1UIFigure);
            app.outputTextArea.FontColor = [0 1 0];
            app.outputTextArea.BackgroundColor = [0 0 0];
            app.outputTextArea.Position = [11 9 345 153];
            app.outputTextArea.Value = {'Esperando imágenes...'};

            % Create RangodinmicoSliderLabel
            app.RangodinmicoSliderLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.RangodinmicoSliderLabel.HorizontalAlignment = 'right';
            app.RangodinmicoSliderLabel.Position = [308 681 92 22];
            app.RangodinmicoSliderLabel.Text = 'Rango dinámico';

            % Create RangodinmicoSlider
            app.RangodinmicoSlider = uislider(app.PositroniumdotMATMdulo1UIFigure, 'range');
            app.RangodinmicoSlider.Limits = [0 255];
            app.RangodinmicoSlider.Orientation = 'vertical';
            app.RangodinmicoSlider.ValueChangedFcn = createCallbackFcn(app, @RangodinmicoSliderValueChanged, true);
            app.RangodinmicoSlider.Enable = 'off';
            app.RangodinmicoSlider.Position = [338 375 3 297];
            app.RangodinmicoSlider.Value = [0 255];

            % Create BrilloSliderLabel
            app.BrilloSliderLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.BrilloSliderLabel.HorizontalAlignment = 'right';
            app.BrilloSliderLabel.FontSize = 10;
            app.BrilloSliderLabel.Position = [519 171 27 22];
            app.BrilloSliderLabel.Text = 'Brillo';

            % Create BrilloSlider
            app.BrilloSlider = uislider(app.PositroniumdotMATMdulo1UIFigure);
            app.BrilloSlider.Limits = [-100 100];
            app.BrilloSlider.Orientation = 'vertical';
            app.BrilloSlider.ValueChangedFcn = createCallbackFcn(app, @BrilloSliderValueChanged, true);
            app.BrilloSlider.FontSize = 10;
            app.BrilloSlider.Enable = 'off';
            app.BrilloSlider.Position = [514 15 3 152];

            % Create ContrasteSliderLabel
            app.ContrasteSliderLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.ContrasteSliderLabel.HorizontalAlignment = 'right';
            app.ContrasteSliderLabel.FontSize = 10;
            app.ContrasteSliderLabel.Position = [448 171 48 22];
            app.ContrasteSliderLabel.Text = 'Contraste';

            % Create ContrasteSlider
            app.ContrasteSlider = uislider(app.PositroniumdotMATMdulo1UIFigure);
            app.ContrasteSlider.Limits = [-90 100];
            app.ContrasteSlider.Orientation = 'vertical';
            app.ContrasteSlider.ValueChangedFcn = createCallbackFcn(app, @ContrasteSliderValueChanged, true);
            app.ContrasteSlider.FontSize = 10;
            app.ContrasteSlider.Enable = 'off';
            app.ContrasteSlider.Position = [456 17 3 150];

            % Create GammaSliderLabel
            app.GammaSliderLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.GammaSliderLabel.HorizontalAlignment = 'right';
            app.GammaSliderLabel.FontSize = 10;
            app.GammaSliderLabel.Position = [384 171 41 22];
            app.GammaSliderLabel.Text = 'Gamma';

            % Create GammaSlider
            app.GammaSlider = uislider(app.PositroniumdotMATMdulo1UIFigure);
            app.GammaSlider.Limits = [0.1 2];
            app.GammaSlider.MajorTicks = [0.1 1 2];
            app.GammaSlider.Orientation = 'vertical';
            app.GammaSlider.ValueChangedFcn = createCallbackFcn(app, @GammaSliderValueChanged, true);
            app.GammaSlider.FontSize = 10;
            app.GammaSlider.Enable = 'off';
            app.GammaSlider.Position = [391 18 3 149];
            app.GammaSlider.Value = 1;

            % Create FiltroslinealesynolinealesDropDownLabel
            app.FiltroslinealesynolinealesDropDownLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.FiltroslinealesynolinealesDropDownLabel.HorizontalAlignment = 'right';
            app.FiltroslinealesynolinealesDropDownLabel.Position = [576 110 152 22];
            app.FiltroslinealesynolinealesDropDownLabel.Text = 'Filtros lineales y no lineales';

            % Create FiltroslinealesynolinealesDropDown
            app.FiltroslinealesynolinealesDropDown = uidropdown(app.PositroniumdotMATMdulo1UIFigure);
            app.FiltroslinealesynolinealesDropDown.Items = {'No filtro', 'Option 2', 'Option 3', 'Option 4'};
            app.FiltroslinealesynolinealesDropDown.ItemsData = [1 2 3 4 5 6 7 8 9 10 11 12];
            app.FiltroslinealesynolinealesDropDown.ValueChangedFcn = createCallbackFcn(app, @FiltroslinealesynolinealesDropDownValueChanged, true);
            app.FiltroslinealesynolinealesDropDown.Position = [582 89 161 22];
            app.FiltroslinealesynolinealesDropDown.Value = 1;

            % Create Param1EditFieldLabel
            app.Param1EditFieldLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.Param1EditFieldLabel.HorizontalAlignment = 'right';
            app.Param1EditFieldLabel.Position = [582 39 47 22];
            app.Param1EditFieldLabel.Text = 'Param1';

            % Create Param1EditField
            app.Param1EditField = uieditfield(app.PositroniumdotMATMdulo1UIFigure, 'numeric');
            app.Param1EditField.ValueChangedFcn = createCallbackFcn(app, @Param1EditFieldValueChanged, true);
            app.Param1EditField.Enable = 'off';
            app.Param1EditField.Position = [636 39 30 22];

            % Create Param2EditFieldLabel
            app.Param2EditFieldLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.Param2EditFieldLabel.HorizontalAlignment = 'right';
            app.Param2EditFieldLabel.Position = [671 39 47 22];
            app.Param2EditFieldLabel.Text = 'Param2';

            % Create Param2EditField
            app.Param2EditField = uieditfield(app.PositroniumdotMATMdulo1UIFigure, 'numeric');
            app.Param2EditField.ValueChangedFcn = createCallbackFcn(app, @Param2EditFieldValueChanged, true);
            app.Param2EditField.Enable = 'off';
            app.Param2EditField.Position = [724 39 31 22];

            % Create MnimoEditFieldLabel
            app.MnimoEditFieldLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.MnimoEditFieldLabel.HorizontalAlignment = 'right';
            app.MnimoEditFieldLabel.Position = [573 167 44 22];
            app.MnimoEditFieldLabel.Text = 'Mínimo';

            % Create MnimoEditField
            app.MnimoEditField = uieditfield(app.PositroniumdotMATMdulo1UIFigure, 'numeric');
            app.MnimoEditField.ValueChangedFcn = createCallbackFcn(app, @MnimoEditFieldValueChanged, true);
            app.MnimoEditField.Enable = 'off';
            app.MnimoEditField.Position = [624 167 34 22];
            app.MnimoEditField.Value = 100;

            % Create MximoEditFieldLabel
            app.MximoEditFieldLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.MximoEditFieldLabel.HorizontalAlignment = 'right';
            app.MximoEditFieldLabel.Position = [676 167 47 22];
            app.MximoEditFieldLabel.Text = 'Máximo';

            % Create MximoEditField
            app.MximoEditField = uieditfield(app.PositroniumdotMATMdulo1UIFigure, 'numeric');
            app.MximoEditField.ValueChangedFcn = createCallbackFcn(app, @MximoEditFieldValueChanged, true);
            app.MximoEditField.Enable = 'off';
            app.MximoEditField.Position = [730 167 34 22];
            app.MximoEditField.Value = 150;

            % Create GradienteDropDownLabel
            app.GradienteDropDownLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.GradienteDropDownLabel.HorizontalAlignment = 'right';
            app.GradienteDropDownLabel.Position = [786 193 58 22];
            app.GradienteDropDownLabel.Text = 'Gradiente';

            % Create GradienteDropDown
            app.GradienteDropDown = uidropdown(app.PositroniumdotMATMdulo1UIFigure);
            app.GradienteDropDown.Items = {'Seleccione...'};
            app.GradienteDropDown.ItemsData = [1 2 3 4 5 6];
            app.GradienteDropDown.ValueChangedFcn = createCallbackFcn(app, @GradienteDropDownValueChanged, true);
            app.GradienteDropDown.Enable = 'off';
            app.GradienteDropDown.Position = [787 173 145 22];
            app.GradienteDropDown.Value = 1;

            % Create PginaTIFFDropDownLabel
            app.PginaTIFFDropDownLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.PginaTIFFDropDownLabel.HorizontalAlignment = 'right';
            app.PginaTIFFDropDownLabel.Position = [197 203 71 22];
            app.PginaTIFFDropDownLabel.Text = 'Página TIFF';

            % Create PginaTIFFDropDown
            app.PginaTIFFDropDown = uidropdown(app.PositroniumdotMATMdulo1UIFigure);
            app.PginaTIFFDropDown.Items = {'Imag 1', 'Imag 2'};
            app.PginaTIFFDropDown.Enable = 'off';
            app.PginaTIFFDropDown.Position = [278 203 78 22];
            app.PginaTIFFDropDown.Value = 'Imag 1';

            % Create ColorDropDownLabel
            app.ColorDropDownLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.ColorDropDownLabel.HorizontalAlignment = 'right';
            app.ColorDropDownLabel.Position = [14 203 34 22];
            app.ColorDropDownLabel.Text = 'Color';

            % Create ColorDropDown
            app.ColorDropDown = uidropdown(app.PositroniumdotMATMdulo1UIFigure);
            app.ColorDropDown.Items = {'RGB', 'Rojo', 'Verde', 'Azul', 'E. grises'};
            app.ColorDropDown.ItemsData = [0 1 2 3 4];
            app.ColorDropDown.ValueChangedFcn = createCallbackFcn(app, @ColorDropDownValueChanged, true);
            app.ColorDropDown.Enable = 'off';
            app.ColorDropDown.Position = [63 203 81 22];
            app.ColorDropDown.Value = 0;

            % Create DilatarButton
            app.DilatarButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.DilatarButton.ButtonPushedFcn = createCallbackFcn(app, @DilatarButtonPushed, true);
            app.DilatarButton.Enable = 'off';
            app.DilatarButton.Position = [776 11 85 23];
            app.DilatarButton.Text = 'Dilatar';

            % Create ErosionarButton
            app.ErosionarButton = uibutton(app.PositroniumdotMATMdulo1UIFigure, 'push');
            app.ErosionarButton.ButtonPushedFcn = createCallbackFcn(app, @ErosionarButtonPushed, true);
            app.ErosionarButton.Enable = 'off';
            app.ErosionarButton.Position = [867 11 79 23];
            app.ErosionarButton.Text = 'Erosionar';

            % Create OpmofolgicaDropDownLabel
            app.OpmofolgicaDropDownLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.OpmofolgicaDropDownLabel.HorizontalAlignment = 'right';
            app.OpmofolgicaDropDownLabel.Position = [775 80 86 22];
            app.OpmofolgicaDropDownLabel.Text = 'Op. mofológica';

            % Create OpmofolgicaDropDown
            app.OpmofolgicaDropDown = uidropdown(app.PositroniumdotMATMdulo1UIFigure);
            app.OpmofolgicaDropDown.Items = {'disk', 'diamond', 'square'};
            app.OpmofolgicaDropDown.ItemsData = [1 2 3 4];
            app.OpmofolgicaDropDown.Enable = 'off';
            app.OpmofolgicaDropDown.Position = [775 52 95 19];
            app.OpmofolgicaDropDown.Value = 1;

            % Create RadiomorfEditFieldLabel
            app.RadiomorfEditFieldLabel = uilabel(app.PositroniumdotMATMdulo1UIFigure);
            app.RadiomorfEditFieldLabel.HorizontalAlignment = 'right';
            app.RadiomorfEditFieldLabel.Position = [871 80 75 22];
            app.RadiomorfEditFieldLabel.Text = 'Radio  (morf)';

            % Create RadiomorfEditField
            app.RadiomorfEditField = uieditfield(app.PositroniumdotMATMdulo1UIFigure, 'numeric');
            app.RadiomorfEditField.Enable = 'off';
            app.RadiomorfEditField.Position = [878 51 67 22];
            app.RadiomorfEditField.Value = 1;

            % Show the figure after all components are created
            app.PositroniumdotMATMdulo1UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PositroniumdotMATMdulo1UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PositroniumdotMATMdulo1UIFigure)
        end
    end
end