page 52100 "Documento Entrega de Propiedad"
{
    ApplicationArea = All;
    Caption = 'Documento Entrega de Propiedad';
    PageType = Card;
    SourceTable = "Cabecera Documento Entrega";
    DataCaptionFields = "No.", "Contract No.", "Property Name";
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
                    Editable = false;

                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Property No."; Rec."Property No.")
                {
                    ToolTip = 'Specifies the value of the Property No. field.';
                    Importance = Promoted;
                    ShowMandatory = true;
                    NotBlank = true;
                    ApplicationArea = All;


                }
                field(Buyer; Rec.Buyer)
                {
                    ToolTip = 'Specifies the value of the Buyer No. field.';
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ToolTip = 'Specifies the value of the Buyer Name field.';
                    ApplicationArea = all;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
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
                    trigger OnDrillDown()
                    var
                        ItemRecord: Record Item;
                        DSPropertyRealEstateRecord: Page "DSProperty Real Estate";
                    begin
                        if rec."Property No." <> '' then begin
                            ItemRecord.Reset();
                            ItemRecord.SetRange("No.", rec."Property No.");
                            DSPropertyRealEstateRecord.SetTableView(ItemRecord);
                            DSPropertyRealEstateRecord.RunModal();
                        end;

                    end;
                }
                field("Property Value"; Rec."Property Value")
                {
                    ToolTip = 'Specifies the value of the Property Value field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job Name"; Rec."Job Name")
                {
                    Caption = 'Job Name';
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
            }

            group("Firma")
            {
                usercontrol("Signature";
                "SignaturePad")
                {
                    ApplicationArea = All;
                    Visible = true;
                    trigger Ready()
                    begin
                        CurrPage."Signature".InitializeSignaturePad();
                    end;

                    trigger Sign(Signature: Text)
                    begin
                        Rec.SignDocument(Signature);
                        CurrPage.Update();
                    end;
                }

            }
            field("DSSignature"; Rec."Signature")
            {
                Caption = 'Firma del cliente';
                ApplicationArea = All;
                Editable = false;
            }


        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(RegistrarRef; Registrar)
            { }
            actionref(CuestionarioRef; cuestionario)
            { }
        }
        area(Processing)
        {
            action(Registrar)
            {
                ApplicationArea = all;
                Image = PostedOrder;
                RunObject = page "Histórico Documentos Entrega";
                RunPageLink = "Contract No." = field("Contract No.");
                trigger OnAction()
                var
                    CodeUnitRegistrar: codeunit RegistrarDocEntrega;
                    HistCabecera: record CabeceraDocEntregaHistorico;
                    HistCabeceraPage: page "Histórico Documentos Entrega";
                    ConfirmStr: Label '¿Desea abrir el documento registrado?';
                    AbrirHist: Boolean;
                    ContractNo: Code[20];
                begin

                    ContractNo := rec."Contract No.";
                    AbrirHist := false;
                    CodeUnitRegistrar.Registrar(rec."No.", rec."Contract No.");

                end;
            }
            action(Cuestionario)
            {
                Image = TaskQualityMeasure;
                trigger OnAction()
                var
                begin
                    RealDemo;
                end;
            }
        }
    }

    var
        Item: Record item;
        DSNWizardCuestionario: page DSNWizardCuestionario;
        DSNCuestionarioLine: record DSNCuestionarioLine;
        demoCuestLineHist: record DSNCuestionarioLineHist;

    procedure RealDemo()
    var
        GroupID: code[15];
        GroupID2: Code[15];
        GroupID3: Code[15];
    begin
        GroupID := '100';

        Item.Get(rec."Property No.");
        DSNCuestionarioLine.Reset();
        DSNCuestionarioLine.SetRange("Profile Questionnaire Code", Item.TipoCuestionario);
        DSNCuestionarioLine.FindSet();
        demoCuestLineHist.Reset();
        demoCuestLineHist.SetRange("No. Doc. Entrega", rec."No.");
        if not demoCuestLineHist.FindFirst() then
            repeat
                if DSNCuestionarioLine.Type = DSNCuestionarioLine.Type::"Área" then begin
                    GroupID := IncStr(GroupID);
                    GroupID2 := '0';
                    demoCuestLineHist."No. Doc. Entrega" := rec."No.";
                    demoCuestLineHist.Type := DSNCuestionarioLine.Type;
                    demoCuestLineHist."Multiple Answers" := DSNCuestionarioLine."Multiple Answers";
                    demoCuestLineHist.Description := DSNCuestionarioLine.Description;
                    demoCuestLineHist."Profile Questionnaire Code" := DSNCuestionarioLine."Profile Questionnaire Code";
                    demoCuestLineHist.GroupID := GroupID;
                    demoCuestLineHist."Line No." += 100;
                    demoCuestLineHist.GroupIDCaracteristica := '';
                    demoCuestLineHist.GroupIDMaster := '';
                    demoCuestLineHist.Insert();
                end;
                if DSNCuestionarioLine.Type = DSNCuestionarioLine.Type::"Característica" then begin
                    GroupID3 := '1';
                    demoCuestLineHist."No. Doc. Entrega" := rec."No.";
                    demoCuestLineHist.Type := DSNCuestionarioLine.Type;
                    demoCuestLineHist.Description := DSNCuestionarioLine.Description;
                    demoCuestLineHist."Multiple Answers" := DSNCuestionarioLine."Multiple Answers";
                    demoCuestLineHist."Profile Questionnaire Code" := DSNCuestionarioLine."Profile Questionnaire Code";
                    demoCuestLineHist."Line No." += 100;
                    GroupID2 := IncStr(GroupID2);
                    demoCuestLineHist.GroupID := GroupID + '-' + GroupID2;
                    demoCuestLineHist.GroupIDCaracteristica := GroupID + '-' + GroupID2;
                    demoCuestLineHist.GroupIDMaster := GroupID;
                    demoCuestLineHist.Insert();

                end;
                if DSNCuestionarioLine.Type = DSNCuestionarioLine.Type::Respuesta then begin
                    demoCuestLineHist."No. Doc. Entrega" := rec."No.";
                    demoCuestLineHist.Type := DSNCuestionarioLine.Type;
                    demoCuestLineHist.Description := DSNCuestionarioLine.Description;
                    demoCuestLineHist."Profile Questionnaire Code" := DSNCuestionarioLine."Profile Questionnaire Code";
                    demoCuestLineHist."Line No." += 100;
                    demoCuestLineHist.GroupID := GroupID + '-' + GroupID2 + '-' + GroupID3;
                    demoCuestLineHist.GroupIDCaracteristica := GroupID + '-' + GroupID2;
                    demoCuestLineHist.GroupIDMaster := GroupID;
                    demoCuestLineHist.Insert();
                    GroupID3 := IncStr(GroupID3);
                end;
            until DSNCuestionarioLine.Next() = 0;

        Item.Get(rec."Property No.");
        DSNCuestionarioLine.Reset();
        DSNCuestionarioLine.SetRange("Profile Questionnaire Code", Item.TipoCuestionario);
        DSNCuestionarioLine.FindFirst();
        demoCuestLineHist.Reset();
        demoCuestLineHist.SetRange("No. Doc. Entrega", rec."No.");
        //demoCuestLineHist.SetRange("Profile Questionnaire Code", DSNCuestionarioLine."Profile Questionnaire Code");
        demoCuestLineHist.FindFirst();
        Commit();
        Clear(DSNWizardCuestionario);
        Page.Run(Page::DSNWizardCuestionario, demoCuestLineHist)
    end;
}
