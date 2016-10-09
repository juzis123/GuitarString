function overtones = overtone_peaks(samples)
	% Function that isolates overtones
	% and returns a list of overtone sizes
	% A signal with well defined overtones is assumed!
	% Input: array with samples
	% Output: array with overtone sizes

	% Isolate peaks in frequency spectrum
	fullfreqspec = abs(fft(samples));			    % Calculate frequency spectrum (amplitude)
	nff = round(length(fullfreqspec)/2);			% Get length of full freq spec array
	freqspec = fullfreqspec(1:nff);	                % Chop off mirrored half of the frequency spectrum
	nf = length(freqspec);			                % Get frequency spectrum array length
	[freqsort,ifs] = sort(freqspec);	            % Get sorted list of amplitudes
	pks = zeros(1,nf);	                            % Initialize peak indication array
	pks(freqspec>mean(freqsort(nf*0.995:nf))) = 1;	% its a peak, if > average of highest 0.5%

	% Retrieve peak starts and ends
	dpks = pks(2:end) - pks(1:end-1);		        % Peak indication difference array; 1 @ start, -1 @ end, else 0
	ipk = 1:nf;				                        % Create index array
	pkstarts = ipk(dpks==1);                        % List peak starts
	pkends = ipk(dpks==-1);                         % List peak ends

	% Check if peaks are really found
	if length(pkstarts)<2 && length(pkends)<2
		error('Less than two peaks found!')
	elseif(pkstarts(1)>pkends(1))
		error('First peak not well defined! Can''t find start.')
	end

	% Create array of overtone sizes
	npeaks = min(length(pkstarts),length(pkends));	% Determine number of overtones
	overtones = zeros(1,npeaks);	                % Initialize overtone array
	for p = 1:npeaks	                            % Loop over overtones
		overtones(p) = sum(freqspec(pkstarts(p):pkends(p)));	% Sum over peak area
	end

return;
