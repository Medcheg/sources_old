object PrintPreviewForm: TPrintPreviewForm
  Left = 57
  Top = 98
  BorderStyle = bsDialog
  Caption = 'Adaptive DTS - Окно подготовки к печати графиков моделирования'
  ClientHeight = 421
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 588
    Top = 0
    Width = 120
    Height = 380
    ActivePage = TabSheet1
    Align = alRight
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Абон №1'
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 112
        Height = 352
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Serif'
        Font.Style = []
        ItemHeight = 13
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
        Width = 112
        Height = 352
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnClick = ListBox2Click
      end
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 588
    Height = 380
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Foot.AdjustFrame = False
    Foot.Visible = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -16
    Title.Font.Name = 'Arial'
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'TChart')
    BottomAxis.Title.Caption = 'Время, t [с]'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -13
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsItalic]
    LeftAxis.AxisValuesFormat = '#,##0.#######'
    LeftAxis.StartPosition = 2
    LeftAxis.EndPosition = 98
    LeftAxis.Title.Caption = '[рад]'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -13
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsItalic]
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
    Top = 380
    Width = 708
    Height = 41
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Печать'
      TabOrder = 0
      OnClick = BitBtn1Click
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
    end
    object BitBtn2: TBitBtn
      Left = 624
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Отмена'
      TabOrder = 1
      Kind = bkCancel
    end
    object BitBtn3: TBitBtn
      Left = 120
      Top = 8
      Width = 161
      Height = 25
      Caption = 'Установки принтера'
      TabOrder = 2
      OnClick = BitBtn3Click
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDD00000000000DDDD0777777777070DD000000000000070D0777777BBB77
        000D077777711177070D00000000000007700777777777707070D00000000007
        0700DD0FFFFFFFF07070CCD0F00000F000CCDCC0FFFFFFFF0CCDDDCCCCCCCCCC
        CCDDDDCCCCCCCCCCCCDDDCCDD00000000CCDCCDDDDDDDDDDDDCC}
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 544
    Top = 8
  end
end
