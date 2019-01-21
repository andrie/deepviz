# Create node data frame from keras model
#' @importFrom DiagrammeR create_node_df create_edge_df
#' @importFrom assertthat assert_that
#' @importFrom glue glue
#'
model_nodes <- function(x){
  assert_that(is.keras_model(x))
  if (is.keras_model_sequential(x)) {
    model_layers <- x$get_config()$layers
    l_name <- map_chr(model_layers, ~purrr::pluck(., "config", "name"))
  } else {
    model_layers <- x$get_config()$layers
    l_name <- model_layers %>% map_chr("name")
  }
  l_type <- model_layers %>% map_chr("class_name")

  l_activation <- model_layers %>%
    map_chr(
      ~(purrr::pluck(., "config", "activation") %||% "")
    )

  create_node_df(
    n = length(model_layers),
    name = l_name,
    type = l_type,
    label = glue::glue("{l_name}\n{l_type}\n{l_activation}"),
    shape = "rectangle",
    activation = l_activation
  )
}

