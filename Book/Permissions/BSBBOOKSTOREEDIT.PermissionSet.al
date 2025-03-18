namespace GuATraining.Book.Permissions;

using GuATraining.Book.Books;
using GuATraining.UpdateInstall;
using Microsoft.Sales.Customer;

permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    Caption = 'Edit and Create Books etc.';
    // Assignable = true;
    Permissions = tabledata "BSB Book" = RIMD,
        table "BSB Book" = X,
        tabledata "BSB Internal Log" = RIMD,
        table "BSB Internal Log" = X;
}