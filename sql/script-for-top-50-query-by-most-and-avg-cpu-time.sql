

-- You can also run the following query to find top 50 queries that take the most CPU overall
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SELECT TOP 50
    ObjectName          = OBJECT_SCHEMA_NAME(qt.objectid,dbid) + '.' + OBJECT_NAME(qt.objectid, qt.dbid)
    ,TextData           = qt.text
    ,DiskReads          = qs.total_physical_reads   -- The worst reads, disk reads
    ,MemoryReads        = qs.total_logical_reads    --Logical Reads are memory reads
    ,Executions         = qs.execution_count
    ,TotalCPUTime       = qs.total_worker_time
    ,AverageCPUTime     = qs.total_worker_time/qs.execution_count
    ,DiskWaitAndCPUTime = qs.total_elapsed_time
    ,MemoryWrites       = qs.max_logical_writes
    ,DateCached         = qs.creation_time
    --,DatabaseName       = DB_Name(qt.dbid)
    ,LastExecutionTime  = qs.last_execution_time
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
where DB_Name(qt.dbid)='<DATABASE_NAME>'
ORDER BY qs.total_worker_time DESC


-- You can also run the following query to find top 50 queries that have the highest average CPU usage
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SELECT TOP 50
    ObjectName          = OBJECT_SCHEMA_NAME(qt.objectid,dbid) + '.' + OBJECT_NAME(qt.objectid, qt.dbid)
    ,TextData           = qt.text
    ,DiskReads          = qs.total_physical_reads   -- The worst reads, disk reads
    ,MemoryReads        = qs.total_logical_reads    --Logical Reads are memory reads
    ,Executions         = qs.execution_count
    ,TotalCPUTime       = qs.total_worker_time
    ,AverageCPUTime     = qs.total_worker_time/qs.execution_count
    ,DiskWaitAndCPUTime = qs.total_elapsed_time
    ,MemoryWrites       = qs.max_logical_writes
    ,DateCached         = qs.creation_time
    --,DatabaseName       = DB_Name(qt.dbid)
    ,LastExecutionTime  = qs.last_execution_time
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
where DB_Name(qt.dbid)='<DATABASE_NAME>'
ORDER BY qs.total_worker_time/qs.execution_count DESC