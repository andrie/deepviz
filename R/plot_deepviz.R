make_node_name <- function(level, label){
  paste("l", level, label, sep = "_")
}


#' @importFrom purrr map_dfr
#' @importFrom dplyr tibble mutate select left_join rename
#' @importFrom magrittr %>%
make_nodes_df <- function(n){

  map_dfr(
    seq_along(n),
    function(i){
      label = seq_len(n[i])
      tibble(
        label = label %>% as.character(),
        node = make_node_name(i, label)
      )
    }
  ) %>%
    mutate(
      id = seq_along(node),
      type = NA,
    ) %>%
    select(id, type, label, node)
}


globalVariables(c("to", "from", "id", "node", "type", "label"))


#' @importFrom stats embed na.omit
make_edges_df <- function(n, nodes = make_nodes_df(n)){

  embedded_nodes <- n %>%
    embed(dimension = 2) %>%
    .[, c(2, 1)] %>%
    matrix(ncol = 2)

  map_dfr(seq_len(length(n) - 1), function(i){
    level <-  i
    emb <- embedded_nodes[i, ]
    from <-  rep(seq_len(emb[1]), each = emb[2])
    to <-  rep(seq_len(emb[2]), emb[1])
    tibble(
      from = make_node_name(level, from),
      to = make_node_name(level + 1, to)
    )
  }) %>%
    left_join(nodes, by = c("from" = "node")) %>%
    select(to, id) %>%
    rename(from = id) %>%
    left_join(nodes, by = c("to" = "node")) %>%
    select(from, id) %>%
    rename(to = id)
}



layout_keras <- function(graph, n_nodes){
  positions <- map_dfr(seq_along(n_nodes), function(i){
    max_nodes <- max(n_nodes)
    layers <- length(n_nodes)
    data.frame(
      x = seq_len(n_nodes[i]) / (n_nodes[i] + 1) * layers,
      y = length(n_nodes) - i
    )
  })
  ggraph::create_layout(graph, layout = "manual", node.positions = positions, circular = FALSE)
}

globalVariables(c("."))


#' Plot deepviz
#'
#' @param n A numeric vector with an element for each layer that indicates the number of nodes in that layer.
#'
#' @importFrom tidygraph tbl_graph
#' @importFrom ggraph ggraph geom_edge_diagonal0 geom_node_circle
#' @importFrom ggplot2 coord_fixed theme_void aes
#'
#' @export
#' @example inst/examples/example_plot_deepviz.R
plot_deepviz <- function(n){
  nodes <- make_nodes_df(n)
  edges <- make_edges_df(n)

  tidygraph::tbl_graph(nodes = nodes, edges = edges) %>%
    ggraph(layout = "manual", node.position = layout_keras(., n)) +
    geom_edge_diagonal0(edge_colour = "grey50") +
    geom_node_circle(aes(r = 0.1), fill = "orange") +
    coord_fixed() +
    theme_void()
}
