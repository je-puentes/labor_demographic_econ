clear
clc
q2 = readmatrix("C:\Users\lucca\OneDrive\Documentos\labor\dataq2.csv");
q2 = array2table(q2, 'VariableNames', {'year', 'nchild', 'age','employed','real_incwage','incnonlabor','education'});
%% 1.a) no constant
% Considering educ
% Do nonparametrical estimation
P = q2(:,4); %participation
X = q2(:, [2 3 7]); %independent vars
P = table2array(P);
X = table2array(X);
grid_nchild = linspace(0,9,10);
grid_age = linspace(25,55,31);
grid_educ = linspace(0,20,41);
[P_hat,bd,n1,n2,n3] = TriKreg(X,P,grid_nchild,grid_age,grid_educ); %bd gives the bandwidth used
%% Probability of participation (prob)
% create a variable, poseduc, to save position of each educ in the grid
n = size(q2,1);
poseduc = zeros(n,1);
poseduc = 2*X(:,3)+1;
% P_hat for each obs
% rows are for age
prob = zeros(n,1);
for i = 1:n %row
    prob(i) = P_hat(X(i,1)+1,X(i,2)-24,poseduc(i));
end
prob = array2table(prob);
% Attach probability
q2 = [q2 prob];
%% 1.b) Robinson steps
% First for age
tic
age_var = q2(1:n, 3);
age_var = table2array(age_var);
[age_hat,bd] = TriKreg(X,age_var,grid_nchild,grid_age,grid_educ);
% Expected age
exp_age = zeros(n,1);
for i = 1:n %row
    exp_age(i) = age_hat(X(i,1)+1,X(i,2)-24,poseduc(i));
end
exp_age = array2table(exp_age);
% Attach probability of high school in the table
q2 = [q2 exp_age]; %expected age very near actual age, *as expected*
toc
%% For education
tic
educ_var = q2(:, 7);
educ_var = table2array(educ_var);
[educ_hat,bd] = TriKreg(X,educ_var,grid_nchild,grid_age,grid_educ);
% Expected education
exp_educ = zeros(n,1);
for i = 1:n %row
    exp_educ(i) = educ_hat(X(i,1)+1,X(i,2)-24,poseduc(i));
end
exp_educ = array2table(exp_educ);
% Attach probability of high school in the table
q2 = [q2 exp_educ]; %expected age very near actual age, *as expected*
toc
%% Wage
tic
wage_var = q2(1:n, 5);
wage_var = table2array(wage_var);
[wage_hat,bd] = TriKreg(X,wage_var,grid_nchild,grid_age,grid_educ);
toc
%% Expected wage
exp_wage = zeros(n,1);
for i = 1:n %row
    exp_wage(i) = wage_hat(X(i,1)+1,X(i,2)-24,poseduc(i));
end
exp_wage = array2table(exp_wage);
% Attach probability of high school in the table
q2 = [q2 exp_wage];
%%
scatter(table2array(q2(:,5)),table2array(q2(:,11)))
%% Regression
% Difference from real to predict
educdiff = table2array(q2(:,7))-table2array(q2(:,10));
agediff = table2array(q2(:,3))-table2array(q2(:,9));
wagediff = table2array(q2(:,5))-table2array(q2(:,11));
prob = table2array(q2(:,8));
% OLS
xdiff = [educdiff agediff prob];
[gamma,se] = OLS(wagediff,xdiff);
gamma
se
%% Functions
% OLS regression
function[Beta,se]=OLS(y,X)
%--------------------------------------------------------------------------
% PURPOSE: performs an OLS regression
%--------------------------------------------------------------------------
% INPUTS: y: N-by-1 dependent variable
%         X: N-by-K independent variables matrix
%--------------------------------------------------------------------------
% OUTPUTS: Beta: OLS coefficient vector
%            se: standard error of Beta
%--------------------------------------------------------------------------
%----------- (1) Calculate the coefficients -------------------------------
XX = X'*X;
Xy = X'*y;
Beta = inv(XX)*Xy;
%----------- (2) Calculate the standard errors ----------------------------
yhat = X*Beta;
res = y - yhat;
N = length(y);
K = size(X,2);
sigma = (res'*res)/(N-K);
% assume homocedasticity
variance = sigma*inv(XX);
se=diag(sqrt(variance));

return
end

%  Changing BiKreg function from Matlab and Microeconometrics book to allow
%  3 independent variables, Epanechnikov kernel, Silverman's rule of
%  thumb and different grid lengths
function [yhat,h,n1,n2,n3] = TriKreg(X,y,x,a,b,h0)
%-----------------------------------------------
% PURPOSE: performs the kernel regression of y
%          on (bivar) X
%-----------------------------------------------
% USAGE: [yhat,h,w,z] = BiKreg(X,y,x,h0,n)
% where:  y : N-by-1 dependent variable
%         X : N-by-3 independent variable
%         x : n1-by-1 points of evaluation one variable (grid)
%         a : n2-by-1 points of evaluation second variable (grid)
%         b : n3-by-1 points of evaluation third variable (grid)
%        h0 : 3-by-1 bandwidth
%         n : scalar, sample size
%-----------------------------------------------
% OUTPUT:    h : bandwidths used
%         yhat : regression evaluated at the
%                n-by-n grid from columns of x, a and b
%-----------------------------------------------

%--- (1) Create grid of points ------------------
N = length(y);
n1 = size(x, 2);
n2 = size(a, 2);
n3 = size(b, 2);
[w,z,v] = meshgrid(x, a, b);

%--- (2) Set Silvermans' rule of thomb bandwidth if not supplied & kernel--
if nargin < 6 %did not specify bandwidth value
    X1 = X(:,1);
    sig1 = std(X1);
    h(1) = ((4/5)^(1/7))*N^(-1/7)*sig1;
    X2 = X(:,2);
    sig2 = std(X2);
    h(2) = ((4/5)^(1/7))*N^(-1/7)*sig2;
    X3 = X(:,3);
    sig3 = std(X3);
    h(3) = ((4/5)^(1/7))*N^(-1/7)*sig3;
else
    h = h0;
end
hw = h(1);
hz = h(2);
hv = h(3);

% Epanechnikov Kernel
krnl = @(u) 0.75*(1-(u.*u)).*(abs(u)<1);

%--- (3) Perform trivariate kernel regression!---
%        Product kernel X(:,1)
KW = NaN(length(y),n1);
W = X(:,1);
for w_ = 1 : n1
    wi = w(1,w_,1);
    uw = (W - wi)/hw;
    Kuw = krnl(uw);
    KW(:,w_) = Kuw;
end

% Product kernel X(:,2)
KZ = NaN(length(y),n2);
Z = X(:,2);
for z_ = 1 : n2
    zi = z(z_,1,1);
    uz = (Z - zi)/hz;
    Kuz = krnl(uz);
    KZ(:,z_) = Kuz;
end

% Product kernel X(:,3)
KV = NaN(length(y),n3);
V = X(:,3);
for v_ = 1 : n3
    vi = v(1,1,v_);
    uv = (V - vi)/hv;
    Kuv = krnl(uv);
    KV(:,v_) = Kuv;
end

% NW estimator
yhat = NaN(size(w,1), size(z,2), size(v,3));
for i = 1 : n1
    for j = 1 : n2
        for f = 1 : n3
        Ku = KW(:,i).*KZ(:,j).*KV(:,f);
        yhat(i,j,f) = sum(Ku.*y)/sum(Ku);
        end
    end
end

return
end