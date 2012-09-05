object Form_Scheme: TForm_Scheme
  Left = 149
  Top = 168
  BorderStyle = bsDialog
  Caption = 'Form_Scheme'
  ClientHeight = 106
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClick = FormClick
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 87
    Width = 215
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Да'
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 136
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 2
    Kind = bkCancel
  end
end
