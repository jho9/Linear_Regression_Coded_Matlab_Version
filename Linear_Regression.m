clc
clear

%{
James Ho
Computer Based Modeling
July 21st 2017

Final Project 

Making a OLS model that predicts variables.

%}

%Condition for the generated variables:
x1 = ones(1,50); 
x2 = 1:50;
x3 = randn(1,50) * 2 + 3;
e = randn(1,50)*sqrt(.04);

b1 = 5;
b2 = 1;
b3 = 0.1;

X = [x1; x2; x3];
X = X';
beta = [b1; b2; b3];
e = e';
%The function for y that gets the generated values
Y = X*beta + e;

%------------------------------------------

%test beta calculation function located on seperate file:
%{
function f = get_betas(X,Y)
    f = inv(X'* X)*(X)'* Y;
end
%}

test_beta = get_betas(X,Y);

%error calculation function
%{
function E = get_errors(Y, Y_test)
    E = Y - Y_test;
end
%}

%Getting tested Y values given test beta:
Y_test = X * test_beta;

%Gets residules
e = get_estimation(Y, Y_test);

%Getting the difference of errors:
diff_errors = get_errors(Y,Y_test);

n = 50; %number of observations
p = 3;  %number of betas

variance = sum(diff_errors'*diff_errors)/(n-p);
covariance = inv(X'*X)*variance;
std_err_x = sqrt(diag(covariance));
t_stat = beta./std_err_x;
std_err_y = sqrt(variance);

%f stats calculation
MSE = variance;
MSR = sum((Y_test - mean(Y)).^2)/(p-1);
f_stats = MSR/MSE;

%Printing function portion:

%-----------------------------------------
%Tested beta and beta printing:
combined_betas = [beta test_beta]';

format_beta_print = 'The values of the set beta is %3.3f and the calculated beta is %3.3f \n';
disp('The betas for the function is:')
fprintf(format_beta_print, combined_betas);
fprintf('\n')

%-----------------------------------------

disp('Standard error are: ')
disp(std_err_x);

%-----------------------------------------

disp('The t statistic are:')
disp(t_stat)

%-----------------------------------------

disp(['The f statistic is: ' , num2str(f_stats)])

%-----------------------------------------
