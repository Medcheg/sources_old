object frmResult_3: TfrmResult_3
  Left = 392
  Top = 112
  Caption = 'frmResult_3'
  ClientHeight = 580
  ClientWidth = 917
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 584
    Top = 0
    Width = 333
    Height = 580
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object pChartBackGround: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 580
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object pChart2: TPanel
      Left = 2
      Top = 194
      Width = 580
      Height = 199
      Align = alClient
      BevelInner = bvLowered
      Color = clSilver
      TabOrder = 0
      object Label3: TLabel
        Left = 16
        Top = 4
        Width = 57
        Height = 20
        Caption = 'X Axes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton2: TSpeedButton
        Tag = 9001
        Left = 200
        Top = 4
        Width = 33
        Height = 22
        Caption = 'reset'
        OnClick = Sb_Reset_item_click
      end
      object Label2: TLabel
        Left = 280
        Top = 4
        Width = 57
        Height = 20
        Caption = 'Y Axes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Chart2: TChart
        Left = 2
        Top = 29
        Width = 576
        Height = 168
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Legend.Visible = False
        Title.AdjustFrame = False
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -16
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'CHART 2')
        Title.Visible = False
        BottomAxis.AxisValuesFormat = '#,##0.#######'
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 0.000000010000000000
        BottomAxis.LabelsSeparation = 7
        BottomAxis.Title.Font.Height = -16
        BottomAxis.Title.Font.Style = [fsBold]
        LeftAxis.AxisValuesFormat = '#,##0.#######'
        LeftAxis.ExactDateTime = False
        LeftAxis.Increment = 0.000000010000000000
        LeftAxis.LabelsSeparation = 6
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Style = [fsBold]
        View3D = False
        Zoom.Pen.Color = clBlack
        Align = alBottom
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        object Series2: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object cb_Chart2_x: TComboBox
        Left = 80
        Top = 4
        Width = 121
        Height = 21
        Style = csDropDownList
        DropDownCount = 23
        TabOrder = 1
      end
      object cb_Chart2_y: TComboBox
        Left = 344
        Top = 4
        Width = 121
        Height = 21
        Style = csDropDownList
        DropDownCount = 23
        TabOrder = 2
      end
    end
    object pChart1: TPanel
      Left = 2
      Top = 35
      Width = 580
      Height = 159
      Align = alTop
      TabOrder = 1
      DesignSize = (
        580
        159)
      object Label1: TLabel
        Left = 16
        Top = 5
        Width = 57
        Height = 20
        Caption = 'X Axes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 272
        Top = 5
        Width = 57
        Height = 20
        Caption = 'Y Axes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton1: TSpeedButton
        Tag = 9000
        Left = 200
        Top = 4
        Width = 33
        Height = 22
        Caption = 'reset'
        OnClick = Sb_Reset_item_click
      end
      object cb_Chart1_x: TComboBox
        Left = 80
        Top = 5
        Width = 121
        Height = 21
        Style = csDropDownList
        DropDownCount = 23
        TabOrder = 0
      end
      object cb_Chart1_y: TComboBox
        Left = 336
        Top = 5
        Width = 121
        Height = 21
        Style = csDropDownList
        DropDownCount = 23
        TabOrder = 1
      end
      object Chart1: TChart
        Left = 1
        Top = 30
        Width = 578
        Height = 128
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Legend.Visible = False
        Title.AdjustFrame = False
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -16
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'CHART 1')
        Title.Visible = False
        BottomAxis.AxisValuesFormat = '#,##0.#######'
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 0.000000010000000000
        BottomAxis.LabelsSeparation = 7
        BottomAxis.Title.Font.Height = -16
        BottomAxis.Title.Font.Style = [fsBold]
        LeftAxis.AxisValuesFormat = '#,##0.#######'
        LeftAxis.ExactDateTime = False
        LeftAxis.Increment = 0.000000010000000000
        LeftAxis.LabelsSeparation = 6
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Style = [fsBold]
        View3D = False
        Zoom.Pen.Color = clBlack
        Align = alBottom
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 2
        Anchors = [akLeft, akTop, akRight, akBottom]
        object Series1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object BitBtn1: TBitBtn
        Left = 487
        Top = 1
        Width = 88
        Height = 28
        Anchors = [akTop, akRight]
        Caption = 'DRAW'
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00344446333334
          44433333FFFF333333FFFF33000033AAA43333332A4333338833F33333883F33
          00003332A46333332A4333333383F33333383F3300003332A2433336A6633333
          33833F333383F33300003333AA463362A433333333383F333833F33300003333
          6AA4462A46333333333833FF833F33330000333332AA22246333333333338333
          33F3333300003333336AAA22646333333333383333F8FF33000033444466AA43
          6A43333338FFF8833F383F330000336AA246A2436A43333338833F833F383F33
          000033336A24AA442A433333333833F33FF83F330000333333A2AA2AA4333333
          333383333333F3330000333333322AAA4333333333333833333F333300003333
          333322A4333333333333338333F333330000333333344A433333333333333338
          3F333333000033333336A24333333333333333833F333333000033333336AA43
          33333333333333833F3333330000333333336663333333333333333888333333
          0000}
        NumGlyphs = 2
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 3
        OnClick = BitBtn1Click
      end
      object CheckBox1: TCheckBox
        Left = 464
        Top = 8
        Width = 17
        Height = 17
        Hint = 'Decimation'
        Caption = 'CheckBox1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
    end
    object pChart3: TPanel
      Left = 2
      Top = 393
      Width = 580
      Height = 185
      Align = alBottom
      Caption = 'pChart3'
      TabOrder = 2
      object Label5: TLabel
        Left = 16
        Top = 4
        Width = 57
        Height = 20
        Caption = 'X Axes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton3: TSpeedButton
        Tag = 9002
        Left = 200
        Top = 4
        Width = 33
        Height = 22
        Caption = 'reset'
        OnClick = Sb_Reset_item_click
      end
      object Label6: TLabel
        Left = 280
        Top = 4
        Width = 57
        Height = 20
        Caption = 'Y Axes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Chart3: TChart
        Left = 1
        Top = 28
        Width = 578
        Height = 156
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Legend.Visible = False
        Title.AdjustFrame = False
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -16
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'CHART 3')
        Title.Visible = False
        BottomAxis.AxisValuesFormat = '#,##0.#######'
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 0.000000010000000000
        BottomAxis.LabelsSeparation = 7
        BottomAxis.Title.Font.Height = -16
        BottomAxis.Title.Font.Style = [fsBold]
        LeftAxis.AxisValuesFormat = '#,##0.#######'
        LeftAxis.ExactDateTime = False
        LeftAxis.Increment = 0.000000010000000000
        LeftAxis.LabelsSeparation = 6
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Style = [fsBold]
        View3D = False
        Zoom.Pen.Color = clBlack
        Align = alBottom
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        object LineSeries1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object cb_Chart3_x: TComboBox
        Left = 80
        Top = 4
        Width = 121
        Height = 21
        Style = csDropDownList
        DropDownCount = 23
        TabOrder = 1
      end
      object cb_Chart3_y: TComboBox
        Left = 344
        Top = 4
        Width = 121
        Height = 21
        Style = csDropDownList
        DropDownCount = 23
        TabOrder = 2
      end
    end
    object pExpName: TPanel
      Left = 2
      Top = 2
      Width = 580
      Height = 33
      Align = alTop
      Caption = 'pExpName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
end
