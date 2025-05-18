namespace vaicap02.db;

using { cuid, Currency } from '@sap/cds/common';
using { vaicap02.common } from './commons';

context master {
    entity BusinessPartner {
        key node_key    :   common.Guid;
        bp_role         :   String(2);
        email_id        :   common.EmailId;
        phone_num       :   common.PhoneNum;
        fax_number      :   String(32);
        web_address     :   String(44);
        bp_id           :   String(32);
        company_name    :   String(250);         
        address_guid    :   Association to Address;
    }

    entity Address {
        key node_key    :   common.Guid;
        city            :   String(44);
        postal_code     :   String(8);
        street          :   String(44);
        building        :   String(120);
        country         :   String(40);
        address_type    :   String(40);
        val_start_date  :   Date;
        val_end_date    :   Date;
        latitude        :   Decimal;
        longitude       :   Decimal;
        buspartner      :   Association to one BusinessPartner 
                            on buspartner.address_guid = $self;
    }

    entity Product {
        key node_key    :   common.Guid;
        prod_id         :   String(28);
        type_cd         :   String(2);
        caterogy        :   String(32);
        description     :   localized String(125);
        tax_tarif_cd    :   Integer;
        measure_unit    :   String(2);
        weight_measure  :   Decimal(5, 2);
        weight_unit     :   String(2);
        currency        :   Currency;
        price           :   Decimal(15, 2);
        width           :   Decimal(5, 2);
        depth           :   Decimal(5, 2);
        height          :   Decimal(5, 2);
        dim_unit        :   String(2);
        supplier_id     :   Association to BusinessPartner;
    }

    entity Employees : cuid {
        first_name      :   String(40);
        middle_name     :   String(40);
        last_name       :   String(40);
        name_init       :   String(40);
        gender          :   common.Gender;
        language        :   String(2);
        phone_num       :   common.PhoneNum;
        email_id        :   common.EmailId;
        login_name      :   String(12);
        currency        :   Currency;
        sal_amt         :   common.AmountType;
        account_num     :   String(16);
        bank_id         :   String(10);
        bank_name       :   String(100);
    }
}

context transaction {
    entity PurchaseOrders : common.Amount {
        key node_key    :   String(32);
        prod_id         :   String(40);
        lifecylstatus   :   String(1);
        overallstatus   :   String(1);
        partner_guid    :   Association to master.BusinessPartner;
        po_item         :   Association to many PoItems on po_item.parent_key = $self;
    }

    entity PoItems : common.Amount {
        key node_key    :   String(32);
        item_pos        :   Integer;
        parent_key      :   Association to transaction.PurchaseOrders;
        prod_guid       :   Association to master.Product;       
    }
}