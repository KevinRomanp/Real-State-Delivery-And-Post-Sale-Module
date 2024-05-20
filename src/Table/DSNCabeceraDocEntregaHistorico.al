table 52103 CabeceraDocEntregaHistorico
{
    Caption = 'CabeceraDocEntregaHistorico';
    DataClassification = AccountData;

    fields
    {
        field(52101; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = AccountData;
        }
        field(52102; Buyer; Code[20])
        {
            Caption = 'No. Cliente';
            TableRelation = Customer;
            DataClassification = AccountData;
        }
        field(52103; "Contract No."; Code[50])
        {
            DataClassification = AccountData;
            Caption = 'No. Contrato';
        }

        field(52105; "Buyer Name"; Text[100])
        {
            Caption = 'Buyer Name';
            TableRelation = Customer.Name;
            DataClassification = AccountData;
            ValidateTableRelation = false;
        }

        field(52104; Representative; Code[20])
        {
            Caption = 'Representative';
            // TableRelation = Contact where (buy)
            DataClassification = AccountData;

        }

        field(52106; "Representative Name"; Code[100])
        {
            Caption = 'Representative Name';
            // TableRelation = Contact where (buy)
            DataClassification = AccountData;

        }

        field(52107; "Property No."; Code[20])
        {
            Caption = 'Property No.';
            DataClassification = AccountData;
            TableRelation = Item;
        }
        field(52109; Currency; Code[20])
        {
            Caption = 'Currency';
        }

        field(52108; "Property Value"; Decimal)
        {
            AutoFormatExpression = Currency;
            AutoFormatType = 1;
            Caption = 'Property Value';
        }
        field(52114; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = AccountData;
        }
        field(52116; "Down Payment"; Decimal)
        {
            Caption = 'Down Payment';
            DataClassification = SystemMetadata;


        }

        field(52121; "Sales person"; Code[20])
        {
            Caption = 'Sales person';
            DataClassification = AccountData;
            TableRelation = "Salesperson/Purchaser";
        }
        field(52122; RepresentativeUser; Code[50])
        {
            Caption = 'Representative User';
            DataClassification = AccountData;
        }
        field(52126; "Property Name"; Text[440])
        {
            Caption = 'Property Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Property No.")));

        }
        field(52133; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = AccountData;
        }
        field(52134; "Job Name"; Text[100])
        {
            Caption = 'Job Name';
            DataClassification = AccountData;
            Editable = false;
        }
        field(52142; Estado; Option)
        {
            Caption = 'Estado';
            OptionMembers = Abierto,Cerrado;
            DataClassification = CustomerContent;
        }
        field(52143; Signature; Blob)
        {
            DataClassification = AccountData;
            Caption = 'Firma del cliente';
            Subtype = Bitmap;
        }
    }
    keys
    {
        key(PK; "No.", "Contract No.")
        {
            Clustered = true;
        }
    }
}
