module org.geotools.http {
    requires java.logging;

    requires transitive org.geotools.metadata;

    exports org.geotools.http;

    provides org.geotools.http.HTTPClientFactory with
        org.geotools.http.DefaultHTTPClientFactory;

}
