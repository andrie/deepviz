# Creates a network that illustrates depthwise separable convolution


library(keras)

model <- local({
  input <-
    layer_input(shape = c(3, 64, 64),
                dtype = 'float32',
                name = 'input')

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

  keras_model(inputs = c(input),
              outputs = c(output))

})

model
model %>% plot_model()




