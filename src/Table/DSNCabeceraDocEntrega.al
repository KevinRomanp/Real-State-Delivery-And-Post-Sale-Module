table 52100 "Cabecera Documento Entrega"
{
    fields
    {
        field(52101; "No."; Code[20])
        {
            Caption = 'No.';

            DataClassification = AccountData;
            trigger OnValidate()

            begin
                if "No." <> xRec."No." then begin
                    DSConfigRealState.get();

                    NoSeriesMgt.TestManual(DSConfigRealState."No Serie Doc Entrega");
                end;
            end;
        }
        field(52103; "Contract No."; Code[50])
        {
            DataClassification = AccountData;
            Caption = 'No. Contrato';
            TableRelation = "DSContract Real Estate" where(State = filter(= "DSStatus Contract Flujo"::"Definitive Contract"),
                                                      "Unit Delivered" = const(false));
            trigger OnValidate()
            var
                DSContractRS: Record "DSContract Real Estate";

                CabDocEntrega: Record "Cabecera Documento Entrega";
                HistDocEntrega: record CabeceraDocEntregaHistorico;

                ExisteErr000: Label 'Este No. Contrato ya se utiliza en el No. Doc %1.';
                ExisteErr001: Label 'Este No. Contrato ya se utilizó en el No. Doc %1.';
            begin
                CabDocEntrega.Reset();
                CabDocEntrega.SetRange("Contract No.", rec."Contract No.");
                if CabDocEntrega.FindFirst() then
                    Error(ExisteErr000, CabDocEntrega."No.");
                HistDocEntrega.Reset();
                HistDocEntrega.SetRange("Contract No.", rec."Contract No.");
                if HistDocEntrega.FindFirst() then
                    Error(ExisteErr001, HistDocEntrega."No.");

                DSContractRS.Get(rec."Contract No.");
                rec."Buyer Name" := DSContractRS."Buyer Name";
                rec.Buyer := DSContractRS.Buyer;
                rec."Property No." := DSContractRS."Property No.";
                rec."Property Name" := DSContractRS."Property Name";
                rec."Property Value" := DSContractRS."Property Value";
                rec."Down Payment" := DSContractRS."Down Payment";
                rec."Job Name" := DSContractRS."Job Name";
                rec."Representative Name" := DSContractRS."Representative Name";
                rec.Currency := DSContractRS.Currency;
            end;
        }
        field(52102; Buyer; Code[20])
        {
            Caption = 'Buyer No.';
            TableRelation = Customer;
            DataClassification = AccountData;
            Editable = false;
        }

        field(52105; "Buyer Name"; Text[100])
        {
            Caption = 'Buyer Name';
            TableRelation = Customer.Name;
            DataClassification = AccountData;
            ValidateTableRelation = false;
            Editable = false;
        }

        field(52104; Representative; Code[20])
        {
            Caption = 'Representative';
            DataClassification = AccountData;
        }

        field(52106; "Representative Name"; Code[100])
        {
            Caption = 'Representative Name';

            DataClassification = AccountData;
            Editable = false;
            trigger OnLookup()
            begin
                LookupContactList();
            end;
        }

        field(52107; "Property No."; Code[20])
        {
            Caption = 'Property No.';
            DataClassification = AccountData;

            Editable = false;


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
            Editable = false;


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
            Editable = false;
        }
        field(52126; "Property Name"; Text[440])
        {
            Caption = 'Property Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Property No.")));
            Editable = false;

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
        field(52135; Signature; Blob)
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
    var
        DSConfigRealState: record "DSConfiguration Real Estate";
        NoSeries: Record "No. Series";
        NoSeriesMgt: codeunit NoSeriesManagement;

    trigger OnInsert()
    var
        User: Record User;

        DSConfigurationRealEstateRecord: Record "DSConfiguration Real Estate";
        ItemRecord: Record Item;
        NoSeriesManagementCodeunit: Codeunit NoSeriesManagement;
    begin

        TestField("Property No.");
        TestField("Contract No.");
        ItemRecord.Get("Property No.");
        ItemRecord.TestField("DSJob No.");
        ItemRecord.TestField(DSBuilding);
        ItemRecord.TestField("DSApartment No.");


        if rec.Date = 0D then
            rec.Date := Today();


        if "No." = '' then begin
            DSConfigurationRealEstateRecord.Get();
            DSConfigurationRealEstateRecord.TestField("No Serie Doc Entrega");
            "No." := NoSeriesManagementCodeunit.GetNextNo(DSConfigurationRealEstateRecord."No Serie Doc Entrega", Today(), true);

        end;



        if RepresentativeUser = '' then begin
            User.Get(UserSecurityId());
            RepresentativeUser := User."User Name";
        end;
    end;

    procedure SignDocument(var Base64Text: Text)
    var
        Base64Cu: Codeunit "Base64 Convert";
        RecordRef: RecordRef;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        ImageBase64String: Text;
    begin

        Base64Text := Base64Text.Replace('data:image/png;base64,', '');
        TempBlob.CreateOutStream(OutStream);
        Base64Cu.FromBase64(Base64Text, OutStream);

        Clear(rec.Signature);
        rec.Modify();

        RecordRef.GetTable(Rec);
        TempBlob.ToRecordRef(RecordRef, Rec.FieldNo("Signature"));
        RecordRef.Modify();

    end;



    local procedure LookupContactList()
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        ContactRecord: Record Contact;
        DSConfigurationRealEstateRecord: Record "DSConfiguration Real Estate";

    begin


        ContactRecord.FilterGroup(2);
        if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Customer, Buyer) then
            ContactRecord.SetRange("Company No.", ContactBusinessRelation."Contact No.")
        else
            ContactRecord.SetRange("Company No.", '');

        DSConfigurationRealEstateRecord.Get();
        DSConfigurationRealEstateRecord.TestField("Organizational Representative");
        ContactRecord.SetRange("Organizational Level Code", DSConfigurationRealEstateRecord."Organizational Representative");

        if Representative <> '' then
            if ContactRecord.Get(Representative) then;
        if PAGE.RunModal(0, ContactRecord) = ACTION::LookupOK then begin
            Validate(Representative, ContactRecord."No.");
            Validate("Representative Name", ContactRecord.Name);

        end;
    end;

    procedure LookupSellToCustomerName(var CustomerName: Text): Boolean
    var
        Customer: Record Customer;
        SearchCustomerName: Text;
    begin
        SearchCustomerName := CustomerName;
        if Buyer <> '' then
            Customer.Get(Buyer);

        if Customer.SelectCustomer(Customer) then begin
            if Rec."Buyer Name" = Customer.Name then
                CustomerName := SearchCustomerName
            else
                CustomerName := Customer.Name;


            Validate(Buyer, Customer."No.");
            exit(true);
        end;
    end;

    procedure AssistEdit(OldDocEntrega: Record "Cabecera Documento Entrega") Result: Boolean
    var
        DocEntrega2: Record "Cabecera Documento Entrega";
        IsHandled: Boolean;
        DocEntrega: Record "Cabecera Documento Entrega";
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        DocEntrega.Copy(Rec);
        DSConfigRealState.Get();
        NoSeries.Get(DSConfigRealState."No Serie Doc Entrega");
        if NoSeriesMgt.SelectSeries(DSConfigRealState."No Serie Doc Entrega", DSConfigRealState."No Serie Doc Entrega", DSConfigRealState."No Serie Doc Entrega") then begin

            NoSeriesMgt.SetSeries(DocEntrega."No.");

            Rec := DocEntrega;
            exit(true);
        end;
    end;
}