# CAN WE IMPROVE OUR UNDERSTANDING OF THESE BIT SEQUENCES?
library(rstan)
source("util.R")

# Prepare data
dat <- read.table("./Data/bit.dat", h = F, sep = "\t")
y   <- dataset$weight[dataset$gender == "F"]

# Run model
stan_data <- list(y = y, n = nrow(y), m = ncol(y))
fit <- load_or_compile(model_name = "task03", force_compile = F)
res <- stan(fit = fit, data = stan_data, chains = 3)

# MCMC diagnostics


# Analyze results