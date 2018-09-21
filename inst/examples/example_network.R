require(keras)

# Functional model example from https://keras.rstudio.com/articles/functional_api.html

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

