object frmResult_1: TfrmResult_1
  Left = 677
  Top = 217
  BorderStyle = bsDialog
  Caption = 'frmResult_1'
  ClientHeight = 260
  ClientWidth = 451
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIForm
  OldCreateOrder = True
  Position = poDefault
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    Left = 0
    Top = 97
    Width = 451
    Height = 163
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9')
    TabIndex = 0
    OnChange = TabControl1Change
    object StringGrid1: TStringGrid
      Left = 4
      Top = 24
      Width = 443
      Height = 135
      Align = alClient
      ColCount = 4
      DefaultColWidth = 109
      FixedCols = 0
      RowCount = 13
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
      ScrollBars = ssNone
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 65
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    OnDblClick = Panel1DblClick
    object Label3: TLabel
      Left = 93
      Top = 13
      Width = 44
      Height = 13
      Caption = 'Gyro Out'
    end
    object Label1: TLabel
      Left = 93
      Top = 37
      Width = 56
      Height = 13
      Caption = 'Quadrature'
    end
    object Label5: TLabel
      Left = 6
      Top = 38
      Width = 14
      Height = 20
      Caption = 'W'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 53
      Top = 41
      Width = 27
      Height = 13
      Caption = 'deg/s'
    end
    object Button1: TButton
      Left = 312
      Top = 4
      Width = 136
      Height = 25
      Caption = 'Delete Selected Tab'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 155
      Top = 10
      Width = 130
      Height = 21
      Style = csDropDownList
      DropDownCount = 44
      TabOrder = 1
    end
    object ComboBox2: TComboBox
      Left = 155
      Top = 34
      Width = 130
      Height = 21
      Style = csDropDownList
      DropDownCount = 44
      TabOrder = 2
    end
    object Button4: TButton
      Left = 7
      Top = 10
      Width = 74
      Height = 25
      Hint = 'Calculate SF, Angle'
      Caption = 'Calculate SF'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Button4Click
    end
    object Edit3: TEdit
      Left = 26
      Top = 38
      Width = 23
      Height = 21
      TabOrder = 4
      Text = '5'
    end
    object Button2: TButton
      Left = 312
      Top = 32
      Width = 136
      Height = 25
      Caption = 'REPORT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 451
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 2
    object Label2: TLabel
      Left = 6
      Top = 9
      Width = 59
      Height = 13
      Caption = 'Scale Factor'
    end
    object Label4: TLabel
      Left = 324
      Top = 9
      Width = 29
      Height = 13
      Caption = 'Phase'
    end
    object Label7: TLabel
      Left = 424
      Top = 9
      Width = 18
      Height = 13
      Caption = 'deg'
    end
    object SpeedButton1: TSpeedButton
      Left = 170
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Use Scalse Factor'
      Caption = 'V'
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 195
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Clear Scale Factor'
      Caption = 'X'
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton2Click
    end
    object speedbutton_ConvertToFreq: TSpeedButton
      Left = 219
      Top = 4
      Width = 99
      Height = 22
      Caption = 'Convert to freq'
      Flat = True
      OnClick = speedbutton_ConvertToFreqClick
    end
    object Edit1: TEdit
      Left = 70
      Top = 5
      Width = 96
      Height = 21
      HideSelection = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 359
      Top = 5
      Width = 62
      Height = 21
      TabOrder = 1
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'Text File (*.txt)|*.txt'
    Left = 15
    Top = 113
  end
end
