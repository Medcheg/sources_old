object frmModelParams: TfrmModelParams
  Left = 87
  Top = 34
  BorderStyle = bsDialog
  Caption = 'Параметры модели'
  ClientHeight = 462
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 19
    Width = 142
    Height = 13
    Caption = 'Азмиут на абонент № 2, грд'
  end
  object Label2: TLabel
    Left = 42
    Top = 51
    Width = 180
    Height = 13
    Alignment = taRightJustify
    Caption = 'Расстояние между абонентами, км'
  end
  object Label3: TLabel
    Left = 14
    Top = 76
    Width = 208
    Height = 26
    Alignment = taRightJustify
    Caption = 'Уровень нечувствительности антенны в автоматическом режиме, грд'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 56
    Top = 365
    Width = 174
    Height = 26
    Alignment = taRightJustify
    Caption = 'Процент от выделенного сигнала ошибки (для автомата захвата)'
    Visible = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 11
    Top = 116
    Width = 211
    Height = 13
    Caption = 'Число импульсов (для автомата захвата)'
  end
  object Label7: TLabel
    Left = 32
    Top = 147
    Width = 190
    Height = 13
    Caption = 'Число пропусков между импульсами'
  end
  object Label12: TLabel
    Left = 41
    Top = 181
    Width = 181
    Height = 13
    Caption = 'Частота следования импульсов, Гц'
  end
  object Label4: TLabel
    Left = 102
    Top = 212
    Width = 120
    Height = 13
    Caption = 'Амплитуда импульса, В'
  end
  object Label15: TLabel
    Left = 117
    Top = 244
    Width = 99
    Height = 13
    Caption = 'Значение порога, В'
  end
  object Label16: TLabel
    Left = 92
    Top = 276
    Width = 124
    Height = 13
    Caption = 'Коэффициент для УВСО'
  end
  object edtBetta12: TEdit
    Left = 232
    Top = 16
    Width = 80
    Height = 21
    TabOrder = 0
    Text = 'edtBetta12'
  end
  object edtDistance: TEdit
    Left = 232
    Top = 48
    Width = 80
    Height = 21
    TabOrder = 1
    Text = 'edtDistance'
  end
  object edtDeltaBetta: TEdit
    Left = 232
    Top = 80
    Width = 80
    Height = 21
    TabOrder = 2
    Text = 'edtDeltaBetta'
  end
  object edtOffsetPercent: TEdit
    Left = 240
    Top = 368
    Width = 60
    Height = 21
    TabOrder = 3
    Text = '10'
    Visible = False
  end
  object edtImpulseAmount: TEdit
    Left = 232
    Top = 112
    Width = 60
    Height = 21
    TabOrder = 4
    Text = '1'
  end
  object edtImpulsiveBlankAmount: TEdit
    Left = 232
    Top = 144
    Width = 60
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object UpDownOffsetPercent: TUpDown
    Left = 300
    Top = 368
    Width = 15
    Height = 21
    Associate = edtOffsetPercent
    Min = 10
    Position = 10
    TabOrder = 6
    Visible = False
    Wrap = False
  end
  object UpDownImpulseAmount: TUpDown
    Left = 292
    Top = 112
    Width = 15
    Height = 21
    Associate = edtImpulseAmount
    Min = 1
    Max = 40
    Position = 1
    TabOrder = 7
    Wrap = False
  end
  object UpDownImpulsiveBlankAmount: TUpDown
    Left = 292
    Top = 144
    Width = 15
    Height = 21
    Associate = edtImpulsiveBlankAmount
    Min = 0
    Max = 10
    Position = 0
    TabOrder = 8
    Wrap = False
  end
  object grpbxAbonent1: TGroupBox
    Left = 336
    Top = 16
    Width = 289
    Height = 201
    Caption = 'Абонент № 1'
    TabOrder = 9
    object Label8: TLabel
      Left = 9
      Top = 24
      Width = 183
      Height = 13
      Caption = 'Начальное положение антенны, грд'
    end
    object Label10: TLabel
      Left = 84
      Top = 50
      Width = 108
      Height = 13
      Caption = 'Глубина сектора, грд'
    end
    object Label13: TLabel
      Left = 56
      Top = 75
      Width = 136
      Height = 13
      Caption = 'Скорость вращения, грд/с'
    end
    object Label17: TLabel
      Left = 30
      Top = 128
      Width = 162
      Height = 13
      Caption = 'Ускорение торможения, грд/с2'
    end
    object Label19: TLabel
      Left = 35
      Top = 93
      Width = 157
      Height = 26
      Alignment = taRightJustify
      Caption = 'Скорость вращения в режиме сопровождения, грд/с'
      WordWrap = True
    end
    object edtBetta0_1: TEdit
      Left = 201
      Top = 19
      Width = 80
      Height = 21
      TabOrder = 0
      Text = 'edtBetta0_1'
    end
    object edtDepthSector1: TEdit
      Left = 201
      Top = 46
      Width = 80
      Height = 21
      TabOrder = 1
      Text = 'edtBetta0_1'
    end
    object edtRotationSpeed1: TEdit
      Left = 201
      Top = 72
      Width = 60
      Height = 21
      TabOrder = 2
      Text = '10'
    end
    object UpDownRotationSpeed1: TUpDown
      Left = 261
      Top = 72
      Width = 15
      Height = 21
      Associate = edtRotationSpeed1
      Min = 10
      Max = 72
      Position = 10
      TabOrder = 3
      Wrap = False
    end
    object edtARotationSpeed1: TEdit
      Left = 201
      Top = 124
      Width = 80
      Height = 21
      TabOrder = 4
      Text = 'edtBetta0_1'
    end
    object RadioGroup1: TRadioGroup
      Left = 16
      Top = 152
      Width = 265
      Height = 41
      Caption = 'Режим поиска'
      Columns = 2
      Items.Strings = (
        'Круговой'
        'Секторный')
      TabOrder = 5
    end
    object edtAutoRotationSpeed1: TEdit
      Left = 201
      Top = 98
      Width = 60
      Height = 21
      TabOrder = 6
      Text = '1'
    end
    object UpDownAutoRotationSpeed1: TUpDown
      Left = 261
      Top = 98
      Width = 15
      Height = 21
      Associate = edtAutoRotationSpeed1
      Min = 1
      Max = 72
      Position = 1
      TabOrder = 7
      Wrap = False
    end
  end
  object btnOk: TBitBtn
    Left = 16
    Top = 424
    Width = 75
    Height = 25
    Caption = 'Да'
    TabOrder = 10
    OnClick = btnOkClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 104
    Top = 424
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 11
    Kind = bkCancel
  end
  object edtFrequency: TEdit
    Left = 232
    Top = 176
    Width = 60
    Height = 21
    TabOrder = 12
    Text = '0'
  end
  object UpDownFrequency: TUpDown
    Left = 292
    Top = 176
    Width = 15
    Height = 21
    Associate = edtFrequency
    Min = 0
    Max = 500
    Position = 0
    TabOrder = 13
    Wrap = False
  end
  object GroupBox1: TGroupBox
    Left = 336
    Top = 224
    Width = 289
    Height = 201
    Caption = 'Абонент № 2'
    TabOrder = 14
    object Label9: TLabel
      Left = 9
      Top = 24
      Width = 183
      Height = 13
      Caption = 'Начальное положение антенны, грд'
    end
    object Label11: TLabel
      Left = 84
      Top = 50
      Width = 108
      Height = 13
      Caption = 'Глубина сектора, грд'
    end
    object Label14: TLabel
      Left = 56
      Top = 75
      Width = 136
      Height = 13
      Caption = 'Скорость вращения, грд/с'
    end
    object Label18: TLabel
      Left = 30
      Top = 128
      Width = 162
      Height = 13
      Caption = 'Ускорение торможения, грд/с2'
    end
    object Label20: TLabel
      Left = 35
      Top = 93
      Width = 157
      Height = 26
      Alignment = taRightJustify
      Caption = 'Скорость вращения в режиме сопровождения, грд/с'
      WordWrap = True
    end
    object edtBetta0_2: TEdit
      Left = 201
      Top = 19
      Width = 80
      Height = 21
      TabOrder = 0
      Text = 'edtBetta0_1'
    end
    object edtDepthSector2: TEdit
      Left = 201
      Top = 46
      Width = 80
      Height = 21
      TabOrder = 1
      Text = 'edtBetta0_1'
    end
    object edtRotationSpeed2: TEdit
      Left = 201
      Top = 72
      Width = 60
      Height = 21
      TabOrder = 2
      Text = '10'
    end
    object UpDownRotationSpeed2: TUpDown
      Left = 261
      Top = 72
      Width = 15
      Height = 21
      Associate = edtRotationSpeed2
      Min = 10
      Max = 72
      Position = 10
      TabOrder = 3
      Wrap = False
    end
    object edtARotationSpeed2: TEdit
      Left = 201
      Top = 124
      Width = 80
      Height = 21
      TabOrder = 4
      Text = 'edtBetta0_1'
    end
    object RadioGroup2: TRadioGroup
      Left = 16
      Top = 152
      Width = 265
      Height = 41
      Caption = 'Режим поиска'
      Columns = 2
      Items.Strings = (
        'Круговой'
        'Секторный')
      TabOrder = 5
    end
    object edtAutoRotationSpeed2: TEdit
      Left = 201
      Top = 98
      Width = 60
      Height = 21
      TabOrder = 6
      Text = '1'
    end
    object UpDownAutoRotationSpeed2: TUpDown
      Left = 261
      Top = 98
      Width = 15
      Height = 21
      Associate = edtAutoRotationSpeed2
      Min = 1
      Max = 72
      Position = 1
      TabOrder = 7
      Wrap = False
    end
  end
  object edtImpulseAmplitude: TEdit
    Left = 232
    Top = 208
    Width = 80
    Height = 21
    TabOrder = 15
    Text = 'edtDeltaBetta'
  end
  object edtLevelV: TEdit
    Left = 232
    Top = 240
    Width = 80
    Height = 21
    TabOrder = 16
    Text = 'edtDeltaBetta'
  end
  object edtK: TEdit
    Left = 232
    Top = 272
    Width = 80
    Height = 21
    TabOrder = 17
    Text = 'edtDeltaBetta'
  end
end
