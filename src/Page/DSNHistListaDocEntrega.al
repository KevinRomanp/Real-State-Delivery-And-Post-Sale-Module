page 52107 HistListaEntrega
{
    ApplicationArea = All;
    Caption = 'Lista Histórico Documento Entrega Propiedades';
    PageType = List;
    SourceTable = CabeceraDocEntregaHistorico;
    UsageCategory = History;
    Editable = false;
    CardPageId = "Histórico Documentos Entrega";
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

                }
                field("Sales person"; Rec."Sales person")
                {
                    ToolTip = 'Specifies the value of the Sales person field.';
                }
            }
        }
    }
}
