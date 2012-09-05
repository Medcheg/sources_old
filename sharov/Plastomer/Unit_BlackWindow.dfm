object frmBlackWindow: TfrmBlackWindow
  Left = 341
  Top = 389
  BorderStyle = bsDialog
  Caption = 'frmBlackWindow'
  ClientHeight = 92
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 124
    Height = 13
    Caption = 'Угол между башмаками'
  end
  object Label2: TLabel
    Left = 272
    Top = 32
    Width = 14
    Height = 13
    Caption = 'гр.'
  end
  object Label3: TLabel
    Left = 8
    Top = 6
    Width = 16
    Height = 20
    Caption = '1.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 28
    Width = 16
    Height = 20
    Caption = '2.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Да'
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
    Left = 216
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 1
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 184
    Top = 28
    Width = 81
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object CheckBox1: TCheckBox
    Left = 48
    Top = 8
    Width = 225
    Height = 17
    Caption = 'Разрешить дествие кнопки PrintScreen'
    TabOrder = 3
    OnClick = CheckBox1Click
  end
end
