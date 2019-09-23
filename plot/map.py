import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import mplleaflet

fig, ax = plt.subplots(figsize=(8,8))
ax.plot(df.Longitude, df.Latitude, 'bo', color = 'red')
mplleaflet.display(fig=fig)