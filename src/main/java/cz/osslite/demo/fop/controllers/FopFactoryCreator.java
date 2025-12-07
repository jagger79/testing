package cz.osslite.demo.fop.controllers;

import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.fop.configuration.DefaultConfigurationBuilder;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URI;

@Component
public class FopFactoryCreator implements FactoryBean<FopFactory> {
    void config(HttpServletResponse out) throws Exception {
        DefaultConfigurationBuilder cfgBuilder = new DefaultConfigurationBuilder();
        var cfg = cfgBuilder.buildFromFile(new File("/tmp/mycfg.xml"));
        var fopFactoryBuilder = new FopFactoryBuilder(URI.create("")).setConfiguration(cfg);
    }

    @Override
    public FopFactory getObject() throws Exception {
        URI configuration = getClass().getClassLoader().getResource("fop/fop.xml").toURI();
        return FopFactory.newInstance(configuration);
    }

    @Override
    public Class<?> getObjectType() {
        return FopFactory.class;
    }
}
