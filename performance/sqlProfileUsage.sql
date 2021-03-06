select distinct 
       PROF.NAME
      ,SQLSTAT.SQL_ID
      ,PROF.SIGNATURE
      ,PROF.CREATED
      ,PROF.LAST_MODIFIED
      ,MAX(SNAP.END_INTERVAL_TIME) LAST_EXECUTED
      ,PROF.DESCRIPTION
      ,PROF.STATUS
      ,PROF.FORCE_MATCHING
      ,DBMS_LOB.substr(PROF.sql_text, 3000) SQL_TEXT
      ,DBMS_LOB.SUBSTR(ATTR.COMP_DATA,4000) ATTRIBUTES
FROM DBA_SQL_PROFILES PROF
    ,DBA_HIST_SQLSTAT SQLSTAT
    ,DBA_HIST_SNAPSHOT SNAP
    ,DBMSHSXP_SQL_PROFILE_ATTR ATTR
WHERE  PROF.NAME=SQLSTAT.SQL_PROFILE(+)
AND SQLSTAT.SNAP_ID=SNAP.SNAP_ID(+) 
AND PROF.NAME=ATTR.PROFILE_NAME(+)
GROUP BY PROF.NAME
      ,SQLSTAT.SQL_ID
      ,PROF.SIGNATURE
      ,PROF.CREATED
      ,PROF.LAST_MODIFIED
      ,PROF.DESCRIPTION
      ,PROF.STATUS
      ,PROF.FORCE_MATCHING
      ,DBMS_LOB.substr(PROF.sql_text, 3000) 
      ,DBMS_LOB.SUBSTR(ATTR.COMP_DATA,4000)
ORDER BY SQL_ID;

