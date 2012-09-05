object frmPostajanki: TfrmPostajanki
  Left = 448
  Top = 215
  BorderStyle = bsDialog
  Caption = 'frmPostajanki'
  ClientHeight = 302
  ClientWidth = 210
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 64
    Top = 48
    Width = 99
    Height = 16
    Caption = #1055#1086#1089#1090#1086#1103#1085#1085#1099#1077' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 13
    Top = 11
    Width = 185
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1089#1090#1086#1103#1085#1085#1099#1077
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 14
    Top = 259
    Width = 185
    Height = 25
    Caption = #1059#1095#1077#1089#1090#1100' '#1087#1086#1089#1090#1086#1103#1085#1085#1099#1077
    TabOrder = 1
    OnClick = Button2Click
  end
  object ListBox1: TListBox
    Left = 13
    Top = 72
    Width = 185
    Height = 169
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 2
  end
end
