CREATE OR REPLACE procedure PRO_USER.update_installments_no(v_CONTRATCT_ID number )
is
v_CONTACT_STARTDATE date ; 
v_CONTRACT_ENDDATE date ; 
v_CONTRACT_PAYMENT_TYPE varchar2(100) ; 
begin

    select CONTACT_STARTDATE , CONTRACT_ENDDATE , CONTRACT_PAYMENT_TYPE
        into v_CONTACT_STARTDATE , v_CONTRACT_ENDDATE , v_CONTRACT_PAYMENT_TYPE
    from contracts where CONTRATCT_ID = v_CONTRATCT_ID ; 
    
    if v_CONTRACT_PAYMENT_TYPE = 'ANNUAL' then
        update contracts
        set PAYMENT_INSTALLMENTS_NO = months_between(to_date(CONTRACT_ENDDATE) , to_date(CONTACT_STARTDATE) )/12 
        where CONTRATCT_ID = v_CONTRATCT_ID ; 
        
    elsif v_CONTRACT_PAYMENT_TYPE = 'HALF_ANNUAL' then
        update contracts
        set PAYMENT_INSTALLMENTS_NO = months_between(to_date(CONTRACT_ENDDATE) , to_date(CONTACT_STARTDATE) )/6 
        where CONTRATCT_ID = v_CONTRATCT_ID ;     
        
    elsif v_CONTRACT_PAYMENT_TYPE = 'QUARTER' then
        update contracts
        set PAYMENT_INSTALLMENTS_NO = months_between(to_date(CONTRACT_ENDDATE) , to_date(CONTACT_STARTDATE) )/3 
        where CONTRATCT_ID = v_CONTRATCT_ID ; 
    else 
        update contracts
        set PAYMENT_INSTALLMENTS_NO = months_between(to_date(CONTRACT_ENDDATE) , to_date(CONTACT_STARTDATE) )
        where CONTRATCT_ID = v_CONTRATCT_ID ;     
   end if ; 
end ;
/
