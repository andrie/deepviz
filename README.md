
<!-- README.md is generated from README.Rmd. Please edit that file -->

# deepviz

The goal of deepviz is to visualize (simple) neural network
architectures.

## Installation

``` r
devtools::install_github("andrie/deepviz")
```

## Example

``` r
library(deepviz)
library(magrittr)
```

### Logistic regression:

``` r
c(4, 1) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

### One hidden layer:

``` r
c(4, 10, 1) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

### A multi-layer perceptron (two hidden layers):

``` r
c(4, 10, 10, 1) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

### Multi-class classification

``` r
c(4, 10, 10, 3) %>% 
  plot_deepviz()
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />
