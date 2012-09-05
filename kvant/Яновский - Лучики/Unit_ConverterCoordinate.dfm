object Form_ConverterCoordinate: TForm_ConverterCoordinate
  Left = 233
  Top = 132
  BorderStyle = bsDialog
  Caption = 'yyyyyyyyyyФФФФФФФФФФФФyyyyyyyy'
  ClientHeight = 258
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 341
    Height = 225
    ActivePage = TabSheet2
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Заданный курс'
      object Image1: TImage
        Left = 6
        Top = 8
        Width = 305
        Height = 41
      end
      object Label1: TLabel
        Left = 67
        Top = 86
        Width = 37
        Height = 16
        Caption = 'C      = '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 77
        Top = 93
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label3: TLabel
        Left = 84
        Top = 97
        Width = 7
        Height = 13
        Caption = 'K'
      end
      object Label4: TLabel
        Left = 64
        Top = 64
        Width = 214
        Height = 13
        Caption = 'Коеффициенты данного закона движения'
      end
      object Label7: TLabel
        Left = 67
        Top = 110
        Width = 37
        Height = 16
        Caption = 'C      = '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 77
        Top = 117
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label9: TLabel
        Left = 84
        Top = 121
        Width = 7
        Height = 13
        Caption = 'K'
      end
      object Label10: TLabel
        Left = 67
        Top = 134
        Width = 37
        Height = 16
        Caption = 'C      = '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 77
        Top = 141
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label12: TLabel
        Left = 84
        Top = 145
        Width = 7
        Height = 13
        Caption = 'K'
      end
      object Label5: TLabel
        Left = 67
        Top = 155
        Width = 15
        Height = 23
        Caption = 'w'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 84
        Top = 169
        Width = 7
        Height = 13
        Caption = 'K'
      end
      object Label17: TLabel
        Left = 95
        Top = 163
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label20: TLabel
        Left = 276
        Top = 90
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label31: TLabel
        Left = 276
        Top = 114
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label32: TLabel
        Left = 276
        Top = 138
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label33: TLabel
        Left = 276
        Top = 162
        Width = 11
        Height = 13
        Caption = 'гц'
      end
      object Edit1: TEdit
        Left = 110
        Top = 85
        Width = 160
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit2: TEdit
        Left = 110
        Top = 109
        Width = 160
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object Edit3: TEdit
        Left = 110
        Top = 133
        Width = 160
        Height = 21
        TabOrder = 2
        Text = '0'
      end
      object Edit4: TEdit
        Left = 110
        Top = 157
        Width = 160
        Height = 21
        TabOrder = 3
        Text = '0'
      end
    end
    object TabSheet3: TTabSheet
      Caption = '  Угол места '
      ImageIndex = 2
      object Image3: TImage
        Left = 20
        Top = 8
        Width = 305
        Height = 41
      end
      object Label6: TLabel
        Left = 64
        Top = 64
        Width = 214
        Height = 13
        Caption = 'Коеффициенты данного закона движения'
      end
      object Label22: TLabel
        Left = 66
        Top = 79
        Width = 10
        Height = 27
        Caption = 'e'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 77
        Top = 93
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label24: TLabel
        Left = 92
        Top = 89
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label26: TLabel
        Left = 77
        Top = 117
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label27: TLabel
        Left = 92
        Top = 113
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label29: TLabel
        Left = 77
        Top = 141
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label25: TLabel
        Left = 66
        Top = 103
        Width = 10
        Height = 27
        Caption = 'e'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 66
        Top = 127
        Width = 10
        Height = 27
        Caption = 'e'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 66
        Top = 151
        Width = 15
        Height = 27
        Caption = 'w'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 82
        Top = 165
        Width = 4
        Height = 15
        Caption = 'e'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 92
        Top = 161
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label30: TLabel
        Left = 92
        Top = 137
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label34: TLabel
        Left = 276
        Top = 90
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label35: TLabel
        Left = 276
        Top = 114
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label36: TLabel
        Left = 276
        Top = 138
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label40: TLabel
        Left = 276
        Top = 162
        Width = 11
        Height = 13
        Caption = 'гц'
      end
      object Edit5: TEdit
        Left = 110
        Top = 85
        Width = 160
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit6: TEdit
        Left = 110
        Top = 109
        Width = 160
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object Edit7: TEdit
        Left = 110
        Top = 133
        Width = 160
        Height = 21
        TabOrder = 2
        Text = '0'
      end
      object Edit8: TEdit
        Left = 110
        Top = 157
        Width = 160
        Height = 21
        TabOrder = 3
        Text = '0'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Рыскание корабля'
      ImageIndex = 2
      object Label21: TLabel
        Left = 64
        Top = 56
        Width = 214
        Height = 13
        Caption = 'Коеффициенты данного закона движения'
      end
      object Label37: TLabel
        Left = 64
        Top = 107
        Width = 15
        Height = 23
        Caption = 'w'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label38: TLabel
        Left = 84
        Top = 121
        Width = 7
        Height = 13
        Caption = 'K'
      end
      object Label39: TLabel
        Left = 95
        Top = 115
        Width = 6
        Height = 13
        Caption = '='
      end
      object Image2: TImage
        Left = 32
        Top = 8
        Width = 279
        Height = 41
      end
      object Label18: TLabel
        Left = 64
        Top = 79
        Width = 12
        Height = 23
        Caption = 'j'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 95
        Top = 87
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label41: TLabel
        Left = 276
        Top = 86
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label44: TLabel
        Left = 276
        Top = 114
        Width = 11
        Height = 13
        Caption = 'гц'
      end
      object Label42: TLabel
        Left = 64
        Top = 163
        Width = 15
        Height = 23
        Caption = 'w'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label43: TLabel
        Left = 80
        Top = 177
        Width = 7
        Height = 13
        Caption = 'K'
      end
      object Label45: TLabel
        Left = 95
        Top = 171
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label46: TLabel
        Left = 64
        Top = 136
        Width = 12
        Height = 23
        Caption = 'j'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label47: TLabel
        Left = 95
        Top = 144
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label48: TLabel
        Left = 276
        Top = 143
        Width = 18
        Height = 13
        Caption = 'рад'
      end
      object Label49: TLabel
        Left = 276
        Top = 170
        Width = 11
        Height = 13
        Caption = 'гц'
      end
      object Label50: TLabel
        Left = 79
        Top = 94
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label51: TLabel
        Left = 91
        Top = 126
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label52: TLabel
        Left = 80
        Top = 152
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label53: TLabel
        Left = 87
        Top = 182
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Edit9: TEdit
        Left = 110
        Top = 81
        Width = 160
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit12: TEdit
        Left = 110
        Top = 109
        Width = 160
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object Edit10: TEdit
        Left = 110
        Top = 138
        Width = 160
        Height = 21
        TabOrder = 2
        Text = '0'
      end
      object Edit11: TEdit
        Left = 110
        Top = 165
        Width = 160
        Height = 21
        TabOrder = 3
        Text = '0'
      end
    end
  end
  object Button1: TButton
    Left = 4
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 260
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 2
  end
end
