SELECT TOP 5000
SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,
((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(qt.TEXT) ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2)+1),qs.execution_count,
qs.total_worker_time/(qs.execution_count*1000) avg_worker_time_in_ms,
qs.total_worker_time,qs.total_logical_reads, qs.last_logical_reads,
qs.total_logical_writes, qs.last_logical_writes,
--qt.TEXT,
qs.last_worker_time,qs.total_elapsed_time/1000000 total_elapsed_time_in_S,
qs.last_elapsed_time/1000000 last_elapsed_time_in_S,qs.last_execution_time,
--getutcdate(),
qp.query_plan
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
--where (qs.total_worker_time/qs.execution_count)>500000
--and qs.execution_count>50
--where qt.TEXT like '%Select Distinct Top 10 K.RANK%'
--ORDER BY qs.total_logical_reads DESC -- logical reads
-- ORDER BY qs.total_logical_writes DESC -- logical writes
 ORDER BY qs.total_worker_time DESC -- CPU time
 --ORDER BY qs.last_worker_time ASC
OPTION (RECOMPILE);
