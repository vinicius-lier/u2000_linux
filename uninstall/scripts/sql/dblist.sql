use master
go

if exists (select name from tempdb..sysobjects where name='tbl_dblist' and type='U')
drop table tempdb..tbl_dblist
go
--select name into tempdb..tbl_dblist from  sysdatabases where name not in('master','tempdb','model','sybsystemdb','sybsystemprocs','Northwind','pubs','msdb')
select name into tempdb..tbl_dblist from  sysdatabases where name in('testDB')
go

