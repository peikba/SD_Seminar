table 123456712 "Seminar Charge"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 1
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
            var
                OldType : Integer;
            begin
                if Type <> xRec.Type then begin
                  OldType:=Type;  
                  Init;
                  Type:=OldType;
                end;
            end;
        }
        field(4;"No.";Code[20])
        {
            TableRelation = if (Type=const(Resource)) Resource."No."
                            else if (Type=const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate();
            begin
                case Type of
                  Type::Resource:
                    begin
                      Resource.Get("No.");
                      Resource.TestField(Blocked,false);
                      Resource.TestField("Gen. Prod. Posting Group");
                      Description := Resource.Name;
                      "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                      "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                      "Unit of Measure Code" := Resource."Base Unit of Measure";
                      "Unit Price" := Resource."Unit Price";
                    end;
                  Type::"G/L Account":
                    begin
                      GLAccount.Get("No.");
                      GLAccount.CheckGLAcc();
                      GLAccount.TestField("Direct Posting",true);
                      Description := GLAccount.Name;
                      "Gen. Prod. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                      "VAT Prod. Posting Group" := GLAccount."VAT Bus. Posting Group";
                    end;
                end;
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
                "Total Price" := Round("Unit Price" * Quantity,0.01);
            end;
        }
        field(7;"Unit Price";Decimal)
        {
            AutoFormatType = 2;
            MinValue = 0;

            trigger OnValidate();
            begin
                "Total Price" := Round("Unit Price" * Quantity,0.01);
            end;
        }
        field(8;"Total Price";Decimal)
        {
            AutoFormatType = 1;
            Editable = false;

            trigger OnValidate();
            begin
              if (Quantity<>0) then 
                "Unit Price" := Round("Total Price" / Quantity,0.01)
              else
                "Unit Price":=0;
            end;
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
            TableRelation = if (Type=const(Resource)) "Resource Unit of Measure".Code where ("Resource No."=Field("No."))
                            else "Unit of Measure".Code;

            trigger OnValidate();
            begin
                case Type of
                  Type::Resource:
                    begin
                      Resource.Get("No.");
                      if "Unit of Measure Code" = '' then begin
                        "Unit of Measure Code" := Resource."Base Unit of Measure";
                      end;
                      ResourceUofM.Get("No.","Unit of Measure Code");
                      "Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                      "Total Price" := Round(Resource."Unit Price" * "Qty. per Unit of Measure");
                    end;
                  Type::"G/L Account":
                    begin
                      "Qty. per Unit of Measure" := 1;
                    end;
                end;
                if CurrFieldNo = FieldNO("Unit of Measure Code") then begin
                  Validate("Unit Price");
                end;
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
        TestField(Registered,false);
    end;

    trigger OnInsert();
    begin
        SeminarRegistrationHeader.Get("Document No.");
    end;

    var
        GLAccount : Record "G/L Account";
        Resource : Record Resource;
        ResourceUofM : Record "Resource Unit of Measure";
        SeminarRegistrationHeader : Record "Seminar Registration Header";
}

