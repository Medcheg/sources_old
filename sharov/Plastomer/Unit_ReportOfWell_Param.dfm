object frmReportOfWell_Param: TfrmReportOfWell_Param
  Left = 112
  Top = 226
  BorderStyle = bsDialog
  Caption = 'frmReportOfWell_Param'
  ClientHeight = 325
  ClientWidth = 605
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 605
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 3
      Top = 7
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = BitBtn1Click
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
    object BitBtn2: TBitBtn
      Left = 528
      Top = 7
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 605
    Height = 288
    ActivePage = tsh3
    Align = alClient
    MultiLine = True
    TabOrder = 1
    OnChanging = PageControl1Changing
    object tsh1: TTabSheet
      Caption = '1.  Отметки глубины  '
      object Bevel1: TBevel
        Left = 1
        Top = 2
        Width = 594
        Height = 65
        Shape = bsFrame
      end
      object Label1: TLabel
        Left = 286
        Top = 20
        Width = 56
        Height = 13
        Caption = 'Подробней'
      end
      object Label2: TLabel
        Left = 464
        Top = 20
        Width = 38
        Height = 13
        Caption = 'Мельче'
      end
      object Label3: TLabel
        Left = 396
        Top = 20
        Width = 15
        Height = 13
        Caption = '1:1'
        OnDblClick = Label3DblClick
      end
      object Label4: TLabel
        Left = 16
        Top = 24
        Width = 165
        Height = 24
        Caption = 'Масштаб глубины:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 1
        Top = 65
        Width = 594
        Height = 65
        Shape = bsFrame
      end
      object Label5: TLabel
        Left = 16
        Top = 88
        Width = 202
        Height = 24
        Caption = 'Шаг отметок глубины :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 464
        Top = 94
        Width = 11
        Height = 13
        Caption = 'м.'
      end
      object Label69: TLabel
        Left = 480
        Top = 40
        Width = 6
        Height = 13
        Caption = '='
      end
      object Label70: TLabel
        Left = 496
        Top = 40
        Width = 15
        Height = 13
        Caption = '1.0'
      end
      object TrackBar1: TTrackBar
        Left = 328
        Top = 32
        Width = 150
        Height = 29
        Max = 19
        Min = 1
        Orientation = trHorizontal
        Frequency = 1
        Position = 10
        SelEnd = 0
        SelStart = 0
        TabOrder = 0
        ThumbLength = 16
        TickMarks = tmTopLeft
        TickStyle = tsAuto
        OnChange = TrackBar1Change
      end
      object eDepthStep: TEdit
        Left = 336
        Top = 90
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'eDepthStep'
      end
    end
    object tsh2: TTabSheet
      Caption = '2.  Литография  '
      ImageIndex = 1
      object Bevel5: TBevel
        Left = 10
        Top = 2
        Width = 228
        Height = 225
        Shape = bsFrame
      end
      object lbLayer: TListBox
        Left = 16
        Top = 40
        Width = 217
        Height = 177
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbLayerClick
      end
      object ControlBar1: TControlBar
        Left = 16
        Top = 8
        Width = 218
        Height = 29
        AutoSize = True
        TabOrder = 1
        object ToolBar2: TToolBar
          Left = 11
          Top = 2
          Width = 201
          Height = 21
          AutoSize = True
          ButtonHeight = 21
          ButtonWidth = 96
          Caption = 'ToolBar2'
          EdgeBorders = []
          Flat = True
          ShowCaptions = True
          TabOrder = 0
          object tbAddLayer: TToolButton
            Left = 0
            Top = 0
            Hint = 'Добавить литографический слой в конец списка'
            Caption = '       Добавить      '
            Grouped = True
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = tbAddLayerClick
          end
          object ToolButton3: TToolButton
            Left = 96
            Top = 0
            Width = 8
            Caption = 'ToolButton3'
            ImageIndex = 2
            Style = tbsSeparator
          end
          object tbDeleteLayer: TToolButton
            Left = 104
            Top = 0
            Hint = 'Удалить выделенный елемент (слой) из списка'
            Caption = 'Удалить'
            Enabled = False
            Grouped = True
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = tbDeleteLayerClick
          end
        end
      end
      object pLithographyLayer: TPanel
        Left = 248
        Top = 8
        Width = 345
        Height = 217
        BevelInner = bvLowered
        TabOrder = 2
        Visible = False
        object Label13: TLabel
          Left = 96
          Top = 16
          Width = 49
          Height = 13
          Caption = 'Имя слоя'
        end
        object lLayerColor: TLabel
          Left = 48
          Top = 42
          Width = 97
          Height = 13
          Caption = 'Цвет заливки слоя'
        end
        object Label14: TLabel
          Left = 43
          Top = 66
          Width = 102
          Height = 13
          Caption = 'Стиль заливки слоя'
        end
        object Label15: TLabel
          Left = 16
          Top = 93
          Width = 145
          Height = 13
          Caption = 'Начальная отметка глубины'
        end
        object Label16: TLabel
          Left = 16
          Top = 141
          Width = 138
          Height = 13
          Caption = 'Конечная отметка глубины'
        end
        object eNameLayer: TEdit
          Left = 152
          Top = 12
          Width = 161
          Height = 21
          TabOrder = 0
          Text = 'eNameLayer'
          OnChange = eNameLayerChange
        end
        object pLayerColor: TPanel
          Left = 152
          Top = 38
          Width = 161
          Height = 21
          BevelInner = bvLowered
          Color = clBlack
          TabOrder = 1
          OnClick = pLayerColorClick
        end
        object Panel3: TPanel
          Left = 152
          Top = 62
          Width = 161
          Height = 21
          BevelInner = bvLowered
          TabOrder = 2
          object PaintBox1: TPaintBox
            Left = 2
            Top = 2
            Width = 157
            Height = 17
            Align = alClient
            OnClick = PaintBox1Click
            OnPaint = PaintBox1Paint
          end
        end
        object eBeginLayerDepth: TEdit
          Left = 56
          Top = 109
          Width = 121
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = eBeginLayerDepthChange
        end
        object eEndLayerDepth: TEdit
          Left = 56
          Top = 157
          Width = 121
          Height = 21
          TabOrder = 4
          Text = '0'
          OnChange = eBeginLayerDepthChange
        end
        object bApplyLayer: TButton
          Left = 6
          Top = 186
          Width = 331
          Height = 25
          Caption = 'Применить'
          Default = True
          TabOrder = 5
          OnClick = bApplyLayerClick
        end
        object Button1: TButton
          Left = 181
          Top = 108
          Width = 148
          Height = 21
          Hint = 'Привязка к конечной глубине предыдущего слоя'
          Caption = 'Привязка слоя'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 182
          Top = 156
          Width = 147
          Height = 21
          Hint = 'Привязка к начальной глубине предыдущего слоя'
          Caption = 'Привязка слоя'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = Button2Click
        end
      end
    end
    object tsh3: TTabSheet
      Caption = '3.  Дополнительные кривые  '
      ImageIndex = 2
      object Bevel4: TBevel
        Left = 200
        Top = 32
        Width = 154
        Height = 193
        Shape = bsFrame
      end
      object Bevel3: TBevel
        Tag = -1
        Left = 4
        Top = 7
        Width = 177
        Height = 220
        Shape = bsFrame
      end
      object Label9: TLabel
        Tag = -1
        Left = 12
        Top = 13
        Width = 89
        Height = 13
        Caption = 'Перечень кривых'
      end
      object Label10: TLabel
        Left = 208
        Top = 40
        Width = 131
        Height = 13
        Caption = 'Перечень кривых на поле'
      end
      object lbSeries: TListBox
        Tag = -1
        Left = 12
        Top = 30
        Width = 161
        Height = 191
        Columns = 3
        DragMode = dmAutomatic
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbSeriesClick
        OnDragOver = lbSeriesDragOver
      end
      object lbPole1: TListBox
        Left = 209
        Top = 63
        Width = 137
        Height = 153
        ItemHeight = 13
        TabOrder = 1
        OnClick = lbSeriesClick
        OnDragDrop = lbPole1DragDrop
        OnDragOver = lbSeriesDragOver
        OnKeyDown = lbPole1KeyDown
        OnMouseDown = lbPole1MouseDown
        OnMouseMove = lbPole1MouseMove
        OnMouseUp = lbPole1MouseUp
      end
      object ToolBar1: TToolBar
        Tag = -1
        Left = 200
        Top = 0
        Width = 154
        Height = 26
        Align = alNone
        ButtonWidth = 146
        Caption = 'ToolBar1'
        EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
        Flat = True
        Images = ilRecyled
        List = True
        ShowCaptions = True
        TabOrder = 2
        object tbRemoveSeries: TToolButton
          Tag = -1
          Left = 0
          Top = 0
          AutoSize = True
          Caption = 'Удалить кривую с поля'
          Grouped = True
          ImageIndex = 0
          OnClick = tbRemoveSeriesClick
        end
      end
    end
    object tsh4: TTabSheet
      Caption = '4.  Профиль скважены  '
      ImageIndex = 3
      object Label11: TLabel
        Left = 176
        Top = 72
        Width = 46
        Height = 13
        Caption = 'Диаметр'
        Enabled = False
      end
      object Label12: TLabel
        Left = 360
        Top = 72
        Width = 16
        Height = 13
        Caption = 'мм'
        Enabled = False
      end
      object cbNominalDiametr: TCheckBox
        Left = 128
        Top = 24
        Width = 289
        Height = 17
        Caption = 'Вкл./выкл. Отображение номинального диаметра'
        TabOrder = 0
        OnClick = cbNominalDiametrClick
      end
      object eNominalDiametr: TEdit
        Left = 232
        Top = 68
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = '0'
      end
    end
    object tsh5: TTabSheet
      Caption = '5.  Поле дополнительных методов ГИС  '
      ImageIndex = 4
      object Bevel7: TBevel
        Tag = -1
        Left = 3
        Top = 30
        Width = 198
        Height = 196
        Shape = bsFrame
      end
      object Label52: TLabel
        Tag = -1
        Left = 11
        Top = 36
        Width = 89
        Height = 13
        Caption = 'Перечень кривых'
      end
      object Bevel8: TBevel
        Tag = -1
        Left = 204
        Top = 84
        Width = 159
        Height = 142
        Shape = bsFrame
      end
      object Label53: TLabel
        Tag = -1
        Left = 212
        Top = 88
        Width = 103
        Height = 13
        Caption = 'Кривая на поле ГИС'
      end
      object lFileName: TLabel
        Left = 304
        Top = 38
        Width = 120
        Height = 13
        Caption = '----------------------------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Transparent = True
      end
      object Label54: TLabel
        Left = 208
        Top = 36
        Width = 90
        Height = 16
        Caption = 'Имя файла :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bbLoadLasFile: TBitBtn
        Left = 4
        Top = 1
        Width = 197
        Height = 25
        Caption = 'Загрузить "GIS LAS" файл'
        TabOrder = 0
        OnClick = bbLoadLasFileClick
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C000000000000000000000000000000000000000000001F7C1F7C
          1F7C1F7C1F7C0000000000420042004200420042004200420042004200001F7C
          1F7C1F7C1F7C0000E07F00000042004200420042004200420042004200420000
          1F7C1F7C1F7C0000FF7FE07F0000004200420042004200420042004200420042
          00001F7C1F7C0000E07FFF7FE07F000000420042004200420042004200420042
          004200001F7C0000FF7FE07FFF7FE07F00000000000000000000000000000000
          0000000000000000E07FFF7FE07FFF7FE07FFF7FE07FFF7FE07F00001F7C1F7C
          1F7C1F7C1F7C0000FF7FE07FFF7FE07FFF7FE07FFF7FE07FFF7F00001F7C1F7C
          1F7C1F7C1F7C0000E07FFF7FE07F00000000000000000000000000001F7C1F7C
          1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
          000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C0000
          1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
      end
      object lbGISSeries: TListBox
        Tag = -1
        Left = 11
        Top = 53
        Width = 182
        Height = 167
        Columns = 3
        DragMode = dmAutomatic
        ItemHeight = 13
        TabOrder = 1
        OnClick = lbGISSeriesClick
        OnDragOver = lbGISSeriesDragOver
      end
      object lbGISPole: TListBox
        Left = 212
        Top = 104
        Width = 146
        Height = 113
        Columns = 3
        DragMode = dmAutomatic
        ItemHeight = 13
        TabOrder = 2
        OnClick = lbGISSeriesClick
        OnDragDrop = lbGISPoleDragDrop
        OnDragOver = lbGISPoleDragOver
        OnEnter = lbGISPoleEnter
        OnKeyDown = lbGISPoleKeyDown
      end
      object tbGISButton: TToolBar
        Tag = -1
        Left = 207
        Top = 57
        Width = 155
        Height = 26
        Align = alNone
        ButtonWidth = 146
        Caption = 'ToolBar1'
        EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
        Flat = True
        Images = ilRecyled
        List = True
        ShowCaptions = True
        TabOrder = 3
        object tbRemoveGISSeries: TToolButton
          Tag = -1
          Left = 0
          Top = 0
          AutoSize = True
          Caption = 'Удалить кривую с поля'
          Grouped = True
          ImageIndex = 0
          OnClick = tbRemoveGISSeriesClick
        end
      end
      object pGisSeriesParam: TPanel
        Left = 364
        Top = 83
        Width = 228
        Height = 142
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 4
        Visible = False
        object Label55: TLabel
          Left = 37
          Top = 12
          Width = 61
          Height = 13
          Caption = 'Имя кривой'
        end
        object lGisSeriesName: TLabel
          Left = 104
          Top = 8
          Width = 129
          Height = 20
          Caption = 'lGisSeriesName'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label56: TLabel
          Left = 66
          Top = 45
          Width = 64
          Height = 13
          Caption = 'Цвет кривой'
        end
        object Label57: TLabel
          Left = 61
          Top = 78
          Width = 69
          Height = 13
          Caption = 'Стиль кривой'
        end
        object Label58: TLabel
          Left = 12
          Top = 110
          Width = 118
          Height = 13
          Caption = 'Толщина линии кривой'
        end
        object seGisSeriesWidth: TSpinEdit
          Left = 138
          Top = 104
          Width = 70
          Height = 22
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = seseGisSeriesWidthChange
        end
        object panelLineStyle: TPanel
          Left = 138
          Top = 72
          Width = 70
          Height = 25
          TabOrder = 1
          object pbGisSeriesStyle: TPaintBox
            Left = 1
            Top = 1
            Width = 68
            Height = 23
            Align = alClient
            OnClick = pbGisSeriesStyleClick
            OnPaint = pbGisSeriesStylePaint
          end
        end
        object pGisSeriesCOlor: TPanel
          Left = 138
          Top = 41
          Width = 70
          Height = 24
          TabOrder = 2
          OnClick = pGisSeriesCOlorClick
        end
      end
      object bbRemoveGISLasFile: TBitBtn
        Left = 204
        Top = 1
        Width = 197
        Height = 25
        Caption = 'Выгрузить "GIS LAS" файл'
        TabOrder = 5
        OnClick = bbRemoveGISLasFileClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
          3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
          33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
          33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
          333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
          03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
          33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
          0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
          3333333337FFF7F3333333333000003333333333377777333333}
        NumGlyphs = 2
      end
    end
    object tsh6: TTabSheet
      Caption = '6.  Наклонограмма  '
      ImageIndex = 5
      object Label7: TLabel
        Left = 120
        Top = 16
        Width = 175
        Height = 16
        Caption = 'Диаметр "головастика"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 392
        Top = 18
        Width = 16
        Height = 13
        Caption = 'мм'
      end
      object Label30: TLabel
        Left = 329
        Top = 46
        Width = 176
        Height = 13
        Caption = 'Формуляр заливки "головастика"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Image1: TImage
        Left = 287
        Top = 69
        Width = 24
        Height = 24
        Picture.Data = {
          07544269746D617076060000424D760600000000000036040000280000001800
          000018000000010008000000000040020000C40E0000C40E0000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
          0000000000FFFFFFFFFFFFFFFFFF00000000000000000000000000000000FFFF
          FFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFF00000000
          00000000000000000000000000000000FFFFFFFF000000000000000000000000
          0000000000000000FFFFFF000000000000000000000000000000000000000000
          00FFFF00000000000000000000000000000000000000000000FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF000000000000000000000000000000000000000000
          00FFFF00000000000000000000000000000000000000000000FFFFFF00000000
          00000000000000000000000000000000FFFFFFFF000000000000000000000000
          0000000000000000FFFFFFFFFF000000000000000000000000000000000000FF
          FFFFFFFFFFFF00000000000000000000000000000000FFFFFFFFFFFFFFFFFF00
          00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
          FFFF}
        Stretch = True
        Transparent = True
      end
      object Image2: TImage
        Left = 287
        Top = 97
        Width = 24
        Height = 24
        Picture.Data = {
          07544269746D617076060000424D760600000000000036040000280000001800
          000018000000010008000000000040020000C40E0000C40E0000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00000052525252000000FFFFFFFFFFFFFFFFFFFFFFFF000052525252525252
          5252520000FFFFFFFFFFFFFFFFFF00525252525252525252525252525200FFFF
          FFFFFFFFFF005252525252525252525252525252525200FFFFFFFFFF00525252
          52525252525252525252525252525200FFFFFFFF005252525252525252525252
          5252525252525200FFFFFF005252525252525252525252525252525252525252
          00FFFF00525252525252525252525252525252525252525200FF005252525252
          5252525252525252525252525252525252000052525252525252525252525252
          5252525252525252520000525252525252525252525252525252525252525252
          5200005252525252525252525252525252525252525252525200005252525252
          5252525252525252525252525252525252000052525252525252525252525252
          52525252525252525200FF005252525252525252525252525252525252525252
          00FFFF00525252525252525252525252525252525252525200FFFFFF00525252
          52525252525252525252525252525200FFFFFFFF005252525252525252525252
          5252525252525200FFFFFFFFFF005252525252525252525252525252525200FF
          FFFFFFFFFFFF00525252525252525252525252525200FFFFFFFFFFFFFFFFFF00
          00525252525252525252520000FFFFFFFFFFFFFFFFFFFFFFFF00000052525252
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
          FFFF}
        Stretch = True
        Transparent = True
      end
      object Image3: TImage
        Left = 287
        Top = 127
        Width = 24
        Height = 24
        Picture.Data = {
          07544269746D617076060000424D760600000000000036040000280000001800
          000018000000010008000000000040020000C40E0000C40E0000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000A4A4A4A4000000FFFFFFFFFFFFFFFFFFFFFFFF0000A4A4A4A4A4A4A4
          A4A4A40000FFFFFFFFFFFFFFFFFF00A4A4A4A4A4A4A4A4A4A4A4A4A4A400FFFF
          FFFFFFFFFF00A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A400FFFFFFFFFF00A4A4A4
          A4A4A4A4A4A4A4A4A4A4A4A4A4A4A400FFFFFFFF00A4A4A4A4A4A4A4A4A4A4A4
          A4A4A4A4A4A4A400FFFFFF00A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
          00FFFF00A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A400FF00A4A4A4A4A4
          A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A40000A4A4A4A4A4A4A4A4A4A4A4A4A4
          A4A4A4A4A4A4A4A4A40000A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
          A40000A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A40000A4A4A4A4A4
          A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A40000A4A4A4A4A4A4A4A4A4A4A4A4A4
          A4A4A4A4A4A4A4A4A400FF00A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4
          00FFFF00A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A400FFFFFF00A4A4A4
          A4A4A4A4A4A4A4A4A4A4A4A4A4A4A400FFFFFFFF00A4A4A4A4A4A4A4A4A4A4A4
          A4A4A4A4A4A4A400FFFFFFFFFF00A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A400FF
          FFFFFFFFFFFF00A4A4A4A4A4A4A4A4A4A4A4A4A4A400FFFFFFFFFFFFFFFFFF00
          00A4A4A4A4A4A4A4A4A4A40000FFFFFFFFFFFFFFFFFFFFFFFF000000A4A4A4A4
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
          FFFF}
        Stretch = True
        Transparent = True
      end
      object Image4: TImage
        Left = 287
        Top = 160
        Width = 24
        Height = 24
        Picture.Data = {
          07544269746D617076060000424D760600000000000036040000280000001800
          000018000000010008000000000040020000C40E0000C40E0000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00000007070707000000FFFFFFFFFFFFFFFFFFFFFFFF000007070707070707
          0707070000FFFFFFFFFFFFFFFFFF00070707070707070707070707070700FFFF
          FFFFFFFFFF000707070707070707070707070707070700FFFFFFFFFF00070707
          07070707070707070707070707070700FFFFFFFF000707070707070707070707
          0707070707070700FFFFFF000707070707070707070707070707070707070707
          00FFFF00070707070707070707070707070707070707070700FF000707070707
          0707070707070707070707070707070707000007070707070707070707070707
          0707070707070707070000070707070707070707070707070707070707070707
          0700000707070707070707070707070707070707070707070700000707070707
          0707070707070707070707070707070707000007070707070707070707070707
          07070707070707070700FF000707070707070707070707070707070707070707
          00FFFF00070707070707070707070707070707070707070700FFFFFF00070707
          07070707070707070707070707070700FFFFFFFF000707070707070707070707
          0707070707070700FFFFFFFFFF000707070707070707070707070707070700FF
          FFFFFFFFFFFF00070707070707070707070707070700FFFFFFFFFFFFFFFFFF00
          00070707070707070707070000FFFFFFFFFFFFFFFFFFFFFFFF00000007070707
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
          FFFF}
        Stretch = True
        Transparent = True
      end
      object Image5: TImage
        Left = 287
        Top = 192
        Width = 24
        Height = 24
        Picture.Data = {
          07544269746D617076060000424D760600000000000036040000280000001800
          000018000000010008000000000040020000C40E0000C40E0000000100000000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
          E00000400000004020000040400000406000004080000040A0000040C0000040
          E00000600000006020000060400000606000006080000060A0000060C0000060
          E00000800000008020000080400000806000008080000080A0000080C0000080
          E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
          E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
          E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
          E00040000000400020004000400040006000400080004000A0004000C0004000
          E00040200000402020004020400040206000402080004020A0004020C0004020
          E00040400000404020004040400040406000404080004040A0004040C0004040
          E00040600000406020004060400040606000406080004060A0004060C0004060
          E00040800000408020004080400040806000408080004080A0004080C0004080
          E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
          E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
          E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
          E00080000000800020008000400080006000800080008000A0008000C0008000
          E00080200000802020008020400080206000802080008020A0008020C0008020
          E00080400000804020008040400080406000804080008040A0008040C0008040
          E00080600000806020008060400080606000806080008060A0008060C0008060
          E00080800000808020008080400080806000808080008080A0008080C0008080
          E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
          E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
          E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
          E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
          E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
          E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
          E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
          E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
          E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
          E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
          A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00F9F9F9F9F9F9F9F9F9F900000000F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9
          F9000000FFFFFFFF000000F9F9F9F9F9F9F9F9F9F9F9F90000FFFFFFFFFFFFFF
          FFFFFF0000F9F9F9F9F9F9F9F9F900FFFFFFFFFFFFFFFFFFFFFFFFFFFF00F9F9
          F9F9F9F9F900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F9F9F9F9F900FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F9F9F9F900FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF00F9F9F900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          00F9F900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F900FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00F900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          00F9F900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F9F9F900FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F9F9F9F900FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF00F9F9F9F9F900FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00F9
          F9F9F9F9F9F900FFFFFFFFFFFFFFFFFFFFFFFFFFFF00F9F9F9F9F9F9F9F9F900
          00FFFFFFFFFFFFFFFFFFFF0000F9F9F9F9F9F9F9F9F9F9F9F9000000FFFFFFFF
          000000F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F900000000F9F9F9F9F9F9F9F9
          F9F9}
        Stretch = True
        Transparent = True
      end
      object Label31: TLabel
        Left = 327
        Top = 75
        Width = 111
        Height = 13
        Caption = 'Отличная корреляция'
      end
      object Label32: TLabel
        Left = 327
        Top = 103
        Width = 108
        Height = 13
        Caption = 'Хорошая корреляция'
      end
      object Label33: TLabel
        Left = 327
        Top = 133
        Width = 171
        Height = 13
        Caption = 'Удовлетворительная корреляция'
      end
      object Label34: TLabel
        Left = 327
        Top = 166
        Width = 182
        Height = 13
        Caption = 'Неудовлетворительная корреляция'
      end
      object Label35: TLabel
        Left = 327
        Top = 198
        Width = 124
        Height = 13
        Caption = 'Корреляция отсутствует'
      end
      object Label36: TLabel
        Left = 93
        Top = 75
        Width = 11
        Height = 13
        Caption = 'от'
      end
      object Label37: TLabel
        Left = 113
        Top = 46
        Width = 116
        Height = 13
        Caption = 'Зоны ответственности'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Label38: TLabel
        Left = 181
        Top = 75
        Width = 12
        Height = 13
        Caption = 'до'
      end
      object Label39: TLabel
        Left = 263
        Top = 69
        Width = 20
        Height = 24
        Caption = '->'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label40: TLabel
        Left = 93
        Top = 103
        Width = 11
        Height = 13
        Caption = 'от'
      end
      object Label41: TLabel
        Left = 181
        Top = 103
        Width = 12
        Height = 13
        Caption = 'до'
      end
      object Label42: TLabel
        Left = 263
        Top = 97
        Width = 20
        Height = 24
        Caption = '->'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label43: TLabel
        Left = 93
        Top = 133
        Width = 11
        Height = 13
        Caption = 'от'
      end
      object Label44: TLabel
        Left = 181
        Top = 133
        Width = 12
        Height = 13
        Caption = 'до'
      end
      object Label45: TLabel
        Left = 263
        Top = 127
        Width = 20
        Height = 24
        Caption = '->'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label46: TLabel
        Left = 93
        Top = 166
        Width = 11
        Height = 13
        Caption = 'от'
      end
      object Label47: TLabel
        Left = 181
        Top = 166
        Width = 12
        Height = 13
        Caption = 'до'
      end
      object Label48: TLabel
        Left = 263
        Top = 160
        Width = 20
        Height = 24
        Caption = '->'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label49: TLabel
        Left = 93
        Top = 198
        Width = 11
        Height = 13
        Caption = 'от'
      end
      object Label50: TLabel
        Left = 181
        Top = 198
        Width = 12
        Height = 13
        Caption = 'до'
      end
      object Label51: TLabel
        Left = 263
        Top = 192
        Width = 20
        Height = 24
        Caption = '->'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label59: TLabel
        Left = 162
        Top = 75
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label60: TLabel
        Left = 247
        Top = 75
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label61: TLabel
        Left = 162
        Top = 103
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label62: TLabel
        Left = 247
        Top = 103
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label63: TLabel
        Left = 162
        Top = 133
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label64: TLabel
        Left = 247
        Top = 133
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label65: TLabel
        Left = 162
        Top = 166
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label66: TLabel
        Left = 247
        Top = 166
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label67: TLabel
        Left = 162
        Top = 199
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Label68: TLabel
        Left = 247
        Top = 199
        Width = 8
        Height = 13
        Caption = '%'
      end
      object seGolovasticRadius: TSpinEdit
        Left = 304
        Top = 13
        Width = 81
        Height = 22
        MaxValue = 15
        MinValue = 1
        TabOrder = 0
        Value = 4
        OnChange = seGolovasticRadiusChange
      end
      object seMain1: TSpinEdit
        Left = 197
        Top = 70
        Width = 49
        Height = 22
        Enabled = False
        MaxValue = 100
        MinValue = 0
        TabOrder = 1
        Value = 100
      end
      object se1: TSpinEdit
        Left = 111
        Top = 70
        Width = 49
        Height = 22
        MaxValue = 99
        MinValue = 0
        TabOrder = 2
        Value = 90
        OnChange = se1Change
      end
      object se4: TSpinEdit
        Left = 111
        Top = 161
        Width = 49
        Height = 22
        MaxValue = 99
        MinValue = 0
        TabOrder = 3
        Value = 60
        OnChange = se1Change
      end
      object seMain2: TSpinEdit
        Left = 197
        Top = 98
        Width = 49
        Height = 22
        Enabled = False
        MaxValue = 99
        MinValue = 0
        TabOrder = 4
        Value = 90
      end
      object se3: TSpinEdit
        Left = 111
        Top = 128
        Width = 49
        Height = 22
        MaxValue = 99
        MinValue = 0
        TabOrder = 5
        Value = 70
        OnChange = se1Change
      end
      object seMain3: TSpinEdit
        Left = 197
        Top = 128
        Width = 49
        Height = 22
        Enabled = False
        MaxValue = 99
        MinValue = 0
        TabOrder = 6
        Value = 80
      end
      object se2: TSpinEdit
        Left = 111
        Top = 98
        Width = 49
        Height = 22
        MaxValue = 99
        MinValue = 0
        TabOrder = 7
        Value = 80
        OnChange = se1Change
      end
      object seMain4: TSpinEdit
        Left = 197
        Top = 161
        Width = 49
        Height = 22
        Enabled = False
        MaxValue = 99
        MinValue = 0
        TabOrder = 8
        Value = 70
      end
      object se5: TSpinEdit
        Left = 111
        Top = 194
        Width = 49
        Height = 22
        Enabled = False
        MaxValue = 99
        MinValue = 0
        TabOrder = 9
        Value = 0
        OnChange = se1Change
      end
      object seMain5: TSpinEdit
        Left = 197
        Top = 193
        Width = 49
        Height = 22
        Enabled = False
        MaxValue = 99
        MinValue = 0
        TabOrder = 10
        Value = 60
      end
    end
    object tsh7: TTabSheet
      Caption = '7.  Частотная обработка  '
      ImageIndex = 6
      object Bevel6: TBevel
        Left = 10
        Top = 2
        Width = 228
        Height = 225
        Shape = bsFrame
      end
      object lbFreqLayer: TListBox
        Left = 16
        Top = 40
        Width = 217
        Height = 177
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbFreqLayerClick
      end
      object ControlBar2: TControlBar
        Left = 16
        Top = 8
        Width = 218
        Height = 29
        AutoSize = True
        TabOrder = 1
        object ToolBar3: TToolBar
          Left = 11
          Top = 2
          Width = 201
          Height = 21
          AutoSize = True
          ButtonHeight = 21
          ButtonWidth = 96
          Caption = 'ToolBar2'
          EdgeBorders = []
          Flat = True
          ShowCaptions = True
          TabOrder = 0
          object tbAddFreqLayer: TToolButton
            Left = 0
            Top = 0
            Hint = 'Добавить литографический слой в конец списка'
            Caption = '       Добавить      '
            Grouped = True
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = tbAddFreqLayerClick
          end
          object ToolButton6: TToolButton
            Left = 96
            Top = 0
            Width = 8
            Caption = 'ToolButton3'
            ImageIndex = 2
            Style = tbsSeparator
          end
          object tbDeleteFreqLayer: TToolButton
            Left = 104
            Top = 0
            Hint = 'Удалить выделенный елемент (слой) из списка'
            Caption = 'Удалить'
            Enabled = False
            Grouped = True
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = tbDeleteFreqLayerClick
          end
        end
      end
      object pFreqLayer: TPanel
        Left = 248
        Top = 2
        Width = 345
        Height = 225
        BevelInner = bvLowered
        TabOrder = 2
        Visible = False
        object Label20: TLabel
          Left = 16
          Top = 41
          Width = 145
          Height = 13
          Caption = 'Начальная отметка глубины'
        end
        object Label21: TLabel
          Left = 16
          Top = 65
          Width = 138
          Height = 13
          Caption = 'Конечная отметка глубины'
        end
        object Label17: TLabel
          Left = 88
          Top = 112
          Width = 142
          Height = 13
          Caption = 'Вычисление азимута окном'
        end
        object Label18: TLabel
          Left = 236
          Top = 109
          Width = 6
          Height = 13
          Caption = '+'
          Transparent = True
        end
        object Label19: TLabel
          Left = 237
          Top = 114
          Width = 5
          Height = 20
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label22: TLabel
          Left = 299
          Top = 112
          Width = 14
          Height = 13
          Caption = 'гр.'
        end
        object Label23: TLabel
          Left = 184
          Top = 16
          Width = 89
          Height = 13
          Caption = 'Интервал глубин:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object Label24: TLabel
          Left = 32
          Top = 139
          Width = 208
          Height = 13
          Caption = 'Строить статистики по углу наклона    от'
        end
        object Label25: TLabel
          Left = 298
          Top = 139
          Width = 14
          Height = 13
          Caption = 'гр.'
        end
        object Label26: TLabel
          Left = 299
          Top = 164
          Width = 14
          Height = 13
          Caption = 'гр.'
        end
        object Label27: TLabel
          Left = 231
          Top = 164
          Width = 12
          Height = 13
          Caption = 'до'
        end
        object Label28: TLabel
          Left = 299
          Top = 65
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object Label29: TLabel
          Left = 299
          Top = 41
          Width = 8
          Height = 13
          Caption = 'м'
        end
        object eBeginDepthFreqLayer: TEdit
          Left = 176
          Top = 37
          Width = 121
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = FreqLayerChange
        end
        object eEndDepthFreqLayer: TEdit
          Left = 176
          Top = 61
          Width = 121
          Height = 21
          TabOrder = 1
          Text = '0'
          OnChange = FreqLayerChange
        end
        object Button3: TButton
          Left = 6
          Top = 190
          Width = 331
          Height = 25
          Caption = 'Применить'
          Default = True
          TabOrder = 2
          OnClick = Button3Click
        end
        object seAzimWindowFreqLayer: TSpinEdit
          Left = 247
          Top = 109
          Width = 50
          Height = 22
          Color = clSilver
          MaxLength = 90
          MaxValue = 90
          MinValue = 1
          TabOrder = 3
          Value = 1
          OnChange = FreqLayerChange
        end
        object seBeginAlfaFreqlayer: TSpinEdit
          Left = 247
          Top = 134
          Width = 50
          Height = 22
          Color = clSilver
          MaxLength = 90
          MaxValue = 80
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = FreqLayerChange
        end
        object seEndAlfaFreqLayer: TSpinEdit
          Left = 247
          Top = 159
          Width = 50
          Height = 22
          Color = clSilver
          MaxLength = 90
          MaxValue = 90
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = FreqLayerChange
        end
      end
    end
  end
  object ilRecyled: TImageList
    Left = 204
    Top = 281
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007BF7F7007BF7F7007BF7F7007BF7F7007BF7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007BF7F7007BF7F7007BF7F70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007BF7F700FFFFFF00FFFFFF00FFFFFF007BF7F700FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BD7B7B00BD7B7B00BD7B7B007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7000000000000000000000000000000000000000000000000007BF7F700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF007BF7F700FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F700FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007BF7F700000000007BF7F700000000007BF7F700000000007BF7F7000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B00000000007BF7F700000000007BF7F7000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B0000000000BD7B7B00000000007BF7F7000000
      00000000000000000000000000000000000000000000000000007BF7F7007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F7007BF7F7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B00000000007BF7F700000000007BF7F7000000
      000000000000000000000000000000000000000000007BF7F700000000007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF007BF7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B0000000000BD7B7B00000000007BF7F7000000
      0000000000000000000000000000000000000000000000000000FFFFFF007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B00000000007BF7F700000000007BF7F7000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B0000000000BD7B7B00000000007BF7F7000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B00000000007BF7F700000000007BF7F7000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BD7B7B0000000000BD7B7B00000000007BF7F7000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7F700FFFFFF007BF7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F700FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF007BF7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F700FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FE00700000000E00FE54700000000
      E00FE00700000000E00FE00700000000E00FE00700000000E00FE00700000000
      E00FC00500000000A00BA00300000000C007C00700000000E00FE00700000000
      E00FE00300000000C007C00300000000C007C00300000000C007C00700000000
      F83FF81F00000000F83FF83F0000000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Images = ilBrushStyle
    Left = 84
    Top = 281
    object N7: TMenuItem
      Caption = 'Сплошная заливка'
      ImageIndex = 6
      OnClick = miLayerBrushStyleClick
    end
    object N1: TMenuItem
      Tag = 5
      Caption = 'Диагональ влево'
      ImageIndex = 0
      OnClick = miLayerBrushStyleClick
    end
    object N2: TMenuItem
      Tag = 4
      Caption = 'Диагональ вправо'
      ImageIndex = 1
      OnClick = miLayerBrushStyleClick
    end
    object N3: TMenuItem
      Tag = 6
      Caption = 'Перекрестие'
      ImageIndex = 2
      OnClick = miLayerBrushStyleClick
    end
    object N4: TMenuItem
      Tag = 7
      Caption = 'Диагональное перекрестие'
      ImageIndex = 3
      OnClick = miLayerBrushStyleClick
    end
    object N6: TMenuItem
      Tag = 2
      Caption = 'Горизонтальные линии'
      ImageIndex = 4
      OnClick = miLayerBrushStyleClick
    end
    object N5: TMenuItem
      Tag = 3
      Caption = 'Вертикальные линии'
      ImageIndex = 5
      OnClick = miLayerBrushStyleClick
    end
  end
  object ilBrushStyle: TImageList
    Width = 52
    Left = 148
    Top = 281
    Bitmap = {
      494C010107000900040034001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000D0000000300000000100200000000000009C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000D0000000300000000100010000000000400500000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000007FFFFFFFFFFFE7FF7FF7FF7FF67FFFFFFFFFFFE0
      00000000000000007FFFFFFFFFFFE7FF7FF7FF7FF67FFFFFFFFFFFE000000000
      0000000000000000000007FF7FF7FF7FF67FFFFFFFFFFFE00000000000000000
      7FFFFFFFFFFFE7FF7FF7FF7FF67FFFFFFFFFFFE000000000000000007FFFFFFF
      FFFFE7FF7FF7FF7FF67FFFFFFFFFFFE000000000000000007FFFFFFFFFFFE7FF
      7FF7FF7FF67FFFFFFFFFFFE000000000000000007FFFFFFFFFFFE7FF7FF7FF7F
      F67FFFFFFFFFFFE000000000000000007FFFFFFFFFFFE7FF7FF7FF7FF67FFFFF
      FFFFFFE000000000000000007FFFFFFFFFFFE7FF7FF7FF7FF67FFFFFFFFFFFE0
      00000000000000007FFFFFFFFFFFE7FF7FF7FF7FF67FFFFFFFFFFFE000000000
      000000007FFFFFFFFFFFE7FF7FF7FF7FF67FFFFFFFFFFFE00000000000000000
      00000000000007FF7FF7FF7FF67FFFFFFFFFFFE000000000000000007FFFFFFF
      FFFFE7FF7FF7FF7FF67FFFFFFFFFFFE000000000000000007FFFFFFFFFFFE7FF
      7FF7FF7FF67FFFFFFFFFFFE00000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000003FFBFFBFFBFFA5FFDFFDFFDFFC7FF7FF7FF7FF65
      FF5FF5FF5FFC00005FFDFFDFFDFFC3FFBFFBFFBFFA7FF7FF7FF7FF63FFBFFBFF
      BFFA00006FFEFFEFFEFFE7FF7FF7FF7FF600000000000005FF5FF5FF5FF60000
      77FF7FF7FF7FE7FEFFEFFEFFEE7FF7FF7FF7FF66FEEFEEFEEFEE00007BFFBFFB
      FFBFE7FDFFDFFDFFDE7FF7FF7FF7FF677DF7DF7DF7DE00007DFFDFFDFFDFE7FB
      FFBFFBFFBE7FF7FF7FF7FF67BBFBBFBBFBBE00007EFFEFFEFFEFE7F7FF7FF7FF
      7E7FF7FF7FF7FF67D7FD7FD7FD7E00007F7FF7FF7FF7E7EFFEFFEFFEFE7FF7FF
      7FF7FF67EFFEFFEFFEFE00007FBFFBFFBFFBE7DFFDFFDFFDFE7FF7FF7FF7FF67
      D7FD7FD7FD7E00007FDFFDFFDFFDE7BFFBFFBFFBFE7FF7FF7FF7FF67BBFBBFBB
      FBBE00007FEFFEFFEFFEE77FF7FF7FF7FE7FF7FF7FF7FF677DF7DF7DF7DE0000
      7FF7FF7FF7FF66FFEFFEFFEFFE00000000000006FEEFEEFEEFEE00003FFBFFBF
      FBFFA5FFDFFDFFDFFC7FF7FF7FF7FF65FF5FF5FF5FF400005FFDFFDFFDFFC3FF
      BFFBFFBFFA7FF7FF7FF7FF63FFBFFBFFBFFA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 264
    Top = 281
  end
  object ilHolovastic: TImageList
    Height = 33
    Width = 33
    Left = 176
    Top = 281
  end
  object OpenDialog1: TOpenDialog
    Left = 293
    Top = 281
  end
  object pmGisSeriesStyle: TPopupMenu
    AutoPopup = False
    Images = imGisSeriesStyle
    Left = 112
    Top = 281
    object fg1: TMenuItem
      Caption = 'Непрерывная линия'
      ImageIndex = 0
      OnClick = fg1Click
    end
    object MenuItem1: TMenuItem
      Tag = 1
      Caption = 'Пунктирная линия'
      ImageIndex = 1
      OnClick = fg1Click
    end
    object MenuItem2: TMenuItem
      Tag = 2
      Caption = 'Точечная линия'
      ImageIndex = 2
      OnClick = fg1Click
    end
    object MenuItem3: TMenuItem
      Tag = 3
      Caption = 'Линия ( тире - точка )'
      ImageIndex = 3
      OnClick = fg1Click
    end
    object MenuItem4: TMenuItem
      Tag = 4
      Caption = 'Линия ( тире - точка - точка )'
      ImageIndex = 4
      OnClick = fg1Click
    end
  end
  object imGisSeriesStyle: TImageList
    Width = 74
    Left = 232
    Top = 281
    Bitmap = {
      494C01010500090004004A001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000002801000030000000010020000000000000DE
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000FFFF
      FF00DEBDBD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00BD7B7B00BD7B7B00FFFFFF00DEBD
      BD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000FFFFFF00DEBDBD00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00FFFFFF00DEBDBD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000FFFF
      FF00DEBDBD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00BD7B7B00BD7B7B00FFFFFF00DEBD
      BD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000FFFFFF00DEBDBD00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000FFFF
      FF00DEBDBD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00BD7B7B00BD7B7B00FFFFFF00DEBD
      BD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000FFFFFF00DEBDBD00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00DEBDBD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBD
      BD00DEBDBD00DEBDBD00DEBDBD00DEBDBD00DEBDBD007BF7F700000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEBDBD00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F70000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00DEBDBD00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B
      7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B00BD7B7B007BF7F700000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7
      F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F7007BF7F70000000000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AD8C9C00AD8C
      AD00AD8CAD00AD8CAD00A58CAD00A58CAD00A58CBD009C7BAD009C7BCE00947B
      DE008C6BDE00846BDE00737BDE00637BDE00528CDE004A9CEF0039ADFF0039BD
      FF0039BDFF0031ADFF0031BDFF0029ADFF0031ADFF0031ADFF0031BDFF0031BD
      FF0031BDFF0031BDFF0031BDFF0031BDFF0031BDFF0031ADFF0031ADFF0039BD
      FF0039BDFF0039BDFF0042CEFF0052DEFF005AEFFF0063DEFF0063DEFF006BDE
      FF006BEFFF006BDEFF0073DEFF0073EFFF006BEFFF006BEFFF006BEFFF006BEF
      FF006BEFFF006BEFFF006BEFFF006BEFFF006BEFFF006BEFFF006BDEFF006BEF
      FF006BEFFF006BEFFF0073DEFF006BDEFF006BEFFF006BEFFF006BDEFF0073DE
      FF007BDEFF0094DEEF000000100008000000F7CEAD00FFCEAD00FFDEAD00FFDE
      AD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDE
      AD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDE
      AD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00FFDEAD00F7CEAD00F7CE
      AD00F7DE9C00F7DE9C00F7CE9C00F7CE9C00F7CE9C00F7CE9C00F7CE9C00EFCE
      9C00EFCE8C00EFCE8C00E7BD7B00E7BD7B00E7BD7B00DEAD6B00D6AD6B00D6AD
      5A00D69C5A00E7AD7B00F7BD9C00F7AD9C00EFAD9C00EFAD9C00EFAD9C00EF9C
      8C00EF9C8C00E79C8C00E78C8C00E78C8C00E78C8C00E78C7B00E77B7B00DE7B
      7B00DE7B7B00DE7B7B00DE6B7B00DE6B7B00D65A7B00D65A7B00D65A7B00D65A
      7B00D64A6B00CE4A6B00CE4A6B00CE396B00CE396B00CE396B00CE396B00C629
      5A00C6295A00C6295A00C6185A00BD184A00BD184A00BD184A00B5183900B518
      3900AD183900A50818009C08290084D6E70084D6E7009CF71000AD083900ADE7
      2100ADE73100ADD62100B5C63100ADC63100A5C621009CC61000A5C621009CB5
      1000A5B51000A5A510009CA51000A5A521009C9421009C941000948410009484
      10009484100094841000947310008C7300008C7300008C6300008C6300008463
      00008452F7008452F7008452F7008442F7008442F7008442F7007B31F7007B31
      E7007342E7007342D6006B31C6005A31B5003931730021314200101031000800
      1000081000000821100008100000081010000821210010213100183131002131
      310021424200316352004A84630063A5730073C673007BC6730084D6840094F7
      94009C189C009C39AD00A54ABD00945AAD008C5AAD00845AAD007B5AAD007B6B
      AD007B5AAD00735AAD00735AAD007B5AAD00845AAD00845AAD00845AAD00845A
      AD00845AAD00845AAD007B6BAD007B6BAD00846BAD00846BAD00846BBD00846B
      BD00846BBD008C6BBD008C7BCE008C7BCE00947BCE00947BCE00947BDE00947B
      DE009C7BEF009C7BEF009C8CEF00A58CFF00424D3E000000000000003E000000
      2800000028010000300000000100010000000000800700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFC0000000000000
      000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
      FFC0000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFFFFFFFFC000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFFC00000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFC0000000000000
      000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
      FFC0000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFFFFFFFFC000000000000000000000000000000000000000000000
      00000000000000000000F0F0F0000F0F0F000000000000000000000000000000
      000000000000000000000000000000000000F0F0F0000F0F0F00000000000000
      000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
      FFC0000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFFFFFFFFC000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFFC00000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFC0000000000000
      000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
      FFC0000000000000000000000000000000000000000000000000000000000000
      FFFFFFFFFFFFFFFFFFC000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFFC00000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF00000000000000000000000000003F0000FC0003F000F0F0F0F0F0
      F0F0F0F00003C3E0001E1E000000000000000000000000000000003F0000FC00
      03F000F0F0F0F0F0F0F0F0F00003C3E0001E1E0000000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
      000000000000}
  end
end
