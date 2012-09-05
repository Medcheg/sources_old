unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Printers, WinSpool;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
  private
     procedure SetPageSizes( APageLength, APageWidth : Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.SetPageSizes( APageLength, APageWidth : Integer);
var
  Handle      : THandle;
  StubDevMode : TDeviceMode;
  NewDevMode : ^TDeviceMode;
  ADevice, ADriver, APort : array[0..255] of Char;
  hPrinter : THandle;
  qwe : integer;
begin
  Printer.GetPrinter( ADevice, ADriver, APort, Handle);
  if not OpenPrinter( ADevice, hPrinter, nil ) then
    raise EPrinter.Create( SysErrorMessage( GetLastError ));
  try
      qwe        := DocumentProperties(0, hPrinter,ADevice, StubDevMode, StubDevMode, 0);
      Handle     := GlobalAlloc( GHND,  qwe);
      NewDevMode := GlobalLock(Handle);
      DocumentProperties( 0, hPrinter, ADevice, NewDevMode^,NewDevMode^,DM_OUT_BUFFER);
      try
        NewDevMode.dmFields      := NewDevMode.dmFields or DM_COPIES or DM_ORIENTATION or DM_PAPERSIZE or DM_PAPERLENGTH or DM_PAPERWIDTH;
        NewDevMode.dmCopies      := 2;
        NewDevMode.dmOrientation := DMORIENT_LANDSCAPE;
        NewDevMode.dmPaperSize   := DMPAPER_USER;
        NewDevMode.dmPaperLength := APageLength;
        NewDevMode.dmPaperWidth  := APageWidth;
        DocumentProperties( Self.Handle, hPrinter, ADevice, NewDevMode^, NewDevMode^, DM_IN_PROMPT or DM_OUT_BUFFER);
      finally
        GlobalUnlock(Handle);
      end;
      Printer.SetPrinter( ADevice, ADriver, APort, Handle);
  finally
    ClosePrinter( hPrinter );
  end;
  Label1.caption := 'Page Width        = ' + intToStr(NewDevMode^.dmPaperWidth);
  Label2.caption := 'Page Height       = ' + intToStr(NewDevMode^.dmPaperLength);
  Label3.caption := 'Page Orientation  = ' + intToStr(NewDevMode^.dmOrientation);
  Label4.caption := 'Page Size         = ' + intToStr(NewDevMode^.dmPaperSize);
  Label5.caption := 'Copies            = ' + intToStr(NewDevMode^.dmCopies);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   SetPageSizes( 1500, 1300);

   {   Printer.BeginDoc;
   with Printer.Canvas do begin
     MoveTo(100, 100);
     lineTo(100, 5500);
   end;
   Printer.EndDoc;
}
end;

end.
