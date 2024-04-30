function [dir_name,perfil] = vector_perfiles(directorio_dicom)
    dicom = read_dicom_folders(directorio_dicom);
    % definomos la localización de las imágenes CT y la modalidad
    carpeta = 'SE000001';
    modalidad = '*CT*';
    for i =  1:length(fieldnames(dicom))
        [~,dir_name.("estudio_" + num2str(i)),~] = fileparts(fullfile(dicom.("estudio_" + num2str(i))));
        lista.("estudio_" + num2str(i)) = dir(fullfile(dicom.("estudio_" + num2str(i)),carpeta,modalidad));
        lista.("estudio_" + num2str(i)) = [char({lista.("estudio_" + num2str(i)).name})];
        tam = size(lista.("estudio_" + num2str(i)));
        cortes.("estudio_" + num2str(i)) = tam(1);
        %info.("estudio_" + num2str(i)) = dicominfo(fullfile(dicom.("estudio_" + num2str(i)),carpeta,lista.("estudio_" + num2str(i))(1,:)));
        perfil.("estudio_" + num2str(i)) = zeros(cortes.("estudio_" + num2str(i)),1,'double');
        for n = 1:tam(1)
            info_corte.("estudio_" + num2str(i)) = dicominfo(fullfile(dicom.("estudio_" + num2str(i)),carpeta,lista.("estudio_" + num2str(i))(n,:)));
            %segmentamos; eliminamos valores por encima de 1000
            img = double(dicomread(info_corte.("estudio_" + num2str(i))));
            mask = zeros(size(img),'double');
            cal_fac = 105;
            mask(img>-cal_fac-info_corte.("estudio_" + num2str(i)).RescaleIntercept &img<cal_fac-info_corte.("estudio_" + num2str(i)).RescaleIntercept) = 1;
            img = img.*mask;
            perfil.("estudio_" + num2str(i))(n) = mean(mean(img));
        end
    end 
end

