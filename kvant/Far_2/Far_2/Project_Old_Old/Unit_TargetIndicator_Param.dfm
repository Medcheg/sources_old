object frmTargetIndicator_Param: TfrmTargetIndicator_Param
  Left = 266
  Top = 263
  BorderStyle = bsDialog
  Caption = 'frmTargetIndicator_Param'
  ClientHeight = 332
  ClientWidth = 714
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 714
    Height = 332
    Align = alClient
    Shape = bsFrame
  end
  object Bevel2: TBevel
    Left = 8
    Top = 247
    Width = 697
    Height = 50
    Shape = bsBottomLine
  end
  object Label2: TLabel
    Left = 144
    Top = 176
    Width = 197
    Height = 13
    Caption = 'Цвет отображения значений графиков'
    Visible = False
  end
  object Label1: TLabel
    Left = 139
    Top = 194
    Width = 202
    Height = 13
    Caption = 'Фон окна графиков ошибок измерения'
    ParentShowHint = False
    ShowHint = True
  end
  object Label3: TLabel
    Left = 59
    Top = 230
    Width = 282
    Height = 13
    Caption = 'Цвет вспомогательных линий угломерного индикатора'
    ParentShowHint = False
    ShowHint = True
  end
  object Label4: TLabel
    Left = 161
    Top = 248
    Width = 180
    Height = 13
    Caption = 'Фон окна угломерного индикатора'
    ParentShowHint = False
    ShowHint = True
  end
  object Label5: TLabel
    Left = 135
    Top = 212
    Width = 206
    Height = 13
    Caption = 'Цвет надписей угломерного индикатора'
    ParentShowHint = False
    ShowHint = True
  end
  object Label6: TLabel
    Left = 64
    Top = 272
    Width = 280
    Height = 13
    Caption = 'Максимальное отклонение на угломерном индикатору'
  end
  object Label7: TLabel
    Left = 480
    Top = 272
    Width = 11
    Height = 13
    Caption = 'гр'
  end
  object BitBtn1: TBitBtn
    Left = 17
    Top = 302
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
  object Panel1: TPanel
    Left = 352
    Top = 174
    Width = 140
    Height = 17
    Hint = 'Нажать сюда для изменения цвета отображения выбранного параметра'
    BevelInner = bvLowered
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Visible = False
    OnClick = Panel1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 345
    Height = 153
    Caption = 'Перечень выводимых графиков ошибок измерений'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object CheckListBox1: TCheckListBox
      Left = 16
      Top = 24
      Width = 300
      Height = 113
      OnClickCheck = CheckListBox1ClickCheck
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        '( метод1 ) Ошибка опред. пеленга цели в СК ФАР'
        '( метод1 ) Ошибка опред. угла места цели в СК ФАР'
        '( метод1 ) Ошибка опред. пеленга цели в ГСК'
        '( метод1 ) Ошибка опред. угла места цели в ГСК'
        '( метод2 ) Ошибка опред. пеленга цели в СК ФАР'
        '( метод2 ) Ошибка опред. угла места цели в СК ФАР'
        '( метод2 ) Ошибка опред. пеленга цели в ГСК'
        '( метод2 ) Ошибка опред. угла места цели в ГСК')
      ParentFont = False
      TabOrder = 0
      OnClick = CheckListBox1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 360
    Top = 8
    Width = 345
    Height = 153
    Caption = 'Перечень выводимых граф. на угломерный индикатор'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object CheckListBox2: TCheckListBox
      Left = 16
      Top = 24
      Width = 300
      Height = 58
      OnClickCheck = CheckListBox2ClickCheck
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        '( метод1 ) Ошибка опред.  координат СК ФАР'
        '( метод1 ) Ошибка опред. координат в ГСК'
        '( метод2 ) Ошибка опред.  координат СК ФАР'
        '( метод2 ) Ошибка опред. координат в ГСК')
      ParentFont = False
      TabOrder = 0
      OnClick = CheckListBox2Click
    end
  end
  object Panel2: TPanel
    Left = 352
    Top = 192
    Width = 140
    Height = 17
    BevelInner = bvLowered
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = Panel2Click
  end
  object Panel4: TPanel
    Left = 352
    Top = 228
    Width = 140
    Height = 17
    BevelInner = bvLowered
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = Panel4Click
  end
  object Panel5: TPanel
    Left = 352
    Top = 246
    Width = 140
    Height = 17
    BevelInner = bvLowered
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = Panel5Click
  end
  object Panel3: TPanel
    Left = 352
    Top = 210
    Width = 140
    Height = 17
    BevelInner = bvLowered
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = Panel3Click
  end
  object FloatEdit1: TFloatEdit
    Left = 352
    Top = 268
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'FloatEdit1'
  end
  object BitBtn2: TBitBtn
    Left = 624
    Top = 302
    Width = 75
    Height = 25
    TabOrder = 9
    Kind = bkCancel
  end
  object Button1: TButton
    Left = 104
    Top = 302
    Width = 177
    Height = 25
    Caption = 'Востановить умолчания'
    TabOrder = 10
    OnClick = Button1Click
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen]
    Left = 496
    Top = 176
  end
end
