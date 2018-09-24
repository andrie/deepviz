

#' Plot keras model
#'
#' @param model A keras model defined using [keras::keras_model_sequential] or [keras::keras_model]
#' @param ... not used
#'
#' @importFrom DiagrammeR create_graph render_graph
#'
#' @export
#' @example inst/examples/example_network.R
#' @example inst/examples/example_network.R
#' @example inst/examples/example_depthwise_separable.R
plot_model <- function(model, ...){
  UseMethod("plot_model", model)
}


# plot_model.default <- function(model, ...){
#   if (is.keras_model_sequential(model))
#     plot_model_sequential(model, ...)
#   else
#     plot_model_network(model, ...)
# }


#' @export
plot_model.keras.engine.sequential.Sequential <- function(model, ...){
    plot_model_sequential(model, ...)
}


#' @export
plot_model.keras.engine.training.Model <- function(model, ...){
  if (is.keras_model_sequential(model))
    plot_model_sequential(model, ...)
  else
    plot_model_network(model, ...)
}

