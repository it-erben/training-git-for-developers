codeunit 50100 CustomerExport
{
    procedure ExportCustomers()
    var
        Customer: Record Customer;
        OutStream: OutStream;
        InStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        Customer.SetFilter("Country/Region Code", 'DE');

        Customer.FindSet();

        TempBlob.CreateOutStream(OutStream);
        repeat
            OutStream.WriteText(Customer."No." + ';' + Customer.Name + ';' + Customer."Phone No.");
            OutStream.WriteText();
        until Customer.Next() = 0;

        TempBlob.CreateInStream(InStream);
        FileName := 'customers_export.csv';
        DownloadFromStream(InStream, 'Export', '', 'CSV Files|*.csv', FileName);
    end;
}
