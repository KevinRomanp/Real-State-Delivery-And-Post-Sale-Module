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
            /*field(ProfileQuestionnaireCodeName; CurrentQuestionsChecklistCode)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Profile Questionnaire Code';
                ToolTip = 'Specifies the profile questionnaire.';
                Visible = ProfileQuestionnaireCodeNameVi;

                /*trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord();
                    Commit();
                    if PAGE.RunModal(0, DEMOCuestionario) = ACTION::LookupOK then begin
                        DEMOCuestionario.Get(DEMOCuestionario.Code);
                        CurrentQuestionsChecklistCode := DEMOCuestionario.Code;
                        ProfileManagement.SetName(CurrentQuestionsChecklistCode, Rec, 0); //TODO: as
                        CurrPage.Update(false);
                    end;
                end;
*/
            /*trigger OnValidate()
            begin
                DEMOCuestionario.Get(CurrentQuestionsChecklistCode);
                CurrentQuestionsChecklistCodeO();
            end;
        }*/
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
                /*field("Multiple Answers"; Rec."Multiple Answers")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies that the question has more than one possible answer.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = RelationshipMgmt;
                    HideValue = PriorityHideValue;
                    ToolTip = 'Specifies the priority you give to the answer and where it should be displayed on the lines of the Contact Card. There are five options:';
                }
                field("Auto Contact Classification"; Rec."Auto Contact Classification")
                {
                    ApplicationArea = RelationshipMgmt;
                    Editable = false;
                    ToolTip = 'Specifies that the question is automatically answered when you run the Update Contact Classification batch job.';
                }
                field("From Value"; Rec."From Value")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the value from which the automatic classification of your contacts starts.';
                }
                field("To Value"; Rec."To Value")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the value that the automatic classification of your contacts stops at.';
                }
                field("No. of Contacts"; Rec."No. of Contacts")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the number of contacts that have given this answer.';
                }*/
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

