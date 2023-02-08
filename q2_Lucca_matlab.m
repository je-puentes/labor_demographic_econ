clear
clc
q2 = readmatrix("C:\Users\lucca\OneDrive\Documentos\labor\dataq2.csv");
q2 = array2table(q2, 'VariableNames', {'year', 'nchild', 'age','employed','real_incwage','incnonlabor','elementary','highschool','college'});
%% 1.a) no constant
% Considering educ
% Do nonparametrical estimation for each educational level
elementary = q2(~(q2.elementary==0),:);
n=size(elementary(:,1),1);
Pe = elementary(1:n,4);
xe = elementary(1:n, [2 3]);
Pe = table2array(Pe);
xe = table2array(xe);
grid = [linspace(0,9,31)' linspace(25,55,31)'];
[P_hatel,bd,w,z] = BiKreg(xe,Pe,grid,n); %bd gives the bandwidth used
%% Graph with our own function graphkernel
graphkernel(w,z,Pe,P_hatel,xe,n,1)
%% P_hat for each obs
% rows are for age
prob = zeros(n,1);
for i = 1:n %row
    [C,I] = min(abs(grid(:,1) - xe(i,1))); %closest to the actual nchild - nearest neighbor interpolation
    % should not be a huge problem because max. difference between real
    % nchild and nchild in the grid is 0.1.
    prob(i) = P_hatel(xe(i,2)-24,I);
end
prob = array2table(prob);
% Attach probability
elementary = [elementary prob];
%% High School
hs = q2(~(q2.highschool==0),:);
n=size(hs(:,1),1);
Ph = hs(1:n,4);
xh = hs(1:n, [2 3]);
Ph = table2array(Ph);
xh = table2array(xh);
[P_hath,bd,w,z] = BiKreg(xh,Ph,grid,n);
%% Graph
graphkernel(w,z,Ph,P_hath,xh,n,2)
%% P_hat for each obs
% rows are for age
prob = zeros(n,1);
for i = 1:n %row
    [C,I] = min(abs(grid(:,1) - xh(i,1))); %closest to the actual nchild
    prob(i) = P_hath(xh(i,2)-24,I);
end
prob = array2table(prob);
% Attach probability
hs = [hs prob];
%% College
college = q2(~(q2.college==0),:);
n=size(college(:,1),1);
Pc = college(1:n,4);
xc = college(1:n, [2 3]);
Pc = table2array(Pc);
xc = table2array(xc);
[P_hatc,bd,w,z] = BiKreg(xc,Pc,grid,n);
%% Graph
graphkernel(w,z,Pc,P_hatc,xc,n,3)
%% P_hat for each obs
% rows are for age
prob = zeros(n,1);
for i = 1:n %row
    [C,I] = min(abs(grid(:,1) - xc(i,1))); %closest to the actual nchild
    prob(i) = P_hatc(xc(i,2)-24,I);
end
prob = array2table(prob);
% Attach probability
college = [college prob];
%% New data set attaching probabilities
q2 = vertcat(elementary,hs,college);
%% 1.b) Robinson steps
% We have three levels of education, should leave one out (elementary)
% Do earlier steps, but for the whole sample now
n = size(q2(:,1),1);
x = q2(1:n, [2 3]);
x = table2array(x);
grid = [linspace(0,9,31)' linspace(25,55,31)'];
% for high school
highs_var = q2(1:n, 8);
highs_var = table2array(highs_var);
[hs_hat,bd,w,z] = BiKreg(x,highs_var,grid,n);
% graph
graphkernel(w,z,highs_var,hs_hat,x,n,2)
%% For each obs
% rows are for age
probhs = zeros(n,1); % probability of high school
for i = 1:n %row
    [C,I] = min(abs(grid(:,1) - x(i,1))); % closest to the actual nchild
    probhs(i) = hs_hat(x(i,2)-24,I);
end
probhs = array2table(probhs);
% Attach probability of high school in the table
q2 = [q2 probhs];
%% For college
college_var = q2(1:n, 9);
college_var = table2array(college_var);
[college_hat,bd,w,z] = BiKreg(x,college_var,grid,n);
% graph
graphkernel(w,z,college_var,college_hat,x,n,3)
%% For each obs
% rows are for age
probcollege = zeros(n,1); % probability of college
for i = 1:n %row
    [C,I] = min(abs(grid(:,1) - x(i,1))); % closest to the actual nchild
    probcollege(i) = college_hat(x(i,2)-24,I);
end
probcollege = array2table(probcollege);
% Attach probability of high school in the table
q2 = [q2 probcollege];
%% Now for age
age_var = q2(1:n, 3);
age_var = table2array(age_var);
[age_hat,bd,w,z] = BiKreg(x,age_var,grid,n);
% graph
graphkernel(w,z,age_var,age_hat,x,n) %as expected, seems to increase one-
% -to-one with age
%% Expected age
exp_age = zeros(n,1);
for i = 1:n %row
    [C,I] = min(abs(grid(:,1) - x(i,1))); % closest to the actual nchild
    exp_age(i) = age_hat(x(i,2)-24,I);
end
exp_age = array2table(exp_age);
% Attach probability of high school in the table
q2 = [q2 exp_age];
%% Wage
wage_var = q2(1:n, 5);
wage_var = table2array(wage_var);
[wage_hat,bd,w,z] = BiKreg(x,wage_var,grid,n);
% graph
graphkernel(w,z,wage_var,wage_hat,x,n)
%% Expected wage
exp_wage = zeros(n,1);
for i = 1:n %row
    [C,I] = min(abs(grid(:,1) - x(i,1))); % closest to the actual nchild
    exp_wage(i) = wage_hat(x(i,2)-24,I);
end
exp_wage = array2table(exp_wage);
% Attach probability of high school in the table
q2 = [q2 exp_wage];
%% Regression
% Difference from real to predict
hsdiff = table2array(q2(1:n,8))-table2array(q2(1:n,11));
collegediff = table2array(q2(1:n,9))-table2array(q2(1:n,12));
agediff = table2array(q2(1:n,3))-table2array(q2(1:n,13));
wagediff = table2array(q2(1:n,5))-table2array(q2(1:n,14));
% OLS
xdiff = [hsdiff collegediff agediff];
[gamma,se] = OLS(wagediff,xdiff);
gamma
se
%% Function from Microeconometrics and Matlab textbook (changed for 
%  Epanechnikov Kernel and Silvermans' rule of thumb)
function [yhat,h,w,z] = BiKreg(X,y,x,n,h0)
%-----------------------------------------------
% PURPOSE: performs the kernel regression of y
%          on (bivar) X
%-----------------------------------------------
% USAGE: [yhat,h,w,z] = BiKreg(X,y,x,h0,n)
% where:  y : N-by-1 dependent variable
%         X : N-by-2 independent variable
%         x : n-by-2 points of evaluation
%        h0 : 2-by-1 bandwidth
%         n : scalar, sample size
%-----------------------------------------------
% OUTPUT:    h : bandwidths used
%         yhat : regression evaluated at the
%                n-by-n grid from columns of x
%-----------------------------------------------

%--- (1) Create grid of points ------------------
N = length(y);
n = size(x, 1);
[w,z] = meshgrid(x(:,1), x(:,2));

%--- (2) Set Silvermans' rule of thomb bandwidth if not supplied & kernel--
% Equals Scott's for dimension = 2, our case
if nargin < 5 %did not specify bandwidth value
    X1 = X(:,1);
    sig1 = std(X1);
    h(1) = n^(-1/6)*sig1;
    X2 = X(:,2);
    sig2 = std(X2);
    h(2) = n^(-1/6)*sig2;
else
    h = h0;
end
hw = h(1);
hz = h(2);
% Epanechnikov Kernel
krnl = @(u) 0.75*(1-(u.*u)).*(abs(u)<1);

%--- (3) Perform bivariate kernel regression!---
%        Product kernel X(:,1)
KW = NaN(length(y),size(w,1));
W = X(:,1);
for w_ = 1 : size(w,1)
    wi = w(1,w_);
    uw = (W - wi)/hw;
    Kuw = krnl(uw);
    KW(:,w_) = Kuw;
end

% Product kernel X(:,2)
KZ = NaN(length(y),size(z,1));
Z = X(:,2);
for z_ = 1 : size(z,1)
    zi = z(z_, 1);
    uz = (Z - zi)/hz;
    Kuz = krnl(uz);
    KZ(:,z_) = Kuz;
end

% NW estimator
yhat = NaN(size(w,1), size(w,2));
for i = 1 : n
    for j = 1 : n
        Ku = KW(:,i).*KZ(:,j);
        yhat(j,i) = sum(Ku.*y)/sum(Ku);
    end
end

return
end

function graphkernel(w,z,P,P_hat,x,n,k)
surf(w,z,P_hat)
if k == 1
title('Elementary')
elseif k == 2
title('High School')
elseif k == 3
title('College')
else
title('For all')       
end
xlabel('nchild', 'FontSize', 14);
ylabel('age', 'FontSize', 14);
zlabel('P_ hat', 'FontSize', 14);
hold on
scatter3(x(1:n,1),x(1:n,2),P(1:n))
colormap(bone)
return
end
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