library(tidyverse)
library(np)


# Carregar dados
data_test <- load("data_test.RDS")


# Estimando a bw pelo método default do pacote
bw_par <- npregbw(formula = labor_par ~ non_labor_income  + educ + age + nchild , 
data = data_test, regtype = "lc", 
ckertype = "epanechnikov")


# Gerando a estimação
resultados <- npreg(bw_par)

# Valores preditos
fitted(resultados)