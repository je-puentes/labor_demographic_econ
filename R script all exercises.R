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
library(Matrix)   # Faster computations of matrices

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
  mutate(real_hhincome = (hhincome*100) / Price_Index, # Creating real hhincome
         real_wage = (incwage * 100) / Price_Index, # real wage
         # labor participation
         labor_par = ifelse(empstat %in% c(1,2),1, ifelse( empstat == 3 ,0, NA)),
         # non labor income
         non_labor_income = real_hhincome - real_wage,
         wkswork2 = as.numeric(wkswork2) ) %>%
  mutate(wkswork2 = case_when(wkswork2 == 1 ~ 7,
                              wkswork2 == 2 ~ 20,
                              wkswork2 == 3 ~ 33,
                              wkswork2 == 4 ~ 43.5,
                              wkswork2 == 5 ~ 48.5,
                              wkswork2 == 6 ~ 51,
                              TRUE ~ wkswork2)) %>% 
  mutate(wage_hour =  real_wage / (wkswork2*uhrswork))


  

# Question 1 --------------------------------------------------------------

# For women women aged 15-65

# yearly mean wages total and per hour
year_mean_wage <- data_ps1 %>%
  filter(age %in% 15:65, sex == 2, uhrswork > 0,
         incwage < 999998, real_wage >=0 ) %>%
  group_by(year) %>%
  summarise(mean_wage = mean(real_wage, na.rm = T),
            mean_wage_hour = mean(wage_hour, na.rm = T))

# Plot mean_wage
plot_wages_year <- ggplot(year_mean_wage, aes(x = year
                           , y = mean_wage ))+
  geom_line(color = "#967BB6")+
  geom_point(color = "#7B1FA2")+
  theme_few()+
  labs(title = "Yearly mean real wage - Total", 
       subtitle = "Women aged 15-65",
       x = "Year",
       y = "Mean wage")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle= element_text(hjust = 0.5),
        legend.position = "bottom") +
  scale_y_continuous(n.breaks = 10)+
  scale_x_continuous(n.breaks = 2019-2005)

# Plot mean_wage_hour
plot_wages_hour <- ggplot(year_mean_wage, aes(x = year
                                              , y = mean_wage_hour ))+
  geom_line(color = "#967BB6")+
  geom_point(color = "#7B1FA2")+
  theme_few()+
  labs(title = "Yearly mean real wage - per hour", 
       subtitle = "Women aged 15-65",
       x = "Year",
       y = "Mean hourly wage")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle= element_text(hjust = 0.5),
        legend.position = "bottom") +
  scale_y_continuous(n.breaks = 10)+
  scale_x_continuous(n.breaks = 2019-2005)

# mean hours worked (unconditional and conditional)
  mean_hour_conditional <- data_ps1 %>%
    filter(age %in% 15:65, sex == 2, empstat == 1) %>%
    mutate(hour_worked = wkswork2*uhrswork) %>%
    group_by(year) %>%
    summarise(mean_hours = mean(hour_worked, na.rm = T)) 
    
  mean_hour_unconditional <- data_ps1 %>%
      filter(age %in% 15:65, sex == 2) %>%
      mutate(hour_worked = wkswork2*uhrswork) %>%
    group_by(year) %>%
      summarise(mean_hours = mean(hour_worked, na.rm = T)) 

  # Plot hours worked 
  plot_hour_worked_Cond <- ggplot(mean_hour_conditional, aes(x = year
                                                , y = mean_hours ))+
    geom_line(color = "#967BB6")+
    geom_point(color = "#7B1FA2")+
    theme_few()+
    labs(title = "Yearly hours worked - Conditional", 
         subtitle = "Women aged 15-65",
         x = "Year",
         y = "Mean hours worked")+
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle= element_text(hjust = 0.5),
          legend.position = "bottom") +
    scale_y_continuous(n.breaks = 10)+
    scale_x_continuous(n.breaks = 2019-2005)
  
  
  plot_hour_worked_uncond <- ggplot(mean_hour_unconditional, aes(x = year
                                                             , y = mean_hours ))+
    geom_line(color = "#967BB6")+
    geom_point(color = "#7B1FA2")+
    theme_few()+
    labs(title = "Yearly hours worked - Unconditional", 
         subtitle = "Women aged 15-65",
         x = "Year",
         y = "Mean hours worked")+
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle= element_text(hjust = 0.5),
          legend.position = "bottom") +
    scale_y_continuous(n.breaks = 10)+
    scale_x_continuous(n.breaks = 2019-2005)
  
  
  
# mean employment rates of women
  mean_employment <- data_ps1 %>%
    filter(age %in% 15:65, sex == 2) %>%
    group_by(year) %>%
    summarise(mean_employed = mean(labor_par, na.rm = T)) 
  
# Plot of labor participation of women 
 plot_employment <-  ggplot(mean_employment, aes(x = year, y = mean_employed))+
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
    scale_y_continuous(n.breaks = 10, labels = scales::percent)+
    scale_x_continuous(n.breaks = 2019-2005)
 


# 1-b) Mincer (1962) table ------------------------------------------------
data_mincer <- data_ps1 %>%
   # keep varaibles we will use
   select( year, empstat, sex, age, wkswork2, 
          marst, relate, relate_sp, empstat, empstat_sp,
          race, race_sp, nchlt5, educd, uhrswork) %>%
   # Keep married couples
   filter(marst <= 2) %>%
   # Keep heads of household
   filter(relate == 1 & relate_sp == 1) %>%
   # Head is unemployed or not in the Labor Force
   filter(!(relate == 1 & empstat > 1)) %>%
   filter(!(relate_sp == 1 & empstat_sp > 1)) %>%
   # Keep only couples with  person that identifies as white
   filter(race == 1 & race_sp == 1)
 
 # Definition of groups
 
 # Under 35 - elementary school
 under35_smallch_elem_FT <- data_mincer %>%
   filter(age <= 35 & nchlt5 != 0 & educd > 2 & 
            educd < 30 & uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 under35_smallch_elem_NFT <- data_mincer %>%
   filter(age <= 35 & nchlt5 != 0 & educd > 2 & 
            educd < 30 & uhrswork < 30 
          & uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 under35_noch_elem_FT <- data_mincer %>%
   filter(age <= 35 & nchlt5 == 0 & educd > 2 & 
            educd < 30 & uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 under35_noch_elem_NFT <- data_mincer %>%
   filter(age <= 35 & nchlt5 == 0 & educd > 2 & 
            educd < 30 & uhrswork < 30 & uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 # Under 55 - elementary school
 under55_elem_FT <- data_mincer %>%
   filter(age > 35 & age <= 55 & educd > 2 &
            educd < 30 & uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 under55_elem_NFT <- data_mincer %>%
   filter(age > 35 & age <= 55 & educd > 2 & educd < 30 &
            uhrswork < 30 & uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 # Older than 55 - elementary school
 older55_elem_FT <- data_mincer %>%
   filter(age > 55 & educd > 2 & educd < 30 & uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 older55_elem_NFT <- data_mincer %>%
   filter(age > 55 & educd > 2 & educd < 30 &
            uhrswork < 30 & uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 # Under 35 - high school
 under35_smallch_hs_FT <- data_mincer %>% 
   summarize(count = n()) %>%
   pull(count)
 
 under35_smallch_hs_NFT <- data_mincer %>% 
   filter(age <= 35, nchlt5 != 0, educd >= 30,
          educd < 65, uhrswork < 30, uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 under35_noch_hs_FT <- data_mincer %>% 
   filter(age <= 35, nchlt5 == 0, educd >= 30,
          educd < 65, uhrswork >= 30) %>% 
   summarize(count = n()) %>%
   pull(count)
 
 
 under35_noch_hs_NFT <- data_mincer %>%
   filter(age <= 35, nchlt5 == 0, educd >= 30, educd < 65,
          uhrswork < 30, uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 # Under 55 - high school
 under55_hs_FT <- data_mincer %>% 
   filter(age > 35, age <= 55, educd >= 30,
          educd < 65, uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 under55_hs_NFT <- data_mincer %>% 
   filter(age > 35, age <= 55, educd >= 30, educd < 65,
          uhrswork < 30, uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 # Older than 55 - high school
 older55_elem_FT <- data_mincer %>%
   filter(age > 55, educd >= 30,
          educd < 65, uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 
 older55_elem_NFT <- data_mincer %>% 
   filter(age > 55, educd >= 30, educd < 65,
          uhrswork < 30, uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 # Under 35 - college
 under35_smallch_college_FT <- data_mincer %>%
   filter(age <= 35, nchlt5 != 0, educd >= 65,
          educd <= 116, uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 
 under35_smallch_college_NFT <- data_mincer %>%
   filter(age <= 35, nchlt5 != 0, educd >= 65,
          educd <= 116, uhrswork < 30, uhrswork > 0)%>%
   summarize(count = n()) %>%
   pull(count)
 
 
 under35_noch_college_FT <- data_mincer %>%
   filter(age <= 35, nchlt5 == 0, educd >= 65,
          educd <= 116, uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 
 under35_noch_college_NFT <- data_mincer %>% 
   filter(age <= 35, nchlt5 == 0, educd >= 65, 
          educd <= 116, uhrswork < 30, uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)
 
 # Under 55 - college
 under55_college_FT <- data_mincer %>% filter(age > 35, age <= 55, educd >= 65,
                                              educd <= 116, uhrswork >= 30) %>%
   summarize(count = n()) %>%
   pull(count)
 
 
 under55_college_NFT <- data_mincer %>%
   filter(age > 35, age <= 55, educd >= 65,
          educd <= 116, uhrswork < 30, uhrswork > 0) %>%
   summarize(count = n()) %>%
   pull(count)

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
bw_par_n1 <- npregbw(formula = labor_par ~ non_labor_income  + education + age 
                     + nchild , 
                  data = m_women_25_55_n_1, regtype = "lc", 
                  ckertype = "gaussian")

bw_par_n2 <- npregbw(formula = labor_par ~ non_labor_income  + education + age
                     + nchild , 
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



# Doing it manually -------------------------------------------------------
# Write auxiliary functions to manually calculate Nadaraya-Watson
# and the kernel estimator

# Function to calculate the multivariate Epanechnikov kernel
epanechnikov_kernel <- function(x, y, h) {
  d <- x - y
  t <- sqrt(diag(tcrossprod(d, solve(h) %*% d)))
  ifelse(t < 1, 0.75 * (1 - t^2), 0)
}

# define the multivariate Nadaraya-Watson estimator
nadaraya_watson <- function(X,y, H){
  # Number of observations
  n <- nrow(X)
  
  # Vector of predicted y
  y_hat <- rep(0, n)
  
  # Loop to calculate m(X - x_i)
  for (i in 1:n) {
    kernel_weights <- rep(0, n)
    for (j in 1:n) {
      kernel_weights[j] <- epanechnikov_kernel(X[j,], X[i,], H)
    }
    y_hat[i] <- sum(kernel_weights * y) / sum(kernel_weights)
    if (i %% 100 == 0){
      print(i)
    } else{
      
    }
  }
  
  # Print the estimated values of y
  y_hat
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
# X variables age nchild
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

# Wages
W_n1 <- as.vector(m_women_25_55_n_1[,"real_wage"])
W_n2 <- as.vector(m_women_25_55_n_2[,"real_wage"])

# bandwith Matrix according to Silverman
H_n1 <- Silverman(T_n1)
H_n2 <- Silverman(T_n2)

# Estimation of P
P_n1 <- nadaraya_watson(X = T_n1, y = L_n1, H = H_n1)
P_n2 <- nadaraya_watson(X = T_n2, y = L_n2, H = H_n2)

save(P_n1, P_n2, file ="prob_matrix.RData")

# 2-b) Robinson's Partial regression --------------------------------------

# Semi parametric model 
robinson_reg_n1 <- npplreg(as.numeric(real_wage) ~ education + age | 
                             predicted_p, data = m_women_25_55_n_1, nmulti = 5)
robinson_reg_n2 <- npplreg(as.numeric(real_wage) ~ education + age |
                             predicted_p, data = m_women_25_55_n_2, nmulti = 2,
                           remin = T)

summary(robinson_reg_n1)
summary(robinson_reg_n2)


# Manually doing Robinson's Regression ------------------------------------

# We will need to define additional functions to perform in the univariate case
# Define the kernel function (Epanechnikov kernel)
epa_uni <- function(x, x0, h) {
  u <- abs((x - x0) / h) # argument
  k <- 0.75 * (1 - u^2) * as.numeric(abs(u) <= 1) # value
  return(k)
}

# Univariate NW Regression
nw_regression <- function(x0, x, y, h) {
  k <- epa_uni(x, x0, h)
  sum(k * y) / sum(k)
}



# Bandwidth for P
HP_1 <-  sd(P_n1) * (4 / (1 + 2))^(1/(1 + 4) ) * (1000 ^(-1*(1/(1+4))))
HP_2 <-  sd(P_n2) * (4 / (1 + 2))^(1/(1 + 4) ) * (5000 ^(-1*(1/(1+4))))


# First Calculate gy 
# First sample
gy_n1 <- sapply(P_n1, nw_regression, x = P_n1, y = W_n1, h = HP_1 )



# Second sample
gy_n2 <- sapply(P_n2, nw_regression, x = P_n2, y = W_n2, h = HP_2)
plot(P_n2, W_n2)
lines(P_n2, gy_n2, col = "blue", lwd = 2)

# Second: calculate gx
gx_n1 <- as.matrix(cbind(sapply(P_n1, nw_regression, x = P_n1, y = Z_n1[,1], h = HP_1 ), sapply(P_n1, nw_regression, x = P_n1, y =  Z_n1[,2], h = HP_1 )))
gx_n2 <- as.matrix(cbind(sapply(P_n2, nw_regression, x = P_n2, y = Z_n2[,1], h = HP_2 ), sapply(P_n2, nw_regression, x = P_n2, y =  Z_n2[,2], h = HP_2 )))


# Graphs of results kernel regression
appended_n1 <- as_tibble(cbind(P_n1, age = Z_n1[,1],
                         educ = Z_n1[,2], 
                         wage = W_n1,
                         g_wage = gy_n1,
                         g_age = gx_n1[,1],
                         g_educ = gx_n1[,2]))

appended_n2 <- as_tibble(cbind(P_n2, age = Z_n2[,1],
                               educ = Z_n2[,2], 
                               wage = W_n2,
                               g_wage = gy_n2,
                               g_age = gx_n2[,1],
                               g_educ = gx_n2[,2]))

base_graph_n1 <- ggplot(appended_n1, aes(x = P_n1)) +
  theme_few()+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle= element_text(hjust = 0.5),
        legend.position = "bottom") 

base_graph_n2 <- ggplot(appended_n2, aes(x = P_n2)) +
  theme_few()+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle= element_text(hjust = 0.5),
        legend.position = "bottom") 

nw_wage_n1 <- base_graph_n1 +
  geom_point(aes(y = wage), color = "#514F59") +
  geom_line(aes(y= g_wage), color = "#5941A9", size = 1.2) +
  labs(title = "NW - Kernel estimation of P on Wage",
       subtitle = "1000 Obs.",
       x = "Predicted P", 
       y = "Real wage")+
  scale_y_continuous(n.breaks = 14)+
  scale_x_continuous(n.breaks = 12)

nw_wage_n2 <- base_graph_n2 +
  geom_point(aes(y = wage), color = "#514F59") +
  geom_line(aes(y= g_wage), color = "#5941A9", size = 1.2) +
  labs(title = "NW - Kernel estimation of P on Wage",
       subtitle = "5000 Obs.",
       x = "Predicted P", 
       y = "Real wage")+
  scale_y_continuous(n.breaks = 14)+
  scale_x_continuous(n.breaks = 8)

nw_age_n1 <- base_graph_n1 +
  geom_point(aes(y = age), color = "#514F59") +
  geom_line(aes(y= g_age), color = "#5941A9", size = 1.2) +
  labs(title = "NW - Kernel estimation of P on Age",
       subtitle = "1000 Obs.",
       x = "Predicted P", 
       y = "Age")+
  scale_y_continuous(n.breaks = 14)+
  scale_x_continuous(n.breaks = 10)

nw_age_n2 <- base_graph_n2 +
  geom_point(aes(y = age), color = "#514F59") +
  geom_line(aes(y= g_age), color = "#5941A9", size = 1.2) +
  labs(title = "NW - Kernel estimation of P on Age",
       subtitle = "5000 Obs.",
       x = "Predicted P", 
       y = "Age")+
  scale_y_continuous(n.breaks = 14)+
  scale_x_continuous(n.breaks = 8)


nw_educ_n1 <- base_graph_n1 +
  geom_point(aes(y = educ), color = "#514F59") +
  geom_line(aes(y= g_educ), color = "#5941A9", size = 1.2) +
  labs(title = "NW - Kernel estimation of P on Education",
       subtitle = "1000 Obs.",
       x = "Predicted P", 
       y = "Education")+
  scale_y_continuous(n.breaks = 14)+
  scale_x_continuous(n.breaks = 8)

nw_educ_n2 <- base_graph_n2 +
  geom_point(aes(y = educ), color = "#514F59") +
  geom_line(aes(y= g_educ), color = "#5941A9", size = 1.2) +
  labs(title = "NW - Kernel estimation of P on Education",
       subtitle = "5000 Obs.",
       x = "Predicted P", 
       y = "Education")+
  scale_y_continuous(n.breaks = 14)+
  scale_x_continuous(n.breaks = 8)

ggsave(plot = nw_wage_n1, file = "ker_wage_1000.pdf")
ggsave(plot = nw_wage_n2, file = "ker_wage_5000.pdf")

ggsave(plot = nw_age_n1, file = "ker_age_1000.pdf")
ggsave(plot = nw_age_n2, file = "ker_age_5000.pdf")

ggsave(plot = nw_educ_n1, file = "ker_educ_1000.pdf")
ggsave(plot = nw_educ_n2, file = "ker_educ_5000.pdf")



# Calculate residual e_y = y - g_y, e_x = X- g_x
ey_n1 <- W_n1 - gy_n1 # First sample
ex_n1 <- Z_n1 - gx_n1

ey_n2 <- W_n2 - gy_n2 # Second samples
ex_n2 <- Z_n2 - gx_n2

# Finaly, OLS residuals

gamma_n1 <- solve(t(ex_n1) %*% ex_n1) %*% t(ex_n1) %*% ey_n1
gamma_n2 <- solve(t(ex_n2) %*% ex_n2) %*% t(ex_n2) %*% ey_n2


# 2-c) Klein-Spady single index model -------------------------------------

# Note: We will define again a new function to perform the NW multivariate 
# estimation because after I estimated questions 2-a) to 2-b) I have found
# a better and more efficient way  of estimating it

# Define the kernel function (Epanechnikov kernel)
kernel <- function(x) {
  d <- length(x)
  k <- (3/4) * (1 - x^2)*(as.numeric(abs(x) <=1))
}



# Account for the gammas we found
# z'gamma
gamma_z_n1 = Z_n1 %*% gamma_n1
gamma_z_n2 = Z_n2 %*% gamma_n2


# Define objective function
log_like_n1 <- function(beta){
  # Step 1: Compute the kernel weights
  X <- as.matrix(cbind(X_n1, Y_n1)) %*% beta - gamma_z_n1  # predictor variables matrix
  y <- L_n1 # response variable vector (labor par)
  n <- nrow(X) # number of observations
  d <- ncol(X) # number of predictor variables
  # bandwidth parameter estimated according to Silverman's rule of thumb
  h <- 1.06 * sd(y) * n^(-1/(d+4)) 
  
  # Step 2: Compute the predicted values
  # kernel predicted values
  y_pred <- sapply(X, nw_regression, x = X, y = y, h = h )
  

  # Define P
  P <- y - y_pred
  
  # Step 3: calculate objective function
  # Log of the value
  log_val <- y*(log(P)) + (1 - y) *(1 - log(P))
  objective <- sum(log_val)
  
  return(objective)
}





# 3)Under the assumption that epsilon and ξ follow a bivariate normal distribution
# 3-a) full information maximum likelihood --------------------------------
#  Estimate the model using full information maximum likelihood 
# (that is, deriving a likelihood function in which we are estimating 
# the utility function and the wage equation jointly).
# Z = educ and age
# X = const, age , nchild
# y = non labor income

# Loglikelihood NP-NS First sample
log_likelihood_n1 <- function(par){
  
  # Dictionary
  # par[1] = alpha_1
  # par[2] = alpha_2
  # par[3] = alpha_3
  # par[4] = beta
  # par[5] = gamma_1
  # par[6] = gamma_2
  # par[7] = sigma_e
  # par[8] = sigma_xi
  # par[9] = rho
  
  
  # sigma_v
  sigma_v <- sqrt(par[7]^2 + par[8]^2 - 2*par[9]*par[7]*par[8])
  
  # Arg pr_0
  arg_pr_0 <- (par[1] + par[2]*X_n1[,2] + par[3]*X_n1[,3] + par[4]*Y_n1 - par[5]*Z_n1[,1] - par[6]*Z_n1[,2]) / sigma_v 
  
  # Define Pr(0)
  pr_0 <- pnorm(arg_pr_0) 
  pr_0 <- exp(pr_0) / (1 + exp(pr_0))
  
  # Arg 1 of pR(1)
  arg_pr_1 <- (W_n1 - par[5]*Z_n1[,1] - par[6]*Z_n1[,2]) / sigma_v
  
  # Arg 2 de pr2
  arg_pr_2 <-  W_n1 - par[1] - par[2]*X_n1[,2]- par[3]*X_n1[,3] -par[4]*Y_n1
  arg_pr_2 <-  arg_pr_2 -(par[9]*par[7]/sigma_v)*(W_n1-par[5]*Z_n1[,1]-par[6]*Z_n1[,2])
  arg_pr_2 <- arg_pr_2 / (par[7]*sqrt(1-par[9]^2))
    
  # Pr(1)
  pr_1 <- (1/par[8]) * dnorm(arg_pr_1) * rnorm(arg_pr_2) 
  pr_1 <- exp(pr_1)/(1 + exp(pr_1))
  
  # Objective
  log_like = sum(L_n1*log(pr_1) + (1 - L_n1)*(log(pr_0)))
  return(log_like)
}




log_likelihood_n2 <- function(par){
  
  # Dictionary
  # par[1] = alpha_1
  # par[2] = alpha_2
  # par[3] = alpha_3
  # par[4] = beta
  # par[5] = gamma_1
  # par[6] = gamma_2
  # par[7] = sigma_e
  # par[8] = sigma_xi
  # par[9] = rho
  
  
  # sigma_v
  sigma_v <- sqrt(par[7]^2 + par[8]^2 - 2*par[9]*par[7]*par[8])
  
  # Arg pr_0
  arg_pr_0 <- (par[1] + par[2]*X_n2[,2] + par[3]*X_n2[,3] + par[4]*Y_n2 - par[5]*Z_n2[,1] - par[6]*Z_n2[,2]) / sigma_v 
  
  # Define Pr(0)
  pr_0 <- pnorm(arg_pr_0) 
  pr_0 <- exp(pr_0) / (1 + exp(pr_0))
  
  # Arg 1 of pR(1)
  arg_pr_1 <- (W_n2 - par[5]*Z_n2[,1] - par[6]*Z_n2[,2]) / sigma_v
  
  # Arg 2 de pr2
  arg_pr_2 <-  W_n2 - par[1] - par[2]*X_n2[,2]- par[3]*X_n2[,3] -par[4]*Y_n2
  arg_pr_2 <-  arg_pr_2 -(par[9]*par[7]/sigma_v)*(W_n2-par[5]*Z_n2[,1]-par[6]*Z_n2[,2])
  arg_pr_2 <- arg_pr_2 / (par[7]*sqrt(1-par[9]^2))
  
  # Pr(1)
  pr_1 <- (1/par[8]) * dnorm(arg_pr_1) * rnorm(arg_pr_2) 
  pr_1 <- exp(pr_1)/(1 + exp(pr_1))
  
  # Objective
  log_like = sum(L_n2*log(pr_1) + (1 - L_n2)*(log(pr_0)))
  return(log_like)
}


# Guesses
lucky_guess <- c(9.156, 0.858, -0.609, 1.265, 1232.229, 60.274,100, 100, 0)
random_guess <- sample(-100:100, 9)

# See if the guesses are of correct size
length(lucky_guess)
length(random_guess)


# Optimization with lucky_guess
optim(lucky_guess, log_likelihood_n1, method = "Nelder-Mead")
optim(lucky_guess, log_likelihood_n2, method = "Nelder-Mead")

# Optimization with random_guess
optim(random_guess, log_likelihood_n1, method = "Nelder-Mead")
optim(random_guess, log_likelihood_n2, method = "Nelder-Mead")


# 4-c) GMM  ---------------------------------------------------------------

data_gmm <- data_ps1 %>%
  filter(year == 2005 & marst >=3 & age %in% 25:55) %>%
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

# Variables in matrix form
T <- as.matrix(data_gmm[,"wkswork2"])
Y <- as.matrix(data_gmm[,"non_labor_income"])   
W <- as.matrix(data_gmm[,"incwage"]) 
X <- as.matrix(data_gmm[,c("age", "educ", "nchild")])   
L <- 52 - T
C <- Y + W*T - W*L 



gmm_objective <- function(beta) {
  
  # Define B_0
  B_0 <- c(beta[3], beta[4], beta[5])
  
  # Leisure moment function
  g1 <- mean(colMeans(X %*% (W*beta[1] + (X %*% B_0 * (Y + W*T - beta[2] - beta[1]*W) - W*L))))  
  # Consumption moment function
  g2 <- mean(colMeans(X*(beta[2] + (1- X %*% t(B_0))*(Y+W*T-beta[2]-beta[1]*W*X) + C)))  
  # Roy Identity moment
  Roy_1 <-  t(X %*% B_0)*(-Y/(W^2) + beta[1]/(W^2))
  Roy_2 <- Y/W - beta[2]/W -beta[1]
  Roy_3 <- (1 - X %*% t(B_0))*(T-beta[1])
  Roy_4 <- Y +W*T -beta[2] -beta[1] *W
  Roy_5 <- t(X %*% B_0)/W
  Roy_6 <- (1- X %*% t(B_0))
  
  # Roy's vector
  Roy <- (Roy_1/Roy_2 + Roy_3/Roy_4) / (Roy_5/Roy_2 + Roy_6/Roy_4)
  Marshall_leisure <- beta[1] + (X %*% B_0) %*% (Y + W*T - beta[2] - beta[1]*W)
  
  # Moment Marshall_leisure - Roy
  g3 <-  mean(Marshall_leisure - Roy)
  
  # Leisure demand moment
  g4 <- mean(colMeans(W*L - W*beta[1] - (X %*% t(B_0)) * (Y + W*T - beta[2] - beta[1]*W)))
  
  # Consumption demand moment
  g5 <- mean(C - beta[2] - (1 - X %*% t(B_0)) * (Y + W*T - beta[2] - beta[1]*W))
  

  # g objective
  g <- c(g1,g2,g3,g4,g5)
  
  # Objective
  obj <- g %*% t(g)
  
  return(obj)
  
}


optim(c(1,1,0,0,0), gmm_objective)
