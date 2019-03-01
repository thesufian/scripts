SELECT  DATEDIFF(DAY, sd.crdate, GETDATE()) AS days_history
FROM    sys.sysdatabases sd
WHERE   sd.[name] = 'tempdb' ;

SELECT
    login_time
FROM
    sys.dm_exec_sessions
WHERE
    session_id = 1

	SELECT
 crdate AS startup,
 DATEDIFF(s, crdate, GETDATE()) / 3600. / 24 AS uptime_days
FROM master..sysdatabases
WHERE name = 'tempdb'