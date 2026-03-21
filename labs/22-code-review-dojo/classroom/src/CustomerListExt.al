pageextension 50100 CustomerListExt extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("Phone No."; Rec."Phone No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
