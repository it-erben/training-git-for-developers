codeunit 50100 CustomerExport
{
    var
        NoDataFoundErr: Label 'No customers found for the selected filter.';
        ExportDialogTitleLbl: Label 'Export Customers';
        CsvFilterLbl: Label 'CSV Files|*.csv';
        DefaultFileNameLbl: Label 'customers_export.csv';
        CsvSeparator: Label ';';

    procedure ExportCustomers(CountryFilter: Code[10])
    var
        Customer: Record Customer;
        OutStream: OutStream;
        InStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        if CountryFilter <> '' then
            Customer.SetFilter("Country/Region Code", CountryFilter);

        if not Customer.FindSet() then
            Error(NoDataFoundErr);

        TempBlob.CreateOutStream(OutStream);
        repeat
            OutStream.WriteText(
                Customer."No." + CsvSeparator + Customer.Name + CsvSeparator + Customer."Phone No."
            );
            OutStream.WriteText();
        until Customer.Next() = 0;

        TempBlob.CreateInStream(InStream);
        FileName := DefaultFileNameLbl;
        DownloadFromStream(InStream, ExportDialogTitleLbl, '', CsvFilterLbl, FileName);
    end;
}
