codeunit 123456739 EventSubscriptions
{
[EventSubscriber(ObjectType::Codeunit, 212,'OnBeforeResLedgEntryInsert', '', true, true)]
local procedure PostResJnlLineOnBeforeResLedgEntryInsert(var ResLedgerEntry : Record "Res. Ledger Entry";ResJournalLine : Record "Res. Journal Line");
var
  c : Codeunit "Res. Jnl.-Post Line";
begin   
    ResLedgerEntry."Seminar No.":=ResJournalLine."Seminar No.";
    ResLedgerEntry."Seminar Registration No.":=ResJournalLine."Seminar Registration No."; 
end;

}