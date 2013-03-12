function varargout = plot(f,varargin)
%PLOT   Basic linear plot for BNDFUN objects. 
%   PLOT(F) plots the BNDFUN object F.
%
%   PLOT(F, S) allows various line types, plot symbols, and colors to be
%   used when S is a character string made from one element from any or all
%   the following 3 columns:
%  
%            b     blue          .     point              -     solid
%            g     green         o     circle             :     dotted
%            r     red           x     x-mark             -.    dashdot 
%            c     cyan          +     plus               --    dashed   
%            m     magenta       *     star             (none)  no line
%            y     yellow        s     square
%            k     black         d     diamond
%            w     white         v     triangle (down)
%                                ^     triangle (up)
%                                <     triangle (left)
%                                >     triangle (right)
%                                p     pentagram
%                                h     hexagram
%   The entries from the centre columns are plotted at the Chebyshev grid
%   being used to represent F. If no options from this column are chosen,
%   'o' is chosen by default if length(f)<256;
%
%   The X,Y pairs, or X,Y,S triples, can be followed by parameter/value
%   pairs to specify additional properties of the lines. For example,
%            F = funcheb.constructor(@sin);
%            plot(F, 'LineWidth', 2, 'Color', [.6 0 0]) 
%   will create a plot with a dark red line width of 2 points.
%
%   H1 = PLOT(F) returns a column vector of handles to lineseries objects,
%   one handle per plotted line (in the case of vector-valued BNDFUN
%   objects). [H1, H2] returns a second vector of column handles, this time
%   for each of the marker plots.

% Deal with an empty input:
if ( isempty(f) )
    if ( nargout == 1 )
        varargout{1} = plot([]);
    end
    return
end

% Store the hold state of the current axis:
holdState = ishold;

%%
% Plot the curve, evaluating at an equispaced grid
xx = linspace(f.domain(1), f.domain(2), 2001).';
ff = feval(f, xx);
if ( isreal(ff) )
    h1 = plot(xx, ff, varargin{:}); 
else
    h1 = plot(ff, varargin{:}); 
end
set(h1, 'Marker', 'none') 
hold on

%%

% Plot the points:
xk = get(f, 'points');
fk = get(f, 'values');
if ( isreal(ff) )
    h2 = plot(xk, fk, varargin{:});
else
    h2 = plot(fk, varargin{:});
end

% Change the style accordingly:
set(h2,'LineStyle', 'none')
if ( all(strcmp(get(h2, 'Marker'),'none')) ) && length(f) < 257
    set(h2,'Marker', 'o')
end

%%
% Return hold state to what it was before:
if ( ~holdState )
    hold off
end

% Give an output if one was requested:
if ( nargout > 0 )
    varargout{1} = h1;
    varargout{2} = h2;
end

end

