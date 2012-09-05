object frmParam: TfrmParam
  Left = 244
  Top = 131
  BorderStyle = bsDialog
  Caption = 'frmParam'
  ClientHeight = 275
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 136
    Top = 72
    Width = 131
    Height = 13
    Caption = 'Толщина основных линий'
  end
  object Label2: TLabel
    Left = 96
    Top = 96
    Width = 173
    Height = 13
    Caption = 'Толщина вспомогательных линий'
  end
  object Label3: TLabel
    Left = 192
    Top = 120
    Width = 75
    Height = 13
    Caption = 'Угол поворота'
  end
  object CheckBox1: TCheckBox
    Left = 200
    Top = 216
    Width = 137
    Height = 17
    Caption = 'Вкл/выкл Стрелки'
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object BitBtn1: TBitBtn
    Left = 232
    Top = 240
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object SpinEdit2: TSpinEdit
    Left = 280
    Top = 88
    Width = 121
    Height = 22
    MaxValue = 10
    MinValue = 1
    TabOrder = 2
    Value = 1
    OnChange = SpinEdit2Change
  end
  object RadioButton1: TRadioButton
    Left = 24
    Top = 8
    Width = 225
    Height = 17
    Caption = 'Вертикальнай ось направленна вверх'
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 24
    Top = 32
    Width = 225
    Height = 17
    Caption = 'Вертикальная ось направлена вниз'
    TabOrder = 4
    OnClick = RadioButton2Click
  end
  object SpinEdit3: TSpinEdit
    Left = 280
    Top = 112
    Width = 121
    Height = 22
    MaxValue = 35
    MinValue = 10
    TabOrder = 5
    Value = 10
    OnChange = SpinEdit3Change
  end
  object SpinEdit1: TSpinEdit
    Left = 280
    Top = 64
    Width = 121
    Height = 22
    MaxValue = 10
    MinValue = 1
    TabOrder = 6
    Value = 1
    OnChange = SpinEdit1Change
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 152
    Width = 169
    Height = 57
    Caption = 'Поворот №1'
    ItemIndex = 1
    Items.Strings = (
      'По часовой стрелке'
      'Против часовой стрелки')
    TabOrder = 7
    OnClick = RadioGroup1Click
  end
  object RadioGroup2: TRadioGroup
    Left = 184
    Top = 152
    Width = 169
    Height = 57
    Caption = 'Поворот №2'
    ItemIndex = 1
    Items.Strings = (
      'По часовой стрелке'
      'Против часовой стрелки')
    TabOrder = 8
    OnClick = RadioGroup2Click
  end
  object RadioGroup3: TRadioGroup
    Left = 360
    Top = 152
    Width = 169
    Height = 57
    Caption = 'Поворот №3'
    ItemIndex = 1
    Items.Strings = (
      'По часовой стрелке'
      'Против часовой стрелки')
    TabOrder = 9
    OnClick = RadioGroup3Click
  end
end
