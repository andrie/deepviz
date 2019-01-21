

#' Plot keras model
#'
#' @param model A keras model defined using [keras::keras_model_sequential] or [keras::keras_model]
#' @param ... not used
#'
#' @importFrom DiagrammeR create_graph render_graph
#'
#' @export
#' @example inst/examples/example_sequential_and_network.R
plot_model <- function(model, ...){
  UseMethod("plot_model", model)
}

globalVariables(c(".", "V1", "V2", "x"))


#' @export
plot_model.keras.engine.training.Model <- function(model, ...){

  nodes_df <- model_nodes(model)
  if (is.keras_model_sequential(model))
    edges_df <- model_edges_sequential(nodes_df)
  else
    edges_df <- model_edges_network(model, nodes_df)

  graph <- DiagrammeR::create_graph(nodes_df, edges_df)
  graph <- DiagrammeR::set_node_attrs(graph, "fixedsize", FALSE)
  graph <- DiagrammeR::set_node_attrs(graph, "nodesep", 2)

  coords <- local({
    (DiagrammeR::to_igraph(graph) %>%
       igraph::layout_with_sugiyama())[[2]] %>%
      dplyr::as_tibble() %>%
      dplyr::rename(
        x = V1,
        y = V2
      ) %>%
      dplyr::mutate(x = 1.5 * x)
  })

  graph$nodes_df <- graph$nodes_df %>%
    dplyr::bind_cols(coords)

  DiagrammeR::render_graph(graph)
}

