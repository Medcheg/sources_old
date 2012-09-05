object frmGLSetColor: TfrmGLSetColor
  Left = 360
  Top = 284
  Width = 207
  Height = 143
  BorderIcons = [biSystemMenu]
  Caption = 'Настройки цветов'
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 54
    Height = 13
    Caption = 'Цвет фона'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 80
    Height = 13
    Caption = 'Цвет скважины'
  end
  object Panel1: TPanel
    Left = 104
    Top = 8
    Width = 57
    Height = 25
    BevelInner = bvLowered
    Caption = 'Panel1'
    Color = clSilver
    TabOrder = 0
    OnClick = Panel1Click
  end
  object Panel2: TPanel
    Left = 104
    Top = 40
    Width = 57
    Height = 25
    BevelInner = bvLowered
    Caption = 'Panel2'
    Color = clRed
    TabOrder = 1
    OnClick = Panel2Click
  end
  object Button1: TButton
    Left = 120
    Top = 88
    Width = 75
    Height = 25
    Caption = 'ОК'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Panel3: TPanel
    Left = 2
    Top = 70
    Width = 192
    Height = 3
    TabOrder = 3
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    OnShow = ColorDialog1Show
    Color = clSilver
    Left = 8
    Top = 80
  end
  object ColorDialog2: TColorDialog
    Ctl3D = True
    OnShow = ColorDialog2Show
    Color = clRed
    Left = 40
    Top = 80
  end
end
