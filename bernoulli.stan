data {
  int n;
  int y[n];
}

parameters {
  real<lower=0,upper=1> theta;
}

model {
  theta ~ beta(1, 1);
  for (i in 1:n) {
    y[i] ~ bernoulli(theta);
  }
}
