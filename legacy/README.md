# legacy/ — not built, not deployed

Kept only for reference. Nothing here is referenced by the application.

| File | Why it was left out |
|---|---|
| `webapp/fb.jsp`, `webapp/fb_old.jsp` | Facebook REST API (2009) client — library and API no longer exist |
| `webapp/signup2.jsp`, `webapp/control/doSignupOld.jsp` | Use `com.temesoft.security` captcha classes that were never in `WEB-INF/lib` (did not compile in the original either) |
| `webapp/zmainFatherFrag.jsp`, `webapp/zmainMotherFrag.jsp` | Call `TreeLogicBean.pullProfileSelect(...)` with an old signature (did not compile); superseded by `zmainMotherFrag2.jsp` etc. |
| `webapp/control/doRecordZnode2.jsp` | Uses `utility.ConnBean`, which does not exist (did not compile) |
| `webapp/control/waitSignup.jsp` | "waittag" (taglib144) library; unreferenced |
| `webapp/upload.jsp` | Hand-written multipart parser test page (javax only); unreferenced |
| `webapp/control/doDbUpload.jsp` | javazoom UploadBean DB upload sample; unreferenced |
| `webapp/control/doGetImg.jsp` | Replaced by `servlet.PeopleImageServlet` mapped to the same URL |
| `java/sql/ConnectionPool.java`, `ConnectionWrapper.java`, `DataSourceWrapper.java`, `DataSourceFactory.java` | Unused JDBC 2.0 pool; replaced by Tomcat's pool (`jdbc/LinkedDB`) |
| `dreamweaver-templates/` | Dreamweaver `.dwt` page templates from the first attempt |
