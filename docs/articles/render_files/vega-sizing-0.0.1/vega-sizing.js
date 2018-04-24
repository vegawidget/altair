/* An attempt to write a couple of functions that:
 *
 * - given an element, return the width and height of the svg or canvas
 *   element within it.
 *
 * - given an element and a width and height, set the styling of the
 *   element so that it has that width and height.
 *
 * Ian Lyttle (in case you are wondering who would write such a monstrosity)
 */

var vega_widget_size = function(el) {
  var canvas = el.find("canvas");
  console.log(canvas);
};
