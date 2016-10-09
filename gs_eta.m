function ETAstr = gs_ETA(n,N,starttime,output_type,console_text,skipframes)
	% Calculate linearly Estimated Time for Arrival
	% Input:
	% n: 			Value for current progress
	% N: 			Value for progress = 100%
	% starttime: 	MatLab time value of process start time, use: starttime=now; before loop
	% output_type: 	string to indicate output type, should be either 'console' or 'string'
	% console_text: string to display above ETA in console
	% skipframes: 	number of frames/iterations to skip, to reduce console output time
    
    if strcmp(output_type,'console')            % If output will be sent to console
        if n==N                                 % If at 100%, give output
            doit = 1;
        else
            doit = mod(n,skipframes+1) == 0;    % Give output every <skipframes+1> iteration
        end
    elseif strcmp(output_type,'string')         % Always give output if a string is requested
        doit = true;
    end
    
    if doit
        % Show Estimated Time for Arrival in console
        perc = n/N*100;                         % Percentage done
        ETA = (now-starttime)*(N/(n-1) - 1);    % ETA in days [why Matlab? (-_-) ]
        ETA_min = floor(ETA*1440);              % minutes of ETA
        ETA_sec = mod(floor(ETA*86400),60);     % seconds of ETA
        
        ETAstr = sprintf('%.0f%% - ETA: %i min %.0f sec\n',perc,ETA_min,ETA_sec); % Format ETA string
        
        if strcmp(output_type,'console')        % If output form is console
            clc                                 % Clear console
            disp(console_text)                  % Show <console_text> in console
            disp(ETAstr)                        % Show the ETA string in console
        end
    end
end
