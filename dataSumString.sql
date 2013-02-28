set QUOTED_IDENTIFIER on
set ANSI_NULLS on
GO
create function [dbo].[dataSumString] ( @fieldname as varchar(50) ,
                                        @totablename as varchar(50) ,
                                        @fromtablename as varchar(50) ,
                                        @groupby as varchar(20) ,
                                        @wheretxt as varchar(100) )
returns nvarchar(500)
/*

Description: Return a sql string that you can run to update the detail table.

Returns: @sqltext

Created by: JD

Version: 1.0
    
Created: 6/25/2011.
Last Updated: 

*/
as 
begin

    declare @sqltext varchar(500)


    set @sqltext = 'update dbo.' + @totablename + ' set ' + @fieldname + ' =  b.tot from dbo.' + @totablename +
        ' a join ' + '(select sum(' + @fieldname + ') tot, ' + @groupby + ' from dbo.' + @fromtablename + ' ' +
        @wheretxt + ' group by ' + @groupby + ') b on a.' + @groupby + ' = b.' + @groupby


    return @sqltext

end


GO
