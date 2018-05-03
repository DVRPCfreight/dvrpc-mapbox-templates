# DVRPC Vector Tilesets

## dvrpc-municipal

### MCD Boundaries
__layer__: municipalities

shp to geojson- `ogr2ogr -f "GeoJSON" -t_srs "EPSG:4326" -lco "COORDINATE_PRECISION=5" -overwrite -sql "SELECT CO_NAME as cty, MUN_NAME as name, MUN_LABEL as label, STATE as state from mun_boundaries" municipal.geojson mun_boundaries.shp`

generate MbTiles - `tippecanoe -o municipal.mbtiles -l municipalities -d -f -pf -pt municipal.geojson`

_metadata_
Field | Value |  
--- | ---
name | municipal name
cty | county name
label | DVRPC defined label value
state | state code (PA/NJ)


### County Boundaries
__layer__: county

`ogr2ogr -f "GeoJSON" -t_srs "EPSG:4326" -lco "COORDINATE_PRECISION=5" -overwrite -sql "SELECT CO_NAME as name, DVRPC_REG as dvrpc, STATE as state from county_28" county.geojson county_28.shp`

generate MbTiles - `tippecanoe -o county.mbtiles -l county -d -f -pf -pt county.geojson`

_metadata_
Field | Value |  
--- | ---
name | county name
state | state code (PA/NJ)
dvrpc | DVRPC 9 or 28 (Yes/No)

### Joining Tileset

`tile-join -n dvrpc_boundaries -f -o dvrpc_boundaries.mb_tiles county.mbtiles municipal.mbtiles`