namespace vaicap02.common;

using { Currency } from '@sap/cds/common';

type Guid       : String(32);
type PhoneNum   : String(20);
type EmailId    : String(255);

type Gender     : String(1) enum {
                    Male = 'M';
                    Female = 'F';
                    Undisclosed = 'U';
};

type AmountType : Decimal(10, 2) @(
    Semantics.amount.currencycode : 'currency_code',
    sap.unit : 'currency_code'
);

aspect Amount {
        currency    : Currency;
        gross_amt   : AmountType;
        tax_amt     : AmountType;
        net_amt     : AmountType; 
}
