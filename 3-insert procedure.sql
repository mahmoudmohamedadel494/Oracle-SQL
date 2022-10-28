create or replace procedure insert_installments_table (v_CONTRATCT_ID number )
is 
v_CONTACT_STARTDATE date ; 
v_CONTRACT_ENDDATE date ; 
v_PAYMENT_INSTALLMENTS_NO number (10,2) ;
v_CONTRACT_TOTAL_FEES number (10,2) ; 
v_CONTRACT_PAYMENT_TYPE varchar2(100) ; 
v_CONTRACT_DEPOSIT_FEES number (10,2) ; 
v_total_remain number (10,2) ; 
v_INSTALLMENT_AMOUNT number (10,2) ; 
v_INSTALLMENT_DATE date ; 
begin 
    
    select    CONTACT_STARTDATE , CONTRACT_ENDDATE , PAYMENT_INSTALLMENTS_NO ,
    CONTRACT_TOTAL_FEES , CONTRACT_PAYMENT_TYPE  , nvl(CONTRACT_DEPOSIT_FEES , 0)
    into     v_CONTACT_STARTDATE , v_CONTRACT_ENDDATE , v_PAYMENT_INSTALLMENTS_NO , v_CONTRACT_TOTAL_FEES , v_CONTRACT_PAYMENT_TYPE , v_CONTRACT_DEPOSIT_FEES
    from contracts where CONTRATCT_ID = v_CONTRATCT_ID ; 

    v_total_remain :=  v_CONTRACT_TOTAL_FEES - v_CONTRACT_DEPOSIT_FEES ; 
    v_INSTALLMENT_AMOUNT := v_total_remain / v_PAYMENT_INSTALLMENTS_NO ; 
    
    v_INSTALLMENT_DATE := v_CONTACT_STARTDATE ; 
    for i in 1..v_PAYMENT_INSTALLMENTS_NO loop

           if   v_CONTRACT_PAYMENT_TYPE = 'ANNUAL' then
                insert into INSTALLMENTS
                (INSTALLMENT_ID, CONTRACT_ID, INSTALLMENT_DATE, INSTALLMENT_AMOUNT, PAID)
                values
                (INSTALLMENT_SEQ.nextval, v_CONTRATCT_ID, ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') , 12) , v_INSTALLMENT_AMOUNT , 0 )    ;
                v_INSTALLMENT_DATE := ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') , 12)  ; 
            
               elsif v_CONTRACT_PAYMENT_TYPE = 'HALF_ANNUAL' then
                 insert into INSTALLMENTS
                (INSTALLMENT_ID, CONTRACT_ID, INSTALLMENT_DATE, INSTALLMENT_AMOUNT, PAID)
                values
                (INSTALLMENT_SEQ.nextval, v_CONTRATCT_ID, ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') ,6) , v_INSTALLMENT_AMOUNT , 0 )   ;
                v_INSTALLMENT_DATE := ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') , 6)  ;     
                
            elsif v_CONTRACT_PAYMENT_TYPE = 'QUARTER' then
                 insert into INSTALLMENTS
                (INSTALLMENT_ID, CONTRACT_ID, INSTALLMENT_DATE, INSTALLMENT_AMOUNT, PAID)
                values
                (INSTALLMENT_SEQ.nextval, v_CONTRATCT_ID, ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') ,3) , v_INSTALLMENT_AMOUNT , 0 );    
                v_INSTALLMENT_DATE := ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') , 3)  ;     
            else 
                 insert into INSTALLMENTS
                (INSTALLMENT_ID, CONTRACT_ID, INSTALLMENT_DATE, INSTALLMENT_AMOUNT, PAID)
                values
                (INSTALLMENT_SEQ.nextval, v_CONTRATCT_ID, ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') ,1) , v_INSTALLMENT_AMOUNT , 0 );    
                v_INSTALLMENT_DATE := ADD_MONTHS (to_date (v_INSTALLMENT_DATE , 'DD/MM/YYYY') ,1)  ;       
                
            end if ;   
            
      end loop ;    
      
end ;