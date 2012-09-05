unit Select;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin;

type
  TfmSelect = class(TForm)
    SelectTay: TCheckBox;
    SelectA: TCheckBox;
    SelectTime: TRadioButton;
    SelectSort: TRadioButton;
    ContrastEdit: TSpinEdit;
    Label1: TLabel;
    DeltaTEdit: TSpinEdit;
    Label2: TLabel;
    SelectContrastIn: TCheckBox;
    DeltaTayEdit: TSpinEdit;
    DeltaAEdit: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    NEdit: TSpinEdit;
    deltaNfEdit: TSpinEdit;
    Label6: TLabel;
    SelectOn: TCheckBox;
    EditBegSel: TEdit;
    Label7: TLabel;
    EditEndSel: TEdit;
    Label8: TLabel;
    procedure TayEditKeyPress(Sender: TObject; var Key: Char);
    procedure AEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure SelectOnClick(Sender: TObject);
//    procedure TayClick(Sender: TObject);
  //  procedure SetAClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelect: TfmSelect;

implementation

uses Passiv, MapUnit;

{$R *.DFM}

procedure TfmSelect.TayEditKeyPress(Sender: TObject; var Key: Char);

var
  T: String;
  P, E: Byte;
begin
  with Sender as TEdit do begin
    T := Text;
    if SelLength > 0 then Delete(T, SelStart + 1, SelLength);
    if Key = 'E' then Key := 'e';
    P := Pos(Key, T);
    case Key of
      '+', '-':   if Length(T) > 0 then begin
                  if (SelStart = 0) and (T[1] in ['+', '-', 'e']) then
                                                               Key := #0;
                  if (SelStart > 0) and (T[SelStart] <> 'e')
            or ((Length(T) > SelStart) and (T[SelStart + 1]in ['+', '-']))
                                                          then Key := #0;
                end;
      'e', 'E': if (SelStart = 0) or (T[SelStart] in ['+', '-']) or
                                                 (P <> 0) then Key := #0;
      '0'..'9': if (Length(T) > SelStart) and (T[SelStart + 1]in['+', '-'])
                                                          then Key := #0;
      #8: ;
    else
      if Key = DecimalSeparator then begin
        e := Pos('e', T);
        if ((e > 0 ) and (e <= SelStart)) or (P <> 0) or
           (Length(T) > SelStart) and (T[SelStart + 1] in ['+', '-'])
            then Key := #0;
      end
      else Key := #0
    end;
  end;
end;


procedure TfmSelect.AEditKeyPress(Sender: TObject; var Key: Char);

var
  T: String;
  P, E: Byte;
begin
  with Sender as TEdit do begin
    T := Text;
    if SelLength > 0 then Delete(T, SelStart + 1, SelLength);
    if Key = 'E' then Key := 'e';
    P := Pos(Key, T);
    case Key of
      '+', '-': if Length(T) > 0 then begin
                  if (SelStart = 0) and (T[1] in ['+', '-', 'e']) then
                                                                Key := #0;
                  if (SelStart > 0) and (T[SelStart] <> 'e') or
      ((Length(T) > SelStart) and (T[SelStart + 1] in ['+', '-']))
                                                           then Key := #0;
                end;
      'e', 'E': if (SelStart = 0) or (T[SelStart] in ['+', '-']) or
                                                   (P <> 0)then Key := #0;
      '0'..'9': if (Length(T) > SelStart) and (T[SelStart + 1] in
                                                 ['+', '-'])then Key := #0;
      #8: ;
    else
      if Key = DecimalSeparator then begin
        e := Pos('e', T);
        if ((e > 0 ) and (e <= SelStart)) or (P <> 0) or
           (Length(T) > SelStart) and (T[SelStart + 1] in ['+', '-'])
                                                           then Key := #0;
      end
                                                            else Key := #0
    end;
  end;
end;

procedure TfmSelect.FormCreate(Sender: TObject);
begin
   if fmSelect.SelectOn.Checked = True then
                      fmPassivRadar.EdCopy.EditorEnabled:=False;
end;

procedure TfmSelect.SelectOnClick(Sender: TObject);
begin
     if SelectOn.Checked=False then
     fmPassivradar.ScaleEdit.Value:=20;
     
end;

end.
