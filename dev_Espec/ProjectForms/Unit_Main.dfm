object frmMain: TfrmMain
  Left = 0
  Top = 0
  ActiveControl = Button1
  Caption = 'ESPEC SH261 - v.1.1'
  ClientHeight = 392
  ClientWidth = 813
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 813
    Height = 47
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object lSerialPortList: TLabel
      Left = 8
      Top = 5
      Width = 79
      Height = 13
      Cursor = crHandPoint
      Hint = 'Refresh List'
      Caption = 'SerialPort List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lSerialPortListClick
    end
    object lProfileList: TLabel
      Left = 279
      Top = 5
      Width = 59
      Height = 13
      Caption = 'Profile List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object bConnectDisconnect: TButton
      Left = 199
      Top = 21
      Width = 74
      Height = 22
      Caption = 'Connect'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = bConnectDisconnectClick
    end
    object cbCommList: TComboBox
      Left = 8
      Top = 22
      Width = 185
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      TabStop = False
    end
    object cbProfileList: TComboBox
      Left = 279
      Top = 21
      Width = 217
      Height = 21
      Style = csDropDownList
      DropDownCount = 88
      ItemHeight = 13
      TabOrder = 2
      TabStop = False
      OnChange = cbProfileListChange
    end
    object bPNew: TButton
      Left = 503
      Top = 21
      Width = 52
      Height = 22
      Caption = 'New'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TabStop = False
      OnClick = bPNewClick
    end
    object LoadFromESPEC: TButton
      Left = 563
      Top = 12
      Width = 110
      Height = 25
      Caption = 'Load from ESPEC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      TabStop = False
      OnClick = LoadFromESPECClick
    end
    object SaveToESPEC: TButton
      Left = 679
      Top = 12
      Width = 110
      Height = 25
      Caption = 'Save to ESPEC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      TabStop = False
      OnClick = SaveToESPECClick
    end
  end
  object Panel2: TPanel
    Left = 639
    Top = 47
    Width = 174
    Height = 345
    Align = alRight
    TabOrder = 1
    object Label6: TLabel
      Left = 5
      Top = 285
      Width = 72
      Height = 13
      Caption = 'OffsetTime [m]'
    end
    object Label9: TLabel
      Left = 5
      Top = 261
      Width = 62
      Height = 13
      Caption = 'Temperature'
    end
    object ListBox1: TListBox
      Left = 1
      Top = 105
      Width = 172
      Height = 127
      TabStop = False
      Align = alTop
      ItemHeight = 13
      Items.Strings = (
        'Step 1'
        'Step 2'
        'Step 3'
        'Step 4'
        'Step 5'
        'Step 6'
        'Step 7'
        'Step 8'
        'Step 9')
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object eTime: TEdit
      Left = 80
      Top = 282
      Width = 43
      Height = 21
      TabOrder = 1
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 172
      Height = 104
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 2
      object Label1: TLabel
        Left = 4
        Top = 5
        Width = 95
        Height = 13
        Caption = 'CountProfileStep'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 109
        Top = 2
        Width = 45
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = '-----'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 4
        Top = 22
        Width = 92
        Height = 13
        Caption = 'BeginRepeatPos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 4
        Top = 46
        Width = 81
        Height = 13
        Caption = 'EndRepeatPos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 4
        Top = 68
        Width = 110
        Height = 13
        Caption = 'ProfileRepeatCount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 52
        Top = 87
        Width = 57
        Height = 13
        Caption = 'Last HOLD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object CSpinEdit1: TCSpinEdit
        Left = 115
        Top = 17
        Width = 49
        Height = 22
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxValue = 9
        ParentFont = False
        TabOrder = 0
      end
      object CSpinEdit2: TCSpinEdit
        Left = 115
        Top = 41
        Width = 49
        Height = 22
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxValue = 9
        ParentFont = False
        TabOrder = 1
      end
      object CSpinEdit3: TCSpinEdit
        Left = 115
        Top = 63
        Width = 49
        Height = 22
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxValue = 9
        ParentFont = False
        TabOrder = 2
      end
    end
    object eTempr: TEdit
      Left = 80
      Top = 258
      Width = 43
      Height = 21
      TabOrder = 3
    end
    object Button1: TButton
      Left = 129
      Top = 261
      Width = 39
      Height = 36
      Caption = 'SET'
      Default = True
      TabOrder = 4
      TabStop = False
      OnClick = Button1Click
    end
    object rbSoak: TRadioButton
      Left = 95
      Top = 238
      Width = 50
      Height = 17
      Caption = 'SOAK'
      Enabled = False
      TabOrder = 5
    end
    object rbRamp: TCheckBox
      Left = 26
      Top = 238
      Width = 63
      Height = 17
      TabStop = False
      Caption = 'Ramp'
      TabOrder = 6
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 47
    Width = 639
    Height = 345
    Gradient.EndColor = 16777088
    Gradient.StartColor = 8454143
    Gradient.Visible = True
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.Maximum = 0.169999999999999800
    DepthAxis.Minimum = -0.830000000000000300
    DepthTopAxis.Automatic = False
    DepthTopAxis.AutomaticMaximum = False
    DepthTopAxis.AutomaticMinimum = False
    DepthTopAxis.Maximum = 0.169999999999999800
    DepthTopAxis.Minimum = -0.830000000000000300
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Maximum = 733.575000000000300000
    LeftAxis.Minimum = -88.925000000000130000
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    View3D = False
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 2
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series5: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series6: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series7: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series8: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series9: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object ActionList1: TActionList
    Left = 8
    Top = 64
    object aNextStep: TAction
      Caption = 'aNextStep'
      ShortCut = 116
      OnExecute = aNextStepExecute
    end
    object aPrevStep: TAction
      Caption = 'aPrevStep'
      ShortCut = 117
      OnExecute = aPrevStepExecute
    end
  end
end
