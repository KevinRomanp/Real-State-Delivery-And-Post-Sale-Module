page 52110 CuestionarioLineHist
{
    Caption = 'CuestionarioLineHist';
    DataCaptionExpression = CaptionExpr;
    PageType = ListPart;
    Editable = false;
    SourceTable = DSNCuestionarioLineHist;
    UsageCategory = History;

    layout
    {
        area(content)
        {

            repeater(Control1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    //Style = Strong;
                    StyleExpr = StyleExprr;
                    ToolTip = 'Specifies whether the entry is a question or an answer.';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = StyleExprr;
                    ToolTip = 'Specifies the profile question or answer.';
                }
                field(Check; Rec.Check)
                {
                    ApplicationArea = all;

                }

            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        PriorityHideValue := false;
        StyleIsStrong := false;
        DescriptionIndent := 0;

        case rec.type of
            rec.Type::"Área":
                begin
                    StyleExprr := 'Strong';
                    PriorityHideValue := true;
                end;
            rec.Type::"Característica":
                begin
                    DescriptionIndent := 1;
                    StyleExprr := 'Ambiguous';
                end;
            else begin
                DescriptionIndent := 2;
                StyleExprr := 'Standard';
            end
        end;


    end;






    var
        CaptionExpr: Text[100];
        DescriptionIndent: Integer;
        StyleIsStrong: Boolean;
        PriorityHideValue: Boolean;
        StyleExprr: text[15];

}

