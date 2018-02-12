page 123456700 "Seminar Setup"
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
                field("Seminar Registration";"Seminar Registration Nos.")
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