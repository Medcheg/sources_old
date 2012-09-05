object frmTargetsParam: TfrmTargetsParam
  Left = 520
  Top = 297
  BorderStyle = bsDialog
  Caption = 'frmTargetsParam'
  ClientHeight = 286
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 0
    Top = 0
    Width = 359
    Height = 286
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 87
    Height = 13
    Caption = 'Список целей:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 130
    Top = 37
    Width = 89
    Height = 13
    Caption = 'Параметры цели:'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 32
    Width = 113
    Height = 217
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    ModalResult = 1
    TabOrder = 1
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object ToolBar1: TToolBar
    Left = 128
    Top = 4
    Width = 225
    Height = 25
    Align = alNone
    ButtonHeight = 21
    ButtonWidth = 96
    Caption = 'ToolBar1'
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Flat = True
    ShowCaptions = True
    TabOrder = 2
    object tbDeleteTarget: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = '  Удалить цель  '
      Enabled = False
      Grouped = True
      ImageIndex = 0
      OnClick = tbDeleteTargetClick
    end
    object tbAddTarget: TToolButton
      Left = 93
      Top = 0
      AutoSize = True
      Caption = '  Добавить цель  '
      Grouped = True
      ImageIndex = 1
      OnClick = tbAddTargetClick
    end
  end
  object Panel1: TPanel
    Left = 128
    Top = 54
    Width = 225
    Height = 195
    BevelInner = bvLowered
    TabOrder = 3
    object Label3: TLabel
      Left = 31
      Top = 18
      Width = 83
      Height = 13
      Caption = 'Дальность цели'
    end
    object Label4: TLabel
      Left = 50
      Top = 42
      Width = 64
      Height = 13
      Caption = 'Пеленг цели'
    end
    object Label5: TLabel
      Left = 39
      Top = 66
      Width = 75
      Height = 13
      Caption = 'Скорость цели'
    end
    object Label6: TLabel
      Left = 49
      Top = 90
      Width = 65
      Height = 13
      Caption = 'Высота цели'
    end
    object Label7: TLabel
      Left = 10
      Top = 114
      Width = 104
      Height = 13
      Caption = 'Курс движения цели'
    end
    object Label8: TLabel
      Left = 13
      Top = 138
      Width = 101
      Height = 13
      Caption = 'Номер трассы цели'
    end
    object Label9: TLabel
      Left = 191
      Top = 18
      Width = 14
      Height = 13
      Caption = 'км'
    end
    object Label10: TLabel
      Left = 191
      Top = 42
      Width = 11
      Height = 13
      Caption = 'гр'
    end
    object Label11: TLabel
      Left = 191
      Top = 66
      Width = 25
      Height = 13
      Caption = 'км/с'
    end
    object Label12: TLabel
      Left = 191
      Top = 90
      Width = 14
      Height = 13
      Caption = 'км'
    end
    object Label13: TLabel
      Left = 191
      Top = 114
      Width = 11
      Height = 13
      Caption = 'гр'
    end
    object efR0: TEdit
      Left = 120
      Top = 14
      Width = 65
      Height = 21
      TabOrder = 0
      Text = 'efR0'
      OnChange = eChange
    end
    object efV0: TEdit
      Left = 120
      Top = 62
      Width = 65
      Height = 21
      TabOrder = 1
      Text = 'efV0'
      OnChange = eChange
    end
    object efH0: TEdit
      Left = 120
      Top = 86
      Width = 65
      Height = 21
      TabOrder = 2
      Text = 'FloatEdit1'
      OnChange = eChange
    end
    object eiId: TEdit
      Left = 120
      Top = 134
      Width = 65
      Height = 21
      TabOrder = 3
      Text = 'eiId'
      OnChange = eChange
    end
    object egrB0: TEdit
      Left = 120
      Top = 38
      Width = 65
      Height = 21
      TabOrder = 4
      Text = 'egrB0'
      OnChange = eChange
    end
    object egrK0: TEdit
      Left = 120
      Top = 110
      Width = 65
      Height = 21
      TabOrder = 5
      Text = 'GradusEdit1'
      OnChange = eChange
    end
    object BitBtn3: TBitBtn
      Left = 8
      Top = 166
      Width = 81
      Height = 25
      Caption = 'Принять'
      Default = True
      TabOrder = 6
      Visible = False
      OnClick = BitBtn3Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn4: TBitBtn
      Left = 142
      Top = 166
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Отмена'
      TabOrder = 7
      Visible = False
      OnClick = BitBtn4Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
