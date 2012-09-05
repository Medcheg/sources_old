object frmMain: TfrmMain
  Left = 210
  Top = 16
  Width = 712
  Height = 743
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 716
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    object Bevel11: TBevel
      Left = 8
      Top = 40
      Width = 233
      Height = 17
      Shape = bsBottomLine
      Style = bsRaised
    end
    object Image1: TImage
      Left = 8
      Top = 216
      Width = 233
      Height = 113
      Center = True
      Transparent = True
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 72
      Width = 233
      Height = 137
      Caption = '   Типы фильтров   '
      ItemIndex = 0
      Items.Strings = (
        'Низкочастоный фильтр'
        'Високочастоный фильтр'
        'Полосовой фильтр'
        'Режекторный фильтр'
        'Фазовый фильтр (корректор)')
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 464
      Width = 249
      Height = 241
      Caption = '   Входные воздействия   '
      TabOrder = 1
      object Label13: TLabel
        Left = 48
        Top = 52
        Width = 13
        Height = 13
        Caption = 'C0'
      end
      object Label14: TLabel
        Left = 48
        Top = 76
        Width = 13
        Height = 13
        Caption = 'C1'
      end
      object Label15: TLabel
        Left = 16
        Top = 216
        Width = 117
        Height = 13
        Caption = 'Время моделиров. [ Т ]'
      end
      object Label16: TLabel
        Left = 220
        Top = 217
        Width = 6
        Height = 13
        Caption = 'c'
      end
      object Label12: TLabel
        Left = 48
        Top = 132
        Width = 7
        Height = 13
        Caption = 'A'
      end
      object Label20: TLabel
        Left = 48
        Top = 156
        Width = 6
        Height = 13
        Caption = 'F'
      end
      object Label21: TLabel
        Left = 48
        Top = 180
        Width = 8
        Height = 13
        Caption = 'Fi'
      end
      object Label22: TLabel
        Left = 146
        Top = 157
        Width = 11
        Height = 13
        Caption = 'гц'
      end
      object Label23: TLabel
        Left = 146
        Top = 181
        Width = 42
        Height = 13
        Caption = 'градусы'
      end
      object Bevel1: TBevel
        Left = 8
        Top = 184
        Width = 233
        Height = 25
        Shape = bsBottomLine
        Style = bsRaised
      end
      object Panel2: TPanel
        Left = 4
        Top = 16
        Width = 241
        Height = 23
        BevelInner = bvLowered
        TabOrder = 0
        object CheckBox1: TCheckBox
          Left = 7
          Top = 4
          Width = 189
          Height = 17
          Caption = 'вкл/выкл   Полином [ C0 + C1*t]'
          TabOrder = 0
        end
      end
      object Edit4: TEdit
        Left = 72
        Top = 48
        Width = 70
        Height = 21
        TabOrder = 1
        Text = '1'
      end
      object Edit5: TEdit
        Left = 72
        Top = 72
        Width = 70
        Height = 21
        TabOrder = 2
        Text = '0'
      end
      object Edit6: TEdit
        Left = 144
        Top = 212
        Width = 70
        Height = 21
        TabOrder = 3
        Text = '1'
      end
      object Panel5: TPanel
        Left = 4
        Top = 104
        Width = 242
        Height = 23
        BevelInner = bvLowered
        TabOrder = 4
        object CheckBox2: TCheckBox
          Left = 4
          Top = 4
          Width = 235
          Height = 17
          Caption = 'вкл/выкл   Синус [ A*sin( F[гц]) + Fi [град] ]'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
      object Edit8: TEdit
        Left = 72
        Top = 128
        Width = 70
        Height = 21
        TabOrder = 5
        Text = '1'
      end
      object Edit9: TEdit
        Left = 72
        Top = 152
        Width = 70
        Height = 21
        TabOrder = 6
        Text = '30'
      end
      object Edit10: TEdit
        Left = 72
        Top = 176
        Width = 70
        Height = 21
        TabOrder = 7
        Text = '0'
      end
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 233
      Height = 41
      Caption = '   Расчет фильтра   '
      Default = True
      ModalResult = 1
      TabOrder = 2
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
        FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00E9E9E9E9E9E9
        E9E9E9E9E9E9E9E9E9E9E9E9E900E9E9E9E9E9E9E9E9E9E9E9E9E9E9001C0000
        E9E9E9E9E9E9E9E9E9E9E9E9001C1C1C0000E9E9E9E9E9E9E9E9E9E9001C1C1C
        1C1C0000E9E9E9E9E9E9E9E9001C1C1C1C1C1C1C0000E9E9E9E9E9E9001C1C1C
        1C1C1C1C1C1C0000E9E9E9E9001C1C1C1C1C1C1C1C1C1C1C00E9E9E9001C1C1C
        1C1C1C1C1C1C1C1C00E9E9E9001C1C1C1C1C1C1C1C1C0000E9E9E9E9001C1C1C
        1C1C1C1C0000E9E9E9E9E9E9001C1C1C1C1C0000E9E9E9E9E9E9E9E9001C1C1C
        0000E9E9E9E9E9E9E9E9E9E9001C0000E9E9E9E9E9E9E9E9E9E9E9E9E900E9E9
        E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9}
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 336
      Width = 241
      Height = 121
      Caption = '   Параметры   '
      TabOrder = 3
      object Label1: TLabel
        Left = 3
        Top = 24
        Width = 143
        Height = 13
        Caption = 'Период дискретизации [T   ]'
      end
      object Label2: TLabel
        Left = 137
        Top = 26
        Width = 6
        Height = 13
        Caption = 'o'
      end
      object Label3: TLabel
        Left = 8
        Top = 72
        Width = 138
        Height = 13
        Caption = 'Частота среза   [                ]'
      end
      object Label4: TLabel
        Left = 127
        Top = 69
        Width = 10
        Height = 19
        Caption = 'w'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 137
        Top = 77
        Width = 6
        Height = 13
        Caption = 'o'
      end
      object Label10: TLabel
        Left = 228
        Top = 29
        Width = 6
        Height = 13
        Caption = 'c'
      end
      object Label11: TLabel
        Left = 226
        Top = 77
        Width = 11
        Height = 13
        Caption = 'гц'
      end
      object Label6: TLabel
        Left = 26
        Top = 96
        Width = 120
        Height = 13
        Caption = 'Ширина провала  [        ]'
      end
      object Label7: TLabel
        Left = 121
        Top = 95
        Width = 21
        Height = 19
        Caption = 'Dw'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Symbol'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 226
        Top = 101
        Width = 11
        Height = 13
        Caption = 'гц'
      end
      object Label8: TLabel
        Left = 52
        Top = 48
        Width = 94
        Height = 13
        Caption = 'Амплитуда [Hmax ]'
      end
      object Edit1: TEdit
        Left = 152
        Top = 24
        Width = 70
        Height = 21
        TabOrder = 0
        Text = '0.0001'
      end
      object Edit2: TEdit
        Left = 152
        Top = 72
        Width = 70
        Height = 21
        TabOrder = 1
        Text = '30'
      end
      object Edit3: TEdit
        Left = 152
        Top = 96
        Width = 70
        Height = 21
        TabOrder = 2
        Text = '10'
      end
      object Edit7: TEdit
        Left = 152
        Top = 48
        Width = 70
        Height = 21
        TabOrder = 3
        Text = '1'
      end
    end
  end
  object pBack: TPanel
    Left = 265
    Top = 0
    Width = 439
    Height = 716
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 439
      Height = 321
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object Chart1: TChart
        Left = 2
        Top = 2
        Width = 435
        Height = 317
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.AdjustFrame = False
        Title.Font.Charset = RUSSIAN_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Title.Text.Strings = (
          'Динамика Фильтра')
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 1E-5
        LeftAxis.AxisValuesFormat = '#,##0.############'
        LeftAxis.ExactDateTime = False
        LeftAxis.Increment = 0.01
        Legend.Visible = False
        View3D = False
        Align = alClient
        TabOrder = 0
        object RadioButton1: TRadioButton
          Left = 8
          Top = 8
          Width = 89
          Height = 17
          Caption = 'Вход фильтра'
          TabOrder = 0
          OnClick = RadioButton2Click
        end
        object RadioButton2: TRadioButton
          Left = 104
          Top = 8
          Width = 105
          Height = 17
          Caption = 'Выход фильтра'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = RadioButton2Click
        end
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
        object Series2: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clGreen
          LinePen.Color = clGreen
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
    end
    object Panel4: TPanel
      Left = 0
      Top = 321
      Width = 439
      Height = 395
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
      object Label17: TLabel
        Left = 298
        Top = 37
        Width = 62
        Height = 16
        Caption = 'Частота'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lFreqValue: TLabel
        Left = 304
        Top = 63
        Width = 50
        Height = 13
        Caption = 'lFreqValue'
      end
      object Label18: TLabel
        Left = 302
        Top = 176
        Width = 55
        Height = 24
        Caption = 'ФЧХ :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lFchValue: TLabel
        Left = 315
        Top = 211
        Width = 47
        Height = 13
        Caption = 'lFchValue'
      end
      object lAchValue: TLabel
        Left = 308
        Top = 147
        Width = 48
        Height = 13
        Caption = 'lAchValue'
      end
      object Label19: TLabel
        Left = 303
        Top = 112
        Width = 52
        Height = 24
        Caption = 'АЧХ :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Image2: TImage
        Left = 8
        Top = 40
        Width = 289
        Height = 329
        OnMouseMove = Image2MouseMove
      end
      object ControlBar1: TControlBar
        Left = 2
        Top = 2
        Width = 435
        Height = 29
        Align = alTop
        AutoSize = True
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
        object ToolBar1: TToolBar
          Left = 11
          Top = 2
          Width = 343
          Height = 21
          AutoSize = True
          ButtonHeight = 21
          ButtonWidth = 143
          Caption = 'ToolBar1'
          EdgeBorders = []
          Flat = True
          ShowCaptions = True
          TabOrder = 0
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            AutoSize = True
            Caption = ' Параметры отображения '
            Grouped = True
            ImageIndex = 0
            OnClick = ToolButton1Click
          end
          object ToolButton2: TToolButton
            Left = 146
            Top = 0
            AutoSize = True
            Caption = '  Сохранить изображение  '
            Grouped = True
            ImageIndex = 1
            OnClick = ToolButton2Click
          end
        end
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 657
    Top = 329
  end
end
