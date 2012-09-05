object frmSaveLasFile: TfrmSaveLasFile
  Left = 228
  Top = 153
  BorderStyle = bsDialog
  Caption = 'frmSaveLasFile'
  ClientHeight = 294
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 447
    Height = 294
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel4: TBevel
    Left = 6
    Top = 184
    Width = 433
    Height = 57
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel3: TBevel
    Left = 8
    Top = 32
    Width = 433
    Height = 113
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel2: TBevel
    Left = 8
    Top = 248
    Width = 433
    Height = 9
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 72
    Top = 96
    Width = 142
    Height = 13
    Caption = 'Начальная глубина в файле'
  end
  object Label2: TLabel
    Left = 79
    Top = 120
    Width = 135
    Height = 13
    Caption = 'Конечная глубина в файле'
  end
  object Label3: TLabel
    Left = 352
    Top = 96
    Width = 8
    Height = 13
    Caption = 'м'
  end
  object Label4: TLabel
    Left = 352
    Top = 120
    Width = 8
    Height = 13
    Caption = 'м'
  end
  object Label5: TLabel
    Left = 42
    Top = 40
    Width = 185
    Height = 13
    Caption = 'Текущая начальная глубина файла :'
  end
  object Label6: TLabel
    Left = 42
    Top = 56
    Width = 185
    Height = 13
    Caption = 'Текущая конечная  глубина  файла :'
  end
  object lStartDepth: TLabel
    Left = 240
    Top = 40
    Width = 53
    Height = 13
    Caption = 'lStartDepth'
  end
  object lStopDepth: TLabel
    Left = 240
    Top = 56
    Width = 53
    Height = 13
    Caption = 'lStopDepth'
  end
  object Label9: TLabel
    Left = 72
    Top = 216
    Width = 124
    Height = 13
    Caption = 'Разбить шаг глубины на'
  end
  object Label11: TLabel
    Left = 336
    Top = 216
    Width = 36
    Height = 13
    Caption = 'участк.'
  end
  object Label13: TLabel
    Left = 42
    Top = 192
    Width = 162
    Height = 13
    Caption = 'Текущий шаг глубины в файле :'
  end
  object lDepthStep: TLabel
    Left = 216
    Top = 192
    Width = 53
    Height = 13
    Caption = 'lDepthStep'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 264
    Width = 89
    Height = 25
    Caption = 'Записать'
    Default = True
    TabOrder = 3
    OnClick = BitBtn1Click
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
      000000001F7C1F7C000000420042000000000000000000000000186318630000
      004200001F7C1F7C000000420042000000000000000000000000186318630000
      004200001F7C1F7C000000420042000000000000000000000000186318630000
      004200001F7C1F7C000000420042000000000000000000000000000000000000
      004200001F7C1F7C000000420042004200420042004200420042004200420042
      004200001F7C1F7C000000420042000000000000000000000000000000000042
      004200001F7C1F7C000000420000186318631863186318631863186318630000
      004200001F7C1F7C000000420000186318631863186318631863186318630000
      004200001F7C1F7C000000420000186318631863186318631863186318630000
      004200001F7C1F7C000000420000186318631863186318631863186318630000
      004200001F7C1F7C000000420000186318631863186318631863186318630000
      000000001F7C1F7C000000420000186318631863186318631863186318630000
      186300001F7C1F7C000000000000000000000000000000000000000000000000
      000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 8
    Width = 225
    Height = 17
    Caption = 'вкл/выкл  Запись данных всего файла'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 224
    Top = 92
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 224
    Top = 116
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object BitBtn2: TBitBtn
    Left = 352
    Top = 264
    Width = 89
    Height = 25
    Caption = 'Отмена'
    TabOrder = 4
    Kind = bkCancel
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 160
    Width = 193
    Height = 17
    Caption = 'вкл/выкл  Интерполяцию в файле'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = CheckBox2Click
  end
  object seSection: TSpinEdit
    Left = 208
    Top = 211
    Width = 121
    Height = 22
    EditorEnabled = False
    MaxValue = 20
    MinValue = 2
    TabOrder = 6
    Value = 4
  end
  object SaveDialog1: TSaveDialog
    Left = 112
    Top = 264
  end
end
