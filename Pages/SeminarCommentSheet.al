page 123456706 "Seminar Comment Sheet"
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 5 - Lab 2-2
    //     - Created new page
{
    Caption = 'Seminar Comment Sheet';
    PageType = List;
    SourceTable = "Seminar Comment Line";
    UsageCategory= Tasks;
    AutoSplitKey=true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date;Date)
                {
                }
                field(Code;Code)
                {
                    Visible=false;
                }
                field(Comment;Comment)
                {    
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewLine;
    end;
}