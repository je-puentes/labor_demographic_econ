clear
clc
q2 = readmatrix("C:\Users\lucca\OneDrive\Documentos\labor\dataq2.csv");
q2 = array2table(q2, 'VariableNames', {'year', 'nchild', 'age','employed','real_incwage','incnonlabor','education'});
%% Q3
n = 5000;
age = q2(1:n,3);
nchild = q2(1:n,2);
educ = q2(1:n,7);
wage = q2(1:n,5);
y = q2(1:n,6); %nonlabor income
x = [age nchild y educ wage];
x=table2array(x);
P = q2(1:n,4);
P = table2array(P);
ig=[1 0 1 0 1 0 0 .2 .3 0]; %initial guess
%[beta] = loglikelihood_maximization(x, ig, P);
%options = optimset('Algorithm', 'sqp', 'Display', 'iter','TolX',1e-12,'TolFun',1e-12, 'MaxFunEvals',3000);
%[utility_parameters,LL,exitflag] = fminsearch(@(param)Likelihood(param,P,x,1),ig,options);
%utility_parameters
options = optimset('Algorithm', 'sqp', 'Display', 'iter','TolX',1e-12,'TolFun',1e-12, 'MaxFunEvals',5000);
[utility_parameters,LL,exit_flag] = fminsearch(@(param)LLik(param,x,P),ig,options);
utility_parameters
%% functions
function [LL, ll_i] = Likelihood(params, y, x, sig)

beta(1,1) = params(1);
beta(2,1) = params(2);
beta(3,1) = params(3);
beta(4,1) = params(4);

r = 1 - normcdf((x*beta)./sig);
T = exp(r)./(1 + exp(r)); %logit transformation
ll_i = y.*log(T) + (1-y).*log(1-T); % contribution of each observation to
% the loglikelihood
LL = -nansum(ll_i);

return
end

function [LL, ll_i] = Likelihood2(params, y, x)

beta(1,1) = params(1);
beta(2,1) = 1;
beta(3,1) = params(2);

P = exp(x*beta)./(1 + exp(x*beta));
ll_i = y.*log(P) + (1-y).*log(1-P); % contribution of each observation to
% the loglikelihood
LL = -nansum(ll_i);

return
end

function beta = loglikelihood_maximization(x, ig, P)
x = table2array(x);
P = table2array(P);
ig = ig';

% With logit transformation
objfun = @(beta) -sum(P.*log(1 - exp(x*beta)./(1+exp(x*beta))) + (1-P).*log(exp(x*beta)./(1+exp(x*beta))));

options = optimoptions('fminunc','Algorithm','quasi-newton');

beta = fminunc(objfun, ig, options);
end

function [beta] = loglikelihood_maximization2(x, ig, P,w,y,rho)
P = table2array(P);
w = table2array(w);
x = table2array(x);
options = optimoptions('fminunc','Algorithm','quasi-newton','Display','iter');


objfun = @(beta) -sum(P.*log(normcdf((w - beta(4)*x(:,4) - beta(5)*x(:,2))) .* ...
    normcdf((w-beta(1)-beta(2)*x(:,4)-beta(3)*x(:,3)-beta(6)*y-rho.*(w- beta(4)*x(:,4)-beta(5)*x(:,2)))) ./ ...
    (1 + exp(-(beta(1)+beta(2)*x(:,2)+beta(3)*x(:,3)+beta(6)*y -beta(4)*x(:,4)-beta(5)*x(:,2))))) + ...
    (1-P).*log(exp(1 - normcdf(beta(1)+beta(2)*x(:,2)+beta(3)*x(:,3)+beta(6)*y -beta(4)*x(:,4)-beta(5)*x(:,2)))/(1+exp(1 - normcdf(beta(1)+beta(2)*x(:,2)+beta(3)*x(:,3)+beta(6)*y -beta(4)*x(:,4)-beta(5)*x(:,2))))));

[beta, fval, exitflag, output] = fminunc(objfun, ig, options);

end

function [LL,ll_i] = LLik(params, x, y)
% nine parameters
alpha0 = params(1);
alpha1 = params(2);
alpha2 = params(3);
gamma1 = params(4);
gamma2 = params(5);
beta = params(6);
sigeps = params(7);
sigeps2 = params(8);
rho = params(9);

signiu = sigeps + sigeps2 -2*rho*sigeps*sigeps2;
% non participation prob with logit transformation:
nP = exp(normcdf((alpha0 +alpha1*x(:,1)+alpha2*x(:,2)+beta*x(:,3)-gamma1*x(:,4)-gamma2*x(:,1))/sqrt(signiu)))./(1 +exp(normcdf((alpha0 +alpha1*x(:,1)+alpha2*x(:,2)+beta*x(:,3)-gamma1*x(:,4)-gamma2*x(:,1))/sqrt(signiu))));
% Now for participation/wage:
% P = (1/sigeps2).*normpdf((x(:,5)-gamma1*x(:,4)-gamma2*x(:,1))/sqrt(signiu)).*normcdf((x(:,5)-alpha0-alpha1*x(:,1)-alpha2*x(:,2)-beta*x(:,3)-rho*(sqrt(sigeps)/sqrt(sigeps2)).*(x(:,5)-gamma1*x(:,4)-gamma2*x(:,1)))/(sqrt(sigeps*(1-(rho^2)))));
P = (1/sigeps2).*normpdf((x(:,5)-gamma1*x(:,4)-gamma2*x(:,1))/signiu).*normcdf((x(:,5)-alpha0-alpha1*x(:,1)-alpha2*x(:,2)-beta*x(:,3)-rho*(sigeps/sigeps2).*(x(:,5)-gamma1*x(:,4)-gamma2*x(:,1)))/sigeps*sqrt((1-(rho^2))));
% Apply logit transformation:
P = exp(P)./(1+exp(P));
ll_i = y.*log(P) + (1-y).*log(nP); % contribution of each observation to
% the loglikelihood - y is zero or one

LL = -nansum(ll_i);
return
end