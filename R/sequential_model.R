# Computes nodes and edges for Keras sequential model

model_to_dataframe <- function(x){
  jsonlite::fromJSON(keras::model_to_json(x))[["config"]]
}



# Create node data frame from keras model
#' @importFrom DiagrammeR create_node_df create_edge_df
#' @importFrom assertthat assert_that
model_nodes_sequential <- function(x){
  assert_that(is.keras_model(x))
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
model_edges_sequential <- function(ndf){
  assert_that(is.data.frame(ndf))
  z <- embed(ndf$id, dimension = 2)
  create_edge_df(
    from = z[, 2],
    to = z[, 1]
  )
}


plot_model_sequential <- function(model, ...){

  nodes_df <- model_nodes_sequential(model)
  edges_df <- model_edges_sequential(nodes_df)

  graph <- DiagrammeR::create_graph(nodes_df, edges_df)
  graph <- DiagrammeR::set_node_attrs(graph, "fixedsize", FALSE)

  DiagrammeR::render_graph(
    graph,
    layout = "tree",
    output = "graph"
  )
}



