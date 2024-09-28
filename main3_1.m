        classdef main3_1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PositroniumdotMATMododeanlisisconjunto2UIFigure  matlab.ui.Figure
        MaxSUVSlider               matlab.ui.control.Slider
        MaxSUVSliderLabel          matlab.ui.control.Label
        UILabel                    matlab.ui.control.Label
        SRNLabel                   matlab.ui.control.Label
        COVLabel                   matlab.ui.control.Label
        GuardarButton_2            matlab.ui.control.Button
        ResultadosButton           matlab.ui.control.Button
        VerVOICheckBox             matlab.ui.control.CheckBox
        AplicarButton              matlab.ui.control.Button
        SegEditField               matlab.ui.control.EditField
        SegEditFieldLabel          matlab.ui.control.Label
        ErosionarButton            matlab.ui.control.Button
        DilatarButton              matlab.ui.control.Button
        VerROICheckBox             matlab.ui.control.CheckBox
        HUXXXXXXLabel              matlab.ui.control.Label
        WindowLevelEditField       matlab.ui.control.NumericEditField
        WindowLevelEditFieldLabel  matlab.ui.control.Label
        WindowWidthEditField       matlab.ui.control.NumericEditField
        WindowWidthEditFieldLabel  matlab.ui.control.Label
        GuardarButton              matlab.ui.control.Button
        HerramientasDropDown       matlab.ui.control.DropDown
        HerramientasDropDownLabel  matlab.ui.control.Label
        AlphaPETSlider             matlab.ui.control.Slider
        AlphaPETSliderLabel        matlab.ui.control.Label
        AlphaCTSlider              matlab.ui.control.Slider
        AlphaCTSliderLabel         matlab.ui.control.Label
        CorteSlider                matlab.ui.control.Slider
        CorteSliderLabel           matlab.ui.control.Label
        RadiomorfEditField         matlab.ui.control.NumericEditField
        RadiomorfEditFieldLabel    matlab.ui.control.Label
        ROIhightEditField          matlab.ui.control.NumericEditField
        ROIhightEditFieldLabel     matlab.ui.control.Label
        ROIlowEditField            matlab.ui.control.NumericEditField
        ROIlowEditFieldLabel       matlab.ui.control.Label
        OpmofolgicaDropDown        matlab.ui.control.DropDown
        OpmofolgicaDropDownLabel   matlab.ui.control.Label
        DeteccindebordeDropDown    matlab.ui.control.DropDown
        ResetsegmentacinButton     matlab.ui.control.Button
        outputTextArea             matlab.ui.control.TextArea
        VisualizacinButtonGroup    matlab.ui.container.ButtonGroup
        VOIButton                  matlab.ui.control.RadioButton
        FusinButton                matlab.ui.control.RadioButton
        CTButton                   matlab.ui.control.RadioButton
        ROIButton                  matlab.ui.control.RadioButton
        SUVButton                  matlab.ui.control.RadioButton
        PETButton                  matlab.ui.control.RadioButton
        FusinSUVButton             matlab.ui.control.RadioButton
        SeleccindeROIButtonGroup   matlab.ui.container.ButtonGroup
        SegmentadoSUVButton        matlab.ui.control.RadioButton
        SegmentadoPETButton        matlab.ui.control.RadioButton
        SegmentadoCTButton         matlab.ui.control.RadioButton
        RectangularButton          matlab.ui.control.RadioButton
        CircularButton             matlab.ui.control.RadioButton
        NingunaButton              matlab.ui.control.RadioButton
        XX2YY2Label                matlab.ui.control.Label
        DistanciaLabel             matlab.ui.control.Label
        XX1YY1Label                matlab.ui.control.Label
        FX2FY2Label                matlab.ui.control.Label
        SUVMEANLabel               matlab.ui.control.Label
        SUVMAXLabel                matlab.ui.control.Label
        FX1FY1Label                matlab.ui.control.Label
        Actividad0Label            matlab.ui.control.Label
        DDMMAAAAalasHHMMSSLabel    matlab.ui.control.Label
        XXXXXXLabel                matlab.ui.control.Label
        XXXYYYLabel                matlab.ui.control.Label
        SUV0000Label               matlab.ui.control.Label
        radionuclidoLabel          matlab.ui.control.Label
        SeleccioneDropDown         matlab.ui.control.DropDown
        SeleccioneDropDownLabel    matlab.ui.control.Label
        Paso_zoomEditField         matlab.ui.control.NumericEditField
        Paso_zoomEditFieldLabel    matlab.ui.control.Label
        Button_2                   matlab.ui.control.Button
        Button                     matlab.ui.control.Button
        vidamediaLabel             matlab.ui.control.Label
        PositroniumButton          matlab.ui.control.Button
        CerrarButton_2             matlab.ui.control.Button
        CorrerButton               matlab.ui.control.Button
        UIAxes                     matlab.ui.control.UIAxes
        UIAxes2                    matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        output
        mod3DIR
        estudios_dir
        x_f;x_i
        num_estudios
        cortes
        running = true
        ct_volume;ct_info;ct_time
        pt_volume;pt_info;pt_time
        pt_edges_pixel
        ct_edges_on = 0
        SUV_pt
        roi_map
        %%
        ptu_edges_pixel
        %%
        global_max_SUV
        WW
        WL
        %%
        CT_resized 
        fused
        %%
        roi_activated = false;
        roi_CT_selected_state = true;
        PT_p1
        PT_p2
        roi_fig
        roi_state = false;
        cambiar_x_y = false
        %% 
        crosshair_fig
        buttonDown_enable = 0;
        CT_p1;CT_p2;CT_ln;CT_xy_p1;CT_xy_p2;rule_state
        %%
        pt_crosshair
        pt_crosshair_x
        pt_crosshair_y
        PT_xy_p1
        PT_xy_p2
        Fig_point_created = false
        %%
        roi_volume
        %%
        suv_results
        %%
        factor_decaimiento
        %%
        main_fig
    end
    
    properties (Access = public)
        %a % Description
    end
    
    methods (Access = private)
        
        function [volumen,info, loc_vector,tiempo,RescaleSlope,decay_factor] = load_dicom_data(~,directorio,carpeta,modalidad,cortes,xi,pt_true)
            % cargamos la lista de archivos en la carpeta
            % WindowWidth,ancho,altura,ImagePositionPatient,PixelSpacing
            lista = dir(fullfile(directorio,carpeta,modalidad));
            %if pt_true == 1
            %lista = flipud([char({lista.name})]);
            %else
            lista = [char({lista.name})];
            %end
            info = dicominfo(fullfile(directorio,carpeta,lista(1,:)));
            ancho = double(info.Width);
            altura = double(info.Height);
            loc_vector = zeros(1,cortes);
            tiempo = zeros(1,cortes);
            RescaleSlope = zeros(1,cortes);
            decay_factor = zeros(1,cortes);
            loc_slice = zeros(1,cortes);
            for n = 1:size(lista,1)
                info_corte = dicominfo(fullfile(directorio,carpeta,lista(n,:)));
                %n_corte_instance = info_corte.InstanceNumber;
                loc_slice(n) = info_corte.SliceLocation;
            end
            [~,Slicesorted] = sort(loc_slice);
            if pt_true
                volumen = zeros(altura,ancho,cortes,'uint16');
                for n = 1:cortes
                    info_corte = dicominfo(fullfile(directorio,carpeta,lista(Slicesorted(xi+n-1),:)));
                    decay_factor(1,n) = info_corte.DecayFactor;
                    AcquisitionTime = info_corte.AcquisitionTime;
                    %AcquisitionTime = info_corte.StudyTime;
                    RescaleSlope(1,n) = info_corte.RescaleSlope;
                    hora = str2double(AcquisitionTime(1:2));
                    minutos = str2double(AcquisitionTime(3:4));
                    segundos = str2double(AcquisitionTime(5:end));
                    tiempo(1,n) = hora*(60*60)+minutos*60+segundos;
                    loc_vector(1,n) = info_corte.SliceLocation;
                    volumen(:,:,n) = dicomread(info_corte); 
                end     
            end
            if not(pt_true)
                volumen = zeros(altura,ancho,cortes,'double');
                for n = 1:cortes
                    info_corte = dicominfo(fullfile(directorio,carpeta,lista(Slicesorted(xi+n-1),:)));
                    AcquisitionTime = info_corte.AcquisitionTime;
                    RescaleSlope(1,n) = info_corte.RescaleSlope;
                    hora = str2double(AcquisitionTime(1:2));
                    minutos = str2double(AcquisitionTime(3:4));
                    segundos = str2double(AcquisitionTime(5:end));
                    tiempo(1,n) = hora*(60*60)+minutos*60+segundos;
                    loc_vector(1,n) = info_corte.SliceLocation;
                    volumen(:,:,n) = double(dicomread(info_corte))*info_corte.RescaleSlope+info_corte.RescaleIntercept; 
                end     
            end

        end

        function []= draw_figs(app,corte,estudio_n)%,x,y)
            delete(app.main_fig)
            title(app.UIAxes, "Estudio "+int2str(estudio_n)+", corte "+int2str(corte))
            corte =  round(corte);
            app.FX1FY1Label.Visible = "off";
            app.FX2FY2Label.Visible = "off";
            %.("estudio_" + num2str(estudio_n))
            app.CT_resized = imresize(app.ct_volume.("estudio_" + num2str(estudio_n))(:,:,corte),size(app.pt_volume.("estudio_" + num2str(estudio_n))(:,:,corte)));
            if app.FusinSUVButton.Value
                maxSUV = app.global_max_SUV;%max(max(app.SUV_pt.("estudio_" + num2str(estudio_n))(:,:,corte)));
                PT = ind2rgb(uint8(256*app.SUV_pt.("estudio_" + num2str(estudio_n))(:,:,corte)/maxSUV), jet(256));
                CT = ind2rgb(int64(app.CT_resized-(app.WL-app.WW/2)), gray(app.WW));
                app.fused = CT*app.AlphaCTSlider.Value + PT*(app.AlphaPETSlider.Value);
                app.fused = im2uint8(app.fused);
                if (app.SegmentadoCTButton.Value == 1 || app.SegmentadoPETButton.Value == 1 || app.SegmentadoSUVButton.Value == 1) && app.VerROICheckBox.Value
                    tam = size(app.CT_resized);
                    matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;%matriz_amarilla(:,:,3) = 0;
                    borde_roi = edge(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)),char(app.DeteccindebordeDropDown.Items(app.DeteccindebordeDropDown.Value)));
                    matriz_amarilla = uint8(borde_roi).*matriz_amarilla;
                    app.fused = uint8(not(borde_roi)).*app.fused;
                    app.fused= app.fused + matriz_amarilla;                    
                end
                if (app.SegmentadoCTButton.Value == 1 || app.SegmentadoPETButton.Value == 1 || app.SegmentadoSUVButton.Value == 1) && app.VerVOICheckBox.Value
                    tam = size(app.CT_resized);
                    matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;%matriz_amarilla(:,:,3) = 0;
                    borde_roi = edge(app.roi_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,corte),char(app.DeteccindebordeDropDown.Items(app.DeteccindebordeDropDown.Value)));
                    matriz_amarilla = uint8(borde_roi).*matriz_amarilla;
                    app.fused = uint8(not(borde_roi)).*app.fused;
                    app.fused= app.fused + matriz_amarilla;                    
                end
                app.main_fig = imagesc(app.UIAxes,app.fused,"HitTest","off",[app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(1),app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(2)]);
                %c = colorbar(app.UIAxes,'TickLabels',{'0',sprintf('%.3f',maxSUV/6),sprintf('%.3f',2*maxSUV/6),sprintf('%.3f',3*maxSUV/6),sprintf('%.3f',4*maxSUV/6),sprintf('%.3f',5*maxSUV/6),sprintf('%.3f',maxSUV)});
                c = colorbar(app.UIAxes,'TickLabels',num2cell(linspace(0,maxSUV,9)));
                colormap(app.UIAxes,jet); 
                c.Label.String = 'Valor SUV'; 
                app.UIAxes.FontSize = 10;
                d = minutes(app.pt_time.("estudio_" + num2str(estudio_n))(corte));
            end
            if app.FusinButton.Value
                PT = ind2rgb(app.pt_volume.("estudio_" + num2str(estudio_n))(:,:,corte), jet(2^16));
                CT = ind2rgb(int64(app.CT_resized-(app.WL-app.WW/2)), gray(app.WW));
                %CT = ind2rgb(app.CT_resized-app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(1), gray(1200-app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(1)));
                app.fused = CT*app.AlphaCTSlider.Value + PT*(app.AlphaPETSlider.Value);
                app.fused = im2uint8(app.fused);
                if (app.SegmentadoCTButton.Value == 1 || app.SegmentadoPETButton.Value == 1 || app.SegmentadoSUVButton.Value == 1) && app.VerROICheckBox.Value
                    tam = size(app.CT_resized);
                    matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;%matriz_amarilla(:,:,3) = 0;
                    borde_roi = edge(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)),char(app.DeteccindebordeDropDown.Items(app.DeteccindebordeDropDown.Value)));
                    matriz_amarilla = uint8(borde_roi).*matriz_amarilla;
                    app.fused = uint8(not(borde_roi)).*app.fused;
                    app.fused= app.fused + matriz_amarilla;                    
                end
                if (app.SegmentadoCTButton.Value == 1 || app.SegmentadoPETButton.Value == 1 || app.SegmentadoSUVButton.Value == 1) && app.VerVOICheckBox.Value
                    tam = size(app.CT_resized);
                    matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;%matriz_amarilla(:,:,3) = 0;
                    borde_roi = edge(app.roi_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,corte),char(app.DeteccindebordeDropDown.Items(app.DeteccindebordeDropDown.Value)));
                    matriz_amarilla = uint8(borde_roi).*matriz_amarilla;
                    app.fused = uint8(not(borde_roi)).*app.fused;
                    app.fused= app.fused + matriz_amarilla;                    
                end
                app.main_fig = imagesc(app.UIAxes,app.fused,"HitTest","off",[app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(1),app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(2)]);
                c = colorbar(app.UIAxes,'TickLabels',num2cell(linspace(0,2^16,9)));
                colormap(app.UIAxes,jet); 
                c.Label.String = 'Intensidad de Pixel'; 
                app.UIAxes.FontSize = 10;
                d = minutes(app.pt_time.("estudio_" + num2str(estudio_n))(corte));
            end
            if app.PETButton.Value
               PT = ind2rgb(app.pt_volume.("estudio_" + num2str(estudio_n))(:,:,corte), jet(2^16));
               app.main_fig = imagesc(app.UIAxes,PT,"HitTest","off",[app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(1),app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(2)]);
               c = colorbar(app.UIAxes,'TickLabels',num2cell(linspace(0,2^16,9)));
                colormap(app.UIAxes,jet); 
                c.Label.String = 'Intensidad de Pixel'; 
                app.UIAxes.FontSize = 10;
                d = minutes(app.pt_time.("estudio_" + num2str(estudio_n))(corte));
            end
            if app.CTButton.Value
               app.main_fig = imagesc(app.UIAxes,app.CT_resized,"HitTest","off",[app.WL-app.WW/2,app.WL+app.WW/2]);colormap(app.UIAxes,"gray");
               app.UIAxes.PlotBoxAspectRatio = [app.ct_info.("estudio_" + num2str(estudio_n)).Width/app.ct_info.("estudio_" + num2str(estudio_n)).Height, 1, 1];
               c = colorbar(app.UIAxes,'TickLabels',num2cell(linspace(app.WL-app.WW/2,app.WL+app.WW/2,9)));
               colormap(app.UIAxes,gray); 
               c.Label.String = 'Densidad HU'; 
               app.UIAxes.FontSize = 10;
               d = minutes(app.ct_time.("estudio_" + num2str(estudio_n))(corte));
            end
            if app.SUVButton.Value
               maxSUV = app.global_max_SUV;%max(max(app.SUV_pt.("estudio_" + num2str(estudio_n))(:,:,corte)));
               PT = ind2rgb(uint8(256*app.SUV_pt.("estudio_" + num2str(estudio_n))(:,:,corte)/maxSUV), jet(256));
               app.main_fig = imagesc(app.UIAxes,PT,"HitTest","off",[app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(1),app.ct_info.("estudio_" + num2str(estudio_n)).WindowWidth(2)]);
               c = colorbar(app.UIAxes,'TickLabels',num2cell(linspace(0,maxSUV,9)));
               colormap(app.UIAxes,jet); 
               c.Label.String = 'Valor SUV'; 
               app.UIAxes.FontSize = 10;
               d = minutes(app.pt_time.("estudio_" + num2str(estudio_n))(corte));

            end
            if app.ROIButton.Value
               app.main_fig = imagesc(app.UIAxes,app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)),"HitTest","off",[0,1]);
               c = colorbar(app.UIAxes,'TickLabels',num2cell(linspace(0,1,9)));
               c.Label.String = 'ROI binario'; 
               app.UIAxes.FontSize = 10;
               colormap(app.UIAxes,gray); 
            end
            if app.VOIButton.Value
               app.main_fig = imagesc(app.UIAxes,app.roi_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,corte),"HitTest","off",[0,1]);
               c = colorbar(app.UIAxes,'TickLabels',num2cell(linspace(0,1,9)));
               c.Label.String = 'ROI binario'; 
               app.UIAxes.FontSize = 10;
               colormap(app.UIAxes,gray); 
            end
            
            app.UIAxes.PlotBoxAspectRatio = [1, 1, 1];
            tam = size(app.CT_resized);
            app.UIAxes.XLim = [1, tam(1)];
            app.UIAxes.YLim = [1, tam(2)];
            app.UIAxes.YDir = 'reverse';
            %%
            % tiempo char
            if app.ROIButton.Value == 1 || app.VOIButton.Value == 1
                app.DDMMAAAAalasHHMMSSLabel.Visible = "off";
                app.Actividad0Label.Visible ="off";
                app.vidamediaLabel.Visible = "off";
                app.radionuclidoLabel.Visible = "off";
            else
                app.DDMMAAAAalasHHMMSSLabel.Visible = "on";
                app.Actividad0Label.Visible ="on";
                app.vidamediaLabel.Visible = "on";
                app.radionuclidoLabel.Visible = "on";
                d.Format = 'hh:mm:ss.SS';
                app.DDMMAAAAalasHHMMSSLabel.Text = ['AcquisitionDateTime ',char(d)];
                app.Actividad0Label.Text = ['A_0 = ',sprintf('%.3f',app.pt_info.("estudio_" + num2str(estudio_n)).RadiopharmaceuticalInformationSequence.Item_1.RadionuclideTotalDose* ...
                    2.7027027027027*10^(-8)),' mCi'];
                app.vidamediaLabel.Text = ['t_1/2 = ' sprintf('%.1f',app.pt_info.("estudio_" + num2str(estudio_n)).RadiopharmaceuticalInformationSequence.Item_1.RadionuclideHalfLife/60) ' m'];
                app.radionuclidoLabel.Text= app.pt_info.("estudio_" + num2str(estudio_n)).RadiopharmaceuticalInformationSequence.Item_1.Radiopharmaceutical;
            end
            %%
            if app.HerramientasDropDown.Value == 2
                rule_new_fig(app)
            end
            if (app.CircularButton.Value==1 || app.RectangularButton.Value ==1 || app.SegmentadoCTButton.Value==1 ) && app.Fig_point_created
                ROI_fig_SUV_CT(app)
            end
            app.roi_CT_selected_state = true;
        end

        function SUV = SUVolume(~, PET_volume,pt_info,RescaleSlope,ad_time,cortes)
            PET_volume = double(PET_volume);
            actividad_0=pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideTotalDose;
            t_string = pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadiopharmaceuticalStartTime;
            hora = str2double(t_string(1:2));
            minutos = str2double(t_string(3:4));
            segundos = str2double(t_string(5:end));
            t1 = hora*60*60+minutos*60+segundos;
            vida_media=pt_info.RadiopharmaceuticalInformationSequence.Item_1.RadionuclideHalfLife;
            % factor_calibracion_dosis=pt_info.DoseCalibrationFactor;
            peso_paciente = pt_info.PatientWeight*1000;
            factor_calibracion_dosis =1;
            SUV = zeros(size(PET_volume));
            for n = 1:cortes
                t2 = ad_time(n);
                delta_t = t2-t1;
                actividad = actividad_0*exp(-delta_t*log(2)/vida_media);
                %factor_decaimiento(n) = 1;
                %RescaleSlope(n)
                %factor_decaimiento(n)
                %exp(-delta_t*log(2)/vida_media)
                SUV(:,:,n) = (PET_volume(:,:,n)*RescaleSlope(n)*factor_calibracion_dosis)*peso_paciente/actividad;
            end
        end
        function fig = get_crosshair(app,x,y)
            lineX = xline(app.UIAxes, x,'Color','y','linewidth',0.8,"HitTest","off");
            lineY = yline(app.UIAxes, y,'Color','y','linewidth',0.8,"HitTest","off");
            fig = [lineX, lineY];
        end
        function [] = componentes_on_off(app,on_off)
            app.DDMMAAAAalasHHMMSSLabel.Visible = on_off;
            app.Actividad0Label.Visible = on_off;
            app.vidamediaLabel.Visible = on_off;
            app.radionuclidoLabel.Visible = on_off;
            %%
            app.AlphaCTSlider.Enable = on_off;
            app.AlphaPETSlider.Enable = on_off;
            app.CorteSlider.Enable = on_off;
            app.buttonDown_enable = 1;
            hold(app.UIAxes,"on")
            app.SeleccindeROIButtonGroup.Enable = on_off;
            app.GuardarButton.Enable = on_off;
            app.SeleccioneDropDown.Enable = on_off;
            app.VisualizacinButtonGroup.Enable =on_off;
            app.WindowLevelEditField.Enable = on_off;
            app.WindowWidthEditField.Enable = on_off;
            app.HerramientasDropDown.Enable = on_off;
            app.VerROICheckBox.Enable = on_off;
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
                sprintf('%.2f',app.pt_info.("estudio_" + num2str(app.SeleccioneDropDown.Value)).PixelSpacing(1)/10*sqrt((app.CT_xy_p1(1) - app.CT_xy_p2(1))^2+(app.CT_xy_p1(2) - app.CT_xy_p2(2))^2)),' cm'];
                
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
            sprintf('%.2f',app.pt_info.("estudio_" + num2str(app.SeleccioneDropDown.Value)).PixelSpacing(1)/10*sqrt((app.CT_xy_p1(1) - app.CT_xy_p2(1))^2+(app.CT_xy_p1(2) - app.CT_xy_p2(2))^2)),' cm'];
            app.rule_state = false;
        end

        function [] = lines_and_info(app,corte)
            corte =  round(corte);
            app.XXXYYYLabel.Text = ['(',int2str(app.pt_crosshair_x),',',int2str(app.pt_crosshair_y),')'];
            app.XXXXXXLabel.Text = [int2str(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(app.pt_crosshair_y,app.pt_crosshair_x,corte))];
            app.HUXXXXXXLabel.Text = [int2str(app.CT_resized(app.pt_crosshair_y,app.pt_crosshair_x))];
            SUVchar = sprintf('%.3f',app.SUV_pt.("estudio_" + num2str(app.SeleccioneDropDown.Value))(app.pt_crosshair_y,app.pt_crosshair_x,corte));
            app.SUV0000Label.Text = ['SUV = ',SUVchar];
            delete(app.pt_crosshair)
            app.pt_crosshair = get_crosshair(app,app.pt_crosshair_x,app.pt_crosshair_y);
        end

        function [] = ROI_fig_SUV_CT(app)
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
                delete([app.PT_p1,app.PT_p2,app.roi_fig])
                app.FX1FY1Label.Visible = "off";
                app.FX2FY2Label.Visible = "off";
                if app.roi_state 
                    app.FX1FY1Label.Visible = "on";
                    app.PT_p1 = plot(app.UIAxes,app.PT_xy_p1(1),app.PT_xy_p1(2),'o','color','c',"HitTest","off");
                    app.FX1FY1Label.Text = ['(',int2str(app.PT_xy_p1(1)),',',int2str(app.PT_xy_p1(2)),')'];
                end
                if not(app.roi_state)
                    app.roi_activated = true;
                    app.cambiar_x_y = false;
                    app.FX1FY1Label.Visible = "on";
                    app.FX2FY2Label.Visible = "on";
                    app.FX1FY1Label.Text = ['(',int2str(app.PT_xy_p1(1)),',',int2str(app.PT_xy_p1(2)),')'];
                    app.FX2FY2Label.Text = ['(',int2str(app.PT_xy_p2(1)),',',int2str(app.PT_xy_p2(2)),')'];
                    app.PT_p1 = plot(app.UIAxes,app.PT_xy_p1(1),app.PT_xy_p1(2),'o','color','c',"HitTest","off");
                    app.PT_p2 = plot(app.UIAxes,app.PT_xy_p2(1),app.PT_xy_p2(2),'o','color','g',"HitTest","off");
                    if app.RectangularButton.Value == 1
                        x = min(app.PT_xy_p1(1),app.PT_xy_p2(1));
                        y = min(app.PT_xy_p1(2),app.PT_xy_p2(2));
                        w = abs(app.PT_xy_p2(1)-app.PT_xy_p1(1));
                        h = abs(app.PT_xy_p2(2)-app.PT_xy_p1(2));
                        app.roi_fig = rectangle(app.UIAxes,'Position',[x y w h],'EdgeColor','y');
                        gen_mean_SUV_info(app)
                    elseif app.CircularButton.Value == 1
                        app.roi_fig = viscircles(app.UIAxes,app.PT_xy_p1,norm(app.PT_xy_p2-app.PT_xy_p1),'EdgeColor','y','LineWidth',0.7);
                        gen_mean_SUV_info(app)
                    elseif app.SegmentadoCTButton.Value == 1
                        % roi segmentation
                        app.ROIlowEditField.Enable = "on";
                        app.ROIhightEditField.Enable ="on";
                        app.ResetsegmentacinButton.Enable = "off";
                        app.DeteccindebordeDropDown.Enable = "on";
                        % op morf
                        app.OpmofolgicaDropDown.Enable = "on";
                        app.OpmofolgicaDropDown.Value = 1;
                        app.RadiomorfEditField.Enable ="on";
                        app.ErosionarButton.Enable = "on";
                        app.DilatarButton.Enable="on";
                        %%
                        x = min(app.PT_xy_p1(1),app.PT_xy_p2(1));
                        y = min(app.PT_xy_p1(2),app.PT_xy_p2(2));
                        w = abs(app.PT_xy_p2(1)-app.PT_xy_p1(1));
                        h = abs(app.PT_xy_p2(2)-app.PT_xy_p1(2));
                        app.roi_fig = rectangle(app.UIAxes,'Position',[x y w h],'EdgeColor','y');
                    end
                end
            end
        
            function [] = gen_mean_SUV_info(app)
                app.SUVMEANLabel.Visible = "on";
                app.SUVMAXLabel.Visible = "on";
                app.COVLabel.Visible = "on";
                app.UILabel.Visible = "on";
                app.SRNLabel.Visible = "on";
                suv_corte = app.SUV_pt.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value);

                
                if app.SegmentadoPETButton.Value == 1
                    %app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    roi_vec = suv_corte(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)));
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
                elseif app.SegmentadoSUVButton.Value == 1 
                    %app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.SUV_pt.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    roi_vec = suv_corte(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)));
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
                elseif app.RectangularButton.Value == 1 && app.roi_activated
                    roi_map_previo = zeros(size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,1)),'logical');
                    roi_map_previo(min(app.PT_xy_p1(2),app.PT_xy_p2(2)):max(app.PT_xy_p1(2),app.PT_xy_p2(2)),...
                        min(app.PT_xy_p1(1),app.PT_xy_p2(1)):max(app.PT_xy_p1(1),app.PT_xy_p2(1))) = true;
                    app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roi_map_previo;
                    %%
                    roi_vec = suv_corte(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)));
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
                elseif app.SegmentadoCTButton.Value == 1 && app.roi_activated
                    if  app.roi_CT_selected_state
                        app.CT_resized = imresize(app.ct_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value)));
                        app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);                
                        roi_map_previo = zeros(size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,1)),'logical');
                        roi_map_previo(min(app.PT_xy_p1(2),app.PT_xy_p2(2)):max(app.PT_xy_p1(2),app.PT_xy_p2(2)),...
                            min(app.PT_xy_p1(1),app.PT_xy_p2(1)):max(app.PT_xy_p1(1),app.PT_xy_p2(1))) = true;
                        app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = logical(double(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value))).*double(roi_map_previo));
                    end
                    roi_vec = suv_corte(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)));
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
                    
                elseif app.CircularButton.Value == 1 && app.roi_activated 
                    roi_map_previo = zeros(size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,1)),'logical');
                    tam = size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,1));
                    %x =app.PT_xy_p2(1);
                    %y = app.PT_xy_p2(2);
                    [x,y] = meshgrid(1:tam(2),1:tam(1));
                    roi_map_previo(sqrt((x-app.PT_xy_p1(1)).^2+(y-app.PT_xy_p1(2)).^2)<=norm(app.PT_xy_p2-app.PT_xy_p1)) = true;
                    app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roi_map_previo;
                    %%
                    roi_vec = suv_corte(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)));
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
                elseif app.NingunaButton.Value == 1
                    app.SUVMEANLabel.Visible = "off";
                    app.SUVMAXLabel.Visible = "off";
                    app.COVLabel.Visible = "off";
                    app.UILabel.Visible = "off";
                    app.SRNLabel.Visible = "off";
                end
            end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            movegui(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'center');
            load("saved_data.mat","modo3DIR");app.mod3DIR=modo3DIR;
            load("saved_data.mat","dir_estudios");app.estudios_dir=dir_estudios;
            load("saved_data.mat","x_inicial");app.x_i=x_inicial;
            load("saved_data.mat","x_final");app.x_f=x_final;
            app.output = "Directorio cargado: " + convertCharsToStrings(app.mod3DIR);
            app.outputTextArea.Value = app.output;
            if isempty(fullfile(app.mod3DIR))
                    app.output = "[X] Directorio no contiene archivos compatibles.";
                    app.outputTextArea.Value =  app.output;
                    app.CorrerButton.Enable = "off";
            else
             app.num_estudios = length(fieldnames(app.estudios_dir));
             app.cortes = app.x_f.estudio_1-app.x_i.estudio_1+1;
             app.CorteSlider.Limits = [1, app.cortes];
             app.output = "[OK] Archivos compatibles encontrados en "+int2str(app.num_estudios)+" directorios." ;
             app.outputTextArea.Value = app.output;
             app.CorrerButton.Enable = "on";
                     
            end

        end

        % Button pushed function: CorrerButton
        function CorrerButtonPushed(app, event)
            %drawnow nocallbacks
            app.CerrarButton_2.Enable = "off";
            app.PositroniumButton.Enable = "off";
            pause(1)
            drawnow nocallbacks
            if app.running
                app.running = not(app.running);
                drawnow limitrate
                app.CorrerButton.Enable = "off"; 
                pause(1)
                drawnow limitrate
                app.output = "Cargando volumen global...."+newline+app.output; 
                app.outputTextArea.Value =  app.output; drawnow limitrate
                for n = 1:app.num_estudios
                    [app.ct_volume.("estudio_" + num2str(n)),app.ct_info.("estudio_" + num2str(n)),~,app.ct_time.("estudio_" + num2str(n)),~,~]  ...
                    = load_dicom_data(app,fullfile(app.mod3DIR,app.estudios_dir.("estudio_" + num2str(n))),'SE000001','*CT*',app.cortes,app.x_i.("estudio_" + num2str(n)),0);
                end
                app.output = "[OK] Imágenes CT cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                for n = 1:app.num_estudios
                    [app.pt_volume.("estudio_" + num2str(n)),app.pt_info.("estudio_" + num2str(n)),~,app.pt_time.("estudio_" + num2str(n)),pt_RescaleSlope.("estudio_" + num2str(n)),app.factor_decaimiento.("estudio_" + num2str(n))] ...
                        = load_dicom_data(app,fullfile(app.mod3DIR,app.estudios_dir.("estudio_" + num2str(n))),'SE000003','*PT*',app.cortes,app.x_i.("estudio_" + num2str(n)),1);
                end
                app.output = "[OK] Imágenes PET cargadas correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                for n = 1:app.num_estudios
                    if app.ct_info.("estudio_" + num2str(n)).PixelSpacing(1)*app.ct_info.("estudio_" + num2str(n)).Height > app.pt_info.("estudio_" + num2str(n)).PixelSpacing(1)*app.pt_info.("estudio_" + num2str(n)).Height
                        % cuando la imagen CT es mayor espacialmente que la img PET
                        % app.ct_info.ReconstructionTargetCenterPatient(1) > app.ct_info.ImagePositionPatient(1)
                        ct_edges_p1 = [app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(1),app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(2)];
                        ct_edges_p2 = [2*app.ct_info.("estudio_" + num2str(n)).ReconstructionTargetCenterPatient(1)-app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(1),2*app.ct_info.("estudio_" + num2str(n)).ReconstructionTargetCenterPatient(2)-app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(2)];
                        %
                        app.pt_edges_pixel.("estudio_" + num2str(n)) = round([(ct_edges_p1(2)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(2))/app.ct_info.("estudio_" + num2str(n)).PixelSpacing(2),(ct_edges_p2(2)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(2))/app.ct_info.("estudio_" + num2str(n)).PixelSpacing(2)...
                            (ct_edges_p1(1)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(1))/app.ct_info.("estudio_" + num2str(n)).PixelSpacing(1),(ct_edges_p2(1)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(1))/app.ct_info.("estudio_" + num2str(n)).PixelSpacing(1)]+1);
                        %
                        app.ct_edges_on = 1;
                    else
                        if app.ct_info.("estudio_" + num2str(n)).ReconstructionTargetCenterPatient(1) > app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(1)
                            ct_edges_p1 = [app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(1),app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(2)];
                            ct_edges_p2 = [2*app.ct_info.("estudio_" + num2str(n)).ReconstructionTargetCenterPatient(1)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(1),2*app.ct_info.("estudio_" + num2str(n)).ReconstructionTargetCenterPatient(2)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(2)];
                            %
                            app.pt_edges_pixel.("estudio_" + num2str(n)) = round([(ct_edges_p1(2)-app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(2))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(2),(ct_edges_p2(2)-app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(2))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(2)...
                                (ct_edges_p1(1)-app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(1))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(1),(ct_edges_p2(1)-app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(1))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(1)]+1);
                            %
                        else
                            ct_edges_p1 = [app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(1),app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(2)];
                            ct_edges_p2 = [2*app.ct_info.("estudio_" + num2str(n)).ReconstructionTargetCenterPatient(1)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(1),2*app.ct_info.("estudio_" + num2str(n)).ReconstructionTargetCenterPatient(2)-app.ct_info.("estudio_" + num2str(n)).ImagePositionPatient(2)];
                            app.pt_edges_pixel = round([(-ct_edges_p2(2)+app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(2))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(2),(-ct_edges_p1(2)+app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(2))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(2)...
                                (-ct_edges_p1(1)+app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(1))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(1),(-ct_edges_p2(1)+app.pt_info.("estudio_" + num2str(n)).ImagePositionPatient(1))/app.pt_info.("estudio_" + num2str(n)).PixelSpacing(1)]+1);
                        end
                    end
                    if not(app.ct_edges_on)
                        app.pt_volume.("estudio_" + num2str(n)) = app.pt_volume.("estudio_" + num2str(n))(app.pt_edges_pixel.("estudio_" + num2str(n))(1):app.pt_edges_pixel.("estudio_" + num2str(n))(2),app.pt_edges_pixel.("estudio_" + num2str(n))(3):app.pt_edges_pixel.("estudio_" + num2str(n))(4),:);
                    else
                        pause(0.2)
                        app.output = "[!] Volumen CT corregido"+newline+app.output;
                        app.outputTextArea.Value =  app.output;
                        drawnow('limitrate')
                        app.ct_volume.("estudio_" + num2str(n)) = app.ct_volume.("estudio_" + num2str(n))(app.pt_edges_pixel.("estudio_" + num2str(n))(1):app.pt_edges_pixel.("estudio_" + num2str(n))(2),app.pt_edges_pixel.("estudio_" + num2str(n))(3):app.pt_edges_pixel.("estudio_" + num2str(n))(4),:);
                    end
                    app.SUV_pt.("estudio_" + num2str(n)) = SUVolume(app, app.pt_volume.("estudio_" + num2str(n)), app.pt_info.("estudio_" + num2str(n)),pt_RescaleSlope.("estudio_" + num2str(n)),app.pt_time.("estudio_" + num2str(n)),app.cortes);
                    pause(0.2)
                    app.output = "[OK] SUV calculado correctamente."+newline+app.output;
                    app.outputTextArea.Value =  app.output;
                    drawnow('limitrate')
                end

                app.WW=app.ct_info.("estudio_" + num2str(1)).WindowWidth(1);
                app.WL=app.ct_info.("estudio_" + num2str(1)).WindowCenter(1);
                app.WindowLevelEditField.Value = app.WL;
                app.WindowWidthEditField.Value = app.WW;
                max_suv = zeros(1,app.num_estudios);
                for n = 1:app.num_estudios
                    max_suv(n) = max(max(max(app.SUV_pt.("estudio_" + num2str(n)))));
                    %
                end
                app.global_max_SUV = max(max_suv);
                %%
                app.MaxSUVSlider.Enable = "on";
                app.MaxSUVSlider.Limits = [0, app.global_max_SUV + 0.5*app.global_max_SUV];
                app.MaxSUVSlider.Value = app.global_max_SUV;
                %%
                app.output = "[OK] SUV calculado correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                for n = 1:app.num_estudios
                    app.roi_map.("estudio_" + num2str(n)) = ones(size(app.pt_volume.("estudio_" + num2str(n))(:,:,1)),'logical');
                    app.roi_volume.("estudio_" + num2str(n)) = ones(size(app.pt_volume.("estudio_" + num2str(n))),'logical');
                    app.suv_results.("estudio_" + num2str(n)) = zeros(2,app.cortes);
                end
                app.output = "[OK] Datos PET cortados correctamente."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                %%
                
                
                %%
                app.CorrerButton.Text = 'Regresar';
                app.CorrerButton.Icon =  fullfile(fileparts(mfilename('fullpath')), 'ico', 'back.png');
                app.CorrerButton.Enable = "on"; drawnow limitrate
                %%
                app.CorteSlider.Enable = "on";
                estudios = cell(1, app.num_estudios);
                for i = 1:app.num_estudios
                    estudios{i} = sprintf('Estudio %d', i);
                end
                app.SeleccioneDropDown.Items =  estudios;
                app.SeleccioneDropDown.ItemsData = 1:app.num_estudios;
                %%
                a = app.pt_edges_pixel.("estudio_" + num2str(1));
                a = -a(1) + a(2) + 1; 
                app.CT_xy_p1 = double([round(a/2-a/3.5),round(a/2)]);
                app.CT_xy_p2 = double([round(a/2+a/3.5),round(a/2)]);
                app.pt_crosshair_x = round((app.pt_edges_pixel.("estudio_" + num2str(1))(2)-app.pt_edges_pixel.("estudio_" + num2str(1))(1)+1)/2);
                app.pt_crosshair_y = round((app.pt_edges_pixel.("estudio_" + num2str(1))(4)-app.pt_edges_pixel.("estudio_" + num2str(1))(3)+1)/2);
                %%
                componentes_on_off(app,"on")
                
                %%
                app.AplicarButton.Enable = "on";
                draw_figs(app,1,1)
            else
                main3
                app.delete;
            end
            
        end

        % Value changed function: CorteSlider
        function CorteSliderValueChanged(app, event)
            app.CorteSlider.Value = round(app.CorteSlider.Value);
            gen_mean_SUV_info(app)
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            app.cambiar_x_y = false;
            if app.HerramientasDropDown.Value == 3
                app.SUV0000Label.Visible = "on";
                app.XXXYYYLabel.Visible="on";
                app.XXXXXXLabel.Visible = "on";
                app.HUXXXXXXLabel.Visible = "on";
                lines_and_info(app,app.CorteSlider.Value)
            end
            
        end

        % Value changed function: MaxSUVSlider
        function MaxSUVSliderValueChanged(app, event)
            app.global_max_SUV = app.MaxSUVSlider.Value;
            gen_mean_SUV_info(app)
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            app.cambiar_x_y = false;
        end

        % Value changed function: SeleccioneDropDown
        function SeleccioneDropDownValueChanged(app, event)
            value = app.SeleccioneDropDown.Value;
            draw_figs(app,app.CorteSlider.Value,value)
            if app.HerramientasDropDown.Value == 3
                app.SUV0000Label.Visible = "on";
                app.XXXYYYLabel.Visible="on";
                app.XXXXXXLabel.Visible = "on";
                app.HUXXXXXXLabel.Visible = "on";
                lines_and_info(app,app.CorteSlider.Value)
            end
            
        end

        % Selection changed function: VisualizacinButtonGroup
        function VisualizacinButtonGroupSelectionChanged(app, event)
            %selectedButton = app.VisualizacinButtonGroup.SelectedObject;
            %selectedButton
            gen_mean_SUV_info(app)
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            
        end

        % Selection changed function: SeleccindeROIButtonGroup
        function SeleccindeROIButtonGroupSelectionChanged(app, event)
            app.HerramientasDropDown.Enable = "on";
            %selectedButton = app.SeleccindeROIButtonGroup.SelectedObject;
            %eliminar elementos gráficos y bloquear la entrada de mouse
            %
            app.cambiar_x_y = false;
            delete([app.PT_p1,app.PT_p2,app.roi_fig])
            %a la gráfica de fusión
            %app.roi_activated = false;
            app.FX1FY1Label.Visible = "off";
            app.FX2FY2Label.Visible = "off";
            app.SUVMEANLabel.Visible = "off";
            app.SUVMAXLabel.Visible = "off";
            app.FX1FY1Label.Visible = "off";
            app.FX2FY2Label.Visible = "off";
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
            if app.SegmentadoCTButton.Value == 1
                    app.ROIlowEditField.Value = -150;
                    app.ROIhightEditField.Value = 150;
                    %app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    %gen_mean_SUV_info(app)
            elseif app.SegmentadoPETButton.Value == 1
                    app.ROIlowEditField.Value = round(0.8*double(app.pt_info.("estudio_" + num2str(app.SeleccioneDropDown.Value)).LargestImagePixelValue));
                    app.ROIhightEditField.Value = double(app.pt_info.("estudio_" + num2str(app.SeleccioneDropDown.Value)).LargestImagePixelValue);
                    app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.SeleccioneDropDown.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    %gen_mean_SUV_info(app)
            elseif app.SegmentadoSUVButton.Value == 1 
                    app.ROIlowEditField.Value = 0.8*app.global_max_SUV;
                    app.ROIhightEditField.Value = app.global_max_SUV;
                    app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.SUV_pt.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.SeleccioneDropDown.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    %gen_mean_SUV_info(app)
            %elseif app.RectangularButton.Value == 1 || app.CircularButton.Value == 1 || app.SegmentadoCTButton.Value == 1
            %    gen_mean_SUV_info(app)
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
            if app.CircularButton.Value == 1 || app.RectangularButton.Value == 1 || app.SegmentadoCTButton.Value == 1
                    app.HerramientasDropDown.Enable = "off";
                    app.SUV0000Label.Visible = "off";
                    app.XXXYYYLabel.Visible="off";
                    app.XXXXXXLabel.Visible = "off";
                    app.HUXXXXXXLabel.Visible = "off";
                    app.XX1YY1Label.Visible = "off";
                    app.XX2YY2Label.Visible = "off";
                    app.DistanciaLabel.Visible = "off";
                    delete([app.CT_p1,app.CT_p2,app.CT_ln])
                    delete(app.pt_crosshair)
                    app.HerramientasDropDown.Value = 1;
            end

            gen_mean_SUV_info(app)
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)

        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
                if app.NingunaButton.Value == 0 && app.SegmentadoSUVButton.Value == 0 && app.SegmentadoPETButton.Value == 0
                    %%
                    app.Fig_point_created = true;
                    app.roi_state = not(app.roi_state);
                    P = get(app.UIAxes,'CurrentPoint'); 
                    x = round(P(1,1)); 
                    y = round(P(1,2));
                    if not(app.cambiar_x_y)
                        app.PT_xy_p1 = [x,y];
                    else
                        app.PT_xy_p2 = [x,y];
                    end
                    app.cambiar_x_y = true;
                    gen_mean_SUV_info(app)
                    draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
                
                end
                if app.HerramientasDropDown.Value ==  2
                    app.rule_state = not(app.rule_state);
                    P = get(app.UIAxes,'CurrentPoint');
                    rule(app,round(P(1,1)),round(P(1,2)))
                end
                if app.HerramientasDropDown.Value ==  3
                    app.SUV0000Label.Visible = "on";
                    app.XXXYYYLabel.Visible="on";
                    app.XXXXXXLabel.Visible = "on";
                    app.HUXXXXXXLabel.Visible = "on";
                    
                    P = get(app.UIAxes,'CurrentPoint'); 
                     app.pt_crosshair_x = round(P(1,1)); 
                     app.pt_crosshair_y = round(P(1,2));
                     ancho = app.pt_edges_pixel.("estudio_" + num2str(app.SeleccioneDropDown.Value))(2)-app.pt_edges_pixel.("estudio_" + num2str(app.SeleccioneDropDown.Value))(1)+1;
                     altura = app.pt_edges_pixel.("estudio_" + num2str(app.SeleccioneDropDown.Value))(4)-app.pt_edges_pixel.("estudio_" + num2str(app.SeleccioneDropDown.Value))(3)+1;
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
                     lines_and_info(app,app.CorteSlider.Value)
                     draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
                end                
                gen_mean_SUV_info(app)
                draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
        end

        % Value changed function: HerramientasDropDown
        function HerramientasDropDownValueChanged(app, event)
            app.SUV0000Label.Visible = "off";
            app.XXXYYYLabel.Visible="off";
            app.XXXXXXLabel.Visible = "off";
            app.HUXXXXXXLabel.Visible = "off";
            app.XX1YY1Label.Visible = "off";
            app.XX2YY2Label.Visible = "off";
            app.DistanciaLabel.Visible = "off";
            delete([app.CT_p1,app.CT_p2,app.CT_ln])
            delete(app.pt_crosshair)

            if app.HerramientasDropDown.Value == 1
                draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            end
            if app.HerramientasDropDown.Value == 2
                draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            end
            if app.HerramientasDropDown.Value == 3
                app.SUV0000Label.Visible = "on";
                app.XXXYYYLabel.Visible="on";
                app.XXXXXXLabel.Visible = "on";
                app.HUXXXXXXLabel.Visible = "on";
                lines_and_info(app,app.CorteSlider.Value)
            end
            %if app.HerramientasDropDown.Value == 4
            %end

            
        end

        % Value changed function: WindowWidthEditField
        function WindowWidthEditFieldValueChanged(app, event)
            app.WW = round(app.WindowWidthEditField.Value);
            app.WindowWidthEditField.Value = round(app.WindowWidthEditField.Value);
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
        end

        % Value changed function: WindowLevelEditField
        function WindowLevelEditFieldValueChanged(app, event)
            app.WL = round(app.WindowLevelEditField.Value);
            app.WindowLevelEditField.Value = round(app.WindowLevelEditField.Value);
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)

        end

        % Value changed function: AlphaCTSlider
        function AlphaCTSliderValueChanged(app, event)
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
        end

        % Value changed function: AlphaPETSlider
        function AlphaPETSliderValueChanged(app, event)
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            
        end

        % Value changed function: VerROICheckBox
        function VerROICheckBoxValueChanged(app, event)
            app.cambiar_x_y = false;
            if app.VerROICheckBox.Value == 1
                app.VerVOICheckBox.Value = 0;
            end
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
        end

        % Value changed function: VerVOICheckBox
        function VerVOICheckBoxValueChanged(app, event)
            app.cambiar_x_y = false;
            if app.VerVOICheckBox.Value == 1
                app.VerROICheckBox.Value = 0;
            end
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            
        end

        % Button pushed function: ResetsegmentacinButton
        function ResetsegmentacinButtonPushed(app, event)
            app.roi_CT_selected_state = false;
            % 
            app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = ones(size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,1)),'logical');
            if app.SegmentadoCTButton.Value == 1
                    app.ROIlowEditField.Value = -app.WW/2+app.WL;
                    app.ROIhightEditField.Value = app.WW/2+app.WL;
                    app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    gen_mean_SUV_info(app)
            elseif app.SegmentadoPETButton.Value == 1
                    app.ROIlowEditField.Value = round(0.8*double(app.pt_info.("estudio_" + num2str(app.SeleccioneDropDown.Value)).LargestImagePixelValue));
                    app.ROIhightEditField.Value = double(app.pt_info.("estudio_" + num2str(app.SeleccioneDropDown.Value)).LargestImagePixelValue);
                    app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.SeleccioneDropDown.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    gen_mean_SUV_info(app)
            elseif app.SegmentadoSUVButton.Value == 1 
                    app.ROIlowEditField.Value = 0.8*app.global_max_SUV;
                    app.ROIhightEditField.Value = app.global_max_SUV;
                    app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.SUV_pt.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.SeleccioneDropDown.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                    gen_mean_SUV_info(app)
            end
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
        end

        % Value changed function: ROIlowEditField
        function ROIlowEditFieldValueChanged(app, event)
           app.roi_CT_selected_state = false;
           % 
           app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = ones(size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,1)),'logical');
           app.CT_resized = imresize(app.ct_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value)));
           if app.SegmentadoCTButton.Value == 1
                app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoPETButton.Value == 1
                app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoSUVButton.Value == 1
               app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.SUV_pt.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           end
           gen_mean_SUV_info(app)
           draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
        end

        % Value changed function: ROIhightEditField
        function ROIhightEditFieldValueChanged(app, event)
           app.roi_CT_selected_state = false;
           % 
           app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = ones(size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,1)),'logical');
           app.CT_resized = imresize(app.ct_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),size(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value)));
           if app.SegmentadoCTButton.Value == 1
                app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.CT_resized,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoPETButton.Value == 1
                app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.pt_volume.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           elseif app.SegmentadoSUVButton.Value == 1
               app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = roicolor(app.SUV_pt.("estudio_" + num2str(app.SeleccioneDropDown.Value))(:,:,app.CorteSlider.Value),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
           end
           gen_mean_SUV_info(app)
           draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            
        end

        % Value changed function: DeteccindebordeDropDown
        function DeteccindebordeDropDownValueChanged(app, event)
            app.roi_CT_selected_state = false;
            % 
            app.cambiar_x_y = false;
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value) 
            
        end

        % Button pushed function: DilatarButton
        function DilatarButtonPushed2(app, event)
            app.roi_CT_selected_state = false;
            % 
            estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
            app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = imdilate(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)),estruc);
            gen_mean_SUV_info(app)
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            
        end

        % Button pushed function: ErosionarButton
        function ErosionarButtonPushed2(app, event)
           app.roi_CT_selected_state = false;
           % 
           estruc = strel(char(app.OpmofolgicaDropDown.Items(app.OpmofolgicaDropDown.Value)),app.RadiomorfEditField.Value);
           app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)) = imerode(app.roi_map.("estudio_" + num2str(app.SeleccioneDropDown.Value)),estruc);
           gen_mean_SUV_info(app)
           draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value) 
        end

        % Value changed function: SegEditField
        function SegEditFieldValueChanged(app, event)
            app.output = "[OK] Cógigo de segmentación guardado. ["  + app.SegEditField.Value+  "]"+newline+app.output;
            app.outputTextArea.Value =  app.output; drawnow limitrate
            
        end

        % Button pushed function: AplicarButton
        function AplicarButtonPushed(app, event)
            app.output = "Generando volumen ROI...."+newline+app.output;
            app.outputTextArea.Value =  app.output; drawnow limitrate
            
            %romper_ciclo = false;
            if strcmp(app.SegEditField.Value(1),'m')
                app.output = "Aplicando en todos los estudios ROICOLOR("+num2str(app.ROIlowEditField.Value)+","+num2str(app.ROIhightEditField.Value)+")"+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                for n = 1:app.num_estudios
                   for m = 1:app.cortes
                       if app.SegmentadoCTButton.Value == 1
                           %app.pt_edges_pixel.("estudio_" + num2str(n))(2)-app.pt_edges_pixel.("estudio_" + num2str(n))(1)+1,app.pt_edges_pixel.("estudio_" + num2str(n))(4)-app.pt_edges_pixel.("estudio_" + num2str(n))(3)+1
                            CT_r = imresize(app.ct_volume.("estudio_" + num2str(n))(:,:,m),size(app.pt_volume.("estudio_" + num2str(n))(:,:,m)));
                            app.roi_volume.("estudio_" + num2str(n))(:,:,m) = roicolor(CT_r,app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                       elseif app.SegmentadoPETButton.Value == 1 
                            app.roi_volume.("estudio_" + num2str(n))(:,:,m) = roicolor(app.pt_volume.("estudio_" + num2str(n))(:,:,m),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                       elseif app.SegmentadoSUVButton.Value == 1
                            app.roi_volume.("estudio_" + num2str(n))(:,:,m) = roicolor(app.SUV_pt.("estudio_" + num2str(n))(:,:,m),app.ROIlowEditField.Value,app.ROIhightEditField.Value);
                       end
                   end 
                end
                ciclos = length(app.SegEditField.Value(2:end))/5;
                if not(ciclos ~= floor(ciclos))
                    for k = 1:ciclos
                        cond1 = strcmp(app.SegEditField.Value(k*5+1-3:k*5+1-2),'dm')||strcmp(app.SegEditField.Value(k*5+1-3:k*5+1-2),'di')||strcmp(app.SegEditField.Value(k*5+1-3:k*5+1-2),'sq');
                        cond2 = strcmp(app.SegEditField.Value(k*5 +1),'d') || strcmp(app.SegEditField.Value(k*5 +1),'e');
                        cond3 = not(isnan(str2double(app.SegEditField.Value(k*5))));
                        str2double(app.SegEditField.Value(k*5));
                        if  cond1 && cond2 && cond3
                            if strcmp(app.SegEditField.Value(k*5+1-3:k*5+1-2),'dm')
                                op_metodo = "diamond";
                            elseif strcmp(app.SegEditField.Value(k*5+1-3:k*5+1-2),'di')
                                op_metodo = "disk";
                            elseif strcmp(app.SegEditField.Value(k*5+1-3:k*5+1-2),'sq')
                                op_metodo = "square";
                            end
                            op_radio = str2double(app.SegEditField.Value(k*5));
                            op_m = strel(op_metodo,op_radio);
                            if strcmp(app.SegEditField.Value(k*5+1),'d')
                                for n = 1:app.num_estudios
                                   for m = 1:app.cortes
                                       app.roi_volume.("estudio_" + num2str(n))(:,:,m) = imdilate(app.roi_volume.("estudio_" + num2str(n))(:,:,m),op_m);
                                   end
                                end
                            elseif strcmp(app.SegEditField.Value(k*5 +1),'e')
                                for n = 1:app.num_estudios
                                   for m = 1:app.cortes
                                       app.roi_volume.("estudio_" + num2str(n))(:,:,m) = imerode(app.roi_volume.("estudio_" + num2str(n))(:,:,m),op_m);
                                   end
                                end
                            end
                        else
                            app.output = "[X] Revise su cadena.  [Error 02]"+newline+app.output;
                            app.outputTextArea.Value =  app.output; drawnow limitrate
                        end
                    end
                else
                    app.output = "[X] Revise su cadena. [Error 01]"+newline+app.output;
                    app.outputTextArea.Value =  app.output; drawnow limitrate
                end
                app.VOIButton.Enable = "on";
                app.VerVOICheckBox.Enable = "on";
                app.VerVOICheckBox.Value = 1; app.VerROICheckBox.Value = 0;
                app.output = "[OK] Volumen ROI construido"+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
                app.ResultadosButton.Enable = "on";
            else
                app.output = "[X] Código SEG. no compatible."+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
            end
            gen_mean_SUV_info(app)
            draw_figs(app,app.CorteSlider.Value,app.SeleccioneDropDown.Value)
            app.cambiar_x_y = false;
            
        end

        % Button pushed function: ResultadosButton
        function ResultadosButtonPushed(app, event)
            % generar un vector de resultados

            for n = 1:app.num_estudios
                   for m = 1:app.cortes
                       corteSUV=app.SUV_pt.("estudio_" + num2str(n))(:,:,m);
                       corteROI=app.roi_volume.("estudio_" + num2str(n))(:,:,m);
                       meanROI = mean(corteSUV(corteROI));
                       stdROI = std(corteSUV(corteROI));
                       if isnan(meanROI)
                           meanROI = 0;
                           stdROI  = 0;
                       end
                       app.suv_results.("estudio_" + num2str(n))(1,m) = meanROI;
                       app.suv_results.("estudio_" + num2str(n))(2,m) = stdROI;
                   end
            end
            app.output = "[OK] Resultados generados."+newline+app.output;
            app.outputTextArea.Value =  app.output; drawnow limitrate
            pause(1)

            cla(app.UIAxes2)
            hold(app.UIAxes2,"on")
            %app.
            Legends=cell(app.num_estudios,1);
            %ylim(app.UIAxes2,[0,1.1])
            for n = 1:app.num_estudios
                %app.perfil_plot.("estudio_" + num2str(n))=
                errorbar(app.UIAxes2,1:app.cortes,app.suv_results.("estudio_" + num2str(n))(1,:),app.suv_results.("estudio_" + num2str(n))(2,:),'-',"HitTest","off");
                %app.
                Legends{n}=['A_0 = ',sprintf('%.3f',app.pt_info.("estudio_" + num2str(n)).RadiopharmaceuticalInformationSequence.Item_1.RadionuclideTotalDose* ...
                    2.7027027027027*10^(-8)),' mCi'];
            end
            legend(app.UIAxes2,Legends);
            app.GuardarButton_2.Enable = "on";
            
        end

        % Button pushed function: GuardarButton
        function GuardarButtonPushed(app, event)
            app.output = "[...] Intentando guardar imagen"+newline+app.output;
            app.outputTextArea.Value =  app.output; drawnow limitrate
            directorio_guardado = uigetdir(userpath);
            
            if directorio_guardado == 0
                app.output = "[X] Guardado cancelado"+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
            else 
                imwrite(app.fused,fullfile(directorio_guardado,['estudio_' num2str(app.SeleccioneDropDown.Value) 'corte_' ...
                  num2str(app.CorteSlider.Value) '.png']));
                app.output = "[OK] Imagen guardada"+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
            end
        end

        % Button pushed function: GuardarButton_2
        function GuardarButton_2Pushed(app, event)
            app.output = "[...] Generando reporte XLSX"+newline+app.output;
            app.outputTextArea.Value =  app.output; drawnow limitrate
            directorio_guardado = uigetdir(userpath);
            if directorio_guardado == 0
                app.output = "[X] Operación cancelada"+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
            else 
                tabla_header = {'SUV100mean','SUV90mean','SUV80mean','SUV50mean','SUV10mean',...
                    'SUV100SD', 'SUV90SD','SUV80SD','SUV50SD','SUV10SD',...
                    'SUV100max', 'SUV90max','SUV80max','SUV50max','SUV10max',...
                    'SUV100min', 'SUV90min','SUV80min','SUV50min','SUV10min',...
                    'bSUV100mean','bSUV90mean','bSUV80mean','bSUV50mean','bSUV10mean',...
                    'bSUV100SD', 'bSUV90SD','bSUV80SD','bSUV50SD','bSUV10SD',...
                    'bSUV100max', 'bSUV90max','bSUV80max','bSUV50max','bSUV10max',...
                    'bSUV100min', 'bSUV90min','bSUV80min','bSUV50min','bSUV10min',...
                    'No.Pixels_100','No.Pixels_90','No.Pixels_80','No.Pixels_50','No.Pixels_10',...
                    'SUV100max5v', 'SUV90max5v','SUV80max5v','SUV50max5v','SUV10max5v',...
                    'SUV100min5v', 'SUV90min5v','SUV80min5v','SUV50min5v','SUV10min5v'};
                num_header = length(tabla_header);
                %%
                % creamos un folder en directorio_guardado
                resultados_dir = ['resultados_positronium_',char(datetime('now','TimeZone','local','Format','d_MMM_y_HH_mm_ss_ms'))];
                mkdir(fullfile(directorio_guardado,resultados_dir));
                rs = [1, 0.9, 0.8,0.5,0.1];
                %
                for n_estudio = 1:app.num_estudios
                    estudios_dir2 = ['estudio_',int2str(n_estudio)];
                    mkdir(fullfile(directorio_guardado,resultados_dir,estudios_dir2));
                    info_cell = cell(2,num_header);
                    %%
                    info_cell(1,1) = {'Dosis'};info_cell(1,2) = {sprintf('%.3f',app.pt_info.("estudio_" + num2str(n_estudio)).RadiopharmaceuticalInformationSequence.Item_1.RadionuclideTotalDose* ...
                    2.7027027027027*10^(-8))};
                    info_cell(2,1) = {'Tdis'};info_cell(2,2) = {'Valor'};
                    %
                    info_cell(1,3) = {'PixelSpacing_X'};info_cell(1,4) = {sprintf('%.5f',app.pt_info.("estudio_" + num2str(n_estudio)).PixelSpacing(1))};
                    info_cell(2,3) = {'PixelSpacing_Y'};info_cell(2,4) = {sprintf('%.5f',app.pt_info.("estudio_" + num2str(n_estudio)).PixelSpacing(2))};
                    info_cell(2,5) = {'SliceT'};info_cell(2,6) = {sprintf('%.5f',app.pt_info.("estudio_" + num2str(n_estudio)).SliceThickness)};
                    %%
                    tam = size(app.SUV_pt.("estudio_" + num2str(n_estudio))(:,:,1));
                    [xe,ye] = meshgrid(1:tam(2),1:tam(1));
                    all_data = cell(app.cortes,num_header);
                    for n_corte = 1:app.cortes
                        mapa_ROI = app.roi_volume.("estudio_" + num2str(n_estudio));
                        borde_roi = edge(mapa_ROI(:,:,n_corte),"canny");
                        [y, x] = find(borde_roi == 1);
                        if isempty(x)
                            x = round(tam(2)/4):round(3*tam(2)/4);
                            y = round([linspace(tam(2)/2,tam(2)/4,round(tam(2)/4)),linspace(tam(2)/2,tam(2)/4,round(tam(2)/4))]);
                        end
                        x1 = x(1); y1 = y(1);
                        x2 = x(round(length(x)/2)); y2 = y(round(length(y)/2));
                        x3 = x(end); y3 = y(end);
                        A = [ 2*x1 2*y1 1;2*x2 2*y2 1;2*x3 2*y3 1];
                        B = [-(x1^2 + y1^2); -(x2^2 + y2^2); -(x3^2 + y3^2)];
                        X = linsolve(A,B);
                        xc = -X(1); yc = -X(2); r = sqrt(xc^2 + yc^2 - X(3));
                        CT_img = app.ct_volume.("estudio_" + num2str(n_estudio));
                        CT_img = imresize(CT_img(:,:,n_corte),tam);
                        PT =app.SUV_pt.("estudio_" + num2str(n_estudio));
                        PT = ind2rgb(uint8(256*PT(:,:,n_corte)/(1.3)), jet(256));
                        CT = ind2rgb(int64(CT_img-(app.WL-app.WW/2)), gray(app.WW));
                        fusion_img = CT*0.5 + PT*(0.5);
                        fusion_img = im2uint8(fusion_img);
                        for n_radio = 1:1:length(rs)
                            r_caso = r*sqrt(rs(n_radio));
                            roi_map_estudio = zeros(tam,'logical');
                            roi_map_estudio(sqrt((xe-xc).^2+(ye-yc).^2)<=r_caso) = true;
                            SUVROI_IMG = app.SUV_pt.("estudio_" + num2str(n_estudio))(:,:,n_corte);
                            SUVROI = SUVROI_IMG(roi_map_estudio);
                            bSUVROI = SUVROI_IMG(not(roi_map_estudio));
                            if length(SUVROI) >= 5
                                sortSUV = sort(SUVROI, 'descend');
                                top_5_SUVmax_values = sortSUV(1:5);
                                sortSUV = sort(SUVROI, 'ascend');
                                top_5_SUVmin_values = sortSUV(1:5);
                            else
                                sortSUV = zeros(1,10);
                                top_5_SUVmax_values = sortSUV(1:5);
                                sortSUV = zeros(1,10);
                                top_5_SUVmin_values = sortSUV(1:5);
                            end
                            %%
                            if isempty(SUVROI) || isempty(bSUVROI)
                                all_data(n_corte,0*5+n_radio) = {0};
                                all_data(n_corte,1*5+n_radio) = {0};
                                all_data(n_corte,2*5+n_radio) = {0};
                                all_data(n_corte,3*5+n_radio) = {0};
                                all_data(n_corte,4*5+n_radio) = {0};
                                all_data(n_corte,5*5+n_radio) = {0};
                                all_data(n_corte,6*5+n_radio) = {0};
                                all_data(n_corte,7*5+n_radio) = {0};
                                all_data(n_corte,8*5+n_radio) = {0};
                                all_data(n_corte,9*5+n_radio) = {0};
                                all_data(n_corte,10*5+n_radio) = {0};
                            else
                                all_data(n_corte,0*5+n_radio) = {mean(SUVROI)};
                                all_data(n_corte,1*5+n_radio) = {std(SUVROI)};
                                all_data(n_corte,2*5+n_radio) = {max(SUVROI)};
                                all_data(n_corte,3*5+n_radio) = {min(SUVROI)};
                                all_data(n_corte,4*5+n_radio) = {mean(bSUVROI)};
                                all_data(n_corte,5*5+n_radio) = {std(bSUVROI)};
                                all_data(n_corte,6*5+n_radio) = {max(bSUVROI)};
                                all_data(n_corte,7*5+n_radio) = {min(bSUVROI)};
                                all_data(n_corte,8*5+n_radio) = {length(SUVROI)};
                                all_data(n_corte,9*5+n_radio) = {mean(top_5_SUVmax_values)};
                                all_data(n_corte,10*5+n_radio) = {mean(top_5_SUVmin_values)};
                                matriz_amarilla = zeros(tam(1),tam(2),3,'uint8');matriz_amarilla(:,:,1) = 255;matriz_amarilla(:,:,2) = 255;
                                borde_roi_2 = edge(roi_map_estudio,"canny");
                                fusion_img = uint8(not(borde_roi_2)).*fusion_img;
                                matriz_amarilla = uint8(borde_roi_2).*matriz_amarilla;
                                fusion_img = fusion_img + matriz_amarilla;
                            end
                        end
                        imwrite(fusion_img,fullfile(directorio_guardado,resultados_dir,estudios_dir2,['estudio',int2str(n_estudio), '_corte_',int2str(n_corte),'.png']))
                    end
                    output_matrix=[info_cell;tabla_header; all_data];
                    writecell(output_matrix,fullfile(directorio_guardado,resultados_dir,'reporte.xlsx'),'Sheet',['estudio',int2str(n_estudio)]);    
                end
                %%
                app.output = "[OK] Reporte generado"+newline+app.output;
                app.outputTextArea.Value =  app.output; drawnow limitrate
            end
            
        end

        % Button pushed function: CerrarButton_2
        function CerrarButton_2Pushed(app, event)
            app.delete;
        end

        % Button pushed function: PositroniumButton
        function PositroniumButtonPushed(app, event)
            main0
            app.delete;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create PositroniumdotMATMododeanlisisconjunto2UIFigure and hide until all components are created
            app.PositroniumdotMATMododeanlisisconjunto2UIFigure = uifigure('Visible', 'off');
            app.PositroniumdotMATMododeanlisisconjunto2UIFigure.Color = [0.9412 0.9412 0.9412];
            app.PositroniumdotMATMododeanlisisconjunto2UIFigure.Position = [100 100 1184 718];
            app.PositroniumdotMATMododeanlisisconjunto2UIFigure.Name = 'Positronium dot MAT - Modo de análisis conjunto 2';
            app.PositroniumdotMATMododeanlisisconjunto2UIFigure.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            title(app.UIAxes2, 'SUV promedio por corte')
            xlabel(app.UIAxes2, 'Corte')
            ylabel(app.UIAxes2, 'SUV_{mean}')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.XGrid = 'on';
            app.UIAxes2.YGrid = 'on';
            app.UIAxes2.Position = [34 8 487 293];

            % Create UIAxes
            app.UIAxes = uiaxes(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            title(app.UIAxes, 'Fig - Cargando...')
            app.UIAxes.XTick = [];
            app.UIAxes.YTick = [];
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [532 140 615 554];

            % Create CorrerButton
            app.CorrerButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.CorrerButton.ButtonPushedFcn = createCallbackFcn(app, @CorrerButtonPushed, true);
            app.CorrerButton.Icon = fullfile(pathToMLAPP, 'ico', 'run.png');
            app.CorrerButton.Enable = 'off';
            app.CorrerButton.Position = [751 11 86 23];
            app.CorrerButton.Text = 'Correr';

            % Create CerrarButton_2
            app.CerrarButton_2 = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.CerrarButton_2.ButtonPushedFcn = createCallbackFcn(app, @CerrarButton_2Pushed, true);
            app.CerrarButton_2.Icon = fullfile(pathToMLAPP, 'ico', 'icon_close.png');
            app.CerrarButton_2.Position = [840 11 100 23];
            app.CerrarButton_2.Text = 'Cerrar';

            % Create PositroniumButton
            app.PositroniumButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.PositroniumButton.ButtonPushedFcn = createCallbackFcn(app, @PositroniumButtonPushed, true);
            app.PositroniumButton.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');
            app.PositroniumButton.Position = [540 11 100 23];
            app.PositroniumButton.Text = 'Positronium';

            % Create vidamediaLabel
            app.vidamediaLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.vidamediaLabel.FontWeight = 'bold';
            app.vidamediaLabel.FontColor = [1 0 0];
            app.vidamediaLabel.Visible = 'off';
            app.vidamediaLabel.Position = [548 635 123 22];
            app.vidamediaLabel.Text = 'vidamedia';

            % Create Button
            app.Button = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.Button.Icon = fullfile(pathToMLAPP, 'ico', 'plus.png');
            app.Button.Visible = 'off';
            app.Button.Position = [918 107 31 30];
            app.Button.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.Button_2.Icon = fullfile(pathToMLAPP, 'ico', 'minus.png');
            app.Button_2.Visible = 'off';
            app.Button_2.Position = [888 108 31 30];
            app.Button_2.Text = '';

            % Create Paso_zoomEditFieldLabel
            app.Paso_zoomEditFieldLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.Paso_zoomEditFieldLabel.HorizontalAlignment = 'right';
            app.Paso_zoomEditFieldLabel.Visible = 'off';
            app.Paso_zoomEditFieldLabel.Position = [805 82 68 22];
            app.Paso_zoomEditFieldLabel.Text = 'Paso_zoom';

            % Create Paso_zoomEditField
            app.Paso_zoomEditField = uieditfield(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'numeric');
            app.Paso_zoomEditField.Visible = 'off';
            app.Paso_zoomEditField.Position = [888 82 52 22];

            % Create SeleccioneDropDownLabel
            app.SeleccioneDropDownLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SeleccioneDropDownLabel.HorizontalAlignment = 'right';
            app.SeleccioneDropDownLabel.Position = [346 397 64 22];
            app.SeleccioneDropDownLabel.Text = 'Seleccione';

            % Create SeleccioneDropDown
            app.SeleccioneDropDown = uidropdown(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SeleccioneDropDown.Items = {'Estudio n'};
            app.SeleccioneDropDown.ItemsData = 1;
            app.SeleccioneDropDown.ValueChangedFcn = createCallbackFcn(app, @SeleccioneDropDownValueChanged, true);
            app.SeleccioneDropDown.Enable = 'off';
            app.SeleccioneDropDown.Position = [421 397 100 22];
            app.SeleccioneDropDown.Value = 1;

            % Create radionuclidoLabel
            app.radionuclidoLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.radionuclidoLabel.FontWeight = 'bold';
            app.radionuclidoLabel.FontColor = [1 0 0];
            app.radionuclidoLabel.Visible = 'off';
            app.radionuclidoLabel.Position = [548 656 140 22];
            app.radionuclidoLabel.Text = 'radionuclido';

            % Create SUV0000Label
            app.SUV0000Label = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SUV0000Label.FontWeight = 'bold';
            app.SUV0000Label.FontColor = [1 0 0];
            app.SUV0000Label.Visible = 'off';
            app.SUV0000Label.Position = [547 615 73 22];
            app.SUV0000Label.Text = 'SUV = 0.000';

            % Create XXXYYYLabel
            app.XXXYYYLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.XXXYYYLabel.HorizontalAlignment = 'right';
            app.XXXYYYLabel.FontWeight = 'bold';
            app.XXXYYYLabel.FontColor = [1 0 0];
            app.XXXYYYLabel.Visible = 'off';
            app.XXXYYYLabel.Position = [995 651 74 22];
            app.XXXYYYLabel.Text = '(XXX,YYY)';

            % Create XXXXXXLabel
            app.XXXXXXLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.XXXXXXLabel.HorizontalAlignment = 'right';
            app.XXXXXXLabel.FontWeight = 'bold';
            app.XXXXXXLabel.FontColor = [1 0 0];
            app.XXXXXXLabel.Visible = 'off';
            app.XXXXXXLabel.Position = [995 630 76 22];
            app.XXXXXXLabel.Text = '(XXXXXX)';

            % Create DDMMAAAAalasHHMMSSLabel
            app.DDMMAAAAalasHHMMSSLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.DDMMAAAAalasHHMMSSLabel.FontWeight = 'bold';
            app.DDMMAAAAalasHHMMSSLabel.FontColor = [1 0 0];
            app.DDMMAAAAalasHHMMSSLabel.Visible = 'off';
            app.DDMMAAAAalasHHMMSSLabel.Position = [548 144 251 22];
            app.DDMMAAAAalasHHMMSSLabel.Text = 'DD/MM/AAAA a las HH:MM:SS.';

            % Create Actividad0Label
            app.Actividad0Label = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.Actividad0Label.HorizontalAlignment = 'right';
            app.Actividad0Label.FontWeight = 'bold';
            app.Actividad0Label.FontColor = [1 0 0];
            app.Actividad0Label.Visible = 'off';
            app.Actividad0Label.Position = [931 144 140 22];
            app.Actividad0Label.Text = 'Actividad0';

            % Create FX1FY1Label
            app.FX1FY1Label = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.FX1FY1Label.HorizontalAlignment = 'center';
            app.FX1FY1Label.FontWeight = 'bold';
            app.FX1FY1Label.FontColor = [0 1 1];
            app.FX1FY1Label.Visible = 'off';
            app.FX1FY1Label.Position = [544 205 64 22];
            app.FX1FY1Label.Text = '(FX1,FY1)';

            % Create SUVMAXLabel
            app.SUVMAXLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SUVMAXLabel.FontWeight = 'bold';
            app.SUVMAXLabel.FontColor = [1 0 1];
            app.SUVMAXLabel.Visible = 'off';
            app.SUVMAXLabel.Position = [547 183 159 22];
            app.SUVMAXLabel.Text = 'SUV MAX';

            % Create SUVMEANLabel
            app.SUVMEANLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SUVMEANLabel.FontWeight = 'bold';
            app.SUVMEANLabel.FontColor = [1 1 0];
            app.SUVMEANLabel.Visible = 'off';
            app.SUVMEANLabel.Position = [547 162 159 22];
            app.SUVMEANLabel.Text = 'SUV MEAN';

            % Create FX2FY2Label
            app.FX2FY2Label = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.FX2FY2Label.HorizontalAlignment = 'center';
            app.FX2FY2Label.FontWeight = 'bold';
            app.FX2FY2Label.FontColor = [0 1 0];
            app.FX2FY2Label.Visible = 'off';
            app.FX2FY2Label.Position = [545 226 62 22];
            app.FX2FY2Label.Text = '(FX2,FY2)';

            % Create XX1YY1Label
            app.XX1YY1Label = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.XX1YY1Label.HorizontalAlignment = 'center';
            app.XX1YY1Label.FontWeight = 'bold';
            app.XX1YY1Label.FontColor = [0 1 1];
            app.XX1YY1Label.Visible = 'off';
            app.XX1YY1Label.Position = [727 162 70 22];
            app.XX1YY1Label.Text = '(XX1,YY1)';

            % Create DistanciaLabel
            app.DistanciaLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.DistanciaLabel.HorizontalAlignment = 'center';
            app.DistanciaLabel.FontWeight = 'bold';
            app.DistanciaLabel.FontColor = [1 1 0];
            app.DistanciaLabel.Visible = 'off';
            app.DistanciaLabel.Position = [798 145 132 22];
            app.DistanciaLabel.Text = 'Distancia';

            % Create XX2YY2Label
            app.XX2YY2Label = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.XX2YY2Label.HorizontalAlignment = 'center';
            app.XX2YY2Label.FontWeight = 'bold';
            app.XX2YY2Label.FontColor = [0 1 0];
            app.XX2YY2Label.Visible = 'off';
            app.XX2YY2Label.Position = [861 162 67 22];
            app.XX2YY2Label.Text = '(XX2,YY2)';

            % Create SeleccindeROIButtonGroup
            app.SeleccindeROIButtonGroup = uibuttongroup(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SeleccindeROIButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @SeleccindeROIButtonGroupSelectionChanged, true);
            app.SeleccindeROIButtonGroup.Enable = 'off';
            app.SeleccindeROIButtonGroup.ForegroundColor = [0.651 0.651 0.651];
            app.SeleccindeROIButtonGroup.Title = 'Selección de ROI';
            app.SeleccindeROIButtonGroup.FontSize = 10;
            app.SeleccindeROIButtonGroup.Position = [34 578 268 123];

            % Create NingunaButton
            app.NingunaButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.NingunaButton.Text = 'Ninguna';
            app.NingunaButton.Position = [11 80 67 22];
            app.NingunaButton.Value = true;

            % Create CircularButton
            app.CircularButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.CircularButton.Text = 'Circular';
            app.CircularButton.Position = [11 57 65 22];

            % Create RectangularButton
            app.RectangularButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.RectangularButton.Text = 'Rectangular';
            app.RectangularButton.Position = [136 79 87 22];

            % Create SegmentadoCTButton
            app.SegmentadoCTButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoCTButton.Text = 'Segmentado (CT)';
            app.SegmentadoCTButton.Position = [136 55 117 22];

            % Create SegmentadoPETButton
            app.SegmentadoPETButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoPETButton.Text = 'Segmentado (PET)';
            app.SegmentadoPETButton.Position = [12 30 125 22];

            % Create SegmentadoSUVButton
            app.SegmentadoSUVButton = uiradiobutton(app.SeleccindeROIButtonGroup);
            app.SegmentadoSUVButton.Text = 'Segmentado (SUV)';
            app.SegmentadoSUVButton.Position = [136 30 126 22];

            % Create VisualizacinButtonGroup
            app.VisualizacinButtonGroup = uibuttongroup(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.VisualizacinButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @VisualizacinButtonGroupSelectionChanged, true);
            app.VisualizacinButtonGroup.Enable = 'off';
            app.VisualizacinButtonGroup.Title = 'Visualización';
            app.VisualizacinButtonGroup.FontSize = 10;
            app.VisualizacinButtonGroup.Position = [323 584 177 115];

            % Create FusinSUVButton
            app.FusinSUVButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.FusinSUVButton.Text = 'Fusión SUV';
            app.FusinSUVButton.Position = [11 72 86 22];
            app.FusinSUVButton.Value = true;

            % Create PETButton
            app.PETButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.PETButton.Text = 'PET';
            app.PETButton.Position = [11 50 65 22];

            % Create SUVButton
            app.SUVButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.SUVButton.Text = 'SUV';
            app.SUVButton.Position = [11 27 47 22];

            % Create ROIButton
            app.ROIButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.ROIButton.Text = 'ROI';
            app.ROIButton.Position = [100 27 43 22];

            % Create CTButton
            app.CTButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.CTButton.Text = 'CT';
            app.CTButton.Position = [100 48 38 22];

            % Create FusinButton
            app.FusinButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.FusinButton.Text = 'Fusión';
            app.FusinButton.Position = [100 72 58 22];

            % Create VOIButton
            app.VOIButton = uiradiobutton(app.VisualizacinButtonGroup);
            app.VOIButton.Enable = 'off';
            app.VOIButton.Text = 'VOI';
            app.VOIButton.Position = [56 6 43 22];

            % Create outputTextArea
            app.outputTextArea = uitextarea(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.outputTextArea.FontColor = [0 1 0];
            app.outputTextArea.BackgroundColor = [0 0 0];
            app.outputTextArea.Position = [961 11 210 127];

            % Create ResetsegmentacinButton
            app.ResetsegmentacinButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.ResetsegmentacinButton.ButtonPushedFcn = createCallbackFcn(app, @ResetsegmentacinButtonPushed, true);
            app.ResetsegmentacinButton.Enable = 'off';
            app.ResetsegmentacinButton.Position = [33 482 268 23];
            app.ResetsegmentacinButton.Text = 'Reset segmentación';

            % Create DeteccindebordeDropDown
            app.DeteccindebordeDropDown = uidropdown(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.DeteccindebordeDropDown.Items = {'Canny', 'zerocross', 'log', 'approxcanny', 'Roberts', 'Prewitt', 'Sobel'};
            app.DeteccindebordeDropDown.ItemsData = [1 2 3 4 5 6 7];
            app.DeteccindebordeDropDown.ValueChangedFcn = createCallbackFcn(app, @DeteccindebordeDropDownValueChanged, true);
            app.DeteccindebordeDropDown.Enable = 'off';
            app.DeteccindebordeDropDown.Position = [178 522 128 22];
            app.DeteccindebordeDropDown.Value = 1;

            % Create OpmofolgicaDropDownLabel
            app.OpmofolgicaDropDownLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.OpmofolgicaDropDownLabel.HorizontalAlignment = 'right';
            app.OpmofolgicaDropDownLabel.Position = [41 458 86 22];
            app.OpmofolgicaDropDownLabel.Text = 'Op. mofológica';

            % Create OpmofolgicaDropDown
            app.OpmofolgicaDropDown = uidropdown(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.OpmofolgicaDropDown.Items = {'disk', 'diamond', 'square'};
            app.OpmofolgicaDropDown.ItemsData = [1 2 3 4];
            app.OpmofolgicaDropDown.Enable = 'off';
            app.OpmofolgicaDropDown.Position = [41 430 140 22];
            app.OpmofolgicaDropDown.Value = 1;

            % Create ROIlowEditFieldLabel
            app.ROIlowEditFieldLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.ROIlowEditFieldLabel.HorizontalAlignment = 'right';
            app.ROIlowEditFieldLabel.Position = [33 512 48 22];
            app.ROIlowEditFieldLabel.Text = 'ROI low';

            % Create ROIlowEditField
            app.ROIlowEditField = uieditfield(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'numeric');
            app.ROIlowEditField.ValueChangedFcn = createCallbackFcn(app, @ROIlowEditFieldValueChanged, true);
            app.ROIlowEditField.Enable = 'off';
            app.ROIlowEditField.Position = [98 512 63 22];

            % Create ROIhightEditFieldLabel
            app.ROIhightEditFieldLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.ROIhightEditFieldLabel.HorizontalAlignment = 'right';
            app.ROIhightEditFieldLabel.Position = [33 542 56 22];
            app.ROIhightEditFieldLabel.Text = 'ROI hight';

            % Create ROIhightEditField
            app.ROIhightEditField = uieditfield(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'numeric');
            app.ROIhightEditField.ValueChangedFcn = createCallbackFcn(app, @ROIhightEditFieldValueChanged, true);
            app.ROIhightEditField.Enable = 'off';
            app.ROIhightEditField.Position = [98 542 64 22];

            % Create RadiomorfEditFieldLabel
            app.RadiomorfEditFieldLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.RadiomorfEditFieldLabel.HorizontalAlignment = 'right';
            app.RadiomorfEditFieldLabel.Position = [42 397 75 22];
            app.RadiomorfEditFieldLabel.Text = 'Radio  (morf)';

            % Create RadiomorfEditField
            app.RadiomorfEditField = uieditfield(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'numeric');
            app.RadiomorfEditField.Enable = 'off';
            app.RadiomorfEditField.Position = [126 397 50 22];
            app.RadiomorfEditField.Value = 1;

            % Create CorteSliderLabel
            app.CorteSliderLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.CorteSliderLabel.HorizontalAlignment = 'right';
            app.CorteSliderLabel.Position = [559 81 34 22];
            app.CorteSliderLabel.Text = 'Corte';

            % Create CorteSlider
            app.CorteSlider = uislider(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.CorteSlider.Limits = [1 97];
            app.CorteSlider.ValueChangedFcn = createCallbackFcn(app, @CorteSliderValueChanged, true);
            app.CorteSlider.Enable = 'off';
            app.CorteSlider.Position = [559 73 380 3];
            app.CorteSlider.Value = 1;

            % Create AlphaCTSliderLabel
            app.AlphaCTSliderLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.AlphaCTSliderLabel.HorizontalAlignment = 'right';
            app.AlphaCTSliderLabel.FontSize = 10;
            app.AlphaCTSliderLabel.Position = [338 547 47 22];
            app.AlphaCTSliderLabel.Text = 'Alpha CT';

            % Create AlphaCTSlider
            app.AlphaCTSlider = uislider(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.AlphaCTSlider.Limits = [0 1];
            app.AlphaCTSlider.ValueChangedFcn = createCallbackFcn(app, @AlphaCTSliderValueChanged, true);
            app.AlphaCTSlider.FontSize = 9;
            app.AlphaCTSlider.Enable = 'off';
            app.AlphaCTSlider.Position = [338 541 119 3];
            app.AlphaCTSlider.Value = 0.5;

            % Create AlphaPETSliderLabel
            app.AlphaPETSliderLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.AlphaPETSliderLabel.HorizontalAlignment = 'right';
            app.AlphaPETSliderLabel.FontSize = 10;
            app.AlphaPETSliderLabel.Position = [332 480 53 22];
            app.AlphaPETSliderLabel.Text = 'Alpha PET';

            % Create AlphaPETSlider
            app.AlphaPETSlider = uislider(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.AlphaPETSlider.Limits = [0 1];
            app.AlphaPETSlider.ValueChangedFcn = createCallbackFcn(app, @AlphaPETSliderValueChanged, true);
            app.AlphaPETSlider.FontSize = 9;
            app.AlphaPETSlider.Enable = 'off';
            app.AlphaPETSlider.Position = [340 472 116 3];
            app.AlphaPETSlider.Value = 0.5;

            % Create HerramientasDropDownLabel
            app.HerramientasDropDownLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.HerramientasDropDownLabel.HorizontalAlignment = 'right';
            app.HerramientasDropDownLabel.Position = [592 115 77 22];
            app.HerramientasDropDownLabel.Text = 'Herramientas';

            % Create HerramientasDropDown
            app.HerramientasDropDown = uidropdown(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.HerramientasDropDown.Items = {'Ninguna', 'Regla', 'Crooshair', 'Zoom', 'Perfiles'};
            app.HerramientasDropDown.ItemsData = [1 2 3 4 5];
            app.HerramientasDropDown.ValueChangedFcn = createCallbackFcn(app, @HerramientasDropDownValueChanged, true);
            app.HerramientasDropDown.Enable = 'off';
            app.HerramientasDropDown.Position = [684 115 100 22];
            app.HerramientasDropDown.Value = 1;

            % Create GuardarButton
            app.GuardarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.GuardarButton.ButtonPushedFcn = createCallbackFcn(app, @GuardarButtonPushed, true);
            app.GuardarButton.Icon = fullfile(pathToMLAPP, 'ico', 'save.png');
            app.GuardarButton.Enable = 'off';
            app.GuardarButton.Position = [798 115 100 23];
            app.GuardarButton.Text = 'Guardar';

            % Create WindowWidthEditFieldLabel
            app.WindowWidthEditFieldLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.WindowWidthEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowWidthEditFieldLabel.Position = [191 312 82 22];
            app.WindowWidthEditFieldLabel.Text = 'Window Width';

            % Create WindowWidthEditField
            app.WindowWidthEditField = uieditfield(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'numeric');
            app.WindowWidthEditField.ValueChangedFcn = createCallbackFcn(app, @WindowWidthEditFieldValueChanged, true);
            app.WindowWidthEditField.Enable = 'off';
            app.WindowWidthEditField.Position = [281 312 43 22];

            % Create WindowLevelEditFieldLabel
            app.WindowLevelEditFieldLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.WindowLevelEditFieldLabel.HorizontalAlignment = 'right';
            app.WindowLevelEditFieldLabel.Position = [51 312 80 22];
            app.WindowLevelEditFieldLabel.Text = 'Window Level';

            % Create WindowLevelEditField
            app.WindowLevelEditField = uieditfield(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'numeric');
            app.WindowLevelEditField.ValueChangedFcn = createCallbackFcn(app, @WindowLevelEditFieldValueChanged, true);
            app.WindowLevelEditField.Enable = 'off';
            app.WindowLevelEditField.Position = [138 312 43 22];

            % Create HUXXXXXXLabel
            app.HUXXXXXXLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.HUXXXXXXLabel.HorizontalAlignment = 'right';
            app.HUXXXXXXLabel.FontWeight = 'bold';
            app.HUXXXXXXLabel.FontColor = [1 0 0];
            app.HUXXXXXXLabel.Visible = 'off';
            app.HUXXXXXXLabel.Position = [1001 612 70 22];
            app.HUXXXXXXLabel.Text = 'HUXXXXXX';

            % Create VerROICheckBox
            app.VerROICheckBox = uicheckbox(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.VerROICheckBox.ValueChangedFcn = createCallbackFcn(app, @VerROICheckBoxValueChanged, true);
            app.VerROICheckBox.Enable = 'off';
            app.VerROICheckBox.Text = 'Ver ROI';
            app.VerROICheckBox.Position = [421 312 65 22];
            app.VerROICheckBox.Value = true;

            % Create DilatarButton
            app.DilatarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.DilatarButton.ButtonPushedFcn = createCallbackFcn(app, @DilatarButtonPushed2, true);
            app.DilatarButton.Enable = 'off';
            app.DilatarButton.Position = [214 429 100 23];
            app.DilatarButton.Text = 'Dilatar';

            % Create ErosionarButton
            app.ErosionarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.ErosionarButton.ButtonPushedFcn = createCallbackFcn(app, @ErosionarButtonPushed2, true);
            app.ErosionarButton.Enable = 'off';
            app.ErosionarButton.Position = [214 396 100 23];
            app.ErosionarButton.Text = 'Erosionar';

            % Create SegEditFieldLabel
            app.SegEditFieldLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SegEditFieldLabel.HorizontalAlignment = 'right';
            app.SegEditFieldLabel.Position = [35 359 30 22];
            app.SegEditFieldLabel.Text = 'Seg.';

            % Create SegEditField
            app.SegEditField = uieditfield(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'text');
            app.SegEditField.ValueChangedFcn = createCallbackFcn(app, @SegEditFieldValueChanged, true);
            app.SegEditField.Position = [80 359 177 22];
            app.SegEditField.Value = 'm_di1d_di1e_di1e_di1d_di9e_di9e_di9e';

            % Create AplicarButton
            app.AplicarButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.AplicarButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarButtonPushed, true);
            app.AplicarButton.Enable = 'off';
            app.AplicarButton.Position = [267 359 100 23];
            app.AplicarButton.Text = 'Aplicar';

            % Create VerVOICheckBox
            app.VerVOICheckBox = uicheckbox(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.VerVOICheckBox.ValueChangedFcn = createCallbackFcn(app, @VerVOICheckBoxValueChanged, true);
            app.VerVOICheckBox.Enable = 'off';
            app.VerVOICheckBox.Text = 'Ver VOI';
            app.VerVOICheckBox.Position = [337 312 73 22];

            % Create ResultadosButton
            app.ResultadosButton = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.ResultadosButton.ButtonPushedFcn = createCallbackFcn(app, @ResultadosButtonPushed, true);
            app.ResultadosButton.Enable = 'off';
            app.ResultadosButton.Position = [384 359 100 23];
            app.ResultadosButton.Text = 'Resultados';

            % Create GuardarButton_2
            app.GuardarButton_2 = uibutton(app.PositroniumdotMATMododeanlisisconjunto2UIFigure, 'push');
            app.GuardarButton_2.ButtonPushedFcn = createCallbackFcn(app, @GuardarButton_2Pushed, true);
            app.GuardarButton_2.Icon = fullfile(pathToMLAPP, 'ico', 'xls.png');
            app.GuardarButton_2.Enable = 'off';
            app.GuardarButton_2.Position = [647 11 100 23];
            app.GuardarButton_2.Text = 'Guardar';

            % Create COVLabel
            app.COVLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.COVLabel.HorizontalAlignment = 'right';
            app.COVLabel.FontColor = [1 1 0.0667];
            app.COVLabel.Visible = 'off';
            app.COVLabel.Position = [950 591 121 21];
            app.COVLabel.Text = 'COV';

            % Create SRNLabel
            app.SRNLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.SRNLabel.HorizontalAlignment = 'right';
            app.SRNLabel.FontColor = [0 1 0];
            app.SRNLabel.Visible = 'off';
            app.SRNLabel.Position = [950 568 119 22];
            app.SRNLabel.Text = 'SRN';

            % Create UILabel
            app.UILabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.UILabel.HorizontalAlignment = 'right';
            app.UILabel.FontColor = [0.0588 1 1];
            app.UILabel.Visible = 'off';
            app.UILabel.Position = [950 547 119 22];
            app.UILabel.Text = 'UI';

            % Create MaxSUVSliderLabel
            app.MaxSUVSliderLabel = uilabel(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.MaxSUVSliderLabel.HorizontalAlignment = 'right';
            app.MaxSUVSliderLabel.FontSize = 9;
            app.MaxSUVSliderLabel.Enable = 'off';
            app.MaxSUVSliderLabel.Position = [467 547 41 22];
            app.MaxSUVSliderLabel.Text = 'MaxSUV';

            % Create MaxSUVSlider
            app.MaxSUVSlider = uislider(app.PositroniumdotMATMododeanlisisconjunto2UIFigure);
            app.MaxSUVSlider.Limits = [0 1];
            app.MaxSUVSlider.Orientation = 'vertical';
            app.MaxSUVSlider.ValueChangedFcn = createCallbackFcn(app, @MaxSUVSliderValueChanged, true);
            app.MaxSUVSlider.FontSize = 9;
            app.MaxSUVSlider.Enable = 'off';
            app.MaxSUVSlider.Position = [472 437 3 105];
            app.MaxSUVSlider.Value = 1;

            % Show the figure after all components are created
            app.PositroniumdotMATMododeanlisisconjunto2UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main3_1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PositroniumdotMATMododeanlisisconjunto2UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PositroniumdotMATMododeanlisisconjunto2UIFigure)
        end
    end
end