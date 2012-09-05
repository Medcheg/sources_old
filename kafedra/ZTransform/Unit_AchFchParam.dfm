object frmAchFchParam: TfrmAchFchParam
  Left = 182
  Top = 142
  BorderStyle = bsDialog
  Caption = 'frmAchFchParam'
  ClientHeight = 244
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 18
    Width = 97
    Height = 13
    Caption = 'Начальная частота'
  end
  object Label2: TLabel
    Left = 48
    Top = 42
    Width = 90
    Height = 13
    Caption = 'Конечная частота'
  end
  object Label3: TLabel
    Left = 280
    Top = 42
    Width = 11
    Height = 13
    Caption = 'гц'
  end
  object Label4: TLabel
    Left = 280
    Top = 18
    Width = 11
    Height = 13
    Caption = 'гц'
  end
  object edBeginFreq: TEdit
    Left = 153
    Top = 14
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0.01'
  end
  object edEndFreq: TEdit
    Left = 153
    Top = 38
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1000000'
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 144
    Width = 353
    Height = 17
    Caption = 'вкл/выкл   Отметки постоянных времени знаменателя объекта'
    TabOrder = 2
  end
  object CheckBox2: TCheckBox
    Left = 32
    Top = 96
    Width = 153
    Height = 17
    Caption = 'вкл/выкл   Отметку 2/Т0'
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 304
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 5
    Kind = bkCancel
  end
  object CheckBox3: TCheckBox
    Left = 32
    Top = 168
    Width = 353
    Height = 17
    Caption = 'вкл/выкл   Отметки постоянных времени числителя коррекции'
    TabOrder = 6
  end
  object CheckBox4: TCheckBox
    Left = 32
    Top = 72
    Width = 105
    Height = 17
    Caption = 'вкл/выкл   АЧХ'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object CheckBox5: TCheckBox
    Left = 184
    Top = 72
    Width = 105
    Height = 17
    Caption = 'вкл/выкл   ФЧХ'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object CheckBox6: TCheckBox
    Left = 32
    Top = 128
    Width = 353
    Height = 17
    Caption = 'вкл/выкл   Отметки постоянных времени числителя объекта'
    TabOrder = 9
  end
  object CheckBox7: TCheckBox
    Left = 32
    Top = 184
    Width = 361
    Height = 17
    Caption = 'вкл/выкл   Отметки постоянных времени знаменателя коррекции'
    TabOrder = 10
  end
end
