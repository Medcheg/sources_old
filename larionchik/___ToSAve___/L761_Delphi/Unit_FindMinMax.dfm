object frmFindMinMax: TfrmFindMinMax
  Left = 227
  Top = 132
  BorderStyle = bsDialog
  Caption = 'Оценка максимумов каналов'
  ClientHeight = 150
  ClientWidth = 305
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
    Left = 16
    Top = 40
    Width = 73
    Height = 16
    Caption = 'Канал №1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 73
    Height = 16
    Caption = 'Канал №2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 88
    Width = 73
    Height = 16
    Caption = 'Канал №3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 119
    Top = 42
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label5: TLabel
    Left = 119
    Top = 66
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label6: TLabel
    Left = 119
    Top = 90
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label7: TLabel
    Left = 215
    Top = 42
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label8: TLabel
    Left = 215
    Top = 66
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label9: TLabel
    Left = 215
    Top = 90
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label10: TLabel
    Left = 112
    Top = 16
    Width = 58
    Height = 13
    Caption = 'Время [c]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 192
    Top = 16
    Width = 113
    Height = 13
    Caption = 'Значение [Вольты]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 120
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
end
