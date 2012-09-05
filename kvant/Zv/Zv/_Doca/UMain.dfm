object FmMain: TFmMain
  Left = 109
  Top = 103
  Width = 960
  Height = 739
  Caption = 'FormCaption'
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
    Width = 952
    Height = 693
    ActivePage = tsData
    Align = alClient
    TabOrder = 0
    object tsData: TTabSheet
      Caption = 'tsData_Caption'
      object ImRes: TImage
        Left = 400
        Top = 82
        Width = 520
        Height = 480
      end
      object GroupBox1: TGroupBox
        Left = 2
        Top = 75
        Width = 375
        Height = 549
        Caption = 'GroupBox1_Caption'
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
          Width = 94
          Height = 16
          Caption = 'Label1_Caption'
        end
        object Label2: TLabel
          Left = 16
          Top = 74
          Width = 94
          Height = 16
          Caption = 'Label2_Caption'
        end
        object Label3: TLabel
          Left = 16
          Top = 101
          Width = 94
          Height = 16
          Caption = 'Label3_Caption'
        end
        object Label4: TLabel
          Left = 16
          Top = 144
          Width = 94
          Height = 16
          Caption = 'Label4_Caption'
        end
        object Label5: TLabel
          Left = 16
          Top = 192
          Width = 94
          Height = 16
          Caption = 'Label5_Caption'
        end
        object Label6: TLabel
          Left = 16
          Top = 240
          Width = 94
          Height = 16
          Caption = 'Label6_Caption'
        end
        object Label7: TLabel
          Left = 23
          Top = 354
          Width = 20
          Height = 16
          Caption = 'Pfa'
        end
        object Label8: TLabel
          Left = 23
          Top = 383
          Width = 94
          Height = 16
          Caption = 'Label8_Caption'
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
          Width = 38
          Height = 32
          Action = acSave
          Caption = ' '
          TabOrder = 0
          Visible = False
        end
        object BitBtn1: TBitBtn
          Left = 426
          Top = 283
          Width = 39
          Height = 32
          Action = acOpen
          Caption = ' '
          TabOrder = 1
          Visible = False
        end
        object rgMFS: TRadioGroup
          Left = 15
          Top = 415
          Width = 235
          Height = 130
          Caption = ' '
          ItemIndex = 0
          Items.Strings = (
            ' 0 '
            ' 1 '
            ' 2 '
            ' 3 '
            ' 4 ')
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
          Left = 150
          Top = 347
          Width = 98
          Height = 24
          TabOrder = 10
          Text = '6'
        end
        object spHNlc: TSpinEdit
          Left = 150
          Top = 378
          Width = 98
          Height = 26
          MaxValue = 1000000
          MinValue = 0
          TabOrder = 11
          Value = 30
        end
        object cbver: TCheckBox
          Left = 24
          Top = 304
          Width = 289
          Height = 17
          Caption = 'cbver_Caption'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
      end
      object btnStart: TBitBtn
        Left = 32
        Top = 15
        Width = 130
        Height = 49
        Action = acStart
        TabOrder = 1
        Kind = bkOK
      end
      object btnPaket: TBitBtn
        Left = 274
        Top = 536
        Width = 71
        Height = 41
        Action = acPaket
        TabOrder = 2
        Visible = False
      end
      object lbPaket: TListBox
        Left = 271
        Top = 608
        Width = 66
        Height = 41
        ItemHeight = 13
        TabOrder = 3
        Visible = False
      end
      object PB: TProgressBar
        Left = 181
        Top = 16
        Width = 365
        Height = 48
        Min = 0
        Max = 100
        TabOrder = 4
      end
      object btnSaveBmp: TBitBtn
        Left = 588
        Top = 20
        Width = 163
        Height = 40
        Caption = 'btnSaveBmp_Caption'
        TabOrder = 5
        OnClick = btnSaveBmpClick
      end
    end
  end
  object sdOpt: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmap|*.bmp'
    Left = 332
    Top = 152
  end
  object odOpt: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 332
    Top = 200
  end
  object MainMenu1: TMainMenu
    Left = 332
    Top = 240
    object mFile: TMenuItem
      Caption = 'File'
      object mOpen: TMenuItem
        Action = acOpen
        Caption = 'Open ...'
      end
      object mSave: TMenuItem
        Action = acSave
        Caption = 'Save '
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Caption = 'n2_Caption'
        OnClick = N2Click
      end
    end
  end
  object alAct: TActionList
    Left = 340
    Top = 296
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
