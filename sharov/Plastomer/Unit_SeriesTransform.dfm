object frmSeriesTransform: TfrmSeriesTransform
  Left = 80
  Top = 46
  ActiveControl = BitBtn1
  BorderStyle = bsDialog
  Caption = 'frmSeriesTransform'
  ClientHeight = 620
  ClientWidth = 853
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Tag = -1
    Left = 8
    Top = 8
    Width = 145
    Height = 13
    Caption = 'Перечень "ведущих" кривых'
  end
  object Label1: TLabel
    Left = 184
    Top = 8
    Width = 86
    Height = 13
    Caption = 'Преобразования'
  end
  object pMNK: TPanel
    Left = 632
    Top = 48
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 5
    object lName3: TLabel
      Left = 88
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 32
      Top = 69
      Width = 25
      Height = 20
      Caption = 'k ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 14
      Top = 49
      Width = 196
      Height = 13
      Caption = 'Коэффициент сгаживающего фильтра'
    end
    object bbMNK: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 0
      OnClick = bbMNKClick
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
    object seMNKCoef: TSpinEdit
      Left = 64
      Top = 68
      Width = 121
      Height = 22
      EditorEnabled = False
      Increment = 2
      MaxValue = 200
      MinValue = 2
      TabOrder = 1
      Value = 10
    end
  end
  object pMul: TPanel
    Left = 408
    Top = 48
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 4
    object Label6: TLabel
      Left = 48
      Top = 24
      Width = 99
      Height = 20
      Caption = 'y(t) = x(t) * k'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lName2: TLabel
      Left = 80
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 32
      Top = 69
      Width = 25
      Height = 20
      Caption = 'k ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object eMulCoef: TEdit
      Left = 64
      Top = 69
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'eMulCoef'
    end
    object bbMul: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 1
      OnClick = bbMulClick
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
  end
  object lbSeries: TListBox
    Tag = -1
    Left = 8
    Top = 25
    Width = 161
    Height = 233
    Columns = 3
    DragMode = dmAutomatic
    ItemHeight = 13
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 184
    Top = 24
    Width = 217
    Height = 21
    Style = csDropDownList
    DropDownCount = 9
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBox1Change
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 267
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'Закрыть'
    Default = True
    ModalResult = 2
    TabOrder = 3
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
  object pAdd: TPanel
    Left = 184
    Top = 48
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 2
    object Label3: TLabel
      Left = 48
      Top = 24
      Width = 102
      Height = 20
      Caption = 'y(t) = x(t) + k'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lName1: TLabel
      Left = 80
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 32
      Top = 69
      Width = 25
      Height = 20
      Caption = 'k ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object eAddCoef: TEdit
      Left = 64
      Top = 69
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'eAddCoef'
    end
    object bbAdd: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 1
      OnClick = bbAddClick
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
  end
  object pDivSeries1toSeries2: TPanel
    Left = 408
    Top = 336
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 7
    object lName7: TLabel
      Left = 72
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 61
      Top = 56
      Width = 90
      Height = 13
      Caption = 'Выберете кривую'
    end
    object Label17: TLabel
      Left = 16
      Top = 32
      Width = 94
      Height = 13
      Caption = 'Имя новой кривой'
    end
    object bbDivSeries1toSeries2: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 0
      OnClick = bbDivSeries1toSeries2Click
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
    object cbDivSeries1toSeries2: TComboBox
      Left = 40
      Top = 72
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object eNameDivSeries1toSeries2: TEdit
      Left = 128
      Top = 28
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '- Нет имени -'
    end
  end
  object pSubSeries1toSeries2: TPanel
    Left = 632
    Top = 192
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 9
    object lName5: TLabel
      Left = 80
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label22: TLabel
      Left = 61
      Top = 56
      Width = 90
      Height = 13
      Caption = 'Выберете кривую'
    end
    object Label23: TLabel
      Left = 16
      Top = 32
      Width = 94
      Height = 13
      Caption = 'Имя новой кривой'
    end
    object bbSubSeries1toSeries2: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 0
      OnClick = bbSubSeries1toSeries2Click
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
    object cbSubSeries1toSeries2: TComboBox
      Left = 40
      Top = 72
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object eNameSubSeries1toSeries2: TEdit
      Left = 128
      Top = 28
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '- Нет имени -'
    end
  end
  object pAddSeries1toSeries2: TPanel
    Left = 408
    Top = 192
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 8
    object lName4: TLabel
      Left = 88
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 61
      Top = 56
      Width = 90
      Height = 13
      Caption = 'Выберете кривую'
    end
    object Label20: TLabel
      Left = 16
      Top = 32
      Width = 94
      Height = 13
      Caption = 'Имя новой кривой'
    end
    object bbAddSeries1toSeries2: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 0
      OnClick = bbAddSeries1toSeries2Click
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
    object cbAddSeries1toSeries2: TComboBox
      Left = 40
      Top = 72
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object eNameAddSeries1toSeries2: TEdit
      Left = 128
      Top = 28
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '- Нет имени -'
    end
  end
  object pMulSeries1toSeries2: TPanel
    Left = 184
    Top = 336
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 6
    object lName6: TLabel
      Left = 72
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 61
      Top = 56
      Width = 90
      Height = 13
      Caption = 'Выберете кривую'
    end
    object Label16: TLabel
      Left = 16
      Top = 32
      Width = 94
      Height = 13
      Caption = 'Имя новой кривой'
    end
    object bbMulSeries1toSeries2: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 0
      OnClick = bbMulSeries1toSeries2Click
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
    object cbMulSeries1toSeries2: TComboBox
      Left = 40
      Top = 72
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object eNameMulSeries1toSeries2: TEdit
      Left = 128
      Top = 28
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '- Нет имени -'
    end
  end
  object pCopySeries: TPanel
    Left = 632
    Top = 334
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 10
    object lName8: TLabel
      Left = 98
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 69
      Top = 40
      Width = 94
      Height = 13
      Caption = 'Имя новой кривой'
    end
    object bbCopySeries: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Копировать кривую'
      TabOrder = 0
      OnClick = bbCopySeriesClick
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
    object eNameCopySeries: TEdit
      Left = 80
      Top = 60
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '- Нет имени -'
    end
  end
  object pDeleteSeries: TPanel
    Left = 184
    Top = 478
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 11
    object lName9: TLabel
      Left = 98
      Top = 8
      Width = 36
      Height = 13
      Caption = 'lName9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 71
      Top = 40
      Width = 90
      Height = 13
      Caption = 'Выберете кривую'
    end
    object bbDeleteSeries: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Удалить кривую'
      TabOrder = 0
      OnClick = bbDeleteSeriesClick
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
    object cbDeleteSeries: TComboBox
      Left = 44
      Top = 56
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object pAzimMNK: TPanel
    Left = 184
    Top = 192
    Width = 217
    Height = 137
    BevelInner = bvLowered
    TabOrder = 12
    object lName10: TLabel
      Left = 88
      Top = 8
      Width = 42
      Height = 13
      Caption = 'lName10'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 32
      Top = 69
      Width = 25
      Height = 20
      Caption = 'k ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 14
      Top = 49
      Width = 196
      Height = 13
      Caption = 'Коэффициент сгаживающего фильтра'
    end
    object bbAzimMNK: TBitBtn
      Left = 40
      Top = 104
      Width = 153
      Height = 25
      Caption = 'Применить'
      TabOrder = 0
      OnClick = bbAzimMNKClick
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
    object seAzimMNKCoef: TSpinEdit
      Left = 64
      Top = 68
      Width = 121
      Height = 22
      EditorEnabled = False
      Increment = 2
      MaxValue = 200
      MinValue = 2
      TabOrder = 1
      Value = 10
    end
  end
end
