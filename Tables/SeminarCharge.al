table 123456712 "Seminar Charge"
{
    // version CSD1.00

    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 3 - Lab 1
    //     - Created new table

    fields
    {
        field(1;"Document No.";Code[20])
        {
            NotBlank = true;
            TableRelation = "Seminar Registration Header";
        }
        field(2;"Line No.";Integer)
        {
        }
        field(3;Type;Option)
        {
            OptionCaption = 'Resource,G/L Account';
            OptionMembers = Resource,"G/L Account";

            trigger OnValidate();
            begin
                IF Type <> xRec.Type THEN BEGIN
                  Description := '';
                END;
            end;
        }
        field(4;"No.";Code[20])
        {
            TableRelation = IF (Type=CONST(Resource)) Resource."No."
                            ELSE IF (Type=CONST("G/L Account")) "G/L Account"."No.";

            trigger OnValidate();
            begin
                CASE Type OF
                  Type::Resource:
                    BEGIN
                      Resource.GET("No.");
                      Resource.TESTFIELD(Blocked,FALSE);
                      Resource.TESTFIELD("Gen. Prod. Posting Group");
                      Description := Resource.Name;
                      "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                      "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                      "Unit of Measure Code" := Resource."Base Unit of Measure";
                      "Unit Price" := Resource."Unit Price";
                    END;
                  Type::"G/L Account":
                    BEGIN
                      GLAccount.GET("No.");
                      GLAccount.CheckGLAcc();
                      GLAccount.TESTFIELD("Direct Posting",TRUE);
                      Description := GLAccount.Name;
                      "Gen. Prod. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                      "VAT Prod. Posting Group" := GLAccount."VAT Bus. Posting Group";
                    END;
                END;
            end;
        }
        field(5;Description;Text[50])
        {
        }
        field(6;Quantity;Decimal)
        {
            DecimalPlaces = 0:5;

            trigger OnValidate();
            begin
                "Total Price" := ROUND("Unit Price" * Quantity,0.01);
            end;
        }
        field(7;"Unit Price";Decimal)
        {
            AutoFormatType = 2;
            MinValue = 0;

            trigger OnValidate();
            begin
                "Total Price" := ROUND("Unit Price" * Quantity,0.01);
            end;
        }
        field(8;"Total Price";Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(9;"To Invoice";Boolean)
        {
            InitValue = true;
        }
        field(10;"Bill-to Customer No.";Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(11;"Unit of Measure Code";Code[10])
        {
            TableRelation = IF (Type=CONST(Resource)) "Resource Unit of Measure".Code WHERE ("Resource No."=FIELD("No."))
                            ELSE "Unit of Measure".Code;

            trigger OnValidate();
            begin
                CASE Type OF
                  Type::Resource:
                    BEGIN
                      Resource.GET("No.");
                      IF "Unit of Measure Code" = '' THEN BEGIN
                        "Unit of Measure Code" := Resource."Base Unit of Measure";
                      END;
                      ResourceUofM.GET("No.","Unit of Measure Code");
                      "Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                      "Total Price" := ROUND(Resource."Unit Price" * "Qty. per Unit of Measure");
                    END;
                  Type::"G/L Account":
                    BEGIN
                      "Qty. per Unit of Measure" := 1;
                    END;
                END;
                IF CurrFieldNo = FIELDNO("Unit of Measure Code") THEN BEGIN
                  VALIDATE("Unit Price");
                END;
            end;
        }
        field(12;"Gen. Prod. Posting Group";Code[10])
        {
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(13;"VAT Prod. Posting Group";Code[10])
        {
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(14;"Qty. per Unit of Measure";Decimal)
        {
        }
        field(15;Registered;Boolean)
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

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TESTFIELD(Registered,FALSE);
    end;

    trigger OnInsert();
    begin
        SeminarRegistrationHeader.GET("Document No.");
    end;

    var
        GLAccount : Record "G/L Account";
        Resource : Record Resource;
        ResourceUofM : Record "Resource Unit of Measure";
        SeminarRegistrationHeader : Record "Seminar Registration Header";
}

