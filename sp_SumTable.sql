set QUOTED_IDENTIFIER on
set ANSI_NULLS on
GO
create proc [dbo].[sp_SumTable]
as 
set ANSI_NULLS on

set QUOTED_IDENTIFIER on

set ANSI_PADDING on

/*
    IF EXISTS ( SELECT  *
                FROM    sysobjects
                WHERE   name = 'tbl_Table_Sum' ) 
        DROP TABLE tbl_Table_Sum

CREATE TABLE [dbo].[tbl_Table_Sum](
..
) ON [PRIMARY]


set ANSI_PADDING off

--insert group by values
insert  into dbo.tbl_Table_Sum ( col1 )
        select  col1
        from    dbo.tbl_Detail_Table
        group by groupbyfields
*/



declare @Field as varchar(50) 
declare @sqltext as nvarchar(500)
declare c cursor forward_only
for
select  COLUMN_NAME
from    INFORMATION_SCHEMA.columns
where   TABLE_NAME = 'tbl_Table_SumName' and
        TABLE_CATALOG = 'database' and
        (
          DATA_TYPE = 'int' or
          DATA_TYPE = 'money' or
          DATA_TYPE = 'float'
        ) and
        COLUMN_NAME <> 'FieldYouWantToAvoid' and
        COLUMN_NAME <> 'FieldYouWantToAvoid2'
order by ORDINAL_POSITION

open c
    
fetch next from c
 into @Field

while @@FETCH_STATUS = 0 
    begin

        set @sqltext = dbo.dataSumString(@field, 'tbl_Table_Sum', 'tbl_Detail_Table', 'groupbyfields', '')
        exec sp_executesql @sqltext

        print @sqltext

        fetch next from c
 into @Field
    end
close c
deallocate c
GO
