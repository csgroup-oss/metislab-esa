# Copyright 2020 CS GROUP - France, http://www.c-s.fr
# All rights reserved
import os

from mpl_toolkits import basemap
import cartopy
import cv2
import eodag
import fiona
import folium
import gdal2tiles
import geojson
import geopandas
import geopy
import ipyleaflet
import ipyvolume
import mapboxgl
import owslib
import pysolar
import rasterio
import rasterstats
import rio_cogeo
import rioxarray
import rtree
import shapely
import spatialpandas
import stl
import xrspatial


# Test NetCDF writing with rasterio
import numpy as np
import xarray as xr
import rasterio as rio
ds = xr.Dataset({'x': (('col', 'row'), np.random.rand(500, 500))},coords={'col':range(500), 'row':range(500)})
ds.to_netcdf("/tmp/fake_ds.nc")


# Test eodag
from eodag import EODataAccessGateway

dag = EODataAccessGateway()
