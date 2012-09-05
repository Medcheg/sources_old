object FmMain: TFmMain
  Left = 1
  Top = 31
  Width = 798
  Height = 568
  Caption = 'Зона видимости низколетящих целей'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PCmain: TPageControl
    Left = 0
    Top = 0
    Width = 790
    Height = 522
    ActivePage = tsData
    Align = alClient
    TabOrder = 0
    object tsData: TTabSheet
      Caption = 'Исходные данные'
      object GroupBox1: TGroupBox
        Left = 2
        Top = 76
        Width = 597
        Height = 337
        Caption = 'Исходные данные'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 48
          Width = 122
          Height = 16
          Caption = 'Высота антенны, м'
        end
        object Label2: TLabel
          Left = 16
          Top = 74
          Width = 166
          Height = 16
          Caption = 'Угол места луча ДН, град'
        end
        object Label3: TLabel
          Left = 16
          Top = 101
          Width = 144
          Height = 16
          Caption = 'Ширина луча ДН, град'
        end
        object Label4: TLabel
          Left = 16
          Top = 144
          Width = 144
          Height = 16
          Caption = 'Высота неровности, м'
        end
        object Label5: TLabel
          Left = 16
          Top = 192
          Width = 130
          Height = 16
          Caption = 'Длина волны РЛС, м'
        end
        object Label6: TLabel
          Left = 16
          Top = 240
          Width = 150
          Height = 16
          Caption = 'Опроная дальность, км'
        end
        object Label7: TLabel
          Left = 335
          Top = 50
          Width = 20
          Height = 16
          Caption = 'Pfa'
        end
        object Label8: TLabel
          Left = 335
          Top = 79
          Width = 98
          Height = 16
          Caption = 'Высота цели, м'
        end
        object Label9: TLabel
          Left = 20
          Top = 271
          Width = 17
          Height = 16
          Caption = 'Pd'
        end
        object btnSave: TBitBtn
          Left = 363
          Top = 283
          Width = 98
          Height = 32
          Action = acSave
          Caption = ' '
          TabOrder = 0
        end
        object BitBtn1: TBitBtn
          Left = 482
          Top = 283
          Width = 97
          Height = 32
          Action = acOpen
          Caption = ' '
          TabOrder = 1
        end
        object rgMFS: TRadioGroup
          Left = 335
          Top = 111
          Width = 235
          Height = 130
          Caption = ' Модель флюктуации сигнала'
          ItemIndex = 0
          Items.Strings = (
            ' Маркум'
            ' Сверлинг 1'
            ' Сверлинг 3'
            ' Сверлинг 2'
            ' Сверлинг 4')
          TabOrder = 2
        end
        object edHa: TEdit
          Left = 228
          Top = 46
          Width = 98
          Height = 24
          TabOrder = 3
          Text = '9'
        end
        object edLuch: TEdit
          Left = 228
          Top = 72
          Width = 98
          Height = 24
          TabOrder = 4
          Text = '0.8'
        end
        object edShir: TEdit
          Left = 228
          Top = 98
          Width = 98
          Height = 24
          TabOrder = 5
          Text = '3'
        end
        object edH: TEdit
          Left = 228
          Top = 137
          Width = 98
          Height = 24
          TabOrder = 6
          Text = '0.2'
        end
        object edLam: TEdit
          Left = 228
          Top = 182
          Width = 98
          Height = 24
          TabOrder = 7
          Text = '0.035'
        end
        object edDal: TEdit
          Left = 228
          Top = 234
          Width = 98
          Height = 24
          TabOrder = 8
          Text = '20.1'
        end
        object edPd: TEdit
          Left = 228
          Top = 264
          Width = 98
          Height = 24
          TabOrder = 9
          Text = '0.5'
        end
        object edPfa: TEdit
          Left = 462
          Top = 43
          Width = 98
          Height = 24
          TabOrder = 10
          Text = '6'
        end
        object spHNlc: TSpinEdit
          Left = 462
          Top = 74
          Width = 98
          Height = 26
          MaxValue = 1000000
          MinValue = 0
          TabOrder = 11
          Value = 400
        end
        object cbver: TCheckBox
          Left = 24
          Top = 304
          Width = 289
          Height = 17
          Caption = 'Зоны видимости для других Pd'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
      end
      object btnStart: TBitBtn
        Left = 33
        Top = 17
        Width = 130
        Height = 49
        Action = acStart
        TabOrder = 1
        Kind = bkOK
      end
      object btnPaket: TBitBtn
        Left = 650
        Top = 64
        Width = 107
        Height = 41
        Action = acPaket
        TabOrder = 2
      end
      object lbPaket: TListBox
        Left = 631
        Top = 120
        Width = 126
        Height = 345
        ItemHeight = 13
        TabOrder = 3
      end
      object PB: TProgressBar
        Left = 13
        Top = 436
        Width = 365
        Height = 52
        Min = 0
        Max = 100
        TabOrder = 4
      end
    end
    object tsRes: TTabSheet
      Caption = ' Результаты'
      ImageIndex = 1
      object ImRes: TImage
        Left = 160
        Top = 6
        Width = 600
        Height = 500
      end
      object btnSaveBmp: TBitBtn
        Left = 372
        Top = 516
        Width = 163
        Height = 40
        Caption = 'Записать в файл'
        TabOrder = 0
        OnClick = btnSaveBmpClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = ' Кривые обнаружения'
      ImageIndex = 2
    end
  end
  object sdOpt: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmap|*.bmp'
    Left = 292
    Top = 104
  end
  object odOpt: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 332
    Top = 104
  end
  object MainMenu1: TMainMenu
    Left = 380
    Top = 104
    object mFile: TMenuItem
      Caption = 'Файл'
      object mOpen: TMenuItem
        Action = acOpen
        Caption = 'Сохранить как ...'
      end
      object mSave: TMenuItem
        Action = acSave
        Caption = ' Откріть'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Caption = ' Выход'
        OnClick = N2Click
      end
    end
  end
  object alAct: TActionList
    Left = 420
    Top = 104
    object acSave: TAction
      OnExecute = btnSaveClick
    end
    object acOpen: TAction
      OnExecute = acOpenExecute
    end
    object acStart: TAction
      OnExecute = btnStartClick
    end
    object acPaket: TAction
      OnExecute = acPaketExecute
    end
  end
end
