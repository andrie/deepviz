
<!-- README.md is generated from README.Rmd. Please edit that file -->

# deepviz

The goal of deepviz is to visualize (simple) neural network
architectures.

## Installation

``` r
devtools::install_github("andrie/deepviz")
```

## Load the packages

``` r
library(deepviz)
library(magrittr)
```

## plot\_model()

Create a model

``` r
require(keras)
#> Loading required package: keras

model <- keras_model_sequential() %>%
  layer_dense(10, input_shape = 4) %>%
  layer_dense(25, input_shape = 4) %>%
  layer_dense(25, input_shape = 4, activation = "relu") %>%
  layer_dropout(0.25) %>%
  layer_dense(2, activation = "sigmoid")
```

Plot the
model

``` r
model %>% plot_model()
```

<!--html_preserve-->

<div id="htmlwidget-3d0c02f0201631712af6" class="grViz html-widget" style="width:100%;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-3d0c02f0201631712af6">{"x":{"diagram":"digraph {\n\ngraph [layout = \"neato\",\n       outputorder = \"edgesfirst\",\n       bgcolor = \"white\",\n       label = \"test\",\n       labelloc = \"t\",\n       labeljust = \"c\",\n       fontname = \"Helvetica\",\n       fontcolor = \"gray30\"]\n\nnode [fontname = \"Helvetica\",\n      fontsize = \"10\",\n      shape = \"circle\",\n      fixedsize = \"true\",\n      width = \"0.5\",\n      style = \"filled\",\n      fillcolor = \"aliceblue\",\n      color = \"gray70\",\n      fontcolor = \"gray50\"]\n\nedge [fontname = \"Helvetica\",\n     fontsize = \"8\",\n     len = \"1.5\",\n     color = \"gray80\",\n     arrowsize = \"0.5\"]\n\n  \"1\" [label = \"dense_1\nDense\nlinear\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,5!\"] \n  \"2\" [label = \"dense_2\nDense\nlinear\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,4!\"] \n  \"3\" [label = \"dense_3\nDense\nrelu\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,3!\"] \n  \"4\" [label = \"dropout_1\nDropout\nNA\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,2!\"] \n  \"5\" [label = \"dense_4\nDense\nsigmoid\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,1!\"] \n  \"1\"->\"2\" \n  \"2\"->\"3\" \n  \"3\"->\"4\" \n  \"4\"->\"5\" \n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->

Add some more layers and plot

``` r
model <- keras_model_sequential() %>%
  layer_dense(10, input_shape = 4) %>%
  layer_dense(25, input_shape = 4) %>%
  layer_dense(25, input_shape = 4, activation = "relu") %>%
  layer_dropout(0.25) %>%
  layer_dense(2, activation = "sigmoid")

model %>% plot_model()
```

<!--html_preserve-->

<div id="htmlwidget-5042dd9b599f2b4cccd5" class="grViz html-widget" style="width:100%;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-5042dd9b599f2b4cccd5">{"x":{"diagram":"digraph {\n\ngraph [layout = \"neato\",\n       outputorder = \"edgesfirst\",\n       bgcolor = \"white\",\n       label = \"test\",\n       labelloc = \"t\",\n       labeljust = \"c\",\n       fontname = \"Helvetica\",\n       fontcolor = \"gray30\"]\n\nnode [fontname = \"Helvetica\",\n      fontsize = \"10\",\n      shape = \"circle\",\n      fixedsize = \"true\",\n      width = \"0.5\",\n      style = \"filled\",\n      fillcolor = \"aliceblue\",\n      color = \"gray70\",\n      fontcolor = \"gray50\"]\n\nedge [fontname = \"Helvetica\",\n     fontsize = \"8\",\n     len = \"1.5\",\n     color = \"gray80\",\n     arrowsize = \"0.5\"]\n\n  \"1\" [label = \"dense_5\nDense\nlinear\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,5!\"] \n  \"2\" [label = \"dense_6\nDense\nlinear\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,4!\"] \n  \"3\" [label = \"dense_7\nDense\nrelu\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,3!\"] \n  \"4\" [label = \"dropout_2\nDropout\nNA\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,2!\"] \n  \"5\" [label = \"dense_8\nDense\nsigmoid\", shape = \"rectangle\", fillcolor = \"#F0F8FF\", fontcolor = \"#000000\", pos = \"0,1!\"] \n  \"1\"->\"2\" \n  \"2\"->\"3\" \n  \"3\"->\"4\" \n  \"4\"->\"5\" \n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->

## plot\_deepviz()

### Logistic regression:

``` r
c(4, 1) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

### One hidden layer:

``` r
c(4, 10, 1) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

### A multi-layer perceptron (two hidden layers):

``` r
c(4, 10, 10, 1) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

### Multi-class classification

``` r
c(4, 10, 10, 3) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-8-1.png" width="100%" />
