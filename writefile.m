function [file] = writefile (settings)

writetable(struct2table(settings), 'guitarsettings.txt');
file = 'guitarsettings';
savedir = 'C:\Users\Judith\Documents\MATLAB\GuitarString';
movefile('C:\Users\Judith\Documents\MATLAB\guitarsettings.txt', savedir);
    return;
end