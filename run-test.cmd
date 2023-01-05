@echo off
for %%x in (
    gt-coverage
    gt-cql
    gt-epsg-extension
    gt-epsg-hsql
    gt-epsg-wkt
    gt-geojson
    gt-geotiff
    gt-http
    gt-jdbc
    gt-main
    gt-metadata
    gt-opengis
    gt-referencing
    gt-render
    gt-sample-data
    gt-shapefile
    gt-xml
) do (
    @echo # %%x
    java -p .\%%x\target\dependency\ -m de.turnertech.geotools/de.turnertech.geotools.main.Application
    jdeps --generate-module-info .\module-info --multi-release base --module-path .\%%x\target\dependency\ .\%%x\target\dependency\%%x-29-SNAPSHOT.jar
    jdeps --generate-module-info .\module-info --multi-release 11 --module-path .\%%x\target\dependency\ .\%%x\target\dependency\%%x-29-SNAPSHOT.jar
)