object frmUVSO_Params: TfrmUVSO_Params
  Left = 223
  Top = 210
  BorderStyle = bsDialog
  Caption = 'Параметры устройстав выделения сигнала ошибки'
  ClientHeight = 96
  ClientWidth = 385
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
    Left = 14
    Top = -3
    Width = 212
    Height = 13
    Caption = 'Процент от выделенного сигнала ошибки'
    Visible = False
  end
  object Label2: TLabel
    Left = 7
    Top = 18
    Width = 189
    Height = 13
    Caption = '  Корректировочный коефициент   K  '
  end
  object btnOk: TBitBtn
    Left = 208
    Top = 64
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = btnOkClick
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 296
    Top = 64
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 232
    Top = -8
    Width = 60
    Height = 21
    TabOrder = 2
    Text = '10'
    Visible = False
  end
  object udOffsetPercent: TUpDown
    Left = 292
    Top = -8
    Width = 15
    Height = 21
    Associate = Edit1
    Min = 10
    Position = 10
    TabOrder = 3
    Visible = False
    Wrap = False
  end
  object edtK: TEdit
    Left = 8
    Top = 38
    Width = 369
    Height = 21
    TabOrder = 4
    Text = '10'
  end
end
