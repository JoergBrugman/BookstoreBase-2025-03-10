namespace GuATraining.Book.Books;

/// <summary>
/// Book is the Mater Table for books
/// </summary>
table 50100 "BSB Book"
{
    Caption = 'Book';
    DataCaptionFields = "No.", Description;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[100]) { Caption = 'Description'; }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description'; //[ ] Muss noch standardkonform versorgt werden
        }
        field(4; Blocked; Boolean) { Caption = 'Blocked'; }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",Hardcover,Paperback;
            OptionCaption = ' ,Hardcover,Paperback';
        }
        field(7; Created; Date)
        {
            Caption = 'Created'; //TODO Muss automatisch gestezt werden
            Editable = false;
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified'; //TODO Muss automatisch gestezt werden
            Editable = false;
        }
        field(10; Author; Text[50]) { Caption = 'Author'; }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(15; ISBN; Code[20]) { Caption = 'ISBN'; }
        field(16; "No. of Pages"; Integer)
        {
            Caption = 'No. of Pages';
            MinValue = 0;
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Edition No.';
            MinValue = 0;
        }
        field(18; "Date of Publishing"; Date) { Caption = 'Date of Publishing'; }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    //TODO Ein Buch darf nicht gelöscht werden.
    //TODO TestBlocked() noch implementieren.
}