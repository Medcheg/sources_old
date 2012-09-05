object frmExport: TfrmExport
  Left = 477
  Top = 233
  BorderStyle = bsDialog
  Caption = 'Export'
  ClientHeight = 299
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 312
    Top = 40
    Width = 377
    Height = 81
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 320
    Top = 33
    Width = 155
    Height = 16
    Caption = '   MDRS sensor data   '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 312
    Top = 136
    Width = 377
    Height = 121
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 320
    Top = 129
    Width = 147
    Height = 16
    Caption = '   MDRS video data   '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 640
    Top = 142
    Width = 25
    Height = 13
    Cursor = crHandPoint
    Caption = 'Drive'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label3Click
  end
  object Label4: TLabel
    Left = 8
    Top = 2
    Width = 72
    Height = 13
    Caption = 'Current DIR:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 18
    Width = 232
    Height = 13
    Caption = 'D:\_Project\#_Bogatskiy\_abb\abb_041'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bDataExport: TButton
    Left = 426
    Top = 87
    Width = 145
    Height = 25
    Caption = 'Export all sensor data'
    TabOrder = 0
    OnClick = bDataExportClick
  end
  object cbiData: TComboBox
    Left = 344
    Top = 56
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7')
  end
  object bSelectedDataExport: TButton
    Left = 506
    Top = 55
    Width = 145
    Height = 25
    Caption = 'Export selected events'
    TabOrder = 2
    OnClick = bSelectedDataExportClick
  end
  object bVideoDataExport: TButton
    Left = 408
    Top = 223
    Width = 195
    Height = 25
    Caption = 'Export all video data'
    TabOrder = 3
    OnClick = bVideoDataExportClick
  end
  object cbiVideoData: TComboBox
    Left = 352
    Top = 192
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7')
  end
  object bSelectedVideoDataExport: TButton
    Left = 514
    Top = 191
    Width = 145
    Height = 25
    Caption = 'Export selected events'
    TabOrder = 5
    OnClick = bSelectedVideoDataExportClick
  end
  object BitBtn1: TBitBtn
    Left = 472
    Top = 264
    Width = 75
    Height = 33
    TabOrder = 6
    Kind = bkClose
  end
  object cbBreakReadEvent: TCheckBox
    Left = 320
    Top = 264
    Width = 65
    Height = 17
    Caption = 'Cancel'
    TabOrder = 7
    Visible = False
  end
  object RadioButton1: TRadioButton
    Left = 328
    Top = 160
    Width = 145
    Height = 17
    Caption = 'Read data through PORT'
    Checked = True
    TabOrder = 8
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 496
    Top = 160
    Width = 129
    Height = 17
    Caption = 'Read data from CARD'
    TabOrder = 9
    OnClick = RadioButton1Click
  end
  object ComboBox1: TComboBox
    Left = 632
    Top = 158
    Width = 49
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 10
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 64
    Width = 289
    Height = 193
    DirLabel = Label5
    ItemHeight = 16
    TabOrder = 11
    OnChange = DirectoryListBox1Change
    OnClick = DirectoryListBox1Click
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 40
    Width = 289
    Height = 19
    AutoDropDown = True
    TabOrder = 12
    OnChange = DriveComboBox1Change
  end
end
