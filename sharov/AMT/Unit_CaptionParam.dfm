object frmCaptionParam: TfrmCaptionParam
  Left = 832
  Top = 141
  ActiveControl = ToolBar1
  BorderStyle = bsToolWindow
  Caption = 'АМТ - Надписи'
  ClientHeight = 386
  ClientWidth = 168
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 18
    Top = 185
    Width = 129
    Height = 26
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 8
    Top = 238
    Width = 75
    Height = 13
    Caption = 'Текст надписи'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnMouseMove = FormMouseMove
  end
  object Label2: TLabel
    Left = 24
    Top = 152
    Width = 61
    Height = 13
    Caption = 'Ориентация'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnMouseMove = FormMouseMove
  end
  object Label3: TLabel
    Left = 8
    Top = 32
    Width = 44
    Height = 13
    Caption = 'Надписи'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnMouseMove = FormMouseMove
  end
  object Label4: TLabel
    Left = 8
    Top = 288
    Width = 107
    Height = 13
    Caption = 'Временной интервал'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnMouseMove = FormMouseMove
  end
  object Label5: TLabel
    Left = 8
    Top = 304
    Width = 37
    Height = 13
    Caption = 'Начало'
    OnMouseMove = FormMouseMove
  end
  object Label6: TLabel
    Left = 11
    Top = 344
    Width = 31
    Height = 13
    Caption = 'Конец'
    OnMouseMove = FormMouseMove
  end
  object edCaption: TEdit
    Left = 8
    Top = 256
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 0
    Text = 'edCaption'
    OnChange = edCaptionChange
    OnMouseMove = FormMouseMove
  end
  object ListBox1: TListBox
    Left = 8
    Top = 48
    Width = 153
    Height = 97
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
    OnKeyDown = ListBox1KeyDown
    OnMouseMove = FormMouseMove
  end
  object Button1: TButton
    Left = 113
    Top = 238
    Width = 48
    Height = 16
    Caption = 'шрифт'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button1Click
    OnMouseMove = FormMouseMove
  end
  object edStartTime: TEdit
    Left = 24
    Top = 320
    Width = 129
    Height = 21
    ReadOnly = True
    TabOrder = 5
    Text = 'edStartTime'
    OnMouseMove = FormMouseMove
  end
  object edEndTime: TEdit
    Left = 24
    Top = 360
    Width = 129
    Height = 21
    ReadOnly = True
    TabOrder = 6
    Text = 'edEndTime'
    OnMouseMove = FormMouseMove
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 168
    Height = 26
    ButtonHeight = 21
    ButtonWidth = 168
    Caption = 'ToolBar1'
    EdgeBorders = []
    ShowCaptions = True
    TabOrder = 7
    OnMouseMove = FormMouseMove
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Cursor = crArrow
      Caption = '               Новая надпись             '
      ImageIndex = 0
      Style = tbsCheck
      OnClick = ToolButton1Click
      OnMouseMove = FormMouseMove
    end
  end
  object RadioButton1: TRadioButton
    Left = 32
    Top = 192
    Width = 105
    Height = 17
    Caption = 'Горизонтальная'
    Checked = True
    Enabled = False
    TabOrder = 2
    TabStop = True
    OnClick = RadioButton1Click
    OnMouseMove = FormMouseMove
  end
  object RadioButton2: TRadioButton
    Left = 32
    Top = 173
    Width = 105
    Height = 17
    Caption = 'Вертикальная'
    Enabled = False
    TabOrder = 3
    OnClick = RadioButton2Click
    OnMouseMove = FormMouseMove
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 213
    Width = 113
    Height = 17
    Caption = 'Вкл/Выкл Линии'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 131
    Top = 50
  end
end
