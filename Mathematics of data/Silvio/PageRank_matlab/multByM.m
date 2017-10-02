%*******************  EE556 - Mathematics of Data  ************************
%*************************** LIONS@EPFL ***********************************
function [ Mx ] = multByM( E, x, p )
%MULTBYM Efficient vector multiplication with PageRank matrix M
%   The function evaluates the matrix vector computation in an efficient 
% 	way, for the PageRank matrix M, generated by using transition matrix E
% 	and the damping factor p.

n   = size(E,1);
if length(x) ~= n 
    error('Dimensions of the inouts E and x does not match!'); 
end
if nargin < 3
    if nargin < 2
        error('There should be at least 2 inputs!')
    end
    p = 0.15; % default value
end
z   = (sum(E,1) == 0)';
Mx  = (1-p)*(E*x) + ones(n,1)*( ( (1-p)*(z'*x) + p*sum(x,1) )/n );

end
%**************************************************************************
% END OF THE IMPLEMENTATION.
%**************************************************************************