# Computes nodes and edges for Keras Network model (from the keras functional API)



# Create node data frame from keras model
#' @importFrom DiagrammeR create_node_df create_edge_df
#' @importFrom assertthat assert_that
model_nodes_network <- function(x){
  # browser()
  assert_that(is.keras_model(x))
  df <- model_to_dataframe(x)$layers
  with(
    df,
    create_node_df(
      n = nrow(df),
      name = config$name,
      type = class_name,
      label = glue::glue("{config$name}\n{class_name}\n{config$activation}"),
      shape = "rectangle",
      activation = config$activation
      # x = 1,
      # y = seq_len(nrow(df))
    )
  )
}


#' @importFrom purrr map map_chr imap_dfr
inbound_nodes <- function(model){
  assert_that(is.keras_model_network(model))
  model_layers <- model$get_config()$layers
  inbound <- map(
    model_layers,
    function(x){
      if (length(x$inbound_nodes)) x$inbound_nodes[[1]] %>% map_chr(c(1, 1)) else NA
    }
  )
  names(inbound) <- map(model_layers, "name")
  z <- imap_dfr(
    inbound,
    ~ data.frame(to = .y, from = .x, stringsAsFactors = FALSE)
  )
  na.omit(z)[, c("from", "to")]
}


# The input x must be a nodes df
model_edges_network <- function(model, ndf){
  assert_that(is.keras_model_network(model))
  assert_that(is.data.frame(ndf))
  z <- inbound_nodes(model)
  z$from <- ndf$id[match(z$from, ndf$name)]
  z$to   <- ndf$id[match(z$to,   ndf$name)]
  z
}


plot_model_network <- function(model, ...){

  nodes_df <- model_nodes_network(model)
  edges_df <- model_edges_network(model, nodes_df)

  graph <- DiagrammeR::create_graph(nodes_df, edges_df)
  graph <- DiagrammeR::set_node_attrs(graph, "fixedsize", FALSE)
  graph <- DiagrammeR::set_node_attrs(graph, "nodesep", 2)

  DiagrammeR::render_graph(
    graph,
    layout = "tree",
    output = "graph"
  )
}
