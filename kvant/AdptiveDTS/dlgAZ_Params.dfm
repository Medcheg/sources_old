object frmAZ_Params: TfrmAZ_Params
  Left = 270
  Top = 223
  BorderStyle = bsDialog
  Caption = 'Параметры автомата захвата'
  ClientHeight = 103
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 134
    Top = 13
    Width = 90
    Height = 13
    Caption = 'Число импульсов'
  end
  object Label2: TLabel
    Left = 78
    Top = 44
    Width = 146
    Height = 13
    Caption = 'Число пропусков импульсов'
  end
  object btnOk: TBitBtn
    Left = 144
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = btnOkClick
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 232
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 232
    Top = 8
    Width = 60
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object udImpulseAmount: TUpDown
    Left = 292
    Top = 8
    Width = 15
    Height = 21
    Associate = Edit1
    Min = 2
    Position = 10
    TabOrder = 3
    Wrap = False
  end
  object Edit2: TEdit
    Left = 232
    Top = 40
    Width = 60
    Height = 21
    TabOrder = 4
    Text = '10'
  end
  object udImpulsiveBlankAmount: TUpDown
    Left = 292
    Top = 40
    Width = 15
    Height = 21
    Associate = Edit2
    Min = 0
    Max = 10
    Position = 10
    TabOrder = 5
    Wrap = False
  end
end
