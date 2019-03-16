# Computes nodes and edges for Keras sequential model

`%||%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
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


#' @importFrom purrr map map_chr imap_dfr
inbound_nodes <- function(model){
  assert_that(is.keras_model_network(model))
  model_layers <- model$get_config()$layers
  inbound <- map(
    model_layers,
    function(x){
      if (length(x$inbound_nodes) == 1) {
        x$inbound_nodes[[1]] %>% map_chr(c(1, 1))
      } else if(length(x$inbound_nodes) > 1) {
        # needed for shared layers
        x$inbound_nodes %>% map_chr(c(1, 1))
      } else {
        NA
      }
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
