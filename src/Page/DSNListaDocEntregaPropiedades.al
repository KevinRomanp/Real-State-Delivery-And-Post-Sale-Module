page 52102 ListaDocEntregaPropiedades
{
    ApplicationArea = All;
    Caption = 'Lista Documento Entrega Propiedades';
    PageType = List;
    SourceTable = "Cabecera Documento Entrega";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Documento Entrega de Propiedad";
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ToolTip = 'Specifies the value of the Buyer Name field.';
                }
                field("Property No."; Rec."Property No.")
                {
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field("Property Name"; Rec."Property Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Name field.';
                    trigger OnDrillDown()
                    var
                        ItemRecord: Record Item;
                        DSPropertyRealEstateRecord: Page "DSProperty Real Estate";
                    begin
                        if rec."Property No." <> '' then begin
                            ItemRecord.Reset();
                            ItemRecord.SetRange("No.", rec."Property No.");
                            DSPropertyRealEstateRecord.SetTableView(ItemRecord);
                            DSPropertyRealEstateRecord.Editable(false);
                            DSPropertyRealEstateRecord.RunModal();
                        end;
                    end;
                }
                field("Property Value"; Rec."Property Value")
                {
                    ToolTip = 'Specifies the value of the Property Value field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Job Name"; Rec."Job Name")
                {
                    Caption = 'Job Name';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Name field.';
                    trigger OnDrillDown()
                    var
                        JobRecord: Record Job;
                        ItemRecord: Record Item;
                        DSjobRealEstateRecord: Page "DSJob Real Estate";
                    begin

                        if rec."Property No." <> '' then begin
                            ItemRecord.Reset();
                            JobRecord.Reset();
                            ItemRecord.Get(rec."Property No.");
                            JobRecord.Get(ItemRecord."DSJob No.");
                            DSjobRealEstateRecord.SetTableView(JobRecord);
                            DSjobRealEstateRecord.Editable(false);
                            DSjobRealEstateRecord.RunModal();
                        end;

                    end;
                }
                field("Sales person"; Rec."Sales person")
                {
                    ToolTip = 'Specifies the value of the Sales person field.';
                }
            }
        }
    }
}
