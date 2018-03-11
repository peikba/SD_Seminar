tableextension 123456701 SourceCodeSetupExt extends "Source Code Setup"
// CSD1.00 - 2012-06-15 - D. E. Veloper
// Chapter 7 - Lab 1-7
// -	Added new fields:
// -	Seminar
{
    fields
    {
        field(123456700;Seminar;Code[10])
        {
            Caption='Seminar';
            TableRelation="Source Code";
        }
    }
}