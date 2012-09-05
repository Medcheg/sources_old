object frmLegentParam: TfrmLegentParam
  Left = 840
  Top = 135
  ActiveControl = ToolBar1
  BorderStyle = bsToolWindow
  Caption = 'АМТ- Легенда'
  ClientHeight = 313
  ClientWidth = 167
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 32
    Width = 44
    Height = 13
    Caption = 'Подписи'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 216
    Width = 107
    Height = 13
    Caption = 'Временной интервал'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 232
    Width = 37
    Height = 13
    Caption = 'Начало'
  end
  object Label6: TLabel
    Left = 11
    Top = 272
    Width = 31
    Height = 13
    Caption = 'Конец'
  end
  object Label2: TLabel
    Left = 16
    Top = 152
    Width = 120
    Height = 13
    Caption = 'Условные обозначения'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 167
    Height = 26
    ButtonHeight = 21
    ButtonWidth = 167
    Caption = 'ToolBar1'
    EdgeBorders = []
    ShowCaptions = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Cursor = crArrow
      Caption = '               Новая легенда             '
      ImageIndex = 0
      Style = tbsCheck
      OnClick = ToolButton1Click
    end
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
  end
  object edStartTime: TEdit
    Left = 24
    Top = 248
    Width = 129
    Height = 21
    ReadOnly = True
    TabOrder = 2
    Text = 'edStartTime'
  end
  object edEndTime: TEdit
    Left = 24
    Top = 288
    Width = 129
    Height = 21
    ReadOnly = True
    TabOrder = 3
    Text = 'edEndTime'
  end
  object RadioButton2: TRadioButton
    Left = 16
    Top = 197
    Width = 105
    Height = 17
    Caption = 'Свабирование'
    Checked = True
    Enabled = False
    TabOrder = 4
    TabStop = True
    OnClick = RadioButton2Click
  end
  object RadioButton1: TRadioButton
    Left = 16
    Top = 176
    Width = 145
    Height = 17
    Caption = 'Восстановление уровня'
    Enabled = False
    TabOrder = 5
    OnClick = RadioButton1Click
  end
end
