tableextension 50100 ItemTableExt extends Item
{
    fields
    {
        field(50100; "Special Discount %"; Decimal)
        {
            ApplicationArea = All;
            Caption = 'Special Discount %';
            MinValue = 0;
            MaxValue = 100;
        }
    }
}

pageextension 50101 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter("Unit Price")
        {
            field("Special Discount %"; Rec."Special Discount %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a special discount percentage for this item.';
            }
        }
    }
}
