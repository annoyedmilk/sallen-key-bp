function plot_vec_diag(vectors,colors,scale,vline,diagtitle,origin)
% 
% PLOT_VEC_DIAG plots for example voltage- or current-vectors in a 
% real-complex graph.it starts a the coordinates given by the input 
% argument origin. 
% 
%USAGE
%---------------------------------
% plot_vec_diag(vectors,colors,scale,vline,diagtitle)
% plot_vec_diag(vectors,colors,scale,vline,diagtitle,[origine])
% 
% 
%INPUT
%--------------------------------
% - VECTORS:   x-, y-coordinates in nx2 or x-, y-, z-coordinates in 
%              nx3 matrices 
%              (n relates to the number of vectors to be shown) 
% - ORIGINE:   x-, y-coordinates in nx2 or x-, y-, z-coordinates in 
%              nx3 matrices of the origine for vector. If origin is not
%              set, vector starts at [0].
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
% - DIAGTITLE: Title of the diagramm
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
if nargin < 6
    origin = zeros(size(vectors,1),size(vectors,2));
end
if size(vectors,2) ~= 2 && size(vectors,2) ~=3 && inputargs
    fprintf('Vectors must be nx2 or nx3 matrices.\n')
    inputargs = false;
end
if size(vectors,1) ~= size(colors,1) && inputargs
    fprintf('"colors" und "vectors" must have the same size of rows \n')
    inputargs = false;
end
if size(vectors,1) ~= size(scale, 1) && inputargs
    fprintf('"scale" und "vectors" must have the same size of rows \n')
    inputargs = false;
end
if size(vectors,1) ~= size(origin, 1) && inputargs
    fprintf('"origin" und "vectors" must have the same size of rows \n')
    inputargs = false;
end
if size(vectors,1) ~= size(vline, 1) && inputargs
    fprintf('"vline" und "vectors" must have the same size of rows \n')
    inputargs = false;
end
% Plot figure
%==========================================================================
if inputargs == true
    figure
    hold on
    if length(diagtitle) > 0
        title(diagtitle);
    elseif title('Diagramm') 
    end
    for vec=1:size(vectors,1)
        if size(vectors,2) == 2
            quiver(origin(vec,1),origin(vec,2),...
                vectors(vec,1),vectors(vec,2),...
                scale(vec),...
                'Color', colors(vec), 'LineWidth',vline(vec))
        elseif size(vectors,2) == 3
            quiver(origin(vec,1),origin(vec,2),origin(vec,3),...
                vectors(vec,1),vectors(vec,2),vectors(vec,2),...
                scale(vec),...
                'Color', colors(vec), 'LineWidth',vline(vec))
        end
    end
    %----------------------------------------------------------------------
    % Axis Labels
    %----------------------------------------------------------------------
    xlabel('Real-Achse')
    ylabel('Imaginär-Achse')
    zlabel('Vz')
    grid on
    hold off
end

