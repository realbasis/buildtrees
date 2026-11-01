# BuildTrees (Maven)

Family-tree web application (JSP/JSTL + Java beans), merged from the two earlier
attempts into one Maven WAR project:

| Taken from **Linked** (attempt 1)                         | Taken from **buildtrees** (attempt 2, NetBeans 2015)            |
|-----------------------------------------------------------|-----------------------------------------------------------------|
| All Java sources (`api`, `servlet`, `sql`, `utility`, `value`) | Tomcat + NetBeans setup (`/buildtrees` context, Run in NetBeans) |
| The complete set of pages (≈215 JSPs) and all `control/do*.jsp` actions | JSTL "standard URI" taglib header (`stdTags.jspf`, JSTL 1.2) |
| Images, JS, CSS                                            | Updated `stylesheet.css`, `autocomplete.js`, new `default.css`, `autocomplete.css` |
| Servlets, listener, JNDI DataSource name `jdbc/LinkedDB`   | `index8.jsp`, and the search landing page (now `searchHome.jsp`, wired to search) |

The second attempt contained no Java code and only ~90 of the pages, so attempt 1
supplies the application and attempt 2 supplies the packaging/runtime choices.

## Requirements

* JDK 11+ (NetBeans 23 itself runs on JDK 17+, which is fine)
* Maven 3.9+ (NetBeans' bundled Maven works)
* **Apache Tomcat 9.0** (Servlet 4.0 / JSP 2.3, `javax.*` packages) – e.g. your local
  `C:\Program Files\Apache Software Foundation\Tomcat 9.0`
* MySQL 8 / MariaDB 10.6+ with the existing `connected` database

> Tomcat 10.1/11 will **not** run this build (they use `jakarta.*`). If you move to
> Tomcat 10.1+ later, the project needs the javax→jakarta switch again.

## Run it on your local Tomcat from NetBeans

1. **Register Tomcat 9 in NetBeans** (once): *Tools ▸ Servers ▸ Add Server… ▸ Apache Tomcat or TomEE*,
   Server Location = `C:\Program Files\Apache Software Foundation\Tomcat 9.0`, choose a
   manager username/password (NetBeans can create it), and keep
   **"Use Private Configuration Folder (Catalina Base)"** ticked – Tomcat under
   *Program Files* is not writable, and this keeps your installed Tomcat untouched.
2. **Create your local settings file** (once): copy `buildtrees-local.properties.example` to
   `C:\Users\<you>\.buildtrees\buildtrees.properties` and fill in the database user/password
   (and `admin.password`). Mail is off by default (`mail.enabled=false`): mails are just
   logged in the Tomcat output.
3. **Open the project** (*File ▸ Open Project…* → the `buildtrees` folder with `pom.xml`).
   The included `nb-configuration.xml` already tells NetBeans to deploy to Tomcat. If
   you have more than one Tomcat registered, pick Tomcat 9 under
   *Project Properties ▸ Run ▸ Server*.
4. Press **Run** (F6). NetBeans builds the WAR, starts Tomcat 9 if needed, deploys it and
   opens **http://localhost:8080/buildtrees/**. **Debug** (Ctrl+F5) works the same way.

Change the settings file → restart Tomcat (*Services ▸ Servers ▸ Tomcat ▸ Restart*).

Without NetBeans: `mvn clean package` and copy `target/buildtrees.war` into Tomcat's `webapps` folder.

## Build

```bash
mvn clean package            # -> target/buildtrees.war
mvn -Pjspc clean verify      # also compiles every JSP with Tomcat 9's Jasper (fails on JSP/EL errors)
```

## Configure

No credentials are stored in the code. Everything comes from `buildtrees.*`
settings (defaults in `src/main/resources/buildtrees.properties`, template in
`buildtrees-local.properties.example`):

| Key | Purpose |
|---|---|
| `db.url`, `db.user`, `db.password`, `db.driver` | Database (JNDI pool *and* the fallback) |
| `mail.smtp.host`, `mail.smtp.port`, `mail.smtp.user`, `mail.smtp.password`, `mail.smtp.starttls` | Outgoing mail |
| `mail.enabled` | `false` = log mails instead of sending (dev) |
| `mail.from`, `mail.admin` | Sender / staff address |
| `admin.password` | Password for `admin.jsp` (owner login). **Admin login is disabled until set.** |

Where they are read from (first hit wins):

1. JVM options `-Dbuildtrees.db.password=…` (Tomcat `bin\setenv.bat` / service *Java Options*)
2. Environment variables `BUILDTREES_DB_PASSWORD=…`
3. The file given by `-Dbuildtrees.config=…`, else **`<user home>\.buildtrees\buildtrees.properties`**
   (keys with or without the `buildtrees.` prefix)
4. The defaults bundled in the WAR

The connection pool `jdbc/LinkedDB` is declared in `src/main/webapp/META-INF/context.xml`
with `factory="appconfig.PoolFactory"`: it is Tomcat's JDBC pool, but takes driver/URL/user/
password from the settings above, so nothing has to be edited in Tomcat's own files.

**On a server** (e.g. Ubuntu, Tomcat running as the `tomcat` user) put the file in that
user's home (`~tomcat/.buildtrees/buildtrees.properties`) or pass
`-Dbuildtrees.config=/etc/buildtrees/buildtrees.properties` in `setenv.sh`.

## What changed during the merge

**Platform**
* Targets Tomcat 9: Servlet 4.0 / JSP 2.3 / JSTL 1.2 (`javax.*`), Java 11 bytecode.
* All 50 jars that were committed in `WEB-INF/lib` are replaced by 4 Maven
  dependencies (JSTL 1.2, MySQL Connector/J, Angus Mail). Duplicate/unused jars
  (two `commons-lang`, two `activation`, jfreechart demo, facebook API, …) are gone.
* `web.xml` rewritten for Servlet 4.0; old `<taglib>` entries and TLD copies removed.

**Unmaintained libraries were replaced**, keeping the pages unchanged:

| Old | New |
|---|---|
| Jakarta mailer2 `<mt:mail>` (37 uses) | Tag file `/WEB-INF/tags/mt/mail.tag` → `appconfig.Mailer` (Jakarta Mail) |
| O'Reilly `orataglib` `<ora:ifValidEmailAddr>`, `<ora:fileWrite>`, `<ora:debug>` | Tag files in `/WEB-INF/tags/ora/` |
| commons-email (`PeopleSql.postMail`) | `appconfig.Mailer` |
| displaytag `<display:table>` (index, index7, admin) | JSTL tables + `<ui:pager>` tag file (admin table sorts client-side) |
| Cewolf/JFreeChart charts (admin) | Inline SVG charts (`utility.ActivityChart`) |
| javazoom UploadBean (photo upload) | Servlet multipart API (`api.ImageUpload`, `<multipart-config>` in web.xml) |
| "sqlx" taglib48 (`control/doGetImg.jsp`) | `servlet.PeopleImageServlet`, mapped to the same URL; shows `images/nophoto.png` when there is no photo |
| Hand-written JDBC 2.0 pool (`sql.ConnectionPool` …) | Tomcat JDBC pool via JNDI `jdbc/LinkedDB` (`appconfig.Db`) |

**Fixes**
* DB/SMTP/admin passwords removed from `ConnBean`, `PeopleSql`, `MailerBean`, `UploadImg`,
  `Linked`, `AuthBean`, `ConfigBean`, `web.xml` → `appconfig.AppConfig`.
* `ConnBean`/`PeopleSql`/`Linked` ran with `autoCommit(false)` and never committed (only
  worked on MyISAM). They now commit on close, and the pool resets connections — otherwise
  inserts made with `<sql:update>` could silently stay uncommitted on InnoDB.
* Connection leak in `control/authenticate.jsp` closed; JDBC driver deregistered on undeploy;
  `TasksServlet` timer stopped on shutdown.
* `doGetImgNew.jsp` wrote garbage bytes past the end of the image; fixed.

## Not included in the WAR (`legacy/`)

Pages that could not compile even in the original project, or depended on dead services,
are kept in `legacy/` for reference only — see `legacy/README.md`.

## Not verified here

There was no database dump in either attempt, so the app was smoke-tested on Tomcat 9.0.118 against a
schema reconstructed from the SQL in the code (login, signup, search, profile pages, admin
stats/charts, photo upload/preview, image servlet). Run it against a copy of the real
`connected` database before going live, and check e-mail delivery with your SMTP settings.
