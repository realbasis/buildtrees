package appconfig;

import java.util.Properties;
import javax.naming.Context;
import javax.sql.DataSource;
import org.apache.tomcat.jdbc.pool.DataSourceFactory;

/**
 * JNDI factory for the {@code jdbc/LinkedDB} pool (see META-INF/context.xml).
 *
 * It is Tomcat's own JDBC pool factory, except that the connection settings
 * (driver, URL, user, password) come from {@link AppConfig}. So the database is
 * configured in one place, for the pool and for the rest of the app, whether
 * Tomcat is started from NetBeans, as a Windows service or with startup.bat:
 * <ul>
 *   <li>{@code %USERPROFILE%\.buildtrees\buildtrees.properties} (or ~/.buildtrees/... on Linux),</li>
 *   <li>or {@code -Dbuildtrees.db.*} JVM options / {@code BUILDTREES_DB_*} environment variables.</li>
 * </ul>
 * Pool tuning attributes (maxActive, validationQuery, ...) stay in context.xml.
 */
public class PoolFactory extends DataSourceFactory {

    @Override
    public DataSource createDataSource(Properties properties, Context context, boolean xa) throws Exception {
        properties.setProperty("driverClassName", AppConfig.dbDriver());
        properties.setProperty("url", AppConfig.dbUrl());
        properties.setProperty("username", AppConfig.dbUser());
        properties.setProperty("password", AppConfig.dbPassword());
        return super.createDataSource(properties, context, xa);
    }
}
