object form_Main: Tform_Main
  Left = 0
  Top = 0
  Caption = 'CVGProg v1.0'
  ClientHeight = 227
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object panel_BoardParam: TPanel
    Left = 0
    Top = 0
    Width = 642
    Height = 39
    Align = alTop
    BevelInner = bvLowered
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
    object lSerialPortList: TLabel
      Left = 8
      Top = 11
      Width = 94
      Height = 13
      Cursor = crHandPoint
      Hint = 'Refresh List'
      Caption = 'Board serial port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lSerialPortListClick
    end
    object label_BaudRate: TLabel
      Left = 427
      Top = 11
      Width = 58
      Height = 13
      Cursor = crHandPoint
      Hint = 'Refresh List'
      Caption = 'Baud Rate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = lSerialPortListClick
    end
    object button_ConnectDisconnect: TButton
      Left = 297
      Top = 6
      Width = 74
      Height = 25
      Caption = 'Connect'
      TabOrder = 0
      OnClick = button_ConnectDisconnectClick
    end
    object combobox_CommList: TComboBox
      Tag = 1
      Left = 108
      Top = 8
      Width = 185
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      TabStop = False
      OnChange = combobox_Change
    end
    object combobox_BaudRate: TComboBox
      Tag = 2
      Left = 491
      Top = 8
      Width = 137
      Height = 21
      Style = csDropDownList
      DropDownCount = 14
      TabOrder = 2
      TabStop = False
      OnChange = combobox_Change
      Items.Strings = (
        '256000'
        '230400'
        '128000'
        '115200'
        '57600'
        '38400'
        '19200'
        '14400'
        '9600'
        '4800'
        '2400'
        '1200'
        '600 '
        '300 '
        '110')
    end
  end
  object panel_BG: TPanel
    Left = 0
    Top = 39
    Width = 642
    Height = 188
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object label_LDRFileName: TLabel
      Left = 28
      Top = 11
      Width = 63
      Height = 13
      Caption = 'Project File'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object label_SpiProgLDRFileName: TLabel
      Left = 6
      Top = 42
      Width = 85
      Height = 13
      Caption = 'SPI Project File'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 63
      Width = 143
      Height = 13
      Caption = 'Serial PORT echo monitor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 320
      Top = 63
      Width = 20
      Height = 13
      Caption = 'Log'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object speedbutton_ChooseLDRFile: TSpeedButton
      Tag = 1
      Left = 385
      Top = 5
      Width = 23
      Height = 25
      Glyph.Data = {
        DE000000424DDE0000000000000076000000280000000D0000000D0000000100
        0400000000006800000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        F000F000000000FFF00000888888880FF000080FBFBFBF0FFA5F080BFBFBFBF0
        F0000880BFBFBFB0F0000880FBFBFBFB0000088800000000000008888888880F
        F0000888800000FFF000F0000FFFFFFFF000FFFFFFFFFFFFF000FFFFFFFFFFFF
        F000}
      OnClick = speedbutton_ChooseFile
    end
    object speedbutton_ChooseSpiProgLDRFile: TSpeedButton
      Tag = 2
      Left = 385
      Top = 35
      Width = 23
      Height = 25
      Glyph.Data = {
        DE000000424DDE0000000000000076000000280000000D0000000D0000000100
        0400000000006800000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        F000F000000000FFF00000888888880FF000080FBFBFBF0FFA5F080BFBFBFBF0
        F0000880BFBFBFB0F0000880FBFBFBFB0000088800000000000008888888880F
        F0000888800000FFF000F0000FFFFFFFF000FFFFFFFFFFFFF000FFFFFFFFFFFF
        F000}
      OnClick = speedbutton_ChooseFile
    end
    object button_SendLoader: TButton
      Tag = 1
      Left = 411
      Top = 5
      Width = 136
      Height = 25
      Action = SendLoader
      TabOrder = 0
    end
    object button_SendSPIProgLoader: TButton
      Tag = 2
      Left = 411
      Top = 35
      Width = 136
      Height = 25
      Action = SEND_SPI_Prog_Loader
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      TabOrder = 1
    end
    object edit_Debug_LDRFileName: TEdit
      Tag = 1
      Left = 94
      Top = 8
      Width = 288
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = 'edit_Debug_LDRFileName'
    end
    object edit_Debug_SPILDRFileName: TEdit
      Tag = 2
      Left = 94
      Top = 37
      Width = 288
      Height = 21
      ReadOnly = True
      TabOrder = 3
      Text = 'edit_Debug_SPILDRFileName'
    end
    object button_CopyFile: TButton
      Left = 550
      Top = 5
      Width = 88
      Height = 24
      Caption = 'COPY'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      WordWrap = True
      OnClick = button_CopyFileClick
    end
    object memo_Log: TMemo
      Left = 320
      Top = 78
      Width = 317
      Height = 89
      Lines.Strings = (
        '19:10:23 - Copy CVG_pm_810m.ldr to Input.ldr'
        '19:10:23 - Send time 12.2 sec'
        '19:10:23 - 25345 Bytes sended'
        '19:10:23 - Sending file CVG_pm_810m.ldr')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 5
      WordWrap = False
    end
    object button_ClearLog: TButton
      Left = 550
      Top = 35
      Width = 88
      Height = 25
      Caption = 'Log`s clear'
      TabOrder = 6
      OnClick = button_ClearLogClick
    end
    object panel_ComEcho: TPanel
      Left = 6
      Top = 78
      Width = 310
      Height = 89
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BiDiMode = bdLeftToRight
      Caption = ' 1231111'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
    end
    object ProgressBar1: TProgressBar
      Left = 2
      Top = 170
      Width = 638
      Height = 16
      Align = alBottom
      TabOrder = 8
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 228
    Top = 134
  end
  object Timer1: TTimer
    Interval = 40
    OnTimer = Timer1Timer
    Left = 176
    Top = 136
  end
  object ActionList1: TActionList
    Left = 120
    Top = 136
    object SendLoader: TAction
      Tag = 1
      Caption = 'SEND Loader'
      ShortCut = 116
      OnExecute = button_SendFile
    end
    object SEND_SPI_Prog_Loader: TAction
      Tag = 2
      Caption = 'SEND SPI Prog Loader'
      OnExecute = button_SendFile
    end
  end
end
