object frmMarks: TfrmMarks
  Left = 371
  Top = 191
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'frmMarks'
  ClientHeight = 188
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 25
    Width = 41
    Height = 13
    Caption = 'Глубина'
    OnDblClick = Label1DblClick
  end
  object Label2: TLabel
    Left = 65
    Top = 25
    Width = 55
    Height = 13
    Caption = 'Кореляция'
    Visible = False
  end
  object Label4: TLabel
    Left = 136
    Top = 25
    Width = 54
    Height = 13
    Caption = 'Смещение'
    Visible = False
  end
  object ScrollBar1: TScrollBar
    Left = 219
    Top = 41
    Width = 16
    Height = 145
    Kind = sbVertical
    Max = 0
    PageSize = 0
    TabOrder = 0
    OnChange = ScrollBar1Change
  end
  object ListBox1: TListBox
    Left = 0
    Top = 40
    Width = 73
    Height = 150
    BorderStyle = bsNone
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object ListBox2: TListBox
    Left = 73
    Top = 40
    Width = 73
    Height = 150
    BorderStyle = bsNone
    ItemHeight = 13
    TabOrder = 2
    OnEnter = ListBox23Enter
  end
  object ListBox3: TListBox
    Left = 145
    Top = 40
    Width = 73
    Height = 150
    BorderStyle = bsNone
    ItemHeight = 13
    TabOrder = 3
    OnEnter = ListBox23Enter
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 236
    Height = 50
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 57
    Caption = 'ToolBar1'
    EdgeBorders = []
    Flat = True
    ShowCaptions = True
    TabOrder = 4
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = 'Excel'
      Grouped = True
      ImageIndex = 2
      OnClick = MicrosoftExcell1Click
    end
    object ToolButton4: TToolButton
      Left = 37
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbSortirovka: TToolButton
      Left = 45
      Top = 0
      AutoSize = True
      Caption = 'Вид'
      DropdownMenu = pmView
      Grouped = True
      ImageIndex = 0
    end
    object ToolButton5: TToolButton
      Left = 0
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 2
      Wrap = True
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 0
      Top = 29
      AutoSize = True
      Caption = 'Фильтр'
      DropdownMenu = pmFiltrs
      Grouped = True
      ImageIndex = 2
    end
    object ToolButton6: TToolButton
      Left = 51
      Top = 29
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 59
      Top = 29
      AutoSize = True
      Caption = 'Удаление'
      DropdownMenu = pmDelete
      Grouped = True
      ImageIndex = 1
    end
  end
  object pmView: TPopupMenu
    Left = 48
    Top = 40
    object miSortByDepth: TMenuItem
      Caption = 'Сортировать по глубине'
      OnClick = miSortByDepthClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miSortByKorel: TMenuItem
      Caption = 'Сортировать по корреляции'
      OnClick = miSortByKorelClick
    end
  end
  object pmDelete: TPopupMenu
    Left = 144
    Top = 40
    object miDeleteMark: TMenuItem
      Caption = 'Удалить текущую отметку'
      Enabled = False
      OnClick = miDeleteMarkClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object miDeleteAllMark: TMenuItem
      Caption = 'Удалить все отметки'
      OnClick = miDeleteAllMarkClick
    end
  end
  object pmFiltrs: TPopupMenu
    Left = 88
    Top = 40
    object miDepthFilter: TMenuItem
      Caption = 'Фильтр по глубине'
      OnClick = miDepthFilterClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object miRepeatDepth: TMenuItem
      Caption = 'Фильтр по повторяемости'
      OnClick = miRepeatDepthClick
    end
  end
end
