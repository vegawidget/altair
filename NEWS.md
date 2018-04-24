# altair 0.1.9000

* `width` and `height` arguments to `vegalite()` are used now to specify the *total* width and height of rendered charts - notes: (1) this is effective only for single-view charts, (2) `width` and `height` apply to the chart only, they do not take into account any action-links (#18)

* `vegalite()` renderer strips the `style` attribute from the `<div/>` for the htmlwidget - this has the effect of letting the rendered Vega-Lite chart determine the size of its container (#16, #18)

* adds function `vega_embed()`, with friend `only_actions()`, to support embedding options in `vegalite()` (#16)

* updates css for embedding, makes the action-links look much better (#20, @aliciaschep)

* adds tooltip-capability to `vegalite()` renderer, with functions `vega_tooltip()`, `add_fields()`, and friends: `vega_tooltip_encoding()` and `vega_tooltip_all()` (#4, @aliciaschep) 
 
* adds a `NEWS.md` file to track changes to the package

* achieves minimal functionality
