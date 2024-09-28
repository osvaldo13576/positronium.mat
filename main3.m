classdef main3_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PositroniumdotMATMododeanlisisconjunto1UIFigure  matlab.ui.Figure
        AnalizarButton   matlab.ui.control.Button
        RegresarButton   matlab.ui.control.Button
        ResetButton      matlab.ui.control.Button
        CargandoLabel    matlab.ui.control.Label
        EmparejarButton  matlab.ui.control.Button
        outputTextArea   matlab.ui.control.TextArea
        CerrarButton     matlab.ui.control.Button
        Image            matlab.ui.control.Image
        Tree             matlab.ui.container.CheckBoxTree
        UIAxes           matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        Nodos
        output
        mod3DIR
        perfiles
        estudios_dir
        corte_pos
        perfil_plot
        %%
        sec_perfil
        line1
        line2
        point_counter = 0
        p1
        p2
        %%
        Legends
        num_estudios
        selected_curve
    end
    
    methods (Access = private)
        
        function [] = plot_perfiles(app)
            cla(app.UIAxes)
            hold(app.UIAxes,"on")
            app.Legends=cell(app.num_estudios,1);
            for n = 1:app.num_estudios
                app.perfil_plot.("estudio_" + num2str(n))=plot(app.UIAxes,app.corte_pos.("estudio_" + num2str(n)), app.perfiles.("estudio_" + num2str(n)),'-','LineWidth',1.5,"HitTest","off");
                app.Legends{n}="Estudio "+int2str(n);
            end
            legend(app.UIAxes,app.Legends);
            %hold(app.UIAxes,"off")
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %movegui(app.PositroniumdotMATMododeanlisisconjunto1UIFigure, 'center');
            app.output = "Validando directorio DICOM...";
            app.outputTextArea.Value = app.output;
            app.CargandoLabel.Text = "Esperando estudios...";
            load("saved_data.mat","modo3DIR");app.mod3DIR=modo3DIR;
            app.output = convertCharsToStrings(app.mod3DIR)+newline+app.output;
            app.outputTextArea.Value = app.output;
            directorios_dicom = read_dicom_folders(app.mod3DIR);
            app.num_estudios = length(fieldnames(directorios_dicom));
            pause(1)
            if isstruct(directorios_dicom)
                if length(fieldnames(directorios_dicom)) > 1
                    app.output = "[OK] Se encontraron " + int2str(app.num_estudios) + " estudios válidos." + newline+app.output;
                    app.outputTextArea.Value =  app.output;
                    for n = 1:app.num_estudios
                        pause(0.8)
                        [~, parent_dir,~] = fileparts(directorios_dicom.("estudio_" + num2str(n)));
                        app.output = "[DIR"+int2str(n)+"] " + convertCharsToStrings(parent_dir) + newline+app.output;
                        app.outputTextArea.Value =  app.output;
                    end
                    validacion = 1;
                else
                    app.output = "[X] Solo existe un estudio válido.";
                    app.outputTextArea.Value =  app.output;
                    validacion = 0;
                end
            else
                app.output = "[X] No existen estudios válidos.";
                app.outputTextArea.Value =  app.output;
                validacion = 0;
            end
            %%
            if validacion
                app.output = "Cargando perfiles..."  + newline+app.output;
                app.outputTextArea.Value =  app.output;
                pause(1)
                [app.estudios_dir,app.perfiles]=vector_perfiles(app.mod3DIR);
                
                for n = 1:app.num_estudios
                    pause(0.5)
                    app.Nodos.("estudio_" + num2str(n)) = uitreenode(app.Tree);
                    app.Nodos.("estudio_" + num2str(n)).Text = convertStringsToChars(app.estudios_dir.("estudio_" + num2str(n)));
                    app.Nodos.("estudio_" + num2str(n)).NodeData = n;
                    app.corte_pos.("estudio_" + num2str(n)) = 1:length(app.perfiles.("estudio_" + num2str(n)));
                    perfil = app.perfiles.("estudio_" + num2str(n));
                    %perfil_1 = app.perfiles.("estudio_" + num2str(1))/mean(app.perfiles.("estudio_" + num2str(1))); % normalizamos siempre con respecto el perfil no. 1
                    app.perfiles.("estudio_" + num2str(n)) = (perfil/mean(perfil))/max(perfil/mean(perfil));
                end
                app.output = "Normalizando estudios." + newline+app.output;
                app.outputTextArea.Value =  app.output;
                pause(1)
                plot_perfiles(app);
                app.Image.Visible = "off";
                app.UIAxes.Visible ="on";
                app.output = "[OK] Cargados correctamente." + newline+app.output;
                app.output = "Seleccione el rango de comparacion." + newline+app.output;
                app.outputTextArea.Value =  app.output;
                %%
                app.CargandoLabel.Text = "Marque los estudios a comparar y seleccione el estudio de referencia";
            end
            %%
            app.CerrarButton.Enable = "on";
            app.RegresarButton.Enable = "on";
            app.ResetButton.Enable = "on";
        end

        % Callback function: Tree
        function TreeCheckedNodesChanged(app, event)
            checkedNodes = app.Tree.CheckedNodes;
            %checkedNodes
            %length(checkedNodes)
            
            
            app.CargandoLabel.Text = "Estudio de referencia >" + convertCharsToStrings(app.Tree.SelectedNodes.Text)+"< se comparará contra "+int2str(length(app.Tree.CheckedNodes))+" estudios.";
            if length(checkedNodes)>1 && length(app.Tree.SelectedNodes) ==  1 && app.point_counter == 3
                app.EmparejarButton.Enable = "on"; 
            else
                app.EmparejarButton.Enable = "off"; 
            end 
        end

        % Selection changed function: Tree
        function TreeSelectionChanged(app, event)
            %selectedNodes = app.Tree.SelectedNodes;
            app.CargandoLabel.Text = "Estudio de referencia >" + convertCharsToStrings(app.Tree.SelectedNodes.Text)+"< se comparará contra "+int2str(length(app.Tree.CheckedNodes))+" estudios.";
            
            if app.point_counter == 3
                delete(app.selected_curve)
                if length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData)) < app.p2-app.p1
                    app.p2 = length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData));
                    app.p1 = 1;
                end
                if length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData)) < app.p2
                    app.p1 = length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData))-app.p2+app.p1;
                    app.p2 = length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData));
                end
                if app.p1 < 1
                    app.p1 = 1;
                end
                delete(app.sec_perfil);delete(app.line1);delete(app.line2)
                app.line1=xline(app.UIAxes, app.p1,'Color',[0,128/255,128/255],'linewidth',1);
                app.line2=xline(app.UIAxes, app.p2,'Color',[0,128/255,128/255],'linewidth',1);
                app.sec_perfil = fill(app.UIAxes,[app.p1, app.p2, app.p2, app.p1],[0, 0, 1, 1],'b','FaceAlpha',0.2,'EdgeColor','none');
                app.selected_curve = plot(app.UIAxes,app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData)(app.p1:app.p2), app.perfiles.("estudio_" + app.Tree.SelectedNodes.NodeData)(app.p1:app.p2),'-s','Color','g',"HitTest","off");
            end
            legend(app.UIAxes,app.Legends);
        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
            P = get(app.UIAxes,'CurrentPoint'); 
            x = round(P(1,1));
            if app.point_counter == 0 || app.point_counter == 3
                delete(app.sec_perfil);delete(app.line1);delete(app.line2)
                app.p1 = x;
                app.line1=xline(app.UIAxes, app.p1,'Color',[0,128/255,128/255],'linewidth',1);
                app.point_counter = 1;
            elseif app.point_counter == 1
                app.p2 = x;
                app.line2=xline(app.UIAxes, app.p2,'Color',[0,128/255,128/255],'linewidth',1);
                app.point_counter = 2;
            end
            if app.point_counter == 2
                if app.p2<app.p1
                    app.p2 = app.p1;
                    app.p1 = x;
                end
                app.sec_perfil = fill(app.UIAxes,[app.p1, app.p2, app.p2, app.p1],[0, 0, 1, 1],'b','FaceAlpha',0.2,'EdgeColor','none');
                app.point_counter = 3;
                if length(app.Tree.SelectedNodes) == 1 
                    delete(app.selected_curve)
                    if length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData)) < app.p2-app.p1
                        app.p2 = length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData));
                        app.p1 = 1;
                    end
                    if length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData)) < app.p2
                        app.p1 = length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData))-app.p2+app.p1;
                        app.p2 = length(app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData));
                    end
                    if app.p1 < 1
                        app.p1 = 1;
                    end
                    delete(app.sec_perfil);delete(app.line1);delete(app.line2)
                    app.line1=xline(app.UIAxes, app.p1,'Color',[0,128/255,128/255],'linewidth',1);
                    app.line2=xline(app.UIAxes, app.p2,'Color',[0,128/255,128/255],'linewidth',1);
                    app.sec_perfil = fill(app.UIAxes,[app.p1, app.p2, app.p2, app.p1],[0, 0, 1, 1],'b','FaceAlpha',0.2,'EdgeColor','none');
                    app.selected_curve = plot(app.UIAxes,app.corte_pos.("estudio_" + app.Tree.SelectedNodes.NodeData)(app.p1:app.p2), app.perfiles.("estudio_" + app.Tree.SelectedNodes.NodeData)(app.p1:app.p2),'-s','Color','g',"HitTest","off");
                end
            end
            legend(app.UIAxes,app.Legends);
            %%
            if length(app.Tree.CheckedNodes)>1 && length(app.Tree.SelectedNodes) ==  1 && app.point_counter == 3
                app.EmparejarButton.Enable = "on"; 
            else
                app.EmparejarButton.Enable = "off";
            end
        end

        % Button pushed function: EmparejarButton
        function EmparejarButtonPushed(app, event)
            app.CerrarButton.Enable = "off";
            app.RegresarButton.Enable = "off";
            app.ResetButton.Enable = "off";
            app.EmparejarButton.Enable = "off";
            app.Tree.Enable = "off";
            % se genera un vector de los estudios seleccionados
            estudios_seleccionados = zeros(1,length(app.Tree.CheckedNodes));
            for n = 1:length(app.Tree.CheckedNodes)
                %app.Tree.CheckedNodes(1).
                %app.Tree.CheckedNodes(1).NodeData
                estudios_seleccionados(n) = app.Tree.CheckedNodes(n).NodeData;
            end
            estudios_seleccionados = setdiff(estudios_seleccionados,app.Tree.SelectedNodes.NodeData);
            estudios_tolales = cat(2,estudios_seleccionados,app.Tree.SelectedNodes.NodeData);
            num_cortes = zeros(1,length(estudios_tolales));
            for n = 1:length(estudios_tolales)
                num_cortes(n) = length(app.perfiles.("estudio_" + num2str(estudios_tolales(n))));
            end
            valor_corte = min(num_cortes);
            correlacion_pares = zeros(valor_corte-(app.p2-app.p1),length(estudios_seleccionados));
            ya = [0, 0, 1, 1];
            
            for n = 1:length(estudios_seleccionados)
                for m =  1:(valor_corte-(app.p2-app.p1))
                    delete(app.sec_perfil);delete(app.line1);delete(app.line2);delete(app.selected_curve)
                    x1 = 0+m;
                    x2 = app.p2-app.p1+m;
                    xa = [x1, x2, x2, x1];
                    %app.line1=xline(app.UIAxes, x1,'Color',[0,128/255,128/255],'linewidth',1);
                    app.line1=xline(app.UIAxes, x1,'Color',[0,128/255,128/255],'linewidth',1);
                    app.line2=xline(app.UIAxes, x2,'Color',[0,128/255,128/255],'linewidth',1);
                    app.selected_curve = plot(app.UIAxes,x1:x2, app.perfiles.("estudio_" + app.Tree.SelectedNodes.NodeData)(app.p1:app.p2),'-s','Color','g',"HitTest","off");
                    app.sec_perfil = fill(app.UIAxes,xa,ya,'b','FaceAlpha',0.2,'EdgeColor','none');
                    [correlacion_pares(m,n),~] = corr(app.perfiles.("estudio_" + num2str(app.Tree.SelectedNodes.NodeData))(app.p1:app.p2), ...
                        app.perfiles.("estudio_" + num2str(estudios_seleccionados(n)))(x1:x2),"type","Spearman");
                    legend(app.UIAxes,app.Legends);
                    %pause(0.1)
                    drawnow %nocallbacks
                end
                max_corre = max(correlacion_pares(:,n));
                app.output = "Estidio "+ num2str(estudios_seleccionados(n))+": " + "max(corr) = " + compose("%1.7f",max_corre) + newline+app.output;
                app.outputTextArea.Value =  app.output;
            end
            [~, indice] = max(correlacion_pares);
            app.output = "Delta x = index-p1 = " + int2str(abs(indice-app.p1)) + newline+app.output;
            app.outputTextArea.Value =  app.output;
            app.output = "Guardando variables..." + newline+app.output;
            app.outputTextArea.Value =  app.output;
            indice = indice-app.p1;

            
            cla(app.UIAxes)
            hold(app.UIAxes,"on")
            app.Legends=cell(length(estudios_tolales),1);
            dir_estudios = [];
            x_inicial = [];
            x_final = [];

            for n = 1:(length(estudios_tolales)-1)
                dir_estudios.("estudio_" + num2str(n))=app.estudios_dir.("estudio_" + num2str(estudios_tolales(n)));
                x_inicial.("estudio_" + num2str(n))=app.p1+indice(n);
                x_final.("estudio_" + num2str(n))=app.p2+indice(n);
                app.perfil_plot.("estudio_" + num2str(n))=plot(app.UIAxes,app.p1:app.p2,app.perfiles.("estudio_" + num2str(estudios_tolales(n)))((app.p1+indice(n)):(app.p2+indice(n))),'-','LineWidth',1.5,"HitTest","off");
                app.Legends{n}="Estudio "+int2str(n);

            end
            title(app.UIAxes, 'Perfiles sincronizados')
            dir_estudios.("estudio_" + num2str(n+1))=app.estudios_dir.("estudio_" + num2str(estudios_tolales(n+1)));
            x_inicial.("estudio_" + num2str(n+1))=app.p1;
            x_final.("estudio_" + num2str(n+1))=app.p2;
            %%
            save("saved_data.mat","dir_estudios",'-append');
            save("saved_data.mat","x_inicial",'-append');
            save("saved_data.mat","x_final",'-append');
            %%
            app.perfil_plot.("estudio_" + num2str(n+1))=plot(app.UIAxes,app.p1:app.p2,app.perfiles.("estudio_" + num2str(estudios_tolales(end)))(app.p1:app.p2),'-','LineWidth',1.5,"HitTest","off");
            app.Legends{n+1}="Estudio REF";
            legend(app.UIAxes,app.Legends);
            ylim(app.UIAxes,[0,1])
            xlim(app.UIAxes,[0,length(app.perfiles.("estudio_" + num2str(estudios_tolales(end))))])

            %%
            app.CerrarButton.Enable = "on";
            app.RegresarButton.Enable = "on";
            app.ResetButton.Enable = "on";
            app.AnalizarButton.Enable = "on";
            %app.Tree.Enable = "off";
            app.CargandoLabel.Text = "Estudios sincronizados. Pulse Reset para volver a comparar estudios.";
            app.output = "Completado." + newline+app.output;
            app.outputTextArea.Value =  app.output;
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
           app.output = "Valores restablecidos." + newline+app.output;
           app.outputTextArea.Value =  app.output;
           delete(app.sec_perfil);delete(app.line1);delete(app.line2)
           app.point_counter = 0;
           plot_perfiles(app);
           app.EmparejarButton.Enable = "off";
           app.Tree.Enable = "on";
        end

        % Button pushed function: RegresarButton
        function RegresarButtonPushed(app, event)
            drawnow nocallbacks
            app.delete;
            main0;
            

        end

        % Button pushed function: AnalizarButton
        function AnalizarButtonPushed(app, event)
            drawnow nocallbacks
            app.delete;
            main3_1;
            
        end

        % Button pushed function: CerrarButton
        function CerrarButtonPushed(app, event)
            app.delete;
            
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create PositroniumdotMATMododeanlisisconjunto1UIFigure and hide until all components are created
            app.PositroniumdotMATMododeanlisisconjunto1UIFigure = uifigure('Visible', 'off');
            app.PositroniumdotMATMododeanlisisconjunto1UIFigure.Position = [100 100 672 478];
            app.PositroniumdotMATMododeanlisisconjunto1UIFigure.Name = 'Positronium dot MAT - Modo de análisis conjunto 1';
            app.PositroniumdotMATMododeanlisisconjunto1UIFigure.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');
            app.PositroniumdotMATMododeanlisisconjunto1UIFigure.Resize = 'off';

            % Create UIAxes
            app.UIAxes = uiaxes(app.PositroniumdotMATMododeanlisisconjunto1UIFigure);
            title(app.UIAxes, 'Perfiles CT')
            xlabel(app.UIAxes, 'Cortes')
            ylabel(app.UIAxes, 'Valor promedio')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Visible = 'off';
            app.UIAxes.Position = [27 155 632 308];

            % Create Tree
            app.Tree = uitree(app.PositroniumdotMATMododeanlisisconjunto1UIFigure, 'checkbox');
            app.Tree.SelectionChangedFcn = createCallbackFcn(app, @TreeSelectionChanged, true);
            app.Tree.Position = [331 18 191 119];

            % Assign Checked Nodes
            app.Tree.CheckedNodesChangedFcn = createCallbackFcn(app, @TreeCheckedNodesChanged, true);

            % Create Image
            app.Image = uiimage(app.PositroniumdotMATMododeanlisisconjunto1UIFigure);
            app.Image.Position = [302 291 70 36];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'ico', 'waiting.gif');

            % Create CerrarButton
            app.CerrarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto1UIFigure, 'push');
            app.CerrarButton.ButtonPushedFcn = createCallbackFcn(app, @CerrarButtonPushed, true);
            app.CerrarButton.Icon = fullfile(pathToMLAPP, 'ico', 'icon_close.png');
            app.CerrarButton.Enable = 'off';
            app.CerrarButton.Position = [595 18 65 23];
            app.CerrarButton.Text = 'Cerrar';

            % Create outputTextArea
            app.outputTextArea = uitextarea(app.PositroniumdotMATMododeanlisisconjunto1UIFigure);
            app.outputTextArea.FontColor = [0 1 0];
            app.outputTextArea.BackgroundColor = [0 0 0];
            app.outputTextArea.Position = [15 16 308 119];

            % Create EmparejarButton
            app.EmparejarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto1UIFigure, 'push');
            app.EmparejarButton.ButtonPushedFcn = createCallbackFcn(app, @EmparejarButtonPushed, true);
            app.EmparejarButton.Icon = fullfile(pathToMLAPP, 'ico', 'compare.png');
            app.EmparejarButton.Enable = 'off';
            app.EmparejarButton.Position = [534 110 126 25];
            app.EmparejarButton.Text = 'Emparejar';

            % Create CargandoLabel
            app.CargandoLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto1UIFigure);
            app.CargandoLabel.Position = [16 134 652 22];
            app.CargandoLabel.Text = 'CargandoLabel';

            % Create ResetButton
            app.ResetButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto1UIFigure, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.Icon = fullfile(pathToMLAPP, 'ico', 'reset.png');
            app.ResetButton.Enable = 'off';
            app.ResetButton.Position = [534 18 61 23];
            app.ResetButton.Text = 'Reset';

            % Create RegresarButton
            app.RegresarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto1UIFigure, 'push');
            app.RegresarButton.ButtonPushedFcn = createCallbackFcn(app, @RegresarButtonPushed, true);
            app.RegresarButton.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');
            app.RegresarButton.Enable = 'off';
            app.RegresarButton.Position = [534 46 125 23];
            app.RegresarButton.Text = 'Regresar';

            % Create AnalizarButton
            app.AnalizarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto1UIFigure, 'push');
            app.AnalizarButton.ButtonPushedFcn = createCallbackFcn(app, @AnalizarButtonPushed, true);
            app.AnalizarButton.Icon = fullfile(pathToMLAPP, 'ico', 'run.png');
            app.AnalizarButton.Enable = 'off';
            app.AnalizarButton.Position = [534 74 125 30];
            app.AnalizarButton.Text = 'Analizar';

            % Show the figure after all components are created
            app.PositroniumdotMATMododeanlisisconjunto1UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main3_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PositroniumdotMATMododeanlisisconjunto1UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PositroniumdotMATMododeanlisisconjunto1UIFigure)
        end
    end
end