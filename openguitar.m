% gets
function [structu] = openguitar (filename)
cd = 'C:\Users\Judith\Documents\MATLAB\GuitarString';
    if exist(fullfile(cd, filename),'file') ~= 2 
        disp([filename ' does not exist']); 
    else
        structu = table2struct(readtable(filename));     
    end
end
