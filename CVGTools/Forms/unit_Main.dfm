object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 494
  ClientWidth = 691
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 217
    Align = alTop
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 353
      Top = 23
      Width = 337
      Height = 193
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'General'
        object checkBox_LogX: TCheckBox
          Left = 11
          Top = 42
          Width = 97
          Height = 17
          Caption = #39'X'#39' axis LOG'
          TabOrder = 0
          OnClick = checkbox_LegendClick
        end
        object checkbox_Legend: TCheckBox
          Left = 10
          Top = 17
          Width = 97
          Height = 17
          Caption = 'Legend'
          TabOrder = 1
          OnClick = checkbox_LegendClick
        end
        object checkBox_LogY: TCheckBox
          Left = 10
          Top = 65
          Width = 97
          Height = 17
          Caption = #39'Y'#39' axis LOG'
          TabOrder = 2
          OnClick = checkbox_LegendClick
        end
        object CheckBox1: TCheckBox
          Left = 10
          Top = 88
          Width = 119
          Height = 17
          Caption = 'Remove mean value'
          TabOrder = 3
          OnClick = checkbox_LegendClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'File Param'
        ImageIndex = 1
        object Label5: TLabel
          Left = 3
          Top = 3
          Width = 364
          Height = 16
          Caption = 
            'FILE NAME : ----------------------------------------------------' +
            '------'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 2
          Top = 62
          Width = 53
          Height = 13
          Caption = 'Begin Point'
        end
        object Label8: TLabel
          Left = 3
          Top = 87
          Width = 45
          Height = 13
          Caption = 'End Point'
        end
        object Label11: TLabel
          Left = 3
          Top = 38
          Width = 67
          Height = 13
          Caption = 'Sampling Time'
        end
        object edit_BeginPoint: TEdit
          Left = 76
          Top = 59
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object edit_EndPoint: TEdit
          Left = 76
          Top = 84
          Width = 121
          Height = 21
          TabOrder = 1
        end
        object edit_SamplingTime: TEdit
          Left = 76
          Top = 35
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object Button2: TButton
          Left = 251
          Top = 25
          Width = 75
          Height = 25
          Caption = 'Apply'
          TabOrder = 3
          OnClick = Button2Click
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Series Param'
        ImageIndex = 2
        object Label9: TLabel
          Left = 3
          Top = 3
          Width = 382
          Height = 16
          Caption = 
            'SERIES NAME : --------------------------------------------------' +
            '--------'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 11
          Top = 117
          Width = 78
          Height = 13
          Caption = 'Selected count :'
        end
        object Label6: TLabel
          Left = 11
          Top = 28
          Width = 50
          Height = 13
          Caption = 'Line Width'
        end
        object Label12: TLabel
          Left = 11
          Top = 55
          Width = 56
          Height = 13
          Caption = 'RAW offset'
        end
        object Label13: TLabel
          Left = 11
          Top = 79
          Width = 57
          Height = 13
          Caption = 'Series Scale'
        end
        object edit_LineWidth: TEdit
          Left = 75
          Top = 25
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object edit_RAW_offset: TEdit
          Left = 74
          Top = 52
          Width = 121
          Height = 21
          TabOrder = 1
        end
        object edit_Scale: TEdit
          Left = 74
          Top = 74
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object Button1: TButton
          Left = 251
          Top = 25
          Width = 75
          Height = 25
          Caption = 'Apply'
          TabOrder = 3
          OnClick = Button1Click
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 689
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 4
        Top = 3
        Width = 35
        Height = 13
        Caption = 'File List'
      end
      object Label3: TLabel
        Left = 350
        Top = 5
        Width = 55
        Height = 13
        Caption = 'Parameters'
      end
      object CheckBox4: TCheckBox
        Left = 186
        Top = 2
        Width = 97
        Height = 17
        Caption = 'Series on '#39'X'#39' Axis'
        TabOrder = 0
        OnClick = CheckBox4Click
      end
    end
    object Panel3: TPanel
      Left = 185
      Top = 23
      Width = 168
      Height = 193
      Align = alLeft
      BevelInner = bvLowered
      TabOrder = 2
      object Label4: TLabel
        Left = 3
        Top = 24
        Width = 99
        Height = 13
        Caption = 'Series List on '#39'Y'#39' Axis'
      end
      object ComboBox1: TComboBox
        Left = 2
        Top = 2
        Width = 164
        Height = 21
        Align = alTop
        Style = csDropDownList
        TabOrder = 0
        OnChange = ComboBox1Change
      end
      object CheckListBox2: TCheckListBox
        Left = 2
        Top = 43
        Width = 164
        Height = 148
        Align = alBottom
        ItemHeight = 13
        TabOrder = 1
        OnClick = CheckListBox2Click
      end
    end
    object CheckListBox1: TCheckListBox
      Left = 1
      Top = 23
      Width = 184
      Height = 193
      Align = alLeft
      ItemHeight = 13
      TabOrder = 3
      OnClick = CheckListBox1Click
      OnKeyDown = CheckListBox1KeyDown
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 217
    Width = 691
    Height = 258
    Legend.Alignment = laBottom
    Legend.LegendStyle = lsSeries
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.AxisValuesFormat = '#,##0.######'
    BottomAxis.ExactDateTime = False
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.Maximum = -0.130000000000000200
    DepthAxis.Minimum = -1.130000000000001000
    DepthTopAxis.Automatic = False
    DepthTopAxis.AutomaticMaximum = False
    DepthTopAxis.AutomaticMinimum = False
    DepthTopAxis.Maximum = -0.130000000000000200
    DepthTopAxis.Minimum = -1.130000000000001000
    LeftAxis.AxisValuesFormat = '#,##0.######'
    LeftAxis.ExactDateTime = False
    LeftAxis.MinorGrid.Color = clSilver
    LeftAxis.MinorGrid.Style = psDot
    LeftAxis.MinorGrid.Visible = True
    LeftAxis.MinorTickCount = 2
    View3D = False
    Zoom.Pen.Color = -1
    Align = alClient
    Color = clWhite
    TabOrder = 1
    object Series1: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clGreen
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clYellow
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clBlue
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series5: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clGray
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series6: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clFuchsia
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series7: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clTeal
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series8: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clNavy
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series9: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clMaroon
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series10: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clLime
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series11: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clOlive
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series12: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clPurple
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series13: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clAqua
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series14: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 475
    Width = 691
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end>
  end
  object ProgressBar1: TProgressBar
    Left = 64
    Top = 396
    Width = 89
    Height = 17
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 456
    Top = 176
    object File1: TMenuItem
      Caption = '&File'
      object Load1: TMenuItem
        Caption = '&Load'
        OnClick = Load1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
      end
    end
    object ools1: TMenuItem
      Caption = 'Tools'
      object RWBI1: TMenuItem
        Caption = 'RW && BI'
        Enabled = False
      end
      object FastFuireTransform1: TMenuItem
        Caption = 'FF Transform'
        Enabled = False
      end
    end
    object Hide1: TMenuItem
      Caption = 'Hide'
      OnClick = Hide1Click
    end
    object Show1: TMenuItem
      Caption = 'Show'
      OnClick = Hide1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.txt;*.*'
    Left = 408
    Top = 176
  end
  object SaveDialog1: TSaveDialog
    Left = 360
    Top = 176
  end
end
