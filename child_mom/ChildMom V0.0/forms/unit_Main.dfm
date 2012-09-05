object form_Main: Tform_Main
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'form_Main'
  ClientHeight = 184
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 2
    Width = 116
    Height = 13
    Caption = 'Blocked program list'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 160
    Top = 63
    Width = 45
    Height = 13
    Caption = 'Time, sec'
  end
  object Label3: TLabel
    Left = 160
    Top = 103
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Memo1: TMemo
    Left = 8
    Top = 21
    Width = 137
    Height = 156
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object button_Test: TButton
    Left = 160
    Top = 152
    Width = 89
    Height = 25
    Caption = 'button_Test'
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 160
    Top = 40
    Width = 97
    Height = 17
    Caption = 'Show info timer'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object CheckBox2: TCheckBox
    Left = 160
    Top = 21
    Width = 133
    Height = 17
    Caption = 'Enabled / disable timer'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object edit_MaxTime: TEdit
    Left = 160
    Top = 79
    Width = 89
    Height = 21
    TabOrder = 4
    Text = 'edit_MaxTime'
  end
  object edit_Password: TEdit
    Left = 160
    Top = 119
    Width = 89
    Height = 21
    TabOrder = 5
    Text = 'edit_Password'
  end
  object Timer2: TTimer
    Interval = 500
    Left = 16
    Top = 40
  end
  object Timer3: TTimer
    Interval = 60000
    Left = 56
    Top = 40
  end
end
