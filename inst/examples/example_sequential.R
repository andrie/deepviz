require(keras)

# Sequential model

model <- keras_model_sequential() %>%
  layer_dense(10, input_shape = c(64, 64)) %>%
  layer_conv_1d(filters = 16, kernel_size = 8) %>%
  layer_max_pooling_1d() %>%
  layer_flatten() %>%
  layer_dense(25) %>%
  layer_dense(25, activation = "relu") %>%
  layer_dropout(0.25) %>%
  layer_dense(2, activation = "sigmoid")


model

model %>% plot_model()

