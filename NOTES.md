These are just some WIP notes which I intend to add to the geotools docs later.


# Using GeoTools in a named module

The Java Module system is very flexible, and very complex. It is not in the scope of this tutorial to explain the whole system. That said, the following hints assume that you intend to use GeoTools in your named module application so that can e.g. utilise jpackage, and you want to run your application as a pure module project, without a classpath using a launch command such as:

```java -p lib/ -m my.module/my.package.MyMainClass```

For a project as complex as GeoTools, the migration roadmap to using named modules is very long. Before the java module system can flawlessly function, every dependency (as well as their transient dependencies) must have implemented module-info files which fully describe the module, and its transitive dependencies. This is decades worth of work. Untill such a time, projects intending to use GeoTools will have to invest a little more time into understanding how the automatic module system works.

Skipping over a lot of information on the module system, the most important thing to know about the current state of the module system and any attempt to use GeoTools in your named module, is that automatically named modules do not include any "requires" or "requires transitive" declerations. For example:

With Maven and Java 8 you can add a dependency to gt-render to your project, knowing that gt-cql will automagically be downloaded too. Unfortunately the gt-render module does not specify a "requires" or "requires transitive" dependency to gt-cql in the java module world. If you use and functions in gt-render which have arguments or return types from gt-cql, then you will also have to require the cql module in your module-info.java.

## Identifying the Module Names

To identify the name of a particular module, download the .jar file (e.g. gt-cql-28.0.jar) and use the following command to get the module information:

```jar --file=gt-render-28.0.jar --describe-module```

This will give an output similar to:

No module descriptor found. Derived automatic module.

org.geotools.text.cql@28.0 automatic
requires java.base mandated
contains org.geotools.filter.text.commons
contains org.geotools.filter.text.cql2
contains org.geotools.filter.text.ecql
contains org.geotools.filter.text.generated.parsers

## Identifying Dependency Conflicts

If you are planning to use GeoTools in your named module project, you will need a script for analysing the entire contents of your maven dependency tree. For example, the following windows cmd file will generate a report for all jar files in a folder. This can be used for example in your projects "lib" folder to get an overview of which modules are exopsing which package

> module-report.txt (
	for %%f in (%~dp0*.jar) do (
		jar --file=%%f --describe-module
	)
)

## JDeps

jdeps --generate-module-info . --multi-release base --module-path .\dependency\ .\dependency\gt-http-28-SNAPSHOT.jar

## Being Impatient

https://stackoverflow.com/questions/47222226/how-to-inject-module-declaration-into-jar

If you are not afraid of some black magic, you can look at trying to inject module-info into your entire dependency tree:

1. jdeps --generate-module-info . <jar_path> 
2. javac --patch-module <module_name>=<jar_path> <module_name>/module-info.java 
3. jar uf <jar_path> -C <module_name> module-info.class

Going further you can then go as far as to exclude maven dependencies, using your own jars instead. At this point you could however probably just extract the contents of all of your dependencies into your classes folder and make an "über jar".

## How can you help?

Learn how to make multi-version jar files, get out there and start opening up some pull requests! It is possible to support java 8 and java 11 with full module support. It just needs to be done!
