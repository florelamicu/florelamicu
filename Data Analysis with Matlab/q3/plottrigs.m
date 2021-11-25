% Write your code here

function plottrigs(st,varargin)
th = (-2*pi):0.1:(2*pi);
if isempty(varargin{1})
    C = [0,0,0];
else 
    C = varargin{1};
end
if isempty(varargin{2})
    W = 1;
else 
    W = varargin{2};
end
if isempty(varargin{3})
    M = '.';
else 
    M = varargin{3};
end


if st == "sin"
    plot(sin(th),'Color',C,"Linewidth",W,'Marker',M)
elseif st=="cos"
    plot(cos(th),'Color',C,"Linewidth",W,'Marker',M)   
end
end