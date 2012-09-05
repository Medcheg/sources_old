unit Unit_About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TfrmAbout = class(TForm)
    OKButton: TButton;
    Panel1: TPanel;
    Image1: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Comments: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    PhysMem: TLabel;
    FreeRes: TLabel;
    CpuLabel: TLabel;
    Image2: TImage;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    procedure Label2Click(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public


    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses ShellApi, mpiDeclaration;

{$R *.DFM}

procedure TfrmAbout.Label2Click(Sender: TObject);
begin
  ShellExecute(Handle,'open', PChar(TLabel(Sender).Caption),nil,nil,SW_SHOW);
end;

procedure TfrmAbout.OKButtonClick(Sender: TObject);
begin
  Close;
end;

function GetCPUSpeed: Double;
const
  DelayTime = 200;
var
  TimerHi, TimerLo: Cardinal;
  PriorityClass, Priority: Integer;
begin
  PriorityClass := GetPriorityClass(GetCurrentProcess);
  Priority := GetThreadPriority(GetCurrentThread);
  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
  Sleep(10);
  asm
    dw 310Fh // rdtsc
    mov TimerLo, eax
    mov TimerHi, edx
  end;
  Sleep(DelayTime);
  asm
    dw 310Fh // rdtsc
    sub eax, TimerLo
    sbb edx, TimerHi
    mov TimerLo, eax
    mov TimerHi, edx
  end;
  SetThreadPriority(GetCurrentThread, Priority);
  SetPriorityClass(GetCurrentProcess, PriorityClass);
  Result := TimerLo / (1000.0 * DelayTime);
end;

procedure TfrmAbout.FormActivate(Sender: TObject);
var
  MS: TMemoryStatus;
begin
  ProductName.Caption := ProjectCaption;

  GlobalMemoryStatus(MS);

  PhysMem.Caption  := 'Всего физической памяти : '      + FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
  FreeRes.Caption  := 'Используется в данный момент : ' + Format('%d %%', [MS.dwMemoryLoad]);
  CpuLabel.Caption := 'Частота процессора : ';
  
  Application.ProcessMessages;
  CpuLabel.Caption := CpuLabel.Caption + FloatToStr(Round(GetCPUSpeed*10)/10)+' МГц';
end;

end.

