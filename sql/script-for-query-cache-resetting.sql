SELECT cp.plan_handle, cp.objtype, cp.usecounts, 
DB_NAME(st.dbid) AS [DatabaseName],*
FROM sys.dm_exec_cached_plans AS cp CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS st 
WHERE --OBJECT_NAME (st.objectid) LIKE N'%<OBJECT_NAME>' or 
st.[text]  like '%SELECT TOP 500  SUBSTRING%' 
OPTION (RECOMPILE)
GO
