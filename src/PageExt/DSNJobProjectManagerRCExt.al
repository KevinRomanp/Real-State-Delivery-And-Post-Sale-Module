pageextension 52100 "DSNJob Project Manager RC Ext" extends "Job Project Manager RC"
{
    actions
    {
        addlast(embedding)
        {
            action(ListaDocEntrega)
            {
                ApplicationArea = Jobs;
                Caption = 'ListaDocEntrega';
                RunObject = Page ListaDocEntregaPropiedades;

            }
        }
    }
}
