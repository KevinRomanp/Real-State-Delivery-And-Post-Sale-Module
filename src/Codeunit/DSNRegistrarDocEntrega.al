codeunit 52100 RegistrarDocEntrega
{
    var
        HistCabeceraDocEntrega: record CabeceraDocEntregaHistorico;
        CabeceraDocEntrega: record "Cabecera Documento Entrega";
        DSConfigurationRealEstateRecord: Record "DSConfiguration Real Estate";
        NoSeriesManagementCodeunit: Codeunit NoSeriesManagement;
        DSNCuestionarioLineHist: record DSNCuestionarioLineHist;
        DSContractRealEstate: record "DSContract Real Estate";

    procedure Registrar(var NoDoc: code[20]; var NoContrato: Code[20])
    begin
        CabeceraDocEntrega.Get(NoDoc, NoContrato);
        CabeceraDocEntrega.TestField("Property No.");
        CabeceraDocEntrega.TestField(Buyer);
        CabeceraDocEntrega.TestField(Signature);


        HistCabeceraDocEntrega.Init();
        HistCabeceraDocEntrega.TransferFields(CabeceraDocEntrega);
        CabeceraDocEntrega.CalcFields(Signature);
        HistCabeceraDocEntrega.Signature := CabeceraDocEntrega.Signature;
        DSConfigurationRealEstateRecord.Get();
        DSConfigurationRealEstateRecord.TestField("No Serie Doc Entrega");
        HistCabeceraDocEntrega."No." := NoSeriesManagementCodeunit.GetNextNo(DSConfigurationRealEstateRecord.NoSerieDocEntregaRegistrado, Today(), true);
        HistCabeceraDocEntrega.Insert();

        DSNCuestionarioLineHist.Reset();
        DSNCuestionarioLineHist.SetRange("No. Doc. Entrega", NoDoc);
        DSNCuestionarioLineHist.FindSet();
        repeat
            DSNCuestionarioLineHist."No. Doc. Entrega Registrado" := HistCabeceraDocEntrega."No.";
            DSNCuestionarioLineHist.Modify();
        until DSNCuestionarioLineHist.Next() = 0;
        DSContractRealEstate.get(CabeceraDocEntrega."Contract No.");
        DSContractRealEstate."Unit Delivered" := true;
        DSContractRealEstate."No Doc Entrega Registrado" := HistCabeceraDocEntrega."No.";
        DSContractRealEstate."Delivery date" := HistCabeceraDocEntrega.Date;
        DSContractRealEstate.Modify();

        CabeceraDocEntrega.Delete();
    end;
}
