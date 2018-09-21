is.keras_model <- function(x){
  inherits(x, "keras.engine.training.Model")
}

is.keras_model_sequential <- function(x){
  is.keras_model(x) && inherits(x, "keras.engine.sequential.Sequential")
}

is.keras_model_network <- function(x){
  is.keras_model(x) && !is.keras_model_sequential(x)
}

