object frmPU_Params: TfrmPU_Params
  Left = 334
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Параметры приемного устройства'
  ClientHeight = 108
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
    Top = 21
    Width = 199
    Height = 13
    Caption = 'Максимальная амплитуда импульса, В'
  end
  object Label2: TLabel
    Left = 118
    Top = 52
    Width = 99
    Height = 13
    Caption = 'Значение порога, В'
  end
  object edtImpulseAmplitude: TEdit
    Left = 231
    Top = 16
    Width = 80
    Height = 21
    TabOrder = 0
    Text = 'edtImpulseAmplitude'
  end
  object edtLevelV: TEdit
    Left = 231
    Top = 48
    Width = 80
    Height = 21
    TabOrder = 1
    Text = 'edtLevelV'
  end
  object btnOk: TBitBtn
    Left = 152
    Top = 80
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = btnOkClick
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 240
    Top = 80
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
