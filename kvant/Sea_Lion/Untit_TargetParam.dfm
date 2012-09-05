object frmTargetParam: TfrmTargetParam
  Left = 12
  Top = 147
  BorderStyle = bsDialog
  Caption = 'frmTargetParam'
  ClientHeight = 57
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 64
    Height = 13
    Caption = 'Пеленг цели'
  end
  object Label2: TLabel
    Left = 232
    Top = 12
    Width = 17
    Height = 13
    Caption = 'грд'
  end
  object Label3: TLabel
    Left = 8
    Top = 36
    Width = 86
    Height = 13
    Caption = 'Угол места цели'
  end
  object Label4: TLabel
    Left = 232
    Top = 36
    Width = 17
    Height = 13
    Caption = 'грд'
  end
  object SpinEdit1: TSpinEdit
    Left = 104
    Top = 8
    Width = 121
    Height = 22
    MaxValue = 85
    MinValue = -85
    TabOrder = 0
    Value = 10
    OnChange = SpinEdit1Change
  end
  object SpinEdit2: TSpinEdit
    Left = 104
    Top = 32
    Width = 121
    Height = 22
    MaxValue = 85
    MinValue = 0
    TabOrder = 1
    Value = 1
    OnChange = SpinEdit2Change
  end
end
