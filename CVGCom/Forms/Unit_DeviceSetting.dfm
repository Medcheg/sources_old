object frmDeviceSetting: TfrmDeviceSetting
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'CVGCom -  Device and Port Settings'
  ClientHeight = 405
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  DesignSize = (
    329
    405)
  PixelsPerInch = 96
  TextHeight = 13
  object llDeviceType: TLabel
    Left = 28
    Top = 7
    Width = 69
    Height = 13
    Caption = 'Device type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pDevice: TPanel
    Left = 0
    Top = 26
    Width = 326
    Height = 345
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    object lDeviceName: TLabel
      Left = 52
      Top = 25
      Width = 44
      Height = 13
      Caption = 'Device #'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lSerialPortList: TLabel
      Left = 37
      Top = 3
      Width = 59
      Height = 13
      Cursor = crHandPoint
      Hint = 'Refresh List'
      Caption = 'Serial Port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lSerialPortListClick
    end
    object Label3: TLabel
      Left = 4
      Top = 49
      Width = 89
      Height = 13
      Caption = 'File parameters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 4
      Top = 186
      Width = 100
      Height = 13
      Caption = 'Work parameters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 269
      Top = 205
      Width = 16
      Height = 13
      Caption = 'sec'
    end
    object Panel1: TPanel
      Left = 4
      Top = 63
      Width = 321
      Height = 117
      BevelInner = bvLowered
      Color = 12508128
      ParentBackground = False
      TabOrder = 2
      object lScaleFactor: TLabel
        Left = 156
        Top = 11
        Width = 57
        Height = 13
        Caption = 'Scale factor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lProfileNumber: TLabel
        Left = 7
        Top = 11
        Width = 39
        Height = 13
        Caption = 'Profile #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lFileName: TLabel
        Left = 7
        Top = 93
        Width = 299
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '--- File name ---'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object eScaleFactor: TEdit
        Left = 220
        Top = 8
        Width = 83
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'eScaleFactor'
      end
      object eProfileNumber: TEdit
        Left = 52
        Top = 8
        Width = 98
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'eProfileNumber'
      end
      object rbStatic: TRadioButton
        Left = 73
        Top = 39
        Width = 57
        Height = 17
        Caption = 'Static'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = True
      end
      object rbDynamic: TRadioButton
        Left = 197
        Top = 39
        Width = 65
        Height = 17
        Caption = 'Dynamic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object bGenerateFileName: TButton
        Left = 65
        Top = 63
        Width = 197
        Height = 24
        Caption = 'Generate File Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = bGenerateFileNameClick
      end
    end
    object cbDeviceName: TComboBox
      Left = 105
      Top = 22
      Width = 185
      Height = 21
      DropDownCount = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnDropDown = cbDeviceNameDropDown
    end
    object cbCommList: TComboBox
      Left = 105
      Top = 1
      Width = 185
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      TabStop = False
      OnChange = cbCommListChange
    end
    object Panel2: TPanel
      Left = 4
      Top = 229
      Width = 321
      Height = 112
      BevelInner = bvLowered
      Color = 14869218
      ParentBackground = False
      TabOrder = 3
      DesignSize = (
        321
        112)
      object Label1: TLabel
        Left = 19
        Top = 10
        Width = 147
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Samping frequency [mode 3, 4]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 268
        Top = 10
        Width = 13
        Height = 13
        Caption = 'Hz'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 40
        Top = -16
        Width = 31
        Height = 13
        Caption = 'Label5'
      end
      object cbSamplingFrequency: TComboBox
        Left = 174
        Top = 6
        Width = 90
        Height = 21
        Style = csDropDownList
        DropDownCount = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ValueListEditor1: TValueListEditor
        Left = 7
        Top = 29
        Width = 307
        Height = 80
        DefaultRowHeight = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Strings.Strings = (
          '=')
        TabOrder = 1
        OnValidate = ValueListEditor1Validate
        ColWidths = (
          202
          99)
      end
    end
    object edit_WorkTime: TEdit
      Left = 178
      Top = 202
      Width = 85
      Height = 21
      TabOrder = 4
    end
    object checkbox_WorkTime: TCheckBox
      Left = 105
      Top = 204
      Width = 72
      Height = 17
      Caption = 'Work time '
      TabOrder = 5
      OnClick = checkbox_WorkTimeClick
    end
  end
  object bOk: TButton
    Left = 163
    Top = 375
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 0
    OnClick = bOkClick
  end
  object bCancel: TButton
    Left = 244
    Top = 375
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = bCancelClick
  end
  object cbDeviceType: TComboBox
    Left = 105
    Top = 4
    Width = 185
    Height = 21
    Style = csDropDownList
    DropDownCount = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = cbDeviceTypeChange
    Items.Strings = (
      'IMU'
      #1043#1080#1088#1086#1089#1082#1086#1087' ('#1072#1076#1099#1085' '#1096#1090#1091#1082')'
      #1044#1078#1072#1087#1072#1085' 1')
  end
end
