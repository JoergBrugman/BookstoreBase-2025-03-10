codeunit 50100 "BSB Subscriber Store"
{
    var
        FavoriteBookHintMsg: Label 'Do not forget to enter %1 in %2 %3 %4';

    // [EventSubscriber(ObjectType::Table, Database::Customer, OnAfterOnInsert, '', false, false)]
    // local procedure Customer_OnAfterOnInsert(var Customer: Record Customer; xCustomer: Record Customer)
    // begin

    // end;


    [EventSubscriber(ObjectType::Table, Database::Customer, OnBeforeInsertEvent, '', true, true)]
    local procedure FavoriteBookHintCustOnAfterInertEvent(var Rec: Record Customer)
    begin
        if Rec."BSB Favorite Book No." = '' then
            Message(FavoriteBookHintMsg,
                Rec.FieldCaption("BSB Favorite Book No."),
                Rec.TableCaption,
                Rec."No.",
                Rec.Name);
    end;
}