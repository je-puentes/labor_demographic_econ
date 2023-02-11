########################################################################################################
#                       Problem Set Labor and Demographics
#
########################################################################################################

# Importing data ----------------------------------------------------------

using DataFrames, Plots, Distributions, LinearAlgebra, Optim, RData, StatsModels, KernelEstimator, Statistics, CategoricalArrays


# Load data 
data_married = load("C:/Users/puent/OneDrive/Área de Trabalho/labor_demographic_econ/R/data_married.rds")


#  ----------------------------------------------------------
# Define Epachinov function
epanechnikov(u) = 0.75 * (1 - u^2)* (abs(u) <= 1);


# Multivariate Silverman's rule of thumb for bandwidth
function SilvermanBandwidth(X)
    d = size(X,2)           # Number of variables
    n = size(X,1)                                     # Number of observations
    sd = std.(eachcol(X))                             # Sample standard deviations
    H = I(d) .* (4 / (d + 2))^(1/(d + 4) ) * (n ^(-1*(1/(d+4))))
    H = H .* sd                                            # Creates diagonal matrix
    return H 
end
    
# Function to calculate the Nadaraya Watson estimator
function NadarayaWatson(X,Y)
    # Defining H bandwidth
    H = SilvermanBandwidth(X) 

    # Size of matrix X
    n = size(X)[1]

    # Vector of predicted y
    y_hat = zeros(n)

    # Loop to calcule m(X- x_i)
    for i = 1:n
        kernel_weights = epanechnikov.(abs.(X .- transpose(X[i, :])) / H)
        y_hat[i] = sum(kernel_weights .* Y) / sum(kernel_weights)
    end
    return y_hat
end


npr(X, P)
#  ----------------------------------------------------------
#    Performing a kernel regression
#  ----------------------------------------------------------

# Using Kernel estimation package










# Linear variables
X = hcat(ones(size(data_married)[1]), Matrix(data_married[:, [:non_labor_income,:age, :educ, :n_child]]))

# Dependent variable labor participation (=1)
P = Matrix(data_married[:,[:labor_par]])

# Calculate Participation probability
P_predict = NadarayaWatson(X,P)