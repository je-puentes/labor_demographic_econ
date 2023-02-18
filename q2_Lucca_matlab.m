clear
clc
q2 = readmatrix("C:\Users\lucca\OneDrive\Documentos\labor\dataq2.csv");
q2 = array2table(q2, 'VariableNames', {'year', 'nchild', 'age','employed','real_incwage','incnonlabor','education'});
%% 1.a) no constant
% Considering educ
% Do nonparametrical estimation
n=100000;
P = q2(1:n, 4); %participation
X = q2(1:n, [2 3 6 7 5 4]); %independent vars and wage
P = table2array(P);
X = table2array(X);
grid_nchild = linspace(0,9,10);
grid_age = linspace(25,55,31);
grid_educ = linspace(0,20,41);
minnlaborinc = min(X(:,3));
maxnlaborinc = max(X(:,3));
grid_nonlaborinc = linspace(minnlaborinc,maxnlaborinc,41);
% The row below will take a while
tic
[P_hat,bd] = MultiKreg(X,P,grid_nchild,grid_age,grid_educ,grid_nonlaborinc); %bd gives the bandwidth used
toc % ~ 3 min for 100,000; 25 up to 30 minutes for 500,000; 45 up to 50 minutes for 1,000,000
%% Probability of participation (prob)
% create a variable, poseduc, to save position of each educ in the grid
poseduc = zeros(n,1);
% maybe you need X = table2array(X), I'm not sure
poseduc = 2*X(:,4)+1;
% nearest neighbor (simplest interpolation) for nonlabor income -- too much
% NaN, cannot interpolate properly with polynomials
dif = zeros(n,1);
Id = zeros(n,1);
for i = 1:n
[dif(i),Id(i)] = min(abs(grid_nonlaborinc(:) - X(i,3)));
end
% P_hat for each obs
% rows are for age
prob = zeros(n,1);
for i = 1:n %row
    prob(i) = P_hat(X(i,1)+1,X(i,2)-24,poseduc(i),Id(i));
end
% Attach probability
X = [array2table(X) array2table(prob)];
% Remove NaNs
X = rmmissing(X);
prob=rmmissing(prob);
%% 1.b) Robinson steps
% First for age on probability of participation according to the kernel
% estimation
age_var = X(:, 2);
age_var = table2array(age_var);
grid_prob = linspace(0,1,100);
tic
[age_hat,bd] = Kreg(prob,age_var,grid_prob); 
toc
%% Expected age
n = size(X,1);
exp_age = zeros(n,1);
% nearest neighbor
dif = zeros(n,1);
Id = zeros(n,1);
for i = 1:n
[dif(i),Id(i)] = min(abs(grid_prob(:) - prob(i)));
end
for i = 1:n %row
    exp_age(i) = age_hat(Id(i));
end
exp_age = array2table(exp_age);
% Attach probability of high school in the table
X = [X exp_age]; %expected age very near actual age, *as expected*
%% For education
educ_var = X(:, 4);
educ_var = table2array(educ_var);
tic
[educ_hat,bd] = Kreg(prob,educ_var,grid_prob);
% Expected education
% nearest neighbor
dif = zeros(n,1);
Id = zeros(n,1);
for i = 1:n
[dif(i),Id(i)] = min(abs(grid_prob(:) - prob(i)));
end
exp_educ = zeros(n,1);
for i = 1:n %row
    exp_educ(i) = educ_hat(Id(i));
end
exp_educ = array2table(exp_educ);
% Attach probability of high school in the table
X = [X exp_educ]; %expected age very near actual age, *as expected*
toc
%% Wage -- there's a problem
% For some reason I cannot figure out, Kernel estimation delivers
% mean(wage_var) for every grid point
tic
wage_var = X(:, 5);
wage_var = table2array(wage_var);
[wage_hat,bd] = Kreg(prob,wage_var,grid_prob);
toc
%% Expected wage
exp_wage = zeros(n,1);
for i = 1:n %row
    exp_wage(i) = wage_hat(Id(i));
end
exp_wage = array2table(exp_wage);
% Attach probability of high school in the table
X= [X exp_wage];
%% Regression
% Difference from real to predict
educdiff = table2array(X(:,4))-table2array(X(:,9));
agediff = table2array(X(:,2))-table2array(X(:,8));
wagediff = table2array(X(:,5))-table2array(X(:,10));
prob = table2array(X(:,7));
% OLS
xdiff = [educdiff agediff];
[gamma,se] = OLS(wagediff,xdiff);
gamma
se
%% Klein-Spady estimator
% C=y+P*w -> we use E(w) with estimated gamma
exp_wages = age_var*gamma(2) + educ_var*gamma(1);
% New P; new size
P = table2array(X(:,6));
% Nonlabor income
y = table2array(X(:,3));
% Consumption
consumption = P.*exp_wages + y;
%% Create x to enter the log likelihood maxim. problem
const = array2table(ones(n,1)); % constant
nchild = X(:,1);
age_var = array2table(age_var);
consumption = array2table(consumption);
P = array2table(P);
x=[const consumption age_var nchild P];
%% Exclude zeros
x = x(x.consumption ~= 0,:);
P = x(:,5);
x = removevars(x,'P');
x = table2array(x);
P = table2array(P);
%% Max likelihood function
%initial guess
ig = [1 1 2 1];
% Created Likelihood function
options = optimset('Algorithm', 'sqp', 'Display', 'iter','TolX',1e-20,'TolFun',1e-20, 'MaxFunEvals',3000);
[utility_parameters,LL,exit_flag,output] = fminsearch(@(param)Likelihood(param,P,x),ig,options);
utility_parameters
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

%  Changing BiKreg function from Matlab and Microeconometrics book to allow
%  4 independent variables, Epanechnikov kernel, Silverman's rule of
%  thumb and different grid lengths
function [yhat,h,w,z,v,r] = MultiKreg(X,y,x,a,b,c,h0)
%-----------------------------------------------
% PURPOSE: performs the kernel regression of y
%          on (4-dimensional) X
%-----------------------------------------------
% USAGE: [yhat,h,w,z] = MultiKreg(X,y,x,h0,n)
% where:  y : N-by-1 dependent variable
%         X : N-by-4 independent variable
%         x : n1-by-1 points of evaluation one variable (grid)
%         a : n2-by-1 points of evaluation second variable (grid)
%         b : n3-by-1 points of evaluation third variable (grid)
%         c : n4-by-1 points of evaluation fourth variable (grid)
%        h0 : 4-by-1 bandwidth
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
n4 = size(c, 2);
[w,z,v,r] = ndgrid(x, a, b, c);

%--- (2) Set Silvermans' rule of thomb bandwidth if not supplied & kernel--
if nargin < 7 %did not specify bandwidth value
    X1 = X(:,1);
    sig1 = std(X1);
    h(1) = ((4/5)^(1/7))*N^(-1/7)*sig1;
    X2 = X(:,2);
    sig2 = std(X2);
    h(2) = ((4/5)^(1/7))*N^(-1/7)*sig2;
    X3 = X(:,3);
    sig3 = std(X3);
    h(3) = ((4/5)^(1/7))*N^(-1/7)*sig3;
    X4 = X(:,4);
    sig4 = std(X4);
    h(4) = ((4/5)^(1/7))*N^(-1/7)*sig4;
else
    h = h0;
end
hw = h(1);
hz = h(2);
hv = h(3);
hr = h(4);

% Epanechnikov Kernel
krnl = @(u) 0.75*(1-(u.*u)).*(abs(u)<1);

%--- (3) Perform trivariate kernel regression!---
%        Product kernel X(:,1)
KW = NaN(length(y),n1);
W = X(:,1);
for w_ = 1 : n1
    wi = w(w_,1,1,1);
    uw = (W - wi)/hw;
    Kuw = krnl(uw);
    KW(:,w_) = Kuw;
end

% Product kernel X(:,2)
KZ = NaN(length(y),n2);
Z = X(:,2);
for z_ = 1 : n2
    zi = z(1,z_,1,1);
    uz = (Z - zi)/hz;
    Kuz = krnl(uz);
    KZ(:,z_) = Kuz;
end

% Product kernel X(:,3)
KV = NaN(length(y),n3);
V = X(:,3);
for v_ = 1 : n3
    vi = v(1,1,v_,1);
    uv = (V - vi)/hv;
    Kuv = krnl(uv);
    KV(:,v_) = Kuv;
end

% Product kernel X(:,4)
KR = NaN(length(y),n4);
R = X(:,4);
for r_ = 1 : n4
    ri = r(1,1,1,r_);
    ur = (R - ri)/hr;
    Kur = krnl(ur);
    KR(:,r_) = Kur;
end

% NW estimator
yhat = NaN(size(w,1), size(z,2), size(v,3), size(r,4));
for i = 1 : n1
    for j = 1 : n2
        for f = 1 : n3
            for t = 1 : n4
                Ku = KW(:,i).*KZ(:,j).*KV(:,f).*KR(:,t);
                yhat(i,j,f,t) = sum(Ku.*y)/sum(Ku);
            end
        end
    end
end

return
end

function [yhat,h] = Kreg(X,y,x,h0,func)
%------------------------------------------------
% PURPOSE: performs the kernel regression of y on
%          (univar) X
%------------------------------------------------
% USAGE: yhat = Kreg(X,y,x,h0,func)
% where: y    : n-by-1 dependent variable
%        X    : n-by-1 independent variable
%        x    : N-by-1 points of evaluation
%        h0   : scalar bandwidth
%        func : kernel function
%------------------------------------------------
% OUTPUT:    h : bandwidth used
%         yhat : regression evaluated at each
%                element of x
%------------------------------------------------
n = length(y);
N = length(x);

%--- (1) Set bandwidth if not supplied ----------
if nargin < 4
    % suggested by Bowman and Azzalini (1997)
    sig1 = std(X);
    hx = ((4/5)^(1/7))*N^(-1/7)*sig1;
    hy=median(abs(y-median(y)))/0.6745*(4/3/n)^0.2;
    h=sqrt(hy*hx);
else
    h = h0;
end

%--- (2) Set Kernel function if so desired ------
if nargin < 5
    % Epan as default
    krnl = @(u) 0.5.*(abs(u) <= 1);
else
    K = {'Gaussian', 'Uniform', 'Epanechnikov'};

    if strcmpi(func, K{1})
        % Epanechnikov
        krnl = @(u) 0.5.*(abs(u) <= 1);
    elseif strcmpi(func, K{2})
        % Uniform
        krnl = @(u) 0.75*(1 - (u.*u)).*(abs(u) <= 1);
    elseif strcmpi(func, K{3})
        % Epanechnikov
        krnl = @(u) 0.5.*(abs(u) <= 1);
    else
        % --> if there's been a mistake- Gaussian
        krnl = @(u) exp(-(u.*u)/2)/sqrt(2*pi);
    end
end

%--- (3) Perform kernel regression! -------------
yhat = NaN(N,1);
for i = 1:N
    u = (X - x(i))/h;
    Ku = krnl(u);
    yhat(i) = sum(Ku.*y)/sum(Ku);
end

return
end
function [LL, ll_i] = Likelihood(params, P, x)
% x: constant, consumption, age and nchild
% P: participation

alpha1 = params(1);
alpha2 = params(2);
alpha3 = params(3);
beta = params(4);

T = x(:,2) + alpha1*(1-P).*x(:,1) + alpha2*(1-P).*x(:,3) + alpha3*(1-P).*x(:,4) + beta*(1-P).*x(:,2); %logit transformation
ll_i = P.*log(T) + (1-P).*log(1-T); % contribution of each observation to
% the loglikelihood
LL = -nansum(ll_i);

return
end