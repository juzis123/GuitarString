% Judith Zissoldt (s1332171) and Daniel Cox (s1228579)
function [file] = writeguitar(settings)
	% Write a guitar string simulation settings file
	% Input: the settings struct, containing one or more
	% of the following properties: M, k, n, p, Ltot, L0, dt, steps, vy0
	savedir = uigetdir;
	writetable(struct2table(settings), fullfile(savedir,'guitarsettings.txt'));
end
