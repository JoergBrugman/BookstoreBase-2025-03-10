namespace GuATraining.Book.Books;

/// <summary>
/// Book is the Mater Table for books
/// </summary>
table 50100 "BSB Book"
{
    Caption = 'Book';
    DataCaptionFields = "No.", Description;
    LookupPageId = "BSB Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description', Comment = 'de-DE=Beschreibung';
            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description'; //[x] Muss noch standardkonform versorgt werden
        }
        field(4; Blocked; Boolean) { Caption = 'Blocked'; }
        field(5; Type; Enum "BSB Book Type")
        {
            Caption = 'Type';
        }
        field(7; Created; Date)
        {
            Caption = 'Created';
            Editable = false;
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
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

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Author, "No. of Pages", ISBN, Type, "Edition No.") { }
    }

    var
        OnDeleteBookErr: Label 'A Book cannot be deleted';

    trigger OnInsert()
    begin
        Created := Today;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        OnBeforeOnDelete(Rec, IsHandled);
        if IsHandled then
            exit;

        Error(OnDeleteBookErr);
    end;

    procedure TestBlocked()
    begin
        TestField(Blocked, false);
    end;

    /// <summary>
    /// Opens the Book Card based on Rec.
    /// </summary>
    procedure ShowCard()
    begin
        ShowCard(Rec);
    end;

    /// <summary>
    ///  First read the Book-Record based on BookNo and the opens the Book Card based on read record.
    /// </summary>
    /// <param name="BookNo">No. of Record to read</param>
    procedure ShowCard(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if not BSBBook.Get(BookNo) then
            exit;
        ShowCard(BSBBook);
    end;

    /// <summary>
    /// Opens the Book Card based on given Record
    /// </summary>
    /// <param name="BSBBook">Record to show</param>
    local procedure ShowCard(BSBBook: Record "BSB Book")
    begin
        Page.Run(page::"BSB Book Card", BSBBook);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}