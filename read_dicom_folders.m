% dada un directorio, devuelve un valor binario si el directorio contiene carpetas válidas
% se crea la función
function dir_validos = read_dicom_folders(dicom_dir)
    % leemos el número de carpetas que contiene el directorio
    dir_properities = dir(dicom_dir);
    % eliminamos las carpetas que no son válidas
    dir_properities = dir_properities(~ismember({dir_properities.name},{'.','..'}));
    dir_validos = [];
    n = 1;
    for i = 1:length(dir_properities)
        % si la carpeta contiene archivos dicom, entonces es válida
        % CT folder: SE000001
        % PET folder: SE000003
        if not(isempty(dir(fullfile(dicom_dir,dir_properities(i).name,'*SE*'))))
            ct_dir = fullfile(dicom_dir,dir_properities(i).name,'SE000001','*CT*');
            pt_dir = fullfile(dicom_dir,dir_properities(i).name,'SE000003','*PT*');
            if not(isempty(dir(ct_dir)) || isempty(dir(pt_dir)))
                if length(dir(ct_dir)) == length(dir(pt_dir))
                    dir_validos.("estudio_" + num2str(i)) = fullfile(dicom_dir, dir_properities(i).name);
                    n = n + 1;
                end
            end
        end
    end 
end