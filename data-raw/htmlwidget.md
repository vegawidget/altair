htmlwidgets lib files
================

The purpose of this document is to download the javascript files for
Vega and Vega-Lite.

``` r
library("httr")
library("rprojroot")
library("tibble")
library("purrr")
library("readr")
```

Let’s establish the root directory to which the files will be
downloaded.

``` r
lib_dir <- file.path(find_package_root_file(), "inst", "htmlwidgets", "lib")
```

Let’s establish the files we will download, and where we will download
them to.

Here’s a [reference](https://vega.github.io/vega/usage/#ie) to a
solution to the promise-and-symbol issue that Alicia Schep brought up.

As of 2015-05-06, the most current versions are:

  - vega 3.3.1 [link](https://www.jsdelivr.com/package/npm/vega)
  - vega-lite 2.4.3
    [link](https://www.jsdelivr.com/package/npm/vega-lite)
  - vega-embed 3.9.0
    [link](https://www.jsdelivr.com/package/npm/vega-embed)

<!-- end list -->

``` r
downloads <-
  tribble(
    ~path_local,                         ~path_remote,
    "vega/promise.min.js",               "https://vega.github.io/vega/assets/promise.min.js",
    "vega/symbol.min.js",                "https://vega.github.io/vega/assets/symbol.min.js",
    "vega/vega.js",                      "https://cdn.jsdelivr.net/npm/vega@3.3.1/build/vega.js",
    "vega/LICENSE",                      "https://raw.githubusercontent.com/vega/vega/master/LICENSE",
    "vega-lite/vega-lite-min.js",        "https://cdn.jsdelivr.net/npm/vega-lite@2.4.3",
    "vega-lite/LICENSE",                 "https://raw.githubusercontent.com/vega/vega-lite/master/LICENSE",
    "vega-embed/vega-embed.js",          "https://cdn.jsdelivr.net/npm/vega-embed@3.9.0",
    "vega-embed/LICENSE",                "https://raw.githubusercontent.com/vega/vega-embed/master/LICENSE"
  )
```

Let’s write a function that will download such a file.

``` r
get_file <- function(path_local, path_remote, lib_dir) {
  
  path_local <- file.path(lib_dir, path_local)
  
  resp <- httr::GET(path_remote)
  
  text <- httr::content(resp, type = "text", encoding = "UTF-8")
  
  readr::write_file(text, path_local)
  
  invisible(NULL)
}
```

``` r
pwalk(downloads, get_file, lib_dir = lib_dir)
```

We also have to write out a yaml manifest. It might be an idea to
automate this, as well.

``` r
vega_embed_path <- file.path(lib_dir, "vega-embed/vega-embed.js")
vega_embed <- readr::read_file(vega_embed_path)

vega_mod <- stringr::str_replace_all(vega_embed, 'head>"','he"+"ad>"') 
vega_mod <- stringr::str_replace_all(vega_mod, '"<\\/head>','"</he"+"ad>') 

readr::write_file(vega_mod,file.path(lib_dir, "vega-embed/vega-embed-modified.js"))
system(paste0("rm ", vega_embed_path))
```
