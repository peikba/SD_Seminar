page 123456700 "Seminar Setup"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 3-4
{
    PageType = Card;
    SourceTable = "Seminar Setup";
    Caption='Seminar Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Seminar Nos.";"Seminar Nos.")
                {
                }
                field("Seminar Registration Nos.";"Seminar Registration Nos.")
                {
                }
                field("Posted Seminar Reg. Nos.";"Posted Seminar Reg. Nos.")
                {
                }
            }
        }
    }

trigger OnOpenPage();
begin
    if not get then begin
        init;
        insert;
    end;
end;
}