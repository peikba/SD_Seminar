table 50100 Seminar
{

    fields
    {
        field(50100;"No.";Code[80])
        {
            CaptionML=ENU='No.';
        }
        field(50101;"Name";Text[50])
        {
            CaptionML=ENU='Name';
        }
        field(50102;Description;Text[50])
        {
            CaptionML=ENU='Description';
        }
    }

    keys
    {
        key(PK;"No.")
        {
            Clustered = true;
        }
    }
    
    var
        myInt : Integer;

    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

}