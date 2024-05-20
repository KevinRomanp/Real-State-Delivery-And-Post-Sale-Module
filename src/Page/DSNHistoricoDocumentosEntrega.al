page 52104 "Histórico Documentos Entrega"
{
    ApplicationArea = All;
    Caption = 'Histórico Documentos Entrega';
    PageType = Card;
    SourceTable = CabeceraDocEntregaHistorico;
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                    ApplicationArea = all;
                }
                field("Property No."; Rec."Property No.")
                {
                    ToolTip = 'Specifies the value of the Property No. field.';
                    ApplicationArea = All;

                }
                field(Buyer; Rec.Buyer)
                {
                    ToolTip = 'Specifies the value of the Buyer No. field.';
                    ApplicationArea = Basic, Suite;

                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ToolTip = 'Specifies the value of the Buyer Name field.';
                    ApplicationArea = all;

                }
                field(Representative; Rec.Representative)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Representative field.';
                    Visible = false;
                }
                field("Representative Name"; Rec."Representative Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Representative Name field.';
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Name field.';

                }
                field("Property Value"; Rec."Property Value")
                {
                    ToolTip = 'Specifies the value of the Property Value field.';
                    ApplicationArea = all;
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                    ApplicationArea = all;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = all;
                }
                field("Job Name"; Rec."Job Name")
                {
                    Caption = 'Job Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Name field.';
                }
            }
            group(Firma)
            {
                field("DSSignature"; Rec."Signature")
                {
                    Caption = 'Firma del cliente';
                    ApplicationArea = All;
                    Editable = false;
                }
            }

        }
    }
}
