source("util.R")
library(ggplot2)
library(rstan)

## Read data
dat <- read.table("./Data/bit.dat", h = F, sep = "\t")
y1  <- as.numeric(dat[1,])     # first sequence only
y2  <- as.numeric(unlist(dat)) # complete data set

## Compile model (we only have to do this once)
fit <- load_or_compile(model_name = "bernoulli", force_compile = F)

## Do inference for 1st sequence and extract parameter values
stan_data <- list(y = y1, n = length(y1))
res1      <- stan(fit = fit, data = stan_data, chains = 3)
theta1    <- c(extract(res1, pars = "theta", permuted = F))

## Do inference for all sequences, extract parameter values
stan_data <- list(y = y2, n = length(y2))
res2      <- stan(fit = fit, data = stan_data, chains = 3)
theta2    <- c(extract(res2, pars = "theta", permuted = F))

# Plot posterior density estimates
x <- seq(0,1, by = 0.001)
g1 <- ggplot() + 
  geom_density(aes(x = theta1), colour = "black") +   
  geom_density(aes(x = theta2), colour = "red") +      
  geom_line(aes(x = x,y = 1), colour = "blue") +
  ylab("posterior density") + xlab(expression(theta)) + theme_bw()
plot(g1)
ggsave("vis01.png", g1, width = 5, height = 4)

# Plot posterior histograms
x <- seq(0,1, by = 0.001)
g1 <- ggplot() + 
  geom_histogram(aes(x = theta1), fill = "black", bins = 100) +   
  geom_histogram(aes(x = theta2), fill = "red", bins = 100) +      
  ylab("posterior density") + xlab(expression(theta)) + theme_bw()
plot(g1)
ggsave("vis02.png", g1, width = 5, height = 4)

# MCMC diagnostics
print(res1)
traceplot(res1)
plot(theta1[1:100], type = "b")
acf(theta1)
