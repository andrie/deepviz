require(keras)

## ---- depthwise-separable ----

# Creates a network that illustrates depthwise separable convolution

depthwise_separable <- local({
  input <-
    layer_input(
      shape = c(3, 64, 64),
      dtype = 'float32',
      name = 'input'
    )

  conv_1x1 <- input %>%
    layer_conv_2d(8, kernel_size = c(1, 1), name = "1x1_convolution")

  conv_1 <- conv_1x1 %>%
    layer_conv_2d(8, kernel_size = c(3, 3), name = "3x3_convolution_1")

  conv_2 <- conv_1x1 %>%
    layer_conv_2d(8, kernel_size = c(3, 3), name = "3x3_convolution_2")

  conv_3 <- conv_1x1 %>%
    layer_conv_2d(8, kernel_size = c(3, 3), name = "3x3_convolution_3")

  output <- layer_concatenate(
    c(conv_1, conv_2, conv_3),
    name = "concat"
  )

  keras_model(
    inputs = c(input),
    outputs = c(output)
  )

})

depthwise_separable

depthwise_separable %>% plot_model()


## ---- resnet ----

# Creates a network that illustrates a module of the resnet network
# references: https://arxiv.org/pdf/1610.02357.pdf

resnet <- local({
  input <- layer_input(shape = c(3, 64, 64), dtype = 'float32')

  stream_1 <- input %>%
    layer_conv_2d(1, kernel_size = c(3, 3), padding = "same", activation = "relu") %>%
    layer_conv_2d(1, kernel_size = c(3, 3), padding = "same", activation = "relu")

  output <- layer_add(c(input, stream_1))

  keras_model(inputs = c(input),
              outputs = c(output))

})

resnet

resnet %>% plot_model()







## ---- inception_v3 ----

# Creates a network that illustrates the inception v3 network
# references: https://arxiv.org/pdf/1610.02357.pdf


inception_v3 <- local({
  input <- layer_input(shape = c(3, 64, 64), dtype = 'float32')

  stream_1 <- input %>%
    layer_conv_2d(1, kernel_size = c(1, 1), filters = 3)


  stream_2 <- input %>%
    layer_conv_2d(1, kernel_size = c(1, 1)) %>%
    layer_conv_2d(1, kernel_size = c(3, 3), padding = "same")

  stream_3 <- input %>%
    layer_average_pooling_2d(pool_size = c(1, 1)) %>%
    layer_conv_2d(8, kernel_size = c(3, 3), padding = "same")

  stream_4 <- input %>%
    layer_conv_2d(8, kernel_size = c(1, 1)) %>%
    layer_conv_2d(8, kernel_size = c(3, 3), padding = "same") %>%
    layer_conv_2d(8, kernel_size = c(3, 3), padding = "same")

  output <- layer_concatenate(
    c(stream_1, stream_2, stream_3, stream_4),
    name = "concat"
  )

  keras_model(inputs = c(input),
              outputs = c(output))

})

inception_v3

inception_v3 %>% plot_model()




