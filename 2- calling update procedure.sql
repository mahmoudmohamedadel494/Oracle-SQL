set serveroutput on size 1000000
declare
    cursor update_installments_cursor is 
    select * from contracts order by  CONTRATCT_ID  ; 
begin

    for data_record in update_installments_cursor loop
        update_installments_no(data_record.CONTRATCT_ID) ; 
    end loop ; 

end ; 

show errors ; 

contracts ; 

