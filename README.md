<!-- badges: start -->

[![Build Status](https://travis-ci.com/egarx/GeomHurricane.svg?branch=main)](https://travis-ci.com/egarx/GeomHurricane)

<!-- badges: end -->


# Geom for Hurricanes

The purpose of this exercise is to build a new geom using grid and
ggplot2 packages to facilitate in visualizing hurricane winds on a
map.

## Hurricanes

Hurricanes can have asymmetrical wind fields, with much higher winds on
one side of a storm compared to the other. Hurricane wind radii report
how far winds of a certain intensity (e.g., 34, 50, or 64 knots)
extended from a hurricane’s center, with separate values given for the
northeast, northwest, southeast, and southwest quadrants of the storm.
The 34 knot radius in the northeast quadrant, for example, reports the
furthest distance from the center of the storm of any location that
experienced 34-knot winds in that quadrant.

This wind radii data provide a clearer picture of the storm structure
than the simpler measurements of a storm’s position and maximum winds.
For example, if a storm was moving very quickly, the forward motion of
the storm might have contributed significantly to wind speeds to the
right of the storm’s direction of forward motion, and wind radii might
be much larger for the northeast quadrant of the storm than the
northwest quadrant.

### Data

One of the functions in this package allow us to import raw Extended
Best Track (EBTRK) data. The example data has 29 variables and 11,824 rows. 
The data had to be cleaned and tidey in onder to fill a data table to feed 
the coded functions. You can see this work at the 
file ~/R/Hurricana_Project_Geom_Data.R.

### How the Library Works on Ike 2008

Here is an example of the wind radii chart for Hurricane Ike 2008 during its lanfall and
an animation of its trayectory. You can see this work at the 
file ~/R/Hurricana_Project_Geom.R.


![](Figures/Ike_example.png!<!-- -->


Here you can appreciate the trayectory of this hurricane


![]( Figures/Ike_example.gif)<!-- -->
