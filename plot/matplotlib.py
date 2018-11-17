'''
https://www.datacamp.com/community/tutorials/matplotlib-tutorial-python
https://github.com/matplotlib/AnatomyOfMatplotlib/blob/master/AnatomyOfMatplotlib-Part1-Figures_Subplots_and_layouts.ipynb

Figure is the overall window everything is drawn on. It is at the top level.
Axes are added to figure. It contains dots, lines, legends, titles, etc.

Functions in matplotlib.pyplot actually calls functions in ax. There are equivalents in pyplot and ax.
Functions in pyplot is usually cleaner and hence preferred in simple cases.
By PEP20, "Explicit is better than implicit", the more explicit ax is preferred.
pylab bulk imports pyplot and numpy. It is not recommended in IPython.

fig.add_subplot vs. fig.add_axes
In add_axes the position of left bottom of the plot, width and height are provided as a lenght 4 list.
In add_subplot, the orientation of subplots are specified. Eg. # rows, # columns, which plot is this in the grid.

Gallery
https://matplotlib.org/gallery.html

'''

# Quick Start Guide

# add `%matplotlib inline` in Jupyter for inline plots
# Import the necessary packages and modules
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(111)
# or equivalently
# fig, ax = plt.subplots()
ax.set(xlim=[0.5, 4.5], ylim=[-2, 8], title='An Example Axes',
       ylabel='Y-Axis', xlabel='X-Axis')
plt.show()
