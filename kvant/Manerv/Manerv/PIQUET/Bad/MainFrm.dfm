object MainForm: TMainForm
  Left = 135
  Top = 292
  Width = 762
  Height = 542
  Caption = 'ПИКЕТ - расчёт ошибок оценок координат и параметров движения '
  Color = clBtnFace
  Constraints.MinHeight = 540
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcrlParams: TPageControl
    Left = 3
    Top = 33
    Width = 306
    Height = 462
    ActivePage = tshtTraek
    Anchors = [akLeft, akTop, akBottom]
    HotTrack = True
    MultiLine = True
    TabOrder = 0
    object tshtRLS: TTabSheet
      Caption = ' РЛС '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object sbxMainPar: TScrollBox
        Left = 0
        Top = 0
        Width = 298
        Height = 434
        HorzScrollBar.Visible = False
        VertScrollBar.Smooth = True
        Align = alClient
        Color = clMenu
        ParentColor = False
        TabOrder = 0
        OnMouseMove = sbxMainParMouseMove
        object Label34: TLabel
          Left = 11
          Top = 13
          Width = 90
          Height = 13
          Caption = 'Число испытаний'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object spbtRefTable: TSpeedButton
          Left = 171
          Top = 9
          Width = 21
          Height = 20
          Flat = True
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            10000300000000020000120B0000120B00000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C041004101F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C04100410041004101F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C04100000F145F145EB2C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CF145041004101F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C04100410F1451F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CF145041004101F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C04100410F1451F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CF145F145000004101F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C04100410041004101F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C041004101F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C041004101F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C041004101F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C}
          OnClick = spbtRefTableClick
        end
        object edtTestAmount: TEdit
          Left = 117
          Top = 9
          Width = 50
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '250'
        end
        object pnlRLS: TPanel
          Left = 1
          Top = 37
          Width = 261
          Height = 239
          BevelOuter = bvNone
          Color = clMenu
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnMouseMove = pnlRLSMouseMove
          object Label33: TLabel
            Left = 11
            Top = 23
            Width = 44
            Height = 13
            Caption = 'Тип РЛС'
          end
          object Label35: TLabel
            Left = 11
            Top = 52
            Width = 89
            Height = 13
            Caption = 'Период обзора, c'
            Color = clMenu
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object Label25: TLabel
            Left = 21
            Top = 261
            Width = 126
            Height = 13
            Caption = 'Дальность действия, км'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 21
            Top = 281
            Width = 98
            Height = 13
            Caption = 'Высота антенны, м'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object sbtnKachkiMatrix: TSpeedButton
            Left = 194
            Top = 201
            Width = 17
            Height = 17
            Caption = '...'
            Enabled = False
            OnClick = sbtnKachkiMatrixClick
          end
          object sbtnVarDiskretMatrix: TSpeedButton
            Left = 127
            Top = 71
            Width = 17
            Height = 17
            Caption = '...'
            Enabled = False
            OnClick = sbtnVarDiskretMatrixClick
          end
          object lblRLSAddOn: TLabel
            Left = 9
            Top = 225
            Width = 95
            Height = 13
            Cursor = crHandPoint
            Caption = 'Дополнительно >>'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblRLSAddOnClick
            OnMouseMove = lblRLSAddOnMouseMove
          end
          object Shape3: TShape
            Left = 218
            Top = 249
            Width = 1
            Height = 131
            Brush.Style = bsClear
          end
          object Shape6: TShape
            Left = 186
            Top = 249
            Width = 33
            Height = 1
            Brush.Style = bsClear
          end
          object shpLow: TShape
            Left = 186
            Top = 380
            Width = 33
            Height = 1
            Brush.Style = bsClear
          end
          object cbRLSType: TComboBox
            Left = 62
            Top = 19
            Width = 124
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = cbRLSTypeChange
            Items.Strings = (
              '2-х координатная'
              '3-х координатная')
          end
          object edtPeriodObzora: TEdit
            Left = 133
            Top = 46
            Width = 51
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '2'
          end
          object GroupBox6: TGroupBox
            Left = 11
            Top = 102
            Width = 248
            Height = 93
            Caption = ' Ошибки съёма:  '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            object Label39: TLabel
              Left = 16
              Top = 24
              Width = 3
              Height = 13
            end
            object lblSigD: TLabel
              Left = 28
              Top = 20
              Width = 67
              Height = 13
              Caption = 'дальности, м'
            end
            object lblSigPel: TLabel
              Left = 28
              Top = 44
              Width = 65
              Height = 13
              Caption = 'азимута, т.д.'
            end
            object lblSigElev: TLabel
              Left = 28
              Top = 68
              Width = 79
              Height = 13
              Caption = 'угла места, т.д.'
            end
            object edtSigD: TEdit
              Left = 123
              Top = 16
              Width = 51
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = '40'
            end
            object edtSigPel: TEdit
              Left = 123
              Top = 39
              Width = 51
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              Text = '4'
            end
            object edtSigElev: TEdit
              Left = 123
              Top = 63
              Width = 51
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              Text = '4'
            end
          end
          object chbxRLSAdvPara: TCheckBox
            Left = 131
            Top = 239
            Width = 60
            Height = 17
            Hint = 'разрешить редактирование'
            Caption = 'редакт.'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = chbxRLSAdvParaClick
          end
          object edtRLS_Range: TEdit
            Left = 154
            Top = 257
            Width = 51
            Height = 21
            AutoSelect = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            Text = '135'
          end
          object edtRLS_H: TEdit
            Left = 154
            Top = 281
            Width = 51
            Height = 21
            AutoSelect = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            Text = '12'
          end
          object gbxBeamWidth: TGroupBox
            Left = 20
            Top = 304
            Width = 191
            Height = 73
            Caption = ' Ширина луча  '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            object Label43: TLabel
              Left = 28
              Top = 22
              Width = 93
              Height = 13
              Caption = 'по углу места, грд'
            end
            object Label44: TLabel
              Left = 28
              Top = 46
              Width = 78
              Height = 13
              Caption = 'по пеленгу, грд'
            end
            object edtRLS_BearElev: TEdit
              Left = 133
              Top = 18
              Width = 51
              Height = 21
              AutoSelect = False
              Color = clBtnFace
              ReadOnly = True
              TabOrder = 0
              Text = '3'
            end
            object edtRLS_BeamBear: TEdit
              Left = 133
              Top = 42
              Width = 51
              Height = 21
              AutoSelect = False
              Color = clBtnFace
              ReadOnly = True
              TabOrder = 1
              Text = '1,2'
            end
          end
          object chkVarDiskretMatrix: TCheckBox
            Left = 34
            Top = 71
            Width = 88
            Height = 17
            Caption = 'Переменный'
            TabOrder = 2
            OnClick = chkVarDiskretMatrixClick
          end
          object chbKachkiMatrix: TCheckBox
            Left = 11
            Top = 202
            Width = 180
            Height = 17
            Caption = 'Ошибки измерения при качках'
            TabOrder = 4
            OnClick = chbKachkiMatrixClick
          end
        end
      end
    end
    object tshtFilterPar: TTabSheet
      Caption = '  Фильтрация  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object sbxFilterPar: TScrollBox
        Left = 0
        Top = 0
        Width = 298
        Height = 434
        Align = alClient
        Color = clMenu
        ParentColor = False
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 14
          Width = 78
          Height = 13
          Caption = 'СК фильтрации'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 11
          Top = 39
          Width = 54
          Height = 13
          Caption = 'СК выхода'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object stxtDubl_cboSKF: TStaticText
          Left = 97
          Top = 12
          Width = 103
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          Caption = 'Декартовая'
          TabOrder = 4
        end
        object stxtDubl_cmbxSKPVI: TStaticText
          Left = 97
          Top = 37
          Width = 103
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          Caption = 'Сферическая'
          TabOrder = 5
        end
        object cmbxSKPVI: TComboBox
          Left = 96
          Top = 35
          Width = 106
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = cmbxSKPVIChange
          Items.Strings = (
            'Декартовая'
            'Сферическая')
        end
        object cmbxSKF: TComboBox
          Left = 97
          Top = 10
          Width = 105
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cmbxSKFChange
          Items.Strings = (
            'Сферическая'
            'Декартовая')
        end
        object GroupBox1: TGroupBox
          Left = 7
          Top = 76
          Width = 276
          Height = 320
          Caption = ' Фильтр                                   '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object pnlBayes: TPanel
            Left = 8
            Top = 25
            Width = 262
            Height = 290
            BevelOuter = bvNone
            Color = clMenu
            TabOrder = 1
            object Bevel1: TBevel
              Left = 5
              Top = 47
              Width = 250
              Height = 153
              Shape = bsFrame
            end
            object Label3: TLabel
              Left = 12
              Top = 67
              Width = 171
              Height = 13
              Caption = 'Матрица условных вероятностей:'
            end
            object Label4: TLabel
              Left = 16
              Top = 149
              Width = 127
              Height = 13
              Caption = 'Априорные вероятности:'
            end
            object Label5: TLabel
              Left = 6
              Top = 214
              Width = 172
              Height = 13
              Caption = 'Мах ускорение на манёвре, км/c '
            end
            object lblBaesCoef: TLabel
              Left = 6
              Top = 238
              Width = 122
              Height = 26
              Caption = 'Коэф. поправки ошибок'#13#10'экстраполяции'
            end
            object Label6: TLabel
              Left = 176
              Top = 209
              Width = 5
              Height = 11
              Caption = '2'
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'MS Serif'
              Font.Style = []
              ParentFont = False
            end
            object StaticText2: TStaticText
              Left = 23
              Top = 41
              Width = 137
              Height = 13
              AutoSize = False
              Caption = '  Число каналов                   '
              TabOrder = 1
            end
            object edtVer1: TEdit
              Left = 17
              Top = 168
              Width = 49
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              Text = '0,1'
            end
            object edtVer2: TEdit
              Left = 71
              Top = 168
              Width = 49
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Text = '0,7'
            end
            object edtVer3: TEdit
              Left = 125
              Top = 168
              Width = 57
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              Text = '0,15'
            end
            object edtManevrUsckor: TEdit
              Left = 189
              Top = 210
              Width = 49
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              Text = '0,0392'
            end
            object edtExtraCoef: TEdit
              Left = 189
              Top = 241
              Width = 49
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              Text = '0'
            end
            object chbFull: TCheckBox
              Left = 8
              Top = 8
              Width = 113
              Height = 17
              Caption = 'Полный вариант'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnClick = chbFullClick
            end
            object sedtChanlNum: TSpinEdit
              Left = 111
              Top = 35
              Width = 41
              Height = 22
              MaxValue = 3
              MinValue = 2
              TabOrder = 4
              Value = 2
              OnChange = sedtChanlNumChange
            end
          end
          object pnlKalman: TPanel
            Left = 8
            Top = 25
            Width = 260
            Height = 293
            BevelOuter = bvNone
            Color = clMenu
            TabOrder = 0
            object pnlRazdFltr: TPanel
              Left = 3
              Top = 24
              Width = 253
              Height = 253
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Color = clMenu
              TabOrder = 3
              object Label13: TLabel
                Left = 9
                Top = 114
                Width = 37
                Height = 13
                Caption = 'Логика'
              end
              object Label14: TLabel
                Left = 9
                Top = 141
                Width = 59
                Height = 13
                Caption = 'Матрица Ку'
                Enabled = False
              end
              object TLabel
                Left = 12
                Top = 87
                Width = 129
                Height = 13
                Caption = 'Эффект. память фильтра'
              end
              object rdgrpAdaptObnManevra: TRadioGroup
                Left = 9
                Top = 12
                Width = 231
                Height = 65
                Caption = 'С адапт. обнаружителем маневра и ...'
                TabOrder = 0
              end
              object rdbtnMemReset: TRadioButton
                Left = 15
                Top = 32
                Width = 113
                Height = 17
                Caption = 'сбросом памяти'
                Checked = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                TabStop = True
                OnClick = rdbtnMemResetClick
              end
              object rdbtnKorKu: TRadioButton
                Left = 15
                Top = 51
                Width = 217
                Height = 17
                Caption = 'кор-кой Ку по оценке интенс. манёвра'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
                OnClick = rdbtnKorKuClick
              end
              object cmbxLogikaRazdFltr: TComboBox
                Left = 61
                Top = 110
                Width = 158
                Height = 21
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 13
                ParentFont = False
                TabOrder = 4
                Items.Strings = (
                  '"2 из 2"; прг1=1; прг2=2'
                  '"1 из 1"; прг=3'
                  '"2 из 2"; прг1=2; прг2=2')
              end
              object StringGrid2: TStringGrid
                Left = 9
                Top = 165
                Width = 233
                Height = 65
                ColCount = 20
                DefaultColWidth = 45
                DefaultRowHeight = 20
                Enabled = False
                FixedCols = 0
                ScrollBars = ssHorizontal
                TabOrder = 1
              end
              object edtFiltrMem: TEdit
                Left = 150
                Top = 83
                Width = 56
                Height = 21
                TabOrder = 5
                Text = '8'
              end
            end
            object pnlOdnovrFltr: TPanel
              Left = 3
              Top = 24
              Width = 253
              Height = 252
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Color = clMenu
              TabOrder = 2
              object GroupBox2: TGroupBox
                Left = 14
                Top = 31
                Width = 225
                Height = 73
                Caption = ' Эффективная память фильтра '
                TabOrder = 0
                object Label15: TLabel
                  Left = 66
                  Top = 48
                  Width = 65
                  Height = 13
                  Caption = 'при манёвре'
                end
                object Label16: TLabel
                  Left = 28
                  Top = 24
                  Width = 98
                  Height = 13
                  Caption = 'при отсут. манёвра'
                end
                object edtMemAtManevr: TEdit
                  Left = 137
                  Top = 44
                  Width = 57
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Text = '2'
                end
                object edtMemAtNoManevr: TEdit
                  Left = 137
                  Top = 20
                  Width = 57
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  Text = '10'
                end
              end
              object GroupBox3: TGroupBox
                Left = 14
                Top = 124
                Width = 225
                Height = 73
                Caption = ' Пороги '
                TabOrder = 1
                object Label17: TLabel
                  Left = 41
                  Top = 46
                  Width = 38
                  Height = 13
                  Caption = 'нижний'
                end
                object Label18: TLabel
                  Left = 38
                  Top = 22
                  Width = 41
                  Height = 13
                  Caption = 'верхний'
                end
                object edtPorogUp: TEdit
                  Left = 90
                  Top = 19
                  Width = 57
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  Text = '8'
                end
                object edtPorogLow: TEdit
                  Left = 90
                  Top = 43
                  Width = 57
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Text = '8'
                end
              end
            end
            object pnlIStrOsh: TPanel
              Left = 3
              Top = 24
              Width = 253
              Height = 253
              BevelInner = bvRaised
              BevelOuter = bvLowered
              Color = clMenu
              TabOrder = 1
              object Label7: TLabel
                Left = 14
                Top = 59
                Width = 42
                Height = 13
                Caption = 'Gamma1'
              end
              object Label12: TLabel
                Left = 14
                Top = 85
                Width = 42
                Height = 13
                Caption = 'Gamma2'
              end
              object lblLogika: TLabel
                Left = 14
                Top = 136
                Width = 37
                Height = 13
                Caption = 'Логика'
                Visible = False
              end
              object lblPorog1: TLabel
                Left = 14
                Top = 165
                Width = 38
                Height = 13
                Caption = 'порог 1'
                Visible = False
              end
              object lblPorog2: TLabel
                Left = 14
                Top = 192
                Width = 38
                Height = 13
                Caption = 'порог 2'
                Visible = False
              end
              object grpbxPorogi: TGroupBox
                Left = 14
                Top = 128
                Width = 169
                Height = 89
                Caption = ' Пороги  '
                TabOrder = 3
                object Label9: TLabel
                  Left = 15
                  Top = 18
                  Width = 67
                  Height = 13
                  Caption = 'дальность, м'
                end
                object Label10: TLabel
                  Left = 15
                  Top = 42
                  Width = 67
                  Height = 13
                  Caption = 'пеленг, мрад'
                end
                object Label11: TLabel
                  Left = 15
                  Top = 66
                  Width = 88
                  Height = 13
                  Caption = 'угол места, мрад'
                end
                object edtPorogD: TEdit
                  Left = 109
                  Top = 14
                  Width = 51
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  Text = '10'
                end
                object edtPorogPel: TEdit
                  Left = 109
                  Top = 38
                  Width = 51
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  Text = '2'
                end
                object edtPorogElev: TEdit
                  Left = 109
                  Top = 62
                  Width = 51
                  Height = 21
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 2
                  Text = '1'
                end
              end
              object chkOdnovr: TCheckBox
                Left = 14
                Top = 23
                Width = 227
                Height = 17
                Caption = 'Одновременная фильтрация координат'
                Checked = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                State = cbChecked
                TabOrder = 0
                OnClick = chkOdnovrClick
              end
              object edtGamma1: TEdit
                Left = 65
                Top = 55
                Width = 51
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                Text = '0,6'
              end
              object edtGamma2: TEdit
                Left = 65
                Top = 81
                Width = 51
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                Text = '0,6'
              end
              object cmbxLogika: TComboBox
                Left = 65
                Top = 132
                Width = 81
                Height = 21
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 13
                ParentFont = False
                TabOrder = 4
                Visible = False
                OnChange = cmbxLogikaChange
                Items.Strings = (
                  '"1 из 1"'
                  '"2 из 2"')
              end
              object edtPorog1: TEdit
                Left = 65
                Top = 161
                Width = 49
                Height = 21
                TabOrder = 5
                Text = 'x'
                Visible = False
              end
              object edtPorog2: TEdit
                Left = 65
                Top = 188
                Width = 49
                Height = 21
                TabOrder = 6
                Text = 'x'
                Visible = False
              end
            end
            object cmbxKalman: TComboBox
              Left = 13
              Top = 14
              Width = 231
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              TabOrder = 0
              OnChange = cmbxKalmanChange
              Items.Strings = (
                'Искусств старение ошибок измерения'
                'Одновременная фильтрация координат')
            end
          end
        end
        object cmbxFltr: TComboBox
          Left = 64
          Top = 73
          Width = 93
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          OnChange = cmbxFltrChange
          Items.Strings = (
            'Калмана'
            'Байеса')
        end
      end
    end
    object tshtTraek: TTabSheet
      Caption = 'Траектория'
      ImageIndex = 2
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 298
        Height = 434
        Align = alClient
        Color = clMenu
        ParentColor = False
        TabOrder = 0
        object pnlGraphicParams: TPanel
          Left = 8
          Top = 173
          Width = 268
          Height = 226
          BevelOuter = bvNone
          Color = clMenu
          TabOrder = 1
          object Shape4: TShape
            Left = 1
            Top = 8
            Width = 266
            Height = 217
            Brush.Style = bsClear
            Pen.Color = clWhite
          end
          object Shape2: TShape
            Left = 0
            Top = 7
            Width = 266
            Height = 218
            Brush.Style = bsClear
            Pen.Color = 8391051
          end
          object Label8: TLabel
            Left = 16
            Top = 97
            Width = 30
            Height = 13
            Caption = 'Ось X'
          end
          object TLabel
            Left = 15
            Top = 121
            Width = 93
            Height = 13
            Caption = 'Выходные данные'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblMarkerY: TLabel
            Left = 37
            Top = 188
            Width = 94
            Height = 26
            Caption = 'Маркер по оси Y'#13#10'текущего графика'
          end
          object lblMarkerX: TLabel
            Left = 39
            Top = 156
            Width = 76
            Height = 26
            Caption = 'Общий маркер'#13#10'по оси X'
          end
          object shpMarkerXColor: TShape
            Left = 16
            Top = 157
            Width = 15
            Height = 15
            Brush.Color = clAqua
            OnMouseDown = shpMarkerXColorMouseDown
          end
          object shpMarkerYColor: TShape
            Left = 16
            Top = 189
            Width = 15
            Height = 15
            Brush.Color = clLime
            OnMouseDown = shpMarkerYColorMouseDown
          end
          object stxtAxeX: TStaticText
            Left = 119
            Top = 94
            Width = 126
            Height = 19
            AutoSize = False
            BorderStyle = sbsSunken
            Caption = ' Шаг сглаживания'
            TabOrder = 8
            Visible = False
          end
          object cboAxeX: TComboBox
            Left = 118
            Top = 92
            Width = 129
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 4
            OnChange = EditChange
            Items.Strings = (
              'Время'
              'Шаг сглаживания')
          end
          object chkCalcOn1Realiz: TCheckBox
            Left = 16
            Top = 20
            Width = 118
            Height = 17
            Caption = 'Одна реализация'
            TabOrder = 0
            OnClick = chkCalcOn1RealizClick
          end
          object chkSKOv: TCheckBox
            Left = 16
            Top = 41
            Width = 101
            Height = 17
            Caption = 'СКО скорости'
            TabOrder = 1
            OnClick = chkSKOvClick
          end
          object chkSKO_HQ: TCheckBox
            Left = 16
            Top = 65
            Width = 25
            Height = 17
            TabOrder = 2
          end
          object cmbxSKO_HQ: TComboBox
            Left = 33
            Top = 61
            Width = 110
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 3
            OnChange = EditChange
            Items.Strings = (
              'СКО курса'
              'СКО высоты')
          end
          object cmbxVVX: TComboBox
            Left = 118
            Top = 117
            Width = 129
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 5
            OnChange = EditChange
            Items.Strings = (
              'Относительные'
              'Абсолютные')
          end
          object edtX: TEdit
            Left = 138
            Top = 156
            Width = 45
            Height = 21
            TabOrder = 6
            Text = '0'
            OnChange = edtXChange
          end
          object edtY: TEdit
            Left = 138
            Top = 185
            Width = 45
            Height = 21
            TabOrder = 7
            Text = '0'
            OnChange = edtYChange
          end
          object StaticText1: TStaticText
            Left = 101
            Top = 1
            Width = 71
            Height = 17
            Caption = '  Графики  '
            Color = clMenu
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391051
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 9
          end
        end
        object pnlTraek: TPanel
          Left = 4
          Top = 4
          Width = 271
          Height = 162
          BevelOuter = bvNone
          Color = clMenu
          TabOrder = 0
          object Shape5: TShape
            Left = 5
            Top = 9
            Width = 265
            Height = 153
            Brush.Style = bsClear
            Pen.Color = clWhite
          end
          object Shape1: TShape
            Left = 4
            Top = 8
            Width = 265
            Height = 153
            Brush.Style = bsClear
            Pen.Color = clNavy
          end
          object Label32: TLabel
            Left = 17
            Top = 136
            Width = 96
            Height = 13
            Caption = 'Число точек (1..40)'
          end
          object edtTracePointAmount: TEdit
            Left = 123
            Top = 132
            Width = 37
            Height = 21
            TabOrder = 3
            Text = '20'
          end
          object pnlTraekImage: TPanel
            Left = 15
            Top = 50
            Width = 128
            Height = 73
            BevelInner = bvRaised
            BevelOuter = bvNone
            TabOrder = 0
            object imgTraek: TImage
              Tag = 1
              Left = 1
              Top = 1
              Width = 126
              Height = 71
              Cursor = crHandPoint
              Hint = 'Щелкните для вызова каталога или [Ctrl+K]'
              Align = alClient
              AutoSize = True
              ParentShowHint = False
              Picture.Data = {
                07544269746D61702A450000424D2A4500000000000042000000280000007D00
                0000460000000100100003000000E8440000202E0000202E0000000000000000
                0000007C0000E00300001F000000C06242250008000400000000000001040000
                0100010000040000000021040100000000000100000000000000000000000000
                0000000000000000E71C3146AD351042EF3DAD35E71C42080000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000042088C31AD35AD35CE39AD352925
                4208000000000000000000000000000000000000000021040000000000000000
                000000000000000000000000000000000000000000000000000000000000E71C
                8C31292521040000000000000000000000000000000000000000000000000000
                000000000000000000000C57C92D430800004108222981140100000000000000
                0000000020000000000000000100000000000000010001000000000000000000
                00002925524AE71C00000000A5148C31EF3DCE398C31E71C2104000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000E71CCE396B2D210400000000E71C8C31AD356B2D
                E71C210400000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000A5146B2D6B2DA5140000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000783E731595210E1588256367816F604E40080100000001000000
                000000000000000001000000000000000100010000000000210400008C313146
                841000000000000000000000000084106B2DEF3D1042AD35E71C420800000000
                0000000000000000000000000000000000000000000000002104000000000000
                0000000021046B2DEF3DC618000000000000000000000000630C0821AD35AD35
                4A29841000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000630C6B2D8C31C61800000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000965672197321B421B61DF22DB04ACA52C61422040004E018211D40080000
                01000000000001000000000000000000000000000000AD351042841000000000
                0000000000000000000000000000210484108C31AD35CE398C31082142080000
                000000000000000000000000000000000000000000000000000000000000C618
                CE398C312104000000000000000000000000000000000000000084106B2D8C31
                6B2D082184100000000000000000000000000000000000000000000000000000
                000000000000420829258C310821210400000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000001066
                D2215015911D901D521D531D9421D42573210D19674A8173216B402900000000
                010000000000000000000000010042081042EF3D000000000000000000000000
                00000000000000000000000000000000210484102925EF3DEF3D8C31E71C2104
                0000000000000000000000000000000000000000000021044A29EF3DE71C0000
                00000000000000000000000000000000000000000000000000002104A5146B2D
                8C316B2DE71C2104000000000000000000000000000000000000000000000000
                E71C8C3129254208000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000CE7D36325119
                711D701D72217121921D9221B325D425D529323AEE52083A6508000400044025
                C01401000000000083101042AD35000000000000000000000000000000000000
                000000000000000000000000000000000000000084106B2DCE39AD356B2DE71C
                42080000000000000000000000000000A514AD35AD3542080000000000000000
                000000000000000000000000000000000000000000000000000000004208E71C
                6B2D6B2D2925C61800000000000000000000000000000000A5146B2D6B2D8410
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000487D544A5115711D711D
                901D71219121912191219221922172219321B425D529512149256667806FA05A
                200C851071462A25000001000000000000002100200001000000000000000000
                0000000001000000010000000000000000000100000084102925CE39CE396B2D
                E71C21040000000000002925EF3D082100000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000630C
                08218C316B2D0821630C000000000000630C4A298C31C6180000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000E4783256921D721D921D7021711D
                9121912191219221922192219221B325B325F429D72DD431B14AEB528B2DF241
                062180140125600C000001000100010401040000000001000100010001002100
                00000000010000000000000000000000000000000000000084104A298C318C31
                29250821AD358C31420800000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                84104A294A290821C61808214A29E71C00000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000A27CEF6DD3255115921D7121921D711D9121
                91219121922191219125922592258F259125B2259421D72938361536EE142746
                A36F4063A0310000010000040004200020002000000001000100000000040000
                00000000010001000000000000000000000021040000000000008410EF3DB556
                31464A29C6184208000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                42088C311042EF3D6B2D84102104000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000021040000817C8B7D553E5111711D7121911D9121912191219121
                91219125912591259125B2259225B225F329D529B325B429D52DF631543EF056
                4A42650C030020044029C0182004020000040000020000000000010001000000
                000001000000000000000000000000000000000042088C318C31630C2104E71C
                8C31CE396B2DC618420800000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000A5146B2D2925
                42082104A5144A296B2D08218410000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000002104
                A51429250000827C277D75567215711D711D701D912192219221922191219221
                9225922591259221B125D429D329B32991299229B129B321B425B529F5311432
                91256B2566638273C05A80100100200001000000000000000000000001000000
                0100020400000000000000000000E71CCE394A2900000000000000000000630C
                0821AD35AD352925C61842080000000000000000000000000000000000000000
                000000000000000000000000000000000000841029258C31A514000000000000
                00000000630C08216B2D4A29C618420800000000000000000000000000000000
                000000000000000000000000000000000000000000002104C618292508218410
                0000A37CC378316AB3217119911D912191217121922192219221922592259225
                9225B229D42DD531B125B225B125B229B225B329B12D9229B229F42D14321532
                363A934A0F57472543080004A014402960102000010000000000200000000100
                000000000000630C8C31CE398410000000000000000000000000000000000000
                630CE71C6B2DAD356B2DC6184208000000000000000000000000000000000000
                00000000000000000000420829258C31E71C0000000000000000000000000000
                000000002104841008216B2D2925A51421040000000000000000000000000000
                00000000000000000000000000004208C6184A29E71C630C000000000000A47C
                A17CCC7D563E7219721D711D711D9121912191219221922192219221B225D52D
                D32DB1259125B329B225B229B129B225D129B42DB22DB229D22DD32DB329B52D
                D62D363615324F214A46A573406BE13500000000000001000000000001000000
                C618CE394A292104000000000000000000000000000000000000000000000000
                00004208E71C8C318C312925C618420821040000000000000000000000000000
                00002104C6188C31292542080000000000000000000000000000000000000000
                0000000000002104A51429254A29E71C84102104000000000000000000000000
                0000000000004208C61829250821420800000000000000000000C47C807C477D
                774EB31DB425D4219321912191219121912191219121B225D429B32592259225
                B229B2299229B329B225B22DB129B329D329D229D22DD32DD12DD331D12DF231
                F531363A143A55421357AC52A614020400002121001D020420046B2DEF3DA514
                0000000000000000000000000000000000000000000000000000000000000000
                000000004208C6186B2DAD354A29C618420800000000000000000000A5148C31
                4A29630C00000000000000000000000000000000000000000000000000000000
                00000000000000004208C61829254A29E71C420800000000000000000000630C
                E71C2925E71C42080000000000000000000000000000835CA37CC37C116AB321
                91199225B421B425B325B425B3259221B225D329B225912592259225B225B225
                B225B229B229B229B229B229D22DD22DB22DD22DD32DD22DD231D331D32DD331
                D431D331D431F735363AD2316C29095FA16FC15AC7452B252004000001000000
                0000010001000004000020000000010000000100010020000000000001000100
                0100200000004208C6186B2D8C312925A5142104630C29254A29A51400000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000630C08212925E71C841021044208C6182925E71C4208
                000000000000000000000000000000000000413CA37C827CEF7514325011701D
                922192219221B221B325D42DF42DB329B22591259225B225B225B225B225B229
                B229B229B229B229D22DD22DD32DD22DD32DD22DD32DD331D331D331D331D331
                F431F33114363336163E3846B4525263093A4304200080104129801001040000
                0004010001000000000000040000000000000000000400000000000000000000
                0000000000000000210484108C31104210428C31630C00000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000084104A29AD35AD352925630C0000000000000000
                00000000000000000000000000002118C478827C687D754E72197121711D9121
                711D9221B325B329B325B325D429D42DD329B329B225B225B225B225B229B229
                B229B229B229D22DD22DD32DD32DD22DD32DD331D331F331F331F331F331F535
                F331F3311436563E163A1636353A353A71290A42A773606B2142000000002000
                0000000000000100010000000000000000000000000000000000000001000000
                000000002104A5146B2D4A29A51429254A290821C61842080000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000004208C6180821C618A5140821E71CC618630C0000000000000000
                000000000000000000000000635CA27CC37C526AB421511D911D711D9221B325
                B329922171219221B225B225B325D329D42DD42DD32DD329B329B229B229B229
                B229D22DD32DD32DD32DD32DD32DD331D22DD231F331F331F331F331F331353A
                553E343AF335D3311436353A57425542744A335BCE52E6184404000021250121
                200800002000200001000100000000000000200000000100000000000000A514
                8C314A29630C0000000000004208A51429256B2D2925A5144208000000000000
                000000000000000000000000000000000000000000000000000000000000630C
                08212925A5142104000000000000630CA51408210821A5144208000000000000
                00000000000020002134C37C8178CC79363E511991199221B425B325711D9121
                91219221B22592219225B225B225B329D329D42DF42DF431F32DD32DB229B229
                B229D32DD32DD22DD32DD32DD331D331F231F331F2311336363E343A133AD335
                F435133AF339F439123A143615361736373E5442F53D8E312A63A3730063602D
                0000000000040000010001000000000000000000010084106B2D6B2DA5140000
                00000000000000000000000000004208A51408214A294A29C618420800000000
                00000000000000000000000000000000000000000000630C08212925A5142104
                00000000000000000000000000000000630CC618082108218410420800000000
                0000000000108270A27C277D555671159221B325B32592217121922191259121
                9121B225B225B225B225B225B225B229B229D32DD32DF431F431F431F331D32D
                D32DD32DD22DD32DF331D331D231F3311436353E153AD535F43512361436F435
                1336143A123A143E133AF439163E343E564278465746D45651630A3E85100100
                420C412D80140004020000000100620C29258C31C61821040000000000000000
                000000002104000000000000000000004208A51408214A292925A51442080000
                0000000000000000000000000000841008212925A51421040000000000000000
                0000000000000000000000000000000021048410E71C0821A51484100000CD35
                2925C65CA278A27C106EF4299321B325711D711D9221922191219225B2259125
                9225B2259225B225B225B225B229B225B229D229D32DD32DF431F4311536F431
                F331D331D32DD32DF3311436353A1336F335D335F3351336F33114361236133A
                143A133A143A333A333E143E333E333E333A363A363E76425642D2350D3E8673
                C373804E00040000081D4A25A914000000000000000000000000000000000000
                00000000000000000000000000000000000042088410E71C4A292925A5142104
                2104000000008410292508218410000000000000000000000000000000000000
                0000000000000000000000000000000000004208A514C618000028258C2D6C55
                C27C607CCC7D78429119701D912191219121922192219221922592259225B225
                B225B225B225B229B229B229B229B229B229B229B229D32DD32DF43114361536
                14361436353A1536F331F32DF3311236F235F3351436F339F33912361436153A
                153A143A133A343E343E14423642333E3442353E5546764697469652135F2D5B
                49256D2D29294029E02021040000000000000000000000000000000000000000
                00000000000000000000000000000000000000002104A514E71C2925E71CE71C
                29250821630C0000000000000000000000000000000000000000000000002104
                000000002104000000000000210400000000000000000000000000108260A27C
                047D945ED521B32192219225921D72217025B1219221912592259225B225B225
                B225B225B229B229B229B229B229D32DD229D229D22DD32DD32DF4311536363A
                353A15361536F435F335F335F335F335F33514361436133A143A143A143A143A
                343A343E343E343E343E343E343E344234423442344234425746994AB84E984E
                AE35CB56C5734067602D00000000000000000100000000000000000000000000
                00000000000400000000000000000000000000000000C71C8D314A2949292925
                8410410801000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000651A37C82780F72
                16327219B225B225D425B425B22591219221912592259225B225B225B225B229
                B229B229B229B229B229B229D22DD22DD22DD22DF4311536F435D331D331F431
                1436353A353A153A143A1436143613361336143A143A133A133A143A143A143E
                343E343E343E343E343E3442344234425542764A774A764654467646784E9756
                D55A526B4C4AA61403004008622DA01800040000010001000000000000000000
                0000010000000000020000002000A51029250721630C000020048410E71C2825
                E81C841042080000000000000000000000000000000000000000000000000000
                000000000000000000004208000000002208EF358A45A274827C487D554E7115
                722191219221B321B325B329D429B329B325B225B225B225B225B225B225B229
                B229B229B229D22DD22DD22DD22D14361436F431D32DD32DD331F331D22DF331
                F335143A353A353A353E353A343A143A133A133A133A143A343E143E143A343E
                343E343E343E343E34425546974A754A7546544254425442764A544276467846
                974A964A133E2D42C973A373C05A601000000000000000000104000001000000
                000000040104A6182A250821630C00000000000000000100000041088310C618
                08210821A5144208000000000000000000000000000000000000000000000000
                21048410C618C6180000630CF0416C2D20088258A37CC37C736EF42571197121
                7121911D92219225B325B329D329D429D429D329B329B329B329B229B229B229
                B229B229B229D32D1536F431F32DD22DD22DD231F331F331F331F335F335F331
                F331F3351436353A353E55425542353E353E143A133A143A143E143E343E343E
                343E5542764A764A554235425442544256465646554674467446554A5446964E
                B7529752D6563467706B492983100000E01C202940100104000001002004A614
                2A250721640C0000010000000000200000000000000000000000000021048410
                C6180821C61884104208000000000000000000000000000042088410E71CC618
                630C00000000EF3DE82401000000412CC37C8078AB7D76467115722191259221
                72259121912191219225B225B329D329D329D42DD42DD32DD32DD329B229D32D
                F431F431F331D22DD22DD32DF331D231D22DD231F331F331F335F335F335F335
                F335F3351336143A343A353E5542564255423542353E343E343E343E76467646
                5542344255425542554655465546564A5646764A5546554A754E5446764A764A
                754A764A984EB756764AF03DCC56C6776067A0310100A5142925A51024002000
                0000000000000000000000000000200400000100000000000000000000002104
                8410C618C618E71C8410210400000000630CA514E71CA5144208000000000000
                0000AD3121040100200000088364A27CE47C9466B221721D912191217125B11D
                912192259225922592259225B225B329D329D32DD32DD32DF42D15321536F431
                B229D22DD22DD32DD32DD331F331F331F331F331F331F335F335F335F3351336
                1436143A133A133A143A343E353E5542554256427646764656463442343E343E
                343E544254425546554654465446544A744A7446764A754A964A7546764A744A
                754E774EB74EF956B956D75A746FEF5AAD350A2162108031E020200800040000
                0000020001000100010000000000000000000000000000000000000000000000
                2104630CA514E71C08210821E71C841000000000000000000000000000006B29
                CE39CE396B29C614A544C37C8178CC79343E7119702191219225912192259225
                9225B225B225B225B225B225B229B225B229D42DF431F431F32DF431F431F431
                F431D331D32DD32DD331D331D331F335F335F335F335F335F335F3351336F335
                143A143A143A133A133A343E5542764656425542564256465646564655423542
                5542554654425342754A55465546754A534A744A564A954A964A754A764E964E
                954A944A954ED852B856D856F85E3446EF41AA73E37FC15A8014010400000000
                2004000002040000010001000000000000000000000000000000000000002104
                A514E71CE71CC618C618A514630C2104000000000000000000000100420CE61C
                29298C296A39E374817C057D975EB219911D711D922191219225912591259225
                B225B225B225B225B225D329D42DF42DD329B229B229D32DD32DF431F431F435
                1536F435F431F331F331F331F331F331F335F335F33513361336143A143A133A
                143A343A353E56425642343E143A343E55425542554676467646764A75465446
                544275465442554675467646764A744A754A754A754A944E754E954A9652B856
                B956B756B64E964EB652D756F95AD85A5567906BCD39A6100000E01C83318010
                00000000000001000000000000000000000000002104630CC618C61884104208
                000000002104630CA514C618A514841042080000000000000104010000002000
                21046344C37C807CEF7D783A931DB325912592257225912591259125B225B225
                92259225D32DF42DD32DB229B229B229D22DD22DB22DD22DD32DD331F431F435
                1436143615361536F435F331F331F335F335F3351336143613361436343E5542
                5542343E343A343E343E343E343E343E343E344255427646764A764A764A764A
                764A7546554655465546754A754A754A754A754A964EB752B752B752964E964E
                964E965296529652B652B7529752B752F95ED7563242CE5EE77BA16FE03D0100
                0100010020040000000001002204A510E61CC618841020000000000000000100
                02000000010401044308A414A514C5140000000400000000000000000000201C
                A470A27C077D965EB4219221D321B329B225B225B225B22591219125B329D42D
                D32DB229B229B229B229B229D22DD32DD22DD32DD32DD22DD22DD22DD331F331
                F43514361436353A353A143A1436F335F335F335143A353E353E353E343E143A
                143A343E343E343E343E343E343E344255423442544255467646764A964A964A
                964A964A764A754A754A754A964AB74EB752964E964E964E964E964E964E964E
                9652B652B652B752B752B752B756D85AF85EF95E17639473EF5A2A25630C0000
                602D20218210A614C518A514440C000400040000010001000000200000000000
                00000000000001002100430800000004000000000000000401000000834CA37C
                817C0E7616367019B2217221B221D329B329D329D429D429D42DD42DB325B225
                B225B229B229B229B229B229B22DD22DD22DD32DD331D331D331D231D231F331
                F331F3351436153A353A353E353E353E563E353E143A133A133A143A343E343E
                343E343E343E343E3442544254425542554255465542544254467546764A964A
                964E964E964EB752B752B74E764A754A754A964E964E964E964E96529652B652
                B652B752B752B752B652B656D75AD552B752B95AFA5E1A6394523246CA73E47F
                626B212900000000010000000100000000000100200000000000200002000000
                0000000000002000000000000004000000000000010000002018A378A37C2475
                9762921D71259121911D92219221B325D42DD42DD429D429D429D42DD32DB329
                B229B229B229D32DD32DD22DD22DD22DD22DD231D331F331F331F331F331F331
                F331F3311436353A563E553E553E353E353E353E353E343E143A343E343E343E
                343E343E343E34425442544254425442554254465546544654465546764AB752
                B752B752B752B7529752964E964E964E954E964E964E964E9652B652B652B652
                B652B652B756D656D656D656D85AB75AD55AF85A39635C673867576F916F0C42
                C71C0100A014A035A01C00002000000000000000010400000000010000000100
                000000000000AD354A2DE71C841042080100010800004148A37CA27C0F7E3536
                5119912592219221B325D329B325B225B225B225D329D329D32DD42DF431F431
                D32DD32DB229D22DD22DD22DD22DD32DD231D231D331F331F331F331F3351436
                153A153A153AF3351336143A353E5542554255425542353E343E343E343E343E
                343E354254423442544255425546554655467546754A964A964E964E764A754A
                754A964EB752B752B752B752B652964E964E964E964EB6529652B652B652B652
                B656B656D656B856D65AD85AF85E1963185FD95AD95AD85A195F39633963544A
                CE5AE97BA1732042010400002104000400000000010001000000000000000000
                0000C61807214A296B2D8C316B2D2A29E718841CA374827C047DB562D41D701D
                9121B225D329B329B225B225B225B225B225B225B229B229D329D32DD32DF431
                F431F431F431F331D331D32DD32DD331D331F331F331F4351436153A143A1436
                F335133614361336133A143A133A343E55425542554255425542554255423442
                343E344234425442544255467546964A964E964A764A5546554A754A754A754A
                754A754A964EB752B752B752D756D756D756B652B652B652B652B652B656B652
                D756F75AF75EF85EF85ED75AD65AD65AF65ED85EF75ED75A185F5A673A673867
                B57330674B2D85100000612D402D400C00000000000021046410851400000000
                000001000000420CC61C4A256B2D6C29275DA47C8178ED7D7646921DB221B325
                B22591219125B225B225B225B225B229B229B229B229B229B229B229D22DF331
                F431F4311436F435F431F431F331F331143615361436F335F331F33514361336
                1436143A143A143A143A133A143A143A343E353E554256425646564676465646
                554655425546764A964A764A554655465546754A754A754A754A754A754A754A
                754E964E954E964EB652B652B756D756D85AD756B652B652D756D85AF85AF95A
                F75AD656D75AD75AF75ED85ED75AD95EF65EF95EF8621763F95EF95EFB5E1967
                5A6BD75A514AAC73E67B426300210000640C8510230801000000000000000000
                2100000000000000000022046114A170A37CC37CB46E382EB321B22592259225
                B22591259125B225B225B225B229B229B229B229B229D229D22DD22DD32DD32D
                D32DF431F43115361536363A353A1436F435F335F335F335F335F33514361436
                133A143A143A143A143A343E343E343E343E343E343E554255427646774A974E
                974E764A7546554655465546554A754A754A754A754A764A764A964E964E964E
                964E964E964E964E964EB652B652D756F85AF85AF85AF85AD75AB756D556D756
                D85AD65AF85AD85AF65AF75AF75AF75EF65EF862F862F65E1863F86219633863
                5A6B386B596FB47790526C2D620CA0108431E018000000000000000000000000
                000000000000010000002034847C807C8979B752B41DB321B42DB325B429B229
                B225B429B221B225B225B229B229B229B229D22DD22DD22DD32DD32DD22DD22D
                F33114361436F3311436143A153A153A143A143A14361436133613361336143A
                143A143A143A143A343E343E343E343E343E544255427646554655467646764A
                764A764A764A764A754A7546754A754A754A754A754A764A964A964E964E964E
                964E964E964EB652B756D756D856D756D756D75AF85AF85AF85AF85AD75AD75A
                D75AD75AD75AF75EF75EF75EF85EF85EF85EF85EF75E17631863186339671967
                19633A673A673967544EAE56E877E7770000A514420800000000000000000000
                000000000000E6200771827CA27872723636511DB121B221B329B329D32DB22D
                F429D329D329B329B229B229B229B229B22DD32DD22DD22DF331F4311436F331
                F331D331F331F331F335F4351436353A353A353E353E353A343A143A143A143A
                343A343E143A143A343E55425546564675465542554254425442554255467546
                764A964A964E964E964E964E754A754A754A964A964E964E964E954E964EB652
                D756D756D756B756B652B652B652B656B656D756D75AF85AF85EF85EF85EF75A
                D75AF75EF75EF75EF75EF75EF85EF85E1863396739673967396719631863F862
                F86238633A6B396B366B576B00006B2D6B2D4A292925E71CA51442080000420C
                6B254A218324837CA17C2679B76AD425701DB12191259225B225B129B329D32D
                D32DD32DD32DD32DD32DD32DD32DB229D32DF431F435F431D331D32DD331F331
                F331F331F331F335F335F335F335143A343A353E353E353E353E343E343E343E
                343E343E55425542554255423542344254425542554255425546554655465546
                5546754A964E964E964E964E964E964E964E954A964EB652B752D756D756B652
                B652B652B652B652B656B656B656D756D756D756D75AF85AF85EF85EF85E185F
                185FF85EF75EF75E18631963396739671863186318631863186318631963175F
                18631863F95E19630000000042088410C6184A296B2D6B2DAD35514ACE39640C
                01006148C17C8178CC7D984A7019B1259125B2259125B2259229B125B225B229
                D329D32DD32DD431F431F431F535F435D331D32DD32DD32DD331D231F331F331
                F335F335F335F335F335F335F33513361336143A343E353E5542564256425642
                564255423542343E343E34425442554255425546554655465546754675467546
                754A754A754A964A964EB752B752B752D756D756B752964E964E964E9652B652
                B652B652B656B656B656D756D756D756D75AD75AD75AD75AF75AF85E18631963
                39633967396719631863F75E186318631863186318631763F75E186318631863
                18631863000000000000000000000000630C8C31CE39092507256A254B292931
                0675837CA17C737676367119912591219225B321B229B225B225B229B225B225
                B229D32DF431F431F431F431F431F4311436F431F331F331F331F331F331F331
                F335F335F335F3351436143A143A1336143A143A343E56425542554255425542
                5542554256465542554254425442544255465546554655467546754A754A754A
                754A754A964EB752B752B752B752B752B752B752D756B652B652B652B652B652
                B652B656B656D756D756D756D75AD75AD75AD75AD75AF85E185F186319631863
                1963186318633967186318631863176318631863186317631863186319631863
                00000000000000000000E71C8C3108210000010000000000620885108430A47C
                817C067DD66A152692219229B329B2259125B229B225B225B229D329D32DD32D
                D32DD22DB22DD32DD32DF331F331F43515361436143614361436F435F335F335
                F3351436F335F3351436143A353E353E5542343E343A143E343E343E55425542
                564676467646764655465546554655465446754A55465546554A754A964E964E
                B752964E964E754A754A954E964EB652B752D756B756B756B756D756B756B656
                B656B656B656D656D756D75AF75AF85EF85EF85EF85EF75EF75AF75EF85E1863
                186339673967396739671863186318631763F76218631863F75E17630000C618
                420842084A294A29630C210400000000000000040000000001006144C478817C
                AB7DD75AD325932DD329D229D329B329B329B329D329D42DD32DB229B229D32D
                B22DD22DD32DD32DD22DD22DD231F331F3311436143A153A143A143A143A143A
                143A143A353A353E353E343E143A143A343A343E343E343E343E343E34423542
                554255467646764A764A764A764A75467546754A964E964E964E964A754A754A
                764A964E964E964E964E964EB6529652B652B652D756D756D75AD75AD75AD756
                D756D75AF75AF85AF75AF75AF75AD75AF75AF75EF85EF85EF85EF85EF75E1863
                18631863396739673967396719631863196319631863396700006B2DEF3D3146
                10420821A514630C42080000010000000004010001000004815CC47CA27C507E
                98469219B229B225B229D42DF42DF431F42DD32DD229D229D32DB229D22DD32D
                D22DD22DD22DD331D331F331F331D331F331F335F3351436143A353E353E563E
                353E353E143A143A143A143A143A343E343E343E343E343E343E344254425542
                5542544255467546764A964E974E974E964E754A55465546754A754A754A754A
                754A954E964E964E964E964E9652B652B652B652B656D756D75AF85EF85EF85E
                F85EF85AD75AD75AD75AF75AF75AF75EF75EF75EF75EF85E1863186318631863
                186318631863196319673967386739673967186300004A298C31C618630CE71C
                29256B2D8C314A25071DC61884102108000400002104836CE37C037DB47A763E
                72199325B125D42DD429D325D325D329F32DF42DF431D331D331D331D32DD32D
                D22DD32DD331D331F331F331F331F331F331F335143A353A143A143A143A343A
                353E353E553E553E353E343E343A343E343E343E543E333E3442354255425542
                5446564E564A96469646964AD84EF9561A571957F956F956D952D852B74E964A
                754A754E954E954EB64EB64EB64EB652D756D756D75AD75AD756D75AD75AF85A
                F85EF85AF85AF85AF75AF75AF85EF85EF85EF75E176318631863186318631863
                1863186339671863186318631863186300000821210400000000000000000000
                630CA510E71C4A296B2D2A292925E720A518C438E67C047D8879F772573A7221
                D429B325B225B2299129B229B329B329D32DD331F431F331F431F431F431F331
                F331F331D331D331F331F435143A143A143AF335F33513361436143A143A343A
                343E3442353E563E56423642354635463442544254423342544655467642B846
                D94AD856D75ED66ED57AD47ED57EF67EF67E157F167F37773873186B1963195F
                F95AD856D752B752B752B752D756D756D752B652D656D65AD65AD65AD75AF85A
                185BF7621763185F185F185F185FF75EF7621863186319633967396739671863
                1863186318631863186318630000000000000000000000000000000000000000
                00000000000042088410C618E71C4A25074D067D0479A97D18773632721D9125
                B2299129B229B32DB229B229B229B229D22DD32DD32DF331F331F431F435F435
                F43514361436153A143AF335F335F335F335143614361336133A133A143A143E
                343A333A543A553E563E564276465546554655467742B846F856D56E507ACA7D
                A97D687D4779467547718871A971EA752C7E6E7EB07ED37EF47EF47E167F387B
                3973396B3A63195BD752B752B652B656B656D656D656D656D75AD75AD75AD75A
                F85EF862F862F86218631963185F396739671863186318631863186318631863
                18631863186318630000292508210821C6188410420800000000000000000000
                00000000000000000000000042080651687D457D0B7A386B3632931DB229D229
                D325B325B129B22DB329B229B229D22DD22DD22DD22DD22DF331F43514361436
                1436143614361436143A14361436143A143A143A143A133A143A143A343E133E
                133A343E343E3442544256467742B94AD9627476AC7D267DE470A35062404128
                4118410C210C2110421863248428E6342841AA510D664E762D76707E917EB17E
                F37E167B3773196B1963195BF85AD756B756B756D75AD85AD85EF85AF85AF75A
                F75A185F19631967196719631963196318631863186318631863186318631863
                186318630000630CA514C61808214A296B2D4A29E71CC6188514630C21040000
                200000000000A4102A25E81CC448877D867D2D7E396F58369221B225F42DD32D
                F32DD32DB329D32DD32DD32DD32DD32DD32DF331F431F435F431F331F331F335
                F3351436143A143A343A353A353A343A143A143A143A143A343A343A143E3442
                553E553E5642B642D75E327A277D6064203C4220A51CC618A410630842042100
                0100000000000000000000004208A51485186314851CC4306849AA61CA710C7E
                2D7E6F7E907EF57A1777396F3B633A5B1957F652F656D65EF75E186318631863
                F75EF85EF8621863186318631863186318631863186318631863186318631863
                00000000000000000000000042088410C61829254A294A292925E71CC618C618
                6B2D6C2DA41001000000E44CA97DAA7D4D7E186F5542921DB221B22DD229F32D
                F331D32DD32DD32DD32DF331F431F431F431D331D331D331F331F331F335F335
                F335F3351336143A143A343A353E353E353E3542343A543E5642563E563A9646
                955A107EE77400580028200400000100020022004308A410C514C414A4148310
                630C830CA514C614840C21000000000000000000000000044110C42C2649465D
                686DC87DEA7D2D7E717ED47A1773396B5A633A63195FF85AD75AF75AF85E185F
                F75E186318631863186318631863186318631863186318631863186300004208
                00000000000000000000000000000000000000004208E71CAD35AD358C314A2D
                081DE61CA6146410274DEC79CA7D6E7E387B774AB2259125B229D229B129B229
                D32DF431F43114361436F435F431F331F331F431F331F335F331F331F335F335
                F335F33513361336143A143A343A553A56423642563E9746D65E1076E87C2250
                001C000021000004010401000000000000000000000021048410C71C0925E71C
                E71CA514430C42082208200400000100000001000100000000000000420C6224
                E54047656779677DAA7D0E7E727E176F386F5967395F185B185BF75AF75E1863
                18631863186318631863186318631863186318631863186300004A294A292925
                E71C8410630C42080000000000000000C6182925A5140000000041086410A614
                E618E7180921AA4D0B7E2C7E6F7E377FF95AF52D92219229B32DD32DF431F431
                D32DD32DD32DD331F331F435F435F43514361436143614361436133613361336
                13361336143A343E353E133E3436963AD65A317EC67401484224C510C514A514
                6410430C2108000000000000000042088410A514A41062082000000000002208
                630C8410841084108410630C4208210400000000000000000000220063088410
                8318822CA348E3642479477DAB7D2F7EB47A18775A6F5A67395FF85E18631863
                1863186318631863186318631863186318631863000042088410C618E71C2925
                4A294A290821C618E71CAD354A29630C00000000000000000000000000002000
                0000210CC724EC6D6E7E8F7E167F5A6F7642D329B329D32DD32DD22DD22DD22D
                D22DD32DD331D331D331F331F335F43514361436153A143E153A353A3536353A
                353E143A3436773E9656527628714148001C000000000000630C84108410A514
                A514A51484108410C618C6188410210400000000000000000000000000000000
                000021044208630C841084108410630C630C8410A514630C2204000000000000
                0004210C4314813CA358E470257D887D0D7E927A17775B6F5B6B5A673963185F
                185F185FF8661863F85E1863185F18670000000000000000000000000000630C
                0821EF3D4A292925082108212925E71C8410630C420800000000000000000004
                0008621CAB51907AB17E147F9A7B3B635742D429B325D32DD32DD32DF431D32D
                D42DD231D231F231F231F231F231F235F33513363436353A153A153635369646
                D85A717A8A756250001C0000000400042000000000000000000021048410C618
                08218410C618C618A514630C4208210400000000000000000000000000000000
                000000002104630CA514A5148410841084106310420821042100000000000004
                000401000004401061288248C4640675687DCB79507ED67E5A737B6B7B673967
                F862185F17631763F862185F000000000000000000000000630CE71C4A298410
                000000002104630CA514C618E71C09212A252925E71CA5148410620C00040000
                210C8B459172D17E147F787F9C7B1B5B7642F331D329D329D42DD42DF431F531
                F431F431F331F331F331F33514361436F4311436553A764AD76A737E6A75614C
                A32CC510C6108514630C630820000000000021048410A514A514630C21040000
                000000004208630C8410A514A5148410630C420821040000000021044208630C
                8410630C420800000000210421042208420C630C630C630C6208410821040000
                0000000000000000200840208338A360E470467DAA7D4F7ED57A59739B6B7B6B
                3A67195F1863F86200000000000000002104E71C4A29C6182104000000000000
                0000000000000000000000004208630C8410A514C518E71C28256A296B292A25
                0829ED4D157B577F987FBC7F9B7B3A6BF95A764213361332F229D32DD32DF42D
                F42DF5311532363A363A563AB74ED762B3760D7E486982400014000001002200
                2304630C840C8510A61CE71CE71CE71CC618630C210400000000000000000000
                0000000000000000210442084208630CA514A514A514A514A514630C21040000
                0000000000000000000000000000000000042104410862086208421063086304
                2204010000000000000000002114612C824CE46C267D897D0C7E717A37777A6F
                7A677A67000000000000A5144A292925630C0000000000000000000000000000
                000000000000000000000000000000002104A5146B29281DA510A610A614E61C
                AB39925A3877BA7BDB7F9A7F997F7A7F39733A6BF85EB756B752974EB84ED956
                F962186B1873B57E517EEC796869E54461180000210021000000000401040100
                41048310E71CA514630C84108410A514A5148410630C42082104000000000000
                000000000000000042088410A51484104208630C630C8410630C630C42084208
                00000000000000000000000000000000000000000000200421042208220C4310
                430C220C02080100200000000004200C41248244C4640579687DED7D937A157B
                0000A51429252925630C00000000000000000000000000000000000000000000
                00000000000000004208C6182925C61842040000000000000000210400002104
                C61C6B353052F56E367B367F367F367F567F367F147BF47ED27EB17E6F7E2C7A
                EA752455A134611C630C8408A50CA614A618A310640C6308A514C5148410620C
                00000000000000000000000021044208630C8410841084108410630C4208630C
                84108410630C2104000000000000000000000000210442084208630C630C630C
                630C420821042000000000000000000000000000000000000000000000042004
                4104210C4208420021000000000000000104411C6238A2540471677D00004A29
                8410000000000000000000000000000000000000000000000000000000000000
                4208C6182925E71C430C00000000000400000000000000000100000000000000
                2004620CA51C8A3D505E50620D5EED610D660D6AEC65AA550639832021100104
                000400000000000000002108640CE6180821E6200721E8208514440C430C2104
                21040000000000000000000000000000000042088410C618C618A514C6188410
                630C210421040000000000000000000000000000000000000000210442084208
                420C630C630C4208220421040100000000000004000000000000000000000004
                0004200421082208420822042100200000000004411063240000000000000000
                0000000000000000000000000000000000000000000000004208E7202925C614
                4208000000000104000001000000010000000000000000000000000000002204
                850CA61084104208000420042008630C8410640C840CA510A610A510840C4208
                21042104430884108410630C42080100000020046108630C84108410A5148410
                8410630C2104210421044208630C84104208420821040000210442084208630C
                630C630C630C630C420821042104000000000000000000000000000400040104
                21042204420842084208430C4208210020000000000000000004000000000100
                0100000000002004200021002100010400000100000000000000000000000000
                00000000000000000000000000000000630CE71C0821C6184208000000000000
                00000000000000000000000000000000000000002104A514E71CC61884102104
                00000000000000000000000000000000000021044208630C8410E71C2925C618
                08210821A5144208000000000000000000000000000000002104420842088410
                C618C618A514C618A514630C2104000000000000000000000000000000002104
                210442084208630C630C4208630C420821042104000000000000000000000000
                0000000000002104210421044208420842082104210400000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000630C08212925C61821040000000000000000000000000000
                0000000000000000000000004208A514E71CC618630C00000000000000000000
                000000000000000000000000000000002104630CA514A514841042084208630C
                8410A5148410A514A5148410630C21040000000000004208630C841084104208
                21044208630C630C630C84108410630C42082104210400000000000000000000
                00000000000021044208420842084208630C4208420821042104000000000000
                0000000000000000000000002104210421042104210421042104210400000000
                0000000000000000000000000000000000000000000000000000000000000000
                841008210821A514210400000000000000000000000000000000000000000000
                000000008410C618E71CC6184208000000000000000000000000000000000000
                0000000000002104630CA514A5148410630C0000000000000000000000000000
                2104420842084208630CA514C618C618C618E71CA51442080000000000000000
                0000000000002104420842084208630C630C630C630C42084208210400000000
                0000000000000000000000002104420842084208420842082104210421040000
                0000000000000000000000000000000000000000210421042104210421040000
                000000000000000000000000000000000000000000000000630C08210821A514
                00000000000000000000000000000000000000000000000000002104A514E71C
                E71C841021040000000000000000000000000000000000000000000000004208
                8410C618C618630C210400000000000000000000000000000000000000000000
                0000420884108410841042084208630C630C630C84108410630C420842082104
                000000000000000000000000000021044208420842084208630C420842082104
                2104000000000000000000000000000000002104210421042104210421042104
                2104210400000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000841008210821A5142104000000000000
                000000000000000000000000000000000000630CC618E71CA514630C00000000
                000000000000000000000000000000000000000021048410A514A51484104208
                0000000000000000000000000000000000000000000021044208841084108410
                630C2104000000000000000000000000210442084208630C630C630C630C630C
                630C420842080000000000000000000000000000210421044208420842084208
                4208420821042104210400000000000000000000000000000000210421042104
                2104210421042104000000000000000000000000000000000000000000000000
                0000000000000000841008210821A51400000000000000000000000000000000
                00000000000000000000630CE71CE71CA5144208000000000000000000000000
                000000000000000000000000630CA514C618A514420800000000000000000000
                000000000000000000000000000042088410A5148410630C2104000000000000
                0000000000000000000000000000000000000000000000002104210442084208
                630C630C630C630C420842082104000000000000000000000000000021042104
                2104420842084208210421042104000000000000000000000000000000000000
                0000210421042104000000000000000000000000000000000000000000000000
                84100821E71C8410210400000000000000000000000000000000000000000000
                4208A514E71CE71C841021040000000000000000000000000000000000000000
                00004208A514C618A51484102104000000000000000000000000000000000000
                00002104630C8410841084104208210400000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                2104210442084208420842084208420842082104000000000000000000000000
                0000000021042104210421042104210421042104000000000000000000000000
                0000000000000000000000000000000000000000000000000000292508218410
                0000000000000000000000000000000000000000000000000000C6180821C618
                4208000000000000000000000000000000000000000000000000630CC618C618
                841042080000000000000000000000000000000000000000000021048410A514
                8410630C21040000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000021042104420842084208420821042104000000000000
                0000000000000000000000002104210421042104210400000000000000000000
                00000000000000000000000000000000000000000000}
              ShowHint = True
              OnClick = imgTraekClick
            end
            object lblTraelNo: TLabel
              Left = 3
              Top = 3
              Width = 6
              Height = 13
              Caption = '1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clHighlightText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
              Visible = False
            end
          end
          object cboTraek: TComboBox
            Left = 17
            Top = 21
            Width = 216
            Height = 21
            Style = csDropDownList
            DropDownCount = 12
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 1
            OnChange = cboTraekChange
            OnKeyPress = cboTraekKeyPress
            Items.Strings = (
              '1 - ГОРКА'
              '2 - ПОЛОГИЙ СПУСК'
              '3 - ПИКИРОВАНИЕ С ВХ/ВЫХОДОМ'
              '4 - ПРЯМОЛИН. НА H=CONST'
              '5 - ПИКИРОВАНИЕ'
              '6 - ГОРИЗОНТ. ЗМЕЙКА'
              '7 - 1 РАЗВОРОТ НА H=CONST'
              '8 - 2 РАЗВОРОТА НА H=CONST'
              '9 - ПЕТЛЯ В ГОРИЗОНТ. ПЛОСК.'
              '10- НАБОР H ПО ВИНТОВОЙ'
              '11- ПРОСТРАНСТВЕННАЯ ЗМЕЙКА'
              '                             Данные из файла')
          end
          object btnTraekPar: TButton
            Left = 155
            Top = 52
            Width = 76
            Height = 23
            Caption = 'Параметры'
            TabOrder = 2
            OnClick = btnTraekParClick
          end
          object stxtTraeks: TStaticText
            Left = 96
            Top = 1
            Width = 90
            Height = 17
            Caption = '  Траектория  '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
          end
        end
      end
    end
  end
  object cbarButtons: TCoolBar
    Left = 0
    Top = 0
    Width = 754
    Height = 28
    Bands = <
      item
        Control = pnlToolBar
        ImageIndex = -1
        Width = 754
      end>
    EdgeInner = esNone
    EdgeOuter = esNone
    object pnlToolBar: TPanel
      Left = 9
      Top = 0
      Width = 741
      Height = 25
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object sbtnExit: TSpeedButton
        Left = 668
        Top = 1
        Width = 65
        Height = 23
        Anchors = [akRight]
        Caption = 'Выход'
        Flat = True
        Glyph.Data = {
          E6010000424DE60100000000000042000000280000000E0000000F0000000100
          100003000000A4010000120B0000120B00000000000000000000007C0000E003
          00001F000000386B386B386B386B386B386B386B386B386B386B386B00000000
          0000386B734E000000000000000000000000000000008C313967734E0000386B
          0000C618C618F6013D53BF02F601C618C61839679C73734E0000386B0000C618
          C618F6013D53BF02F601C618C61839679C73734E0000386B0000C618C618F601
          BF02BF02F601C618C61839679C73734E0000386B0000C618F601FF6B3D533D53
          BF02F601C6183967734E734E0000386B0000C618F601FF6B3D533D53BF02F601
          C6183967FF7F00000000386B0000C618F601FF6B3D533D53BF02F601C6183967
          9C73734E0000386B0000C618C618BF02FF7FFF6BBF02C618C61839679C73734E
          0000386B0000C618C618C61880498049C618C618C61839679C73734E0000386B
          0000C618C6186C66337F6C668049C618C61839679C73734E0000386B0000C618
          C6186C66F97F337F8049C618C61839679C73734E0000386B0000C618C618C618
          6C666C66C618C618C61839679C73734E0000386B734E00000000000000000000
          0000000000008C319C73734E0000386B386B386B386B386B386B386B386B386B
          386B386B8C318C310000}
        OnClick = sbtnExitClick
      end
      object sbtnCalc: TSpeedButton
        Left = 2
        Top = 1
        Width = 72
        Height = 23
        Hint = 'Запустить на вычисление (F9)'
        Caption = 'Расчёт'
        Flat = True
        Glyph.Data = {
          DA050000424DDA05000000000000360400002800000012000000150000000100
          080000000000A4010000120B0000120B0000000100000000000000000000FFFF
          FF00A7FFFF003A38A8007A78B600C3B8DD00F5D4FE00FFE0FF00FFF0FF00FFF7
          FF00AA76A900BF83A900EAA5A700CC666600D06A6A00DD787800D0717100EC87
          8700D1797900F18D8D00F8939300FC969600FF999900FF9A9A00FE9C9C00FFA0
          9F00EB959500F99F9F00FFA5A400DE909000EE9E9D00F4A2A200F7A8A700FDAC
          AC00FEB0B000FFB5B400F0ACAB00CE969600FFBBBB00D79F9F00FFC1C100FFC6
          C600FBC8C800B9959500F2C6C600E0B8B800D2AEAE00ECC6C600F2D0D0006255
          55008C7A7A00BFADAD00E4D6D600555353006F6D6D00FFFDFD008A898900D070
          6E00F5999600FFAAA800F3B2B000FFCAC800FFCDCC00AA8C8B00E0847F00FEE6
          E500F7BDB900FFD6D000FFF0EE00FFBEB300E9968300FEAB9800F0CDC400FFDE
          D400E7B6A500FDCEBE00FFF8F500CFBDB400EDC7B300FEDAC700C4A58600FFE9
          D300D1700B00D6802200D1924B00FECC9600C1B6AA00B0630600FFD5A400FCC3
          7700FFF4E500FD980200FEA21900FFB13D00FEBA5A00FFDFB300FFF0DB00FFE6
          BF00FFF0C900FEF3D300FFF9D800E0DBBF00FFFEF800FFFEDF00ECECD300FFFF
          E800FFFFF100FFFFFC00ECF2E900029A0300056A05002B2C2B0064656400E4E5
          E4000DA5170014801D0018AF2B001FB83A00355F3D0022A33D0025BB47002BC3
          4E0031C75A0054A86C0088BF9900C6E4CF0039D0690046DE760055ED860063FC
          96005BDB850073DC960046745500435F4C0094CDAD0064EAAA005DDCA00075EE
          C80042454400B1BBB900EFF9F70085919000A0FCF5009BFDFE00A0F2F200A6F9
          F900AEF8F800C2F1F100D8E9E900949B9B004C4E4E00393A3A00B3B5B5007778
          78005B5C5C00F6F7F700BDBEBE008081810087F6F900A5FAFE0070828300A4AF
          B000B0F1FD0095A7AA0003D3FE0017ACD70034D1FD0000ADE200079CCD0067C3
          DE000486B500408EA90061D6FE00CAD2D50005B6F9000C73A2007CD8FF00C1EB
          FF00B3D6EE000194FD00B4C8D9003198FF0053A8FE00E6E7E8000260CF00006E
          FD00488DE900E4F0FF00267DFE00CDE1FF002370EA00488FFF003B7BFE00F6F9
          FF003574FE003470F7002C68FE00376EEC008DAEFC001F5EFF002F64F1000746
          FE00194FF9002D5CE9002E54DB00758FEE00EEF1FC000132FA002045D6004668
          ED00899ADD000129E9005567C2009EA6CB00BFC4DC000120D700162EBF004158
          DE00CBD1F200DFE3FC00C0C1CE00DEDFF3000B0FA100FEFEFE00FCFCFC00F9F9
          F900F4F4F400F2F2F200EEEEEE00ECECEC00EAEAEA00E8E8E800E7E7E700E3E3
          E300E2E2E200DFDFDF00DCDCDC00D9D9D900D6D6D600D3D3D300D0D0D000CECE
          CE00CDCDCD00C9C9C900C5C5C500C2C2C200BABABA00B5B5B500B2B2B200ACAC
          AC00A4A4A4009F9F9F009A9A9A0094949400181818000D0D0D00020202020202
          020E0202020202020202020200000202020202023916140D0202020202020202
          000002020202020214516316140D020202020202000002020202020F633E3E49
          6316140D020202020000020202020215433D31293D496316140D020200000202
          020240632927F2E8422929436316140D000002020202153E2831273F36713628
          2843630D000002020211632625F2E83C27F925F6352628020000020202154B26
          31273F3671363CF9F02610020000020213632325F2E82027F925F63523230202
          0000020214512324F9F036352725F271232102020000021745221626282299F2
          3F03253F2212020200000216602163674B26281E0BB5B5212002020200001745
          210F676767674B26280CD42140020202000017603B556969696969694B261C1C
          020202020000171C1C1140586666666666551C1102020202000002021B191940
          4058010141111B02020202020000020202021B181940405855171A0202020202
          0000020202020202171717400E16020202020202000002020202020202021716
          163A0202020202020000020202020202020202021B020202020202020000}
        ParentShowHint = False
        ShowHint = True
        OnClick = sbtnCalcClick
      end
      object btnSaveGraphs: TSpeedButton
        Left = 304
        Top = 1
        Width = 84
        Height = 23
        AllowAllUp = True
        Caption = 'Сохранить '
        Flat = True
        Glyph.Data = {
          82020000424D8202000000000000420000002800000012000000100000000100
          10000300000040020000120B0000120B00000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1042000000000000000000000000000000000000
          00000000000010421F7C1F7C1F7C1F7C0000007C007C0000FF7F00000000FF7F
          FF7FFF7F0000007C007C00001F7C1F7C1F7C1F7C0000007C007C0000FF7F0000
          0000FF7FFF7FFF7F0000007C007C00001F7C1F7C1F7C1F7C0000007C007C0000
          FF7FFF7FFF7FFF7FFF7FFF7F00000040004000001F7C1F7C1F7C1F7C0000007C
          007C00000000000000000000000000000000000000000000000000001F7C1F7C
          0000007C007C007C00001F001F001F001F001F001F001F001F001F001F000000
          1F7C1F7C0000007C007C007C00001F001F001F001F001F001F00000200020002
          000200001F7C1F7C0000007C007C007C0000FF03FF7FFF03FF7FFF03FF7F0002
          00020002000200001F7C1F7C0000007C007C007C0000FF7FFF03FF7FFF03FF7F
          FF03FF7F00020002000200001F7C1F7C0000007C007C007C0000FF03386BFF03
          FF7FFF03FF7FFF03FF7F0002000200001F7C1F7C0000007C007C007C0000386B
          E07F386BFF03FF7FFF03FF7FFF03FF7F000200001F7C1F7C0000007C007C007C
          0000FF03386BFF03FF7FFF03FF7FFF03FF7FFF03FF7F00001F7C1F7C0000FF7F
          007C007C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001F7C1F7C
          1042000000000000000000000000000000000000000000000000000000000000
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
        OnClick = btnSaveGraphsClick
      end
      object sbtnSettings: TSpeedButton
        Left = 86
        Top = 1
        Width = 94
        Height = 23
        Caption = 'Параметры'
        Flat = True
        Glyph.Data = {
          96030000424D9603000000000000360000002800000010000000120000000100
          18000000000060030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF040CA3040CA300019AFF00FFFF00FFFF
          00FFFF00FFFF00FFC58C70A5450D9B3500C58C70FF00FFFF00FFFF00FF4040B2
          224DF0002FE90012AC4040B2FF00FFFF00FFFF00FFFF00FFAC4F1CEDAF60BE5E
          00A04010FF00FFFF00FFFF00FF4040B2234FFF0033FF0024D24040B2FF00FFFF
          00FFFF00FFFF00FFB25926EDAF60C466009B3500FF00FFFF00FFFF00FF4040B2
          2651FF0033FF002AE44040B2FF00FFFF00FFFF00FFFF00FFB25926EDAF60C466
          009B3500FF00FFFF00FFFF00FF4040B22E57FF0033FF002FE94040B2FF00FFFF
          00FFFF00FFFF00FFB25926EDAF60C466009B3500FF00FFFF00FFFF00FF4040B2
          365EFF0033FF002AEE4040B2FF00FFFF00FFFF00FFFF00FFB25926EDAF60C466
          009B3500FF00FFFF00FFFF00FF4040B23E64FF0033FF002FE94040B2FF00FFFF
          00FFFF00FFFF00FFB25926EDAC58C466009B3500FF00FFFF00FFFF00FF4040B2
          5D7EFF093AFE0026E64040B2FF00FFFF00FFFF00FFFF00FFB25926ECAB55C466
          009B3500FF00FFFF00FFFF00FF4040B22C30B20A15B20007A84040B2FF00FFFF
          00FFFF00FFFF00FFA54919D18336B55300B26640FF00FFFF00FFFF00FFFF00FF
          8A8A8AF2F2F27D7D7DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAD7A61A875
          5BFF00FFFF00FFFF00FFFF00FFFF00FF8A8A8AF2F2F27D7D7DFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF9D9D9D9D9D9DFF00FFFF00FFFF00FFFF00FFFF00FF
          8A8A8AF2F2F27D7D7DFF00FFFF00FFFF00FFFF00FFA9A9A9A9A9A97070707D7D
          7D8A8A8A7D7D7DFF00FFFF00FFFF00FFB9B9B9F8F8F88A8A8AFF00FFFF00FFFF
          00FF7D7D7DC7C7C7A9A9A97D7D7D8A8A8A8181818A8A8A707070FF00FF8A8A8A
          F2F2F2F2F2F2D6D6D68A8A8AFF00FFFF00FF7D7D7DCACACA9D9D9DC8D0D4C8D0
          D4A6A6A68A8A8A7D7D7DFF00FF8A8A8ADEDEDEDEDEDECACACA8A8A8AFF00FFFF
          00FF818181B2B2B2A9A9A9C8D0D4C8D0D4B2B2B2818181818181FF00FF8A8A8A
          8181818181817D7D7D8A8A8AFF00FFFF00FFFF00FF979797A9A9A9C8D0D4C8D0
          D4B2B2B28A8A8AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = sbtnSettingsClick
      end
    end
  end
  object pnlGraphs: TPanel
    Left = 312
    Top = 33
    Width = 440
    Height = 462
    Anchors = [akLeft, akTop, akRight, akBottom]
    FullRepaint = False
    TabOrder = 2
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 497
    Width = 754
    Height = 18
    Panels = <
      item
        Width = 308
      end
      item
        Bevel = pbNone
        Width = 50
      end
      item
        Bevel = pbNone
        Text = '   НИИ "Квант-Радиолокация", 2004.'
        Width = 50
      end>
    SimplePanel = False
    OnResize = StatusBarResize
  end
  object ApplicationEvents1: TApplicationEvents
    OnShortCut = ApplicationEvents1ShortCut
    Left = 527
    Top = 32
  end
  object ActionList1: TActionList
    Left = 521
    object actShowTraekKatalog: TAction
      Caption = 'ShowTraekKatalog'
      ShortCut = 16459
      OnExecute = actShowTraekKatalogExecute
    end
    object actCalc: TAction
      Caption = 'actCalc'
      ShortCut = 120
      OnExecute = sbtnCalcClick
    end
    object actChartEdit: TAction
      Caption = 'actChartEdit'
      OnExecute = actChartEditExecute
    end
  end
  object ppmenuGraphSave: TPopupMenu
    Left = 554
    object N1: TMenuItem
      Caption = 'Текущий график'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'Все графики'
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object GraphSaveSize: TMenuItem
      Caption = 'Размеры'
      OnClick = GraphSaveSizeClick
    end
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen, cdPreventFullOpen, cdAnyColor]
    Left = 555
    Top = 31
  end
  object ppmenuSettings: TPopupMenu
    Left = 585
    object ppmenuSetLoad: TMenuItem
      Bitmap.Data = {
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
      Caption = ' Открыть'
      OnClick = ppmenuSetLoadClick
    end
    object ppmenuSetSave: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000CC0E0000C30E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDD0000000000000DD03300000088030DD03300000088030DD03300000088
        030DD03300000000030DD03333333333330DD03300000000330DD03088888888
        030DD03088888888030DD03088888888030DD03088888888030DD03088888888
        000DD03088888888080DD00000000000000DDDDDDDDDDDDDDDDD}
      Caption = ' Сохранить'
      OnClick = ppmenuSetSaveClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.ini'
    Filter = 'ini-файлы  (*.ini)|*.ini|все файлы|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 648
    Top = 1
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.ini'
    Filter = 'ini-файлы (*.ini)|*.ini|все файлы|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofCreatePrompt, ofNoReadOnlyReturn, ofEnableSizing]
    Left = 618
  end
end
