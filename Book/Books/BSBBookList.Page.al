page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = "BSB Book";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "BSB Book Card";

    layout
    {
        area(Content)
        {
            repeater(Books)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.', Comment = '%';
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    ToolTip = 'Specifies the value of the No. of Pages field.', Comment = '%';
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(CreateBooks_Promoted; CreateBooks) { }
        }
        area(Processing)
        {
            action(CreateBooks)
            {
                Caption = 'Create Books';
                Image = CreateDocuments;
                ToolTip = 'Executes the Creatipn of 100 Books.';
                RunObject = codeunit "BSB Create Books";
            }

            action(SalesClassic)
            {
                Caption = 'Classic Programming';
                Image = Action;

                trigger OnAction()
                var
                    IsHandled: Boolean;
                begin
                    OnBeforeStartBookProcess(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "BSB Book Type"::" ":
                            begin
                                StartDeployBookEmpty();
                                StartDeliverBookEmpty();
                            end;
                        "BSB Book Type"::Hardcover:
                            begin
                                StartDeployBookHardcover();
                                StartDeliverBookHardcover();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                StartDeployBookPaperback();
                                StartDeliverBookPaperback();
                            end;
                        else
                            Error('Type unknown');
                    end;
                end;
            }

            action(SalesWithInterface)
            {
                Caption = 'Sales with Interface';
                Image = Action;

                trigger OnAction()
                var
                    BSBBookTypeEmptyImpl: Codeunit "BSB Book Type Empty Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    BookTypeProcessInterface: Interface "BSB Book Type Process";
                begin
                    case Rec.Type of
                        "BSB Book Type"::" ":
                            BookTypeProcessInterface := BSBBookTypeEmptyImpl;
                        "BSB Book Type"::Hardcover:
                            BookTypeProcessInterface := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BookTypeProcessInterface := BSBBookTypePaperbackImpl;
                        else
                            OnGetBookTypeInterface(Rec, BookTypeProcessInterface);
                    end;
                    BookTypeProcessInterface.StartDeployBook();
                    BookTypeProcessInterface.StartDeliverBook();
                end;

            }
            action(SalesInterfaceWithEnum)
            {
                Caption = 'Interface incl. Enum';
                Image = Action;

                trigger OnAction()
                var
                    BookTypeProcessInterface: Interface "BSB Book Type Process";
                begin
                    BookTypeProcessInterface := Rec.Type;
                    BookTypeProcessInterface.StartDeployBook();
                    BookTypeProcessInterface.StartDeliverBook();
                end;
            }
        }
    }

    local procedure StartDeployBookEmpty()
    begin
        Message('Not Implemented');
    end;

    local procedure StartDeliverBookEmpty()
    begin
        Message('Not Implemented');
    end;

    local procedure StartDeployBookHardcover()
    begin
        Message('Pick from Bin');
    end;

    local procedure StartDeliverBookHardcover()
    begin
        Message('UPS Premium');
    end;

    local procedure StartDeployBookPaperback()
    begin
        Message('Print on Demand');
    end;

    local procedure StartDeliverBookPaperback()
    begin
        Message('DPD Standard');
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStartBookProcess(var BSBBook: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetBookTypeInterface(Rec: Record "BSB Book"; var BookTypeImpl: Interface "BSB Book Type Process")
    begin
    end;
}