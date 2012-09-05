object Form_SpatialWave: TForm_SpatialWave
  Left = 186
  Top = 161
  BorderStyle = bsDialog
  Caption = 'Adaptive DTS - Блок задания пространственной качки'
  ClientHeight = 297
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 3
    Top = 269
    Width = 75
    Height = 25
    Caption = 'Да'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 326
    Top = 269
    Width = 71
    Height = 25
    Caption = 'Отмена'
    Default = True
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 404
    Height = 265
    ActivePage = TabSheet2
    TabOrder = 2
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Килевая качка'
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 396
        Height = 249
        ActivePage = TabSheet6
        Align = alTop
        TabOrder = 0
        object TabSheet6: TTabSheet
          Caption = 'Детерменированная качка'
          object Bevel3: TBevel
            Left = 2
            Top = 94
            Width = 377
            Height = 118
            Shape = bsFrame
            Style = bsRaised
          end
          object Label25: TLabel
            Left = 16
            Top = 120
            Width = 96
            Height = 13
            Caption = 'Первая гармоника'
          end
          object Label26: TLabel
            Left = 16
            Top = 152
            Width = 94
            Height = 13
            Caption = 'Вторая гармоника'
          end
          object Label27: TLabel
            Left = 16
            Top = 184
            Width = 94
            Height = 13
            Caption = 'Третья гармоника'
          end
          object Label28: TLabel
            Left = 128
            Top = 101
            Width = 44
            Height = 16
            Caption = 'A (рад)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label29: TLabel
            Left = 210
            Top = 94
            Width = 13
            Height = 23
            Caption = 'a'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 265
            Top = 99
            Width = 5
            Height = 21
            Caption = 'f'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 321
            Top = 94
            Width = 12
            Height = 23
            Caption = 'j'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Image4: TImage
            Left = 24
            Top = 27
            Width = 337
            Height = 46
          end
          object Label49: TLabel
            Left = 272
            Top = 102
            Width = 24
            Height = 13
            Caption = '- (Гц)'
          end
          object Label50: TLabel
            Left = 336
            Top = 101
            Width = 35
            Height = 13
            Caption = '- (град)'
          end
          object Edit34: TEdit
            Left = 123
            Top = 120
            Width = 57
            Height = 24
            TabOrder = 0
            Text = '0000000000'
          end
          object Edit35: TEdit
            Left = 188
            Top = 120
            Width = 57
            Height = 24
            TabOrder = 1
            Text = '0000000000'
          end
          object Edit36: TEdit
            Left = 251
            Top = 120
            Width = 57
            Height = 24
            TabOrder = 2
            Text = '0000000000'
          end
          object Edit37: TEdit
            Left = 315
            Top = 120
            Width = 57
            Height = 24
            TabOrder = 3
            Text = '0000000000'
          end
          object Edit38: TEdit
            Left = 123
            Top = 152
            Width = 57
            Height = 24
            TabOrder = 4
            Text = '0000000000'
          end
          object Edit39: TEdit
            Left = 188
            Top = 152
            Width = 57
            Height = 24
            TabOrder = 5
            Text = '0000000000'
          end
          object Edit40: TEdit
            Left = 251
            Top = 152
            Width = 57
            Height = 24
            TabOrder = 6
            Text = '0000000000'
          end
          object Edit41: TEdit
            Left = 315
            Top = 152
            Width = 57
            Height = 24
            TabOrder = 7
            Text = '0000000000'
          end
          object Edit42: TEdit
            Left = 123
            Top = 184
            Width = 57
            Height = 24
            TabOrder = 8
            Text = '0000000000'
          end
          object Edit43: TEdit
            Left = 188
            Top = 184
            Width = 57
            Height = 24
            TabOrder = 9
            Text = '0000000000'
          end
          object Edit44: TEdit
            Left = 251
            Top = 184
            Width = 57
            Height = 24
            TabOrder = 10
            Text = '0000000000'
          end
          object Edit45: TEdit
            Left = 315
            Top = 184
            Width = 57
            Height = 24
            TabOrder = 11
            Text = '0000000000'
          end
          object CheckBox4: TCheckBox
            Left = 0
            Top = 0
            Width = 137
            Height = 17
            Caption = 'Включить/Выключить'
            Checked = True
            State = cbChecked
            TabOrder = 12
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'Cлучайная качка'
          ImageIndex = 1
          object Bevel4: TBevel
            Left = 6
            Top = 72
            Width = 377
            Height = 137
            Shape = bsFrame
            Style = bsRaised
          end
          object Label32: TLabel
            Left = 12
            Top = 74
            Width = 11
            Height = 19
            Caption = 'A'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Label33: TLabel
            Left = 12
            Top = 116
            Width = 9
            Height = 19
            Caption = 'm'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Label34: TLabel
            Left = 12
            Top = 161
            Width = 9
            Height = 19
            Caption = 'l'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Image5: TImage
            Left = 24
            Top = 28
            Width = 337
            Height = 33
          end
          object Label35: TLabel
            Left = 28
            Top = 78
            Width = 258
            Height = 13
            Caption = '- дисперсия ординаты волнового провиля   [рад^2]'
          end
          object Label36: TLabel
            Left = 28
            Top = 121
            Width = 288
            Height = 13
            Caption = '- коэффициент затухания кореляционной функции   [1/c]'
          end
          object Label37: TLabel
            Left = 28
            Top = 166
            Width = 107
            Height = 13
            Caption = ' -   частота качки [Гц]'
          end
          object Edit46: TEdit
            Left = 12
            Top = 97
            Width = 365
            Height = 21
            TabOrder = 0
            Text = 'Edit13'
          end
          object Edit47: TEdit
            Left = 12
            Top = 140
            Width = 365
            Height = 21
            TabOrder = 1
            Text = 'Edit14'
          end
          object Edit48: TEdit
            Left = 12
            Top = 183
            Width = 365
            Height = 21
            TabOrder = 2
            Text = 'Edit15'
          end
          object CheckBox5: TCheckBox
            Left = 0
            Top = 0
            Width = 137
            Height = 17
            Caption = 'Включить/Выключить'
            TabOrder = 3
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Импульсное возмучение'
          ImageIndex = 2
          object Label38: TLabel
            Left = 223
            Top = 41
            Width = 44
            Height = 16
            Caption = 'A (рад)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label43: TLabel
            Left = 160
            Top = 68
            Width = 54
            Height = 13
            Caption = 'Импульс 1'
          end
          object Label44: TLabel
            Left = 160
            Top = 88
            Width = 54
            Height = 13
            Caption = 'Импульс 2'
          end
          object Label45: TLabel
            Left = 160
            Top = 108
            Width = 54
            Height = 13
            Caption = 'Импульс 3'
          end
          object Label46: TLabel
            Left = 160
            Top = 129
            Width = 54
            Height = 13
            Caption = 'Импульс 4'
          end
          object Label47: TLabel
            Left = 160
            Top = 149
            Width = 54
            Height = 13
            Caption = 'Импульс 5'
          end
          object Label48: TLabel
            Left = 160
            Top = 170
            Width = 54
            Height = 13
            Caption = 'Импульс 6'
          end
          object Image6: TImage
            Left = 8
            Top = 64
            Width = 129
            Height = 121
          end
          object Label39: TLabel
            Left = 274
            Top = 39
            Width = 35
            Height = 20
            Caption = 'Т  (с)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label41: TLabel
            Left = 283
            Top = 51
            Width = 6
            Height = 13
            Caption = '1'
          end
          object Label40: TLabel
            Left = 322
            Top = 39
            Width = 35
            Height = 20
            Caption = 'Т  (с)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label42: TLabel
            Left = 331
            Top = 51
            Width = 6
            Height = 13
            Caption = '2'
          end
          object Edit49: TEdit
            Left = 224
            Top = 64
            Width = 45
            Height = 21
            TabOrder = 0
            Text = '16'
          end
          object Edit50: TEdit
            Left = 272
            Top = 64
            Width = 45
            Height = 21
            TabOrder = 1
            Text = '17'
          end
          object Edit51: TEdit
            Left = 320
            Top = 64
            Width = 45
            Height = 21
            TabOrder = 2
            Text = '18'
          end
          object Edit52: TEdit
            Left = 224
            Top = 84
            Width = 45
            Height = 21
            TabOrder = 3
            Text = '19'
          end
          object Edit53: TEdit
            Left = 272
            Top = 84
            Width = 45
            Height = 21
            TabOrder = 4
            Text = '20'
          end
          object Edit54: TEdit
            Left = 320
            Top = 84
            Width = 45
            Height = 21
            TabOrder = 5
            Text = '21'
          end
          object Edit55: TEdit
            Left = 224
            Top = 104
            Width = 45
            Height = 21
            TabOrder = 6
            Text = '22'
          end
          object Edit56: TEdit
            Left = 272
            Top = 104
            Width = 45
            Height = 21
            TabOrder = 7
            Text = '23'
          end
          object Edit57: TEdit
            Left = 320
            Top = 104
            Width = 45
            Height = 21
            TabOrder = 8
            Text = '24'
          end
          object Edit58: TEdit
            Left = 224
            Top = 125
            Width = 45
            Height = 21
            TabOrder = 9
            Text = '25'
          end
          object Edit59: TEdit
            Left = 272
            Top = 125
            Width = 45
            Height = 21
            TabOrder = 10
            Text = '26'
          end
          object Edit60: TEdit
            Left = 320
            Top = 125
            Width = 45
            Height = 21
            TabOrder = 11
            Text = '27'
          end
          object Edit61: TEdit
            Left = 224
            Top = 145
            Width = 45
            Height = 21
            TabOrder = 12
            Text = '28'
          end
          object Edit62: TEdit
            Left = 272
            Top = 145
            Width = 45
            Height = 21
            TabOrder = 13
            Text = '29'
          end
          object Edit63: TEdit
            Left = 320
            Top = 145
            Width = 45
            Height = 21
            TabOrder = 14
            Text = '30'
          end
          object Edit64: TEdit
            Left = 224
            Top = 166
            Width = 45
            Height = 21
            TabOrder = 15
            Text = '31'
          end
          object Edit65: TEdit
            Left = 272
            Top = 166
            Width = 45
            Height = 21
            TabOrder = 16
            Text = '32'
          end
          object Edit66: TEdit
            Left = 320
            Top = 166
            Width = 45
            Height = 21
            TabOrder = 17
            Text = '33'
          end
          object CheckBox6: TCheckBox
            Left = 0
            Top = 0
            Width = 137
            Height = 17
            Caption = 'Включить/Выключить'
            TabOrder = 18
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Бортовая качка'
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 396
        Height = 249
        ActivePage = TabSheet3
        Align = alTop
        TabOrder = 0
        object TabSheet3: TTabSheet
          Caption = 'Детерменированная качка'
          object Label1: TLabel
            Left = 16
            Top = 120
            Width = 96
            Height = 13
            Caption = 'Первая гармоника'
          end
          object Label2: TLabel
            Left = 16
            Top = 152
            Width = 94
            Height = 13
            Caption = 'Вторая гармоника'
          end
          object Label3: TLabel
            Left = 16
            Top = 184
            Width = 94
            Height = 13
            Caption = 'Третья гармоника'
          end
          object Label4: TLabel
            Left = 130
            Top = 101
            Width = 44
            Height = 16
            Caption = 'A (рад)'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 210
            Top = 94
            Width = 13
            Height = 23
            Caption = 'a'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Image1: TImage
            Left = 24
            Top = 27
            Width = 337
            Height = 46
          end
          object Label6: TLabel
            Left = 265
            Top = 99
            Width = 5
            Height = 21
            Caption = 'f'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 321
            Top = 94
            Width = 12
            Height = 23
            Caption = 'j'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Label51: TLabel
            Left = 272
            Top = 102
            Width = 24
            Height = 13
            Caption = '- (Гц)'
          end
          object Label52: TLabel
            Left = 336
            Top = 101
            Width = 35
            Height = 13
            Caption = '- (град)'
          end
          object Bevel1: TBevel
            Left = 2
            Top = 94
            Width = 377
            Height = 118
            Shape = bsFrame
            Style = bsRaised
          end
          object Edit1: TEdit
            Left = 123
            Top = 120
            Width = 57
            Height = 21
            TabOrder = 0
            Text = '0000000000'
          end
          object Edit2: TEdit
            Left = 188
            Top = 120
            Width = 57
            Height = 21
            TabOrder = 1
            Text = '0000000000'
          end
          object Edit3: TEdit
            Left = 251
            Top = 120
            Width = 57
            Height = 21
            TabOrder = 2
            Text = '0000000000'
          end
          object Edit4: TEdit
            Left = 315
            Top = 120
            Width = 57
            Height = 21
            TabOrder = 3
            Text = '0000000000'
          end
          object Edit5: TEdit
            Left = 123
            Top = 152
            Width = 57
            Height = 21
            TabOrder = 4
            Text = '0000000000'
          end
          object Edit6: TEdit
            Left = 188
            Top = 152
            Width = 57
            Height = 21
            TabOrder = 5
            Text = '0000000000'
          end
          object Edit7: TEdit
            Left = 251
            Top = 152
            Width = 57
            Height = 21
            TabOrder = 6
            Text = '0000000000'
          end
          object Edit8: TEdit
            Left = 315
            Top = 152
            Width = 57
            Height = 21
            TabOrder = 7
            Text = '0000000000'
          end
          object Edit9: TEdit
            Left = 123
            Top = 184
            Width = 57
            Height = 21
            TabOrder = 8
            Text = '0000000000'
          end
          object Edit10: TEdit
            Left = 188
            Top = 184
            Width = 57
            Height = 21
            TabOrder = 9
            Text = '0000000000'
          end
          object Edit11: TEdit
            Left = 251
            Top = 184
            Width = 57
            Height = 21
            TabOrder = 10
            Text = '0000000000'
          end
          object Edit12: TEdit
            Left = 315
            Top = 184
            Width = 57
            Height = 21
            TabOrder = 11
            Text = '0000000000'
          end
          object CheckBox1: TCheckBox
            Left = 0
            Top = 0
            Width = 137
            Height = 17
            Caption = 'Включить/Выключить'
            Checked = True
            State = cbChecked
            TabOrder = 12
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Cлучайная качка'
          ImageIndex = 1
          object Bevel2: TBevel
            Left = 2
            Top = 82
            Width = 377
            Height = 137
            Shape = bsFrame
            Style = bsRaised
          end
          object Label8: TLabel
            Left = 8
            Top = 84
            Width = 11
            Height = 19
            Caption = 'A'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 8
            Top = 126
            Width = 9
            Height = 19
            Caption = 'm'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 8
            Top = 171
            Width = 9
            Height = 19
            Caption = 'l'
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Image2: TImage
            Left = 24
            Top = 28
            Width = 337
            Height = 33
          end
          object Label22: TLabel
            Left = 24
            Top = 88
            Width = 258
            Height = 13
            Caption = '- дисперсия ординаты волнового провиля   [рад^2]'
          end
          object Label23: TLabel
            Left = 24
            Top = 131
            Width = 288
            Height = 13
            Caption = '- коэффициент затухания кореляционной функции   [1/c]'
          end
          object Label24: TLabel
            Left = 24
            Top = 176
            Width = 107
            Height = 13
            Caption = ' -   частота качки [Гц]'
          end
          object Edit13: TEdit
            Left = 8
            Top = 107
            Width = 365
            Height = 21
            TabOrder = 0
            Text = 'Edit13'
          end
          object Edit14: TEdit
            Left = 8
            Top = 150
            Width = 365
            Height = 21
            TabOrder = 1
            Text = 'Edit14'
          end
          object Edit15: TEdit
            Left = 8
            Top = 193
            Width = 365
            Height = 21
            TabOrder = 2
            Text = 'Edit15'
          end
          object CheckBox2: TCheckBox
            Left = 0
            Top = 0
            Width = 137
            Height = 17
            Caption = 'Включить/Выключить'
            TabOrder = 3
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Импульсное возмучение'
          ImageIndex = 2
          object Label16: TLabel
            Left = 160
            Top = 68
            Width = 54
            Height = 13
            Caption = 'Импульс 1'
          end
          object Label17: TLabel
            Left = 160
            Top = 88
            Width = 54
            Height = 13
            Caption = 'Импульс 2'
          end
          object Label18: TLabel
            Left = 160
            Top = 108
            Width = 54
            Height = 13
            Caption = 'Импульс 3'
          end
          object Label19: TLabel
            Left = 160
            Top = 129
            Width = 54
            Height = 13
            Caption = 'Импульс 4'
          end
          object Label20: TLabel
            Left = 160
            Top = 149
            Width = 54
            Height = 13
            Caption = 'Импульс 5'
          end
          object Label21: TLabel
            Left = 160
            Top = 170
            Width = 54
            Height = 13
            Caption = 'Импульс 6'
          end
          object Image3: TImage
            Left = 8
            Top = 64
            Width = 129
            Height = 121
          end
          object Label11: TLabel
            Left = 223
            Top = 41
            Width = 44
            Height = 16
            Caption = 'A (рад)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 274
            Top = 39
            Width = 35
            Height = 20
            Caption = 'Т  (с)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 283
            Top = 51
            Width = 6
            Height = 13
            Caption = '1'
          end
          object Label14: TLabel
            Left = 322
            Top = 39
            Width = 35
            Height = 20
            Caption = 'Т  (с)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 331
            Top = 51
            Width = 6
            Height = 13
            Caption = '2'
          end
          object Edit16: TEdit
            Left = 224
            Top = 64
            Width = 45
            Height = 21
            TabOrder = 0
            Text = '16'
          end
          object Edit17: TEdit
            Left = 272
            Top = 64
            Width = 45
            Height = 21
            TabOrder = 1
            Text = '17'
          end
          object Edit18: TEdit
            Left = 320
            Top = 64
            Width = 45
            Height = 21
            TabOrder = 2
            Text = '18'
          end
          object Edit19: TEdit
            Left = 224
            Top = 84
            Width = 45
            Height = 21
            TabOrder = 3
            Text = '19'
          end
          object Edit20: TEdit
            Left = 272
            Top = 84
            Width = 45
            Height = 21
            TabOrder = 4
            Text = '20'
          end
          object Edit21: TEdit
            Left = 320
            Top = 84
            Width = 45
            Height = 21
            TabOrder = 5
            Text = '21'
          end
          object Edit22: TEdit
            Left = 224
            Top = 104
            Width = 45
            Height = 21
            TabOrder = 6
            Text = '22'
          end
          object Edit23: TEdit
            Left = 272
            Top = 104
            Width = 45
            Height = 21
            TabOrder = 7
            Text = '23'
          end
          object Edit24: TEdit
            Left = 320
            Top = 104
            Width = 45
            Height = 21
            TabOrder = 8
            Text = '24'
          end
          object Edit25: TEdit
            Left = 224
            Top = 125
            Width = 45
            Height = 21
            TabOrder = 9
            Text = '25'
          end
          object Edit26: TEdit
            Left = 272
            Top = 125
            Width = 45
            Height = 21
            TabOrder = 10
            Text = '26'
          end
          object Edit27: TEdit
            Left = 320
            Top = 125
            Width = 45
            Height = 21
            TabOrder = 11
            Text = '27'
          end
          object Edit28: TEdit
            Left = 224
            Top = 145
            Width = 45
            Height = 21
            TabOrder = 12
            Text = '28'
          end
          object Edit29: TEdit
            Left = 272
            Top = 145
            Width = 45
            Height = 21
            TabOrder = 13
            Text = '29'
          end
          object Edit30: TEdit
            Left = 320
            Top = 145
            Width = 45
            Height = 21
            TabOrder = 14
            Text = '30'
          end
          object Edit31: TEdit
            Left = 224
            Top = 166
            Width = 45
            Height = 21
            TabOrder = 15
            Text = '31'
          end
          object Edit32: TEdit
            Left = 272
            Top = 166
            Width = 45
            Height = 21
            TabOrder = 16
            Text = '32'
          end
          object Edit33: TEdit
            Left = 320
            Top = 166
            Width = 45
            Height = 21
            TabOrder = 17
            Text = '33'
          end
          object CheckBox3: TCheckBox
            Left = 0
            Top = 0
            Width = 137
            Height = 17
            Caption = 'Включить/Выключить'
            TabOrder = 18
          end
        end
      end
    end
  end
end
