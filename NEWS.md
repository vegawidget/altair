# altair 4.2.2

* Update case-study vignette to allow for more than 5000 rows. (#159)

* Update signatures of `repr_text()` and `repr_vegalite4()` to align with signatures of their generics. (#158)

# altair 4.2.1

* Upgrade to [vegawidget](https://vegawidget.github.io/vegawidget/) 0.4.1. (#150, #154)

* Upgrade to [Altair](https://altair-viz.github.io/) 4.2.0. (#148)

* Bump version for development

# altair 4.1.1

* Upgrade to Altair 4.1.0

* Re-export `vegawidget::vw_set_base_url()`, sets default base URL when rendering specs.

# altair 4.0.1

* Upgrade to Altair 4.0.0

* Update `repr` methods to include top-level Altair class. (#127)

# altair 3.1.1

* Deprecate `vw_as_json()`, `vegawidgetOutput()`, `renderVegawidget()`; these are available in the **vegawidget** package. (#117)

* Remove references to `r_to_py()`, as **reticulate** manages this automatically. (#83)

* Update the JupyterLab renderers to Vega-Lite 3

* Upgrade to Altair 3.1.0

# altair 2.3.0.1

* updates the image-functions from vegawidget

# altair 2.3.0

* upgrades to Altair 2.3.0

# altair 2.2.2.2

* updates exports from vegawidget

# altair 2.2.2.1

* adds methods `repr_text()` and `repr_vegalite2()` methods for Altair chart objects, allowing them to be rendered natively in Jupyter notebooks using IRKernel (https://irkernel.github.io) (#91, with @flying-sheep).

* imports `vw_rename_datasets()` from vegawidget

# altair 2.2.2.0

* new versioning system: first three version numbers follow supported Altair (Python) version

* updates to use Altair 2.2.2

# altair 0.0.6

* adds `altair_version()`, returns list of versions used for Altair, Vega, Vega-Lite, etc.

* adds `as_chart()`, to import a vegaspec as an Altair chart
 
* removes rendering functions in favor of a separate package, [**vegawidget**](https://github.com/vegawidget/vegawidget) - vegawidget functions imported and exported using templating function `vegawidget::use_vegawidget()`.

* adds requirement to use reticulate (>=) 1.9, to avoid conflict between data-frame variable-names and python methods (#50, @aliciaschep) and to remove the need to use the `r_to_py()` function for data (#83)

* updates to use Altair 2.1.0, which offers tooltips (#29, #46, @aliciaschep)

# altair 0.0.5

* adds `compiled` option to `only_actions()` to conform with new option in vega-embed (#71) 

* incorporates remaining galleries

# altair 0.0.4

* incorporates first gallery

# altair 0.0.3

* adapts examples gallery from Altair (#24, @haleyjeppson)

* updates articles and documentation (#32)

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
