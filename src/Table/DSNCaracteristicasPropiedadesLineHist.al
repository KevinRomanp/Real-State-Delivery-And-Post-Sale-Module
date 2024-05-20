table 52111 CaracteristicaPropLineHist
{
    Caption = 'CaracteristicaPropiedadLine';
    DataClassification = AccountData;

    fields
    {
        field(1; "Property No."; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Característica"; Code[20])
        {
            Caption = 'Característica';
        }
        field(3; "Descripción"; Text[100])
        {
            Caption = 'Descripción';
        }
        field(4; LineNo; Integer)
        {
        }
    }
    keys
    {
        key(PK; "Property No.", "Característica", LineNo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Característica", "Descripción")
        { }
        fieldgroup(Brick; "Característica", "Descripción")
        { }
    }
}
