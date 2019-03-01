---- Finding the most beneficial missing indexes, but don't blindly follow it. apply judgement to find the correct balance between 
---- too many and too few indexes, ---- and having in place the appropriate set of “useful” indexes is extremely important.

SELECT  user_seeks * avg_total_user_cost * ( avg_user_impact * 0.01 ) AS [index_advantage] ,
        dbmigs.last_user_seek ,
        dbmid.[statement] AS [Database.Schema.Table] ,
        dbmid.equality_columns ,
        dbmid.inequality_columns ,
        dbmid.included_columns ,
        dbmigs.unique_compiles ,
        dbmigs.user_seeks ,
        dbmigs.avg_total_user_cost ,
        dbmigs.avg_user_impact
FROM    sys.dm_db_missing_index_group_stats AS dbmigs WITH ( NOLOCK )
        INNER JOIN sys.dm_db_missing_index_groups AS dbmig WITH ( NOLOCK )
                    ON dbmigs.group_handle = dbmig.index_group_handle
        INNER JOIN sys.dm_db_missing_index_details AS dbmid WITH ( NOLOCK )
                    ON dbmig.index_handle = dbmid.index_handle
WHERE   dbmid.[database_id] = DB_ID()
	and (user_seeks * avg_total_user_cost * ( avg_user_impact * 0.01 )) > 500
	and dbmid.[statement] like '%[[]<TABLE_NAME>]'
ORDER BY index_advantage DESC
	OPTION(RECOMPILE);
	
	GO