object frmPlanshetCreator: TfrmPlanshetCreator
  Left = 121
  Top = 296
  BorderStyle = bsDialog
  Caption = 'АМТ - Создать планшет  '
  ClientHeight = 280
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 272
    Top = 8
    Width = 86
    Height = 29
    Caption = 'Поле 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel4: TBevel
    Left = 544
    Top = 40
    Width = 153
    Height = 185
    Shape = bsFrame
  end
  object Bevel3: TBevel
    Left = 384
    Top = 40
    Width = 153
    Height = 185
    Shape = bsFrame
  end
  object Label11: TLabel
    Left = 581
    Top = 8
    Width = 86
    Height = 29
    Caption = 'Поле 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel
    Left = 429
    Top = 8
    Width = 86
    Height = 29
    Caption = 'Поле 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel2: TBevel
    Left = 224
    Top = 40
    Width = 153
    Height = 185
    Shape = bsFrame
  end
  object Label5: TLabel
    Left = 268
    Top = 5
    Width = 86
    Height = 29
    Caption = 'Поле 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 201
    Height = 249
    Shape = bsFrame
  end
  object SpeedButtonAddFile: TSpeedButton
    Left = 179
    Top = 33
    Width = 24
    Height = 23
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFF9999FFFFFFFFFFFF9999FFFFFFFFFFFF9999FFFFFFFFFFFF9999FF
      FFFFFFFFFF9999FFFFFFF99999999999999FF99999999999999FF99999999999
      999FF99999999999999FFFFFFF9999FFFFFFFFFFFF9999FFFFFFFFFFFF9999FF
      FFFFFFFFFF9999FFFFFFFFFFFF9999FFFFFFFFFFFFFFFFFFFFFF}
    OnClick = SpeedButtonAddFileClick
  end
  object SpeedButtonRemoveFile: TSpeedButton
    Left = 179
    Top = 57
    Width = 24
    Height = 23
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99999999999
      999FF88888888888888FF99999999999999FF88888888888888FF99999999999
      999FF88888888888888FF99999999999999FF88888888888888FFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    NumGlyphs = 2
    OnClick = SpeedButtonRemoveFileClick
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 160
    Height = 13
    Caption = 'Перечень загруженных файлов'
  end
  object Label2: TLabel
    Left = 16
    Top = 152
    Width = 133
    Height = 13
    Caption = 'Перечень кривых в файле'
  end
  object Label3: TLabel
    Left = 232
    Top = 48
    Width = 131
    Height = 13
    Caption = 'Перечень кривых на поле'
  end
  object Gauge1: TGauge
    Left = 16
    Top = 133
    Width = 161
    Height = 17
    Hint = 'Состояние загрузки файла'
    ForeColor = clBlue
    MaxValue = 10000
    ParentShowHint = False
    Progress = 0
    ShowHint = True
  end
  object Label6: TLabel
    Left = 392
    Top = 48
    Width = 131
    Height = 13
    Caption = 'Перечень кривых на поле'
  end
  object Label7: TLabel
    Left = 425
    Top = 5
    Width = 86
    Height = 29
    Caption = 'Поле 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel
    Left = 552
    Top = 48
    Width = 131
    Height = 13
    Caption = 'Перечень кривых на поле'
  end
  object Label10: TLabel
    Left = 577
    Top = 5
    Width = 86
    Height = 29
    Caption = 'Поле 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object ListBox1: TListBox
    Left = 16
    Top = 32
    Width = 161
    Height = 97
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
    OnKeyDown = ListBox1KeyDown
  end
  object ListBox2: TListBox
    Left = 16
    Top = 168
    Width = 161
    Height = 81
    DragMode = dmAutomatic
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox2Click
    OnDragOver = ListBox2DragOver
  end
  object ListBox3: TListBox
    Left = 232
    Top = 72
    Width = 137
    Height = 145
    ItemHeight = 13
    TabOrder = 2
    OnClick = ListBox3Click
    OnDragDrop = ListBox3DragDrop
    OnDragOver = ListBox2DragOver
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 261
    Width = 700
    Height = 19
    Panels = <
      item
        Text = 'Пусто'
        Width = 50
      end>
    SimplePanel = False
  end
  object BitBtn1: TBitBtn
    Left = 224
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Да'
    TabOrder = 4
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 621
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 5
    Kind = bkCancel
  end
  object ListBox4: TListBox
    Left = 392
    Top = 72
    Width = 137
    Height = 145
    ItemHeight = 13
    TabOrder = 6
    OnClick = ListBox3Click
    OnDragDrop = ListBox3DragDrop
    OnDragOver = ListBox2DragOver
  end
  object ListBox5: TListBox
    Left = 552
    Top = 72
    Width = 137
    Height = 145
    ItemHeight = 13
    TabOrder = 7
    OnClick = ListBox3Click
    OnDragDrop = ListBox3DragDrop
    OnDragOver = ListBox2DragOver
  end
  object OpenDialog1: TOpenDialog
    Left = 176
    Top = 80
  end
end
