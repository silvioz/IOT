%*******************  EE556 - Mathematics of Data  ************************
% Function:  [x, err, time, iter] = PR(E, x0, maxit, tol)       
% Purpose:   Implementation of the PageRank algorithm.     
% Inputs:    E     - Transition matrix.
%            x0    - initial state vector (initial estimate).
%            maxit - Maximum number of iterations.
%            tol   - Error toleration for stopping condition.
% Outputs:   x     - Rank vector (eigenvector that corresponds to 1).
%            err   - Vector containing error ||Mx-x|| at each iteration.
%            time  - Elapsed time at each iteration (not cumulative).
%            iter  - Number of iterations needed to reach tol.
%*************************** LIONS@EPFL ***********************************
function [ x, err, time, iter ] = PR( E, x0, maxit, tol )

    fprintf('%s\n', repmat('*', 1, 68));
     
    % Set initial estimate.
    x           = x0;
    p=0.15;
    
    for iter    = 1:maxit
        
        % Start the clock.
        tic;

        % Update the next iteration
		x_next = multByM( E, x, p );
		        
        % Check stopping criterion.
        rerr = norm(x_next - x);
        if rerr <= tol 
            break;
        end
        
        % Compute error and save data to be plotted later on.
        time(iter ,1)      = toc;
        err(iter,1)        = rerr;
        
        % Print the information.
        fprintf('Iter = %4d,  ||Mx - x|| = %5.3e, time = %3.3e \n', ...
        iter,  rerr, sum(time));

        % Prepare the next iterate
        x           = x_next;
        
    end

end

