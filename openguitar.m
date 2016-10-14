% Judith Zissoldt (s1332171) and Daniel Cox (s1228579)
function [structu] = openguitar(filename)
	% Opens guitar settings file and returns a corresponding struct
    uiopen(filename)
	% Input: filename of file to be read
    if exist(fullfile(filename),'file') ~= 2 		% If the given argument is not a file
        error([filename ' does not exist']); 			% Give an error
    else
        structu = table2struct(readtable(filename));	% read the file
    end
end
