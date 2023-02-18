############################################################################
#                       Problem Set Labor and Demographics
#
############################################################################

# Packages
library(tidyverse) # Package for everything
library(haven)     # Package for reading dta files 
library(ggthemes)  # Package for themes
library(lubridate) # Converts to date format
library(np)        # Package for non parametric and semiparametric
library(purrr)     # Map function is here
library(ks)

# Set seed
set.seed(666)
# Importing data ----------------------------------------------------------

# Important note: we are dealing with a database that has already been 
# cleaned. We will convert the file in a Rdata format so that we can 
# load faster the data.

# Only use this option if you dont't have acess to the Rdata format
# data_ps <- read_dta(file = "data_PS1.dta")

# Convert to Rdata the data_ps
# saveRDS(data_ps, file = "data_ps1.rds")

# Load data
data_ps1 <- as_tibble(readRDS(file =  "data_ps1.rds"))

# Creates real values of wages
data_ps1 <- data_ps1 %>%
  mutate(real_hhincome = (hhincome*100) / Price_Index,
         real_wage = (incwage * 100) / Price_Index,
         labor_par = ifelse(empstat %in% c(1,2),1, ifelse( empstat == 3 ,0, NA)),
         non_labor_income = real_hhincome - real_wage)
  

# Question 1 --------------------------------------------------------------

# For women women aged 15-65

# yearly mean wages
year_mean_wage <- data_ps1 %>%
  filter(age %in% 15:65, sex == 2, incwage >=0 ) %>%
  group_by(year) %>%
  summarise(mean_wage = mean(incwage, na.rm = T))

# Plot mean_wage
plot_wages <- ggplot(year_mean_wage, aes(x = year
                           , y = mean_wage ))+
  geom_line(color = "#967BB6")+
  geom_point(color = "#7B1FA2")+
  theme_few()+
  labs(title = "Yearly mean wage", 
       subtitle = "Women aged 15-65",
       x = "Year",
       y = "Mean wage")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle= element_text(hjust = 0.5),
        legend.position = "bottom") +
  scale_y_continuous(n.breaks = 10)+
  scale_x_continuous(n.breaks = 2019-2005)

# mean hours worked (unconditional and conditional)
  mean_hour_unconditional <- data_ps1 %>%
    filter(age %in% 15:65, sex == 2, empstat == 1) %>%
    group_by(year) %>%
    summarise(mean_wage = mean(incwage, na.rm = T)) 

# mean employment rates of women
  mean_employment <- data_ps1 %>%
    filter(age %in% 15:65, sex == 2) %>%
    group_by(year) %>%
    summarise(mean_labor_par = mean(labor_par, na.rm = T)) 
  
# Plot of labor participation of women 
  ggplot(mean_employment, aes(x = year, y = mean_labor_par))+
    geom_line(color = "#967BB6")+
    geom_point(color = "#7B1FA2")+
    theme_few()+
    labs(title = "Yearly Employment Rate", 
         subtitle = "Women aged 15-65",
         x = "Year",
         y = "Percent employed")+
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle= element_text(hjust = 0.5),
          legend.position = "bottom") +
    scale_y_continuous(n.breaks = 10)+
    scale_x_continuous(n.breaks = 2019-2005)

# Question 2 --------------------------------------------------------------

# Utility function
# U(c, P; e) = c + x'a*(1-P) + b(1-P)c + e(1-P)
# c: consumption
# Participation index (=1 if works)
# x: vector of covariates
# r threshold value
  

# 2 - a) Estimation Particiaption probabilities ---------------------------
# wage equation:
# w(z,eta) = z'y + M(Pr(P =1| y,z,x )) + u

# Subseting for married women between 25-55
  m_women_25_55 <- data_ps1 %>%
    filter(age %in% 25:55, marst %in% c(1,2), hhincome >=0,
           !is.na(non_labor_income),
           !is.na(age),
           !is.na(nchild)) %>%
    mutate(n_child = as.numeric(nchild),
           educ = as.numeric(educ)) %>%
    filter(educd > 1 & educd != 999) %>%  # drop if educd <= 1 or educd == 999
    mutate(education = -1) %>%  # create new column 'education' with -1 as initial value
    mutate(education = case_when(
      educd == 2 ~ 0,
      educd == 14 ~ 1,
      educd == 15 ~ 2,
      educd == 13 ~ 2.5,
      educd == 16 ~ 3,
      educd == 17 ~ 4,
      educd == 22 ~ 5,
      educd == 21 ~ 5.5,
      educd == 23 ~ 6,
      educd == 20 ~ 6.5,
      educd == 25 ~ 7,
      educd == 24 ~ 7.5,
      educd == 26 ~ 8,
      educd == 30 ~ 9,
      educd == 40 ~ 10,
      educd == 50 ~ 11,
      educd == 60 ~ 12,
      educd == 61 ~ 12,
      educd == 62 ~ 12,
      educd == 63 ~ 12,
      educd == 64 ~ 12,
      educd == 65 ~ 12,
      educd == 70 ~ 13,
      educd == 71 ~ 13,
      educd == 80 ~ 14,
      educd == 90 ~ 15,
      educd == 100 ~ 16,
      educd == 101 ~ 16,
      educd == 110 ~ 17,
      educd == 111 ~ 18,
      educd == 112 ~ 19,
      educd == 113 ~ 20,
      educd == 114 ~ 20,
      educd == 116 ~ 20,
      TRUE ~ education  # if none of the above conditions are true, keep existing value
    )) %>% 
    filter(education != -1) 
  

# Take a subsample of n=1000 and n = 50000 because my laptop does not have enough computing
# power
n_1 = 1000 # Size of subsample 1 
n_2 = 5000 # Size of subsample 2 

# First subsample n= 1000
m_women_25_55_n_1 <- m_women_25_55[sample(nrow(m_women_25_55), n_1),] %>%
                                        mutate(educ = as.factor(educ),
                                               age = as.numeric(age),
                                               nchild = n_child)

# Second subsample n= 5000
m_women_25_55_n_2 <- m_women_25_55[sample(nrow(m_women_25_55), n_2),] %>%
  mutate(educ = as.factor(educ),
         age = as.numeric(age),
         nchild = n_child)


# Step 1: Non-parametric estimation of Pr(P = 1 | y,z,x) ------------------
# a)  Non-parametrically estimate Pr(P = 1|y, z, x) using a kernel regression 
  # where z includes completed education and age and x includes a constant, 
  # age and current number of children and y is non labor income



# R's built-in function using np package ----------------------------------
# Bandwidth estimation with Linear Cross-Validation
bw_par_n1 <- npregbw(formula = labor_par ~ non_labor_income  + educ + age + nchild , 
                  data = m_women_25_55_n_1, regtype = "lc", 
                  ckertype = "gaussian")

bw_par_n2 <- npregbw(formula = labor_par ~ non_labor_income  + educ + age + nchild , 
                     data = m_women_25_55_n_2, regtype = "lc", 
                     ckertype = "gaussian")

# Results
resultados_n1 <- npreg(bw_par_n1) # first sample
resultados_n2 <- npreg(bw_par_n2) # second sample


# Summary of results
summary(resultados_n1)
summary(resultados_n2)


# Generate predicted probabilities
m_women_25_55_n_1 <- m_women_25_55_n_1 %>%
  mutate(predicted_p = predict(resultados_n1, data = m_women_25_55_n_1))

m_women_25_55_n_2 <- m_women_25_55_n_2 %>%
  mutate(predicted_p = predict(resultados_n2, data = m_women_25_55_n_2))


mean(m_women_25_55_n_2$predicted_p)
sd(m_women_25_55_n_2$predicted_p)
max(m_women_25_55_n_2$predicted_p)
min(m_women_25_55_n_2$predicted_p)

# Doing it manually -------------------------------------------------------
# Write auxiliary functions to manually calculate Nadaraya-Watson
# and the kernel estimator

# define the kernel function - Gaussian
K <- function(x, X, h) {
  d <- dist(cbind(x, X))
  w <- dnorm(d/h)
  return(w)
}

# define the multivariate Nadaraya-Watson estimator
NW <- function(x, X, Y, h) {
  W <- K(x, X, h)
  yhat <- sum(W*Y)/sum(W)
  return(yhat)
}


# Define the Nadaraya-Watson estimator function
nadaraya_watson <- function(x, T, L, H){
  n <- nrow(T)
  weights <- exp(-0.5 * rowSums(t((t(x) - T) %*% solve(H)) * (t(x) - T), na.rm = TRUE))
  return(sum(weights * L) / sum(weights))
}


# Estimate the optimal bandwidth using Silverman's rule of thumb
Silverman <- function(X){
  n <- nrow(X) # Number of rows
  d <- ncol(X) # Number of columns 
  std <- apply(X, 2, sd)  # Sd
  H <- diag(d) * std * (4 / (d + 2))^(1/(d + 4) ) * (n ^(-1*(1/(d+4))))
  return(H)
  } # Returns the diagonal matrix for bandwidth


# Subset matrices
# X variables age education
X_n1 <- as.matrix(cbind(const = rep(1, times = nrow(m_women_25_55_n_1)),m_women_25_55_n_1[, c("age", "nchild")]))
X_n2 <- as.matrix(cbind(const = rep(1, times = nrow(m_women_25_55_n_2)),m_women_25_55_n_2[, c("age", "nchild")]))

# Z variables completed education and age
Z_n1 <- as.matrix(m_women_25_55_n_1[, c("age", "education")])
Z_n2 <- as.matrix(m_women_25_55_n_2[, c("age", "education")])

# Y non labor income
Y_n1 <- as.vector(m_women_25_55_n_1[,"non_labor_income"])
Y_n2 <- as.vector(m_women_25_55_n_2[,"non_labor_income"])

# Matrix containing everything to estimate P
T_n1 <- as.matrix(cbind(X_n1[,-1], Z_n1, Y_n1))
T_n2 <- as.matrix(cbind(X_n2[,-1], Z_n2, Y_n2))

# Matrix of labor participation
L_n1 <- as.vector(m_women_25_55_n_1[,"labor_par"])
L_n2 <- as.vector(m_women_25_55_n_2[,"labor_par"])

# bandwith Matrix according to Silverman
H_n1 <- Silverman(T_n1)
H_n2 <- Silverman(T_n2)

# Estimation of P
y_est_n1 <- map_dbl(as.data.frame(T_n1), ~nadaraya_watson(unlist(.), T_n1, L_n1, H_n1))

# 2-b) Robinson's Partial regression --------------------------------------

# Semi parametric model 
robinson_reg_n1 <- npplreg(as.numeric(real_wage) ~ education + age | predicted_p, data = m_women_25_55_n_1, nmulti = 5)
robinson_reg_n2 <- npplreg(as.numeric(real_wage) ~ education + age | predicted_p, data = m_women_25_55_n_2, nmulti = 2, remin = T)

summary(robinson_reg_n1)
summary(robinson_reg_n2)

a


# 2-c) Klein Spady single index model -------------------------------------

obj_func_n1 <- function(alpha_1, alpha_2, alpha_3, beta, gamma_1, gamma_2){
  arg_g <- alpha_1 + alpha_2*m_women_25_55_n_1$age + alpha_3$nchild + beta*m_women_25_55_n_1$non_labor_income - gamma_1*m_women_25_55_n_1$education - gamma_2*m_women_25_55_n_1$age
}

obj_func <- function(alpha, beta, gamma){
  arg_x <- X %*% alpha + Y*beta - Z %*% gamma
  
}

# 3)Under the assumption that epsilon and ξ follow a bivariate normal distribution
# 3-a) full information maximum likelihood --------------------------------
#  Estimate the model using full information maximum likelihood 
# (that is, deriving a likelihood function in which we are estimating 
# the utility function and the wage equation jointly).
# Z = educ and age
# X = const, age , nchild
# y = non labor income

# Loglilihood
log_likelihood <- function(alpha_1,alpha_2,alpha_3, beta, gamma_1, gamma_2, sigma_e, sigma_xi, rho){
  sigma_v = sqrt(sigma_e^2 + sigma_xi^2 - 2*rho*sigma_e*sigma_xi)
  arg_pr_0 = (alpha_1 + alpha_2*m_women_25_55_n_1$age + alpha_3$nchild + beta*m_women_25_55_n_1$non_labor_income - gamma_1*m_women_25_55_n_1$education - gamma_2*m_women_25_55_n_1$age) / sigma_v 
  pr_0 = pnorm(arg_pr_0) ^ (1 - m_women_25_55_n_1$labor_par)
  
  arg_phi_z = (m_women_25_55_n_1$real_wage - gamma_1*m_women_25_55_n_1$education - gamma_2*m_women_25_55_n_1$age) / sigma_v
  arg_pr_1 = (m_women_25_55_n_1$real_wage - alpha_1 - alpha_2*m_women_25_55_n_1$age - alpha_3$nchild - beta*m_women_25_55_n_1$non_labor_income - rho*(sigma_e/sigma_xi)*(m_women_25_55_n_1$real_wage - gamma_1*m_women_25_55_n_1$education - gamma_2*m_women_25_55_n_1$age )) / (sigma_e*(1 - rho^2)^(0.5))
  pr_1 = ((1/sigma_xi) *(dnomr(arg_phi_z))*pnorm(arg_pr_1))^(m_women_25_55_n_1$labor_par)
  
  log_like = sum(log(pr_1)) + sum(log(pr_0))
  return(log_like)
}

in_guess <- c(0,0,0,0,0,0,0,0,0)
optim(in_iguess, log_likelihood, method = "Nelder-Mead")
