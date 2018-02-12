table 123456701 Seminar
{

    fields
    {
        field(10;"No.";Code[20])
        {
            Caption='No.';
        }
        field(20;Name;Text[50])
        {   
            Caption='Name';
        }
        field(30;"Search Name";Text[50])
        {
            Caption='Search Name';
        }
        field(40;"Duration";Decimal)
        {
            Caption='Duration';
        }
        field(50;"Minimum Participants";Integer)
        {
            Caption='Minimum Participants';
        }
        field(60;"Maximum Participants";Integer)
        {
            Caption='Maximum Participants';
        }
        field(70;Blocked;Boolean)
        {
            Caption='Blocked';
        }
        field(80;"Last Date Modified";Date)
        {
            Caption='Last Date Modified';
            Editable=false;
        }
        field(90;Comment;Boolean)
        {
            Caption='Comment';
            FieldClass=FlowField;
            CalcFormula=exist("Comment Line" where("Table Name"=const(123456701),"No."=Field("No.")));
        }
        field(100;"Seminar Price";Decimal)
        {
            Caption='Seminar Price';
        }
        field(110;"Gen. Prod. Posting Group";code[10])
        {
            Caption='Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(120;"VAT Prod. Posting Group";code[10])
        {
            Caption='VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(130;"No. Series";Code[10])
        {
            Caption='No. Series';
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