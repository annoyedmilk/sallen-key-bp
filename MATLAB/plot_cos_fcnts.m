function plot_cos_fcnts(cplxvecs,colors,scale,vline,freq,periodes)
% 
% PLOT_COS_FCNTS plots for example voltage- or current-cosnine-funntions in 
% time-amplitude graph for each complex vector given by the input 
% argument cplxvecs. 
% 
%USAGE
%---------------------------------
% plot_vec_diag(vectors,colors,scale,vline)
% plot_vec_diag(vectors,colors,scale,vline,origin)
% 
% 
%INPUT
%--------------------------------
% - VECTORS:   x-, y-coordinates in nx2 or x-, y-, z-coordinates in 
%              nx3 matrices 
%              (n relates to the number of vectors to be shown) 
% - COLORS:    nx1 matrix of vector-colors
%              valid colors are:
%               'b': blue 
%               'r': red 
%               'g': green 
%               'c': cyan 
%               'm': magenta 
%               'y': yellow 
%               'k': black
% - SCALE:     nx1 matrix of length scale-factor für vector realtet 
%              to row n     
% - VLINE:     nx1 matrix of line-width for vector related to row n
% - ORIGINE:   x-, y-coordinates in nx2 or x-, y-, z-coordinates in 
%              nx3 matrices of the origine for vector. If origin is not
%              set, vector starts at [0].
% 
% 
%OUTPUT
%------
% Figure with the vectors from VECTORS starting at the origin from ORIGIN  
% wiht Colors from COLOR and line-width from VLINE. Each vector can bei  
% scaledd by SCALE.
%  
% See also COMPASS, QUIVER, QUIVER3, PLOT3
% Peter Jost, Juventus Technikerschule HF (peter.jost@juventus.schule)
% 2019-Dec-18, 6:00pm
% 

% Check Input
%==========================================================================
inputargs = true;
if size(cplxvecs,1) ~= size(colors,1) && inputargs
    fprintf('"colors" und "cplxvecs" must have the same size of rows \n')
    inputargs = false;
end
if size(cplxvecs,1) ~= size(scale, 1) && inputargs
    fprintf('"scale" und "cplxvecs" must have the same size of rows \n')
    inputargs = false;
end
if size(cplxvecs,1) ~= size(vline, 1) && inputargs
    fprintf('"vline" und "cplxvecs" must have the same size of rows \n')
    inputargs = false;
end
% Plot figure
%==========================================================================
if inputargs == true
    Sample = freq * 1000;
    dt = 1/Sample;
    StopTime = periodes * (1/freq);
    t = [0:dt:StopTime-dt];
    figure
    hold on
    title('Zeitfunktionen von Strömen und Spannungen')
    for cosvec = 1:length(cplxvecs)
        plot_vec = scale(cosvec)*abs(cplxvecs(cosvec))*...
            cos(2*pi*freq*t + angle(cplxvecs(cosvec)));
        plot(t,plot_vec,"Color",colors(cosvec),"LineWidth",vline(cosvec));
    end
    %----------------------------------------------------------------------
    % Axis Labels
    %----------------------------------------------------------------------
    xlabel('Zeit')
    ylabel('Amplitude')
    grid on
    hold off
end

