object Form1: TForm1
  Left = 405
  Top = 177
  Caption = 'HAMEG 8123'
  ClientHeight = 424
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 405
    Width = 672
    Height = 19
    Panels = <
      item
        Text = '(c) Pavel Marusyk. Innalabs UA'
        Width = 50
      end>
  end
  object Chart1: TChart
    Left = 0
    Top = 89
    Width = 672
    Height = 316
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    LeftAxis.AxisValuesFormat = '#,##0.#########'
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 0.000000000100000000
    View3D = False
    View3DWalls = False
    Align = alClient
    TabOrder = 1
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 89
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 2
    object lCheckCOMPort: TLabel
      Left = 16
      Top = 8
      Width = 50
      Height = 13
      Cursor = crHandPoint
      Caption = #1057#1054#1052' '#1087#1086#1088#1090
    end
    object Label1: TLabel
      Left = 336
      Top = 16
      Width = 321
      Height = 53
      Alignment = taCenter
      AutoSize = False
      Caption = '----------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 47
      Height = 13
      Cursor = crHandPoint
      Caption = 'File Name'
    end
    object Start: TButton
      Left = 13
      Top = 60
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = StartClick
    end
    object cbCOMName: TComboBox
      Left = 88
      Top = 4
      Width = 233
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object Button1: TButton
      Left = 246
      Top = 58
      Width = 75
      Height = 25
      Caption = 'Stop'
      Enabled = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 88
      Top = 29
      Width = 233
      Height = 21
      TabOrder = 3
      Text = 'noname.txt'
    end
  end
  object Timer1: TTimer
    Interval = 4000
    OnTimer = Timer1Timer
    Left = 480
  end
end
