object form_Main: Tform_Main
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'form_Main'
  ClientHeight = 317
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 152
    Top = 23
    Width = 286
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 74
    Width = 138
    Height = 13
    Caption = #1057#1087#1080#1089#1086#1082' '#1090#1086#1075#1086', '#1095#1090#1086' '#1083#1086#1074#1080#1084':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 303
    Top = 143
    Width = 136
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1077#1082#1091#1085#1076' '#1074' '#1076#1077#1085#1100
  end
  object Label4: TLabel
    Left = 303
    Top = 213
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object Label5: TLabel
    Left = 10
    Top = 28
    Width = 136
    Height = 13
    Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1086#1082#1086#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 303
    Top = 186
    Width = 80
    Height = 13
    Caption = #1054#1089#1090#1072#1083#1086#1089#1100' ['#1089#1077#1082']:'
  end
  object Label7: TLabel
    Left = 389
    Top = 186
    Width = 30
    Height = 13
    Caption = '00000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object CheckBox2: TCheckBox
    Left = 303
    Top = 112
    Width = 118
    Height = 17
    Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1090#1072#1081#1084#1077#1088
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = CheckBox2Click
  end
  object CheckBox1: TCheckBox
    Left = 303
    Top = 93
    Width = 118
    Height = 17
    Caption = #1042#1082#1083'/'#1042#1099#1082#1083' '#1088#1072#1073#1086#1090#1091
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object edit_MaxTime: TEdit
    Left = 303
    Top = 159
    Width = 134
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = 'edit_MaxTime'
  end
  object edit_Password: TEdit
    Left = 303
    Top = 229
    Width = 134
    Height = 21
    Enabled = False
    TabOrder = 3
    Text = 'edit_Password'
  end
  object combobox_WindowsList: TComboBox
    Left = 10
    Top = 48
    Width = 429
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    OnDropDown = combobox_WindowsListDropDown
  end
  object statusbar_pm: TStatusBar
    Left = 0
    Top = 298
    Width = 440
    Height = 19
    Panels = <>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 440
    Height = 21
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 142
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 6
    object toolbutton_Add: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = '   '#1044#1086#1073#1072#1074#1080#1090#1100' '#1082' '#1089#1087#1080#1089#1082#1091'   '
      Grouped = True
      ImageIndex = 0
      OnClick = toolbutton_AddClick
    end
    object toolbutton_del: TToolButton
      Left = 125
      Top = 0
      AutoSize = True
      Caption = '    '#1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1089#1087#1080#1089#1082#1072'    '
      Grouped = True
      ImageIndex = 1
      OnClick = toolbutton_delClick
    end
    object toolbutton_check: TToolButton
      Left = 255
      Top = 0
      AutoSize = True
      Caption = '   '#1058#1077#1089#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1082#1088#1099#1090#1080#1077'   '
      Grouped = True
      ImageIndex = 2
      OnClick = toolbutton_checkClick
    end
  end
  object ListBox1: TListBox
    Left = 8
    Top = 93
    Width = 289
    Height = 203
    ItemHeight = 13
    TabOrder = 7
    OnClick = ListBox1Click
  end
  object Timer2: TTimer
    Interval = 500
    OnTimer = Timer2Timer
    Left = 16
    Top = 112
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 48
    Top = 112
  end
end
