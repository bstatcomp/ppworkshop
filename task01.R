# IS THE EXPECTED WEIGHT OF A FEMALE ANACONDA MORE THAN 35kg?
library(rstan)
source("util.R")

#### Prepare data (female anaconda weight)
dat <- read.table("./Data/anaconda.dat", h = T, sep = "\t")
y   <- dataset$weight[dataset$gender == "F"]

#### Plot data
plot(y, rep(0, length(y)), xlab = "weight", ylab = "")
segments(35, -1, 35, +1, lty = "dashed", col = "red")
segments(mean(y), -1, mean(y), +1, lty = "dashed", col = "blue")
title("blue line is sample average, red line is at 30 kg")

#### Run model
stan_data <- list(y = y, n = length(y))
fit <- load_or_compile(model_name = "task01", force_compile = F)
res <- stan(fit = fit, data = stan_data, chains = 3)

#### Analyze results (assumes the mean parameter is named "mean_weight")
param_name <- "mean_weight"

# MCMC diagnostics
traceplot(res, pars = param_name)
print(res, pars = param_name)

# Reason about the probability of mean > 35kg
x <- extract(res, pars = param_name)[[1]]

# Plot results
plot(y, rep(0, length(y)), xlab = "weight", ylab = "")
segments(35, -1, 35, +1, lty = "dashed", col = "red")
segments(mean(y), -1, mean(y), +1, lty = "dashed", col = "blue")
segments(quantile(x, 0.05), 0.02, quantile(x, 0.95), .02, lwd = 2, col = "green")
title("blue is average, red is 35 kg, green captures 95% certainty")

cat(sprintf("After seeing the data, the probability of mean > 35 is %.3f\n", mean(x > 35)))
