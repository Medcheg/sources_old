object frmReportOfWell1: TfrmReportOfWell1
  Left = 130
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmReportOfWell1'
  ClientHeight = 75
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pBack: TPanel
    Left = 0
    Top = 0
    Width = 251
    Height = 56
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object Image1: TImage
      Left = 2
      Top = 2
      Width = 247
      Height = 52
      Align = alClient
      OnMouseDown = Image1MouseDown
      OnMouseMove = Image1MouseMove
    end
  end
  object ScrollBar1: TScrollBar
    Left = 251
    Top = 0
    Width = 16
    Height = 56
    Align = alRight
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnChange = ScrollBar1Change
    OnKeyDown = ScrollBar1KeyDown
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 56
    Width = 267
    Height = 19
    Panels = <
      item
        Text = ' Глубина : '
        Width = 120
      end
      item
        Text = ' Средний радиус : '
        Width = 150
      end
      item
        Text = ' Достоверность головастика : '
        Width = 190
      end
      item
        Text = ' Угол падения пласта : '
        Width = 160
      end
      item
        Text = ' Азимут падения пласта : '
        Width = 160
      end>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 16
    object miParamOfWell: TMenuItem
      Caption = '  Параметры отображения  '
      OnClick = miParamOfWellClick
    end
    object miPrintReportOfWell: TMenuItem
      Caption = '  Печать отчета  '
      OnClick = miPrintReportOfWellClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 16
    object N1: TMenuItem
      Caption = '  Удалить выделенный головастик  '
      OnClick = N1Click
    end
  end
end
