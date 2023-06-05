classdef main1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        PositroniumdotMATModoindividualUIFigure  matlab.ui.Figure
        RestaurarimagenCheckBox        matlab.ui.control.CheckBox
        InvertirCheckBox_2             matlab.ui.control.CheckBox
        MximoEditField                 matlab.ui.control.NumericEditField
        MximoEditFieldLabel            matlab.ui.control.Label
        MnimoEditField                 matlab.ui.control.NumericEditField
        MnimoEditFieldLabel            matlab.ui.control.Label
        AplicarSegButton               matlab.ui.control.Button
        SegmentacinporhistogramaLabel  matlab.ui.control.Label
        GradienteDropDown              matlab.ui.control.DropDown
        GradienteDropDownLabel         matlab.ui.control.Label
        TransponerCheckBox             matlab.ui.control.CheckBox
        Param2EditField                matlab.ui.control.NumericEditField
        Param2EditFieldLabel           matlab.ui.control.Label
        Param1EditField                matlab.ui.control.NumericEditField
        Param1EditFieldLabel           matlab.ui.control.Label
        AplicarfiltroButton            matlab.ui.control.Button
        ParamsfiltrosLabel             matlab.ui.control.Label
        FiltroslinealesynolinealesDropDown  matlab.ui.control.DropDown
        FiltroslinealesynolinealesDropDownLabel  matlab.ui.control.Label
        CoordsxyLabel                  matlab.ui.control.Label
        ComplementosDropDown           matlab.ui.control.DropDown
        ComplementosDropDownLabel      matlab.ui.control.Label
        EcualizacinDropDown            matlab.ui.control.DropDown
        EcualizacinDropDownLabel       matlab.ui.control.Label
        RealceymejoramientoLabel       matlab.ui.control.Label
        GammaSlider                    matlab.ui.control.Slider
        GammaSliderLabel               matlab.ui.control.Label
        ContrasteSlider                matlab.ui.control.Slider
        ContrasteSliderLabel           matlab.ui.control.Label
        BrilloSlider                   matlab.ui.control.Slider
        BrilloSliderLabel              matlab.ui.control.Label
        ColorDropDown                  matlab.ui.control.DropDown
        ColorDropDownLabel             matlab.ui.control.Label
        PginaTIFFDropDown              matlab.ui.control.DropDown
        PginaTIFFDropDownLabel         matlab.ui.control.Label
        CerrarButton                   matlab.ui.control.Button
        AplicarButton                  matlab.ui.control.Button
        GuadarButton                   matlab.ui.control.Button
        EsperandoLabel                 matlab.ui.control.Label
        CorrerButton                   matlab.ui.control.Button
        Button                         matlab.ui.control.Button
        Button_2                       matlab.ui.control.Button
        slidervalue2EditField          matlab.ui.control.NumericEditField
        slidervalue1EditField          matlab.ui.control.NumericEditField
        MostrarhistAcumCheckBox        matlab.ui.control.CheckBox
        outputTextArea                 matlab.ui.control.TextArea
        ButtonGroup                    matlab.ui.container.ButtonGroup
        DireccinButton                 matlab.ui.control.RadioButton
        MagnitudButton                 matlab.ui.control.RadioButton
        YDirButton                     matlab.ui.control.RadioButton
        XDirButton                     matlab.ui.control.RadioButton
        ButtonGroup_2                  matlab.ui.container.ButtonGroup
        UpdateButton                   matlab.ui.control.Button
        iRadnButton                    matlab.ui.control.Button
        theta_fEditField               matlab.ui.control.NumericEditField
        theta_fEditFieldLabel          matlab.ui.control.Label
        theta_sEditField               matlab.ui.control.NumericEditField
        theta_sEditFieldLabel          matlab.ui.control.Label
        theta_iEditField               matlab.ui.control.NumericEditField
        thetaLabel                     matlab.ui.control.Label
        TransformadasButtonGroup       matlab.ui.container.ButtonGroup
        RadnButton                     matlab.ui.control.RadioButton
        NormalButton                   matlab.ui.control.RadioButton
        FiltrosDropDown                matlab.ui.control.DropDown
        FiltrosDropDownLabel           matlab.ui.control.Label
        Param2EditField_2              matlab.ui.control.NumericEditField
        Param2EditField_2Label         matlab.ui.control.Label
        InvertirCheckBox               matlab.ui.control.CheckBox
        Param1EditField_2              matlab.ui.control.NumericEditField
        Param1EditField_2Label         matlab.ui.control.Label
        IntensidadSlider               matlab.ui.control.Slider
        IntensidadSliderLabel          matlab.ui.control.Label
        AplicarButton_3                matlab.ui.control.Button
        AbsButton                      matlab.ui.control.RadioButton
        ImButton                       matlab.ui.control.RadioButton
        ReButton                       matlab.ui.control.RadioButton
        UIAxes7                        matlab.ui.control.UIAxes
        UIAxes6                        matlab.ui.control.UIAxes
        UIAxes5                        matlab.ui.control.UIAxes
        UIAxes4_3                      matlab.ui.control.UIAxes
        UIAxes4_2                      matlab.ui.control.UIAxes
        UIAxes4                        matlab.ui.control.UIAxes
        UIAxes3                        matlab.ui.control.UIAxes
        UIAxes2                        matlab.ui.control.UIAxes
        UIAxes                         matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        pt1 = 0; p1
        pt2 = 255; p2
        formatos = {'.png','.jpg','.bmp','.dcm','.pcx','.tif'};
        mod1DIR
        output
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
        main_fig;histog_fig;histog_acum_fig
        lines_main;lines_mod
        histog_fig_mod,histog_acum_fig_mod
        rang_dinam_editable = 0;
        profile_lines_
        Px 
        Py
        %% 
        brillo = 0;
        contraste = 0;
        gamma = 1;
        %%filtro
        filtro_fig
        fspecial_filtro = randi([-5,5],5,5);
        filtros = {'Filtro Rnd','average','disk','gaussian','laplacian','log','motion','prewitt','sobel','mínimos','máximos','medianas'};
        gradiente_metodo = {'Seleccione...','intermediate','central','prewitt','sobel','Deshacer'};
        %%fourier
        main_fourier
        mod_fourier
        main_fig_fourier
        mod_fig_fourier
        fourier_index = 1;
        fourier_mask
        %% segmentacion
        seg_min = 100;
        seg_max = 150;
        seg_invertir=0;
        %
        iradon_max_size
    end
    
    
    methods (Access = private)
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

        function H = HAcum(~,imagen)
            clase = 'uint8';% provisional
            bits = 2^str2double(strjoin(regexp(clase,'[0-9]','match'),''));
            [cont,~]=imhist(imagen,bits);
            va=0; H = zeros(1,bits,'double');
            for v=1:bits
                H(v)=va+cont(v);
                va=H(v);
            end
        end
        
        function Imp = EqAcum(app,imagen)
            if length(size(imagen)) == 3
                
                [m1,n1,l]=size(imagen);
                Imp = zeros(m1,n1,l);
                for s = 1:l
                    H = HAcum(app,imagen(:,:,s));
                    for r=1:m1
                        for c=1:n1
                            ac=imagen(r,c,s);
                            Imp(r,c,s)=(H(ac+1)*(127/n1*m1));
                        end
                    end
                end
                Imp=uint8(255 * mat2gray(Imp));
            else
                H = HAcum(app,imagen);
                [m1,n1]=size(imagen);
                Imp = zeros(m1,n1,1);
                for r=1:m1
                    for c=1:n1
                        ac=imagen(r,c);
                        Imp(r,c)=(H(ac+1)*(127/m1*n1));
                    end
                end
                Imp=uint8(255 * mat2gray(Imp));
            end
        end
        
        % generamos los histogramas acumulativos
        function histAcum = histAcum_fig(app,imagen,color_tipo,ancho,altura,fcolor,UI_AXES)
                 binLocations=ancho*0.70+(ancho*0.30)*(0:1:255)/255;
                 
                 if contains(color_tipo,'truecolor')
                    histAcum = altura-(altura*0.30)*[transpose(HAcum(app,imagen(:,:,1))),transpose(HAcum(app,imagen(:,:,2))),...
                        transpose(HAcum(app,imagen(:,:,3)))]/max(max([transpose(HAcum(app,imagen(:,:,1))),transpose(HAcum(app,imagen(:,:,2))),transpose(HAcum(app,imagen(:,:,3)))]));
                    
                    hist1 = area(UI_AXES,binLocations,histAcum(:,1),FaceAlpha=0.4,BaseValue=altura,FaceColor = 'r',EdgeColor='none',HitTest='off');
                    hist2 = area(UI_AXES,binLocations,histAcum(:,2),FaceAlpha=0.4,BaseValue=altura,FaceColor = 'g',EdgeColor='none',HitTest='off');
                    hist3 = area(UI_AXES,binLocations,histAcum(:,3),FaceAlpha=0.4,BaseValue=altura,FaceColor = 'b',EdgeColor='none',HitTest='off');
                    plot1 = plot(UI_AXES,binLocations,histAcum(:,1),"Color",'r',"LineWidth",1,"LineStyle","-",HitTest='off');
                    plot2 = plot(UI_AXES,binLocations,histAcum(:,2),"Color",'g',"LineWidth",1,"LineStyle","-",HitTest='off');
                    plot3 = plot(UI_AXES,binLocations,histAcum(:,3),"Color",'b',"LineWidth",1,"LineStyle","-",HitTest='off');
                    histAcum = [hist1,hist2,hist3,plot1,plot2,plot3];
                else
                    %counts = imhist(imagen);
                    hist= altura-(altura*0.30)/max(max(HAcum(app,imagen)))*HAcum(app,imagen);
                    histAcum = area(UI_AXES,binLocations,hist,FaceAlpha=0.4,BaseValue=altura,FaceColor = fcolor,EdgeColor='none',HitTest='off');
                    plot_mono = plot(UI_AXES,binLocations,hist,"Color",fcolor,"LineWidth",1,"LineStyle","-",HitTest="off");
                    histAcum = [histAcum,plot_mono];

                end

        end
        
        function profile_lines = make_profile_fig(app,x,y,matriz1,matriz2,color_tipo,rgb_index,ancho,altura,UI_AXES_v,UI_AXES_h,UI_AXES_d)
            %%
            if x > ancho
                x = ancho;
            elseif x<1
                x = 1;
            end
            if y > altura
                y = altura;
            elseif y<1
                y = 1;
            end

            if app.RadnButton.Value == 1
                if contains(color_tipo,'truecolor')
                    matriz1 = uint8(255*matriz1/max(max(max(matriz1))));
                    matriz2 = uint8(255*matriz2/max(max(max(matriz2))));
                else
                    matriz1 = uint8(255*matriz1/max(max(matriz1)));
                    matriz2 = uint8(255*matriz2/max(max(matriz2)));
                end
            end

            app.CoordsxyLabel.Text  = "Coords. ("+int2str(x)+","+int2str(y)+")";
            hold(UI_AXES_v,"on")
            hold(UI_AXES_h,"on")
            hold(UI_AXES_d,"on")
            UI_AXES_v.YLim=[0,255];
            UI_AXES_h.YLim=[0,255];
            UI_AXES_d.YLim=[0,255];

            pxi = x; pyi = y;
            while 1
                  if pxi<=1 || pyi<=1
                      break
                  end
                  [pxi,pyi] = deal(pxi-1,pyi-1);
            end
            pxf = x; pyf = y;
            while 1
                  if pxf>=ancho || pyf>=altura
                      break
                  end
                  [pxf,pyf] = deal(pxf+1,pyf+1);
            end
            %%
            if contains(color_tipo,'truecolor')
                if rgb_index ~= 0
                    %monocolor
                    if rgb_index == 1
                        d_l = length(diag(matriz2(pyi:pyf,pxi:pxf,1)));
                        p_rojo_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x,1),"Color",[178/255,34/255,34/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:,1),"Color",[178/255,34/255,34/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf,1)),"Color",[178/255,34/255,34/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_rojo_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x,1),"Color",'r',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:,1),"Color",'r',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf,1)),"Color",'r',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        profile_lines = [p_rojo_1_v,p_rojo_1_h,p_rojo_1_d,p_rojo_2_v,p_rojo_2_h,p_rojo_2_d];
                        
                    end
                    if rgb_index == 2
                        d_l = length(diag(matriz2(pyi:pyf,pxi:pxf,2)));
                        p_verde_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x,2),"Color",[85/255,107/255,47/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:,2),"Color",[85/255,107/255,47/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf,2)),"Color",[85/255,107/255,47/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_verde_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x,2),"Color",'g',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:,2),"Color",'g',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf,2)),"Color",'g',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        profile_lines = [p_verde_1_v,p_verde_1_h,p_verde_1_d,p_verde_2_v,p_verde_2_h,p_verde_2_d];
                        
                    end
                    if rgb_index == 3
                        d_l=length(diag(matriz2(pyi:pyf,pxi:pxf,3)));
                        p_azul_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x,3),"Color",[0,139/255,139/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:,3),"Color",[0,139/255,139/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf,3)),"Color",[0,139/255,139/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_azul_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x,3),"Color",'b',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:,3),"Color",'b',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf,3)),"Color",'b',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        profile_lines = [p_azul_1_v,p_azul_1_h,p_azul_1_d,p_azul_2_v,p_azul_2_h,p_azul_2_d];
                    end
                    if rgb_index == 4
                        d_l = length(diag(matriz2(pyi:pyf,pxi:pxf)));
                        matriz1 = rgb2gray(matriz1);matriz2 = rgb2gray(matriz2);
                        p_grises_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x),"Color",[176/255,196/255,222/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:),"Color",[176/255,196/255,222/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf)),"Color",[176/255,196/255,222/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                       
                        p_grises_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x),"Color",'c',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:),"Color",'c',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf)),"Color",'c',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        profile_lines = [p_grises_1_v,p_grises_1_h,p_grises_1_d,p_grises_2_v,p_grises_2_h,p_grises_2_d];
                        
                    end
                    
                else
                    %color rgb_index = 1
                        d_l = length(diag(matriz2(pyi:pyf,pxi:pxf,1)));
                        p_rojo_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x,1),"Color",[178/255,34/255,34/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:,1),"Color",[178/255,34/255,34/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf,1)),"Color",[178/255,34/255,34/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_rojo_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x,1),"Color",'r',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:,1),"Color",'r',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_rojo_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf,1)),"Color",'r',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_verde_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x,2),"Color",[85/255,107/255,47/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:,2),"Color",[85/255,107/255,47/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf,2)),"Color",[85/255,107/255,47/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_verde_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x,2),"Color",'g',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:,2),"Color",'g',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_verde_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf,2)),"Color",'g',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_azul_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x,3),"Color",[0,139/255,139/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:,3),"Color",[0,139/255,139/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf,3)),"Color",[0,139/255,139/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        p_azul_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x,3),"Color",'b',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:,3),"Color",'b',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_azul_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf,3)),"Color",'b',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        profile_lines = [p_rojo_1_v,p_rojo_1_h,p_rojo_1_d,p_rojo_2_v,p_rojo_2_h,p_rojo_2_d,p_verde_1_v,p_verde_1_h,p_verde_1_d,p_verde_2_v,p_verde_2_h,p_verde_2_d,p_azul_1_v,p_azul_1_h,p_azul_1_d,p_azul_2_v,p_azul_2_h,p_azul_2_d];
                end
            else    
                        d_l = length(diag(matriz2(pyi:pyf,pxi:pxf)));
                        p_grises_2_v =  plot(UI_AXES_v,1:altura,matriz2(:,x),"Color",[186/255,85/255,211/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_2_h =  plot(UI_AXES_h,1:ancho, matriz2(y,:),"Color",[186/255,85/255,211/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_2_d =  plot(UI_AXES_d,1:d_l, diag(matriz2(pyi:pyf,pxi:pxf)),"Color",[186/255,85/255,211/255],"LineWidth",1,"LineStyle","-",HitTest='off');
                        
                       
                        p_grises_1_v =  plot(UI_AXES_v,1:altura,matriz1(:,x),"Color",'m',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_1_h =  plot(UI_AXES_h,1:ancho, matriz1(y,:),"Color",'m',"LineWidth",1,"LineStyle","-",HitTest='off');
                        p_grises_1_d =  plot(UI_AXES_d,1:d_l, diag(matriz1(pyi:pyf,pxi:pxf)),"Color",'m',"LineWidth",1,"LineStyle","-",HitTest='off');
                        %
                        profile_lines = [p_grises_1_v,p_grises_1_h,p_grises_1_d,p_grises_2_v,p_grises_2_h,p_grises_2_d];
                    
            end
        UI_AXES_v.XLim=[0,altura];
        UI_AXES_h.XLim=[0,ancho];
        UI_AXES_d.XLim=[0,d_l];
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
        function [lines] = get_lines(~,x,y,ancho,altura,UI_AXES)
            x = round(x);y=round(y);
            if x > ancho
                x = ancho;
            elseif x<1
                x = 1;
            end
            if y > altura
                y = altura;
            elseif y<1
                y = 1;
            end
            %%
            pxi = x; pyi = y;
            while 1
                  if pxi<=1 || pyi<=1
                      break
                  end
                  [pxi,pyi] = deal(pxi-1,pyi-1);
            end
            pxf = x; pyf = y;
            while 1
                  if pxf>=ancho || pyf>=altura
                      break
                  end
                  [pxf,pyf] = deal(pxf+1,pyf+1);
            end
            
            lineX = xline(UI_AXES, x,'Color',[0,128/255,128/255],'linewidth',1);
            lineY = yline(UI_AXES, y,'Color',[0,128/255,128/255],'linewidth',1);
            lineD = line(UI_AXES,'XData',[pxi pxf],'YData',[pyi pyf],'color',[0,128/255,128/255],'linewidth',1);
            lines = [lineX, lineY, lineD];
        end
        





        %%
        function [texto_label] = image_label(~,n1,n2,imagenes)
           if n2 > 1
                imagenes = imagenes(n1);
           end 
           texto_label = int2str(n1)+" / "+int2str(n2)+" "+imagenes; 
        end
        %%
        function [main_matrix, altura, ancho, color_tipo,minimo, maximo, tiff_pages] = get_image_params(app,dir,image_name,image_index,tif_index,n1)
            tiff_pages = 0;
            if n1 > 1
               image_name = image_name(image_index);
            end 
            image_name = convertStringsToChars(image_name);
            dir_image = fullfile(dir,image_name);
            if  contains(image_name,'.dcm','IgnoreCase',true)
                metadatos = dicominfo(dir_image,"UseDictionaryVR",true);
                main_matrix = dicomread(metadatos.Filename);
                main_matrix =  uint8(255 * mat2gray(main_matrix));
                maximo = max(max(main_matrix));
                minimo = min(min(main_matrix));
            else
                if contains(dir_image, '.tif','IgnoreCase',true)
                    metadatos =  imfinfo(dir_image);
                    tiff_pages=length(metadatos);
                    metadatos =  metadatos(tif_index);
                    main_matrix =  imread(dir_image,tif_index);
                    maximo = max(max(main_matrix));
                    minimo = min(min(main_matrix));
                else
                    % imagenes a color o BN jpg pnh y demás
                    metadatos =  imfinfo(dir_image);
                    main_matrix = imread(metadatos.Filename);
                    maximo = max(max(main_matrix));
                    minimo = min(min(main_matrix));
                end

            end
            main_matrix = uint8(main_matrix);
            ancho = double(metadatos.Width);
            altura = double(metadatos.Height);
            app.iradon_max_size = max(ancho,altura);
            color_tipo = metadatos.ColorType;
            if app.RadnButton.Value == 1
                theta = app.theta_iEditField.Value:app.theta_sEditField.Value:app.theta_fEditField.Value;
                if contains(color_tipo, 'truecolor')
                    R1 = radon(main_matrix(:,:,1),theta);
                    R2 = radon(main_matrix(:,:,2),theta);
                    R3 = radon(main_matrix(:,:,3),theta);
                    main_matrix = cat(3,R1,R2,R3);
                    tam = size(R3);
                    ancho = tam(2);
                    altura = tam(1);
                else
                    main_matrix = radon(main_matrix,theta);
                    tam = size(main_matrix);
                    ancho = tam(2);
                    altura = tam(1);
                end
            end
        end
        %%
        function [main_fig,histog,histog_acum] = make_fig(app,matrix,ancho,altura,color_tipo,rgb_index,hist_on_off,UI_AXES)
            UI_AXES.XLim=[1,ancho];
            UI_AXES.YLim=[1,altura];
            fcolor = 'm';
            color_tipo_m = color_tipo;
            if app.RadnButton.Value == 1
                if contains(color_tipo,'truecolor')
                    matrix = uint8(255*matrix/max(max(max(matrix))));
                else
                    matrix = uint8(255*matrix/max(max(matrix)));
                end
            end
            if contains(color_tipo,'truecolor')
                %% habilitamos la selección de color 
                app.ColorDropDown.Enable = "on";
                
                %%
                if rgb_index ~= 0
                    app.UIAxes3.XLabel.String = "[OK] Rango dinámico";
                    app.rang_dinam_editable = 1;
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
                    app.UIAxes3.XLabel.String = "[X] Rango dinámico";
                    app.rang_dinam_editable = 0;
                end
            else
                %% deshabilitamos la selección de color 
                app.ColorDropDown.Enable = "off";
                app.UIAxes3.XLabel.String = "[OK] Rango dinámico";
                app.rang_dinam_editable = 1;
                %%
            end
            
            hold(UI_AXES,"on")
            main_fig = imagesc(UI_AXES,matrix,"HitTest","off",[app.pt1 app.pt2]);colormap(UI_AXES,"gray");

            if hist_on_off == 1
                histog   = histograma_fig(app, matrix, altura, ancho, color_tipo_m,fcolor,UI_AXES);
                histog_acum = histAcum_fig(app,matrix,color_tipo_m,ancho,altura,fcolor,UI_AXES);
            else
                histog   = [];
                histog_acum = [];
            end
            if app.RadnButton.Value == 1
                UI_AXES.PlotBoxAspectRatio = [1, 1, 1];
            else
                UI_AXES.PlotBoxAspectRatio = [ancho/altura, 1, 1];
            end
            
            UI_AXES.YDir = 'reverse';

        end

        function [lines_main,histog_fig,histog_acum_fig] = make_new_fig(app,matrix,UI_AXES)
            [app.main_fig,histog_fig,histog_acum_fig] =make_fig(app,matrix,app.ancho,app.altura,app.color_tipo,app.rgb_index,app.hist_on_off,UI_AXES);
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
            
            lines_main = get_lines(app,round(app.ancho/2),round(app.altura/2),app.ancho,app.altura,UI_AXES);
        end


        %% filtros
        
        %%
        %app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @minNL);
        %app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @maxNL);
        %app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @medianaNL);
        function [] = min_max_median_filters(app,filt_index)
            if filt_index == 1
                if contains(app.color_tipo,'truecolor')
                    app.mod_matrix(:,:,1) =  nlfilter(app.main_matrix(:,:,1),[app.Param1EditField.Value app.Param1EditField.Value], @minNL);
                    app.mod_matrix(:,:,2) =  nlfilter(app.main_matrix(:,:,2),[app.Param1EditField.Value app.Param1EditField.Value], @minNL);
                    app.mod_matrix(:,:,3) =  nlfilter(app.main_matrix(:,:,3),[app.Param1EditField.Value app.Param1EditField.Value], @minNL);
                else
                     app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @minNL);
                end

            end
            if filt_index == 2
                if contains(app.color_tipo,'truecolor')
                    app.mod_matrix(:,:,1) =  nlfilter(app.main_matrix(:,:,1),[app.Param1EditField.Value app.Param1EditField.Value], @maxNL);
                    app.mod_matrix(:,:,2) =  nlfilter(app.main_matrix(:,:,2),[app.Param1EditField.Value app.Param1EditField.Value], @maxNL);
                    app.mod_matrix(:,:,3) =  nlfilter(app.main_matrix(:,:,3),[app.Param1EditField.Value app.Param1EditField.Value], @maxNL);
                else
                     app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @maxNL);
                end
            end
            if filt_index == 3
                if contains(app.color_tipo,'truecolor')
                    app.mod_matrix(:,:,1) =  nlfilter(app.main_matrix(:,:,1),[app.Param1EditField.Value app.Param1EditField.Value], @medianaNL);
                    app.mod_matrix(:,:,2) =  nlfilter(app.main_matrix(:,:,2),[app.Param1EditField.Value app.Param1EditField.Value], @medianaNL);
                    app.mod_matrix(:,:,3) =  nlfilter(app.main_matrix(:,:,3),[app.Param1EditField.Value app.Param1EditField.Value], @medianaNL);
                else
                     app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @medianaNL);
                end
            end
           
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
        
        
        function fourier_matrix = get_fourier_2d(~,matriz,rgb_index,color_tipo)
            if contains(color_tipo,'truecolor')  
                if rgb_index <= 4 && rgb_index >=0
                    fourier_matrix = zeros(size(matriz)); 
                    for n = 1:3 
                        fourier_matrix(:,:,n) = fftshift(fft2(matriz(:,:,n)));
                    end
                end
                %if rgb_index == 4
                   % fourier_matrix=fftshift(fft2(rgb2gray(matriz)));
                %end
            else
                fourier_matrix=fftshift(fft2(matriz));
            end
        end


        function inversa_fourier_matrix = get_ifourier_2d(~,fourier_matrix,fourier_mask,color_tipo)
            fourier_matrix = fourier_mask.*fourier_matrix;
            if contains(color_tipo,'truecolor')  
                %if rgb_index <= 3 && rgb_index >=0
                    inversa_fourier_matrix = zeros(size(fourier_matrix)); 
                    for n = 1:3 

                        inversa_fourier_matrix(:,:,n) = ifft2(fftshift(fourier_matrix(:,:,n)));
                    end
                %end
                %if rgb_index == 4
                %    inversa_fourier_matrix = ifft2(fftshift(fourier_matrix));
                %end
            else
                inversa_fourier_matrix=ifft2(fftshift(fourier_matrix));
            end
            %inversa_fourier_matrix=ifft2(fftshift(fourier_matrix));
            inversa_fourier_matrix = uint8(abs(inversa_fourier_matrix));
        end

        function fourier_fig = gen_fourier_fig(app,matriz,fourier_matrix,fourier_index,color_tipo,rgb_index,UIAXES)
            UIAXES.YLim=[0,app.altura];
            UIAXES.XLim=[0,app.ancho];
            if fourier_index == 1 % parte real 
                if contains(color_tipo,'truecolor')
                    fourier_matrix = real(fourier_matrix);
                    if rgb_index == 0
                        fourier_fig =  imshow(fourier_matrix,[24 10000], 'Parent', UIAXES);
                    end
                    if rgb_index == 1
                        fourier_fig =  imshow(fourier_matrix(:,:,1),[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 2
                        fourier_fig =  imshow(fourier_matrix(:,:,2),[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 3
                        fourier_fig =  imshow(fourier_matrix(:,:,3),[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 4
                        matriz = rgb2gray(matriz);
                        fourier_matrix = real(fftshift(fft2(matriz)));
                        fourier_fig =  imshow(fourier_matrix,[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                else
                    
                    fourier_fig =  imshow(real(fourier_matrix),[24 10000], 'Parent', UIAXES,Colormap = jet);
                end
                    
            end
             if fourier_index == 2 % parte imaginaria 
                 if contains(color_tipo,'truecolor')
                    fourier_matrix = imag(fourier_matrix);
                    if rgb_index == 0
                        fourier_fig =  imshow(fourier_matrix,[24 10000], 'Parent', UIAXES);
                    end
                    if rgb_index == 1
                        fourier_fig =  imshow(fourier_matrix(:,:,1),[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 2
                        fourier_fig =  imshow(fourier_matrix(:,:,2),[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 3
                        fourier_fig =  imshow(fourier_matrix(:,:,3),[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 4
                        matriz = rgb2gray(matriz);
                        fourier_matrix = imag(fftshift(fft2(matriz)));
                        fourier_fig =  imshow(fourier_matrix,[24 10000], 'Parent', UIAXES,Colormap = jet);
                    end
                 else
                    
                    fourier_fig =  imshow(imag(fourier_matrix),[24 10000], 'Parent', UIAXES,Colormap = jet);
                end

             end
              if fourier_index == 3 % magnitud 
                if contains(color_tipo,'truecolor')
                    fourier_matrix = uint8(255*mat2gray(log(1000+abs(fourier_matrix))));
                    if rgb_index == 0
                        fourier_fig =  imshow(fourier_matrix, 'Parent', UIAXES);
                    end
                    if rgb_index == 1
                        fourier_fig =  imshow(fourier_matrix(:,:,1), 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 2
                        fourier_fig =  imshow(fourier_matrix(:,:,2), 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 3
                        fourier_fig =  imshow(fourier_matrix(:,:,3), 'Parent', UIAXES,Colormap = jet);
                    end
                    if rgb_index == 4
                         matriz = rgb2gray(matriz);
                        fourier_matrix = uint8(255*mat2gray(log(1000+abs(fftshift(fft2(matriz))))));
                        fourier_fig =  imshow(fourier_matrix, 'Parent', UIAXES,Colormap = jet);
                    end
                else
                   fourier_matrix = uint8(255*mat2gray(log(1000+abs(fourier_matrix))));
                    fourier_fig =  imshow(fourier_matrix, 'Parent', UIAXES,Colormap = jet);
                end

              end
        end


        %%
        function img = filt_rejilla(~,grosor,tamano,lado,invertir)
                img = ones(tamano);
                for i = 1:lado:size(img, 2)
                    img(:, i:i+grosor-1) = 0;
                end
                for i = 1:lado:size(img, 1)
                    img(i:i+grosor-1, :) = 0;
                end
                if invertir == 0
                   img = img == 1;
                else
                   img = img == 0;
                end
                img = img(1:tamano(1),1:tamano(2));
        end

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
        function [] = reset_fourier(app)
            app.FiltrosDropDown.Value = 1;
            app.IntensidadSlider.Value = 1;
            app.InvertirCheckBox.Value = 1;
            app.Param1EditField_2.Value = 0;
            app.Param2EditField_2.Value = 0;
            app.Param1EditField_2.Enable = "off";
            app.Param2EditField_2.Enable = "off";
            app.AplicarButton_3.Enable = "off";
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
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
           app.Param1EditField_2Label.Enable ="on";
           movegui(app.PositroniumdotMATModoindividualUIFigure, 'center'); 
           load("saved_data.mat","modo1DIR");app.mod1DIR=modo1DIR;
           app.output = "Directorio cargado: " + convertCharsToStrings(app.mod1DIR);
           app.outputTextArea.Value = app.output;
           archivos = dir(fullfile(app.mod1DIR,'*.*'));%listamos todos los objetos que tengan una extensión en 
           [~,~,ext]=fileparts({archivos.name});          %el directorio dado
           archivos =  archivos(matches(ext,app.formatos,"IgnoreCase",1));
           app.files=[convertCharsToStrings({archivos.name})];
           app.images_number = length(app.files);
           %lista = '';
           %for i = 1:app.images_number
           %      lista = sprintf("%s%s\n", lista, app.files(i));
           %end
           if isempty({archivos.name}) 
                    app.output = "[X] Directorio vacío.";
                    app.outputTextArea.Value =  app.output;
                    app.CorrerButton.Enable = "off";
                    app.EsperandoLabel.Text = "Error.";
           else 
                    %n = app.images_number;
                    app.output = "[OK] Archivos compatibles encontrados: " + int2str(app.images_number) +newline + app.output;
                    app.outputTextArea.Value = app.output;
                    app.CorrerButton.Enable = "on";
                    app.EsperandoLabel.Text = "idle.";
           end
            

           %%
           [app.p1, app.p2, app.pt1, app.pt2] = slider_2(app,0,app.pt1, app.pt2,app.UIAxes3);
            app.FiltroslinealesynolinealesDropDown.Items = app.filtros;
            app.GradienteDropDown.Items = app.gradiente_metodo;
            app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
            app.TransponerCheckBox.Enable = "on";
            
        end

        % Button pushed function: CorrerButton
        function CorrerButtonPushed(app, event)
            app.CorrerButton.Visible = "off";
            app.AplicarButton.Visible = "on";
            app.AplicarfiltroButton.Enable="on";
            app.GradienteDropDown.Enable = "on";
            app.Button.Enable = "on";
            app.Button_2.Enable = "on";
            app.GuadarButton.Enable = "on";
            app.MostrarhistAcumCheckBox.Enable ="on";
            app.ComplementosDropDown.Enable = "on";
            app.EcualizacinDropDown.Enable ="on";
            app.BrilloSlider.Enable="on";
            app.ContrasteSlider.Enable ="on";
            app.GammaSlider.Enable = "on";
            app.AplicarSegButton.Enable = "on";
            app.MnimoEditField.Enable = "on";
            app.MximoEditField.Enable = "on";
            app.InvertirCheckBox_2.Enable ="on";
            %app.IntensidadSlider.Enable = "on";
            app.FiltrosDropDown.Enable="on";
            app.theta_iEditField.Enable = "on";
            app.theta_sEditField.Enable = "on";
            app.theta_fEditField.Enable = "on";
            
            app.ButtonGroup_2.Enable = "on";
            
            app.EsperandoLabel.Text = image_label(app,app.imag_index,app.images_number,app.files);


            [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            app.mod_matrix = app.main_matrix;
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            %%
            app.Px = app.ancho/2; app.Py = app.altura/2;
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = app.main_fourier;
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
            %%

            
            %ButtonPushed(app, true)
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            % boton atras
            app.imag_index = app.imag_index - 1;
            if app.imag_index < 1
                app.imag_index = app.images_number;
            end
            app.EsperandoLabel.Text = image_label(app,app.imag_index,app.images_number,app.files);
            [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            
            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            app.mod_matrix = app.main_matrix;
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
            
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            % boton siguiente
            app.imag_index = app.imag_index + 1;
            if app.imag_index > app.images_number
                app.imag_index = 1;
            end
            app.EsperandoLabel.Text = image_label(app,app.imag_index,app.images_number,app.files);
            [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            
            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            app.mod_matrix = app.main_matrix;
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
              P = get(app.UIAxes,'CurrentPoint'); 
              delete([app.lines_main,app.lines_mod])
              app.Px = P(1,1); app.Py = P(1,2);
              delete([app.lines_main,app.lines_mod])
              app.lines_main = get_lines(app,app.Px,app.Py,app.ancho,app.altura,app.UIAxes);
              app.lines_mod = get_lines(app,app.Px,app.Py,app.ancho,app.altura,app.UIAxes2);
              delete(app.profile_lines_)
              app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
              %%
                if app.FiltrosDropDown.Value  == 2 % circular

                    app.fourier_mask = filt_circ(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
                    delete(app.filtro_fig)
                    app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
                    app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
                end
                if app.FiltrosDropDown.Value  == 3 % rejilla
    
                    app.fourier_mask = filt_rejilla(app,app.Param1EditField_2.Value,[app.altura, app.ancho],app.Param2EditField_2.Value,app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
                    delete(app.filtro_fig)
                    app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
                    app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
                end
                if app.FiltrosDropDown.Value  == 4 % rectangular
    
                    app.fourier_mask = filt_rect(app,app.Param1EditField_2.Value,app.Param2EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);}delete(app.filtro_fig)
                    app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
                    app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
                end
               
        end

        % Button down function: UIAxes2
        function UIAxes2ButtonDown(app, event)
              P = get(app.UIAxes2,'CurrentPoint'); 
              delete([app.lines_main,app.lines_mod])
              app.Px = P(1,1); app.Py = P(1,2);
              app.lines_main = get_lines(app,app.Px,app.Py,app.ancho,app.altura,app.UIAxes);
              app.lines_mod = get_lines(app,app.Px,app.Py,app.ancho,app.altura,app.UIAxes2);
              delete(app.profile_lines_)
              app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
              %%
            if app.FiltrosDropDown.Value  == 2 % circular

                app.fourier_mask = filt_circ(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
                delete(app.filtro_fig)
                app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
                app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
            end
            if app.FiltrosDropDown.Value  == 3 % rejilla

                app.fourier_mask = filt_rejilla(app,app.Param1EditField_2.Value,[app.altura, app.ancho],app.Param2EditField_2.Value,app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
                delete(app.filtro_fig)
                app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
                app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
            end
            if app.FiltrosDropDown.Value  == 4 % rectangular

                app.fourier_mask = filt_rect(app,app.Param1EditField_2.Value,app.Param2EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);}delete(app.filtro_fig)
                app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
                app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
            end
        end

        % Button down function: UIAxes3
        function UIAxes3ButtonDown(app, event)
            if app.rang_dinam_editable == 1
             P1 = get(app.UIAxes3,'CurrentPoint'); 
             x=P1(1,1);
             delete([app.lines_main,app.lines_mod])
             delete(app.p1);delete(app.p2)
             [app.p1, app.p2, app.pt1, app.pt2] = slider_2(app,x,app.pt1, app.pt2,app.UIAxes3);
             app.slidervalue1EditField.Value = app.pt1;
             app.slidervalue2EditField.Value = app.pt2;
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            drawnow nocallbacks
            end
           
        end

        % Value changed function: MostrarhistAcumCheckBox
        function MostrarhistAcumCheckBoxValueChanged(app, event)
            app.hist_on_off = app.MostrarhistAcumCheckBox.Value;
            
            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            %app.mod_matrix = app.main_matrix;
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
        end

        % Value changed function: ColorDropDown
        function ColorDropDownValueChanged(app, event)
            app.rgb_index = app.ColorDropDown.Value;
            % = 1;
            %app.tiff_index = 1;
            %[app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, ~] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            if app.RestaurarimagenCheckBox.Value == 1
                app.mod_matrix = app.main_matrix; 
            end
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);

            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%

            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            %reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Value changed function: PginaTIFFDropDown
        function PginaTIFFDropDownValueChanged(app, event)
            app.tiff_index = app.PginaTIFFDropDown.Value;
            [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            app.mod_matrix = app.main_matrix;
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%

            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            %reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Value changed function: BrilloSlider
        function BrilloSliderValueChanged(app, event)
            app.brillo = app.BrilloSlider.Value;
            app.mod_matrix = (1+app.contraste)*imadjust(app.main_matrix,[0;1],[0;1],app.gamma)+app.brillo;
            delete(app.lines_mod)
            %[app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            %app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
           mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
           app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Value changed function: ContrasteSlider
        function ContrasteSliderValueChanged(app, event)
            app.contraste = app.ContrasteSlider.Value/100;
            app.mod_matrix = (1+app.contraste)*imadjust(app.main_matrix,[0;1],[0;1],app.gamma)+app.brillo;
            delete(app.lines_mod)
            %[app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            %app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
           app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Value changed function: GammaSlider
        function GammaSliderValueChanged(app, event)
            app.gamma = app.GammaSlider.Value;
            app.mod_matrix = (1+app.contraste)*imadjust(app.main_matrix,[0;1],[0;1],app.gamma)+app.brillo;
            delete(app.lines_mod)
            %[app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            %app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Button pushed function: AplicarButton
        function AplicarButtonPushed(app, event)
            app.output = "[OK] Se han aplicado los cambios." + newline + app.output;
            app.outputTextArea.Value = app.output;
            
            app.main_matrix = app.mod_matrix;

            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);

           
            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);

            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Value changed function: ComplementosDropDown
        function ComplementosDropDownValueChanged(app, event)
            value = app.ComplementosDropDown.Value;
            if value == 1 || value == 5
                app.mod_matrix = app.main_matrix;
                app.ComplementosDropDown.Value = 1;
            end
            if value == 2
                app.mod_matrix = max(max(app.main_matrix)) - app.main_matrix;
            end
            if value == 3
                c = max(max(app.main_matrix)) - app.main_matrix;
                app.mod_matrix = c - app.main_matrix;
            end
            if value == 4
                c = max(max(app.main_matrix)) - app.main_matrix;
                app.mod_matrix = app.main_matrix - c;
            end
            delete(app.lines_mod)
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_realce_mejoramiento(app);
            app.EcualizacinDropDown.Value = 1;
            reset_gradient(app);
            %%
            reset_fourier(app)
            %app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
           app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Value changed function: EcualizacinDropDown
        function EcualizacinDropDownValueChanged(app, event)
            value = app.EcualizacinDropDown.Value;
            if value == 1 || value == 4
                app.mod_matrix = app.main_matrix;
                app.EcualizacinDropDown.Value = 1;
            end
            if value == 2
                app.mod_matrix = EqAcum(app,app.main_matrix);
            end
            if value == 3
                max=220;min=210;h1=90;l1=80;
                app.mod_matrix= (app.main_matrix-l1)*((max-min)/(h1-l1));
            end
            delete(app.lines_mod)
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            
            reset_realce_mejoramiento(app);
            reset_gradient(app);
            app.ComplementosDropDown.Value = 1;
            
            %%
            reset_fourier(app)
            %app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
           app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);

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

        % Button pushed function: AplicarfiltroButton
        function AplicarfiltroButtonPushed(app, event)
            %cambio = 0;
            if app.FiltroslinealesynolinealesDropDown.Value <= 9 && app.FiltroslinealesynolinealesDropDown.Value >= 1
                app.mod_matrix = imfilter(app.main_matrix,app.fspecial_filtro,'replicate');
                %cambio = 1;
            end
            %app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @minNL);
            %app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @maxNL);
            %app.mod_matrix =  nlfilter(app.main_matrix,[app.Param1EditField.Value app.Param1EditField.Value], @medianaNL);
            
            if app.FiltroslinealesynolinealesDropDown.Value == 10
                min_max_median_filters(app,1)
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 11
                min_max_median_filters(app,2)
            end
            if app.FiltroslinealesynolinealesDropDown.Value == 12
                min_max_median_filters(app,3)
            end
            
          
            
            
            
           %if cambio == 1
                delete(app.lines_mod)
                %[app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
                [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
                
                delete(app.profile_lines_)
                app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
                %%
                reset_realce_mejoramiento(app);
                reset_gradient(app);
                app.ComplementosDropDown.Value = 1;
                app.EcualizacinDropDown.Value = 1;
           %%
           reset_fourier(app)
           %app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
           app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Value changed function: TransponerCheckBox
        function TransponerCheckBoxValueChanged(app, event)
            %value = app.TransponerCheckBox.Value;
             delete(app.filtro_fig)
             %app.fspecial_filtro = fspecial(char(app.filtros(7)),app.Param1EditField.Value,value);
             app.fspecial_filtro=transpose(app.fspecial_filtro);
             app.filtro_fig =  imshow(app.fspecial_filtro,[], 'Parent', app.UIAxes5,Colormap = jet);
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
            delete(app.lines_mod)
            %[app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_realce_mejoramiento(app);
            
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            %app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
           app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
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
            delete(app.lines_mod)
            %[app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_realce_mejoramiento(app);
            
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
            
        end

        % Button pushed function: GuadarButton
        function GuadarButtonPushed(app, event)
            app.GuadarButton.Enable = "off";
            save_dir = fullfile(app.mod1DIR,'positronium_saved_images');
            if ~exist(save_dir, 'dir')
               mkdir(save_dir);
               app.output = "[!] Directorio positronium_saved_images no encontrado, creando directorio en " + convertCharsToStrings(app.mod1DIR) + newline + app.output;
               app.outputTextArea.Value = app.output;
            else
               app.output = "[OK] Directorio positronium_saved_images encontrado en " + convertCharsToStrings(app.mod1DIR) + newline + app.output;
               app.outputTextArea.Value = app.output;
            end
            %app.files(app.imag_index)
            file_name = char(app.files(app.imag_index));%
            new_imag_dir = fullfile(save_dir,[file_name(1:end-4),'_',char(datetime('now','TimeZone','local','Format','d_MMM_y_HH_mm_ss_ms')),'.png']);
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
            app.outputTextArea.Value = app.output;
            pause(1)
            app.GuadarButton.Enable = "on";

        end

        % Value changed function: FiltrosDropDown
        function FiltrosDropDownValueChanged(app, event)
            value = app.FiltrosDropDown.Value;
            %app.Param1EditField_2.Enable = "on";
            %app.Param2EditField_2.Enable = "on";
            %app.InvertirCheckBox.Enable ="on";
            if value == 1 || value == 5
                app.Param1EditField_2.Enable = "off";
                app.Param2EditField_2.Enable = "off";
                app.Param1EditField_2Label.Text = "Param1";
                app.Param2EditField_2Label.Text = "Param2";
                app.IntensidadSlider.Value=1;
                app.IntensidadSlider.Enable ="off";
                app.AplicarButton_3.Enable ="off";
                app.Param1EditField_2.Value = 0;
                app.Param2EditField_2.Value = 0;
                %app.mod_matrix = app.main_matrix;
                app.FiltrosDropDown.Value = 1;
                app.InvertirCheckBox.Enable = "off";
                app.InvertirCheckBox.Value = 1;
            else
                app.IntensidadSlider.Enable ="on";
                app.AplicarButton_3.Enable ="on";
                app.InvertirCheckBox.Enable = "on";
                if value == 2 % circular
                    app.Param1EditField_2.Enable = "on";
                    app.Param2EditField_2.Enable = "off";
                    app.Param1EditField_2Label.Text = "Radio";
                    app.Param2EditField_2Label.Text = "Param2";
                    app.Param1EditField_2.Value = 100;
                    app.Param2EditField_2.Value = 0;
                    app.fourier_mask = filt_circ(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
                end
                if value == 3 % rejilla
                    app.Param1EditField_2.Enable = "on";
                    app.Param2EditField_2.Enable = "on";
                    app.Param1EditField_2Label.Text = "Gros.";
                    app.Param2EditField_2Label.Text = "Lado";
                    app.Param1EditField_2.Value = 30;
                    app.Param2EditField_2.Value = 150;
                    app.fourier_mask = filt_rejilla(app,app.Param1EditField_2.Value,[app.altura, app.ancho],app.Param2EditField_2.Value,app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
                end
                if value == 4 % rectangular
                    app.Param1EditField_2.Enable = "on";
                    app.Param2EditField_2.Enable = "on";
                    app.Param1EditField_2Label.Text = "Lado1";
                    app.Param2EditField_2Label.Text = "Lado2";
                    app.Param1EditField_2.Value = 100;
                    app.Param2EditField_2.Value = 150;
                    app.fourier_mask = filt_rect(app,app.Param1EditField_2.Value,app.Param2EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
                end
                delete(app.filtro_fig)
                app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
                app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);

            end
        end

        % Value changed function: InvertirCheckBox
        function InvertirCheckBoxValueChanged(app, event)
            value = app.InvertirCheckBox.Value;
            if app.FiltrosDropDown.Value == 2 % circular

                app.fourier_mask = filt_circ(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],value);
            end
            if app.FiltrosDropDown.Value == 3 % rejilla

                app.fourier_mask = filt_rejilla(app,app.Param1EditField_2.Value,[app.altura, app.ancho],app.Param2EditField_2.Value,value);
            end
            if app.FiltrosDropDown.Value == 4 % rectangular

                app.fourier_mask = filt_rect(app,app.Param1EditField_2.Value,app.Param2EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],value);
            end
            delete(app.filtro_fig)
            app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
            app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
        end

        % Value changed function: Param1EditField_2
        function Param1EditField_2ValueChanged(app, event)
            value = app.Param1EditField_2.Value;
            if app.FiltrosDropDown.Value  == 2 % circular

                app.fourier_mask = filt_circ(app,value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            if app.FiltrosDropDown.Value  == 3 % rejilla

                app.fourier_mask = filt_rejilla(app,value,[app.altura, app.ancho],app.Param2EditField_2.Value,app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            if app.FiltrosDropDown.Value  == 4 % rectangular

                app.fourier_mask = filt_rect(app,value,app.Param2EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            delete(app.filtro_fig)
            app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
            app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
        end

        % Value changed function: Param2EditField_2
        function Param2EditField_2ValueChanged(app, event)
            value = app.Param2EditField_2.Value;
            if app.FiltrosDropDown.Value  == 3 % rejilla

                app.fourier_mask = filt_rejilla(app,app.Param1EditField_2.Value,[app.altura, app.ancho],value,app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            if app.FiltrosDropDown.Value  == 4 % rectangular

                app.fourier_mask = filt_rect(app,app.Param1EditField_2.Value,value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            delete(app.filtro_fig)
            app.fourier_mask = app.IntensidadSlider.Value*double(app.fourier_mask);
            app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
        end

        % Value changed function: IntensidadSlider
        function IntensidadSliderValueChanged(app, event)
            value = app.IntensidadSlider.Value;
            if app.FiltrosDropDown.Value  == 2 % circular
                app.fourier_mask = filt_circ(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            if app.FiltrosDropDown.Value  == 3 % rejilla
                app.fourier_mask = filt_rejilla(app,app.Param1EditField_2.Value,[app.altura, app.ancho],app.Param2EditField_2.Value,app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            if app.FiltrosDropDown.Value  == 4 % rectangular

                app.fourier_mask = filt_rect(app,app.Param1EditField_2.Value,app.Param2EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);%filt(app,app.Param1EditField_2.Value,app.Py,app.Px,[app.altura, app.ancho],app.InvertirCheckBox.Value);
            end
            delete(app.filtro_fig)
            app.fourier_mask = value*double(app.fourier_mask);
            app.filtro_fig =  imshow(app.fourier_mask,[0 1], 'Parent', app.UIAxes5);
            
        end

        % Selection changed function: ButtonGroup_2
        function ButtonGroup_2SelectionChanged(app, event)
            selectedButton = app.ButtonGroup_2.SelectedObject;
            if contains(selectedButton.Text,'Re()')
                app.fourier_index = 1;
            end
            if contains(selectedButton.Text,'Im()')
                app.fourier_index = 2;
            end
            if contains(selectedButton.Text,'Abs()')
                app.fourier_index = 3;
            end
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Button pushed function: AplicarButton_3
        function AplicarButton_3Pushed(app, event)
            if app.RadnButton.Value == 1
                app.mod_matrix = app.fourier_mask.*app.main_matrix;
            else
                app.mod_matrix = get_ifourier_2d(app,app.mod_fourier,app.fourier_mask,app.color_tipo);
            end
            delete(app.lines_mod)
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
           %%
           reset_fourier(app)
           mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
           app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
           
        end

        % Button pushed function: AplicarSegButton
        function AplicarSegButtonPushed(app, event)
            seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            app.mod_matrix = uint8(seg_mask).*app.main_matrix;
            delete(app.lines_mod)
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            delete(app.profile_lines_)
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_realce_mejoramiento(app);
            reset_gradient(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            mod_fourier_filter = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,mod_fourier_filter,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);



            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(seg_mask), 'Parent', app.UIAxes5);

        end

        % Value changed function: InvertirCheckBox_2
        function InvertirCheckBox_2ValueChanged(app, event)
            app.seg_invertir = app.InvertirCheckBox_2.Value;
            seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(seg_mask), 'Parent', app.UIAxes5);

        end

        % Value changed function: MnimoEditField
        function MnimoEditFieldValueChanged(app, event)
            app.seg_min = app.MnimoEditField.Value;
            app.seg_invertir = app.InvertirCheckBox_2.Value;
            seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(seg_mask), 'Parent', app.UIAxes5);
        end

        % Value changed function: MximoEditField
        function MximoEditFieldValueChanged(app, event)
            app.seg_max = app.MximoEditField.Value;
            app.seg_invertir = app.InvertirCheckBox_2.Value;
            seg_mask = segmentacion_mascara(app,app.main_matrix,app.seg_min,app.seg_max,app.rgb_index,app.color_tipo,app.seg_invertir);
            delete(app.filtro_fig)
            app.filtro_fig =  imshow(255*uint8(seg_mask), 'Parent', app.UIAxes5);
        end

        % Selection changed function: TransformadasButtonGroup
        function TransformadasButtonGroupSelectionChanged(app, event)
            if app.RadnButton.Value ==1
                app.UpdateButton.Enable = "on";
                app.iRadnButton.Enable ="on";
                app.EcualizacinDropDown.Enable = "off";
                app.AplicarSegButton.Enable = "off";
                app.GradienteDropDown.Enable = "off";
                app.BrilloSlider.Enable = "off";
                app.ContrasteSlider.Enable = "off";
                app.GammaSlider.Enable = "off";
            else
                app.UpdateButton.Enable = "off";
                app.iRadnButton.Enable ="off";
                app.EcualizacinDropDown.Enable = "on";
                app.AplicarSegButton.Enable = "on";
                app.GradienteDropDown.Enable = "on";
                app.BrilloSlider.Enable = "on";
                app.ContrasteSlider.Enable = "on";
                app.GammaSlider.Enable = "on";
            end
            
            
            
            [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            app.mod_matrix = app.main_matrix;
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
            
        end

        % Button pushed function: UpdateButton
        function UpdateButtonPushed(app, event)
            [app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            app.mod_matrix = app.main_matrix;
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
        end

        % Button pushed function: iRadnButton
        function iRadnButtonPushed(app, event)
            %[app.main_matrix, app.altura, app.ancho, app.color_tipo,~, ~, app.tiff_pages] = get_image_params(app,app.mod1DIR,app.files,app.imag_index,app.tiff_index,app.images_number);
            app.RadnButton.Value = 0;
            app.UpdateButton.Enable = "off";
            app.iRadnButton.Enable = "off";
            if contains(app.color_tipo,'truecolor')%app.iradon_max_size
                theta = app.theta_iEditField.Value:app.theta_sEditField.Value:app.theta_fEditField.Value;
                iR1 = iradon(app.main_matrix(:,:,1),theta,app.iradon_max_size);
                iR2 = iradon(app.main_matrix(:,:,2),theta,app.iradon_max_size);
                iR3 = iradon(app.main_matrix(:,:,3),theta,app.iradon_max_size);
                app.main_matrix = uint8(cat(3,iR1,iR2,iR3));
                iR1m = iradon(app.mod_matrix(:,:,1),theta,app.iradon_max_size);
                iR2m = iradon(app.mod_matrix(:,:,2),theta,app.iradon_max_size);
                iR3m = iradon(app.mod_matrix(:,:,3),theta,app.iradon_max_size);
                app.mod_matrix = uint8(cat(3,iR1m,iR2m,iR3m));
                app.ancho = app.iradon_max_size;
                app.altura = app.iradon_max_size;
            else
                theta = app.theta_iEditField.Value:app.theta_sEditField.Value:app.theta_fEditField.Value;
                app.main_matrix = uint8(iradon(app.main_matrix,theta,app.iradon_max_size));
                app.mod_matrix = uint8(iradon(app.mod_matrix,theta,app.iradon_max_size));
                app.ancho = app.iradon_max_size;
                app.altura = app.iradon_max_size;
            end
            
            
            app.EcualizacinDropDown.Enable = "on";
            app.AplicarSegButton.Enable = "on";
            app.GradienteDropDown.Enable = "on";
            app.BrilloSlider.Enable = "on";
            app.ContrasteSlider.Enable = "on";
            app.GammaSlider.Enable = "on";

            delete([app.lines_main,app.lines_mod])
            [app.lines_main,app.histog_fig,app.histog_acum_fig]=make_new_fig(app,app.main_matrix,app.UIAxes);
            %app.mod_matrix = app.main_matrix;
            [app.lines_mod,app.histog_fig_mod,app.histog_acum_fig_mod]=make_new_fig(app,app.mod_matrix,app.UIAxes2);
            
            delete(app.profile_lines_)
            app.Px = app.ancho/2; app.Py = app.altura/2;
            app.profile_lines_ =  make_profile_fig(app,round(app.Px),round(app.Py),app.main_matrix,app.mod_matrix,app.color_tipo,app.rgb_index,app.ancho,app.altura,app.UIAxes4,app.UIAxes4_2,app.UIAxes4_3);
            %%
            reset_gradient(app);
            reset_realce_mejoramiento(app);
            app.ComplementosDropDown.Value = 1;
            app.EcualizacinDropDown.Value = 1;
            %%
            reset_fourier(app)
            app.main_fourier =  get_fourier_2d(app,app.main_matrix,app.rgb_index,app.color_tipo);
            app.mod_fourier = get_fourier_2d(app,app.mod_matrix,app.rgb_index,app.color_tipo);
            app.main_fig_fourier = gen_fourier_fig(app,app.main_matrix,app.main_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes6);
            app.mod_fig_fourier = gen_fourier_fig(app,app.mod_matrix,app.mod_fourier,app.fourier_index,app.color_tipo,app.rgb_index,app.UIAxes7);
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

            % Create PositroniumdotMATModoindividualUIFigure and hide until all components are created
            app.PositroniumdotMATModoindividualUIFigure = uifigure('Visible', 'off');
            app.PositroniumdotMATModoindividualUIFigure.Position = [100 100 1349 718];
            app.PositroniumdotMATModoindividualUIFigure.Name = 'Positronium dot MAT - Modo individual';
            app.PositroniumdotMATModoindividualUIFigure.Icon = fullfile(pathToMLAPP, 'ico', 'positronium_ico_small.jpg');
            app.PositroniumdotMATModoindividualUIFigure.Resize = 'off';

            % Create UIAxes
            app.UIAxes = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            title(app.UIAxes, 'Imagen original')
            xlabel(app.UIAxes, 'Píxeles X')
            ylabel(app.UIAxes, 'Píxeles Y')
            app.UIAxes.Toolbar.Visible = 'off';
            app.UIAxes.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes.XTick = [];
            app.UIAxes.XTickLabel = '';
            app.UIAxes.YTick = [];
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [1014 469 323 235];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
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
            app.UIAxes2.Position = [385 243 599 462];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            xlabel(app.UIAxes3, 'Rango dinámico')
            app.UIAxes3.Toolbar.Visible = 'off';
            app.UIAxes3.XLim = [-5 260];
            app.UIAxes3.YLim = [0 1e-06];
            app.UIAxes3.XTick = [0 25 50 75 100 125 150 175 200 225 255];
            app.UIAxes3.XTickLabel = {'0'; '25'; '50'; '75'; '100'; '125'; '150'; '175'; '200'; '225'; '255'};
            app.UIAxes3.YTick = [];
            app.UIAxes3.LineWidth = 2;
            app.UIAxes3.Color = [0.9412 0.9412 0.9412];
            app.UIAxes3.FontSize = 11;
            app.UIAxes3.ButtonDownFcn = createCallbackFcn(app, @UIAxes3ButtonDown, true);
            app.UIAxes3.Position = [432 198 194 33];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            title(app.UIAxes4, 'Perfil Vertical')
            xlabel(app.UIAxes4, 'Pos. de Píxel')
            ylabel(app.UIAxes4, 'Intensidad')
            zlabel(app.UIAxes4, 'Z')
            app.UIAxes4.Toolbar.Visible = 'off';
            app.UIAxes4.PlotBoxAspectRatio = [3 1 1];
            app.UIAxes4.XGrid = 'on';
            app.UIAxes4.YGrid = 'on';
            app.UIAxes4.FontSize = 10;
            app.UIAxes4.Position = [1014 310 323 150];

            % Create UIAxes4_2
            app.UIAxes4_2 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            title(app.UIAxes4_2, 'Perfil Horizontal')
            xlabel(app.UIAxes4_2, 'Pos. de Píxel')
            ylabel(app.UIAxes4_2, 'Intensidad')
            zlabel(app.UIAxes4_2, 'Z')
            app.UIAxes4_2.Toolbar.Visible = 'off';
            app.UIAxes4_2.PlotBoxAspectRatio = [3 1 1];
            app.UIAxes4_2.XGrid = 'on';
            app.UIAxes4_2.YGrid = 'on';
            app.UIAxes4_2.FontSize = 10;
            app.UIAxes4_2.Position = [1014 164 323 150];

            % Create UIAxes4_3
            app.UIAxes4_3 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            title(app.UIAxes4_3, 'Perfil Diagonal')
            xlabel(app.UIAxes4_3, 'Pos. de Píxel')
            ylabel(app.UIAxes4_3, 'Intensidad')
            zlabel(app.UIAxes4_3, 'Z')
            app.UIAxes4_3.Toolbar.Visible = 'off';
            app.UIAxes4_3.PlotBoxAspectRatio = [3 1 1];
            app.UIAxes4_3.XGrid = 'on';
            app.UIAxes4_3.YGrid = 'on';
            app.UIAxes4_3.FontSize = 10;
            app.UIAxes4_3.Position = [1014 16 323 150];

            % Create UIAxes5
            app.UIAxes5 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            title(app.UIAxes5, 'Filtro')
            zlabel(app.UIAxes5, 'Z')
            app.UIAxes5.Toolbar.Visible = 'off';
            app.UIAxes5.PlotBoxAspectRatio = [1 1 1];
            app.UIAxes5.XTick = [];
            app.UIAxes5.YTick = [];
            app.UIAxes5.Position = [930 611 106 93];

            % Create UIAxes6
            app.UIAxes6 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            title(app.UIAxes6, 'Fourier (original)')
            zlabel(app.UIAxes6, 'Z')
            app.UIAxes6.Toolbar.Visible = 'off';
            app.UIAxes6.XTick = [];
            app.UIAxes6.YTick = [];
            app.UIAxes6.BoxStyle = 'full';
            app.UIAxes6.Position = [385 16 300 148];

            % Create UIAxes7
            app.UIAxes7 = uiaxes(app.PositroniumdotMATModoindividualUIFigure);
            title(app.UIAxes7, 'Fourier (modificado)')
            zlabel(app.UIAxes7, 'Z')
            app.UIAxes7.Toolbar.Visible = 'off';
            app.UIAxes7.XTick = [];
            app.UIAxes7.YTick = [];
            app.UIAxes7.BoxStyle = 'full';
            app.UIAxes7.Position = [684 16 300 153];

            % Create ButtonGroup_2
            app.ButtonGroup_2 = uibuttongroup(app.PositroniumdotMATModoindividualUIFigure);
            app.ButtonGroup_2.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroup_2SelectionChanged, true);
            app.ButtonGroup_2.Enable = 'off';
            app.ButtonGroup_2.Position = [15 419 159 286];

            % Create ReButton
            app.ReButton = uiradiobutton(app.ButtonGroup_2);
            app.ReButton.Text = 'Re()';
            app.ReButton.Position = [10 103 58 22];
            app.ReButton.Value = true;

            % Create ImButton
            app.ImButton = uiradiobutton(app.ButtonGroup_2);
            app.ImButton.Text = 'Im()';
            app.ImButton.Position = [57 103 43 22];

            % Create AbsButton
            app.AbsButton = uiradiobutton(app.ButtonGroup_2);
            app.AbsButton.Text = 'Abs()';
            app.AbsButton.Position = [103 103 51 22];

            % Create AplicarButton_3
            app.AplicarButton_3 = uibutton(app.ButtonGroup_2, 'push');
            app.AplicarButton_3.ButtonPushedFcn = createCallbackFcn(app, @AplicarButton_3Pushed, true);
            app.AplicarButton_3.Enable = 'off';
            app.AplicarButton_3.Position = [80 4 75 23];
            app.AplicarButton_3.Text = 'Aplicar';

            % Create IntensidadSliderLabel
            app.IntensidadSliderLabel = uilabel(app.ButtonGroup_2);
            app.IntensidadSliderLabel.HorizontalAlignment = 'right';
            app.IntensidadSliderLabel.FontSize = 10;
            app.IntensidadSliderLabel.Position = [11 78 51 22];
            app.IntensidadSliderLabel.Text = 'Intensidad';

            % Create IntensidadSlider
            app.IntensidadSlider = uislider(app.ButtonGroup_2);
            app.IntensidadSlider.Limits = [0.1 1];
            app.IntensidadSlider.MajorTicks = [];
            app.IntensidadSlider.MajorTickLabels = {''};
            app.IntensidadSlider.ValueChangedFcn = createCallbackFcn(app, @IntensidadSliderValueChanged, true);
            app.IntensidadSlider.MinorTicks = [];
            app.IntensidadSlider.Enable = 'off';
            app.IntensidadSlider.FontSize = 10;
            app.IntensidadSlider.Position = [15 77 125 3];
            app.IntensidadSlider.Value = 1;

            % Create Param1EditField_2Label
            app.Param1EditField_2Label = uilabel(app.ButtonGroup_2);
            app.Param1EditField_2Label.HorizontalAlignment = 'right';
            app.Param1EditField_2Label.FontSize = 9;
            app.Param1EditField_2Label.Position = [2 38 37 22];
            app.Param1EditField_2Label.Text = 'Param1';

            % Create Param1EditField_2
            app.Param1EditField_2 = uieditfield(app.ButtonGroup_2, 'numeric');
            app.Param1EditField_2.ValueChangedFcn = createCallbackFcn(app, @Param1EditField_2ValueChanged, true);
            app.Param1EditField_2.FontSize = 10;
            app.Param1EditField_2.Enable = 'off';
            app.Param1EditField_2.Position = [42 38 32 22];

            % Create InvertirCheckBox
            app.InvertirCheckBox = uicheckbox(app.ButtonGroup_2);
            app.InvertirCheckBox.ValueChangedFcn = createCallbackFcn(app, @InvertirCheckBoxValueChanged, true);
            app.InvertirCheckBox.Enable = 'off';
            app.InvertirCheckBox.Text = 'Invertir';
            app.InvertirCheckBox.Position = [10 5 59 22];
            app.InvertirCheckBox.Value = true;

            % Create Param2EditField_2Label
            app.Param2EditField_2Label = uilabel(app.ButtonGroup_2);
            app.Param2EditField_2Label.HorizontalAlignment = 'right';
            app.Param2EditField_2Label.FontSize = 9;
            app.Param2EditField_2Label.Position = [80 38 37 22];
            app.Param2EditField_2Label.Text = 'Param2';

            % Create Param2EditField_2
            app.Param2EditField_2 = uieditfield(app.ButtonGroup_2, 'numeric');
            app.Param2EditField_2.ValueChangedFcn = createCallbackFcn(app, @Param2EditField_2ValueChanged, true);
            app.Param2EditField_2.FontSize = 10;
            app.Param2EditField_2.Enable = 'off';
            app.Param2EditField_2.Position = [119 38 32 22];

            % Create FiltrosDropDownLabel
            app.FiltrosDropDownLabel = uilabel(app.ButtonGroup_2);
            app.FiltrosDropDownLabel.Position = [8 151 95 22];
            app.FiltrosDropDownLabel.Text = 'Filtros';

            % Create FiltrosDropDown
            app.FiltrosDropDown = uidropdown(app.ButtonGroup_2);
            app.FiltrosDropDown.Items = {'Seleccione...', 'Circular', 'Rejilla', 'Rectangular', 'Deshacer'};
            app.FiltrosDropDown.ItemsData = [1 2 3 4 5];
            app.FiltrosDropDown.ValueChangedFcn = createCallbackFcn(app, @FiltrosDropDownValueChanged, true);
            app.FiltrosDropDown.Enable = 'off';
            app.FiltrosDropDown.Position = [8 130 143 22];
            app.FiltrosDropDown.Value = 1;

            % Create TransformadasButtonGroup
            app.TransformadasButtonGroup = uibuttongroup(app.ButtonGroup_2);
            app.TransformadasButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @TransformadasButtonGroupSelectionChanged, true);
            app.TransformadasButtonGroup.Title = 'Transformadas';
            app.TransformadasButtonGroup.Position = [0 235 159 50];

            % Create NormalButton
            app.NormalButton = uiradiobutton(app.TransformadasButtonGroup);
            app.NormalButton.Text = 'Normal';
            app.NormalButton.Position = [11 4 61 22];
            app.NormalButton.Value = true;

            % Create RadnButton
            app.RadnButton = uiradiobutton(app.TransformadasButtonGroup);
            app.RadnButton.Text = 'Radón';
            app.RadnButton.Position = [84 4 65 22];

            % Create thetaLabel
            app.thetaLabel = uilabel(app.ButtonGroup_2);
            app.thetaLabel.Interpreter = 'latex';
            app.thetaLabel.HorizontalAlignment = 'right';
            app.thetaLabel.Position = [-9 192 25 35];
            app.thetaLabel.Text = {'$\theta_i'; '$'};

            % Create theta_iEditField
            app.theta_iEditField = uieditfield(app.ButtonGroup_2, 'numeric');
            app.theta_iEditField.Limits = [0 Inf];
            app.theta_iEditField.RoundFractionalValues = 'on';
            app.theta_iEditField.Enable = 'off';
            app.theta_iEditField.Position = [21 205 30 22];

            % Create theta_sEditFieldLabel
            app.theta_sEditFieldLabel = uilabel(app.ButtonGroup_2);
            app.theta_sEditFieldLabel.Interpreter = 'latex';
            app.theta_sEditFieldLabel.HorizontalAlignment = 'right';
            app.theta_sEditFieldLabel.Position = [42 205 25 22];
            app.theta_sEditFieldLabel.Text = '$\theta_s$';

            % Create theta_sEditField
            app.theta_sEditField = uieditfield(app.ButtonGroup_2, 'numeric');
            app.theta_sEditField.Limits = [0 Inf];
            app.theta_sEditField.Enable = 'off';
            app.theta_sEditField.Position = [72 205 30 22];
            app.theta_sEditField.Value = 1;

            % Create theta_fEditFieldLabel
            app.theta_fEditFieldLabel = uilabel(app.ButtonGroup_2);
            app.theta_fEditFieldLabel.Interpreter = 'latex';
            app.theta_fEditFieldLabel.HorizontalAlignment = 'right';
            app.theta_fEditFieldLabel.Position = [97 192 25 35];
            app.theta_fEditFieldLabel.Text = {'$\theta_f'; '$'};

            % Create theta_fEditField
            app.theta_fEditField = uieditfield(app.ButtonGroup_2, 'numeric');
            app.theta_fEditField.Limits = [0 Inf];
            app.theta_fEditField.RoundFractionalValues = 'on';
            app.theta_fEditField.Enable = 'off';
            app.theta_fEditField.Position = [127 205 30 22];
            app.theta_fEditField.Value = 180;

            % Create iRadnButton
            app.iRadnButton = uibutton(app.ButtonGroup_2, 'push');
            app.iRadnButton.ButtonPushedFcn = createCallbackFcn(app, @iRadnButtonPushed, true);
            app.iRadnButton.Enable = 'off';
            app.iRadnButton.Position = [83 176 71 23];
            app.iRadnButton.Text = 'iRadón';

            % Create UpdateButton
            app.UpdateButton = uibutton(app.ButtonGroup_2, 'push');
            app.UpdateButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.UpdateButton.Enable = 'off';
            app.UpdateButton.Position = [7 176 73 23];
            app.UpdateButton.Text = 'Update';

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.PositroniumdotMATModoindividualUIFigure);
            app.ButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupSelectionChanged, true);
            app.ButtonGroup.Enable = 'off';
            app.ButtonGroup.Position = [15 283 157 129];

            % Create XDirButton
            app.XDirButton = uiradiobutton(app.ButtonGroup);
            app.XDirButton.Text = 'XDir';
            app.XDirButton.Position = [10 61 58 22];
            app.XDirButton.Value = true;

            % Create YDirButton
            app.YDirButton = uiradiobutton(app.ButtonGroup);
            app.YDirButton.Text = 'YDir';
            app.YDirButton.Position = [10 40 65 22];

            % Create MagnitudButton
            app.MagnitudButton = uiradiobutton(app.ButtonGroup);
            app.MagnitudButton.Text = 'Magnitud';
            app.MagnitudButton.Position = [11 19 71 22];

            % Create DireccinButton
            app.DireccinButton = uiradiobutton(app.ButtonGroup);
            app.DireccinButton.Text = 'Dirección';
            app.DireccinButton.Position = [12 -1 72 22];

            % Create outputTextArea
            app.outputTextArea = uitextarea(app.PositroniumdotMATModoindividualUIFigure);
            app.outputTextArea.FontColor = [0 1 0];
            app.outputTextArea.BackgroundColor = [0 0 0];
            app.outputTextArea.Position = [21 16 345 153];

            % Create MostrarhistAcumCheckBox
            app.MostrarhistAcumCheckBox = uicheckbox(app.PositroniumdotMATModoindividualUIFigure);
            app.MostrarhistAcumCheckBox.ValueChangedFcn = createCallbackFcn(app, @MostrarhistAcumCheckBoxValueChanged, true);
            app.MostrarhistAcumCheckBox.Enable = 'off';
            app.MostrarhistAcumCheckBox.Text = 'Mostrar hist/Acum';
            app.MostrarhistAcumCheckBox.Position = [17 199 119 22];
            app.MostrarhistAcumCheckBox.Value = true;

            % Create slidervalue1EditField
            app.slidervalue1EditField = uieditfield(app.PositroniumdotMATModoindividualUIFigure, 'numeric');
            app.slidervalue1EditField.Editable = 'off';
            app.slidervalue1EditField.Position = [396 204 37 22];

            % Create slidervalue2EditField
            app.slidervalue2EditField = uieditfield(app.PositroniumdotMATModoindividualUIFigure, 'numeric');
            app.slidervalue2EditField.Editable = 'off';
            app.slidervalue2EditField.Position = [626 204 37 22];
            app.slidervalue2EditField.Value = 255;

            % Create Button_2
            app.Button_2 = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_right.png');
            app.Button_2.Enable = 'off';
            app.Button_2.Position = [790 180 32 24];
            app.Button_2.Text = '';

            % Create Button
            app.Button = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Icon = fullfile(pathToMLAPP, 'ico', 'arrow_left.png');
            app.Button.Enable = 'off';
            app.Button.Position = [673 180 32 24];
            app.Button.Text = '';

            % Create CorrerButton
            app.CorrerButton = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.CorrerButton.ButtonPushedFcn = createCallbackFcn(app, @CorrerButtonPushed, true);
            app.CorrerButton.Icon = fullfile(pathToMLAPP, 'ico', 'run.png');
            app.CorrerButton.Enable = 'off';
            app.CorrerButton.Position = [709 180 76 25];
            app.CorrerButton.Text = 'Correr';

            % Create EsperandoLabel
            app.EsperandoLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.EsperandoLabel.FontSize = 13;
            app.EsperandoLabel.FontWeight = 'bold';
            app.EsperandoLabel.Position = [27 168 317 22];
            app.EsperandoLabel.Text = 'Esperando...';

            % Create GuadarButton
            app.GuadarButton = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.GuadarButton.ButtonPushedFcn = createCallbackFcn(app, @GuadarButtonPushed, true);
            app.GuadarButton.Icon = fullfile(pathToMLAPP, 'ico', 'save.png');
            app.GuadarButton.Enable = 'off';
            app.GuadarButton.Position = [828 180 75 24];
            app.GuadarButton.Text = 'Guadar';

            % Create AplicarButton
            app.AplicarButton = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.AplicarButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarButtonPushed, true);
            app.AplicarButton.Icon = fullfile(pathToMLAPP, 'ico', 'aplicar.png');
            app.AplicarButton.Visible = 'off';
            app.AplicarButton.Position = [709 180 76 25];
            app.AplicarButton.Text = 'Aplicar';

            % Create CerrarButton
            app.CerrarButton = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.CerrarButton.ButtonPushedFcn = createCallbackFcn(app, @CerrarButtonPushed, true);
            app.CerrarButton.Icon = fullfile(pathToMLAPP, 'ico', 'icon_close.png');
            app.CerrarButton.Position = [907 180 77 24];
            app.CerrarButton.Text = 'Cerrar';

            % Create PginaTIFFDropDownLabel
            app.PginaTIFFDropDownLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.PginaTIFFDropDownLabel.HorizontalAlignment = 'right';
            app.PginaTIFFDropDownLabel.Position = [823 211 71 22];
            app.PginaTIFFDropDownLabel.Text = 'Página TIFF';

            % Create PginaTIFFDropDown
            app.PginaTIFFDropDown = uidropdown(app.PositroniumdotMATModoindividualUIFigure);
            app.PginaTIFFDropDown.Items = {'Imag 1', 'Imag 2'};
            app.PginaTIFFDropDown.ValueChangedFcn = createCallbackFcn(app, @PginaTIFFDropDownValueChanged, true);
            app.PginaTIFFDropDown.Enable = 'off';
            app.PginaTIFFDropDown.Position = [904 211 78 22];
            app.PginaTIFFDropDown.Value = 'Imag 1';

            % Create ColorDropDownLabel
            app.ColorDropDownLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.ColorDropDownLabel.HorizontalAlignment = 'right';
            app.ColorDropDownLabel.Position = [685 211 34 22];
            app.ColorDropDownLabel.Text = 'Color';

            % Create ColorDropDown
            app.ColorDropDown = uidropdown(app.PositroniumdotMATModoindividualUIFigure);
            app.ColorDropDown.Items = {'RGB', 'Rojo', 'Verde', 'Azul', 'E. grises'};
            app.ColorDropDown.ItemsData = [0 1 2 3 4];
            app.ColorDropDown.ValueChangedFcn = createCallbackFcn(app, @ColorDropDownValueChanged, true);
            app.ColorDropDown.Enable = 'off';
            app.ColorDropDown.Position = [734 211 81 22];
            app.ColorDropDown.Value = 0;

            % Create BrilloSliderLabel
            app.BrilloSliderLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.BrilloSliderLabel.HorizontalAlignment = 'right';
            app.BrilloSliderLabel.FontSize = 10;
            app.BrilloSliderLabel.Position = [191 319 27 22];
            app.BrilloSliderLabel.Text = 'Brillo';

            % Create BrilloSlider
            app.BrilloSlider = uislider(app.PositroniumdotMATModoindividualUIFigure);
            app.BrilloSlider.Limits = [-100 100];
            app.BrilloSlider.ValueChangedFcn = createCallbackFcn(app, @BrilloSliderValueChanged, true);
            app.BrilloSlider.Enable = 'off';
            app.BrilloSlider.FontSize = 10;
            app.BrilloSlider.Position = [191 317 162 3];

            % Create ContrasteSliderLabel
            app.ContrasteSliderLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.ContrasteSliderLabel.HorizontalAlignment = 'right';
            app.ContrasteSliderLabel.FontSize = 10;
            app.ContrasteSliderLabel.Position = [183 376 48 22];
            app.ContrasteSliderLabel.Text = 'Contraste';

            % Create ContrasteSlider
            app.ContrasteSlider = uislider(app.PositroniumdotMATModoindividualUIFigure);
            app.ContrasteSlider.Limits = [-90 100];
            app.ContrasteSlider.ValueChangedFcn = createCallbackFcn(app, @ContrasteSliderValueChanged, true);
            app.ContrasteSlider.Enable = 'off';
            app.ContrasteSlider.FontSize = 10;
            app.ContrasteSlider.Position = [191 373 161 3];

            % Create GammaSliderLabel
            app.GammaSliderLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.GammaSliderLabel.HorizontalAlignment = 'right';
            app.GammaSliderLabel.FontSize = 10;
            app.GammaSliderLabel.Position = [183 437 41 22];
            app.GammaSliderLabel.Text = 'Gamma';

            % Create GammaSlider
            app.GammaSlider = uislider(app.PositroniumdotMATModoindividualUIFigure);
            app.GammaSlider.Limits = [0.1 2];
            app.GammaSlider.MajorTicks = [0.1 1 2];
            app.GammaSlider.ValueChangedFcn = createCallbackFcn(app, @GammaSliderValueChanged, true);
            app.GammaSlider.Enable = 'off';
            app.GammaSlider.FontSize = 10;
            app.GammaSlider.Position = [189 435 172 3];
            app.GammaSlider.Value = 1;

            % Create RealceymejoramientoLabel
            app.RealceymejoramientoLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.RealceymejoramientoLabel.Position = [181 458 128 22];
            app.RealceymejoramientoLabel.Text = 'Realce y mejoramiento';

            % Create EcualizacinDropDownLabel
            app.EcualizacinDropDownLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.EcualizacinDropDownLabel.HorizontalAlignment = 'right';
            app.EcualizacinDropDownLabel.Position = [28 252 72 22];
            app.EcualizacinDropDownLabel.Text = 'Ecualización';

            % Create EcualizacinDropDown
            app.EcualizacinDropDown = uidropdown(app.PositroniumdotMATModoindividualUIFigure);
            app.EcualizacinDropDown.Items = {'Seleccione...', 'Histograma acumulativo', 'Ajuste adaptativo', 'Deshacer'};
            app.EcualizacinDropDown.ItemsData = [1 2 3 4];
            app.EcualizacinDropDown.ValueChangedFcn = createCallbackFcn(app, @EcualizacinDropDownValueChanged, true);
            app.EcualizacinDropDown.Enable = 'off';
            app.EcualizacinDropDown.Position = [27 231 140 22];
            app.EcualizacinDropDown.Value = 1;

            % Create ComplementosDropDownLabel
            app.ComplementosDropDownLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.ComplementosDropDownLabel.HorizontalAlignment = 'right';
            app.ComplementosDropDownLabel.Position = [192 252 86 22];
            app.ComplementosDropDownLabel.Text = 'Complementos';

            % Create ComplementosDropDown
            app.ComplementosDropDown = uidropdown(app.PositroniumdotMATModoindividualUIFigure);
            app.ComplementosDropDown.Items = {'Seleccione...', 'Complemento', 'Complemento - Original', 'Original - Complemento', 'Deshacer'};
            app.ComplementosDropDown.ItemsData = [1 2 3 4 5];
            app.ComplementosDropDown.ValueChangedFcn = createCallbackFcn(app, @ComplementosDropDownValueChanged, true);
            app.ComplementosDropDown.Enable = 'off';
            app.ComplementosDropDown.Position = [194 231 140 22];
            app.ComplementosDropDown.Value = 1;

            % Create CoordsxyLabel
            app.CoordsxyLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.CoordsxyLabel.Position = [139 199 131 22];
            app.CoordsxyLabel.Text = 'Coords. (x,y)';

            % Create FiltroslinealesynolinealesDropDownLabel
            app.FiltroslinealesynolinealesDropDownLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.FiltroslinealesynolinealesDropDownLabel.HorizontalAlignment = 'right';
            app.FiltroslinealesynolinealesDropDownLabel.Position = [188 592 152 22];
            app.FiltroslinealesynolinealesDropDownLabel.Text = 'Filtros lineales y no lineales';

            % Create FiltroslinealesynolinealesDropDown
            app.FiltroslinealesynolinealesDropDown = uidropdown(app.PositroniumdotMATModoindividualUIFigure);
            app.FiltroslinealesynolinealesDropDown.Items = {'No filtro', 'Option 2', 'Option 3', 'Option 4'};
            app.FiltroslinealesynolinealesDropDown.ItemsData = [1 2 3 4 5 6 7 8 9 10 11 12];
            app.FiltroslinealesynolinealesDropDown.ValueChangedFcn = createCallbackFcn(app, @FiltroslinealesynolinealesDropDownValueChanged, true);
            app.FiltroslinealesynolinealesDropDown.Position = [194 571 161 22];
            app.FiltroslinealesynolinealesDropDown.Value = 1;

            % Create ParamsfiltrosLabel
            app.ParamsfiltrosLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.ParamsfiltrosLabel.Position = [191 543 82 22];
            app.ParamsfiltrosLabel.Text = 'Params. filtros';

            % Create AplicarfiltroButton
            app.AplicarfiltroButton = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.AplicarfiltroButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarfiltroButtonPushed, true);
            app.AplicarfiltroButton.Enable = 'off';
            app.AplicarfiltroButton.Position = [267 488 100 23];
            app.AplicarfiltroButton.Text = 'Aplicar filtro';

            % Create Param1EditFieldLabel
            app.Param1EditFieldLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.Param1EditFieldLabel.HorizontalAlignment = 'right';
            app.Param1EditFieldLabel.Position = [194 521 47 22];
            app.Param1EditFieldLabel.Text = 'Param1';

            % Create Param1EditField
            app.Param1EditField = uieditfield(app.PositroniumdotMATModoindividualUIFigure, 'numeric');
            app.Param1EditField.ValueChangedFcn = createCallbackFcn(app, @Param1EditFieldValueChanged, true);
            app.Param1EditField.Enable = 'off';
            app.Param1EditField.Position = [248 521 30 22];

            % Create Param2EditFieldLabel
            app.Param2EditFieldLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.Param2EditFieldLabel.HorizontalAlignment = 'right';
            app.Param2EditFieldLabel.Position = [283 521 47 22];
            app.Param2EditFieldLabel.Text = 'Param2';

            % Create Param2EditField
            app.Param2EditField = uieditfield(app.PositroniumdotMATModoindividualUIFigure, 'numeric');
            app.Param2EditField.ValueChangedFcn = createCallbackFcn(app, @Param2EditFieldValueChanged, true);
            app.Param2EditField.Enable = 'off';
            app.Param2EditField.Position = [336 521 31 22];

            % Create TransponerCheckBox
            app.TransponerCheckBox = uicheckbox(app.PositroniumdotMATModoindividualUIFigure);
            app.TransponerCheckBox.ValueChangedFcn = createCallbackFcn(app, @TransponerCheckBoxValueChanged, true);
            app.TransponerCheckBox.Enable = 'off';
            app.TransponerCheckBox.Text = 'Transponer';
            app.TransponerCheckBox.Position = [184 489 83 22];

            % Create GradienteDropDownLabel
            app.GradienteDropDownLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.GradienteDropDownLabel.HorizontalAlignment = 'right';
            app.GradienteDropDownLabel.Position = [22 390 58 22];
            app.GradienteDropDownLabel.Text = 'Gradiente';

            % Create GradienteDropDown
            app.GradienteDropDown = uidropdown(app.PositroniumdotMATModoindividualUIFigure);
            app.GradienteDropDown.Items = {'Seleccione...'};
            app.GradienteDropDown.ItemsData = [1 2 3 4 5 6];
            app.GradienteDropDown.ValueChangedFcn = createCallbackFcn(app, @GradienteDropDownValueChanged, true);
            app.GradienteDropDown.Enable = 'off';
            app.GradienteDropDown.Position = [23 370 143 22];
            app.GradienteDropDown.Value = 1;

            % Create SegmentacinporhistogramaLabel
            app.SegmentacinporhistogramaLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.SegmentacinporhistogramaLabel.Position = [180 679 165 22];
            app.SegmentacinporhistogramaLabel.Text = 'Segmentación por histograma';

            % Create AplicarSegButton
            app.AplicarSegButton = uibutton(app.PositroniumdotMATModoindividualUIFigure, 'push');
            app.AplicarSegButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarSegButtonPushed, true);
            app.AplicarSegButton.Enable = 'off';
            app.AplicarSegButton.Position = [267 620 99 23];
            app.AplicarSegButton.Text = 'Aplicar Seg.';

            % Create MnimoEditFieldLabel
            app.MnimoEditFieldLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.MnimoEditFieldLabel.HorizontalAlignment = 'right';
            app.MnimoEditFieldLabel.Position = [180 654 44 22];
            app.MnimoEditFieldLabel.Text = 'Mínimo';

            % Create MnimoEditField
            app.MnimoEditField = uieditfield(app.PositroniumdotMATModoindividualUIFigure, 'numeric');
            app.MnimoEditField.ValueChangedFcn = createCallbackFcn(app, @MnimoEditFieldValueChanged, true);
            app.MnimoEditField.Enable = 'off';
            app.MnimoEditField.Position = [231 654 34 22];
            app.MnimoEditField.Value = 100;

            % Create MximoEditFieldLabel
            app.MximoEditFieldLabel = uilabel(app.PositroniumdotMATModoindividualUIFigure);
            app.MximoEditFieldLabel.HorizontalAlignment = 'right';
            app.MximoEditFieldLabel.Position = [283 654 47 22];
            app.MximoEditFieldLabel.Text = 'Máximo';

            % Create MximoEditField
            app.MximoEditField = uieditfield(app.PositroniumdotMATModoindividualUIFigure, 'numeric');
            app.MximoEditField.ValueChangedFcn = createCallbackFcn(app, @MximoEditFieldValueChanged, true);
            app.MximoEditField.Enable = 'off';
            app.MximoEditField.Position = [337 654 34 22];
            app.MximoEditField.Value = 150;

            % Create InvertirCheckBox_2
            app.InvertirCheckBox_2 = uicheckbox(app.PositroniumdotMATModoindividualUIFigure);
            app.InvertirCheckBox_2.ValueChangedFcn = createCallbackFcn(app, @InvertirCheckBox_2ValueChanged, true);
            app.InvertirCheckBox_2.Enable = 'off';
            app.InvertirCheckBox_2.Text = 'Invertir';
            app.InvertirCheckBox_2.Position = [182 621 59 22];

            % Create RestaurarimagenCheckBox
            app.RestaurarimagenCheckBox = uicheckbox(app.PositroniumdotMATModoindividualUIFigure);
            app.RestaurarimagenCheckBox.Text = 'Restaurar imagen';
            app.RestaurarimagenCheckBox.Position = [241 198 117 22];

            % Show the figure after all components are created
            app.PositroniumdotMATModoindividualUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main1

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.PositroniumdotMATModoindividualUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.PositroniumdotMATModoindividualUIFigure)
        end
    end
end