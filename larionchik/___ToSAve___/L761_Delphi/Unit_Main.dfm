object Form1: TForm1
  Left = 191
  Top = 55
  Width = 615
  Height = 413
  ActiveControl = Panel1
  Caption = 'Анализатор - []'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 607
    Height = 56
    Align = alTop
    AutoSize = True
    TabOrder = 0
    OnMouseMove = Image1MouseMove
    object ToolBar1: TToolBar
      Left = 577
      Top = 28
      Width = 24
      Height = 22
      Caption = 'ToolBar1'
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      TabOrder = 0
      OnMouseMove = Image1MouseMove
      object ToolButton5: TToolButton
        Left = 0
        Top = 0
        Caption = 'ToolButton5'
        Grouped = True
        ImageIndex = 0
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton6: TToolButton
        Left = 0
        Top = 22
        Caption = 'ToolButton6'
        Grouped = True
        ImageIndex = 1
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton7: TToolButton
        Left = 0
        Top = 44
        Caption = 'ToolButton7'
        Grouped = True
        ImageIndex = 2
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton8: TToolButton
        Left = 0
        Top = 66
        Caption = 'ToolButton8'
        Grouped = True
        ImageIndex = 3
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton9: TToolButton
        Left = 0
        Top = 88
        Caption = 'ToolButton9'
        Grouped = True
        ImageIndex = 4
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton10: TToolButton
        Left = 0
        Top = 110
        Caption = 'ToolButton10'
        Grouped = True
        ImageIndex = 5
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton11: TToolButton
        Left = 0
        Top = 132
        Caption = 'ToolButton11'
        Grouped = True
        ImageIndex = 6
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton12: TToolButton
        Left = 0
        Top = 154
        Caption = 'ToolButton12'
        Grouped = True
        ImageIndex = 7
        Wrap = True
        Visible = False
        OnMouseMove = Image1MouseMove
      end
      object ToolButton13: TToolButton
        Left = 0
        Top = 176
        Caption = 'ToolButton13'
        Grouped = True
        ImageIndex = 8
        Visible = False
        OnMouseMove = Image1MouseMove
      end
    end
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 553
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 201
      Caption = 'ToolBar1'
      EdgeBorders = []
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      ShowCaptions = True
      TabOrder = 1
      OnMouseMove = Image1MouseMove
      object tbFile: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = '  Файл  '
        DropdownMenu = PopupMenu1
        Grouped = True
        ImageIndex = 0
        OnMouseMove = Image1MouseMove
      end
      object tbReadACPData: TToolButton
        Left = 52
        Top = 0
        AutoSize = True
        Caption = 'Индикация сигналов акселерометров'
        Grouped = True
        ImageIndex = 1
        OnClick = tbReadACPDataClick
        OnMouseMove = Image1MouseMove
      end
      object tbService: TToolButton
        Left = 257
        Top = 0
        AutoSize = True
        Caption = '  Сервис  '
        DropdownMenu = PopupMenu2
        Grouped = True
        ImageIndex = 2
        OnMouseMove = Image1MouseMove
      end
      object nSpectr: TToolButton
        Left = 317
        Top = 0
        AutoSize = True
        Caption = '  Спектр  '
        Grouped = True
        ImageIndex = 3
        OnClick = tbFFTClick
        OnMouseMove = Image1MouseMove
      end
      object tbAbout: TToolButton
        Left = 376
        Top = 0
        AutoSize = True
        Caption = '  О программе...  '
        Grouped = True
        ImageIndex = 4
        OnClick = tbAboutClick
      end
    end
  end
  object Panel4: TPanel
    Left = 468
    Top = 56
    Width = 139
    Height = 330
    Align = alRight
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    OnMouseMove = Image1MouseMove
    object Label1: TLabel
      Left = 19
      Top = 13
      Width = 74
      Height = 20
      Caption = 'Канал №'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 94
      Top = 13
      Width = 11
      Height = 20
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 11
      Top = 120
      Width = 112
      Height = 13
      Caption = 'Значение времени'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 27
      Top = 144
      Width = 78
      Height = 13
      Caption = '--------------------------'
    end
    object Label5: TLabel
      Left = 11
      Top = 56
      Width = 103
      Height = 13
      Caption = 'Значение кривой'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 27
      Top = 80
      Width = 78
      Height = 13
      Caption = '--------------------------'
    end
    object Label7: TLabel
      Left = 10
      Top = 270
      Width = 109
      Height = 13
      Caption = 'Масштаб времени'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 27
      Top = 96
      Width = 78
      Height = 13
      Caption = '--------------------------'
    end
    object Label9: TLabel
      Left = 10
      Top = 216
      Width = 103
      Height = 13
      Caption = 'Масштаб оси "Y"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 10
      Top = 288
      Width = 110
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = '1 : 1'
      OnChange = ComboBox1Change
      Items.Strings = (
        '1 : 1'
        '1 : 2'
        '1 : 4'
        '1 : 8'
        '1 : 16'
        '1 : 32'
        '1 : 64'
        '1 : 128'
        '1 : 256'
        '1 : 512'
        '1 : 1024')
    end
    object Panel3: TPanel
      Left = -1
      Top = 168
      Width = 140
      Height = 41
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object ControlBar2: TControlBar
        Left = 2
        Top = 2
        Width = 136
        Height = 29
        Align = alTop
        AutoSize = True
        TabOrder = 0
        object ToolBar3: TToolBar
          Left = 11
          Top = 2
          Width = 119
          Height = 21
          AutoSize = True
          ButtonHeight = 21
          ButtonWidth = 57
          Caption = 'ToolBar3'
          EdgeBorders = []
          Flat = True
          ShowCaptions = True
          TabOrder = 0
          object tbAdd: TToolButton
            Left = 0
            Top = 0
            AutoSize = True
            Caption = 'Добавить'
            Grouped = True
            ImageIndex = 0
            OnClick = tbAddClick
          end
          object tbClear: TToolButton
            Left = 61
            Top = 0
            AutoSize = True
            Caption = 'Очистить'
            Grouped = True
            ImageIndex = 1
            OnClick = tbClearClick
          end
        end
      end
      object ListBox1: TListBox
        Left = 2
        Top = 31
        Width = 136
        Height = 8
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
        OnKeyDown = ListBox1KeyDown
      end
    end
    object ComboBox2: TComboBox
      Left = 10
      Top = 232
      Width = 110
      Height = 21
      DropDownCount = 33
      ItemHeight = 13
      TabOrder = 2
      Text = '1 : 1'
      OnChange = ComboBox2Change
      Items.Strings = (
        '1       : 1'
        '2       : 1'
        '4       : 1'
        '8       : 1'
        '10     : 1'
        '25     : 1'
        '50     : 1'
        '100   : 1'
        '200   : 1'
        '300   : 1'
        '500   : 1'
        '1000 : 1')
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 56
    Width = 468
    Height = 330
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object ScrollBar1: TScrollBar
      Left = 0
      Top = 314
      Width = 468
      Height = 16
      Align = alBottom
      Max = 0
      PageSize = 0
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
    object TabControl1: TTabControl
      Left = 0
      Top = 0
      Width = 468
      Height = 314
      Align = alClient
      HotTrack = True
      TabOrder = 1
      Tabs.Strings = (
        'Канал 1'
        'Канал 2'
        'Канал 3')
      TabIndex = 0
      OnChange = TabControl1Change
      OnMouseMove = Image1MouseMove
      object Panel2: TPanel
        Left = 4
        Top = 24
        Width = 460
        Height = 286
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Image1: TImage
          Left = 2
          Top = 2
          Width = 456
          Height = 282
          Align = alClient
          OnMouseMove = Image1MouseMove
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 10
    Top = 26
    object nOpenFile: TMenuItem
      Caption = 'Открыть файл реализации'
      OnClick = nOpenFileClick
    end
    object nSaveFile: TMenuItem
      Caption = 'Сохранить реализацию'
      OnClick = nSaveFileClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object nSaveBitampToFile: TMenuItem
      Caption = 'Сохранить текущий график'
      OnClick = nSaveBitampToFileClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object nClose: TMenuItem
      Caption = 'Выход ...'
      OnClick = nCloseClick
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 74
    Top = 26
  end
  object OpenDialog1: TOpenDialog
    Left = 42
    Top = 26
  end
  object PopupMenu2: TPopupMenu
    Left = 274
    Top = 26
    object N2: TMenuItem
      Caption = 'Оценка максимумов каналов'
      OnClick = N2Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = 'Фильтрация'
      OnClick = tbFiltrClick
    end
  end
end
