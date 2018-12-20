load_or_compile <- function(model_name, force_compile = F) {
  fn_code <- paste0(model_name, ".stan")
  fn_fit  <- paste0(model_name, ".rds")
  if (!force_compile & file.exists(fn_fit)) {
    fit <- readRDS(fn_fit)    
  } else {
    fit <- stan_model(file = fn_code)
    saveRDS(fit, fn_fit)
  }
  fit
}