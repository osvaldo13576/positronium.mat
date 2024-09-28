classdef main2_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PositroniumdotMATMododetomografaUIFigure  matlab.ui.Figure
        UILabel                       matlab.ui.control.Label
        SRNLabel                      matlab.ui.control.Label
        COVLabel                      matlab.ui.control.Label
        flipvolButton                 matlab.ui.control.Button
        nCorteEditField               matlab.ui.control.NumericEditField
        Button_6                      matlab.ui.control.Button
        Button_5                      matlab.ui.control.Button
        CrosshairctrlLabel            matlab.ui.control.Label
        Button_4                      matlab.ui.control.Button
        Button_3                      matlab.ui.control.Button
        Button_2                      matlab.ui.control.Button
        Button                        matlab.ui.control.Button
        FWHMButtonGroup               matlab.ui.container.ButtonGroup
        GxlsxCheckBox                 matlab.ui.control.CheckBox
        RefrescarButton               matlab.ui.control.Button
        AjustarejeCheckBox            matlab.ui.control.CheckBox
        NumricoCheckBox               matlab.ui.control.CheckBox
        PuntualCheckBox               matlab.ui.control.CheckBox
        RadiocmEditField              matlab.ui.control.NumericEditField
        RadiocmEditFieldLabel         matlab.ui.control.Label
        UmbralEditField               matlab.ui.control.NumericEditField
        UmbralEditFieldLabel          matlab.ui.control.Label
        IniciarButton                 matlab.ui.control.Button
        MximoButton                   matlab.ui.control.RadioButton
        RadioEditField                matlab.ui.control.NumericEditField
        RadioEditFieldLabel           matlab.ui.control.Label
        PuntualButton                 matlab.ui.control.RadioButton
        PromedioButton                matlab.ui.control.RadioButton
        WindowWidthEditField          matlab.ui.control.NumericEditField
        WindowWidthEditFieldLabel     matlab.ui.control.Label
        WindowLevelEditField          matlab.ui.control.NumericEditField
        WindowLevelEditFieldLabel     matlab.ui.control.Label
        vidamediaLabel                matlab.ui.control.Label
        radionuclidoLabel             matlab.ui.control.Label
        Actividad0Label               matlab.ui.control.Label
        DeteccindebordeDropDown       matlab.ui.control.DropDown
        DeteccindebordeDropDownLabel  matlab.ui.control.Label
        GuardarButton                 matlab.ui.control.Button
        CerrarButton                  matlab.ui.control.Button
        ResetsegmentacinButton        matlab.ui.control.Button
        SUVMAXLabel                   matlab.ui.control.Label
        ErosionarButton               matlab.ui.control.Button
        DilatarButton                 matlab.ui.control.Button
        RadiomorfEditField            matlab.ui.control.NumericEditField
        RadiomorfEditFieldLabel       matlab.ui.control.Label
        ROIhightEditField             matlab.ui.control.NumericEditField
        ROIhightEditFieldLabel        matlab.ui.control.Label
        ROIlowEditField               matlab.ui.control.NumericEditField
        ROIlowEditFieldLabel          matlab.ui.control.Label
        OpmofolgicaDropDown           matlab.ui.control.DropDown
        OpmofolgicaDropDownLabel      matlab.ui.control.Label
        VerROICheckBox                matlab.ui.control.CheckBox
        VisualizacinButtonGroup       matlab.ui.container.ButtonGroup
        ROIButton                     matlab.ui.control.RadioButton
        SUVButton                     matlab.ui.control.RadioButton
        PETPETuButton                 matlab.ui.control.RadioButton
        SUVMEANLabel                  matlab.ui.control.Label
        FX2FY2Label                   matlab.ui.control.Label
        FX1FY1Label                   matlab.ui.control.Label
        SeleccindeROIButtonGroup      matlab.ui.container.ButtonGroup
        SegmentadoSUVButton           matlab.ui.control.RadioButton
        SegmentadoPETButton           matlab.ui.control.RadioButton
        SegmentadoCTButton            matlab.ui.control.RadioButton
        RectangularButton             matlab.ui.control.RadioButton
        CircularButton                matlab.ui.control.RadioButton
        NingunaButton                 matlab.ui.control.RadioButton
        DistanciaLabel                matlab.ui.control.Label
        XX2YY2Label                   matlab.ui.control.Label
        XX1YY1Label                   matlab.ui.control.Label
        XXXXXXLabel                   matlab.ui.control.Label
        XXXYYYLabel                   matlab.ui.control.Label
        SUV0000Label                  matlab.ui.control.Label
        CorteSlider                   matlab.ui.control.Slider
        CorteSliderLabel              matlab.ui.control.Label
        AlphaPETSlider                matlab.ui.control.Slider
        AlphaPETSliderLabel           matlab.ui.control.Label
        AlphaCTSlider                 matlab.ui.control.Slider
        AlphaCTSliderLabel            matlab.ui.control.Label
        UncorrectedPETCheckBox        matlab.ui.control.CheckBox
        DDMMAAAAalasHHMMSSLabel       matlab.ui.control.Label
        outputTextArea                matlab.ui.control.TextArea
        CorrerButton                  matlab.ui.control.Button
        UIAxes5                       matlab.ui.control.UIAxes
        UIAxes4                       matlab.ui.control.UIAxes
        UIAxes3                       matlab.ui.control.UIAxes
        UIAxes2                       matlab.ui.control.UIAxes
        UIAxes                        matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        CTDIR = 'SE000001';
        PTDIR = 'SE000003';%'SE000002';
        PTUDIR = 'SE000004';%'SE000004';
        output
        mod2DIR
        cortes
        well_enable = 0;
        buttonDown_PET_enable = 0;
        buttonDown_CT_enable = 0;
        buttonDown_fusion_enable = 0;
        %%
        topogram_index
        %topogram_rot = false;
        ct_volume
        pt_volume
        ptu_volume
        ct_info
        pt_info
        ptu_info
        ct_time
        pt_time
        ptu_time
        pt_edges_pixel
        ptu_edges_pixel
        ct_edges_on = 0
        SUV_pt
        SUV_ptu
        %%
        pt_crosshair
        pt_crosshair_x
        pt_crosshair_y
        %%
        tp_line
        ptu_true = 0;
        %%
        CT_p1;CT_xy_p1
        CT_p2;CT_xy_p2
        CT_ln
        rule_state
        %%
        roi_fig
        PT_p1;PT_xy_p1
        PT_p2;PT_xy_p2
        roi_state = false;
        roi_activated = false;
        roi_CT_selected_state = true;
        roi_map
        viewROI_true = 0;
        cambiar_x_y = false;
        CT_resized
        fused
        WW
        WL
        %% fwhm
        ac_cont
        axial_plot
        linea_perfil_px
        fwhm_fig
        fwhm_vec;fwhm_vec_z;fwhm_vec_x;fwhm_vec_y
        fwhm_max_point
        fwhm_points
        fwhm_shadow
        fwhm_points_activated = true;
        min_x_axis
        max_x_axis
        %%
        running = true
        %%
        main_fig1
        main_fig2
        main_fig3
    end
    
    methods (Access = private)
        function [loc_slice,pixel_spacing,altura,ancho,WindowWidth] = get_topograma(app,directorio,carpeta,UIAXES)
            lista = dir(fullfile(directorio,carpeta,'*CT*'));
            lista = [char({lista.name})];
            info = dicominfo(fullfile(directorio,carpeta,lista(1,:)));
            WindowWidth = info.WindowWidth;
            loc_slice = info.SliceLocation;
            pixel_spacing = info.PixelSpacing;
            ancho = info.Width;
            altura = info.Height;
            matrix = dicomread(info);
            val1 = 1; val2 = altura; val3 = 1; val4 = ancho;
            n=0;
            while n==0
                n = max(matrix(val1,:));
                val1 = val1 + 1;
            end
            n=0;
            while n==0
                n = max(matrix(val2,:));
                val2 = val2 - 1;
            end
            n=0;
            while n==0
                n = max(matrix(:,val3));
                val3 = val3 + 1;
            end
            n=0;
            while n==0
                n = max(matrix(:,val4));
                val4 = val4 - 1;
            end
            val1 = val1-1; val2 = val2+1; val3 = val3-1; val4 = val4+1;
            altura = val2-val1+1;
            ancho = val4-val3+1;
            topograma = matrix(val1:val2,val3:val4,1);
            UIAXES.XLim = [1,ancho];
            UIAXES.YLim = [1,altura];

            
            %% configuramos los niveles de grises del topograma
            WiWi=info.WindowWidth(1);
            WiLe=info.WindowCenter(1);
            
            topograma = double(topograma*info.RescaleSlope+info.RescaleIntercept);
            if altura > ancho
                camroll(UIAXES,270)
                %topograma = rot90(topograma,2);
            end
            topograma = ind2rgb(int64(topograma-(WiLe-WiWi/2)), gray(WiWi));            
            
            %% mostramos la figura
            imagesc(UIAXES,topograma,"HitTest","off");colormap(UIAXES,"gray");
            UIAXES.PlotBoxAspectRatio = [4,10,1];
            app.output = "Tamaño de topograma: "+convertCharsToStrings(int2str(size(topograma)))+newline+app.output; 
            app.outputTextArea.Value =  app.output; 
            app.output = "Tamaño de volumen: "+convertCharsToStrings(int2str(size(app.SUV_pt)))+newline+app.output; 
            app.outputTextArea.Value =  app.output; drawnow limitrate
        end

        function [mins,correctDate] = ConvertChar2Minutes(app, CharDate)
            hora =  str2double(CharDate(1:2)); min =  str2double(CharDate(4:5));
            segundos =  str2double(CharDate(8:end));
            correctDate = isnan(hora) || isnan(min) || isnan(segundos);
            if correctDate
                 app.output = "[X] Hora inválida."+newline+app.output; 
                 app.outputTextArea.Value =  app.output;
            else
                mins = hora*60 + min + segundos/60;
                app.output = "[OK] Hora correcta: "+convertCharsToStrings()+"min"+newline+app.output; 
                app.outputTextArea.Value =  app.output;
            end

        end
        function SUV = SUVolume(~, PET_volume,pt_info,RescaleSlope,ad_time,cortes)
            PET_volume = double(PET_volume);
            actividad_0=pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideTotalDose;
            t_string = pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
            hora = str2double(t_string(1:2));
            minutos = str2double(t_string(3:4));
            segundos = str2double(t_string(5:end));
            t1 = hora*60+minutos+segundos/60;
            vida_media=pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideHalfLife/60;
            % factor_calibracion_dosis=pt_info.DoseCalibrationFactor;
            peso_paciente = pt_info.PatientWeight*1000;
            factor_calibracion_dosis =1;
            SUV = zeros(size(PET_volume));
            for n = 1:cortes
                t2 = ad_time(n);
                delta_t = t2-t1;
                actividad = actividad_0*exp(-delta_t*log(2)/vida_media);
                SUV(:,:,n) = (PET_volume(:,:,n)*RescaleSlope(n)*factor_calibracion_dosis)*peso_paciente/actividad;
            end
        end

        function A_c = Concentracion_Ac(~, PET_volume,RescaleSlope,cortes)
            PET_volume = double(PET_volume);
            A_c = zeros(size(PET_volume));
            for n = 1:cortes
                A_c(:,:,n) = PET_volume(:,:,n)*RescaleSlope(n);%app.ac_cont
            end
        end        
        
        function [volumen,info, loc_vector,tiempo,RescaleSlope] = load_dicom_data(~,directorio,carpeta,modalidad,cortes,pt_true)
            % cargamos la lista de archivos en la carpeta
            % WindowWidth,ancho,altura,ImagePositionPatient,PixelSpacing
            lista = dir(fullfile(directorio,carpeta,modalidad));
            lista = [char({lista.name})];
            info = dicominfo(fullfile(directorio,carpeta,lista(1,:)));
            ancho = double(info.Width);
            altura = double(info.Height);
            loc_vector = zeros(1,cortes);
            tiempo = zeros(1,cortes);
            RescaleSlope = zeros(1,cortes);
            if pt_true == 1
                volumen = zeros(altura,ancho,cortes,'uint16');
            else 
                volumen = zeros(altura,ancho,cortes,'double');
            end
            loc_slice = zeros(1,cortes);
            for n = 1:cortes
                info_corte = dicominfo(fullfile(directorio,carpeta,lista(n,:)));
                loc_slice(n) = info_corte.SliceLocation;
            end
            [~,Slicesorted] = sort(loc_slice);
            for n = 1:cortes
                n_corte_instance = Slicesorted(n);
                info_corte = dicominfo(fullfile(directorio,carpeta,lista(n_corte_instance,:)));
                AcquisitionTime = info_corte.AcquisitionTime;
                RescaleSlope(1,n) = info_corte.RescaleSlope;
                hora = str2double(AcquisitionTime(1:2));
                minutos = str2double(AcquisitionTime(3:4));
                segundos = str2double(AcquisitionTime(5:end));
                tiempo(1,n) = hora*60+minutos+segundos/60;
                loc_vector(1,n_corte_instance) = info_corte.SliceLocation;
                if pt_true == 1
                    volumen(:,:,n) = dicomread(info_corte);
                else 
                    volumen(:,:,n) = double(dicomread(info_corte))*info_corte.RescaleSlope+info_corte.RescaleIntercept; 
                end
            end
            
        end
        function [lines] = crosshair_lines(app,x,y,UI_AXES)
            lineX = xline(UI_AXES, x,'Color','y','linewidth',0.8,"HitTest","off");
            lineY = yline(UI_AXES, y,'Color','y','linewidth',0.8,"HitTest","off");
            lines = [lineX, lineY];
            fwhm_plot(app,x,y,app.CorteSlider.Value)
        end
        %% fwhm
        function [] = fwhm_plot(app,x,y,z)
            delete([app.axial_plot,app.fwhm_fig,app.fwhm_shadow])
            if app.fwhm_points_activated
                delete([app.fwhm_max_point,app.fwhm_points])
                app.fwhm_points_activated = false;
            end
            app.IniciarButton.Enable ="on";
            hold(app.UIAxes5,"on")
            x_cord = [-app.RadiocmEditField.Value app.RadiocmEditField.Value app.RadiocmEditField.Value -app.RadiocmEditField.Value];
            y_cord = [1 1 -1 -1]*1e10;
            app.fwhm_shadow = fill(app.UIAxes5,x_cord,y_cord,'cyan','FaceAlpha',0.3,'EdgeAlpha',0);
            if app.PromedioButton.Value
                c_z = [x y];
                %c_x = [z y];
                %c_y = [z x];
                r = app.RadioEditField.Value;
                pos_z = [c_z-r 2*r 2*r];
                %pos_x = [c_x-r 2*r 2*r];
                %pos_y = [c_y-r 2*r 2*r];
                app.fwhm_fig = rectangle(app.UIAxes2,'Position',pos_z,'Curvature',[1 1],'EdgeColor','y');
                % 
                tam = size(app.ac_cont(:,:,:));

                app.fwhm_vec_z = zeros(1,tam(3));
                app.fwhm_vec_x = zeros(1,tam(2));
                app.fwhm_vec_y = zeros(1,tam(1));

                for n = 1:tam(3)
                    %SUV_volume_corte = app.ac_cont(:,:,n);
                    %app.fwhm_vec_z(n) = mean(SUV_volume_corte(fwhm_map_z));
                    SUV_volume_corte = app.ac_cont(y-(r-0):y+(r-0),x,n);
                    app.fwhm_vec_z(n) =  mean(SUV_volume_corte);
                end
                for n = 1:tam(2)
                    %SUV_volume_corte = squeeze(app.ac_cont(:,n,:));
                    %app.fwhm_vec_x(n) = mean(SUV_volume_corte(fwhm_map_x));
                    SUV_volume_corte = app.ac_cont(y-(r-0):y+(r-0),n,z);
                    app.fwhm_vec_x(n) = mean(SUV_volume_corte);
                end
                for n = 1:tam(1)
                    %SUV_volume_corte = squeeze(app.ac_cont(n,:,:));
                    %app.fwhm_vec_y(n) = mean(SUV_volume_corte(fwhm_map_y));
                    SUV_volume_corte = app.ac_cont(n,x-(r-0):x+(r-0),z);
                    app.fwhm_vec_y(n) = mean(SUV_volume_corte);
                end
                vec_z = ((0:tam(3)-1)-z)*app.ct_info.SliceThickness/10;
                vec_x = ((0:tam(2)-1)-x)*app.pt_info.PixelSpacing(1)/10;
                vec_y = ((0:tam(1)-1)-y)*app.pt_info.PixelSpacing(2)/10;
                app.axial_plot(1) = plot(app.UIAxes5,vec_z,app.fwhm_vec_z,"Color",'b',"LineWidth",1,"LineStyle","-",'Marker','.');
                app.axial_plot(2) = plot(app.UIAxes5,vec_x,app.fwhm_vec_x,"Color",'g',"LineWidth",1,"LineStyle","-",'Marker','.');
                app.axial_plot(3) = plot(app.UIAxes5,vec_y,app.fwhm_vec_y,"Color",'r',"LineWidth",1,"LineStyle","-",'Marker','.');
            elseif app.PuntualButton.Value
                %app.IniciarButton.Enable ="off";
                %app.fwhm_vec = squeeze(app.SUV_pt(y,x,:));
                %app.axial_plot = plot(app.UIAxes5,1:app.cortes,app.fwhm_vec,"Color",'b',"LineWidth",1,"LineStyle","-",'Marker','.');
                app.fwhm_vec_z = squeeze(app.ac_cont(y,x,:))';
                app.fwhm_vec_x = squeeze(app.ac_cont(y,:,z));
                app.fwhm_vec_y = squeeze(app.ac_cont(:,x,z))';
                tam = size(app.ac_cont(:,:,:));
                vec_z = ((0:tam(3)-1)-z)*app.ct_info.SliceThickness/10;
                vec_x = ((0:tam(2)-1)-x)*app.pt_info.PixelSpacing(1)/10;
                vec_y = ((0:tam(1)-1)-y)*app.pt_info.PixelSpacing(2)/10;
                %
                app.axial_plot(1) = plot(app.UIAxes5,vec_z,app.fwhm_vec_z,"Color",'b',"LineWidth",1,"LineStyle","-",'Marker','.');
                app.axial_plot(2) = plot(app.UIAxes5,vec_x,app.fwhm_vec_x,"Color",'g',"LineWidth",1,"LineStyle","-",'Marker','.');
                app.axial_plot(3) = plot(app.UIAxes5,vec_y,app.fwhm_vec_y,"Color",'r',"LineWidth",1,"LineStyle","-",'Marker','.');
            elseif app.MximoButton.Value
                %
                c_z = [x y];
                %c_x = [z y];
                %c_y = [z x];
                r = app.RadioEditField.Value;
                pos_z = [c_z-r 2*r 2*r];
                %pos_x = [c_x-r 2*r 2*r];
                %pos_y = [c_y-r 2*r 2*r];
                app.fwhm_fig = rectangle(app.UIAxes2,'Position',pos_z,'Curvature',[1 1],'EdgeColor','y');
                %
                tam = size(app.ac_cont(:,:,:));

                app.fwhm_vec_z = zeros(1,tam(3));
                app.fwhm_vec_x = zeros(1,tam(2));
                app.fwhm_vec_y = zeros(1,tam(1));

                for n = 1:tam(3)
                    %SUV_volume_corte = app.ac_cont(:,:,n);
                    %app.fwhm_vec_z(n) = max(SUV_volume_corte(fwhm_map_z));
                    SUV_volume_corte = app.ac_cont(y-(r-0):y+(r-0),x,n);
                    app.fwhm_vec_z(n) =  mean(SUV_volume_corte);
                end
                for n = 1:tam(2)
                    SUV_volume_corte = app.ac_cont(y-(r-0):y+(r-0),n,z);
                    app.fwhm_vec_x(n) = max(SUV_volume_corte);
                end
                for n = 1:tam(1)
                    %SUV_volume_corte = squeeze(app.ac_cont(n,:,:));
                    %app.fwhm_vec_y(n) = max(SUV_volume_corte(fwhm_map_y));
                    SUV_volume_corte = app.ac_cont(n,x-(r-0):x+(r-0),z);
                    app.fwhm_vec_y(n) = max(SUV_volume_corte);
                end
                vec_z = ((0:tam(3)-1)-z)*app.ct_info.SliceThickness/10;
                vec_x = ((0:tam(2)-1)-x)*app.pt_info.PixelSpacing(1)/10;
                vec_y = ((0:tam(1)-1)-y)*app.pt_info.PixelSpacing(2)/10;
                app.axial_plot(1) = plot(app.UIAxes5,vec_z,app.fwhm_vec_z,"Color",'b',"LineWidth",1,"LineStyle","-",'Marker','.');
                app.axial_plot(2) = plot(app.UIAxes5,vec_x,app.fwhm_vec_x,"Color",'g',"LineWidth",1,"LineStyle","-",'Marker','.');
                app.axial_plot(3) = plot(app.UIAxes5,vec_y,app.fwhm_vec_y,"Color",'r',"LineWidth",1,"LineStyle","-",'Marker','.');
            end
            app.min_x_axis = min([min(vec_z) min(vec_x) min(vec_y)]);
            app.max_x_axis = max([max(vec_z) max(vec_x) max(vec_y)]);
            ylim(app.UIAxes5,[0 max([max(app.fwhm_vec_z) max(app.fwhm_vec_x) max(app.fwhm_vec_y)])])
        end

        function []= draw_figs(app,corte,x,y)
            delete([app.main_fig1,app.main_fig2,app.main_fig3])
            corte =  round(corte);
            if app.roi_activated 
                ROI_map_SUV_CT(app,x,y,app.SUV_pt(:,:,corte))
            end
            app.main_fig1 = imagesc(app.UIAxes,app.ct_volume(:,:,corte),"HitTest","off",[app.WL-app.WW/2,app.WL+app.WW/2]);colormap(app.UIAxes,"gray");
            app.UIAxes.PlotBoxAspectRatio = [app.ct_info.Width/app.ct_info.Height, 1, 1];
            if app.ptu_true == 0
                title(app.UIAxes2, 'PET')
                app.CT_resized = imresize(app.ct_volume(:,:,corte),size(app.pt_volume(:,:,corte)));
                maxSUV = max(max(app.SUV_pt(:,:,corte)));
                if app.PETPETuButton.Value == 1
                      app.main_fig2 = imagesc(app.UIAxes2,app.pt_volume(:,:,corte),"HitTest","off",[0 65535]);colormap(app.UIAxes2,"jet");
                      PT = ind2rgb(app.pt_volume(:,:,corte), jet(2^16));
                      c = colorbar(app.UIAxes3,'TickLabels',num2cell(linspace(0,2^16,9)));
                      colormap(app.UIAxes3,jet); 
                      c.Label.String = 'Intensidad de Píxel'; 
                      app.UIAxes3.FontSize = 10; 
                elseif app.SUVButton.Value == 1
                      app.main_fig2 = imagesc(app.UIAxes2,app.SUV_pt(:,:,corte),"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"jet");
                      PT = ind2rgb(uint8(256*app.SUV_pt(:,:,corte)/maxSUV), jet(256));
                      c = colorbar(app.UIAxes3,'TickLabels',num2cell(linspace(0,maxSUV,9)));
                      colormap(app.UIAxes3,jet); 
                      c.Label.String = 'Valor SUV'; 
                      app.UIAxes3.FontSize = 10; 
                elseif app.ROIButton.Value == 1
                      app.main_fig2 = imagesc(app.UIAxes2,app.roi_map,"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"gray");
                      PT = ind2rgb(uint8(256*app.SUV_pt(:,:,corte)/maxSUV), jet(256));
                      c = colorbar(app.UIAxes3,'TickLabels',num2cell(linspace(0,maxSUV,9)));
                      colormap(app.UIAxes3,jet); 
                      c.Label.String = 'Valor SUV'; 
                      app.UIAxes3.FontSize = 10; 
                      
                end
                CT = ind2rgb(int64(app.CT_resized-(app.WL-app.WW/2)), gray(app.WW));
                app.fused = CT*app.AlphaCTSlider.Value + PT*(app.AlphaPETSlider.Value);
                app.fused = im2uint8(app.fused);
                %%
                if (app.SegmentadoPETButton.Value ==1 || app.SegmentadoSUVButton.Value == 1) && app.VerROICheckBox.Value == 0
                    tam = size(PT);
                    matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;%matriz_amarilla(:,:,3) = 0;
                    borde_roi = edge(app.roi_map,char(app.DeteccindebordeDropDown.Items(app.DeteccindebordeDropDown.Value)));
                    matriz_amarilla = uint8(borde_roi).*matriz_amarilla;
                    app.fused = uint8(not(borde_roi)).*app.fused;
                    app.fused= app.fused + matriz_amarilla;
                end
                if app.SegmentadoPETButton.Value ==1 || app.SegmentadoSUVButton.Value == 1
                    segment_data(app,app.SUV_pt(:,:,corte))
                end
                if app.SegmentadoCTButton.Value == 1 && not(app.roi_state)
                    tam = size(PT);
                    matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;%matriz_amarilla(:,:,3) = 0;
                    borde_roi = edge(app.roi_map,char(app.DeteccindebordeDropDown.Items(app.DeteccindebordeDropDown.Value)));
                    matriz_amarilla = uint8(borde_roi).*matriz_amarilla;
                    app.fused = uint8(not(borde_roi)).*app.fused;
                    app.fused= app.fused + matriz_amarilla;
                    segment_data(app,app.SUV_pt(:,:,corte))
                end

                %
                %%
                if app.viewROI_true == 0
                    app.main_fig3 = imagesc(app.UIAxes3,app.fused,"HitTest","off",[app.WL-app.WW/2,app.WL+app.WW/2]);
                elseif app.viewROI_true == 1
                    app.main_fig3 = imagesc(app.UIAxes3,uint8(app.roi_map).*app.fused,"HitTest","off",[app.WL-app.WW/2,app.WL+app.WW/2]);
                end
              
                % tiempo char
                d = minutes(app.pt_time(corte));d.Format = 'hh:mm:ss.SS';
                app.DDMMAAAAalasHHMMSSLabel.Text = ['AcquisitionDateTime ',char(d)];
                app.Actividad0Label.Text = ['A_0 = ',sprintf('%.3f',app.pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideTotalDose* ...
                    2.7027027027027*10^(-8)),' mCi'];
                app.vidamediaLabel.Text = ['t_1/2 = ' sprintf('%.2f',app.pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideHalfLife/60) ' m'];
                app.radionuclidoLabel.Text= app.pt_info.RadiopharmaceuticalInformationSequence.Item_1.Radiopharmaceutical;
                
                
            else
                title(app.UIAxes2, 'PET sin corregir')
                CT_resized_1 = imresize(app.ct_volume(:,:,corte),size(app.ptu_volume(:,:,corte)));
                maxSUV = max(max(app.SUV_pt(:,:,corte)));
                if app.PETPETuButton.Value == 1
                    app.main_fig2 = imagesc(app.UIAxes2,app.ptu_volume(:,:,corte),"HitTest","off",[0 65535]);colormap(app.UIAxes2,"jet");                
                    PT = ind2rgb(app.ptu_volume(:,:,corte), jet(2^16));
                    %c = colorbar(app.UIAxes3,'TickLabels',{'0',int2str(app.pt_info.LargestImagePixelValue/6),int2str(2*app.pt_info.LargestImagePixelValue/6),int2str(3*app.pt_info.LargestImagePixelValue/6),int2str(4*app.pt_info.LargestImagePixelValue/6),int2str(5*app.pt_info.LargestImagePixelValue/6),int2str(app.pt_info.LargestImagePixelValue)});
                    c = colorbar(app.UIAxes3,'TickLabels',num2cell(linspace(0,2^16,9)));
                    colormap(app.UIAxes3,jet); 
                    c.Label.String = 'Intensidad de Píxel'; 
                    app.UIAxes3.FontSize = 10; 
                elseif app.SUVButton.Value == 1
                    app.main_fig2 = imagesc(app.UIAxes2,app.SUV_ptu(:,:,corte),"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"jet");                
                    PT = ind2rgb(uint8(256*app.SUV_ptu(:,:,corte)/maxSUV), jet(256));
                    %c = colorbar(app.UIAxes3,'TickLabels',{'0',sprintf('%.3f',maxSUV/6),sprintf('%.3f',2*maxSUV/6),sprintf('%.3f',3*maxSUV/6),sprintf('%.3f',4*maxSUV/6),sprintf('%.3f',5*maxSUV/6),sprintf('%.3f',maxSUV)});
                    c = colorbar(app.UIAxes3,'TickLabels',num2cell(linspace(0,maxSUV,9)));
                    colormap(app.UIAxes3,jet); 
                    c.Label.String = 'Valor SUV'; 
                    app.UIAxes3.FontSize = 10; 
                elseif app.ROIButton.Value == 1
                    app.main_fig2 = imagesc(app.UIAxes2,app.roi_map,"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"gray");
                    PT = ind2rgb(uint8(256*app.SUV_ptu(:,:,corte)/maxSUV), jet(256));
                    %c = colorbar(app.UIAxes3,'TickLabels',{'0',sprintf('%.3f',maxSUV/6),sprintf('%.3f',2*maxSUV/6),sprintf('%.3f',3*maxSUV/6),sprintf('%.3f',4*maxSUV/6),sprintf('%.3f',5*maxSUV/6),sprintf('%.3f',maxSUV)});
                    c = colorbar(app.UIAxes3,'TickLabels',num2cell(linspace(0,maxSUV,9)));
                    colormap(app.UIAxes3,jet); 
                    c.Label.String = 'Valor SUV'; 
                    app.UIAxes3.FontSize = 10; 
                end
                CT = ind2rgb(int64(CT_resized_1-(app.WL-app.WW/2)), gray(app.WW));
                app.fused = CT*app.AlphaCTSlider.Value + PT*(app.AlphaPETSlider.Value);
                app.fused = im2uint8(app.fused);
                %imagesc(app.UIAxes3,app.fused,"HitTest","off",[app.WL-app.WW/2,app.WL+app.WW/2]);
                if app.viewROI_true == 0
                    app.main_fig3 = imagesc(app.UIAxes3,app.fused,"HitTest","off",[app.WL-app.WW/2,app.WL+app.WW/2]);
                elseif app.viewROI_true == 1
                    app.main_fig3 = imagesc(app.UIAxes3,uint8(app.roi_map).*app.fused,"HitTest","off",[app.WL-app.WW/2,app.WL+app.WW/2]);
                end
                %
                
                % tiempo char
                d = minutes(app.ptu_time(corte));d.Format = 'hh:mm:ss.SS';
                app.DDMMAAAAalasHHMMSSLabel.Text = ['AcquisitionDateTime ',char(d)];
                
                
            end

            %%
            tam = size(CT);
            app.UIAxes2.PlotBoxAspectRatio = [app.pt_info.Width/app.pt_info.Height, 1, 1];
            app.UIAxes2.XLim = [1, tam(1)];
            app.UIAxes2.YLim = [1, tam(2)];
            app.UIAxes3.XLim = [1, tam(1)];
            app.UIAxes3.YLim = [1, tam(2)];
            %%
            tam_1 = size(app.ct_volume(:,:,corte));
            app.UIAxes.XLim = [1, tam_1(1)];
            app.UIAxes.YLim = [1, tam_1(1)];
            app.UIAxes.YDir = 'reverse';
            app.UIAxes2.YDir = 'reverse';
            app.UIAxes3.YDir = 'reverse';
            y=app.topogram_index(corte);
            %y
            delete(app.tp_line)

            app.tp_line=yline(app.UIAxes4, y,'Color','y','linewidth',1);
            rule_new_fig(app)
            if app.roi_activated && app.roi_CT_selected_state  %not(app.ptu_true)
                ROI_fig_SUV_CT(app)
            end
            %%
            app.roi_CT_selected_state = true;
        end

        function [] = lines_and_info(app,corte)
            corte =  round(corte);
            app.XXXYYYLabel.Text = ['(',int2str(app.pt_crosshair_x),',',int2str(app.pt_crosshair_y),')'];
            if app.ptu_true == 0
                app.XXXXXXLabel.Text = [int2str(app.pt_volume(app.pt_crosshair_y,app.pt_crosshair_x,corte))];
                SUVchar = sprintf('%.3f',app.SUV_pt(app.pt_crosshair_y,app.pt_crosshair_x,corte));
                app.SUV0000Label.Text = ['SUV = ',SUVchar];
                delete(app.pt_crosshair)
                app.pt_crosshair = crosshair_lines(app,app.pt_crosshair_x,app.pt_crosshair_y,app.UIAxes2);
            else
                app.XXXXXXLabel.Text = [int2str(app.ptu_volume(app.pt_crosshair_y,app.pt_crosshair_x,corte))];
                SUVchar = sprintf('%.3f',app.SUV_ptu(app.pt_crosshair_y,app.pt_crosshair_x,corte));
                app.SUV0000Label.Text = ['SUV = ',SUVchar];
                delete(app.pt_crosshair)
                app.pt_crosshair = crosshair_lines(app,app.pt_crosshair_x,app.pt_crosshair_y,app.UIAxes2);
            end
        end

        function [] = ROI_map_SUV_CT(app,x,y,SUV_volume_corte)
            %%
            % roi segmentation
            app.ROIlowEditField.Enable = "off";
            app.ROIhightEditField.Enable ="off";
            app.ResetsegmentacinButton.Enable = "off";
            app.DeteccindebordeDropDown.Enable = "off";
            % op morf
            app.OpmofolgicaDropDown.Enable = "off";
            app.OpmofolgicaDropDown.Value = 1;
            app.RadiomorfEditField.Enable ="off";
            app.ErosionarButton.Enable = "off";
            app.DilatarButton.Enable="off";
            %%
            app.FX1FY1Label.Visible = "off";
            app.FX2FY2Label.Visible = "off";
            app.SUVMEANLabel.Visible = "off";
            app.SUVMAXLabel.Visible = "off";
            app.COVLabel.Visible = "off";
            app.UILabel.Visible = "off";
            app.SRNLabel.Visible = "off";
            roi_map_previo = zeros(size(app.pt_volume(:,:,1)),'logical');
            delete([app.PT_p1,app.PT_p2,app.roi_fig])
            if app.roi_state
                app.FX1FY1Label.Visible = "on";
                if app.cambiar_x_y 
                    app.PT_xy_p1 =[x, y];
                end
                app.FX1FY1Label.Text = ['(',int2str(app.PT_xy_p1(1)),',',int2str(app.PT_xy_p1(2)),')'];
            end
            if not(app.roi_state)
                app.FX1FY1Label.Visible = "on";
                app.FX2FY2Label.Visible = "on";
                app.SUVMEANLabel.Visible = "on";
                app.SUVMAXLabel.Visible = "on";
                app.COVLabel.Visible = "on";
                app.UILabel.Visible = "on";
                app.SRNLabel.Visible = "on";
                if app.cambiar_x_y
                    app.PT_xy_p2 =[x, y];
                end
                app.FX1FY1Label.Text = ['(',int2str(app.PT_xy_p1(1)),',',int2str(app.PT_xy_p1(2)),')'];
                app.FX2FY2Label.Text = ['(',int2str(app.PT_xy_p2(1)),',',int2str(app.PT_xy_p2(2)),')'];
                if app.RectangularButton.Value == 1
                    roi_map_previo(min(app.PT_xy_p1(2),app.PT_xy_p2(2)):max(app.PT_xy_p1(2),app.PT_xy_p2(2)),...
                        min(app.PT_xy_p1(1),app.PT_xy_p2(1)):max(app.PT_xy_p1(1),app.PT_xy_p2(1))) = true;
                    app.roi_map = roi_map_previo;
                    roi_vec = SUV_volume_corte(app.roi_map);
                    mean_SUV = mean(roi_vec);
                    SD_SUV = std(roi_vec);
                    min_SUV = min(roi_vec);
                    max_SUV = max(roi_vec);
                    %
                    SUVchar = sprintf('%.3f',mean_SUV);
                    SUVSDchar = sprintf('%.3f',SD_SUV);
                    SUVSNRchar = sprintf('%.3f',(mean_SUV)/(SD_SUV));
                    SUVCOVchar = sprintf('%.3f',100*(SD_SUV)/(mean_SUV));
                    SUVUIchar = sprintf('%.3f',(max_SUV-min_SUV)/(max_SUV+min_SUV));
                    app.SUVMEANLabel.Text = ['SUV_MEAN = ',SUVchar,char(177),SUVSDchar];
                    SUVchar = sprintf('%.3f',max(roi_vec));
                    app.SUVMAXLabel.Text = ['SUV_MAX = ',SUVchar];
                    app.COVLabel.Text = ['COV = ',SUVCOVchar,'%'];
                    app.SRNLabel.Text = ['SNR = ',SUVSNRchar];
                    app.UILabel.Text = ['IU = ',SUVUIchar];
                        
                elseif app.CircularButton.Value == 1
                    tam = size(app.pt_volume(:,:,1));
                    [x,y] = meshgrid(1:tam(2),1:tam(1));
                    roi_map_previo(sqrt((x-app.PT_xy_p1(1)).^2+(y-app.PT_xy_p1(2)).^2)<=norm(app.PT_xy_p2-app.PT_xy_p1)) = true;
                    app.roi_map = roi_map_previo;
                    roi_vec = SUV_volume_corte(app.roi_map);
                    mean_SUV = mean(roi_vec);
                    SD_SUV = std(roi_vec);
                    min_SUV = min(roi_vec);
                    max_SUV = max(roi_vec);
                    %%
                    SUVchar = sprintf('%.3f',mean_SUV);
                    SUVSDchar = sprintf('%.3f',SD_SUV);
                    SUVSNRchar = sprintf('%.3f',(mean_SUV)/(SD_SUV));
                    SUVCOVchar = sprintf('%.3f',100*(SD_SUV)/(mean_SUV));
                    SUVUIchar = sprintf('%.3f',(max_SUV-min_SUV)/(max_SUV+min_SUV));
                    app.SUVMEANLabel.Text = ['SUV_MEAN = ',SUVchar,char(177),SUVSDchar];
                    SUVchar = sprintf('%.3f',max(roi_vec));
                    app.SUVMAXLabel.Text = ['SUV_MAX = ',SUVchar];
                    app.COVLabel.Text = ['COV = ',SUVCOVchar,'%'];
                    app.SRNLabel.Text = ['SNR = ',SUVSNRchar];
                    app.UILabel.Text = ['IU = ',SUVUIchar];
               elseif app.SegmentadoCTButton.Value == 1
                    % roi segmentation
                    app.ROIlowEditField.Enable = "on";
                    app.ROIhightEditField.Enable ="on";
                    %app.ResetsegmentacinButton.Enable = "on";
                    app.DeteccindebordeDropDown.Enable = "on";
                    % op morf
                    app.OpmofolgicaDropDown.Enable = "on";
                    app.OpmofolgicaDropDown.Value = 1;
                    app.RadiomorfEditField.Enable ="on";
                    app.ErosionarButton.Enable = "on";
                    app.DilatarButton.Enable="on";
                    %% ct MINI
                    if  app.roi_CT_selected_state
                        app.roi_map = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                            roi_map_previo(min(app.PT_xy_p1(2),app.PT_xy_p2(2)):max(app.PT_xy_p1(2),app.PT_xy_p2(2)),...
                            min(app.PT_xy_p1(1),app.PT_xy_p2(1)):max(app.PT_xy_p1(1),app.PT_xy_p2(1))) = true;
                        app.roi_map = logical(double(app.roi_map).*double(roi_map_previo));
                    end
                end
                %
            end
        end

            function [] = ROI_fig_SUV_CT(app)
                delete([app.PT_p1,app.PT_p2,app.roi_fig])
                if app.roi_state
                    app.PT_p1 = plot(app.UIAxes3,app.PT_xy_p1(1),app.PT_xy_p1(2),'o','color','c',"HitTest","off");
                end
                if not(app.roi_state)
                    app.PT_p1 = plot(app.UIAxes3,app.PT_xy_p1(1),app.PT_xy_p1(2),'o','color','c',"HitTest","off");
                    app.PT_p2 = plot(app.UIAxes3,app.PT_xy_p2(1),app.PT_xy_p2(2),'o','color','g',"HitTest","off");
                    if app.RectangularButton.Value == 1
                        x = min(app.PT_xy_p1(1),app.PT_xy_p2(1));
                        y = min(app.PT_xy_p1(2),app.PT_xy_p2(2));
                        w = abs(app.PT_xy_p2(1)-app.PT_xy_p1(1));
                        h = abs(app.PT_xy_p2(2)-app.PT_xy_p1(2));
                        app.roi_fig = rectangle(app.UIAxes3,'Position',[x y w h],'EdgeColor','y');
                    elseif app.CircularButton.Value == 1
                        c = app.PT_xy_p1;
                        r = norm(app.PT_xy_p2-app.PT_xy_p1);
                        pos = [c-r 2*r 2*r];
                        app.roi_fig = rectangle(app.UIAxes3,'Position',pos,'Curvature',[1 1],'EdgeColor','y');
                    elseif app.SegmentadoCTButton.Value == 1
                        x = min(app.PT_xy_p1(1),app.PT_xy_p2(1));
                        y = min(app.PT_xy_p1(2),app.PT_xy_p2(2));
                        w = abs(app.PT_xy_p2(1)-app.PT_xy_p1(1));
                        h = abs(app.PT_xy_p2(2)-app.PT_xy_p1(2));
                        app.roi_fig = rectangle(app.UIAxes3,'Position',[x y w h],'EdgeColor','g','LineWidth',0.1);
                        %%
                    end
                end
            end

        function [] = rule(app,x,y)
            app.XX1YY1Label.Visible = "off";
            app.XX2YY2Label.Visible = "off";
            app.DistanciaLabel.Visible = "off";
            delete([app.CT_p1,app.CT_p2,app.CT_ln])
            if app.rule_state % es igual a 1
                app.CT_xy_p1 =[x, y];
                app.XX1YY1Label.Visible = "on";
                app.CT_p1 = plot(app.UIAxes,app.CT_xy_p1(1),app.CT_xy_p1(2),'o','color','c',"HitTest","off");
                app.XX1YY1Label.Text = ['(',int2str(app.CT_xy_p1(1)),',',int2str(app.CT_xy_p1(2)),')'];
            end
            if not(app.rule_state) % es igual a 0
                app.CT_xy_p2 =[x, y];
                app.XX1YY1Label.Visible = "on";
                app.XX2YY2Label.Visible = "on";
                app.DistanciaLabel.Visible = "on";
                app.CT_p1 = plot(app.UIAxes,app.CT_xy_p1(1),app.CT_xy_p1(2),'o','color','c',"HitTest","off");
                app.CT_p2 = plot(app.UIAxes,app.CT_xy_p2(1),app.CT_xy_p2(2),'o','color','g',"HitTest","off");
                app.CT_ln = plot(app.UIAxes,[app.CT_xy_p1(1) app.CT_xy_p2(1)],[app.CT_xy_p1(2) app.CT_xy_p2(2)],'color','y',"HitTest","off");
                app.XX1YY1Label.Text = ['(',int2str(app.CT_xy_p1(1)),',',int2str(app.CT_xy_p1(2)),')'];
                app.XX2YY2Label.Text = ['(',int2str(app.CT_xy_p2(1)),',',int2str(app.CT_xy_p2(2)),')'];
                app.DistanciaLabel.Text = ['Distancia = ',...
                sprintf('%.2f',app.ct_info.PixelSpacing(1)/10*sqrt((app.CT_xy_p1(1) - app.CT_xy_p2(1))^2+(app.CT_xy_p1(2) - app.CT_xy_p2(2))^2)),' cm'];
                
            end
        end
        

        function [] = rule_new_fig(app)
            delete([app.CT_p1,app.CT_p2,app.CT_ln])
            app.XX1YY1Label.Visible = "on";
            app.XX2YY2Label.Visible = "on";
            app.DistanciaLabel.Visible = "on";
            app.CT_p1 = plot(app.UIAxes,app.CT_xy_p1(1),app.CT_xy_p1(2),'o','color','c',"HitTest","off");
            app.CT_p2 = plot(app.UIAxes,app.CT_xy_p2(1),app.CT_xy_p2(2),'o','color','g',"HitTest","off");
            app.CT_ln = plot(app.UIAxes,[app.CT_xy_p1(1) app.CT_xy_p2(1)],[app.CT_xy_p1(2) app.CT_xy_p2(2)],'color','y',"HitTest","off");
            app.XX1YY1Label.Text = ['(',int2str(app.CT_xy_p1(1)),',',int2str(app.CT_xy_p1(2)),')'];
            app.XX2YY2Label.Text = ['(',int2str(app.CT_xy_p2(1)),',',int2str(app.CT_xy_p2(2)),')'];
            app.DistanciaLabel.Text = ['Distancia = ',...
            sprintf('%.2f',app.ct_info.PixelSpacing(1)/10*sqrt((app.CT_xy_p1(1) - app.CT_xy_p2(1))^2+(app.CT_xy_p1(2) - app.CT_xy_p2(2))^2)),' cm'];
            app.rule_state = false;
            
        end
        function [] = segment_data(app,SUV_volume)
            app.SUVMEANLabel.Visible = "on";
            app.SUVMAXLabel.Visible = "on";
            app.COVLabel.Visible = "on";
            app.UILabel.Visible = "on";
            app.SRNLabel.Visible = "on";
            roi_vec = SUV_volume(app.roi_map);
            mean_SUV = mean(roi_vec);
            SD_SUV = std(roi_vec);
            min_SUV = min(roi_vec);
            max_SUV = max(roi_vec);
            %%
            SUVchar = sprintf('%.3f',mean_SUV);
            SUVSDchar = sprintf('%.3f',SD_SUV);
            SUVSNRchar = sprintf('%.3f',(mean_SUV)/(SD_SUV));
            SUVCOVchar = sprintf('%.3f',100*(SD_SUV)/(mean_SUV));
            SUVUIchar = sprintf('%.3f',(max_SUV-min_SUV)/(max_SUV+min_SUV));
            app.SUVMEANLabel.Text = ['SUV_MEAN = ',SUVchar,char(177),SUVSDchar];
            SUVchar = sprintf('%.3f',max(roi_vec));
            app.SUVMAXLabel.Text = ['SUV_MAX = ',SUVchar];
            app.COVLabel.Text = ['COV = ',SUVCOVchar,'%'];
            app.SRNLabel.Text = ['SNR = ',SUVSNRchar];
            app.UILabel.Text = ['IU = ',SUVUIchar];

        end

        function [] = componentes_on_off(app,on_off)
            app.DDMMAAAAalasHHMMSSLabel.Visible = on_off;
            app.AlphaCTSlider.Enable = on_off;
            app.AlphaPETSlider.Enable = on_off;
            app.UncorrectedPETCheckBox.Enable = on_off;
            app.CorteSlider.Enable = on_off;
            app.SUV0000Label.Visible = on_off;
            app.XXXYYYLabel.Visible=on_off;
            app.XXXXXXLabel.Visible = on_off;
            app.Actividad0Label.Visible = on_off;
            app.vidamediaLabel.Visible = on_off;
            app.radionuclidoLabel.Visible = on_off;
            app.well_enable = 1;
            app.buttonDown_PET_enable = 1;
            app.buttonDown_CT_enable = 1;
            app.buttonDown_fusion_enable = 1;
            hold(app.UIAxes,"on")
            hold(app.UIAxes3,"on")
            app.VerROICheckBox.Enable ="on";
            app.SeleccindeROIButtonGroup.Enable = "on";
            app.VisualizacinButtonGroup.Enable = "on";
            app.GuardarButton.Enable = on_off;
            app.WindowLevelEditField.Enable = on_off;
            app.WindowWidthEditField.Enable = on_off;
            app.WindowLevelEditFieldLabel.Enable = on_off;
            app.WindowWidthEditFieldLabel.Enable = on_off;
            app.flipvolButton.Enable = on_off;
            %% nuevos componentes
            app.Button.Enable = on_off;
            app.Button_2.Enable = on_off;
            app.Button_3.Enable = on_off;
            app.Button_4.Enable = on_off;
            app.Button_5.Enable = on_off;
            app.Button_6.Enable = on_off;
            app.FWHMButtonGroup.Enable = on_off;
            app.RadioEditField.Enable = on_off;
            app.RadiocmEditField.Enable = on_off;
            app.UmbralEditField.Enable = on_off;
            app.IniciarButton.Enable = on_off;
            app.nCorteEditField.Enable = on_off;
        end
        
        
        
        function [] = on_off_all(app,on_off)
            set(findobj(app.PositroniumdotMATMododetomografaUIFigure,'Type','uibutton'),'Enable',on_off)
            set(findobj(app.PositroniumdotMATMododetomografaUIFigure,'Type','uicheckbox'),'Enable',on_off)
            set(findobj(app.PositroniumdotMATMododetomografaUIFigure,'Type','uiradiobutton'),'Enable',on_off)
            set(findobj(app.PositroniumdotMATMododetomografaUIFigure,'Type','uieditfield'),'Enable',on_off)
            set(findobj(app.PositroniumdotMATMododetomografaUIFigure,'Type','uiaxes'),'Enable',on_off)
            set(findobj(app.PositroniumdotMATMododetomografaUIFigure,'Type','uislider'),'Enable',on_off)
            %uicheckbox
            %uiradiobutton
            %uieditfield uieditfield
            %uiaxes
            %uislider
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
             movegui(app.PositroniumdotMATMododetomografaUIFigure, 'center');
             load("saved_data.mat","modo2DIR");app.mod2DIR=modo2DIR;
             app.output = "Directorio cargado: " + convertCharsToStrings(app.mod2DIR);
             app.outputTextArea.Value = app.output;
             if isempty(dir(fullfile(app.mod2DIR,'*SE*')))
                    app.output = "[X] Directorio no contiene archivos compatibles.";
                    app.outputTextArea.Value =  app.output;
                    app.CorrerButton.Enable = "off";
                else
                    ct_dir = fullfile(app.mod2DIR,app.CTDIR,'*CT*');
                    pt_dir = fullfile(app.mod2DIR,app.PTDIR,'*PT*');
                    ptu_dir =fullfile(app.mod2DIR,app.PTUDIR,'*PT*');
                    if isempty(dir(ct_dir)) || isempty(dir(pt_dir)) || isempty(dir(ptu_dir))
                        app.output = "[X] Algún directorio DICOM está vacío o no contiene archivos con los patrones CT y/o PT en sus nombres.";
                        app.outputTextArea.Value =  app.output;
                        app.CorrerButton.Enable = "off";
                    else
                        if length(dir(ct_dir)) == length(dir(pt_dir)) && length(dir(pt_dir)) == length(dir(ptu_dir))
                           archivos = dir(ct_dir);
                           files=[convertCharsToStrings({archivos.name})];
                           lista = '';
                           for i = 1:length(files)
                             lista = sprintf("%s%s\n", lista, files(i));
                           end
                            app.cortes = length(dir(ct_dir));
                            app.CorteSlider.Limits = [1, app.cortes];
                            app.output = "[OK] Archivos compatibles encontrados en 3 directorios: " + int2str(length(dir(ct_dir))) +newline+lista+app.output;
                            app.outputTextArea.Value = app.output;
                            app.CorrerButton.Enable = "on";
                        else
                            app.output = "[X] Se encontró que los directorios DICOM no contiene la misma cantidad de elementos.";
                            app.outputTextArea.Value =  app.output;
                            app.CorrerButton.Enable = "off";
                        end
                    end
                     
             end

        end

        % Button pushed function: CorrerButton
        function CorrerButtonPushed(app, event)

            if app.running
                app.running = not(app.running);
                pause(0.1)
                app.CorrerButton.Enable = "off";
                app.CerrarButton.Enable = "off";
                app.outputTextArea.Value = app.output;
                drawnow('limitrate')
                pause(0.2)
                app.output = "Cargando imágenes...."+newline+app.output; 
                app.outputTextArea.Value =  app.output;
                drawnow('limitrate')
                [app.ct_volume,app.ct_info,loc_vector,app.ct_time,~]  = load_dicom_data(app,app.mod2DIR,app.CTDIR,'*CT*',app.cortes,0);
                pause(0.2)
                app.output = "[OK] Imágenes CT cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output;
                drawnow('limitrate')
                [app.pt_volume,app.pt_info,~,app.pt_time,pt_RescaleSlope]  = load_dicom_data(app,app.mod2DIR,app.PTDIR,'*PT*',app.cortes,1);
                pause(0.2)
                app.output = "[OK] Imágenes PET cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output;
                drawnow('limitrate')
                [app.ptu_volume,app.ptu_info,~,app.ptu_time,ptu_RescaleSlope]  = load_dicom_data(app,app.mod2DIR,app.PTUDIR,'*PT*',app.cortes,1);
                pause(0.2)
                app.output = "[OK] Imágenes PET sin corregir cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; 
                drawnow('limitrate')
                
                %%
                if app.ct_info.PixelSpacing(1)*app.ct_info.Height > app.pt_info.PixelSpacing(1)*app.pt_info.Height
                    % cuando la imagen CT es mayor espacialmente que la img PET
                    % app.ct_info.ReconstructionTargetCenterPatient(1) > app.ct_info.ImagePositionPatient(1)
                    ct_edges_p1 = [app.pt_info.ImagePositionPatient(1),app.pt_info.ImagePositionPatient(2)];
                    ct_edges_p2 = [2*app.ct_info.ReconstructionTargetCenterPatient(1)-app.pt_info.ImagePositionPatient(1),2*app.ct_info.ReconstructionTargetCenterPatient(2)-app.pt_info.ImagePositionPatient(2)];
                    %
                    app.pt_edges_pixel = round([(ct_edges_p1(2)-app.ct_info.ImagePositionPatient(2))/app.ct_info.PixelSpacing(2),(ct_edges_p2(2)-app.ct_info.ImagePositionPatient(2))/app.ct_info.PixelSpacing(2)...
                        (ct_edges_p1(1)-app.ct_info.ImagePositionPatient(1))/app.ct_info.PixelSpacing(1),(ct_edges_p2(1)-app.ct_info.ImagePositionPatient(1))/app.ct_info.PixelSpacing(1)]+1);
                    %
                    app.ptu_edges_pixel = app.pt_edges_pixel;
                    app.ct_edges_on = 1;
                else
                    if app.ct_info.ReconstructionTargetCenterPatient(1) > app.ct_info.ImagePositionPatient(1)
                        ct_edges_p1 = [app.ct_info.ImagePositionPatient(1),app.ct_info.ImagePositionPatient(2)];
                        ct_edges_p2 = [2*app.ct_info.ReconstructionTargetCenterPatient(1)-app.ct_info.ImagePositionPatient(1),2*app.ct_info.ReconstructionTargetCenterPatient(2)-app.ct_info.ImagePositionPatient(2)];
                        %
                        app.pt_edges_pixel = round([(ct_edges_p1(2)-app.pt_info.ImagePositionPatient(2))/app.pt_info.PixelSpacing(2),(ct_edges_p2(2)-app.pt_info.ImagePositionPatient(2))/app.pt_info.PixelSpacing(2)...
                            (ct_edges_p1(1)-app.pt_info.ImagePositionPatient(1))/app.pt_info.PixelSpacing(1),(ct_edges_p2(1)-app.pt_info.ImagePositionPatient(1))/app.pt_info.PixelSpacing(1)]+1);
                        %
                        app.ptu_edges_pixel = app.pt_edges_pixel;
                    else
                        ct_edges_p1 = [app.ct_info.ImagePositionPatient(1),app.ct_info.ImagePositionPatient(2)];
                        ct_edges_p2 = [2*app.ct_info.ReconstructionTargetCenterPatient(1)-app.ct_info.ImagePositionPatient(1),2*app.ct_info.ReconstructionTargetCenterPatient(2)-app.ct_info.ImagePositionPatient(2)];
                        app.pt_edges_pixel = round([(-ct_edges_p2(2)+app.pt_info.ImagePositionPatient(2))/app.pt_info.PixelSpacing(2),(-ct_edges_p1(2)+app.pt_info.ImagePositionPatient(2))/app.pt_info.PixelSpacing(2)...
                            (-ct_edges_p1(1)+app.pt_info.ImagePositionPatient(1))/app.pt_info.PixelSpacing(1),(-ct_edges_p2(1)+app.pt_info.ImagePositionPatient(1))/app.pt_info.PixelSpacing(1)]+1);
                        app.ptu_edges_pixel = app.pt_edges_pixel;
                    end
                end
                

                %%
                app.WW=app.ct_info.WindowWidth(1);
                app.WL=app.ct_info.WindowCenter(1);
                app.WindowLevelEditField.Value = app.WL;
                app.WindowWidthEditField.Value = app.WW;
                
                if not(app.ct_edges_on)
                    app.pt_volume = app.pt_volume(app.pt_edges_pixel(1):app.pt_edges_pixel(2),app.pt_edges_pixel(3):app.pt_edges_pixel(4),:);
                    app.ptu_volume = app.ptu_volume(app.ptu_edges_pixel(1):app.ptu_edges_pixel(2),app.ptu_edges_pixel(3):app.ptu_edges_pixel(4),:);
                else
                    pause(0.2)
                    app.output = "[!] Volumen CT corregido"+newline+app.output;
                    app.outputTextArea.Value =  app.output;
                    drawnow('limitrate')
                    app.ct_volume = app.ct_volume(app.pt_edges_pixel(1):app.pt_edges_pixel(2),app.pt_edges_pixel(3):app.pt_edges_pixel(4),:);
                end
                app.SUV_pt = SUVolume(app, app.pt_volume, app.pt_info,pt_RescaleSlope,app.pt_time,app.cortes);
                pause(0.2)
                app.output = "[OK] SUV calculado correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output;
                drawnow('limitrate')
                app.SUV_ptu = SUVolume(app, app.ptu_volume, app.ptu_info,ptu_RescaleSlope,app.ptu_time,app.cortes);
                pause(0.2)
                app.output = "[OK] SUV sin corregir calculado correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output;  
                drawnow('limitrate')
                %
                app.ac_cont = Concentracion_Ac(app, app.pt_volume,pt_RescaleSlope,app.cortes);
                app.output = "[OK] Concentracion de Actividad sin corregir calculado correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output;
                drawnow('limitrate')
                %%
                pause(0.2)
                app.output = "[OK] Datos PET/PETu cortados correctamente."+newline+app.output;
                %%
                app.outputTextArea.Value =  app.output;
                drawnow('limitrate')
                [loc_slice,pixel_spacing,~,~] = get_topograma(app,app.mod2DIR,'SE000000',app.UIAxes4);
                %% indices de posicion del topograma
                app.topogram_index = round((loc_slice-loc_vector)/pixel_spacing(1));

                %%
                app.pt_crosshair_x = round((app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1)/2);
                app.pt_crosshair_y = round((app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1)/2);
                %%
                app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
                %%
                app.CT_xy_p1 = double([round(app.ct_info.Width/2-app.ct_info.Width/3.5),round(app.ct_info.Height/2)]);
                app.CT_xy_p2 = double([round(app.ct_info.Width/2+app.ct_info.Width/3.5),round(app.ct_info.Height/2)]);
                componentes_on_off(app,"on");
                draw_figs(app,1)
                lines_and_info(app,1)

                %% 
                app.CorrerButton.Text = 'Regresar';
                app.CorrerButton.Icon =  fullfile(fileparts(mfilename('fullpath')), 'ico', 'positronium_ico_medium.png');
                app.CorrerButton.Enable = "on";
                app.CerrarButton.Enable = "on";
                %%
                app.nCorteEditField.Limits = [1, app.cortes];
            else
                main0
                app.delete;
            end
            %%
            
        end

        % Window scroll wheel function: 
        % PositroniumdotMATMododetomografaUIFigure
        function PositroniumdotMATMododetomografaUIFigureWindowScrollWheel(app, event)
            %verticalScrollAmount = event.VerticalScrollAmount
            if app.well_enable == 1
                verticalScrollCount = event.VerticalScrollCount;
                posicion = verticalScrollCount + app.CorteSlider.Value;
                if posicion<1
                    app.CorteSlider.Value = 1;
                    app.nCorteEditField.Value = 1;
                elseif posicion>app.cortes
                    app.CorteSlider.Value = app.cortes;
                    app.nCorteEditField.Value = app.cortes;
                else
                    app.nCorteEditField.Value = posicion;
                    app.CorteSlider.Value = posicion;
                end
                app.cambiar_x_y = false;
                draw_figs(app,app.CorteSlider.Value,1,1)
                lines_and_info(app,app.CorteSlider.Value)
            end
            
        end

        % Value changed function: CorteSlider
        function CorteSliderValueChanged(app, event)
            app.CorteSlider.Value = round(app.CorteSlider.Value);
            app.nCorteEditField.Value = app.CorteSlider.Value;
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: nCorteEditField
        function nCorteEditFieldValueChanged(app, event)
            app.nCorteEditField.Value = round(app.nCorteEditField.Value);
            app.CorteSlider.Value = app.nCorteEditField.Value;
            %app.app.CorteSlider.Value = round(value);
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: UncorrectedPETCheckBox
        function UncorrectedPETCheckBoxValueChanged(app, event)
            app.ptu_true = app.UncorrectedPETCheckBox.Value;
            app.cambiar_x_y = false;
            if app.ptu_true
                delete([app.PT_p1,app.PT_p2,app.roi_fig])
                app.SeleccindeROIButtonGroup.Enable = "off";
                app.VerROICheckBox.Enable = "off";
                app.NingunaButton.Value = 1;
                app.FX1FY1Label.Visible = "off";
                app.FX2FY2Label.Visible = "off";
                app.SUVMEANLabel.Visible = "off";
                app.SUVMAXLabel.Visible = "off";
                app.COVLabel.Visible = "off";
                app.UILabel.Visible = "on";
                app.SRNLabel.Visible = "on";
                app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
                app.roi_activated = false;
                app.ROIlowEditField.Enable ="off";
                app.ROIhightEditField.Enable = "off";
                app.OpmofolgicaDropDown.Enable = "off";
                app.OpmofolgicaDropDown.Value = 1;
                app.RadiomorfEditField.Enable = "off";
                app.ErosionarButton.Enable = "off";
                app.DilatarButton.Enable = "off";
                app.DeteccindebordeDropDown.Enable = "off";
                app.ResetsegmentacinButton.Enable = "off";
            elseif not(app.ptu_true)
                app.SeleccindeROIButtonGroup.Enable = "on";
                app.VerROICheckBox.Enable = "on";
                app.NingunaButton.Value = 1;
            end
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: AlphaCTSlider
        function AlphaCTSliderValueChanged(app, event)
            %value = app.AlphaCTSlider.Value;
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: AlphaPETSlider
        function AlphaPETSliderValueChanged(app, event)
            %value = app.AlphaPETSlider.Value;
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button down function: UIAxes2
        function UIAxes2ButtonDown(app, event)
             if app.buttonDown_PET_enable == 1
                 P = get(app.UIAxes2,'CurrentPoint'); 
                 app.pt_crosshair_x = round(P(1,1)); 
                 app.pt_crosshair_y = round(P(1,2));
                 ancho = app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1;
                 altura = app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1;
                    if app.pt_crosshair_x > ancho
                        app.pt_crosshair_x = ancho;
                    elseif app.pt_crosshair_x<1
                        app.pt_crosshair_x = 1;
                    end
                    if app.pt_crosshair_y > altura
                        app.pt_crosshair_y = altura;
                    elseif app.pt_crosshair_y<1
                        app.pt_crosshair_y = 1;
                    end
                 
                 %draw_figs(app,app.CorteSlider.Value)
                 lines_and_info(app,app.CorteSlider.Value)
             end
        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
            if app.buttonDown_CT_enable == 1
                app.rule_state = not(app.rule_state);
                P = get(app.UIAxes,'CurrentPoint'); 
                x = round(P(1,1)); 
                y = round(P(1,2));
                rule(app,x,y)
            end
        end

        % Button down function: UIAxes3
        function UIAxes3ButtonDown(app, event)
            
            if app.NingunaButton.Value == 0 && app.SegmentadoSUVButton.Value == 0 && app.SegmentadoPETButton.Value == 0
                app.roi_state = not(app.roi_state);
                app.roi_activated = true;
                P = get(app.UIAxes3,'CurrentPoint'); 
                x = round(P(1,1)); 
                y = round(P(1,2));
                app.cambiar_x_y = true;
                draw_figs(app,app.CorteSlider.Value,x,y)
                lines_and_info(app,app.CorteSlider.Value)
            end
            
        end

        % Value changed function: VerROICheckBox
        function VerROICheckBoxValueChanged(app, event)
            app.viewROI_true = app.VerROICheckBox.Value;
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Selection changed function: SeleccindeROIButtonGroup
        function SeleccindeROIButtonGroupSelectionChanged(app, event)
            %eliminar elementos gráficos y bloquear la entrada de mouse
            %a la gráfica de fusión
            app.roi_activated = false;
            app.ROIButton.Value = 1;
            app.FX1FY1Label.Visible = "off";
            app.FX2FY2Label.Visible = "off";
            app.SUVMEANLabel.Visible = "off";
            app.SUVMAXLabel.Visible = "off";
            app.COVLabel.Visible = "off";
            app.UILabel.Visible = "off";
            app.SRNLabel.Visible = "off";
            % roi segmentation
            app.ROIlowEditField.Enable = "off";
            app.ROIhightEditField.Enable ="off";
            app.ResetsegmentacinButton.Enable = "off";
            app.DeteccindebordeDropDown.Enable = "off";
            % op morf
            app.OpmofolgicaDropDown.Enable = "off";
            app.OpmofolgicaDropDown.Value = 1;
            app.RadiomorfEditField.Enable ="off";
            app.ErosionarButton.Enable = "off";
            app.DilatarButton.Enable="off";
            app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
            delete([app.PT_p1,app.PT_p2,app.roi_fig])

            if app.SegmentadoCTButton.Value == 1
                 app.ROIlowEditField.Value = -20;
                 app.ROIhightEditField.Value = 20;
            %     app.roi_map = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
            elseif app.SegmentadoPETButton.Value == 1
                app.ROIlowEditField.Value = round(0.8*double(app.pt_info.LargestImagePixelValue));
                app.ROIhightEditField.Value = double(app.pt_info.LargestImagePixelValue);
                app.roi_map = roicolor(app.pt_volume(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
            elseif app.SegmentadoSUVButton.Value == 1
                app.ROIlowEditField.Value = round(0.8*max(max(app.SUV_pt(:,:,round(app.CorteSlider.Value)))));
                app.ROIhightEditField.Value = max(max(app.SUV_pt(:,:,round(app.CorteSlider.Value))));
                app.roi_map = roicolor(app.SUV_pt(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
            end
            if app.SegmentadoPETButton.Value ==1 || app.SegmentadoSUVButton.Value == 1
                % roi segmentation
                app.ROIlowEditField.Enable = "on";
                app.ROIhightEditField.Enable ="on";
                app.ResetsegmentacinButton.Enable = "on";
                app.DeteccindebordeDropDown.Enable = "on";
                % op morf
                app.OpmofolgicaDropDown.Enable = "on";
                app.OpmofolgicaDropDown.Value = 1;
                app.RadiomorfEditField.Enable ="on";
                app.ErosionarButton.Enable = "on";
                app.DilatarButton.Enable="on";
            end
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Selection changed function: VisualizacinButtonGroup
        function VisualizacinButtonGroupSelectionChanged(app, event)
            %selectedButton = app.VisualizacinButtonGroup.SelectedObject;
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: ResetsegmentacinButton
        function ResetsegmentacinButtonPushed(app, event)
            app.roi_CT_selected_state = false;
            %
            app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
            if app.SegmentadoCTButton.Value == 1 && not(app.roi_state)
                app.roi_map = zeros(size(app.pt_volume(:,:,1)),'logical');
                app.ROIlowEditField.Value = -20;
                app.ROIhightEditField.Value = 20;
                %app.roi_map = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoPETButton.Value == 1
                app.ROIlowEditField.Value = round(0.8*double(app.pt_info.LargestImagePixelValue));
                app.ROIhightEditField.Value = double(app.pt_info.LargestImagePixelValue);
                app.roi_map = roicolor(app.pt_volume(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoSUVButton.Value == 1
               app.roi_map = roicolor(app.SUV_pt(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
               app.ROIlowEditField.Value = round(0.8*max(max(app.SUV_pt(:,:,round(app.CorteSlider.Value)))));
               app.ROIhightEditField.Value = max(max(app.SUV_pt(:,:,round(app.CorteSlider.Value))));
               app.roi_map = roicolor(app.SUV_pt(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
            end
            %%
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: ROIlowEditField
        function ROIlowEditFieldValueChanged(app, event)
           app.roi_CT_selected_state = false;
           % 
           app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
           if app.SegmentadoCTButton.Value == 1
                app.roi_map = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoPETButton.Value == 1
                app.roi_map = roicolor(app.pt_volume(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoSUVButton.Value == 1
               app.roi_map = roicolor(app.SUV_pt(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           end
            %%
           draw_figs(app,app.CorteSlider.Value,1,1)
           lines_and_info(app,app.CorteSlider.Value)
            
        end

        % Value changed function: ROIhightEditField
        function ROIhightEditFieldValueChanged(app, event)
           app.roi_CT_selected_state = false;
           % 
           app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
           if app.SegmentadoCTButton.Value == 1
                app.roi_map = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoPETButton.Value == 1
                app.roi_map = roicolor(app.pt_volume(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoSUVButton.Value == 1
               app.roi_map = roicolor(app.SUV_pt(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           end
            %%
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: DilatarButton
        function DilatarButtonPushed(app, event)
            app.roi_CT_selected_state = false;
            % 
            estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
            app.roi_map = imdilate(app.roi_map,estruc);
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: ErosionarButton
        function ErosionarButtonPushed(app, event)
            app.roi_CT_selected_state = false;
            % 
            estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
            app.roi_map = imerode(app.roi_map,estruc);
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: DeteccindebordeDropDown
        function DeteccindebordeDropDownValueChanged(app, event)
            %value = app.DeteccindebordeDropDown.Value;
            app.roi_CT_selected_state = false;
            %
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: GuardarButton
        function GuardarButtonPushed(app, event)
           app.GuardarButton.Enable = "off";
            save_dir = fullfile(app.mod2DIR,'positronium_saved_fused_images');
            if ~exist(save_dir, 'dir')
               mkdir(save_dir);
               app.output = "[!] Directorio positronium_saved_fused_images no encontrado, creando directorio en " + convertCharsToStrings(app.mod2DIR) + newline + app.output;
               app.outputTextArea.Value = app.output;
            else
               app.output = "[OK] Directorio positronium_saved_fused_images encontrado en " + convertCharsToStrings(app.mod2DIR) + newline + app.output;
               app.outputTextArea.Value = app.output;
            end
            %app.files(app.imag_index)
            file_name = 'PT_CT_fused';%
            new_imag_dir = fullfile(save_dir,[file_name,'_',char(datetime('now','TimeZone','local','Format','d_MMM_y_HH_mm_ss_ms')),'.png']);
            if app.VerROICheckBox.double
                imwrite(uint8(app.roi_map).*app.fused, new_imag_dir);
            else
                imwrite(app.fused, new_imag_dir);
            end
            app.output = "[OK] Imagen guardada como: " + convertCharsToStrings(new_imag_dir) + newline + app.output;
            app.outputTextArea.Value = app.output;
            pause(1)
            app.GuardarButton.Enable = "on";
        end

        % Value changed function: WindowLevelEditField
        function WindowLevelEditFieldValueChanged(app, event)
            app.WL = round(app.WindowLevelEditField.Value);
            app.WindowLevelEditField.Value = round(app.WindowLevelEditField.Value);
            draw_figs(app,app.CorteSlider.Value,1,1)
            
        end

        % Value changed function: WindowWidthEditField
        function WindowWidthEditFieldValueChanged(app, event)
            app.WW = round(app.WindowWidthEditField.Value);
            app.WindowWidthEditField.Value = round(app.WindowWidthEditField.Value);
            draw_figs(app,app.CorteSlider.Value,1,1)
        end

        % Button pushed function: CerrarButton
        function CerrarButtonPushed(app, event)
            app.delete;
        end

        % Selection changed function: FWHMButtonGroup
        function FWHMButtonGroupSelectionChanged(app, event)
            %selectedButton = app.FWHMButtonGroup.SelectedObject;
            app.CorteSlider.Value = round(app.CorteSlider.Value);
            %app.app.CorteSlider.Value = round(value);
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: IniciarButton
        function IniciarButtonPushed(app, event)
            on_off_all(app,'off')
            pause(0.8)
            drawnow('limitrate')
            if app.fwhm_points_activated
                delete([app.fwhm_max_point,app.fwhm_points])
            end
            %%
            pause(0.5)
            app.output = "Calculando FWHM." +newline+app.output;
            app.outputTextArea.Value = app.output;
            drawnow('limitrate')
            
            if app.PuntualCheckBox.Value
                %%
                % localizamos los valores máximos FWHM
                x = app.pt_crosshair_x;
                y = app.pt_crosshair_y;
                z = app.CorteSlider.Value;
                %ancho = app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1;
                %altura = app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1;
                tam = size(app.SUV_pt);
                vec_z = ((0:tam(3)-1)-z)*app.ct_info.SliceThickness/10;
                vec_x = ((0:tam(2)-1)-x)*app.pt_info.PixelSpacing(1)/10;
                vec_y = ((0:tam(1)-1)-y)*app.pt_info.PixelSpacing(2)/10;
                [~,closestIndex_z_left]  = min(abs(vec_z+app.RadiocmEditField.Value));
                [~,closestIndex_z_right] = min(abs(vec_z-app.RadiocmEditField.Value));
                [~,closestIndex_x_left]  = min(abs(vec_x+app.RadiocmEditField.Value));
                [~,closestIndex_x_right] = min(abs(vec_x-app.RadiocmEditField.Value));
                [~,closestIndex_y_left]  = min(abs(vec_y+app.RadiocmEditField.Value));
                [~,closestIndex_y_right] = min(abs(vec_y-app.RadiocmEditField.Value));
    
                [~,maxFWHM_loc_z] = findpeaks(app.fwhm_vec_z(closestIndex_z_left:closestIndex_z_right),1:length(vec_z(closestIndex_z_left:closestIndex_z_right)), 'MinPeakHeight',app.UmbralEditField.Value, 'MinPeakDistance',app.RadiocmEditField.Value);
                [~,maxFWHM_loc_x] = findpeaks(app.fwhm_vec_x(closestIndex_x_left:closestIndex_x_right),1:length(vec_x(closestIndex_x_left:closestIndex_x_right)), 'MinPeakHeight',app.UmbralEditField.Value, 'MinPeakDistance',app.RadiocmEditField.Value);
                [~,maxFWHM_loc_y] = findpeaks(app.fwhm_vec_y(closestIndex_y_left:closestIndex_y_right),1:length(vec_y(closestIndex_y_left:closestIndex_y_right)), 'MinPeakHeight',app.UmbralEditField.Value, 'MinPeakDistance',app.RadiocmEditField.Value);
                FMWH = 50/100;            
                if not(isempty(maxFWHM_loc_z))&& not(isempty(maxFWHM_loc_x)) && not(isempty(maxFWHM_loc_y))
                    loc_z = maxFWHM_loc_z+closestIndex_z_left-1;
                    loc_x = maxFWHM_loc_x+closestIndex_x_left-1;
                    loc_y = maxFWHM_loc_y+closestIndex_y_left-1;
                    %
                    pause(0.5)
                    app.output = "FWHM locs z: "+convertCharsToStrings(int2str(loc_z))+newline+app.output; 
                    app.outputTextArea.Value = app.output;
                    app.output = "FWHM locs x: "+convertCharsToStrings(int2str(loc_x))+newline+app.output; 
                    app.outputTextArea.Value = app.output;
                    app.output = "FWHM locs y: "+convertCharsToStrings(int2str(loc_y))+newline+app.output; 
                    app.outputTextArea.Value = app.output;
                    drawnow('limitrate')
                    %
                    if length(maxFWHM_loc_z) > 1 || length(maxFWHM_loc_x) > 1 || length(maxFWHM_loc_y) > 1
                        pause(0.2)
                        app.output = "[X] FWHM locs excede más de 1 elemento." +newline+app.output;
                        app.outputTextArea.Value = app.output;
                        drawnow('limitrate')
                        app.fwhm_points_activated = false;
                    else 
                        index_left1_right2_z = zeros(2,1);
                        index_left1_right2_x = zeros(2,1);
                        index_left1_right2_y = zeros(2,1);
                        %
                        halfMaxValue_z = app.fwhm_vec_z(loc_z)*FMWH;
                        index_left1_right2_z(1) = find(app.fwhm_vec_z(closestIndex_z_left:closestIndex_z_right) >= halfMaxValue_z, 1, 'first');
                        index_left1_right2_z(2) = find(app.fwhm_vec_z(closestIndex_z_left:closestIndex_z_right) >= halfMaxValue_z, 1, 'last');
                        index_left1_right2_z = index_left1_right2_z + closestIndex_z_left - 1;
                        %
                        halfMaxValue_x = app.fwhm_vec_x(loc_x)*FMWH;
                        index_left1_right2_x(1) = find(app.fwhm_vec_x(closestIndex_x_left:closestIndex_x_right) >= halfMaxValue_x, 1, 'first');
                        index_left1_right2_x(2) = find(app.fwhm_vec_x(closestIndex_x_left:closestIndex_x_right) >= halfMaxValue_x, 1, 'last');
                        index_left1_right2_x = index_left1_right2_x + closestIndex_x_left - 1;
                        %
                        halfMaxValue_y = app.fwhm_vec_y(loc_y)*FMWH;
                        index_left1_right2_y(1) = find(app.fwhm_vec_y(closestIndex_y_left:closestIndex_y_right) >= halfMaxValue_y, 1, 'first');
                        index_left1_right2_y(2) = find(app.fwhm_vec_y(closestIndex_y_left:closestIndex_y_right) >= halfMaxValue_y, 1, 'last');
                        index_left1_right2_y = index_left1_right2_y + closestIndex_y_left - 1;
                        %
                        d_z = vec_z(index_left1_right2_z(2))-vec_z(index_left1_right2_z(1));
                        d_x = vec_x(index_left1_right2_x(2))-vec_x(index_left1_right2_x(1));
                        d_y = vec_y(index_left1_right2_y(2))-vec_y(index_left1_right2_y(1));
                        pause(0.5)
                        app.output = "FWHM z: "+convertCharsToStrings(num2str(d_z))+"cm"+newline+app.output; 
                        app.outputTextArea.Value = app.output;
                        app.output = "FWHM x: "+convertCharsToStrings(num2str(d_x))+"cm"+newline+app.output; 
                        app.outputTextArea.Value = app.output;
                        app.output = "FWHM y: "+convertCharsToStrings(num2str(d_y))+"cm"+newline+app.output; 
                        app.outputTextArea.Value = app.output;
                        pause(1)
                        app.output = "[OK] Tarea terminada."+newline+app.output; 
                        app.outputTextArea.Value = app.output;
                        drawnow('limitrate')
                        %
                        app.fwhm_max_point(1) = scatter(app.UIAxes5,vec_z(loc_z),app.fwhm_vec_z(loc_z),"Color",'b');
                        app.fwhm_max_point(2) = scatter(app.UIAxes5,vec_x(loc_x),app.fwhm_vec_x(loc_x),"Color",'g');
                        app.fwhm_max_point(3) = scatter(app.UIAxes5,vec_y(loc_y),app.fwhm_vec_y(loc_y),"Color",'r');
                        %
                        app.fwhm_points(1) = scatter(app.UIAxes5,vec_z(index_left1_right2_z),app.fwhm_vec_z(index_left1_right2_z),"Color",'b');
                        app.fwhm_points(2) = scatter(app.UIAxes5,vec_x(index_left1_right2_x),app.fwhm_vec_x(index_left1_right2_x),"Color",'g');
                        app.fwhm_points(3) = scatter(app.UIAxes5,vec_y(index_left1_right2_y),app.fwhm_vec_y(index_left1_right2_y),"Color",'r');
                        app.fwhm_points_activated = true;
                    end
                else
                    pause(0.2)
                    app.output = "[X] No fue posible realizar el cálculo. Vector vacío." +newline+app.output;
                    app.outputTextArea.Value = app.output;
                    drawnow('limitrate')
                    app.fwhm_points_activated = false;
                end
            elseif app.NumricoCheckBox.Value
                if length(app.fwhm_vec_z)>=5 && length(app.fwhm_vec_x)>=5 && length(app.fwhm_vec_y)>=5
                    x = app.pt_crosshair_x;
                    y = app.pt_crosshair_y;
                    z = app.CorteSlider.Value;
                    %ancho = app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1;
                    %altura = app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1;
                    tam = size(app.SUV_pt);
                    vec_z = ((0:tam(3)-1)-z)*app.ct_info.SliceThickness/10;
                    vec_x = ((0:tam(2)-1)-x)*app.pt_info.PixelSpacing(1)/10;
                    vec_y = ((0:tam(1)-1)-y)*app.pt_info.PixelSpacing(2)/10;
                    [~,closestIndex_z_left]  = min(abs(vec_z+app.RadiocmEditField.Value));
                    [~,closestIndex_z_right] = min(abs(vec_z-app.RadiocmEditField.Value));
                    [~,closestIndex_x_left]  = min(abs(vec_x+app.RadiocmEditField.Value));
                    [~,closestIndex_x_right] = min(abs(vec_x-app.RadiocmEditField.Value));
                    [~,closestIndex_y_left]  = min(abs(vec_y+app.RadiocmEditField.Value));
                    [~,closestIndex_y_right] = min(abs(vec_y-app.RadiocmEditField.Value));
                    %modelo_ajuste = "a + (b-a)*exp(-log(2)*(power(4*(x-c)*(x-c)/(d*d),e)))";
                    modelo_ajuste = "a + (b-a)*exp(-(x-c)*(x-c)/(2*d*d))";
                    %x_data_Z = vec_z(closestIndex_z_left:closestIndex_z_right)';
                    %x_data_X = vec_x(closestIndex_x_left:closestIndex_x_right)';
                    %x_data_Y = vec_y(closestIndex_y_left:closestIndex_y_right)';
                    x_data_Z = ((1:length(vec_z(closestIndex_z_left:closestIndex_z_right)))'-1);
                    x_data_X = ((1:length(vec_x(closestIndex_x_left:closestIndex_x_right)))'-1);
                    x_data_Y = ((1:length(vec_y(closestIndex_y_left:closestIndex_y_right)))'-1);
                    
                    y_data_Z = app.fwhm_vec_z(closestIndex_z_left:closestIndex_z_right)';
                    y_data_X = app.fwhm_vec_x(closestIndex_x_left:closestIndex_x_right)';
                    y_data_Y = app.fwhm_vec_y(closestIndex_y_left:closestIndex_y_right)';
                    %StartPoints_z = [min(y_data_Z) max(y_data_Z) length(y_data_Z)/2 sqrt(std(y_data_Z/mean(y_data_Z))) 2];
                    %StartPoints_x = [min(y_data_X) max(y_data_X) length(y_data_X)/2 sqrt(std(y_data_X/mean(y_data_X))) 2];
                    %StartPoints_y = [min(y_data_Y) max(y_data_Y) length(y_data_Y)/2 sqrt(std(y_data_Y/mean(y_data_Y))) 2];
                    StartPoints_z = [min(y_data_Z) max(y_data_Z) length(y_data_Z)/2 sqrt(std(y_data_Z/mean(y_data_Z)))];
                    StartPoints_x = [min(y_data_X) max(y_data_X) length(y_data_X)/2 sqrt(std(y_data_X/mean(y_data_X)))];
                    StartPoints_y = [min(y_data_Y) max(y_data_Y) length(y_data_Y)/2 sqrt(std(y_data_Y/mean(y_data_Y)))];
                    f_z = fit(x_data_Z,y_data_Z,modelo_ajuste,"StartPoint",StartPoints_z,'Normalize','off');
                    f_x = fit(x_data_X,y_data_X,modelo_ajuste,"StartPoint",StartPoints_x,'Normalize','off');
                    f_y = fit(x_data_Y,y_data_Y,modelo_ajuste,"StartPoint",StartPoints_y,'Normalize','off');
                    %% eliminamos algunos elementos gráficos
                    delete(app.axial_plot)
                    num_ponints = 2000;
                    linsZ = linspace(vec_z(closestIndex_z_left),vec_z(closestIndex_z_right),num_ponints);
                    linsX = linspace(vec_x(closestIndex_x_left),vec_x(closestIndex_x_right),num_ponints);
                    linsY = linspace(vec_y(closestIndex_y_left),vec_y(closestIndex_y_right),num_ponints);
                    app.axial_plot(1) = plot(app.UIAxes5,linsZ,f_z(linspace(x_data_Z(1),x_data_Z(end),num_ponints)),'Color','b');
                    app.axial_plot(2) = plot(app.UIAxes5,linsX,f_x(linspace(x_data_X(1),x_data_X(end),num_ponints)),'Color','g');
                    app.axial_plot(3) = plot(app.UIAxes5,linsY,f_y(linspace(x_data_Y(1),x_data_Y(end),num_ponints)),'Color','r');
                    
                    app.fwhm_points(1) = plot(app.UIAxes5,vec_z(closestIndex_z_left:closestIndex_z_right),y_data_Z,"Color",'b',"LineStyle","none",'Marker','.');
                    app.fwhm_points(2) = plot(app.UIAxes5,vec_x(closestIndex_x_left:closestIndex_x_right),y_data_X,"Color",'g',"LineStyle","none",'Marker','.');
                    app.fwhm_points(3) = plot(app.UIAxes5,vec_y(closestIndex_y_left:closestIndex_y_right),y_data_Y,"Color",'r',"LineStyle","none",'Marker','.');
                    %%
                    sigma = sqrt(8*log(2));
                    FWHM_z = f_z.d*sigma*app.pt_info.SliceThickness/10;
                    FWHM_x = f_x.d*sigma*app.pt_info.PixelSpacing(1)/10;
                    FWHM_y = f_y.d*sigma*app.pt_info.PixelSpacing(2)/10;
                    [max_z,maxFWHM_loc_z] = max(f_z(linspace(x_data_Z(1),x_data_Z(end),num_ponints)));
                    [max_x,maxFWHM_loc_x] = max(f_x(linspace(x_data_X(1),x_data_X(end),num_ponints)));
                    [max_y,maxFWHM_loc_y] = max(f_y(linspace(x_data_Y(1),x_data_Y(end),num_ponints)));

                    app.fwhm_max_point(1) = line(app.UIAxes5,[linsZ(maxFWHM_loc_z)-FWHM_z/2, linsZ(maxFWHM_loc_z)+FWHM_z/2],[max_z/2 max_z/2],'color','b');
                    app.fwhm_max_point(2) = line(app.UIAxes5,[linsX(maxFWHM_loc_x)-FWHM_x/2, linsX(maxFWHM_loc_x)+FWHM_x/2],[max_x/2 max_x/2],'color','g');
                    app.fwhm_max_point(3) = line(app.UIAxes5,[linsY(maxFWHM_loc_y)-FWHM_y/2, linsY(maxFWHM_loc_y)+FWHM_y/2],[max_y/2 max_y/2],'color','r');
                    %%
                    pause(0.5)
                    
                    app.output = "FWHM z: "+convertCharsToStrings(num2str(FWHM_z*10))+"mm"+newline+app.output; 
                    app.outputTextArea.Value = app.output;
                    app.output = "FWHM x: "+convertCharsToStrings(num2str(FWHM_x*10))+"mm"+newline+app.output; 
                    app.outputTextArea.Value = app.output;
                    app.output = "FWHM y: "+convertCharsToStrings(num2str(FWHM_y*10))+"mm"+newline+app.output; 
                    app.outputTextArea.Value = app.output;
                    %%
                    pause(1)
                    app.output = "[OK] Tarea terminada."+newline+app.output; 
                    app.outputTextArea.Value = app.output;
                    drawnow('limitrate')
                    app.fwhm_points_activated = true;
                else
                    pause(0.2)
                    app.output = "[X] No fue posible realizar el cálculo. Datos insufcientes." +newline+app.output;
                    app.outputTextArea.Value = app.output;
                    drawnow('limitrate')
                    app.fwhm_points_activated = false;
                end
                    % definimos el modelo 
                    
            end
            if app.GxlsxCheckBox.Value && app.NumricoCheckBox.Value
                r = app.RadioEditField.Value;
                serie = replace(replace(app.pt_info.SeriesDescription, '/', '_'), ' ', '_');
                if app.PromedioButton.Value
                    operacion = 'mean';
                    nombre_mat_file = ['fwhm_',operacion,'_', '_r',sprintf('%03d', r),'_x',sprintf('%03d', x),'_y',sprintf('%03d', y),'z_',sprintf('%03d', z),'_',serie];
                elseif app.MximoButton.Value
                    operacion = 'maxi';
                    nombre_mat_file = ['fwhm_',operacion,'_', '_r',sprintf('%03d', r),'_x',sprintf('%03d', x),'_y',sprintf('%03d', y),'z_',sprintf('%03d', z),'_',serie];
                elseif app.PuntualButton.Value
                    operacion = 'punt';
                    %r = 'N';
                    nombre_mat_file = ['fwhm_',operacion,'_', '_rN','_x',sprintf('%03d', x),'_y',sprintf('%03d', y),'z_',sprintf('%03d', z),'_',serie];
                end


                PET_info = app.pt_info;
                save(nombre_mat_file,'x','y','z','nombre_mat_file',...
                    'x_data_Z','x_data_X','x_data_Y',...
                    'y_data_Z','y_data_X','y_data_Y',...
                    'f_z','f_x','f_y','PET_info','linsZ','linsX','linsY');
                app.output = "[!] Archivo MAT guardado." +newline+app.output;
                app.outputTextArea.Value = app.output;
            end
            %app.axial_plot = plot(app.UIAxes5,1:app.cortes,app.fwhm_vec,"Color",'b',"LineWidth",1,"LineStyle","-");
            on_off_all(app,'on')
        end

        % Value changed function: RadiocmEditField
        function RadiocmEditFieldValueChanged(app, event)
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
            
        end

        % Value changed function: RadioEditField
        function RadioEditFieldValueChanged(app, event)
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
            
        end

        % Button pushed function: Button_5
        function Button_5Pushed(app, event)
            posicion = -1 + app.CorteSlider.Value;
            if posicion<1
                app.CorteSlider.Value = 1;
            elseif posicion>app.cortes
                app.nCorteEditField.Value = app.cortes;
                app.CorteSlider.Value = app.cortes;
            else
                app.nCorteEditField.Value = posicion;
                app.CorteSlider.Value = posicion;
            end
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)

        end

        % Button pushed function: Button_6
        function Button_6Pushed(app, event)
            posicion = 1 + app.CorteSlider.Value;
            if posicion<1
                app.CorteSlider.Value = 1;
            elseif posicion>app.cortes
                app.nCorteEditField.Value = app.cortes;
                app.CorteSlider.Value = app.cortes;
            else
                app.nCorteEditField.Value = posicion;
                app.CorteSlider.Value = posicion;
            end
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            %P = get(app.UIAxes2,'CurrentPoint'); 
            %app.pt_crosshair_x = round(P(1,1)); 
            app.pt_crosshair_y = app.pt_crosshair_y + 1;
            %ancho = app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1;
            altura = app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1;
            %if app.pt_crosshair_x > ancho
            %    app.pt_crosshair_x = ancho;
            %elseif app.pt_crosshair_x<1
            %    app.pt_crosshair_x = 1;
            %end
            if app.pt_crosshair_y > altura
                app.pt_crosshair_y = altura;
            elseif app.pt_crosshair_y<1
                app.pt_crosshair_y = 1;
            end 
            %draw_figs(app,app.CorteSlider.Value)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            %P = get(app.UIAxes2,'CurrentPoint'); 
            app.pt_crosshair_x = app.pt_crosshair_x + 1; 
            %app.pt_crosshair_y = app.pt_crosshair_y + 1;
            ancho = app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1;
            %altura = app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1;
            if app.pt_crosshair_x > ancho
                app.pt_crosshair_x = ancho;
            elseif app.pt_crosshair_x<1
                app.pt_crosshair_x = 1;
            end
            %if app.pt_crosshair_y > altura
            %    app.pt_crosshair_y = altura;
            %elseif app.pt_crosshair_y<1
            %    app.pt_crosshair_y = 1;
            %end 
            %draw_figs(app,app.CorteSlider.Value)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
            %P = get(app.UIAxes2,'CurrentPoint'); 
            app.pt_crosshair_x = app.pt_crosshair_x - 1; 
            %app.pt_crosshair_y = app.pt_crosshair_y + 1;
            ancho = app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1;
            %altura = app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1;
            if app.pt_crosshair_x > ancho
                app.pt_crosshair_x = ancho;
            elseif app.pt_crosshair_x<1
                app.pt_crosshair_x = 1;
            end
            %if app.pt_crosshair_y > altura
            %    app.pt_crosshair_y = altura;
            %elseif app.pt_crosshair_y<1
            %    app.pt_crosshair_y = 1;
            %end 
            %draw_figs(app,app.CorteSlider.Value)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: Button_4
        function Button_4Pushed(app, event)
            %P = get(app.UIAxes2,'CurrentPoint'); 
            %app.pt_crosshair_x = round(P(1,1)); 
            app.pt_crosshair_y = app.pt_crosshair_y - 1;
            %ancho = app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1;
            altura = app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1;
            %if app.pt_crosshair_x > ancho
            %    app.pt_crosshair_x = ancho;
            %elseif app.pt_crosshair_x<1
            %    app.pt_crosshair_x = 1;
            %end
            if app.pt_crosshair_y > altura
                app.pt_crosshair_y = altura;
            elseif app.pt_crosshair_y<1
                app.pt_crosshair_y = 1;
            end 
            %draw_figs(app,app.CorteSlider.Value)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: PuntualCheckBox
        function PuntualCheckBoxValueChanged(app, event)
            if app.PuntualCheckBox.Value
                app.NumricoCheckBox.Value = 0;
                % activamos componentes
                %app.RadioEditField.Enable = "on";
                app.UmbralEditField.Enable = "on";
            else
                app.NumricoCheckBox.Value = 1;
                %app.RadioEditField.Enable = "off";
                app.UmbralEditField.Enable = "off";
            end
            
        end

        % Value changed function: NumricoCheckBox
        function NumricoCheckBoxValueChanged(app, event)
            %value = app.NumricoCheckBox.Value;
            if app.NumricoCheckBox.Value
                app.PuntualCheckBox.Value = 0;
                % activamos componentes
                %app.RadioEditField.Enable = "off";
                app.UmbralEditField.Enable = "off";
            else
                app.PuntualCheckBox.Value = 1;
                app.RadioEditField.Enable = "on";
                app.UmbralEditField.Enable = "on";
            end
        end

        % Value changed function: AjustarejeCheckBox
        function AjustarejeCheckBoxValueChanged(app, event)
            %value = app.AjustarejeCheckBox.Value;
            if app.AjustarejeCheckBox.Value
                xlim(app.UIAxes5, [-app.RadiocmEditField.Value app.RadiocmEditField.Value])
            else
                xlim(app.UIAxes5, [app.min_x_axis app.max_x_axis])
            end
        end

        % Button pushed function: RefrescarButton
        function RefrescarButtonPushed(app, event)
            app.CorteSlider.Value = round(app.CorteSlider.Value);
            %app.app.CorteSlider.Value = round(value);
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: flipvolButton
        function flipvolButtonPushed(app, event)
            app.SUV_pt = flip(app.SUV_pt,3);
            app.SUV_ptu = flip(app.SUV_ptu,3);
            app.pt_volume = flip(app.pt_volume,3);
            app.ptu_volume = flip(app.ptu_volume,3);
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create PositroniumdotMATMododetomografaUIFigure and hide until all components are created
            app.PositroniumdotMATMododetomografaUIFigure = uifigure('Visible', 'off');
            app.PositroniumdotMATMododetomografaUIFigure.Position = [100 100 1349 718];
            app.PositroniumdotMATMododetomografaUIFigure.Name = 'Positronium dot MAT - Modo de tomografía';
            app.PositroniumdotMATMododetomografaUIFigure.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');
            app.PositroniumdotMATMododetomografaUIFigure.Resize = 'off';
            app.PositroniumdotMATMododetomografaUIFigure.WindowScrollWheelFcn = createCallbackFcn(app, @PositroniumdotMATMododetomografaUIFigureWindowScrollWheel, true);

            % Create UIAxes
            app.UIAxes = uiaxes(app.PositroniumdotMATMododetomografaUIFigure);
            title(app.UIAxes, 'CT')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Toolbar.Visible = 'off';
            app.UIAxes.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes.XTick = [];
            app.UIAxes.YTick = [];
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [21 328 366 366];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.PositroniumdotMATMododetomografaUIFigure);
            title(app.UIAxes2, 'PET/SUV')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes2.XTick = [];
            app.UIAxes2.YTick = [];
            app.UIAxes2.ButtonDownFcn = createCallbackFcn(app, @UIAxes2ButtonDown, true);
            app.UIAxes2.Position = [386 328 366 366];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.PositroniumdotMATMododetomografaUIFigure);
            title(app.UIAxes3, 'Fusión PET/CT')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes3.XTick = [];
            app.UIAxes3.YTick = [];
            app.UIAxes3.ButtonDownFcn = createCallbackFcn(app, @UIAxes3ButtonDown, true);
            app.UIAxes3.Position = [767 152 564 564];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.PositroniumdotMATMododetomografaUIFigure);
            title(app.UIAxes4, 'Topograma')
            zlabel(app.UIAxes4, 'Z')
            app.UIAxes4.Toolbar.Visible = 'off';
            app.UIAxes4.DataAspectRatio = [4 10 1];
            app.UIAxes4.XTick = [];
            app.UIAxes4.YTick = [];
            app.UIAxes4.Position = [13 187 258 133];

            % Create UIAxes5
            app.UIAxes5 = uiaxes(app.PositroniumdotMATMododetomografaUIFigure);
            title(app.UIAxes5, 'FWHM total')
            xlabel(app.UIAxes5, 'Corte (cm)')
            ylabel(app.UIAxes5, 'A_c [Bq/ml]')
            zlabel(app.UIAxes5, 'Z')
            app.UIAxes5.Layer = 'top';
            app.UIAxes5.GridLineWidth = 0.1;
            app.UIAxes5.GridColor = [0 0.4471 0.7412];
            app.UIAxes5.XGrid = 'on';
            app.UIAxes5.YGrid = 'on';
            app.UIAxes5.FontSize = 8;
            app.UIAxes5.Position = [7 16 264 169];

            % Create CorrerButton
            app.CorrerButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.CorrerButton.ButtonPushedFcn = createCallbackFcn(app, @CorrerButtonPushed, true);
            app.CorrerButton.Icon = fullfile(pathToMLAPP, 'ico', 'run.png');
            app.CorrerButton.Position = [505 16 100 23];
            app.CorrerButton.Text = 'Correr';

            % Create outputTextArea
            app.outputTextArea = uitextarea(app.PositroniumdotMATMododetomografaUIFigure);
            app.outputTextArea.FontSize = 10;
            app.outputTextArea.FontColor = [0 1 0];
            app.outputTextArea.BackgroundColor = [0 0 0];
            app.outputTextArea.Position = [1073 16 258 121];

            % Create DDMMAAAAalasHHMMSSLabel
            app.DDMMAAAAalasHHMMSSLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.DDMMAAAAalasHHMMSSLabel.HandleVisibility = 'off';
            app.DDMMAAAAalasHHMMSSLabel.FontWeight = 'bold';
            app.DDMMAAAAalasHHMMSSLabel.FontColor = [1 0 0];
            app.DDMMAAAAalasHHMMSSLabel.Visible = 'off';
            app.DDMMAAAAalasHHMMSSLabel.Position = [399 331 199 22];
            app.DDMMAAAAalasHHMMSSLabel.Text = 'DD/MM/AAAA a las HH:MM:SS.';

            % Create UncorrectedPETCheckBox
            app.UncorrectedPETCheckBox = uicheckbox(app.PositroniumdotMATMododetomografaUIFigure);
            app.UncorrectedPETCheckBox.ValueChangedFcn = createCallbackFcn(app, @UncorrectedPETCheckBoxValueChanged, true);
            app.UncorrectedPETCheckBox.Enable = 'off';
            app.UncorrectedPETCheckBox.Text = 'Uncorrected PET';
            app.UncorrectedPETCheckBox.Position = [484 298 114 22];

            % Create AlphaCTSliderLabel
            app.AlphaCTSliderLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.AlphaCTSliderLabel.HorizontalAlignment = 'right';
            app.AlphaCTSliderLabel.FontSize = 10;
            app.AlphaCTSliderLabel.Position = [935 117 47 22];
            app.AlphaCTSliderLabel.Text = 'Alpha CT';

            % Create AlphaCTSlider
            app.AlphaCTSlider = uislider(app.PositroniumdotMATMododetomografaUIFigure);
            app.AlphaCTSlider.Limits = [0 1];
            app.AlphaCTSlider.ValueChangedFcn = createCallbackFcn(app, @AlphaCTSliderValueChanged, true);
            app.AlphaCTSlider.FontSize = 9;
            app.AlphaCTSlider.Enable = 'off';
            app.AlphaCTSlider.Position = [935 111 119 3];
            app.AlphaCTSlider.Value = 0.5;

            % Create AlphaPETSliderLabel
            app.AlphaPETSliderLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.AlphaPETSliderLabel.HorizontalAlignment = 'right';
            app.AlphaPETSliderLabel.FontSize = 10;
            app.AlphaPETSliderLabel.Position = [929 50 53 22];
            app.AlphaPETSliderLabel.Text = 'Alpha PET';

            % Create AlphaPETSlider
            app.AlphaPETSlider = uislider(app.PositroniumdotMATMododetomografaUIFigure);
            app.AlphaPETSlider.Limits = [0 1];
            app.AlphaPETSlider.ValueChangedFcn = createCallbackFcn(app, @AlphaPETSliderValueChanged, true);
            app.AlphaPETSlider.FontSize = 9;
            app.AlphaPETSlider.Enable = 'off';
            app.AlphaPETSlider.Position = [937 42 116 3];
            app.AlphaPETSlider.Value = 0.5;

            % Create CorteSliderLabel
            app.CorteSliderLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.CorteSliderLabel.HorizontalAlignment = 'right';
            app.CorteSliderLabel.Position = [500 92 34 22];
            app.CorteSliderLabel.Text = 'Corte';

            % Create CorteSlider
            app.CorteSlider = uislider(app.PositroniumdotMATMododetomografaUIFigure);
            app.CorteSlider.Limits = [1 97];
            app.CorteSlider.ValueChangedFcn = createCallbackFcn(app, @CorteSliderValueChanged, true);
            app.CorteSlider.FontSize = 10;
            app.CorteSlider.Enable = 'off';
            app.CorteSlider.Position = [506 80 264 3];
            app.CorteSlider.Value = 1;

            % Create SUV0000Label
            app.SUV0000Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.SUV0000Label.FontWeight = 'bold';
            app.SUV0000Label.FontColor = [1 0 0];
            app.SUV0000Label.Visible = 'off';
            app.SUV0000Label.Position = [399 609 94 22];
            app.SUV0000Label.Text = 'SUV = 0.000';

            % Create XXXYYYLabel
            app.XXXYYYLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.XXXYYYLabel.HorizontalAlignment = 'right';
            app.XXXYYYLabel.FontWeight = 'bold';
            app.XXXYYYLabel.FontColor = [1 0 0];
            app.XXXYYYLabel.Visible = 'off';
            app.XXXYYYLabel.Position = [671 651 64 22];
            app.XXXYYYLabel.Text = '(XXX,YYY)';

            % Create XXXXXXLabel
            app.XXXXXXLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.XXXXXXLabel.HorizontalAlignment = 'right';
            app.XXXXXXLabel.FontWeight = 'bold';
            app.XXXXXXLabel.FontColor = [1 0 0];
            app.XXXXXXLabel.Visible = 'off';
            app.XXXXXXLabel.Position = [674 630 61 22];
            app.XXXXXXLabel.Text = '(XXXXXX)';

            % Create XX1YY1Label
            app.XX1YY1Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.XX1YY1Label.FontColor = [0 1 1];
            app.XX1YY1Label.Visible = 'off';
            app.XX1YY1Label.Position = [40 331 75 22];
            app.XX1YY1Label.Text = '(XX1,YY1)';

            % Create XX2YY2Label
            app.XX2YY2Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.XX2YY2Label.HorizontalAlignment = 'right';
            app.XX2YY2Label.FontColor = [0 1 0];
            app.XX2YY2Label.Visible = 'off';
            app.XX2YY2Label.Position = [293 331 75 22];
            app.XX2YY2Label.Text = '(XX2,YY2)';

            % Create DistanciaLabel
            app.DistanciaLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.DistanciaLabel.HorizontalAlignment = 'center';
            app.DistanciaLabel.FontColor = [1 1 0];
            app.DistanciaLabel.Visible = 'off';
            app.DistanciaLabel.Position = [101 331 206 22];
            app.DistanciaLabel.Text = 'Distancia';

            % Create SeleccindeROIButtonGroup
            app.SeleccindeROIButtonGroup = uibuttongroup(app.PositroniumdotMATMododetomografaUIFigure);
            app.SeleccindeROIButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @SeleccindeROIButtonGroupSelectionChanged, true);
            app.SeleccindeROIButtonGroup.Enable = 'off';
            app.SeleccindeROIButtonGroup.Title = 'Selección de ROI';
            app.SeleccindeROIButtonGroup.FontSize = 10;
            app.SeleccindeROIButtonGroup.Position = [287 184 191 133];

            % Create NingunaButton
            app.NingunaButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.NingunaButton.Text = 'Ninguna';
            app.NingunaButton.FontSize = 10;
            app.NingunaButton.Position = [11 90 59 22];
            app.NingunaButton.Value = true;

            % Create CircularButton
            app.CircularButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.CircularButton.Text = 'Circular';
            app.CircularButton.FontSize = 10;
            app.CircularButton.Position = [11 68 65 22];

            % Create RectangularButton
            app.RectangularButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.RectangularButton.Text = 'Rectangular';
            app.RectangularButton.FontSize = 10;
            app.RectangularButton.Position = [81 68 76 22];

            % Create SegmentadoCTButton
            app.SegmentadoCTButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoCTButton.Text = 'Segmentado (CT)';
            app.SegmentadoCTButton.FontSize = 10;
            app.SegmentadoCTButton.Position = [11 47 101 22];

            % Create SegmentadoPETButton
            app.SegmentadoPETButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoPETButton.Text = 'Segmentado (PET)';
            app.SegmentadoPETButton.FontSize = 10;
            app.SegmentadoPETButton.Position = [11 25 108 22];

            % Create SegmentadoSUVButton
            app.SegmentadoSUVButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoSUVButton.Text = 'Segmentado (SUV)';
            app.SegmentadoSUVButton.FontSize = 10;
            app.SegmentadoSUVButton.Position = [11 3 109 22];

            % Create FX1FY1Label
            app.FX1FY1Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.FX1FY1Label.FontColor = [0 1 1];
            app.FX1FY1Label.Visible = 'off';
            app.FX1FY1Label.Position = [782 184 70 22];
            app.FX1FY1Label.Text = '(FX1,FY1)';

            % Create FX2FY2Label
            app.FX2FY2Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.FX2FY2Label.HorizontalAlignment = 'right';
            app.FX2FY2Label.FontColor = [0 1 0];
            app.FX2FY2Label.Visible = 'off';
            app.FX2FY2Label.Position = [1190 184 70 22];
            app.FX2FY2Label.Text = '(FX2,FY2)';

            % Create SUVMEANLabel
            app.SUVMEANLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.SUVMEANLabel.HorizontalAlignment = 'center';
            app.SUVMEANLabel.FontColor = [1 1 0];
            app.SUVMEANLabel.Visible = 'off';
            app.SUVMEANLabel.Position = [871 184 156 22];
            app.SUVMEANLabel.Text = 'SUV MEAN';

            % Create VisualizacinButtonGroup
            app.VisualizacinButtonGroup = uibuttongroup(app.PositroniumdotMATMododetomografaUIFigure);
            app.VisualizacinButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @VisualizacinButtonGroupSelectionChanged, true);
            app.VisualizacinButtonGroup.Enable = 'off';
            app.VisualizacinButtonGroup.Title = 'Visualización';
            app.VisualizacinButtonGroup.FontSize = 10;
            app.VisualizacinButtonGroup.Position = [287 130 191 50];

            % Create PETPETuButton
            app.PETPETuButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.PETPETuButton.Text = 'PET/PETu';
            app.PETPETuButton.Position = [11 7 78 22];
            app.PETPETuButton.Value = true;

            % Create SUVButton
            app.SUVButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.SUVButton.Text = 'SUV';
            app.SUVButton.Position = [88 7 65 22];

            % Create ROIButton
            app.ROIButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.ROIButton.Text = 'ROI';
            app.ROIButton.Position = [138 7 43 22];

            % Create VerROICheckBox
            app.VerROICheckBox = uicheckbox(app.PositroniumdotMATMododetomografaUIFigure);
            app.VerROICheckBox.ValueChangedFcn = createCallbackFcn(app, @VerROICheckBoxValueChanged, true);
            app.VerROICheckBox.Enable = 'off';
            app.VerROICheckBox.Text = 'Ver ROI';
            app.VerROICheckBox.Position = [670 298 65 22];

            % Create OpmofolgicaDropDownLabel
            app.OpmofolgicaDropDownLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.OpmofolgicaDropDownLabel.HorizontalAlignment = 'right';
            app.OpmofolgicaDropDownLabel.Position = [492 184 86 22];
            app.OpmofolgicaDropDownLabel.Text = 'Op. mofológica';

            % Create OpmofolgicaDropDown
            app.OpmofolgicaDropDown = uidropdown(app.PositroniumdotMATMododetomografaUIFigure);
            app.OpmofolgicaDropDown.Items = {'disk', 'diamond', 'square'};
            app.OpmofolgicaDropDown.ItemsData = [1 2 3 4];
            app.OpmofolgicaDropDown.Enable = 'off';
            app.OpmofolgicaDropDown.Position = [492 156 140 22];
            app.OpmofolgicaDropDown.Value = 1;

            % Create ROIlowEditFieldLabel
            app.ROIlowEditFieldLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.ROIlowEditFieldLabel.HorizontalAlignment = 'right';
            app.ROIlowEditFieldLabel.Position = [484 238 48 22];
            app.ROIlowEditFieldLabel.Text = 'ROI low';

            % Create ROIlowEditField
            app.ROIlowEditField = uieditfield(app.PositroniumdotMATMododetomografaUIFigure, 'numeric');
            app.ROIlowEditField.ValueChangedFcn = createCallbackFcn(app, @ROIlowEditFieldValueChanged, true);
            app.ROIlowEditField.Enable = 'off';
            app.ROIlowEditField.Position = [549 238 63 22];

            % Create ROIhightEditFieldLabel
            app.ROIhightEditFieldLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.ROIhightEditFieldLabel.HorizontalAlignment = 'right';
            app.ROIhightEditFieldLabel.Position = [484 268 56 22];
            app.ROIhightEditFieldLabel.Text = 'ROI hight';

            % Create ROIhightEditField
            app.ROIhightEditField = uieditfield(app.PositroniumdotMATMododetomografaUIFigure, 'numeric');
            app.ROIhightEditField.ValueChangedFcn = createCallbackFcn(app, @ROIhightEditFieldValueChanged, true);
            app.ROIhightEditField.Enable = 'off';
            app.ROIhightEditField.Position = [549 268 64 22];

            % Create RadiomorfEditFieldLabel
            app.RadiomorfEditFieldLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.RadiomorfEditFieldLabel.HorizontalAlignment = 'right';
            app.RadiomorfEditFieldLabel.Position = [493 123 75 22];
            app.RadiomorfEditFieldLabel.Text = 'Radio  (morf)';

            % Create RadiomorfEditField
            app.RadiomorfEditField = uieditfield(app.PositroniumdotMATMododetomografaUIFigure, 'numeric');
            app.RadiomorfEditField.Enable = 'off';
            app.RadiomorfEditField.Position = [577 123 50 22];
            app.RadiomorfEditField.Value = 1;

            % Create DilatarButton
            app.DilatarButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.DilatarButton.ButtonPushedFcn = createCallbackFcn(app, @DilatarButtonPushed, true);
            app.DilatarButton.Enable = 'off';
            app.DilatarButton.Position = [646 156 100 23];
            app.DilatarButton.Text = 'Dilatar';

            % Create ErosionarButton
            app.ErosionarButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.ErosionarButton.ButtonPushedFcn = createCallbackFcn(app, @ErosionarButtonPushed, true);
            app.ErosionarButton.Enable = 'off';
            app.ErosionarButton.Position = [646 122 100 23];
            app.ErosionarButton.Text = 'Erosionar';

            % Create SUVMAXLabel
            app.SUVMAXLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.SUVMAXLabel.HorizontalAlignment = 'center';
            app.SUVMAXLabel.FontColor = [1 0 1];
            app.SUVMAXLabel.Visible = 'off';
            app.SUVMAXLabel.Position = [1037 184 154 22];
            app.SUVMAXLabel.Text = 'SUV MAX';

            % Create ResetsegmentacinButton
            app.ResetsegmentacinButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.ResetsegmentacinButton.ButtonPushedFcn = createCallbackFcn(app, @ResetsegmentacinButtonPushed, true);
            app.ResetsegmentacinButton.Enable = 'off';
            app.ResetsegmentacinButton.Position = [484 208 268 23];
            app.ResetsegmentacinButton.Text = 'Reset segmentación';

            % Create CerrarButton
            app.CerrarButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.CerrarButton.ButtonPushedFcn = createCallbackFcn(app, @CerrarButtonPushed, true);
            app.CerrarButton.Icon = fullfile(pathToMLAPP, 'ico', 'icon_close.png');
            app.CerrarButton.Position = [734 16 100 23];
            app.CerrarButton.Text = 'Cerrar';

            % Create GuardarButton
            app.GuardarButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.GuardarButton.ButtonPushedFcn = createCallbackFcn(app, @GuardarButtonPushed, true);
            app.GuardarButton.Icon = fullfile(pathToMLAPP, 'ico', 'save.png');
            app.GuardarButton.Enable = 'off';
            app.GuardarButton.Position = [617 16 100 23];
            app.GuardarButton.Text = 'Guardar';

            % Create DeteccindebordeDropDownLabel
            app.DeteccindebordeDropDownLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.DeteccindebordeDropDownLabel.HorizontalAlignment = 'right';
            app.DeteccindebordeDropDownLabel.Position = [628 271 109 22];
            app.DeteccindebordeDropDownLabel.Text = 'Detección de borde';

            % Create DeteccindebordeDropDown
            app.DeteccindebordeDropDown = uidropdown(app.PositroniumdotMATMododetomografaUIFigure);
            app.DeteccindebordeDropDown.Items = {'Canny', 'log', 'zerocross', 'approxcanny', 'Roberts', 'Prewitt', 'Sobel'};
            app.DeteccindebordeDropDown.ItemsData = [1 2 3 4 5 6 7];
            app.DeteccindebordeDropDown.ValueChangedFcn = createCallbackFcn(app, @DeteccindebordeDropDownValueChanged, true);
            app.DeteccindebordeDropDown.Enable = 'off';
            app.DeteccindebordeDropDown.Position = [629 248 128 22];
            app.DeteccindebordeDropDown.Value = 1;

            % Create Actividad0Label
            app.Actividad0Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.Actividad0Label.HorizontalAlignment = 'right';
            app.Actividad0Label.FontWeight = 'bold';
            app.Actividad0Label.FontColor = [1 0 0];
            app.Actividad0Label.Visible = 'off';
            app.Actividad0Label.Position = [617 331 118 22];
            app.Actividad0Label.Text = 'Actividad0';

            % Create radionuclidoLabel
            app.radionuclidoLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.radionuclidoLabel.FontWeight = 'bold';
            app.radionuclidoLabel.FontColor = [1 0 0];
            app.radionuclidoLabel.Visible = 'off';
            app.radionuclidoLabel.Position = [399 651 135 22];
            app.radionuclidoLabel.Text = 'radionuclido';

            % Create vidamediaLabel
            app.vidamediaLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.vidamediaLabel.FontWeight = 'bold';
            app.vidamediaLabel.FontColor = [1 0 0];
            app.vidamediaLabel.Visible = 'off';
            app.vidamediaLabel.Position = [399 630 120 22];
            app.vidamediaLabel.Text = 'vidamedia';

            % Create WindowLevelEditFieldLabel
            app.WindowLevelEditFieldLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.WindowLevelEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowLevelEditFieldLabel.Enable = 'off';
            app.WindowLevelEditFieldLabel.Position = [767 126 80 22];
            app.WindowLevelEditFieldLabel.Text = 'Window Level';

            % Create WindowLevelEditField
            app.WindowLevelEditField = uieditfield(app.PositroniumdotMATMododetomografaUIFigure, 'numeric');
            app.WindowLevelEditField.ValueChangedFcn = createCallbackFcn(app, @WindowLevelEditFieldValueChanged, true);
            app.WindowLevelEditField.Enable = 'off';
            app.WindowLevelEditField.Position = [853 124 62 24];

            % Create WindowWidthEditFieldLabel
            app.WindowWidthEditFieldLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.WindowWidthEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowWidthEditFieldLabel.Enable = 'off';
            app.WindowWidthEditFieldLabel.Position = [767 99 82 22];
            app.WindowWidthEditFieldLabel.Text = 'Window Width';

            % Create WindowWidthEditField
            app.WindowWidthEditField = uieditfield(app.PositroniumdotMATMododetomografaUIFigure, 'numeric');
            app.WindowWidthEditField.ValueChangedFcn = createCallbackFcn(app, @WindowWidthEditFieldValueChanged, true);
            app.WindowWidthEditField.Enable = 'off';
            app.WindowWidthEditField.Position = [853 98 63 22];

            % Create FWHMButtonGroup
            app.FWHMButtonGroup = uibuttongroup(app.PositroniumdotMATMododetomografaUIFigure);
            app.FWHMButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @FWHMButtonGroupSelectionChanged, true);
            app.FWHMButtonGroup.Enable = 'off';
            app.FWHMButtonGroup.Title = 'FWHM';
            app.FWHMButtonGroup.FontSize = 10;
            app.FWHMButtonGroup.Position = [287 15 191 111];

            % Create PromedioButton
            app.PromedioButton = uiradiobutton(app.FWHMButtonGroup);
            app.PromedioButton.Text = 'Promedio';
            app.PromedioButton.FontSize = 10;
            app.PromedioButton.Position = [5 70 65 22];
            app.PromedioButton.Value = true;

            % Create PuntualButton
            app.PuntualButton = uiradiobutton(app.FWHMButtonGroup);
            app.PuntualButton.Text = 'Puntual';
            app.PuntualButton.FontSize = 10;
            app.PuntualButton.Position = [75 70 56 22];

            % Create RadioEditFieldLabel
            app.RadioEditFieldLabel = uilabel(app.FWHMButtonGroup);
            app.RadioEditFieldLabel.HorizontalAlignment = 'right';
            app.RadioEditFieldLabel.FontSize = 10;
            app.RadioEditFieldLabel.Position = [6 49 31 22];
            app.RadioEditFieldLabel.Text = 'Radio';

            % Create RadioEditField
            app.RadioEditField = uieditfield(app.FWHMButtonGroup, 'numeric');
            app.RadioEditField.ValueChangedFcn = createCallbackFcn(app, @RadioEditFieldValueChanged, true);
            app.RadioEditField.FontSize = 10;
            app.RadioEditField.Enable = 'off';
            app.RadioEditField.Position = [39 50 24 22];
            app.RadioEditField.Value = 3;

            % Create MximoButton
            app.MximoButton = uiradiobutton(app.FWHMButtonGroup);
            app.MximoButton.Text = 'Máximo';
            app.MximoButton.FontSize = 10;
            app.MximoButton.Position = [131 70 57 22];

            % Create IniciarButton
            app.IniciarButton = uibutton(app.FWHMButtonGroup, 'push');
            app.IniciarButton.ButtonPushedFcn = createCallbackFcn(app, @IniciarButtonPushed, true);
            app.IniciarButton.FontSize = 10;
            app.IniciarButton.Enable = 'off';
            app.IniciarButton.Position = [138 5 47 22];
            app.IniciarButton.Text = 'Iniciar';

            % Create UmbralEditFieldLabel
            app.UmbralEditFieldLabel = uilabel(app.FWHMButtonGroup);
            app.UmbralEditFieldLabel.HorizontalAlignment = 'right';
            app.UmbralEditFieldLabel.FontSize = 10;
            app.UmbralEditFieldLabel.Position = [70 50 37 22];
            app.UmbralEditFieldLabel.Text = 'Umbral';

            % Create UmbralEditField
            app.UmbralEditField = uieditfield(app.FWHMButtonGroup, 'numeric');
            app.UmbralEditField.FontSize = 10;
            app.UmbralEditField.Enable = 'off';
            app.UmbralEditField.Position = [122 50 59 22];
            app.UmbralEditField.Value = 100000;

            % Create RadiocmEditFieldLabel
            app.RadiocmEditFieldLabel = uilabel(app.FWHMButtonGroup);
            app.RadiocmEditFieldLabel.HorizontalAlignment = 'right';
            app.RadiocmEditFieldLabel.FontSize = 10;
            app.RadiocmEditFieldLabel.Position = [6 25 54 22];
            app.RadiocmEditFieldLabel.Text = 'Radio (cm)';

            % Create RadiocmEditField
            app.RadiocmEditField = uieditfield(app.FWHMButtonGroup, 'numeric');
            app.RadiocmEditField.Limits = [0 Inf];
            app.RadiocmEditField.ValueChangedFcn = createCallbackFcn(app, @RadiocmEditFieldValueChanged, true);
            app.RadiocmEditField.FontSize = 10;
            app.RadiocmEditField.Enable = 'off';
            app.RadiocmEditField.Position = [72 25 40 22];
            app.RadiocmEditField.Value = 5;

            % Create PuntualCheckBox
            app.PuntualCheckBox = uicheckbox(app.FWHMButtonGroup);
            app.PuntualCheckBox.ValueChangedFcn = createCallbackFcn(app, @PuntualCheckBoxValueChanged, true);
            app.PuntualCheckBox.Text = 'Puntual';
            app.PuntualCheckBox.FontSize = 10;
            app.PuntualCheckBox.Position = [46 91 56 22];
            app.PuntualCheckBox.Value = true;

            % Create NumricoCheckBox
            app.NumricoCheckBox = uicheckbox(app.FWHMButtonGroup);
            app.NumricoCheckBox.ValueChangedFcn = createCallbackFcn(app, @NumricoCheckBoxValueChanged, true);
            app.NumricoCheckBox.Text = 'Numérico';
            app.NumricoCheckBox.Position = [108 91 73 22];

            % Create AjustarejeCheckBox
            app.AjustarejeCheckBox = uicheckbox(app.FWHMButtonGroup);
            app.AjustarejeCheckBox.ValueChangedFcn = createCallbackFcn(app, @AjustarejeCheckBoxValueChanged, true);
            app.AjustarejeCheckBox.Text = 'Ajustar eje';
            app.AjustarejeCheckBox.FontSize = 10;
            app.AjustarejeCheckBox.Position = [4 1 69 22];

            % Create RefrescarButton
            app.RefrescarButton = uibutton(app.FWHMButtonGroup, 'push');
            app.RefrescarButton.ButtonPushedFcn = createCallbackFcn(app, @RefrescarButtonPushed, true);
            app.RefrescarButton.FontSize = 9;
            app.RefrescarButton.Position = [128 31 53 15];
            app.RefrescarButton.Text = 'Refrescar';

            % Create GxlsxCheckBox
            app.GxlsxCheckBox = uicheckbox(app.FWHMButtonGroup);
            app.GxlsxCheckBox.Visible = 'off';
            app.GxlsxCheckBox.Text = 'G. xlsx';
            app.GxlsxCheckBox.Position = [75 1 59 22];

            % Create Button
            app.Button = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_down.png');
            app.Button.Enable = 'off';
            app.Button.Position = [873 15 22 24];
            app.Button.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_right.png');
            app.Button_2.Enable = 'off';
            app.Button_2.Position = [900 15 22 24];
            app.Button_2.Text = '';

            % Create Button_3
            app.Button_3 = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_left.png');
            app.Button_3.Enable = 'off';
            app.Button_3.Position = [847 15 22 24];
            app.Button_3.Text = '';

            % Create Button_4
            app.Button_4 = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.Button_4.ButtonPushedFcn = createCallbackFcn(app, @Button_4Pushed, true);
            app.Button_4.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_up.png');
            app.Button_4.Enable = 'off';
            app.Button_4.Position = [873 45 22 24];
            app.Button_4.Text = '';

            % Create CrosshairctrlLabel
            app.CrosshairctrlLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.CrosshairctrlLabel.Position = [847 71 79 22];
            app.CrosshairctrlLabel.Text = 'Crosshair ctrl.';

            % Create Button_5
            app.Button_5 = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.Button_5.ButtonPushedFcn = createCallbackFcn(app, @Button_5Pushed, true);
            app.Button_5.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_left_1.png');
            app.Button_5.Enable = 'off';
            app.Button_5.Position = [847 45 22 24];
            app.Button_5.Text = '';

            % Create Button_6
            app.Button_6 = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.Button_6.ButtonPushedFcn = createCallbackFcn(app, @Button_6Pushed, true);
            app.Button_6.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_right_1.png');
            app.Button_6.Enable = 'off';
            app.Button_6.Position = [900 45 22 24];
            app.Button_6.Text = '';

            % Create nCorteEditField
            app.nCorteEditField = uieditfield(app.PositroniumdotMATMododetomografaUIFigure, 'numeric');
            app.nCorteEditField.Limits = [0 90];
            app.nCorteEditField.ValueChangedFcn = createCallbackFcn(app, @nCorteEditFieldValueChanged, true);
            app.nCorteEditField.Enable = 'off';
            app.nCorteEditField.Position = [789 58 38 23];

            % Create flipvolButton
            app.flipvolButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.flipvolButton.ButtonPushedFcn = createCallbackFcn(app, @flipvolButtonPushed, true);
            app.flipvolButton.FontSize = 10;
            app.flipvolButton.Enable = 'off';
            app.flipvolButton.Visible = 'off';
            app.flipvolButton.Position = [657 90 100 22];
            app.flipvolButton.Text = 'flip(vol)';

            % Create COVLabel
            app.COVLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.COVLabel.FontColor = [1 1 0.0667];
            app.COVLabel.Visible = 'off';
            app.COVLabel.Position = [782 662 119 21];
            app.COVLabel.Text = 'COV';

            % Create SRNLabel
            app.SRNLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.SRNLabel.FontColor = [0 1 0];
            app.SRNLabel.Visible = 'off';
            app.SRNLabel.Position = [1003 662 119 22];
            app.SRNLabel.Text = 'SRN';

            % Create UILabel
            app.UILabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.UILabel.FontColor = [0.0588 1 1];
            app.UILabel.Visible = 'off';
            app.UILabel.Position = [1199 661 119 22];
            app.UILabel.Text = 'UI';

            % Show the figure after all components are created
            app.PositroniumdotMATMododetomografaUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main2_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PositroniumdotMATMododetomografaUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PositroniumdotMATMododetomografaUIFigure)
        end
    end
end