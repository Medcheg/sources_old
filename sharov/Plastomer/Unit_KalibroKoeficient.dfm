object frmKalibroKoeficient: TfrmKalibroKoeficient
  Left = 202
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Plastomer - Паспортные данные прибора № -------------------'
  ClientHeight = 281
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 29
    Width = 620
    Height = 252
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 40
    Top = 48
    Width = 245
    Height = 13
    Caption = 'Калибровочные коефициенты радиусов :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 20
    Top = 91
    Width = 51
    Height = 13
    Caption = 'Радиус [1]'
  end
  object Label3: TLabel
    Left = 88
    Top = 72
    Width = 80
    Height = 13
    Caption = 'Коеф. передачи'
  end
  object Label4: TLabel
    Left = 192
    Top = 72
    Width = 86
    Height = 13
    Caption = 'Коеф. смещения'
  end
  object Label5: TLabel
    Left = 20
    Top = 115
    Width = 51
    Height = 13
    Caption = 'Радиус [2]'
  end
  object Label6: TLabel
    Left = 20
    Top = 139
    Width = 51
    Height = 13
    Caption = 'Радиус [3]'
  end
  object Label7: TLabel
    Left = 20
    Top = 163
    Width = 51
    Height = 13
    Caption = 'Радиус [4]'
  end
  object Label8: TLabel
    Left = 20
    Top = 187
    Width = 51
    Height = 13
    Caption = 'Радиус [5]'
  end
  object Label9: TLabel
    Left = 352
    Top = 48
    Width = 259
    Height = 13
    Caption = 'Калибровочные коефициенты электродов :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 324
    Top = 91
    Width = 63
    Height = 13
    Caption = 'Электрод [1]'
  end
  object Label11: TLabel
    Left = 400
    Top = 72
    Width = 80
    Height = 13
    Caption = 'Коеф. передачи'
  end
  object Label12: TLabel
    Left = 504
    Top = 72
    Width = 86
    Height = 13
    Caption = 'Коеф. смещения'
  end
  object Label13: TLabel
    Left = 324
    Top = 115
    Width = 63
    Height = 13
    Caption = 'Электрод [2]'
  end
  object Label14: TLabel
    Left = 324
    Top = 139
    Width = 63
    Height = 13
    Caption = 'Электрод [3]'
  end
  object Label15: TLabel
    Left = 324
    Top = 163
    Width = 63
    Height = 13
    Caption = 'Электрод [4]'
  end
  object Label16: TLabel
    Left = 324
    Top = 187
    Width = 63
    Height = 13
    Caption = 'Электрод [5]'
  end
  object Label17: TLabel
    Left = 280
    Top = 224
    Width = 160
    Height = 13
    Caption = 'Поправка на азимут электрода'
  end
  object Label18: TLabel
    Left = 72
    Top = 224
    Width = 69
    Height = 13
    Caption = 'Точка записи'
  end
  object Edit1: TEdit
    Left = 88
    Top = 88
    Width = 89
    Height = 21
    TabOrder = 0
    Text = '1'
  end
  object Edit2: TEdit
    Left = 192
    Top = 88
    Width = 89
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object Edit3: TEdit
    Left = 88
    Top = 112
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object Edit4: TEdit
    Left = 192
    Top = 112
    Width = 89
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Edit5: TEdit
    Left = 88
    Top = 136
    Width = 89
    Height = 21
    TabOrder = 4
    Text = '1'
  end
  object Edit6: TEdit
    Left = 192
    Top = 136
    Width = 89
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object Edit7: TEdit
    Left = 88
    Top = 160
    Width = 89
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object Edit8: TEdit
    Left = 192
    Top = 160
    Width = 89
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object Edit9: TEdit
    Left = 88
    Top = 184
    Width = 89
    Height = 21
    TabOrder = 8
    Text = '1'
  end
  object Edit10: TEdit
    Left = 192
    Top = 184
    Width = 89
    Height = 21
    TabOrder = 9
    Text = '0'
  end
  object Edit11: TEdit
    Left = 400
    Top = 88
    Width = 89
    Height = 21
    TabOrder = 10
    Text = '1'
  end
  object Edit12: TEdit
    Left = 504
    Top = 88
    Width = 89
    Height = 21
    TabOrder = 11
    Text = '0'
  end
  object Edit13: TEdit
    Left = 400
    Top = 112
    Width = 89
    Height = 21
    TabOrder = 12
    Text = '1'
  end
  object Edit14: TEdit
    Left = 504
    Top = 112
    Width = 89
    Height = 21
    TabOrder = 13
    Text = '0'
  end
  object Edit15: TEdit
    Left = 400
    Top = 136
    Width = 89
    Height = 21
    TabOrder = 14
    Text = '1'
  end
  object Edit16: TEdit
    Left = 504
    Top = 136
    Width = 89
    Height = 21
    TabOrder = 15
    Text = '0'
  end
  object Edit17: TEdit
    Left = 400
    Top = 160
    Width = 89
    Height = 21
    TabOrder = 16
    Text = '1'
  end
  object Edit18: TEdit
    Left = 504
    Top = 160
    Width = 89
    Height = 21
    TabOrder = 17
    Text = '0'
  end
  object Edit19: TEdit
    Left = 400
    Top = 184
    Width = 89
    Height = 21
    TabOrder = 18
    Text = '1'
  end
  object Edit20: TEdit
    Left = 504
    Top = 184
    Width = 89
    Height = 21
    TabOrder = 19
    Text = '0'
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 620
    Height = 29
    Align = alTop
    AutoSize = True
    TabOrder = 20
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 603
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 231
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbClearParam: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = '  Очистить  '
        Grouped = True
        ImageIndex = 2
        OnClick = tbClearParamClick
      end
      object ToolButton4: TToolButton
        Left = 70
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbLoadCoef: TToolButton
        Left = 78
        Top = 0
        AutoSize = True
        Caption = '  Загрузить калибровочные коеф. прибора  '
        Grouped = True
        ImageIndex = 0
        OnClick = tbLoadCoefClick
      end
      object ToolButton5: TToolButton
        Left = 312
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbSaveCoef: TToolButton
        Left = 320
        Top = 0
        AutoSize = True
        Caption = '  Сохранить калибровочные коеф. прибора  '
        Grouped = True
        ImageIndex = 1
        OnClick = tbSaveCoefClick
      end
    end
  end
  object Edit21: TEdit
    Left = 152
    Top = 220
    Width = 89
    Height = 21
    TabOrder = 21
    Text = '3'
  end
  object Edit22: TEdit
    Left = 456
    Top = 220
    Width = 89
    Height = 21
    TabOrder = 22
    Text = '0'
  end
  object BitBtn1: TBitBtn
    Left = 19
    Top = 252
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 23
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
    Left = 529
    Top = 253
    Width = 75
    Height = 25
    TabOrder = 24
    Kind = bkCancel
  end
  object OpenDialog1: TOpenDialog
    Left = 272
    Top = 240
  end
  object SaveDialog1: TSaveDialog
    Left = 304
    Top = 240
  end
end
