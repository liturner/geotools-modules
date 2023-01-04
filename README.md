# GeoTools Modules

This is a testing toolset for helping to analyse and improve the GeoTools java module readiness.

The aim is to have a few tests which ensure that end users can somewhat effectively use the java module system. The tests can then be used to help prevent regression and generally help GeoTool take a stepped approach to being prepared for the Module system.

## What are the Tests?

Initially, each of the single "gt-" maven artefacts will be added as a dependency to their own Java 11 project. A few basic, but common java module commands will then be executed on the complete set of downloaded dependencies. This is an effective smoke test for identifying problems with the automatically named modules.

1. jar --file=gt-render-28.0.jar --describe-module
2. jdeps --generate-module-info . --multi-release base --module-path .\dependency\ .\dependency\gt-http-28-SNAPSHOT.jar

At current, the second test fails every time, while the first test fails on a few modules.