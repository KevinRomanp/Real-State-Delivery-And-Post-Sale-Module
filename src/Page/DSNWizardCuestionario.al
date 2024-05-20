page 52101 DSNWizardCuestionario
{
    ApplicationArea = All;
    Caption = 'DSNWizardCuestionario';
    PageType = NavigatePage;
    SourceTable = DSNCuestionarioLineHist;
    DataCaptionFields = Description;
    ModifyAllowed = false;
    SourceTableView = where(Type = const("Característica"));

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Editable = false;
                Visible = TopBannerVisible and (done = false);
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                Editable = false;
                Visible = TopBannerVisible and (Done = true);
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = all;
                    ShowCaption = false;
                }
            }
            group(Area1)
            {
                Visible = (currentArea = 1) and (done = false);
                ShowCaption = false;
                field(AreaActual; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActua0; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Característica';
                }
            }
            group(Area2)
            {
                Visible = (currentArea = 2) and (done = false);
                ShowCaption = false;
                field(AreaActual1; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActual2; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Característica';
                }
            }
            group(Area3)
            {
                ShowCaption = false;
                Visible = (currentArea = 3) and (done = false);
                field(AreaActual2; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActual3; rec.Description)
                {
                    Caption = 'Característica';
                    ApplicationArea = all;
                    Editable = false;

                }
            }
            group(Area4)
            {
                Visible = (currentArea = 4) and (done = false);
                ShowCaption = false;
                field(AreaActua4; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActual4; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Característica';
                }
            }
            group(Area5)
            {
                Visible = (currentArea = 5) and (done = false);
                ShowCaption = false;
                field(AreaActua5; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActual5; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Característica';
                }
            }
            group(Area6)
            {
                Visible = (currentArea = 6) and (done = false);
                ShowCaption = false;
                field(AreaActua6; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActual6; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Característica';
                }
            }
            group(Area7)
            {
                Visible = (currentArea = 7) and (done = false);
                ShowCaption = false;
                field(AreaActua7; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActual7; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Característica';
                }

            }
            group(Area8)
            {
                Visible = (currentArea = 8) and (done = false);
                ShowCaption = false;
                field(AreaActua8; AreaActual)
                {
                    Caption = 'Área';
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = false;
                }
                field(CaractActual8; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Característica';
                }

            }
            group(EndingLine)
            {
                Visible = Done = true;

                group(Confirm)
                {
                    Caption = 'Cuestionario Exitoso!';
                    InstructionalText = 'Terminado';
                }
            }
            part(CuestionarioLineListPart; CuestionarioLineListPart)
            {
                Caption = 'Respuestas';
                Visible = Done = false;
                ApplicationArea = all;
                Editable = true;
                Enabled = true;
                SubPageLink = "No. Doc. Entrega" = field("No. Doc. Entrega"),
                GroupIDCaracteristica = field(GroupIDCaracteristica);
                UpdatePropagation = Both;
            }
        }


    }
    actions
    {
        area(Processing)
        {

            action(Back)
            {
                ApplicationArea = All;
                Caption = 'Atrás';
                InFooterBar = true;
                Enabled = BackAllowed;
                Image = PreviousRecord;
                trigger OnAction()
                begin

                    takeStep(-1);
                    rec.Next(-1);
                end;
            }
            action(Next)
            {
                ApplicationArea = All;
                Caption = 'Siguiente';
                InFooterBar = true;
                Enabled = NextAllowed;
                Image = NextRecord;
                trigger OnAction()
                begin

                    takeStep(1);
                    rec.Next();
                end;
            }
            action(Finish)
            {
                ApplicationArea = All;
                Caption = 'Terminar';
                InFooterBar = true;
                Enabled = FinishAllowed;
                Image = Approve;
                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        Respondido: Boolean;
        CurrentArea: Integer;
        NextAllowed: Boolean;
        BackAllowed: Boolean;
        AreaActual: text[20];
        FinishAllowed: Boolean;
        TopBannerVisible: Boolean;
        DSNCuestionarioLineHist: Record DSNCuestionarioLineHist;
        MediaRepositoryStandard: record "Media Repository";
        MediaRepositoryDone: record "Media Repository";
        MediaResourcesStandard: record "Media Resources";
        MediaResourcesDone: record "Media Resources";
        LineNo: Integer;
        Done: Boolean;
        Answered: Boolean;
        NumeroDeLineas: Integer;

    [Scope('Cloud')]
    procedure SetControls(var NoDoc: Code[25])
    begin
        FinishAllowed := false;
        Answered := false;
        BackAllowed := CurrentArea > 1;

        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", NoDoc);
        DSNCuestionarioLineHist.SetRange(Type, DSNCuestionarioLineHist.Type::"Respuesta");
        DSNCuestionarioLineHist.SetRange(GroupIDCaracteristica, rec.GroupIDCaracteristica);
        DSNCuestionarioLineHist.SetRange(Check, true);
        if DSNCuestionarioLineHist.FindFirst() then
            Answered := true;

        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", NoDoc);
        DSNCuestionarioLineHist.SetRange(Type, DSNCuestionarioLineHist.Type::"Característica");
        NumeroDeLineas := DSNCuestionarioLineHist.Count();
        if CurrentArea > NumeroDeLineas then
            Done := true else
            Done := false;
        DSNCuestionarioLineHist.reset;
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", NoDoc);
        DSNCuestionarioLineHist.SetRange(Type, DSNCuestionarioLineHist.Type::"Característica");
        DSNCuestionarioLineHist.FindLast();
        LineNo := DSNCuestionarioLineHist."Line No.";

        if done = true then
            FinishAllowed := true
        else
            FinishAllowed := false;

        if (FinishAllowed = false) and (Answered = true) then
            NextAllowed := true else
            NextAllowed := false;

        //NextAllowed := CurrentArea < 9;

        //FinishAllowed := CurrentArea = 9;


    end;

    local procedure takeStep(step: Integer)
    begin
        CurrentArea += step;
        SetControls(rec."No. Doc. Entrega");
    end;

    local procedure TestGroupID()
    var
        groupID: code[15];
    begin
        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", rec."No. Doc. Entrega");
        DSNCuestionarioLineHist.FindSet();
        repeat
            groupID := DSNCuestionarioLineHist.GroupID;
        until DSNCuestionarioLineHist.Next() = 0;
    end;

    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.get('AssistedSetup-NoText-400px.png', Format(CurrentClientType)) and
            MediaRepositoryDone.get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType))
            then
            if MediaResourcesStandard.get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.get(MediaRepositoryDone."Media Resources Ref")
                then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue;
    end;

    trigger OnOpenPage()
    begin
        CurrentArea := 1;
        AreaActual := rec.Description;
        SetControls(rec."No. Doc. Entrega");
    end;

    trigger OnInit()
    begin
        LoadTopBanners();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //Para encontrar el area actual
        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", rec."No. Doc. Entrega");
        DSNCuestionarioLineHist.SetRange(GroupID, CopyStr(rec.GroupID, 1, 3));
        DSNCuestionarioLineHist.SetRange(Type, DSNCuestionarioLineHist.Type::"Área");
        DSNCuestionarioLineHist.FindFirst();
        AreaActual := DSNCuestionarioLineHist.Description;
        SetControls(rec."No. Doc. Entrega");
    end;

    [Scope('Cloud')]
    procedure Completado(): Boolean
    begin
        if done = true then
            exit(true);
    end;
}
