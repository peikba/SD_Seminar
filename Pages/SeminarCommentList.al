page 123456707 "Seminar Comment List"
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 5 - Lab 2-2
    //     - Created new page
{
    Caption = 'Seminar Comment List';
    PageType = List;
    SourceTable = "Seminar Comment Line";
    UsageCategory= Tasks;
    Editable=false;

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
}