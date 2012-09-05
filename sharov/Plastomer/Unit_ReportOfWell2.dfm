object frmReportOfWell2: TfrmReportOfWell2
  Left = 186
  Top = 188
  BorderStyle = bsDialog
  Caption = 'frmReportOfWell2'
  ClientHeight = 80
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 731
    Height = 29
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 714
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 142
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbSaveToFile: TToolButton
        Left = 0
        Top = 0
        Hint = 'Запись текущего изображения в файл'
        AutoSize = True
        Caption = ' Запись в файл '
        Grouped = True
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = tbSaveToFileClick
      end
      object tbParam: TToolButton
        Left = 92
        Top = 0
        Caption = ' Параметры отображения '
        Grouped = True
        ImageIndex = 3
        OnClick = tbParamClick
      end
      object Panel1: TPanel
        Left = 234
        Top = 0
        Width = 360
        Height = 21
        BevelOuter = bvNone
        TabOrder = 0
      end
      object tbZeroSettings: TToolButton
        Left = 594
        Top = 0
        AutoSize = True
        Caption = 'Выставка на "Север"'
        Grouped = True
        ImageIndex = 2
        OnClick = tbZeroSettingsClick
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 61
    Width = 731
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 8
    Top = 32
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 32
  end
end
