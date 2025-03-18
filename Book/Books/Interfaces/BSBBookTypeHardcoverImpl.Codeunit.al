codeunit 50110 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Pick from Bin');
    end;

    procedure StartDeliverBook()
    begin
        Message('UPS Premium');
    end;
}