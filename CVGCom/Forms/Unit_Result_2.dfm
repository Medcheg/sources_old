object frmResult_2: TfrmResult_2
  Left = 315
  Top = 103
  Caption = 'frmResult_2'
  ClientHeight = 582
  ClientWidth = 905
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
  object pChart1: TPanel
    Left = 0
    Top = 0
    Width = 169
    Height = 582
    Align = alLeft
    TabOrder = 0
    ExplicitHeight = 333
    object Label1: TLabel
      Left = 16
      Top = 31
      Width = 76
      Height = 16
      Caption = 'DeltaTime = '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 98
      Top = 31
      Width = 52
      Height = 16
      Caption = '-------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 6
      Top = 93
      Width = 35
      Height = 13
      Caption = 'Y axis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CheckBox1: TCheckBox
      Left = 14
      Top = 8
      Width = 97
      Height = 17
      Caption = 'Time Analis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object ListBox1: TListBox
      Left = 1
      Top = 112
      Width = 167
      Height = 416
      Style = lbOwnerDrawFixed
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 32
      TabOrder = 1
      OnClick = ListBox1Click
    end
    object Panel1: TPanel
      Left = 1
      Top = 528
      Width = 167
      Height = 53
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Label4: TLabel
        Left = 5
        Top = 4
        Width = 35
        Height = 13
        Caption = 'X axis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ComboBox1: TComboBox
        Left = 5
        Top = 23
        Width = 157
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = ListBox1Click
      end
    end
    object CheckBox2: TCheckBox
      Left = 6
      Top = 53
      Width = 97
      Height = 17
      Caption = 'Use SF for YAxis'
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 92
      Top = 72
      Width = 71
      Height = 21
      TabOrder = 4
      Text = '0'
    end
  end
  object Chart1: TChart
    Left = 169
    Top = 0
    Width = 736
    Height = 582
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.BevelWidth = 1
    Title.Font.Color = clBlack
    Title.Font.Height = -19
    Title.Font.Style = [fsBold]
    Title.Font.Shadow.HorizSize = 2
    Title.Font.Shadow.VertSize = 2
    Title.Gradient.Visible = True
    Title.Text.Strings = (
      'TChart')
    OnUndoZoom = Chart1UndoZoom
    OnZoom = Chart1Zoom
    BottomAxis.AxisValuesFormat = '#,##0.######'
    DepthAxis.AxisValuesFormat = '#,##0.######'
    DepthTopAxis.AxisValuesFormat = '#,##0.######'
    LeftAxis.AxisValuesFormat = '#,##0.#########'
    View3D = False
    Zoom.Pen.Color = clBlack
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 1
    OnClick = Chart1Click
    OnMouseDown = Chart1MouseDown
    OnMouseMove = Chart1MouseMove
    OnMouseUp = Chart1MouseUp
    ExplicitHeight = 333
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
