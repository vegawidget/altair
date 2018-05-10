# altair 0.0.2.9000

* deprecates `vegalite()` in favor of `vegawidget()` (#48)

* provides methods for `knit_print()` and `print()` generics (#8)

* updates versions of JS libraries: vega 3.3.1, vega-lite 2.4.3, vega-embed 3.9.0 (#33) 

* removes tooltip functions (#45)

* updates `.onLoad()` to run `check_altair()` on loading, and adds error handling (#43, with @aliciaschep)

* updates travis.yml so that this package installs its supported version of Altair (#44)

* adds function `check_altair()` to check installed version against supported version (#42, with @aliciaschep)

* updates `install_altair()` (#41) 

* synchronizes with Altair v2.0.x (#36)

# altair 0.0.1.9000

* new function to manage installation of Altair Python package: `install_altair()` (#1)

* makes Vega datasets available through `import_vega_data()` (#25)

* significant changes to the rendering function `vegalite()`:

  * if the `embed` argument is `NULL`, `vegalite()` sets it to `getOption("altair.embed_options")` - if that is not defined, the vega-embed defaults are used

  * `width` and `height` arguments to `vegalite()` are used now to specify the *total* width and height of rendered charts - notes: (1) this is effective only for single-view charts, (2) `width` and `height` apply to the chart only, they do not take into account any action-links - if arguments are not set, the size of the chart is determined from the chart specification (#18)

  * `vegalite()` strips the `style` attribute from the `<div/>` for the htmlwidget - this has the effect of letting the rendered Vega-Lite chart determine the size of its container (#16, #18)

* adds concatenation operators for charts: `|`, `&`, `+` (#22, @aliciaschep)

* adds function `vega_embed()`, with friend `only_actions()`, to support embedding options in `vegalite()` (#16)

* updates css for embedding, makes the action-links look much better (#20, @aliciaschep)

* adds tooltip-capability to `vegalite()` renderer, with functions `vega_tooltip()`, `add_fields()`, and friends: `vega_tooltip_encoding()` and `vega_tooltip_all()` (#4, with @aliciaschep) 
 
* adds a `NEWS.md` file to track changes to the package

* achieves minimal functionality
