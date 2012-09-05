object frmGLSettings: TfrmGLSettings
  Left = 221
  Top = 209
  Width = 275
  Height = 148
  Cursor = crHandPoint
  BorderIcons = [biSystemMenu]
  Caption = 'Параметры плоскости'
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
  object Button1: TButton
    Left = 184
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 1
    Top = 1
    Width = 264
    Height = 89
    BevelInner = bvLowered
    TabOrder = 1
  end
end
