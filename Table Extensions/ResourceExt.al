tableextension 123456700 ResourceExt extends Resource
// CSD1.00 - 2012-06-15 - D. E. Veloper
// Chapter 5 - Lab 1-1
// -	Added new fields:
// -	Internal/External
// -	Maximum Participants
{
    fields
    {
        field(123456700;"Resource Type";Option)
        {
            Caption = 'Resource Type';
            OptionMembers = "Internal","External";
            OptionCaption = 'Internal,External';
        }
        field(123456701;"Maximum Participants";Integer)
        {
            Caption = 'Maximum Participants';
        }
    }
}


