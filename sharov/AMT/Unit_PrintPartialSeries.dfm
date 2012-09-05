object frmPrintPartialSeries: TfrmPrintPartialSeries
  Left = 116
  Top = 117
  Width = 848
  Height = 553
  Caption = 'АМТ - Печать выделенного фрагмента кривой'
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
  object Panel11: TPanel
    Left = 0
    Top = 0
    Width = 186
    Height = 526
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 106
      Height = 13
      Caption = 'Подпись диаграммы'
    end
    object Label2: TLabel
      Left = 32
      Top = 128
      Width = 94
      Height = 13
      Alignment = taCenter
      Caption = 'Первой страницей'
      Visible = False
      WordWrap = True
      OnClick = Label2Click
    end
    object Label3: TLabel
      Left = 32
      Top = 144
      Width = 115
      Height = 13
      Caption = 'заголовок диаграммы'
      Visible = False
    end
    object Bevel1: TBevel
      Left = 6
      Top = 108
      Width = 169
      Height = 53
      Shape = bsFrame
      Visible = False
    end
    object Label4: TLabel
      Left = 8
      Top = 56
      Width = 133
      Height = 13
      Caption = 'Подпись верткальной оси'
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 496
      Width = 75
      Height = 25
      Caption = 'Печать'
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000004000
        000080000000FF000000002000004020000080200000FF200000004000004040
        000080400000FF400000006000004060000080600000FF600000008000004080
        000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
        000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
        200080002000FF002000002020004020200080202000FF202000004020004040
        200080402000FF402000006020004060200080602000FF602000008020004080
        200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
        200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
        400080004000FF004000002040004020400080204000FF204000004040004040
        400080404000FF404000006040004060400080604000FF604000008040004080
        400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
        400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
        600080006000FF006000002060004020600080206000FF206000004060004040
        600080406000FF406000006060004060600080606000FF606000008060004080
        600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
        600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
        800080008000FF008000002080004020800080208000FF208000004080004040
        800080408000FF408000006080004060800080608000FF608000008080004080
        800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
        800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
        A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
        A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
        A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
        A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
        C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
        C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
        C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
        C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
        FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
        FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
        FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
        FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00E3E3E3E3E3E3
        E3E3E3E3E3E3E3E3E3E3E3E30000000000000000000000E3E3E3E30092929292
        9292929292009200E3E3000000000000000000000000009200E3009292929292
        92FCFCFC9292000000E3009292929292928080809292009200E3000000000000
        0000000000000092920000929292929292929292920092009200E30000000000
        00000000009200920000E3E300FFFFFFFFFFFFFFFF0092009200E3E3E300FF00
        00000000FF00000000E3E3E3E300FFFFFFFFFFFFFFFF00E3E3E3E3E3E3E300FF
        0000000000FF00E3E3E3E3E3E3E300FFFFFFFFFFFFFFFF00E3E3E3E3E3E3E300
        0000000000000000E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3}
    end
    object BitBtn2: TBitBtn
      Left = 104
      Top = 496
      Width = 75
      Height = 25
      Caption = 'Отмена'
      TabOrder = 1
      Kind = bkCancel
    end
    object Edit1: TEdit
      Left = 8
      Top = 24
      Width = 169
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
      OnChange = Edit1Change
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 112
      Width = 73
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Вкл/выкл'
      TabOrder = 3
      Visible = False
    end
    object Edit2: TEdit
      Left = 8
      Top = 72
      Width = 169
      Height = 21
      TabOrder = 4
      Text = 'Давление '
      OnChange = Edit2Change
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 168
      Width = 169
      Height = 97
      Caption = 'Отступы'
      TabOrder = 5
      Visible = False
      object Label5: TLabel
        Left = 109
        Top = 23
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label6: TLabel
        Left = 149
        Top = 47
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label7: TLabel
        Left = 109
        Top = 71
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label8: TLabel
        Left = 69
        Top = 47
        Width = 8
        Height = 13
        Caption = '%'
      end
      object se111: TSpinEdit
        Left = 64
        Top = 19
        Width = 41
        Height = 22
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 10
        OnChange = seChange
      end
      object se222: TSpinEdit
        Left = 24
        Top = 43
        Width = 41
        Height = 22
        MaxValue = 100
        MinValue = 0
        TabOrder = 1
        Value = 10
        OnChange = seChange
      end
      object se333: TSpinEdit
        Left = 64
        Top = 67
        Width = 41
        Height = 22
        MaxValue = 100
        MinValue = 0
        TabOrder = 2
        Value = 45
        OnChange = seChange
      end
      object se444: TSpinEdit
        Left = 104
        Top = 43
        Width = 41
        Height = 22
        MaxValue = 100
        MinValue = 0
        TabOrder = 3
        Value = 10
        OnChange = seChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 9
      Top = 432
      Width = 169
      Height = 57
      Caption = 'Ориентация бумаги'
      TabOrder = 6
      Visible = False
      object RadioButton1: TRadioButton
        Left = 32
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Книжная'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 32
        Top = 32
        Width = 97
        Height = 17
        Caption = 'Альбомная'
        TabOrder = 1
        OnClick = RadioButton2Click
      end
    end
    object Panel111: TPanel
      Left = 8
      Top = 264
      Width = 169
      Height = 169
      BevelOuter = bvNone
      TabOrder = 7
      Visible = False
      object Panel222: TPanel
        Left = 39
        Top = 9
        Width = 95
        Height = 151
        Color = clGray
        TabOrder = 0
        object Panel333: TPanel
          Left = 8
          Top = 8
          Width = 81
          Height = 113
          Caption = 'График'
          TabOrder = 0
        end
      end
    end
  end
  object Chart1: TChart
    Left = 186
    Top = 0
    Width = 654
    Height = 526
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    PrintProportional = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -13
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      'TChart')
    BottomAxis.DateTimeFormat = 'hh:mm:ss'
    BottomAxis.Title.Caption = 'Время, [чч:мм:сс]'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -13
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsItalic]
    LeftAxis.AxisValuesFormat = '#,##0.#######'
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 1E-9
    LeftAxis.StartPosition = 2
    LeftAxis.EndPosition = 98
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -13
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsItalic]
    Legend.Visible = False
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlack
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 148
    Top = 406
  end
end
