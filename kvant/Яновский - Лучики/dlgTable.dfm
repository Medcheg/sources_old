object frmTable: TfrmTable
  Left = 86
  Top = 106
  ActiveControl = StringGrid1
  BorderStyle = bsDialog
  Caption = 'AdaptiveDTS - Табличные данные результатов моделирования'
  ClientHeight = 389
  ClientWidth = 641
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 41
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Закрыть'
      TabOrder = 0
      OnClick = Button1Click
    end
    object BitBtn1: TBitBtn
      Left = 104
      Top = 8
      Width = 185
      Height = 25
      Caption = 'Записать таблицу у файл'
      TabOrder = 1
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 641
    Height = 348
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Абонент №1'
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 617
        Height = 320
        Align = alClient
        ColCount = 15
        DefaultColWidth = 110
        RowCount = 22
        ScrollBars = ssHorizontal
        TabOrder = 0
      end
      object ScrollBar1: TScrollBar
        Left = 617
        Top = 0
        Width = 16
        Height = 320
        Align = alRight
        Kind = sbVertical
        PageSize = 0
        TabOrder = 1
        OnChange = ScrollBar1Change
        OnScroll = ScrollBar1Scroll
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Абонент №2'
      ImageIndex = 1
      object StringGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 617
        Height = 320
        Align = alClient
        ColCount = 15
        DefaultColWidth = 110
        RowCount = 22
        ScrollBars = ssHorizontal
        TabOrder = 0
      end
      object ScrollBar2: TScrollBar
        Left = 617
        Top = 0
        Width = 16
        Height = 320
        Align = alRight
        Kind = sbVertical
        PageSize = 0
        TabOrder = 1
        OnChange = ScrollBar2Change
        OnScroll = ScrollBar2Scroll
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 304
    Top = 8
  end
end
