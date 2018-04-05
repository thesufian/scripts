select * from sys.configurations
where name ='user connections'

select * from sys.dm_os_performance_counters
where counter_name ='User Connections'