
model_to_dataframe <- function(x){
  jsonlite::fromJSON(keras::model_to_json(x))[["config"]]
}



is.keras <- function(x){
  inherits(x, "keras.engine.training.Model")
}

# Create node data frame from keras model
#' @importFrom DiagrammeR create_node_df create_edge_df
#' @importFrom assertthat assert_that
model_nodes <- function(x){
  assert_that(is.keras(x))
  df <- model_to_dataframe(x)
  with(
    df,
    create_node_df(
      n = nrow(df),
      name = config$name,
      type = class_name,
      label = glue::glue("{config$name}\n{class_name}\n{config$activation}"),
      shape = "rectangle",
      activation = config$activation,
      x = 1,
      y = seq_len(nrow(df))
    )
  )
}

# The input x must be a nodes df
model_edges <- function(x){
  assert_that(is.data.frame(x))
  z <- embed(x$id, dimension = 2)
  create_edge_df(
    from = z[, 2],
    to = z[, 1]
  )
}


#' Plot keras model
#'
#' @param model A keras model defined using [keras::keras_model_sequential]
#'
#' @importFrom DiagrammeR create_graph render_graph
#'
#' @export
#' @example inst/examples/example_plot_model.R
plot_model <- function(model){

  nodes_df <- model_nodes(model)
  edges_df <- model_edges(nodes_df)

  graph <- DiagrammeR::create_graph(nodes_df, edges_df)
  graph <- DiagrammeR::set_node_attrs(graph, "fixedsize", FALSE)

  DiagrammeR::render_graph(
    graph,
    layout = "tree",
    output = "graph"
  )
}


