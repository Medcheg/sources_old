; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Digital & Analog Laboratory 2.0
AppVerName=DiALab 2.0
AppPublisher=Digital systems & technologies
AppPublisherURL=http://www.dst.com.ua
AppSupportURL=http://www.dst.com.ua
AppUpdatesURL=http://www.dst.com.ua
DefaultDirName={pf}\DST\DiALab 2.0
DefaultGroupName=\DST\DiALab 2.0
Compression=lzma
SolidCompression=yes
WindowVisible=yes


[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
;Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\_Programs\Work\DiALab\DiALab 2.0\Project\DiALab.exe"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[INI]
Filename: "{app}\DiALab.url"; Section: "InternetShortcut"; Key: "URL"; String: "http://www.dst.com.ua"

[Icons]
Name: "{group}\DiALab 2.0"; Filename: "{app}\DiALab.exe"
Name: "{group}\{cm:ProgramOnTheWeb,Digital & Analog Laboratory}"; Filename: "{app}\DiALab.url"
Name: "{group}\{cm:UninstallProgram,Digital & Analog Laboratory}"; Filename: "{uninstallexe}"
Name: "{userdesktop}\DiALab 2.0"; Filename: "{app}\DiALab.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\DiALab.exe"; Description: "{cm:LaunchProgram,Digital and Analog Laboratory}"; Flags: nowait postinstall skipifsilent

;[Registry]
;Root: HKCU; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKCU; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKCU; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "Name"; ValueData: "{code:GetUser|Name}"
;Root: HKCU; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "Company"; ValueData: "{code:GetUser|Company}"
;Root: HKCU; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "DataDir"; ValueData: "{code:GetDataDir}"
; etc.

[UninstallDelete]
Type: files; Name: "{app}\DiALab.url"

[Code]
procedure AboutButtonOnClick(Sender: TObject);
begin
  MsgBox('This demo shows some features of the WizardForm object and the various VCL classes.', mbInformation, mb_Ok);
end;

procedure URLLabelOnClick(Sender: TObject);
var
  Dummy: Integer;
begin
  InstShellExec('http://www.dst.com.ua', '', '', SW_SHOWNORMAL, Dummy);
end;

procedure InitializeWizard();
var
//  AboutButton,
  CancelButton: TButton;
  URLLabel: TNewStaticText;
//  BackgroundBitmapImage: TBitmapImage;
//  BackgroundBitmapText: TNewStaticText;
begin
  CancelButton := WizardForm.CancelButton;
{
  AboutButton := TButton.Create(WizardForm);
  AboutButton.Left := WizardForm.ClientWidth - CancelButton.Left - CancelButton.Width;
  AboutButton.Top := CancelButton.Top;
  AboutButton.Width := CancelButton.Width;
  AboutButton.Height := CancelButton.Height;
  AboutButton.Caption := '&About...';
  AboutButton.OnClick := @AboutButtonOnClick;
  AboutButton.Parent := WizardForm;
}
  URLLabel            := TNewStaticText.Create(WizardForm);
  URLLabel.Top        := CancelButton.Top + (CancelButton.Height - URLLabel.Height) / 2;
  URLLabel.Left       := 5;
  URLLabel.Caption    := 'http://www.dst.com.ua';
  URLLabel.Font.Style := URLLabel.Font.Style + [fsUnderLine];
  URLLabel.Font.Color := clBlue;
  URLLabel.Cursor     := crHand;
  URLLabel.OnClick    := @URLLabelOnClick;
  URLLabel.Parent     := WizardForm;
end;

