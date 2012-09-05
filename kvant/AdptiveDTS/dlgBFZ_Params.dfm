object frmBFZ_Params: TfrmBFZ_Params
  Left = 334
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Параметы блока формирования задания'
  ClientHeight = 144
  ClientWidth = 320
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
    Left = 24
    Top = 53
    Width = 199
    Height = 13
    Caption = 'Максимальная амплитуда импульса, В'
  end
  object Label2: TLabel
    Left = 118
    Top = 84
    Width = 105
    Height = 13
    Caption = 'Значение порога, дБ'
  end
  object Label3: TLabel
    Left = 42
    Top = 24
    Width = 181
    Height = 13
    Caption = 'Частота следования импульсов, Гц'
  end
  object edtImpulseAmplitude: TEdit
    Left = 231
    Top = 48
    Width = 80
    Height = 21
    TabOrder = 0
    Text = 'edtImpulseAmplitude'
  end
  object edtLevelDb: TEdit
    Left = 231
    Top = 80
    Width = 80
    Height = 21
    TabOrder = 1
    Text = 'edtLevelDb'
  end
  object btnOk: TBitBtn
    Left = 144
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = btnOkClick
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 240
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 232
    Top = 16
    Width = 60
    Height = 21
    TabOrder = 4
    Text = '10'
  end
  object udFrequency: TUpDown
    Left = 292
    Top = 16
    Width = 15
    Height = 21
    Associate = Edit1
    Min = 10
    Max = 1000
    Position = 10
    TabOrder = 5
    Wrap = False
  end
end
