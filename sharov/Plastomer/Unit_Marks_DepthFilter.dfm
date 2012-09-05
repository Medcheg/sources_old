object frmMarks_DepthFilter: TfrmMarks_DepthFilter
  Left = 393
  Top = 243
  BorderStyle = bsDialog
  Caption = 'frmMarks_DepthFilter'
  ClientHeight = 189
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 8
    Top = 32
    Width = 321
    Height = 113
    Shape = bsFrame
    Style = bsRaised
  end
  object Label5: TLabel
    Left = 42
    Top = 40
    Width = 150
    Height = 13
    Caption = 'Текущая начальная глубина :'
  end
  object Label6: TLabel
    Left = 42
    Top = 56
    Width = 150
    Height = 13
    Caption = 'Текущая конечная  глубина  :'
  end
  object lStartDepth: TLabel
    Left = 208
    Top = 40
    Width = 53
    Height = 13
    Caption = 'lStartDepth'
  end
  object lStopDepth: TLabel
    Left = 208
    Top = 56
    Width = 53
    Height = 13
    Caption = 'lStopDepth'
  end
  object Label1: TLabel
    Left = 16
    Top = 96
    Width = 162
    Height = 13
    Caption = 'Начальная глубина фильтрации'
  end
  object Label3: TLabel
    Left = 312
    Top = 96
    Width = 8
    Height = 13
    Caption = 'м'
  end
  object Label4: TLabel
    Left = 312
    Top = 120
    Width = 8
    Height = 13
    Caption = 'м'
  end
  object Label2: TLabel
    Left = 15
    Top = 120
    Width = 155
    Height = 13
    Caption = 'Конечная глубина фильтрации'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Caption = 'OK'
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
    Left = 248
    Top = 160
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object cbFiltration: TCheckBox
    Left = 8
    Top = 8
    Width = 209
    Height = 17
    Caption = 'Вкл/Выкл  Фильтрация по глубине'
    TabOrder = 2
    OnClick = cbFiltrationClick
  end
  object Edit1: TEdit
    Left = 184
    Top = 92
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Edit2: TEdit
    Left = 184
    Top = 116
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0'
  end
end
