page 52105 CuestionarioLineListPart
{
    ApplicationArea = All;
    Caption = 'CuestionarioLineListPart';
    PageType = ListPart;
    SourceTable = DSNCuestionarioLineHist;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where(Type = filter("Respuesta"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Check; rec.Check)
                {
                    ToolTip = 'Specifies the value of the Check field.';
                }
            }
        }
    }
    var
        DSNCuestionarioLineHist: record DSNCuestionarioLineHist;

    trigger OnAfterGetCurrRecord()

    begin
        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", rec."No. Doc. Entrega");
        DSNCuestionarioLineHist.SetFilter(GroupID, rec.GroupID + '*');
        DSNCuestionarioLineHist.SetRange(Type, DSNCuestionarioLineHist.Type::Respuesta);
        DSNCuestionarioLineHist.FindFirst();
    end;

}
