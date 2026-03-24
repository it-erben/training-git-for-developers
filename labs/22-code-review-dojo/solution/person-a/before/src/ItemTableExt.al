tableextension 50100 ItemTableExt extends Item
{
    fields
    {
        field(50100; "Special Discount %"; Decimal)
        {
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
                ToolTip = 'Discount';
            }
        }
    }
}
