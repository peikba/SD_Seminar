codeunit 123456734 SeminarRegShowLedger
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-10
{
    TableNo="Seminar Register";

    trigger OnRun();
    begin
        SeminarLedgerEntry.SETRANGE("Entry No.", "From Entry No.", "To Entry No.");
        page.Run(Page::"Seminar Ledger Entries", SeminarLedgerEntry);
    end;

    var
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
}