object frmProjectParam: TfrmProjectParam
  Left = 239
  Top = 134
  BorderStyle = bsDialog
  Caption = '��������� �������'
  ClientHeight = 137
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 355
    Height = 137
    Align = alClient
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 164
    Height = 13
    Caption = '����� ������������� �������'
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 152
    Height = 13
    Caption = '���� ������������� �������'
  end
  object Label3: TLabel
    Left = 312
    Top = 24
    Width = 6
    Height = 13
    Caption = 'c'
  end
  object Label4: TLabel
    Left = 312
    Top = 64
    Width = 6
    Height = 13
    Caption = 'c'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 104
    Width = 75
    Height = 25
    Caption = '��'
    Default = True
    TabOrder = 0
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
    Left = 272
    Top = 104
    Width = 75
    Height = 25
    Caption = '������'
    TabOrder = 1
    Kind = bkCancel
  end
  object eCalcTime: TEdit
    Left = 184
    Top = 20
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'eCalcTime'
  end
  object eT0: TEdit
    Left = 184
    Top = 60
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'eT0'
  end
end
