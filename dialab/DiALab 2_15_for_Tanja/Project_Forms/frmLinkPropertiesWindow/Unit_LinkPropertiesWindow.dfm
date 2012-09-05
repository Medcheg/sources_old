object frmLinkPropertiesWindow: TfrmLinkPropertiesWindow
  Left = 426
  Top = 268
  BorderStyle = bsDialog
  Caption = 'frmLinkPropertiesWindow'
  ClientHeight = 140
  ClientWidth = 277
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
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = #1062#1074#1077#1090' '#1089#1074#1103#1079#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 132
    Height = 13
    Caption = #1058#1086#1083#1097#1080#1085#1072' '#1083#1080#1085#1080#1080' '#1089#1074#1103#1079#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 8
    Top = 33
    Width = 265
    Height = 18
    BevelInner = bvLowered
    TabOrder = 2
    OnClick = Panel1Click
  end
  object CSpinEdit1: TCSpinEdit
    Left = 8
    Top = 80
    Width = 265
    Height = 22
    MaxValue = 5
    MinValue = 1
    TabOrder = 3
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 240
    Top = 32
  end
end
