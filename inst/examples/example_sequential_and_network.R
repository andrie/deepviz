## ---- sequential ----

require(keras)

# Sequential model with several different layers

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

## ---- network ----

# Model with several inputs and several outputs
# Example from https://keras.rstudio.com/articles/functional_api.html

model <- local({
  main_input <- layer_input(shape = c(100), dtype = 'int32', name = 'main_input')

  lstm_out <- main_input %>%
    layer_embedding(input_dim = 10000, output_dim = 512, input_length = 100) %>%
    layer_lstm(units = 32)

  auxiliary_output <- lstm_out %>%
    layer_dense(units = 1, activation = 'sigmoid', name = 'aux_output')

  auxiliary_input <- layer_input(shape = c(5), name = 'aux_input')

  main_output <- layer_concatenate(c(lstm_out, auxiliary_input)) %>%
    layer_dense(units = 64, activation = 'relu') %>%
    layer_dense(units = 64, activation = 'relu') %>%
    layer_dense(units = 64, activation = 'relu') %>%
    layer_dense(units = 1, activation = 'sigmoid', name = 'main_output')

  keras_model(
    inputs = c(main_input, auxiliary_input),
    outputs = c(main_output, auxiliary_output)
  )
})

model

model %>% plot_model()

