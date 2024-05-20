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
                    trigger OnValidate()
                    begin
                        DSNWizardCuestionario.SetControls(rec."No. Doc. Entrega");
                    end;
                }
            }
        }
    }
    var
        DSNCuestionarioLineHist: record DSNCuestionarioLineHist;
        DSNCuestionarioLineHist2: Record DSNCuestionarioLineHist;
        DSNWizardCuestionario: page DSNWizardCuestionario;

    trigger OnAfterGetCurrRecord()

    begin
        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", rec."No. Doc. Entrega");
        DSNCuestionarioLineHist.SetFilter(GroupID, rec.GroupID + '*');
        DSNCuestionarioLineHist.SetRange(Type, DSNCuestionarioLineHist.Type::Respuesta);
        DSNCuestionarioLineHist.FindFirst();
        CheckMultipleAnswers;
    end;

    local procedure CheckMultipleAnswers()
    var
        NoRespuestas: Integer;
        Error000: Label 'Esta característica no permite multiples respuestas.';
    begin
        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", rec."No. Doc. Entrega");
        DSNCuestionarioLineHist.SetFilter(GroupID, rec.GroupID + '*');
        DSNCuestionarioLineHist.SetRange(Type, DSNCuestionarioLineHist.Type::Respuesta);
        DSNCuestionarioLineHist.SetRange(Check, true);
        if DSNCuestionarioLineHist.Find('-') then begin
            NoRespuestas := DSNCuestionarioLineHist.Count();
            DSNCuestionarioLineHist2.Reset();
            DSNCuestionarioLineHist2.SetRange("No. Doc. Entrega", rec."No. Doc. Entrega");
            DSNCuestionarioLineHist2.SetFilter(groupidcaracteristica, DSNCuestionarioLineHist.GroupIDCaracteristica);
            DSNCuestionarioLineHist2.SetRange(Type, DSNCuestionarioLineHist.Type::"Característica");
            DSNCuestionarioLineHist2.FindFirst();
            if (DSNCuestionarioLineHist2."Multiple Answers" = false) and (NoRespuestas > 1) then
                Error(Error000);
        end;

    end;
}
