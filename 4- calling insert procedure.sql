set serveroutput on size 1000000
declare
    cursor insert_installments_cursor is 
    select * from contracts order by  CONTRATCT_ID  ; 
begin

    for data_record in insert_installments_cursor loop
        insert_installments_table(data_record.CONTRATCT_ID) ; 
    end loop ; 

end ; 

show errors ; 