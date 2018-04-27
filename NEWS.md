# altair 0.1.9000

* makes Vega datasets available as `vega_data` (#25)

* significant changes to the rendering function `vegalite()`:

  * if the `embed` argument is `NULL`, `vegalite()` sets it to `getOption("altair.embed_options")` - if that is not defined, the vega-embed defaults are used

  * `width` and `height` arguments to `vegalite()` are used now to specify the *total* width and height of rendered charts - notes: (1) this is effective only for single-view charts, (2) `width` and `height` apply to the chart only, they do not take into account any action-links - if arguments are not set, the size of the chart is determined from the chart specification (#18)

  * `vegalite()` strips the `style` attribute from the `<div/>` for the htmlwidget - this has the effect of letting the rendered Vega-Lite chart determine the size of its container (#16, #18)

* adds concatenation operators for charts: `|`, `&`, `+` (#22, @aliciaschep)

* adds function `vega_embed()`, with friend `only_actions()`, to support embedding options in `vegalite()` (#16)

* updates css for embedding, makes the action-links look much better (#20, @aliciaschep)

* adds tooltip-capability to `vegalite()` renderer, with functions `vega_tooltip()`, `add_fields()`, and friends: `vega_tooltip_encoding()` and `vega_tooltip_all()` (#4, @aliciaschep) 
 
* adds a `NEWS.md` file to track changes to the package

* achieves minimal functionality
