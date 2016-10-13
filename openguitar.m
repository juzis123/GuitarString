function [structu] = openguitar(filename)
	% Opens guitar settings file and returns a corresponding struct
	% Input: filename of file to be read
    if exist(fullfile(cd, filename),'file') ~= 2 		% If the given argument is not a file
        error([filename ' does not exist']); 			% Give an error
    else
        structu = table2struct(readtable(filename));	% read the file
    end
end
