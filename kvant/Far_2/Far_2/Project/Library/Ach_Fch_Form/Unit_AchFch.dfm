object frmAchFch: TfrmAchFch
  Left = 258
  Top = 113
  BorderStyle = bsDialog
  Caption = 'frmAchFch'
  ClientHeight = 406
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 56
    Width = 577
    Height = 321
    Shape = bsFrame
    Style = bsRaised
    Visible = False
  end
  object Bevel2: TBevel
    Left = 48
    Top = 77
    Width = 521
    Height = 273
    Shape = bsFrame
    Style = bsRaised
    Visible = False
  end
  object Label7: TLabel
    Left = 103
    Top = 384
    Width = 38
    Height = 16
    Caption = 'АЧХ :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lAchValue: TLabel
    Left = 148
    Top = 386
    Width = 48
    Height = 13
    Caption = 'lAchValue'
  end
  object Label8: TLabel
    Left = 358
    Top = 384
    Width = 40
    Height = 16
    Caption = 'ФЧХ :'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lFchValue: TLabel
    Left = 403
    Top = 386
    Width = 47
    Height = 13
    Caption = 'lFchValue'
  end
  object Label11: TLabel
    Left = 10
    Top = 37
    Width = 62
    Height = 16
    Caption = 'Частота'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lFreqValue: TLabel
    Left = 96
    Top = 39
    Width = 50
    Height = 13
    Caption = 'lFreqValue'
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 593
    Height = 29
    Align = alTop
    AutoSize = True
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 576
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 142
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbClose: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = 'Закрыть'
        Grouped = True
        ImageIndex = 2
        OnClick = tbCloseClick
      end
      object tbParam: TToolButton
        Left = 55
        Top = 0
        AutoSize = True
        Caption = ' Параметры отображения '
        Grouped = True
        ImageIndex = 0
        OnClick = tbParamClick
      end
      object tbSaveImage: TToolButton
        Left = 201
        Top = 0
        AutoSize = True
        Caption = 'Сохранить изображение'
        Grouped = True
        ImageIndex = 1
        OnClick = tbSaveImageClick
      end
    end
  end
  object ProgressBar1: TProgressBar
    Left = 352
    Top = 32
    Width = 233
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 1
    Visible = False
  end
  object SaveDialog1: TSaveDialog
    Left = 16
    Top = 64
  end
end
