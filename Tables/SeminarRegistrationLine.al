table 123456711 "Seminar Registration Line"
{
    // version CSD1.00

    // CSD1.00 - 2013-03-01 - D. E. Veloper
    //   Chapter 3 - Lab 1
    //     - Created new table


    fields
    {
        field(1;"Document No.";Code[20])
        {
            TableRelation = "Seminar Registration Header";
        }
        field(2;"Line No.";Integer)
        {
        }
        field(3;"Bill-to Customer No.";Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate();
            begin
                IF "Bill-to Customer No." <> xRec."Bill-to Customer No." THEN BEGIN
                  IF Registered THEN BEGIN
                    ERROR(Text001,
                      FIELDCAPTION("Bill-to Customer No."),
                      FIELDCAPTION(Registered),
                      Registered);
                  END;
                END;
            end;
        }
        field(4;"Participant Contact No.";Code[20])
        {
            TableRelation = Contact;

            trigger OnLookup();
            begin
                ContactBusinessRelation.RESET;
                ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
                IF ContactBusinessRelation.FINDFIRST THEN BEGIN
                  Contact.SETRANGE("Company No.",ContactBusinessRelation."Contact No.");
                  IF PAGE.RUNMODAL(PAGE::"Contact List",Contact) = ACTION::LookupOK THEN BEGIN
                    "Participant Contact No." := Contact."No.";
                  END;
                END;

                CALCFIELDS("Participant Name");
            end;

            trigger OnValidate();
            begin
                IF ("Bill-to Customer No." <> '') AND
                   ("Participant Contact No." <> '')
                THEN BEGIN
                  Contact.GET("Participant Contact No.");
                  ContactBusinessRelation.RESET;
                  ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
                  ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
                  ContactBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
                  IF ContactBusinessRelation.FINDFIRST THEN BEGIN
                    IF ContactBusinessRelation."Contact No." <> Contact."Company No." THEN BEGIN
                      ERROR(Text002,Contact."No.",Contact.Name,"Bill-to Customer No.");
                    END;
                  END;
                END;
            end;
        }
        field(5;"Participant Name";Text[50])
        {
            CalcFormula = Lookup(Contact.Name WHERE ("No."=FIELD("Participant Contact No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Registration Date";Date)
        {
            Editable = false;
        }
        field(7;"To Invoice";Boolean)
        {
            InitValue = true;
        }
        field(8;Participated;Boolean)
        {
        }
        field(9;"Confirmation Date";Date)
        {
            Editable = false;
        }
        field(10;"Seminar Price";Decimal)
        {
            AutoFormatType = 2;

            trigger OnValidate();
            begin
                VALIDATE("Line Discount %");
            end;
        }
        field(11;"Line Discount %";Decimal)
        {
            DecimalPlaces = 0:5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate();
            begin
                IF "Seminar Price" = 0 THEN BEGIN
                  "Line Discount Amount" := 0;
                END ELSE BEGIN
                  GLSetup.GET;
                  "Line Discount Amount" := ROUND("Line Discount %" * "Seminar Price" * 0.01,GLSetup."Amount Rounding Precision");
                END;
                UpdateAmount;
            end;
        }
        field(12;"Line Discount Amount";Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate();
            begin
                IF "Seminar Price" = 0 THEN BEGIN
                  "Line Discount %" := 0;
                END ELSE BEGIN
                  GLSetup.GET;
                  "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100,GLSetup."Amount Rounding Precision");
                END;
                UpdateAmount;
            end;
        }
        field(13;Amount;Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate();
            begin
                TESTFIELD("Bill-to Customer No.");
                TESTFIELD("Seminar Price");
                GLSetup.GET;
                Amount := ROUND(Amount,GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                IF "Seminar Price" = 0 THEN BEGIN
                  "Line Discount %" := 0;
                END ELSE BEGIN
                  "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100,GLSetup."Amount Rounding Precision");
                END;
            end;
        }
        field(14;Registered;Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Document No.","Line No.")
        {
        }
    }

    trigger OnDelete();
    begin
        TESTFIELD(Registered,FALSE);
    end;

    trigger OnInsert();
    begin
        GetSeminarRegHeader;
        "Registration Date" := WORKDATE;
        "Seminar Price" := SeminarRegHeader."Seminar Price";
        Amount := SeminarRegHeader."Seminar Price";
    end;

    var
        SeminarRegHeader : Record "Seminar Registration Header";
        SeminarRegLine : Record "Seminar Registration Line";
        ContactBusinessRelation : Record "Contact Business Relation";
        Contact : Record Contact;
        GLSetup : Record "General Ledger Setup";
        SkipBillToContact : Boolean;
        Text001 : Label 'You cannot change the %1, because %2 is %3.';
        Text002 : Label 'Contact %1 %2 is related to a different company than customer %3.';

    procedure GetSeminarRegHeader();
    begin
        IF SeminarRegHeader."No." <> "Document No." THEN BEGIN
          SeminarRegHeader.GET("Document No.");
        END;
    end;

    procedure CalculateAmount();
    begin
        Amount := ROUND(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;

    procedure UpdateAmount();
    begin
        GLSetup.GET;
        Amount := ROUND("Seminar Price" - "Line Discount Amount",GLSetup."Amount Rounding Precision");
    end;
}

