#!/bin/bash
# conversion and prep of the dvrpc_boundary shapefiles to vector tiles for publishing
# assumes all shapefiles are in the directory of the script

echo "Converting municipalities.."
ogr2ogr -f "GeoJSON" -t_srs "EPSG:4326" -lco "COORDINATE_PRECISION=5" -overwrite -sql "SELECT CO_NAME as cty, MUN_NAME as name, MUN_LABEL as label, STATE as state from mun_boundaries" municipal.geojson mun_boundaries.shp
tippecanoe -o municipal.mbtiles -l municipalities -d -f -pf -pt municipal.geojson

echo "Converting counties.."
ogr2ogr -f "GeoJSON" -t_srs "EPSG:4326" -lco "COORDINATE_PRECISION=5" -overwrite -sql "SELECT CO_NAME as name, DVRPC_REG as dvrpc, STATE as state from county_28" county.geojson county_28.shp
tippecanoe -o county.mbtiles -l county -d -f -pf -pt county.geojson

echo "Joining final tileset.."
tile-join -n dvrpc_boundaries -f -o dvrpc_boundaries.mb_tiles county.mbtiles municipal.mbtiles
