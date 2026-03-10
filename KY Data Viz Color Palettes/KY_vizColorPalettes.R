# color_palette.R
# Complete Color Palette System for R
# WCAG-optimized with text color recommendations

library(tibble)
library(dplyr)
library(purrr)

# ----------------------------------------------------------------------
# 1. COLOR DETAILS WITH METADATA
# ----------------------------------------------------------------------

color_details <- tibble::tribble(
  ~color, ~name, ~cat, ~text_color,

  # Primary Colors
  "#62bcf0", "KY Sky Blue", "primary", "#000000",
  "#c7e072", "Pale Milkweed Yellow-Green", "primary", "#000000",
  "#4c6dc1", "Wild Indigo Blue", "primary", "#ffffff",
  "#012a5c", "Grosbeak Navy", "primary", "#ffffff",
  "#a572b2", "Coneflower Purple", "primary", "#000000",
  "#28655a", "Deep River Teal", "primary", "#ffffff",
  "#76933c", "Leaf Green", "primary", "#000000",
  "#b0d7ed", "Pale Moon Blue", "primary", "#000000",

  # Suppressed & Null Colors
  "#ebebeb", "Pearl Grey (suppressed)", "suppressed", "#000000",
  "#a4a4a4", "Deep Grey (suppressed)", "suppressed", "#000000",
  "#e3e1d3", "Threshold Greige", "null", "#000000",

  # Secondary - Yellow-Greens
  "#e8f3c0", "Lightest Yellow-Green", "secondary", "#000000",
  "#c8dd86", "Pale Yellow-Green", "secondary", "#000000",
  "#abc465", "Medium Yellow-Green", "secondary", "#000000",
  "#90ac4e", "Yellow-Green", "secondary", "#000000",
  "#9ec371", "Light Leaf Green", "secondary", "#000000",
  "#74a76f", "Medium Green", "secondary", "#000000",
  "#468c6c", "Medium Teal", "secondary", "#ffffff",

  # Secondary - Purples
  "#ede2ef", "Lightest Pale Purple", "secondary", "#000000",
  "#dbc5e0", "Light Pale Purple", "secondary", "#000000",
  "#ac94c6", "Medium Pale Purple", "secondary", "#000000",
  "#c9a9d1", "Pale Purple", "secondary", "#000000",
  "#f4e2f8", "Lightest Purple", "secondary", "#000000",
  "#e9c5f1", "Light Purple", "secondary", "#000000",
  "#b78dc1", "Medium Purple", "secondary", "#000000",

  # Secondary - Indigos & Blues
  "#b2a9d5", "Lightest Pale Indigo", "secondary", "#000000",
  "#878dca", "Pale Indigo", "secondary", "#000000",
  "#5673be", "Medium Indigo", "secondary", "#ffffff",
  "#b5b6da", "Pale Blue-Purple", "secondary", "#000000",
  "#c2d6ed", "Lightest Pale Blue-Purple", "secondary", "#000000",
  "#e5f3fa", "Lightest Pale Blue", "secondary", "#000000",
  "#dcf3ff", "Light Pale Blue", "secondary", "#000000",
  "#5e97d6", "Medium Sky Blue", "secondary", "#ffffff"
)

# Create lookup functions
color_lookup <- function(hex) {
  idx <- which(color_details$color == hex)
  if (length(idx) > 0) {
    return(as.list(color_details[idx, ]))
  } else {
    return(list(color = hex, name = "Unknown", cat = "unknown", text_color = "#000000"))
  }
}

# ----------------------------------------------------------------------
# 2. PALETTE DEFINITIONS
# ----------------------------------------------------------------------

# Categorical Palettes
categorical_palettes <- list(
  "8 Categorical" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#a572b2", "#012a5c", "#76933c", "#b0d7ed"),
  "7 Categorical + Grey" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#a572b2", "#012a5c", "#76933c", "#ebebeb"),
  "7 Categorical" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#a572b2", "#012a5c", "#76933c"),
  "6 Categorical + Grey" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#a572b2", "#012a5c", "#ebebeb"),
  "6 Categorical" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#a572b2", "#012a5c"),
  "5 Categorical + Grey" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#a572b2", "#ebebeb"),
  "5 Categorical" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#a572b2"),
  "4 Categorical + Grey" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a", "#ebebeb"),
  "4 Categorical" = c("#62bcf0", "#c7e072", "#4c6dc1", "#28655a"),
  "3 Categorical + Grey" = c("#62bcf0", "#c7e072", "#4c6dc1", "#ebebeb"),
  "3 Categorical" = c("#62bcf0", "#c7e072", "#4c6dc1")
)

# Sequential Palettes
sequential_palettes <- list(
  "5-Color Sequential (blue)" = c("#e5f3fa", "#b0d7ed", "#62bcf0", "#5e97d6", "#5673be"),
  "5-Color Sequential (yellow-green)" = c("#e8f3c0", "#c8dd86", "#abc465", "#90ac4e", "#76933c"),
  "5-Color Sequential (purple)" = c("#ede2ef", "#dbc5e0", "#c9a9d1", "#b78dc1", "#a572b2"),
  "5-Color Sequential (multi-hue blue-purple)" = c("#dcf3ff", "#c2d6ed", "#b5b6da", "#ac94c6", "#a572b2"),
  "5-Color Sequential (multi-hue green)" = c("#e8f3c0", "#c7e072", "#9ec371", "#74a76f", "#468c6c"),
  "5-Color Sequential (multi-hue purple-blue)" = c("#ede2ef", "#dbc5e0", "#b2a9d5", "#878dca", "#5673be")
)

# Diverging Palettes
diverging_palettes <- list(
  "7-Color Diverging (blue & yellow-green)" = c("#5e97d6", "#62bcf0", "#b0d7ed", "#e3e1d3", "#e8f3c0", "#c7e072", "#76933c"),
  "7-Color Diverging (green & purple)" = c("#76933c", "#c7e072", "#e8f3c0", "#e3e1d3", "#f4e2f8", "#e9c5f1", "#a572b2"),
  "6-Color Diverging (blue & yellow-green)" = c("#5e97d6", "#62bcf0", "#b0d7ed", "#e8f3c0", "#c7e072", "#76933c"),
  "6-Color Diverging (green & purple)" = c("#76933c", "#c7e072", "#e8f3c0", "#f4e2f8", "#e9c5f1", "#a572b2")
)

# Dual-Color Palettes
dual_palettes <- list(
  "2 Category (Blues)" = c("#62bcf0", "#012a5c"),
  "2 Category (Purple Blue)" = c("#a572b2", "#012a5c"),
  "Indigo Highlight" = c("#4c6dc1", "#e3e1d3"),
  "Purple Highlight" = c("#a572b2", "#e3e1d3")
)

# Null & Suppressed Colors
null_suppressed_palettes <- list(
  "Suppressed & Null Values" = c("#ebebeb", "#a4a4a4", "#e3e1d3")
)

# Combine all palettes
all_palettes <- list(
  categorical = categorical_palettes,
  sequential = sequential_palettes,
  diverging = diverging_palettes,
  dual = dual_palettes,
  null_suppressed = null_suppressed_palettes
)

# ----------------------------------------------------------------------
# 3. HELPER FUNCTIONS
# ----------------------------------------------------------------------

#' Get color information by hex code
#' @param hex Character. Hex color code (e.g., "#62bcf0")
#' @return List with color details
get_color_info <- function(hex) {
  color_lookup(hex)
}

#' Get a palette by name
#' @param type Character. One of "categorical", "sequential", "diverging", "dual", "null_suppressed"
#' @param name Character. Name of the palette
#' @return Character vector of hex colors
get_palette <- function(type, name) {
  if (type %in% names(all_palettes)) {
    palettes <- all_palettes[[type]]
    if (name %in% names(palettes)) {
      return(palettes[[name]])
    } else {
      warning("Palette '", name, "' not found in type '", type, "'")
      return(NULL)
    }
  } else {
    warning("Palette type '", type, "' not found. Available types: ",
            paste(names(all_palettes), collapse = ", "))
    return(NULL)
  }
}

#' Get colors by category
#' @param category Character. One of "primary", "secondary", "suppressed", "null"
#' @return Tibble of colors in that category
get_colors_by_category <- function(category) {
  color_details %>%
    filter(cat == category)
}

