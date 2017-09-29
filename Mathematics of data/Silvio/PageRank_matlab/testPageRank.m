%**************************************************************************
%*************************** LIONS@EPFL ***********************************
%**************************************************************************
addpath('dataset');
datasetname = 'hollins.dat';  % load data.
datasetname = ['dataset/', datasetname];

% A  = list2matrix(datasetname);   % A is adjacency matrix
[~, A] = loaddat(datasetname,1);   % A is adjacency matrix
E = A./repmat(sum(A,1),size(A,1),1); % note that all zero columns will be nan
E(isnan(E)) = 0;                 % set back replace all zero columns 

n  = size(A,1);                  % n is number of nodes

fprintf(strcat('Numerical solution process is started: \n'));
% x0                = abs(randn(n,1));  
% while any(x0==0), x0 = abs(randn(n,1)); end %% initial state vector have all postive entries
% x0                = x0/norm(x0,1);    % initial state vector entries sum up to 1
x0                = 1/n*ones(n,1);    % we set x0 deterministically for easy check!
tol               = 1e-10;            % You can vary tol and maxit     
maxit             = 1e5;              % to achieve the convergence. 

% Solve numerically with PageRank algorithm (Power method).
[xPR, err, time, iter]   = PR( E, x0, maxit, tol );

fprintf(strcat('Numerical solution process is completed. \n'));

% Plot the figure
figure;
subplot(1,2,1);
semilogy(err,'LineWidth',1);
xlabel('# iterations','FontSize',16);
ylabel('Error: ||Mx - x||','FontSize',16);
subplot(1,2,2);
semilogy(cumsum(time)*1e3,err,'LineWidth',1);
xlabel('time (ms)','FontSize',16);
ylabel('Error: ||Mx - x||','FontSize',16);


%*******************************%
%  EPFL STI IEL LIONS           %
%  1015 LAUSANNE                %
%*******************************%
