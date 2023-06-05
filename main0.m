classdef main0 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PositroniumMATUIFigure        matlab.ui.Figure
        SeleccionarButton             matlab.ui.control.Button
        outputTextArea                matlab.ui.control.TextArea
        Button_2                      matlab.ui.control.Button
        Button                        matlab.ui.control.Button
        CargarButton                  matlab.ui.control.Button
        directorio2EditField          matlab.ui.control.EditField
        directorio2EditFieldLabel     matlab.ui.control.Label
        directorio1EditField          matlab.ui.control.EditField
        directorio1EditFieldLabel     matlab.ui.control.Label
        Image3_2                      matlab.ui.control.Image
        Image3                        matlab.ui.control.Image
        SeleccioneelmodoButtonGroup   matlab.ui.container.ButtonGroup
        AnlisisconjuntoButton         matlab.ui.control.RadioButton
        VisualizacintomogrficaButton  matlab.ui.control.RadioButton
        VisualizacinindividualButton  matlab.ui.control.RadioButton
        CerrarButton                  matlab.ui.control.Button
        hiddenButton                  matlab.ui.control.Button
        Image4                        matlab.ui.control.Image
        HTML2                         matlab.ui.control.HTML
        Image2                        matlab.ui.control.Image
        HTML                          matlab.ui.control.HTML
        Image                         matlab.ui.control.Image
    end

    
    properties (Access = private)
        output = "Cargando..."
        mod1DIR;mod2DIR;mod3DIR_1;mod3DIR_2 
        formatos = {'.png','.jpg','.bmp','.dcm','.pcx','.tif'};
    end
    
    methods (Access = private)
        
        function [] = ON_OFF(app,var1,var2,var3,var4,var5,var6) % [] void function
            app.SeleccioneelmodoButtonGroup.Enable =var1;
            app.Button.Enable = var2;
            app.Button_2.Enable = var3;
            app.CerrarButton.Enable =var4;
            app.SeleccionarButton.Enable=var5;
            app.CargarButton.Enable = var6;  
        end
        
        function [] = dir2Visible(app,var)
            app.directorio2EditField.Visible = var;
            app.directorio2EditFieldLabel.Visible =var;
            app.Button_2.Visible = var;
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            movegui(app.PositroniumMATUIFigure, 'center'); 
            app.directorio1EditFieldLabel.Text = "Directorio";
            app.directorio2EditFieldLabel.Text = "Estudio 2";
            app.PositroniumMATUIFigure.Interruptible="on";
            % cargamos variables
            load("saved_data.mat","modo1DIR");load("saved_data.mat","modo2DIR");
            load("saved_data.mat","modo3DIR_1");load("saved_data.mat","modo3DIR_2");
            app.mod1DIR=modo1DIR;app.mod2DIR=modo2DIR;app.mod3DIR_1=modo3DIR_1;app.mod3DIR_2=modo3DIR_2; 
            app.outputTextArea.Value = app.output;
            wbar = permute(repmat(app.hiddenButton.BackgroundColor,20,1,900),[1,3,2]);
            wbar([1,end],:,:) = 0;
            wbar(:,[1,end],:) = 0;
            app.hiddenButton.Icon = wbar;
            n = 200;
             for i = 1:n
                 if mod(i,20)==0
                     currentProg = min(round((size(wbar,2)-2)*(i/n)),size(wbar,2)-2);
                     RGB = app.hiddenButton.Icon;
                     RGB(2:end-1, 2:currentProg+1, 1) = 0.41016; 
                     RGB(2:end-1, 2:currentProg+1, 2) = 0.41016;
                     RGB(2:end-1, 2:currentProg+1, 3) = 0.41016;
                     app.Image4.ImageSource = RGB;
                     %drawnow nocallbacks
                  end
             end
             pause(0.5)
             app.output = "Directorio cargado: "+convertCharsToStrings(app.mod1DIR)+newline+app.output;
             app.outputTextArea.Value = app.output;
             app.directorio1EditField.Value = app.mod1DIR;
             ON_OFF(app,1,1,1,1,1,0);

             
        end

        % Selection changed function: SeleccioneelmodoButtonGroup
        function SeleccioneelmodoButtonGroupSelectionChanged(app, event)
            ON_OFF(app,1,1,1,1,1,0);
            if app.VisualizacinindividualButton.Value == 1
                app.directorio1EditFieldLabel.Text = "Directorio";
                app.output = "Directorio cargado: "+convertCharsToStrings(app.mod1DIR)+newline+app.output;
                app.outputTextArea.Value = app.output;
                app.directorio1EditField.Value = app.mod1DIR;
                dir2Visible(app,0);
            end
            if app.VisualizacintomogrficaButton.Value == 1
                app.directorio1EditFieldLabel.Text = "Estudio";
                app.output = "Estudio cargado: "+convertCharsToStrings(app.mod2DIR)+newline+app.output;
                app.outputTextArea.Value = app.output;
                app.directorio1EditField.Value = app.mod2DIR;
                dir2Visible(app,0);
            end
            if app.AnlisisconjuntoButton.Value == 1
                app.directorio1EditFieldLabel.Text = "Estudio 1";
                app.output = "Estudio cargado (1): "+convertCharsToStrings(app.mod3DIR_1)+newline+app.output;
                app.output = "Estudio cargado (2): "+convertCharsToStrings(app.mod3DIR_2)+newline+app.output;
                app.outputTextArea.Value = app.output;
                app.directorio1EditField.Value = app.mod3DIR_1;
                app.directorio2EditField.Value = app.mod3DIR_2;
                dir2Visible(app,1);
            end
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            ON_OFF(app,0,0,0,0,0,0);
            directorio = uigetdir;
            if app.VisualizacinindividualButton.Value == 1
                if directorio ~= 0
                  app.directorio1EditField.Value = directorio;
                   modo1DIR = directorio;
                   app.mod1DIR = modo1DIR;
                   save("saved_data.mat","modo1DIR",'-append');
                   app.output =  "Directorio modificado: " + convertCharsToStrings(directorio)+ newline+app.output;
                   app.outputTextArea.Value = app.output;
                else
                   app.output =  "Operación Cancelada." + newline+app.output;
                   app.outputTextArea.Value = app.output;
                end
            end
            if app.VisualizacintomogrficaButton.Value == 1
                if directorio ~= 0
                  app.directorio1EditField.Value = directorio;
                   modo2DIR = directorio;
                   app.mod2DIR = modo2DIR;
                   save("saved_data.mat","modo2DIR",'-append');
                   app.output =  "Estudio dir. modificado: " + convertCharsToStrings(directorio)+ newline+app.output;
                   app.outputTextArea.Value = app.output;
                else
                   app.output =  "Operación Cancelada." + newline+app.output;
                   app.outputTextArea.Value = app.output;
                end
            end
            if app.AnlisisconjuntoButton.Value == 1
                if directorio ~= 0
                  app.directorio1EditField.Value = directorio;
                   modo3DIR_1 = directorio;
                   app.mod3DIR_1 = modo3DIR_1;
                   save("saved_data.mat","modo3DIR_1",'-append');
                   app.output =  "Estudio (1) dir. modificado: " + convertCharsToStrings(directorio)+ newline+app.output;
                   app.outputTextArea.Value = app.output;
                else
                   app.output =  "Operación Cancelada." + newline+app.output;
                   app.outputTextArea.Value = app.output;
                end
            end
            ON_OFF(app,1,1,1,1,1,0);
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            ON_OFF(app,0,0,0,0,0,0);
            directorio = uigetdir;
            if directorio ~= 0
                  app.directorio2EditField.Value = directorio;
                   modo3DIR_2 = directorio;
                   app.mod3DIR_2 = modo3DIR_2;
                   save("saved_data.mat","modo3DIR_2",'-append');
                   app.output =  "Estudio (2) dir. modificado: " + convertCharsToStrings(directorio)+ newline+app.output;
                   app.outputTextArea.Value = app.output;
                else
                   app.output =  "Operación Cancelada." + newline+app.output;
                   app.outputTextArea.Value = app.output;
            end
            ON_OFF(app,1,1,1,1,1,0);
        end

        % Button pushed function: SeleccionarButton
        function SeleccionarButtonPushed(app, event)
            app.output =  "Validando directorio...";
            app.outputTextArea.Value = app.output;
            if app.VisualizacinindividualButton.Value == 1
               archivos = dir(fullfile(app.mod1DIR,'*.*'));%listamos todos los objetos que tengan una extensión en 
               [~,~,ext]=fileparts({archivos.name});          %el directorio dado
               archivos =  archivos(matches(ext,app.formatos,"IgnoreCase",1));
               files=[convertCharsToStrings({archivos.name})];
               lista = '';
               for i = 1:length(files)
                 lista = sprintf("%s%s\n", lista, files(i));
               end
               if isempty({archivos.name}) 
                    app.output = "[X] Directorio no contiene archivos compatibles.";
                    app.outputTextArea.Value =  app.output;
                    app.CargarButton.Enable = "off";
                else 
                    n = length({archivos.name});
                    app.output = "[OK] Archivos compatibles encontrados: " + int2str(n) +newline+lista+app.output;
                    app.outputTextArea.Value = app.output;
                    app.CargarButton.Enable = "on";
                end
                  
            end
            if app.VisualizacintomogrficaButton.Value == 1
                % CT folder: SE000001
                % PET folder: SE000003
                % PETu folder: SE000004
                if isempty(dir(fullfile(app.mod2DIR,'*SE*')))
                    app.output = "[X] Directorio no contiene archivos compatibles.";
                    app.outputTextArea.Value =  app.output;
                    app.CargarButton.Enable = "off";
                else
                    ct_dir = fullfile(app.mod2DIR,'SE000001','*CT*');
                    pt_dir = fullfile(app.mod2DIR,'SE000003','*PT*');
                    ptu_dir =fullfile(app.mod2DIR,'SE000004','*PT*');
                    if isempty(dir(ct_dir)) || isempty(dir(pt_dir)) || isempty(dir(ptu_dir))
                        app.output = "[X] Algún directorio DICOM está vacío o no contiene archivos con los patrones CT y/o PT en sus nombres.";
                        app.outputTextArea.Value =  app.output;
                        app.CargarButton.Enable = "off";
                    else
                        if length(dir(ct_dir)) == length(dir(pt_dir)) && length(dir(pt_dir)) == length(dir(ptu_dir))
                           archivos = dir(ct_dir);
                           files=[convertCharsToStrings({archivos.name})];
                           lista = '';
                           for i = 1:length(files)
                             lista = sprintf("%s%s\n", lista, files(i));
                           end
                            app.output = "[OK] Archivos compatibles encontrados en 3 directorios: " + int2str(length(dir(ct_dir))) +newline+lista+app.output;
                            app.outputTextArea.Value = app.output;
                            app.CargarButton.Enable = "on";
                        else
                            app.output = "[X] Se encontró que los directorios DICOM no contiene la misma cantidad de elementos.";
                            app.outputTextArea.Value =  app.output;
                            app.CargarButton.Enable = "off";
                        end
                    end
                     
                end

                
                
            end
            if app.AnlisisconjuntoButton.Value == 1
                
            end
        end

        % Button pushed function: CargarButton
        function CargarButtonPushed(app, event)
             
            if app.VisualizacinindividualButton.Value == 1
                main1;
            end
            if app.VisualizacintomogrficaButton.Value == 1
                main2;
            end
            if app.AnlisisconjuntoButton.Value == 1
                main3;
            end
            app.delete;
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

            % Create PositroniumMATUIFigure and hide until all components are created
            app.PositroniumMATUIFigure = uifigure('Visible', 'off');
            app.PositroniumMATUIFigure.Position = [960 100 578 536];
            app.PositroniumMATUIFigure.Name = 'Positronium.MAT';
            app.PositroniumMATUIFigure.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');
            app.PositroniumMATUIFigure.Resize = 'off';

            % Create Image
            app.Image = uiimage(app.PositroniumMATUIFigure);
            app.Image.Position = [16 337 212 190];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'ico', 'positronium_ico_medium.png');

            % Create HTML
            app.HTML = uihtml(app.PositroniumMATUIFigure);
            app.HTML.HTMLSource = '<p><span style="font-family:Courier New,Courier,monospace"><span style="font-size:46px">{Positronium<br /><strong>dot</strong><br />MAT}</span></span></p>';
            app.HTML.Position = [228 325 348 182];

            % Create Image2
            app.Image2 = uiimage(app.PositroniumMATUIFigure);
            app.Image2.Position = [327 359 242 94];
            app.Image2.ImageSource = fullfile(pathToMLAPP, 'ico', 'pet_ct.png');

            % Create HTML2
            app.HTML2 = uihtml(app.PositroniumMATUIFigure);
            app.HTML2.HTMLSource = '<p style="text-align:left;"> v1.0   <span style="float:right;">        https://github.com/osvaldo13576/positronium.mat </span></p>';
            app.HTML2.Position = [8 -7 468 36];

            % Create Image4
            app.Image4 = uiimage(app.PositroniumMATUIFigure);
            app.Image4.Position = [16 155 452 38];

            % Create hiddenButton
            app.hiddenButton = uibutton(app.PositroniumMATUIFigure, 'push');
            app.hiddenButton.Visible = 'off';
            app.hiddenButton.Position = [475 6 100 23];
            app.hiddenButton.Text = 'hidden';

            % Create CerrarButton
            app.CerrarButton = uibutton(app.PositroniumMATUIFigure, 'push');
            app.CerrarButton.ButtonPushedFcn = createCallbackFcn(app, @CerrarButtonPushed, true);
            app.CerrarButton.Icon = fullfile(pathToMLAPP, 'ico', 'icon_close.png');
            app.CerrarButton.Enable = 'off';
            app.CerrarButton.Position = [482 163 94 23];
            app.CerrarButton.Text = 'Cerrar';

            % Create SeleccioneelmodoButtonGroup
            app.SeleccioneelmodoButtonGroup = uibuttongroup(app.PositroniumMATUIFigure);
            app.SeleccioneelmodoButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @SeleccioneelmodoButtonGroupSelectionChanged, true);
            app.SeleccioneelmodoButtonGroup.Enable = 'off';
            app.SeleccioneelmodoButtonGroup.Title = 'Seleccione el modo';
            app.SeleccioneelmodoButtonGroup.Position = [16 204 178 106];

            % Create VisualizacinindividualButton
            app.VisualizacinindividualButton = uiradiobutton(app.SeleccioneelmodoButtonGroup);
            app.VisualizacinindividualButton.Text = 'Visualización individual';
            app.VisualizacinindividualButton.Position = [11 60 145 22];
            app.VisualizacinindividualButton.Value = true;

            % Create VisualizacintomogrficaButton
            app.VisualizacintomogrficaButton = uiradiobutton(app.SeleccioneelmodoButtonGroup);
            app.VisualizacintomogrficaButton.Text = 'Visualización tomográfica';
            app.VisualizacintomogrficaButton.Position = [11 38 158 22];

            % Create AnlisisconjuntoButton
            app.AnlisisconjuntoButton = uiradiobutton(app.SeleccioneelmodoButtonGroup);
            app.AnlisisconjuntoButton.Text = 'Análisis conjunto';
            app.AnlisisconjuntoButton.Position = [11 16 112 22];

            % Create Image3
            app.Image3 = uiimage(app.PositroniumMATUIFigure);
            app.Image3.Position = [500 6 30 29];
            app.Image3.ImageSource = fullfile(pathToMLAPP, 'ico', 'unam_logo.png');

            % Create Image3_2
            app.Image3_2 = uiimage(app.PositroniumMATUIFigure);
            app.Image3_2.Position = [541 6 31 29];
            app.Image3_2.ImageSource = fullfile(pathToMLAPP, 'ico', 'fc.png');

            % Create directorio1EditFieldLabel
            app.directorio1EditFieldLabel = uilabel(app.PositroniumMATUIFigure);
            app.directorio1EditFieldLabel.HorizontalAlignment = 'right';
            app.directorio1EditFieldLabel.Position = [200 286 61 22];
            app.directorio1EditFieldLabel.Text = 'directorio1';

            % Create directorio1EditField
            app.directorio1EditField = uieditfield(app.PositroniumMATUIFigure, 'text');
            app.directorio1EditField.Editable = 'off';
            app.directorio1EditField.Position = [276 286 261 22];

            % Create directorio2EditFieldLabel
            app.directorio2EditFieldLabel = uilabel(app.PositroniumMATUIFigure);
            app.directorio2EditFieldLabel.HorizontalAlignment = 'right';
            app.directorio2EditFieldLabel.Visible = 'off';
            app.directorio2EditFieldLabel.Position = [200 255 61 22];
            app.directorio2EditFieldLabel.Text = 'directorio2';

            % Create directorio2EditField
            app.directorio2EditField = uieditfield(app.PositroniumMATUIFigure, 'text');
            app.directorio2EditField.Editable = 'off';
            app.directorio2EditField.Visible = 'off';
            app.directorio2EditField.Position = [276 255 261 22];

            % Create CargarButton
            app.CargarButton = uibutton(app.PositroniumMATUIFigure, 'push');
            app.CargarButton.ButtonPushedFcn = createCallbackFcn(app, @CargarButtonPushed, true);
            app.CargarButton.Enable = 'off';
            app.CargarButton.Position = [476 203 100 23];
            app.CargarButton.Text = 'Cargar';

            % Create Button
            app.Button = uibutton(app.PositroniumMATUIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Icon = fullfile(pathToMLAPP, 'ico', 'open.png');
            app.Button.Enable = 'off';
            app.Button.Position = [542 287 29 23];
            app.Button.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.PositroniumMATUIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.Icon = fullfile(pathToMLAPP, 'ico', 'open.png');
            app.Button_2.Enable = 'off';
            app.Button_2.Visible = 'off';
            app.Button_2.Position = [542 255 29 23];
            app.Button_2.Text = '';

            % Create outputTextArea
            app.outputTextArea = uitextarea(app.PositroniumMATUIFigure);
            app.outputTextArea.FontColor = [0 1 0];
            app.outputTextArea.BackgroundColor = [0 0 0];
            app.outputTextArea.Position = [16 47 555 109];

            % Create SeleccionarButton
            app.SeleccionarButton = uibutton(app.PositroniumMATUIFigure, 'push');
            app.SeleccionarButton.ButtonPushedFcn = createCallbackFcn(app, @SeleccionarButtonPushed, true);
            app.SeleccionarButton.Enable = 'off';
            app.SeleccionarButton.Position = [368 203 100 23];
            app.SeleccionarButton.Text = 'Seleccionar';

            % Show the figure after all components are created
            app.PositroniumMATUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main0

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PositroniumMATUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PositroniumMATUIFigure)
        end
    end
end