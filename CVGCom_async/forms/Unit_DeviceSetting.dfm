object form_DeviceSetting: Tform_DeviceSetting
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'form_DeviceSetting'
  ClientHeight = 293
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClick = FormClick
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    341
    293)
  PixelsPerInch = 96
  TextHeight = 13
  object llDeviceType: TLabel
    Left = 16
    Top = 4
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
  object Label7: TLabel
    Left = 25
    Top = 39
    Width = 60
    Height = 13
    Hint = 'Refresh List'
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'device'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label6: TLabel
    Left = 25
    Top = 24
    Width = 60
    Height = 13
    Hint = 'Refresh List'
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Connected'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label8: TLabel
    Left = 25
    Top = 54
    Width = 60
    Height = 13
    Hint = 'Refresh List'
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'list'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object panel_WorkDevice: TPanel
    Left = 9
    Top = 107
    Width = 324
    Height = 156
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    object lDeviceName: TLabel
      Left = 32
      Top = 2
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
    object Label4: TLabel
      Left = 0
      Top = 98
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
    object lFileName: TLabel
      Left = 11
      Top = 84
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
    object lProfileNumber: TLabel
      Left = 8
      Top = 26
      Width = 68
      Height = 13
      Caption = 'File Comments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object combobox_DeviceName: TComboBox
      Left = 81
      Top = 0
      Width = 184
      Height = 21
      DropDownCount = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = combobox_DeviceNameChange
      OnDropDown = combobox_DeviceNameDropDown
    end
    object panel_SamplingFreq: TPanel
      Left = 0
      Top = 117
      Width = 320
      Height = 34
      BevelKind = bkTile
      BevelOuter = bvNone
      Color = 14869218
      ParentBackground = False
      TabOrder = 3
      DesignSize = (
        316
        30)
      object label_SampleFrequency: TLabel
        Left = 5
        Top = 8
        Width = 129
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Samping frequency'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 236
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
      object combobox_SamplingFrequency: TComboBox
        Left = 141
        Top = 5
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
        OnChange = combobox_SamplingFrequencyChange
      end
    end
    object button_GenerateFileName: TButton
      Left = 44
      Top = 54
      Width = 241
      Height = 24
      Caption = 'Generate File Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = button_GenerateFileNameClick
    end
    object edit_FileComment: TEdit
      Left = 81
      Top = 23
      Width = 184
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'edit_FileComment'
      OnChange = combobox_DeviceNameChange
    end
  end
  object button_OK: TButton
    Left = 172
    Top = 264
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    TabOrder = 5
    OnClick = button_OKClick
  end
  object button_Cancel: TButton
    Left = 253
    Top = 264
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object combobox_DeviceType: TComboBox
    Left = 90
    Top = 1
    Width = 184
    Height = 21
    Style = csDropDownList
    DropDownCount = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnDropDown = combobox_DeviceTypeDropDown
    OnExit = combobox_DeviceTypeExit
    Items.Strings = (
      'IMU'
      #1043#1080#1088#1086#1089#1082#1086#1087' ('#1072#1076#1099#1085' '#1096#1090#1091#1082')'
      #1044#1078#1072#1087#1072#1085' 1')
  end
  object button_AddSubDevice: TButton
    Left = 279
    Top = 1
    Width = 54
    Height = 21
    Caption = 'ADD'
    TabOrder = 1
    OnClick = button_AddSubDeviceClick
  end
  object listbox_SubDeviceList: TListBox
    Left = 90
    Top = 23
    Width = 184
    Height = 61
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemHeight = 14
    Items.Strings = (
      'CVGx_pm_0'
      'CVGx_pm_1'
      'CVGx_pm_2'
      'CVGx_pm_3'
      'CVGx_pm_4'
      'CVGx_pm_5'
      'CVGx_pm_6'
      'CVGx_pm_7'
      'CVGx_pm_8'
      'CVGx_pm_9'
      'CVGx_pm_10')
    ParentFont = False
    TabOrder = 2
    OnClick = listbox_SubDeviceListClick
    OnExit = listbox_SubDeviceListExit
  end
  object button_DeleteSubDevice: TButton
    Left = 278
    Top = 63
    Width = 54
    Height = 21
    Caption = 'DELETE'
    TabOrder = 3
    OnClick = button_DeleteSubDeviceClick
  end
  object panel_SerialPort: TPanel
    Left = 9
    Top = 84
    Width = 324
    Height = 22
    BevelOuter = bvNone
    TabOrder = 7
    object label_SerialPort: TLabel
      Left = 17
      Top = 4
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
      OnClick = label_SerialPortClick
    end
    object combobox_SerialCommList: TComboBox
      Left = 81
      Top = 1
      Width = 184
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      TabStop = False
      OnChange = combobox_SerialCommListChange
    end
  end
end
