classdef main2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PositroniumdotMATMododetomografaUIFigure  matlab.ui.Figure
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
        UIAxes4                       matlab.ui.control.UIAxes
        UIAxes3                       matlab.ui.control.UIAxes
        UIAxes2                       matlab.ui.control.UIAxes
        UIAxes                        matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        output
        mod2DIR
        cortes
        well_enable = 0;
        buttonDown_PET_enable = 0;
        buttonDown_CT_enable = 0;
        buttonDown_fusion_enable = 0;
        %%
        topogram_index
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
        roi_map
        viewROI_true = 0;
        cambiar_x_y = false;
        CT_resized
        fused
        %%
        running = true
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
            UIAXES.XLim = [1,ancho];
            UIAXES.YLim = [1,altura];
            topograma = matrix(val1:val2,val3:val4,1);
            app.output = "Tamaño de topograma: "+convertCharsToStrings(int2str(size(topograma)))+newline+app.output; 
            app.outputTextArea.Value =  app.output; drawnow limitrate
            imshow(topograma,[900 1200], 'Parent', UIAXES)
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

        
        function [volumen,info, loc_vector,tiempo,RescaleSlope] = load_dicom_data(~,directorio,carpeta,modalidad,cortes,pt_true)
            % cargamos la lista de archivos en la carpeta
            % WindowWidth,ancho,altura,ImagePositionPatient,PixelSpacing
            lista = dir(fullfile(directorio,carpeta,modalidad));
            if pt_true == 1
                lista = flipud([char({lista.name})]);
            else
                lista = [char({lista.name})];
            end
            info = dicominfo(fullfile(directorio,carpeta,lista(1,:)));
            ancho = double(info.Width);
            altura = double(info.Height);
            volumen = zeros(altura,ancho,cortes,'uint16');
            loc_vector = zeros(1,cortes);
            tiempo = zeros(1,cortes);
            RescaleSlope = zeros(1,cortes);
            for n = 1:cortes
                info_corte = dicominfo(fullfile(directorio,carpeta,lista(n,:)));
                AcquisitionTime = info_corte.AcquisitionTime;
                RescaleSlope(1,n) = info_corte.RescaleSlope;
                hora = str2double(AcquisitionTime(1:2));
                minutos = str2double(AcquisitionTime(3:4));
                segundos = str2double(AcquisitionTime(5:end));
                tiempo(1,n) = hora*60+minutos+segundos/60;
                info = dicominfo(fullfile(directorio,carpeta,lista(n,:)));
                loc_vector(1,n) = info.SliceLocation;
                volumen(:,:,n) = dicomread(info); 
            end
            
        end
        function [lines] = crosshair_lines(~,x,y,UI_AXES)
            
            lineX = xline(UI_AXES, x,'Color','y','linewidth',0.8,"HitTest","off");
            lineY = yline(UI_AXES, y,'Color','y','linewidth',0.8,"HitTest","off");
            lines = [lineX, lineY];
        end
        
        function []= draw_figs(app,corte,x,y)
            
            corte =  round(corte);
            if app.roi_activated 
                ROI_map_SUV_CT(app,x,y,app.SUV_pt(:,:,corte))
            end
            imagesc(app.UIAxes,app.ct_volume(:,:,corte),"HitTest","off",[app.ct_info.WindowWidth(1),app.ct_info.WindowWidth(2)]);colormap(app.UIAxes,"gray");
            app.UIAxes.PlotBoxAspectRatio = [app.ct_info.Width/app.ct_info.Height, 1, 1];
            if app.ptu_true == 0
                title(app.UIAxes2, 'PET')
                app.CT_resized = imresize(app.ct_volume(:,:,corte),[app.pt_edges_pixel(2)-app.pt_edges_pixel(1)+1,app.pt_edges_pixel(4)-app.pt_edges_pixel(3)+1]);
                maxSUV = max(max(app.SUV_pt(:,:,corte)));
                if app.PETPETuButton.Value == 1
                      imagesc(app.UIAxes2,app.pt_volume(:,:,corte),"HitTest","off",[0 65535]);colormap(app.UIAxes2,"jet");
                      PT = ind2rgb(app.pt_volume(:,:,corte), jet(2^16));
                      c = colorbar(app.UIAxes3,'TickLabels',{'0',int2str(app.pt_info.LargestImagePixelValue/6),int2str(2*app.pt_info.LargestImagePixelValue/6),int2str(3*app.pt_info.LargestImagePixelValue/6),int2str(4*app.pt_info.LargestImagePixelValue/6),int2str(5*app.pt_info.LargestImagePixelValue/6),int2str(app.pt_info.LargestImagePixelValue)});
                      colormap(app.UIAxes3,jet); 
                      c.Label.String = 'Intensidad de Píxel'; 
                      app.UIAxes3.FontSize = 10; 
                elseif app.SUVButton.Value == 1
                      imagesc(app.UIAxes2,app.SUV_pt(:,:,corte),"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"jet");
                      PT = ind2rgb(uint8(256*app.SUV_pt(:,:,corte)/maxSUV), jet(256));
                      c = colorbar(app.UIAxes3,'TickLabels',{'0',sprintf('%.3f',maxSUV/6),sprintf('%.3f',2*maxSUV/6),sprintf('%.3f',3*maxSUV/6),sprintf('%.3f',4*maxSUV/6),sprintf('%.3f',5*maxSUV/6),sprintf('%.3f',maxSUV)});
                      colormap(app.UIAxes3,jet); 
                      c.Label.String = 'Valor SUV'; 
                      app.UIAxes3.FontSize = 10; 
                elseif app.ROIButton.Value == 1
                      imagesc(app.UIAxes2,app.roi_map,"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"gray");
                      PT = ind2rgb(uint8(256*app.SUV_pt(:,:,corte)/maxSUV), jet(256));
                      c = colorbar(app.UIAxes3,'TickLabels',{'0',sprintf('%.3f',maxSUV/6),sprintf('%.3f',2*maxSUV/6),sprintf('%.3f',3*maxSUV/6),sprintf('%.3f',4*maxSUV/6),sprintf('%.3f',5*maxSUV/6),sprintf('%.3f',maxSUV)});
                      colormap(app.UIAxes3,jet); 
                      c.Label.String = 'Valor SUV'; 
                      app.UIAxes3.FontSize = 10; 
                      
                end
                CT = ind2rgb(app.CT_resized-app.ct_info.WindowWidth(1), gray(1200-app.ct_info.WindowWidth(1)));
                app.fused = CT*app.AlphaCTSlider.Value + PT*(app.AlphaPETSlider.Value);
                app.fused = im2uint8(app.fused);
                %%
                if (app.SegmentadoCTButton.Value == 1 || app.SegmentadoPETButton.Value ==1 || app.SegmentadoSUVButton.Value == 1) && app.VerROICheckBox.Value == 0
                    tam = size(PT);
                    matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;%matriz_amarilla(:,:,3) = 0;
                    borde_roi = edge(app.roi_map,char(app.DeteccindebordeDropDown.Items(app.DeteccindebordeDropDown.Value)));
                    matriz_amarilla = uint8(borde_roi).*matriz_amarilla;
                    app.fused = uint8(not(borde_roi)).*app.fused;
                    app.fused= app.fused + matriz_amarilla;
                end
                if app.SegmentadoCTButton.Value == 1 || app.SegmentadoPETButton.Value ==1 || app.SegmentadoSUVButton.Value == 1
                    segment_data(app,app.SUV_pt(:,:,corte))
                end

                %
                %%
                if app.viewROI_true == 0
                    imagesc(app.UIAxes3,app.fused,"HitTest","off",[app.ct_info.WindowWidth(1),app.ct_info.WindowWidth(2)]);
                elseif app.viewROI_true == 1
                    imagesc(app.UIAxes3,uint8(app.roi_map).*app.fused,"HitTest","off",[app.ct_info.WindowWidth(1),app.ct_info.WindowWidth(2)]);
                end
                
                %
                app.UIAxes2.PlotBoxAspectRatio = [app.pt_info.Width/app.pt_info.Height, 1, 1];
                app.UIAxes2.XLim = [1, app.pt_edges_pixel(4)-app.pt_edges_pixel(3)+1];
                app.UIAxes2.YLim = [1, app.pt_edges_pixel(2)-app.pt_edges_pixel(1)+1];
                app.UIAxes3.XLim = [1, app.pt_edges_pixel(4)-app.pt_edges_pixel(3)+1];
                app.UIAxes3.YLim = [1, app.pt_edges_pixel(2)-app.pt_edges_pixel(1)+1];

              
                % tiempo char
                d = minutes(app.pt_time(corte));d.Format = 'hh:mm:ss.SS';
                app.DDMMAAAAalasHHMMSSLabel.Text = ['AcquisitionDateTime ',char(d)];
                app.Actividad0Label.Text = ['A_0 = ',sprintf('%.3f',app.pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideTotalDose* ...
                    2.7027027027027*10^(-8)),' mCi'];
               app.vidamediaLabel.Text = ['t_1/2 = ' sprintf('%.1f',app.pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideHalfLife/60) ' m'];
               app.radionuclidoLabel.Text= app.pt_info.RadiopharmaceuticalInformationSequence.Item_1.Radiopharmaceutical;
                
                
            else
                title(app.UIAxes2, 'PET sin corregir')
                CT_resized_1 = imresize(app.ct_volume(:,:,corte),[app.pt_edges_pixel(2)-app.pt_edges_pixel(1)+1,app.pt_edges_pixel(4)-app.pt_edges_pixel(3)+1]);
                maxSUV = max(max(app.SUV_pt(:,:,corte)));
                if app.PETPETuButton.Value == 1
                    imagesc(app.UIAxes2,app.ptu_volume(:,:,corte),"HitTest","off",[0 65535]);colormap(app.UIAxes2,"jet");                
                    PT = ind2rgb(app.ptu_volume(:,:,corte), jet(2^16));
                    c = colorbar(app.UIAxes3,'TickLabels',{'0',int2str(app.pt_info.LargestImagePixelValue/6),int2str(2*app.pt_info.LargestImagePixelValue/6),int2str(3*app.pt_info.LargestImagePixelValue/6),int2str(4*app.pt_info.LargestImagePixelValue/6),int2str(5*app.pt_info.LargestImagePixelValue/6),int2str(app.pt_info.LargestImagePixelValue)});
                    colormap(app.UIAxes3,jet); 
                    c.Label.String = 'Intensidad de Píxel'; 
                    app.UIAxes3.FontSize = 10; 
                elseif app.SUVButton.Value == 1
                    imagesc(app.UIAxes2,app.SUV_ptu(:,:,corte),"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"jet");                
                    PT = ind2rgb(uint8(256*app.SUV_ptu(:,:,corte)/maxSUV), jet(256));
                    c = colorbar(app.UIAxes3,'TickLabels',{'0',sprintf('%.3f',maxSUV/6),sprintf('%.3f',2*maxSUV/6),sprintf('%.3f',3*maxSUV/6),sprintf('%.3f',4*maxSUV/6),sprintf('%.3f',5*maxSUV/6),sprintf('%.3f',maxSUV)});
                    colormap(app.UIAxes3,jet); 
                    c.Label.String = 'Valor SUV'; 
                    app.UIAxes3.FontSize = 10; 
                elseif app.ROIButton.Value == 1
                    imagesc(app.UIAxes2,app.roi_map,"HitTest","off",[0 maxSUV]);colormap(app.UIAxes2,"gray");
                    PT = ind2rgb(uint8(256*app.SUV_ptu(:,:,corte)/maxSUV), jet(256));
                    c = colorbar(app.UIAxes3,'TickLabels',{'0',sprintf('%.3f',maxSUV/6),sprintf('%.3f',2*maxSUV/6),sprintf('%.3f',3*maxSUV/6),sprintf('%.3f',4*maxSUV/6),sprintf('%.3f',5*maxSUV/6),sprintf('%.3f',maxSUV)});
                    colormap(app.UIAxes3,jet); 
                    c.Label.String = 'Valor SUV'; 
                    app.UIAxes3.FontSize = 10; 
                end
                CT = ind2rgb(CT_resized_1-app.ct_info.WindowWidth(1), gray(1200-app.ct_info.WindowWidth(1)));
                
                app.fused = CT*app.AlphaCTSlider.Value + PT*(app.AlphaPETSlider.Value);
                app.fused = im2uint8(app.fused);
                imagesc(app.UIAxes3,app.fused,"HitTest","off",[app.ct_info.WindowWidth(1),app.ct_info.WindowWidth(2)]);
                if app.viewROI_true == 0
                    imagesc(app.UIAxes3,app.fused,"HitTest","off",[app.ct_info.WindowWidth(1),app.ct_info.WindowWidth(2)]);
                elseif app.viewROI_true == 1
                    imagesc(app.UIAxes3,uint8(app.roi_map).*app.fused,"HitTest","off",[app.ct_info.WindowWidth(1),app.ct_info.WindowWidth(2)]);
                end
                %
                app.UIAxes2.PlotBoxAspectRatio = [app.ptu_info.Width/app.ptu_info.Height, 1, 1];
                app.UIAxes2.XLim = [1, app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1];
                app.UIAxes2.YLim = [1, app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1];
                app.UIAxes3.XLim = [1, app.ptu_edges_pixel(4)-app.ptu_edges_pixel(3)+1];
                app.UIAxes3.YLim = [1, app.ptu_edges_pixel(2)-app.ptu_edges_pixel(1)+1];
                % tiempo char
                d = minutes(app.ptu_time(corte));d.Format = 'hh:mm:ss.SS';
                app.DDMMAAAAalasHHMMSSLabel.Text = ['AcquisitionDateTime ',char(d)];
                
                
            end
            app.UIAxes.XLim = [1, app.ct_info.Width];
            app.UIAxes.YLim = [1, app.ct_info.Height];
            app.UIAxes.YDir = 'reverse';
            app.UIAxes2.YDir = 'reverse';
            app.UIAxes3.YDir = 'reverse';
            y=app.topogram_index(corte);
            delete(app.tp_line)
            app.tp_line=yline(app.UIAxes4, y,'Color',[0,128/255,128/255],'linewidth',1);
            rule_new_fig(app)
            
            if app.roi_activated %&& not(app.ptu_true)
                ROI_fig_SUV_CT(app)
            end
            %%
            
            
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
            app.FX1FY1Label.Visible = "off";
            app.FX2FY2Label.Visible = "off";
            app.SUVMEANLabel.Visible = "off";
            app.SUVMAXLabel.Visible = "off";
            roi_map_previo = zeros(size(app.pt_volume(:,:,1)),'logical');
            delete([app.PT_p1,app.PT_p2,app.roi_fig])
            if app.roi_state
                app.FX1FY1Label.Visible = "on";
                if app.cambiar_x_y 
                    app.PT_xy_p1 =[x, y];
                end
                %app.PT_p1 = plot(app.UIAxes3,app.PT_xy_p1(1),app.PT_xy_p1(2),'o','color','c',"HitTest","off");
                app.FX1FY1Label.Text = ['(',int2str(app.PT_xy_p1(1)),',',int2str(app.PT_xy_p1(2)),')'];
            end
            if not(app.roi_state)
                app.FX1FY1Label.Visible = "on";
                app.FX2FY2Label.Visible = "on";
                app.SUVMEANLabel.Visible = "on";
                app.SUVMAXLabel.Visible = "on";
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
                    SUVchar = sprintf('%.2f',mean(roi_vec));
                    SUVSDchar = sprintf('%.2f',std(roi_vec));
                    app.SUVMEANLabel.Text = ['SUV_MEAN = ',SUVchar,char(177),SUVSDchar];
                    SUVchar = sprintf('%.2f',max(roi_vec));
                    app.SUVMAXLabel.Text = ['SUV_MAX = ',SUVchar];
                        
                elseif app.CircularButton.Value == 1
                    tam = size(app.pt_volume(:,:,1));
                    [x,y] = meshgrid(1:tam(2),1:tam(1));
                    roi_map_previo(sqrt((x-app.PT_xy_p1(1)).^2+(y-app.PT_xy_p1(2)).^2)<=norm(app.PT_xy_p2-app.PT_xy_p1)) = true;
                    app.roi_map = roi_map_previo;
                    roi_vec = SUV_volume_corte(app.roi_map);
                    SUVchar = sprintf('%.2f',mean(roi_vec));
                    SUVSDchar = sprintf('%.2f',std(roi_vec));
                    app.SUVMEANLabel.Text = ['SUV_MEAN = ',SUVchar,char(177),SUVSDchar];
                    SUVchar = sprintf('%.2f',max(roi_vec));
                    app.SUVMAXLabel.Text = ['SUV_MAX = ',SUVchar];
                end
                
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
                        app.roi_fig = viscircles(app.UIAxes3,app.PT_xy_p1,norm(app.PT_xy_p2-app.PT_xy_p1),'Color','y');
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
            roi_vec = SUV_volume(app.roi_map);
            SUVchar = sprintf('%.2f',mean(roi_vec));
            SUVSDchar = sprintf('%.2f',std(roi_vec));
            app.SUVMEANLabel.Text = ['SUV_MEAN = ',SUVchar,char(177),SUVSDchar];
            SUVchar = sprintf('%.2f',max(roi_vec));
            app.SUVMAXLabel.Text = ['SUV_MAX = ',SUVchar];

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
                    ct_dir = fullfile(app.mod2DIR,'SE000001','*CT*');
                    pt_dir = fullfile(app.mod2DIR,'SE000003','*PT*');
                    ptu_dir =fullfile(app.mod2DIR,'SE000004','*PT*');
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
                app.CorrerButton.Enable = "off"; drawnow limitrate
                pause(0.5)
                app.output = "Cargando imágenes...."+newline+app.output; 
                app.outputTextArea.Value =  app.output; drawnow limitrate
                [app.ct_volume,app.ct_info,loc_vector,app.ct_time,~]  = load_dicom_data(app,app.mod2DIR,'SE000001','*CT*',app.cortes,0);
                app.output = "[OK] Imágenes CT cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                [app.pt_volume,app.pt_info,~,app.pt_time,pt_RescaleSlope]  = load_dicom_data(app,app.mod2DIR,'SE000003','*PT*',app.cortes,1);
                app.output = "[OK] Imágenes PET cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                [app.ptu_volume,app.ptu_info,~,app.ptu_time,ptu_RescaleSlope]  = load_dicom_data(app,app.mod2DIR,'SE000004','*PT*',app.cortes,1);
                app.output = "[OK] Imágenes PET sin corregir cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                
    
                ct_edges = [app.ct_info.ImagePositionPatient(1),2*app.ct_info.ReconstructionTargetCenterPatient(1)-app.ct_info.ImagePositionPatient(1),...
                    app.ct_info.ImagePositionPatient(2),2*app.ct_info.ReconstructionTargetCenterPatient(2)-app.ct_info.ImagePositionPatient(2)];
                app.pt_edges_pixel = round([(ct_edges(3)-app.pt_info.ImagePositionPatient(2))/app.pt_info.PixelSpacing(2),(ct_edges(4)-app.pt_info.ImagePositionPatient(2))/app.pt_info.PixelSpacing(2)...
                    (ct_edges(1)-app.pt_info.ImagePositionPatient(1))/app.pt_info.PixelSpacing(1),(ct_edges(2)-app.pt_info.ImagePositionPatient(1))/app.pt_info.PixelSpacing(1)]+1);
                app.ptu_edges_pixel = round([(ct_edges(3)-app.ptu_info.ImagePositionPatient(2))/app.ptu_info.PixelSpacing(2),(ct_edges(4)-app.ptu_info.ImagePositionPatient(2))/app.ptu_info.PixelSpacing(2)...
                    (ct_edges(1)-app.ptu_info.ImagePositionPatient(1))/app.ptu_info.PixelSpacing(1),(ct_edges(2)-app.ptu_info.ImagePositionPatient(1))/app.ptu_info.PixelSpacing(1)]+1);
                
                app.ct_info.WindowWidth(1) = 900;
                
                app.SUV_pt = SUVolume(app, app.pt_volume(app.pt_edges_pixel(1):app.pt_edges_pixel(2),app.pt_edges_pixel(3):app.pt_edges_pixel(4),:), ...
                    app.pt_info,pt_RescaleSlope,app.pt_time,app.cortes);
                app.output = "[OK] SUV calculado correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                app.SUV_ptu = SUVolume(app, app.ptu_volume(app.ptu_edges_pixel(1):app.ptu_edges_pixel(2),app.ptu_edges_pixel(3):app.ptu_edges_pixel(4),:), ...
                    app.ptu_info,ptu_RescaleSlope,app.ptu_time,app.cortes);
                app.output = "[OK] SUV sin corregir calculado correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                %%
                app.pt_volume = app.pt_volume(app.pt_edges_pixel(1):app.pt_edges_pixel(2),app.pt_edges_pixel(3):app.pt_edges_pixel(4),:);
                app.ptu_volume = app.ptu_volume(app.ptu_edges_pixel(1):app.ptu_edges_pixel(2),app.ptu_edges_pixel(3):app.ptu_edges_pixel(4),:);
                app.output = "[OK] Datos PET/PETu cortados correctamente."+newline+app.output;
                %%
                app.outputTextArea.Value =  app.output; drawnow limitrate
                [loc_slice,pixel_spacing,~,~] = get_topograma(app,app.mod2DIR,'SE000000',app.UIAxes4);
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
                app.CorrerButton.Enable = "on"; drawnow limitrate
                pause(0.5)
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
                elseif posicion>app.cortes
                    app.CorteSlider.Value = app.cortes;
                else
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
                %app.FX1FY1Label.Visible = "off";
                %app.FX2FY2Label.Visible = "off";
                %app.SUVMEANLabel.Visible = "off";
                %app.SUVMAXLabel.Visible = "off";
                %app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
                %delete([app.PT_p1,app.PT_p2,app.roi_fig])
                %app.ROIlowEditField.Enable ="off";
                %app.ROIhightEditField.Enable = "off";
                %app.OpmofolgicaDropDown.Enable = "off";
                %app.OpmofolgicaDropDown.Value = 1;
                %app.RadiomorfEditField.Enable = "off";
                %app.ErosionarButton.Enable = "off";
                %app.DilatarButton.Enable = "off";
                %%
               

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
            
            if app.NingunaButton.Value == 0 && app.SegmentadoCTButton.Value == 0 && app.SegmentadoPETButton.Value == 0
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
                app.ROIlowEditField.Value = app.ct_info.WindowWidth(1);
                app.ROIhightEditField.Value = app.ct_info.WindowWidth(2);
                app.roi_map = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
            elseif app.SegmentadoPETButton.Value == 1
                app.ROIlowEditField.Value = round(0.8*double(app.pt_info.LargestImagePixelValue));
                app.ROIhightEditField.Value = double(app.pt_info.LargestImagePixelValue);
                app.roi_map = roicolor(app.pt_volume(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
            elseif app.SegmentadoSUVButton.Value == 1
                app.ROIlowEditField.Value = round(0.8*max(max(app.SUV_pt(:,:,round(app.CorteSlider.Value)))));
                app.ROIhightEditField.Value = max(max(app.SUV_pt(:,:,round(app.CorteSlider.Value))));
                app.roi_map = roicolor(app.SUV_pt(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
            end
            if app.SegmentadoCTButton.Value == 1 || app.SegmentadoPETButton.Value ==1 || app.SegmentadoSUVButton.Value == 1
                
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
            app.roi_map = ones(size(app.pt_volume(:,:,1)),'logical');
            if app.SegmentadoCTButton.Value == 1
                app.ROIlowEditField.Value = app.ct_info.WindowWidth(1);
                app.ROIhightEditField.Value = app.ct_info.WindowWidth(2);
                app.roi_map = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
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
            estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
            app.roi_map = imdilate(app.roi_map,estruc);
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Button pushed function: ErosionarButton
        function ErosionarButtonPushed(app, event)
            estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
            app.roi_map = imerode(app.roi_map,estruc);
            draw_figs(app,app.CorteSlider.Value,1,1)
            lines_and_info(app,app.CorteSlider.Value)
        end

        % Value changed function: DeteccindebordeDropDown
        function DeteccindebordeDropDownValueChanged(app, event)
            %value = app.DeteccindebordeDropDown.Value;
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
            imwrite(app.fused, new_imag_dir);
            app.output = "[OK] Imagen guardada como: " + convertCharsToStrings(new_imag_dir) + newline + app.output;
            app.outputTextArea.Value = app.output;
            pause(1)
            app.GuardarButton.Enable = "on";
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
            title(app.UIAxes2, 'PET/PET uncorrected')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Toolbar.Visible = 'off';
            app.UIAxes2.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes2.XTick = [];
            app.UIAxes2.YTick = [];
            app.UIAxes2.ButtonDownFcn = createCallbackFcn(app, @UIAxes2ButtonDown, true);
            app.UIAxes2.Position = [386 328 366 366];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.PositroniumdotMATMododetomografaUIFigure);
            title(app.UIAxes3, 'Fusión PET/CT')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.Toolbar.Visible = 'off';
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
            app.UIAxes4.XTick = [];
            app.UIAxes4.YTick = [];
            app.UIAxes4.Position = [21 14 258 297];

            % Create CorrerButton
            app.CorrerButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.CorrerButton.ButtonPushedFcn = createCallbackFcn(app, @CorrerButtonPushed, true);
            app.CorrerButton.Icon = fullfile(pathToMLAPP, 'ico', 'run.png');
            app.CorrerButton.Position = [505 20 100 23];
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
            app.AlphaCTSlider.Enable = 'off';
            app.AlphaCTSlider.FontSize = 9;
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
            app.AlphaPETSlider.Enable = 'off';
            app.AlphaPETSlider.FontSize = 9;
            app.AlphaPETSlider.Position = [937 42 116 3];
            app.AlphaPETSlider.Value = 0.5;

            % Create CorteSliderLabel
            app.CorteSliderLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.CorteSliderLabel.HorizontalAlignment = 'right';
            app.CorteSliderLabel.Position = [506 96 34 22];
            app.CorteSliderLabel.Text = 'Corte';

            % Create CorteSlider
            app.CorteSlider = uislider(app.PositroniumdotMATMododetomografaUIFigure);
            app.CorteSlider.Limits = [1 97];
            app.CorteSlider.ValueChangedFcn = createCallbackFcn(app, @CorteSliderValueChanged, true);
            app.CorteSlider.Enable = 'off';
            app.CorteSlider.Position = [506 88 380 3];
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
            app.XX1YY1Label.Interpreter = 'latex';
            app.XX1YY1Label.FontColor = [0 1 1];
            app.XX1YY1Label.Visible = 'off';
            app.XX1YY1Label.Position = [40 331 75 22];
            app.XX1YY1Label.Text = '(XX1,YY1)';

            % Create XX2YY2Label
            app.XX2YY2Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.XX2YY2Label.Interpreter = 'latex';
            app.XX2YY2Label.HorizontalAlignment = 'right';
            app.XX2YY2Label.FontColor = [0 1 0];
            app.XX2YY2Label.Visible = 'off';
            app.XX2YY2Label.Position = [293 331 75 22];
            app.XX2YY2Label.Text = '(XX2,YY2)';

            % Create DistanciaLabel
            app.DistanciaLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.DistanciaLabel.Interpreter = 'latex';
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
            app.SeleccindeROIButtonGroup.Position = [287 136 191 166];

            % Create NingunaButton
            app.NingunaButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.NingunaButton.Text = 'Ninguna';
            app.NingunaButton.Position = [11 123 67 22];
            app.NingunaButton.Value = true;

            % Create CircularButton
            app.CircularButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.CircularButton.Text = 'Circular';
            app.CircularButton.Position = [11 101 65 22];

            % Create RectangularButton
            app.RectangularButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.RectangularButton.Text = 'Rectangular';
            app.RectangularButton.Position = [11 79 87 22];

            % Create SegmentadoCTButton
            app.SegmentadoCTButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoCTButton.Text = 'Segmentado (CT)';
            app.SegmentadoCTButton.Position = [11 57 117 22];

            % Create SegmentadoPETButton
            app.SegmentadoPETButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoPETButton.Text = 'Segmentado (PET)';
            app.SegmentadoPETButton.Position = [11 34 125 22];

            % Create SegmentadoSUVButton
            app.SegmentadoSUVButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoSUVButton.Text = 'Segmentado (SUV)';
            app.SegmentadoSUVButton.Position = [11 11 126 22];

            % Create FX1FY1Label
            app.FX1FY1Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.FX1FY1Label.Interpreter = 'latex';
            app.FX1FY1Label.FontColor = [0 1 1];
            app.FX1FY1Label.Visible = 'off';
            app.FX1FY1Label.Position = [782 184 70 22];
            app.FX1FY1Label.Text = '(FX1,FY1)';

            % Create FX2FY2Label
            app.FX2FY2Label = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.FX2FY2Label.Interpreter = 'latex';
            app.FX2FY2Label.HorizontalAlignment = 'right';
            app.FX2FY2Label.FontColor = [0 1 0];
            app.FX2FY2Label.Visible = 'off';
            app.FX2FY2Label.Position = [1190 184 70 22];
            app.FX2FY2Label.Text = '(FX2,FY2)';

            % Create SUVMEANLabel
            app.SUVMEANLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.SUVMEANLabel.Interpreter = 'latex';
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
            app.VisualizacinButtonGroup.Position = [287 24 191 90];

            % Create PETPETuButton
            app.PETPETuButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.PETPETuButton.Text = 'PET/PETu';
            app.PETPETuButton.Position = [11 47 78 22];
            app.PETPETuButton.Value = true;

            % Create SUVButton
            app.SUVButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.SUVButton.Text = 'SUV';
            app.SUVButton.Position = [11 25 65 22];

            % Create ROIButton
            app.ROIButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.ROIButton.Text = 'ROI';
            app.ROIButton.Position = [11 2 43 22];

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
            app.DilatarButton.Position = [657 156 100 23];
            app.DilatarButton.Text = 'Dilatar';

            % Create ErosionarButton
            app.ErosionarButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.ErosionarButton.ButtonPushedFcn = createCallbackFcn(app, @ErosionarButtonPushed, true);
            app.ErosionarButton.Enable = 'off';
            app.ErosionarButton.Position = [657 122 100 23];
            app.ErosionarButton.Text = 'Erosionar';

            % Create SUVMAXLabel
            app.SUVMAXLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.SUVMAXLabel.Interpreter = 'latex';
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
            app.CerrarButton.Position = [800 20 100 23];
            app.CerrarButton.Text = 'Cerrar';

            % Create GuardarButton
            app.GuardarButton = uibutton(app.PositroniumdotMATMododetomografaUIFigure, 'push');
            app.GuardarButton.ButtonPushedFcn = createCallbackFcn(app, @GuardarButtonPushed, true);
            app.GuardarButton.Icon = fullfile(pathToMLAPP, 'ico', 'save.png');
            app.GuardarButton.Enable = 'off';
            app.GuardarButton.Position = [654 20 100 23];
            app.GuardarButton.Text = 'Guardar';

            % Create DeteccindebordeDropDownLabel
            app.DeteccindebordeDropDownLabel = uilabel(app.PositroniumdotMATMododetomografaUIFigure);
            app.DeteccindebordeDropDownLabel.HorizontalAlignment = 'right';
            app.DeteccindebordeDropDownLabel.Position = [628 271 109 22];
            app.DeteccindebordeDropDownLabel.Text = 'Detección de borde';

            % Create DeteccindebordeDropDown
            app.DeteccindebordeDropDown = uidropdown(app.PositroniumdotMATMododetomografaUIFigure);
            app.DeteccindebordeDropDown.Items = {'zerocross', 'log', 'Canny', 'approxcanny', 'Roberts', 'Prewitt', 'Sobel'};
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

            % Show the figure after all components are created
            app.PositroniumdotMATMododetomografaUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main2

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