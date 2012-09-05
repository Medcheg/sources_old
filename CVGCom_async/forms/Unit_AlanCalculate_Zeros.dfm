object form_AlanCalculate_Zeros: Tform_AlanCalculate_Zeros
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'form_AlanCalculate_Zeros'
  ClientHeight = 159
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cbPar2: TComboBox
    Left = 25
    Top = 119
    Width = 110
    Height = 21
    Style = csDropDownList
    DropDownCount = 22
    TabOrder = 0
  end
  object cbPar1: TComboBox
    Left = 25
    Top = 92
    Width = 110
    Height = 21
    Style = csDropDownList
    DropDownCount = 22
    TabOrder = 1
  end
  object cbPar3: TComboBox
    Left = 233
    Top = 119
    Width = 110
    Height = 21
    Style = csDropDownList
    DropDownCount = 22
    TabOrder = 2
  end
  object cbPar4: TComboBox
    Left = 233
    Top = 92
    Width = 110
    Height = 21
    Style = csDropDownList
    DropDownCount = 22
    TabOrder = 3
  end
  object cbPar6: TComboBox
    Left = 444
    Top = 119
    Width = 110
    Height = 21
    Style = csDropDownList
    DropDownCount = 22
    TabOrder = 4
  end
  object cbPar5: TComboBox
    Left = 444
    Top = 92
    Width = 110
    Height = 21
    Style = csDropDownList
    DropDownCount = 22
    TabOrder = 5
  end
  object ePar1_Zero: TEdit
    Left = 141
    Top = 92
    Width = 70
    Height = 21
    TabOrder = 6
    Text = '0.0'
  end
  object ePar2_Zero: TEdit
    Left = 141
    Top = 119
    Width = 70
    Height = 21
    TabOrder = 7
    Text = '0.0'
  end
  object ePar4_Zero: TEdit
    Left = 349
    Top = 92
    Width = 70
    Height = 21
    TabOrder = 8
    Text = '0.0'
  end
  object ePar3_Zero: TEdit
    Left = 349
    Top = 119
    Width = 70
    Height = 21
    TabOrder = 9
    Text = '0.0'
  end
  object ePar5_Zero: TEdit
    Left = 560
    Top = 92
    Width = 70
    Height = 21
    TabOrder = 10
    Text = '0.0'
  end
  object ePar6_Zero: TEdit
    Left = 560
    Top = 119
    Width = 70
    Height = 21
    TabOrder = 11
    Text = '0.0'
  end
  object Button1: TButton
    Left = 25
    Top = 8
    Width = 120
    Height = 30
    Caption = 'Clear'
    TabOrder = 12
    OnClick = Button1Click
  end
  object cbCorrectedParam: TComboBox
    Left = 25
    Top = 44
    Width = 121
    Height = 24
    Style = csDropDownList
    DropDownCount = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object ePar0_Zero: TEdit
    Left = 152
    Top = 44
    Width = 97
    Height = 21
    TabOrder = 14
    Text = '0.0'
  end
  object Button2: TButton
    Left = 534
    Top = 8
    Width = 120
    Height = 30
    Caption = 'OK && Close'
    Default = True
    TabOrder = 15
    OnClick = Button2Click
  end
end
