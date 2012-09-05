object GraphNameForm: TGraphNameForm
  Left = 279
  Top = 138
  ActiveControl = Panel1
  BorderStyle = bsToolWindow
  Caption = 'Результаты моделирования аналоговой части'
  ClientHeight = 362
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 335
    Top = 33
    Width = 147
    Height = 329
    ActivePage = TabSheet2
    Align = alRight
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Абон №1'
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 139
        Height = 294
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Serif'
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 0
        OnClick = ListBox1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Абон №2'
      ImageIndex = 1
      object ListBox2: TListBox
        Left = 0
        Top = 0
        Width = 139
        Height = 294
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Serif'
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 0
        OnClick = ListBox2Click
      end
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 33
    Width = 335
    Height = 329
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.AxisValuesFormat = '#,##0.########'
    BottomAxis.Maximum = 10
    BottomAxis.Title.Caption = 'Время, t [с]'
    BottomAxis.Title.Font.Charset = RUSSIAN_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -11
    BottomAxis.Title.Font.Name = 'Courier'
    BottomAxis.Title.Font.Style = [fsItalic]
    LeftAxis.AxisValuesFormat = '#,##0.########'
    LeftAxis.StartPosition = 1
    LeftAxis.EndPosition = 99
    Legend.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 1
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Color = clRed
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 33
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 84
      Top = 9
      Width = 29
      Height = 16
      Hint = 'Такт дискретизации аналоговой части системы'
      Caption = 'T0 = '
      ParentShowHint = False
      ShowHint = True
    end
    object SpeedButton1: TSpeedButton
      Left = 2
      Top = 4
      Width = 29
      Height = 27
      Hint = 'Вывести окно печати графиков'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object CheckBox1: TCheckBox
      Left = 311
      Top = 6
      Width = 99
      Height = 21
      Hint = 'Слежение за графиками'
      Caption = 'Слежение'
      Checked = True
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
  end
end
