############################################################################
#                       Problem Set Labor and Demographics
#
############################################################################


# Importing data ----------------------------------------------------------

using DataFrames, Plots, Distributions, Optim, RData, StatsModels, KernelDensity, Statistics

# Load data 
data_ps1 = load("C:/Users/puent/OneDrive/Área de Trabalho/labor_demographic_econ/R/data_ps1.rds")


#  ----------------------------------------------------------
# Define Epachinov function
epanechnikov(u) = 0.75 * (1 - u^2)* (abs(u) <= 1);

# Kernel calculation
function kernel_epa(x, x_0, h)
    # x_0 is the reference point
    # x is any point
    # h is the bandwidth
    u = ((x .- x_0) ./ h)
    y = epanechnikov.(u)
end

# Nadaya-Watson estiamtion
function NadayaWatson(Y, h)
    y_hat = zeros(size(Y,1))
    for i in 1:size(Y,1)
        ker_val = kernel_epa.(Y, Y[i] , h) # vector of kernel values
        weights = ker_val ./ sum(ker_val)
        y_hat[i] = sum(weights .* Y)
    end
    return y_hat
end

plot(Y)

#  ----------------------------------------------------------
#    Performing a kernel regression
#  ----------------------------------------------------------

# Linear variables
X = hcat(ones(size(data_ps1)[1]), Matrix(data_ps1[:, [:age, :nchild]]))

# Non linear variables
Z = Matrix(data_ps1[:, [:educ, :age]])

# Dependent variable
Y = Matrix(data_ps1[:,[:empstat]])

# Establish bandwidths for z and x
bw_z = 0.5 * (median(abs.(Z .- mean(Z, dims = 1)))) / size(Z, 1)^0.2
bw_x = 0.5 * (median(abs.(X .- mean(X, dims = 1)))) / size(X, 1)^0.2

# Compute the kernel regression estimate
p_hat = zeros(size(Y))

for i in 1:size(data_ps1, 1)
    z_i = Z[i, :]
    x_i = X[i, :]
    
    kernel_z = EpanechnikovKernel(bw_z)
    kernel_x = EpanechnikovKernel(bw_x)
    
    weights_z = pdf(kernel_z, (z .- z_i))
    weights_x = pdf(kernel_x, (x .- x_i))
    
    weights = weights_z .* weights_x
    
    p_hat[i] = sum(weights .* y) / sum(weights)
end



