page 123456724 "Seminar Charges"
{
    // version CSD1.00

    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 2
    //     - Created new page

    AutoSplitKey = true;
    Caption = 'Seminar Charges';
    PageType = List;
    SourceTable = "Seminar Charge";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                }
                field(Description;Description)
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Total Price";"Total Price")
                {
                }
                field("To Invoice";"To Invoice")
                {
                }
            }
        }
    }

    actions
    {
    }
}

