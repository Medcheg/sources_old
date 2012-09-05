object frmAbonent_Params: TfrmAbonent_Params
  Left = 232
  Top = 126
  BorderStyle = bsDialog
  Caption = 'Абонент 1'
  ClientHeight = 247
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label10: TLabel
    Left = 84
    Top = 50
    Width = 108
    Height = 13
    Caption = 'Глубина сектора, грд'
  end
  object Label8: TLabel
    Left = 9
    Top = 24
    Width = 183
    Height = 13
    Caption = 'Начальное положение антенны, грд'
  end
  object Label13: TLabel
    Left = 56
    Top = 75
    Width = 136
    Height = 13
    Caption = 'Скорость вращения, грд/с'
  end
  object Label17: TLabel
    Left = 30
    Top = 127
    Width = 162
    Height = 13
    Caption = 'Ускорение торможения, грд/с2'
  end
  object Label1: TLabel
    Left = 35
    Top = 92
    Width = 157
    Height = 26
    Alignment = taRightJustify
    Caption = 'Скорость вращения в режиме сопровождения, грд/с'
    WordWrap = True
  end
  object edtBetta0: TEdit
    Left = 201
    Top = 19
    Width = 80
    Height = 21
    TabOrder = 0
    Text = 'edtBetta0'
  end
  object edtDepthSector: TEdit
    Left = 201
    Top = 46
    Width = 80
    Height = 21
    TabOrder = 1
    Text = 'edtBetta0_1'
  end
  object edtRotationSpeed1: TEdit
    Left = 201
    Top = 72
    Width = 60
    Height = 21
    TabOrder = 2
    Text = '5'
  end
  object UpDownRotationSpeed: TUpDown
    Left = 261
    Top = 72
    Width = 15
    Height = 21
    Associate = edtRotationSpeed1
    Min = 5
    Max = 72
    Position = 5
    TabOrder = 3
    Wrap = False
  end
  object BitBtn2: TBitBtn
    Left = 207
    Top = 216
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
  object btnOk: TBitBtn
    Left = 120
    Top = 216
    Width = 75
    Height = 25
    TabOrder = 5
    OnClick = btnOkClick
    Kind = bkOK
  end
  object edtARotationSpeed: TEdit
    Left = 201
    Top = 123
    Width = 80
    Height = 21
    TabOrder = 6
    Text = 'edtBetta0_1'
  end
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 152
    Width = 265
    Height = 41
    Caption = 'Режим поиска'
    Columns = 2
    Items.Strings = (
      'Круговой'
      'Секторный')
    TabOrder = 7
  end
  object edtAutoRotationSpeed: TEdit
    Left = 201
    Top = 97
    Width = 60
    Height = 21
    TabOrder = 8
    Text = '1'
  end
  object UpDownAutoRotationSpeed: TUpDown
    Left = 261
    Top = 97
    Width = 15
    Height = 21
    Associate = edtAutoRotationSpeed
    Min = 1
    Max = 72
    Position = 1
    TabOrder = 9
    Wrap = False
  end
end
