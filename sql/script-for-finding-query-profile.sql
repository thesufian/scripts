SELECT node_id,
			        physical_operator_name,
			        CAST(SUM(row_count)*100 AS float) / SUM(estimate_row_count) AS percent_complete,
			        SUM(elapsed_time_ms) AS elapsed_time_ms,
			        SUM(cpu_time_ms) AS cpu_time_ms,
			        SUM(logical_read_count) AS logical_read_count,
			        SUM(physical_read_count) AS physical_read_count,
			        SUM(write_page_count) AS write_page_count,
			        SUM(estimate_row_count) AS estimate_row_count
			   FROM sys.dm_exec_query_profiles
			  WHERE session_id = 134 -- spid running query
			  GROUP BY node_id,
			           physical_operator_name
			  ORDER BY node_id;
