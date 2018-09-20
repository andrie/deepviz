require(keras)

model <- keras_model_sequential() %>%
  layer_dense(10, input_shape = 4) %>%
  layer_dense(25, input_shape = 4) %>%
  layer_dense(25, input_shape = 4, activation = "relu") %>%
  layer_dropout(0.25) %>%
  layer_dense(2, activation = "sigmoid")

class(model)

model %>% plot_model()


