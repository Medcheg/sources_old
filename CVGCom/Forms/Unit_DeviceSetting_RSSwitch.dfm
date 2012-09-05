object frmDeviceSetting_RSSwitch: TfrmDeviceSetting_RSSwitch
  Left = 0
  Top = 0
  ActiveControl = button_CheckSwitchs
  BorderStyle = bsDialog
  Caption = 'CVGCom -  Device and Port Settings'
  ClientHeight = 232
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    782
    232)
  PixelsPerInch = 96
  TextHeight = 13
  object llDeviceType: TLabel
    Left = 31
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
  object Panel3: TPanel
    Left = 2
    Top = 134
    Width = 457
    Height = 58
    BevelInner = bvLowered
    Color = 14869218
    ParentBackground = False
    TabOrder = 0
    object lDeviceName: TLabel
      Left = 48
      Top = 11
      Width = 53
      Height = 13
      Caption = 'Device #'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lScaleFactor: TLabel
      Left = 207
      Top = 11
      Width = 70
      Height = 13
      Caption = 'Scale factor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 307
      Top = 11
      Width = 55
      Height = 13
      Caption = 'File name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 13
      Top = 11
      Width = 29
      Height = 13
      Caption = 'SW#'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lSwitchNumber_: TLabel
      Left = 13
      Top = 33
      Width = 6
      Height = 13
      Caption = '0'
      Enabled = False
    end
    object lFileName_: TLabel
      Left = 307
      Top = 33
      Width = 142
      Height = 13
      AutoSize = False
      Caption = '----  File name  ----'
      Enabled = False
    end
    object cbDeviceNamber_: TComboBox
      Left = 48
      Top = 30
      Width = 151
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 0
      Text = '  -----------------------------'
    end
    object eScaleFactor_: TEdit
      Left = 205
      Top = 30
      Width = 89
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = '  ------------------'
    end
  end
  object bOk: TButton
    Left = 304
    Top = 199
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    OnClick = bOkClick
  end
  object bCancel: TButton
    Left = 385
    Top = 199
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = bCancelClick
  end
  object Panel2: TPanel
    Left = 2
    Top = 84
    Width = 457
    Height = 44
    BevelInner = bvLowered
    Color = 12508128
    ParentBackground = False
    TabOrder = 3
    object lProfileNumber: TLabel
      Left = 8
      Top = 16
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
    object bGenerateFileName: TButton
      Left = 250
      Top = 10
      Width = 150
      Height = 24
      Caption = 'Generate Files Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = bGenerateFileNameClick
    end
    object rbDynamic: TRadioButton
      Left = 180
      Top = 14
      Width = 65
      Height = 17
      Caption = 'Dynamic'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object rbStatic: TRadioButton
      Left = 128
      Top = 14
      Width = 49
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
    object eProfileNumber: TEdit
      Left = 53
      Top = 12
      Width = 68
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'eProfileNumber'
    end
    object button_GetSF: TButton
      Left = 403
      Top = 10
      Width = 48
      Height = 24
      Caption = 'Get SF'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object cbDeviceType: TComboBox
    Left = 109
    Top = 4
    Width = 185
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 4
    OnChange = cbDeviceTypeChange
    Items.Strings = (
      'IMU'
      #1043#1080#1088#1086#1089#1082#1086#1087' ('#1072#1076#1099#1085' '#1096#1090#1091#1082')'
      #1044#1078#1072#1087#1072#1085' 1')
  end
  object Panel1: TPanel
    Left = 1
    Top = 26
    Width = 457
    Height = 52
    BevelOuter = bvNone
    TabOrder = 5
    object lSerialPortList: TLabel
      Left = 40
      Top = 9
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
    object Label2: TLabel
      Left = 81
      Top = 34
      Width = 98
      Height = 14
      Caption = 'Switch`s count ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 242
      Top = 34
      Width = 83
      Height = 14
      Caption = 'Gyros count  ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object label_SwitchConectedCount: TLabel
      Left = 184
      Top = 34
      Width = 31
      Height = 14
      Caption = '0 / 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object label_GyrosCount: TLabel
      Left = 331
      Top = 34
      Width = 8
      Height = 14
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbCommList: TComboBox
      Left = 108
      Top = 5
      Width = 185
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      TabStop = False
      OnChange = cbCommListChange
    end
    object button_CheckSwitchs: TButton
      Left = 298
      Top = 3
      Width = 157
      Height = 25
      Caption = 'Check Switch`s'
      Default = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = button_CheckSwitchsClick
    end
    object bShowLog: TButton
      Left = 354
      Top = 31
      Width = 101
      Height = 19
      Caption = 'Log '
      TabOrder = 2
      OnClick = bShowLogClick
    end
  end
  object ListBox1: TListBox
    Left = 465
    Top = 29
    Width = 313
    Height = 163
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16')
    TabOrder = 6
  end
end
