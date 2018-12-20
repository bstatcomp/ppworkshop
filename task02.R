# HOW ARE A MOVIE'S YEAR OF RELEASE AND BUDGET 
# CONNECTED TO MOVIE GROSS?
library(rstan)
source("util.R")

# Prepare data
dat <- read.table("./Data/movie_metadata.csv", h = T, sep = ",", encoding = "UTF-8", quote = "\"", comment.char = "")
dat <- dat[dat$country == "USA",]
dat <- data.frame(Year = dat$title_year, Budget = dat$budget, Gross = dat$gross)
dat <- dat[complete.cases(dat),]

# Run model
stan_data <- list(y_gross = dat$Gross, x_year = dat$Year, x_budget = dat$Budget, n = nrow(dat))
fit <- load_or_compile(model_name = "task02", force_compile = F)
res <- stan(fit = fit, data = stan_data, chains = 3)

# MCMC diagnostics


# Analyze results


