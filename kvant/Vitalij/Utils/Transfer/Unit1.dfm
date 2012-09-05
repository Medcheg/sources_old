object Form1: TForm1
  Left = 281
  Top = 200
  Width = 379
  Height = 209
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 120
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Edit1: TEdit
    Left = 40
    Top = 48
    Width = 33
    Height = 21
    TabOrder = 0
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 96
    Top = 48
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit3: TEdit
    Left = 152
    Top = 48
    Width = 49
    Height = 21
    TabOrder = 2
    Text = '0'
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 40
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Посчитать'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 144
    Width = 289
    Height = 25
    Caption = 'Add to file '
    TabOrder = 6
    OnClick = Button2Click
  end
  object Edit4: TEdit
    Left = 224
    Top = 48
    Width = 49
    Height = 21
    TabOrder = 3
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit5: TEdit
    Left = 280
    Top = 48
    Width = 49
    Height = 21
    TabOrder = 4
    Text = '0'
    OnChange = Edit1Change
  end
  object CheckBox1: TCheckBox
    Left = 96
    Top = 24
    Width = 33
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 7
  end
  object CheckBox2: TCheckBox
    Left = 160
    Top = 24
    Width = 33
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 8
  end
  object CheckBox3: TCheckBox
    Left = 224
    Top = 24
    Width = 33
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 9
  end
  object CheckBox4: TCheckBox
    Left = 280
    Top = 24
    Width = 33
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 10
  end
end
