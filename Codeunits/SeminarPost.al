codeunit 123456700 "Seminar-Post"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 5-2
    //     - Created new codeunit

    TableNo = 123456710;

    trigger OnRun();
    begin
    end;

    var
        SeminarRegHeader : Record "Seminar Registration Header";
        SeminarRegLine : Record "Seminar Registration Line";
        PstdSeminarRegHeader : Record "Posted Seminar Reg. Header";
        PstdSeminarRegLine : Record "Posted Seminar Reg. Line";
        SeminarCommentLine : Record "Seminar Comment Line";
        SeminarCommentLine2 : Record "Seminar Comment Line";
        SeminarCharge : Record "Seminar Charge";
        PstdSeminarCharge : Record "Posted Seminar Charge";
        Room : Record Resource;
        Instructor : Record Resource;
        Customer : Record Customer;
        ResLedgEntry : Record "Res. Ledger Entry";
        SeminarJnlLine : Record "Seminar Journal Line";
        SourceCodeSetup : Record "Source Code Setup";
        ResJnlLine : Record "Res. Journal Line";
        SeminarJnlPostLine : Codeunit "Seminar Jnl.-Post Line";
        ResJnlPostLine : Codeunit "Res. Jnl.-Post Line";
        NoSeriesMgt : Codeunit NoSeriesManagement;
        DimMgt : Codeunit DimensionManagement;
        Window : Dialog;
        SourceCode : Code[10];
        LineCount : Integer;
        Text001 : Label 'There is no participant to post.';
        Text002 : Label 'Posting lines              #2######\';
        Text003 : Label 'Registration';
        Text004 : Label 'Registration %1  -> Posted Reg. %2';
        Text005 : Label 'The combination of dimensions used in %1 is blocked. %2';
        Text006 : Label 'The combination of dimensions used in %1,  line no. %2 is blocked. %3';
        Text007 : Label 'The dimensions used in %1 are invalid. %2';
        Text008 : Label 'The dimensions used in %1, line no. %2 are invalid. %3';

    local procedure CopyCommentLines(FromDocumentType : Integer;ToDocumentType : Integer;FromNumber : Code[20];ToNumber : Code[20]);
    begin
        SeminarCommentLine.Reset;
        SeminarCommentLine.SetRange("Table Name",FromDocumentType);
        SeminarCommentLine.SetRange("No.",FromNumber);
        if SeminarCommentLine.FindSet then repeat
            SeminarCommentLine2:=SeminarCommentLine;
            SeminarCommentLine2."Table Name":=ToDocumentType;
            SeminarCommentLine2."No.":=ToNumber;
            SeminarCommentLine2.Insert;
        until SeminarCommentLine.Next=0;
    end;

    local procedure CopyCharges(FromNumber : Code[20];ToNumber : Code[20]);
    begin
        SeminarCharge.Reset;
        SeminarCharge.SetRange("Document No.",FromNumber);
        if SeminarCharge.FindSet then repeat
            PstdSeminarCharge.TransferFields(SeminarCharge);
            PstdSeminarCharge."Document No.":=ToNumber;
            PstdSeminarCharge.Insert;
        until SeminarCharge.Next=0;
    end;

    local procedure PostResJnlLine(Resource : Record Resource) : Integer;
    begin
        with SeminarRegHeader do begin
            Resource.TESTFIELD("Quantity Per Day"); 
            ResJnlLine.Init; 
            ResJnlLine."Entry Type":=ResJnlLine."Entry Type"::Usage;
            ResJnlLine."Document No.":=PstdSeminarRegHeader."No.";
            ResJnlLine."Resource No.":=Resource."No.";
            ResJnlLine."Posting Date" := "Posting Date"; 
            ResJnlLine."Reason Code" := "Reason Code"; 
            ResJnlLine.Description := "Seminar Name";
            ResJnlLine."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group"; 
            ResJnlLine."Posting No. Series" := "Posting No. Series"; 
            ResJnlLine."Source Code" := SourceCode;
            ResJnlLine."Resource No." := Resource."No.";
            ResJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure"; 
            ResJnlLine."Unit Cost" := Resource."Unit Cost";
            ResJnlLine."Qty. per Unit of Measure" := 1;
            ResJnlLine.Quantity := Duration * Resource."Quantity Per Day"; 
            ResJnlLine."Total Cost" := ResJnlLine."Unit Cost" * ResJnlLine.Quantity; 
            ResJnlLine."Seminar No." := "Seminar No.";
            ResJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No."; 
            ResJnlPostLine.RunWithCheck(ResJnlLine);
            ResLedgEntry.FindLast;
            exit(ResLedgEntry."Entry No.");
        end;
    end;

    local procedure PostSeminarJnlLine(ChargeType : Option Instructor,Room,Participant,Charge);
    begin
    end;

    local procedure PostCharges();
    begin
    end;
}

