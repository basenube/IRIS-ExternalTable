 -- create GS table
create table tst.multifileGS 
(field1 varchar(50), 
int1 INT, 
float1 DOUBLE, 
field2 varchar(50))
 -- convert table to file-based external Google Cloud
call EXT.ConvertToExternal('tst.multifileGS','test/multifile-gs.json')
 --
select %PATH,* from tst.multifileGS 
 -- create S3 table
create table tst.multifileS3 
(field1 varchar(50), 
int1 INT, 
float1 DOUBLE, 
field2 varchar(50))
 -- convert table to file-based external AWS S3
call EXT.ConvertToExternal('tst.multifileS3','test/multifile-s3.json')
 --
select * from tst.multifileS3
 -- create Azure table
create table tst.multifileAZ 
(field1 varchar(50), 
int1 INT, 
float1 DOUBLE, 
field2 varchar(50))
 -- convert table to file-based external Azure Storage Bucket
call EXT.ConvertToExternal('tst.multifileAZ','test/multifile-azure.json')
 --
select * from tst.multifileAZ
 -- UNION across all three providers
select field1, int1, float1,field2, %PATH  from tst.multifileGS
union all
select field1, int1, float1,field2,%PATH  from tst.multifileS3
union all
select field1, int1, float1,field2,%PATH  from tst.multifileAZ
 -- cleanup  GS
drop table tst.multifileGS  %NODELDATA
 -- cleanup  S3
drop table tst.multifileS3  %NODELDATA
 -- cleanup  Azure
drop table tst.multifileAZ  %NODELDATA
 -- DONE