pageextension 123456700 ResourceCardExt extends "Resource Card"
// CSD1.00 - 2012-06-15 - D. E. Veloper
// Chapter 5 - Lab 2
// Added new fields:
// - Internal/External
// - Maximum Participants
// Added new FastTab 
// Added code to OnOpenPage trigger
{
    layout
    {
        addlast(General)
        {
            field("Resource Type"; "Resource Type")
            {
            }
        }

        addafter("Personal Data")
        {
            group("Room")
            {
                field("Maximum Participants"; "Maximum Participants")
                {
                    Visible = ShowMaxField;
                }
            }
        }
    }


    trigger OnOpenPage();
    begin
        ShowMaxField := (Type = Type::Machine);
        CurrPage.Update(false);
    end;

    var
        [InDataSet]
        ShowMaxField: Boolean;
}