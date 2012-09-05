object frmCaptionSaveLoad: TfrmCaptionSaveLoad
  Left = 322
  Top = 232
  BorderStyle = bsNone
  Caption = 'Plastomer -'
  ClientHeight = 29
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 297
    Height = 28
    Alignment = taCenter
    AutoSize = False
    BorderStyle = sbsSunken
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 900
    OnTimer = Timer1Timer
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 400
    OnTimer = Timer2Timer
    Left = 264
  end
end
