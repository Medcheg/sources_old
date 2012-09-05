object frmGraphicList: TfrmGraphicList
  Left = 409
  Top = 148
  BorderStyle = bsDialog
  Caption = 'frmGraphicList'
  ClientHeight = 238
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 21
    Width = 425
    Height = 185
    BevelInner = bvLowered
    TabOrder = 2
    object RadioButton1: TRadioButton
      Left = 48
      Top = 56
      Width = 145
      Height = 17
      Caption = 'Килевая качка корабля'
      TabOrder = 0
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton2: TRadioButton
      Tag = 1
      Left = 48
      Top = 72
      Width = 153
      Height = 17
      Caption = 'Бортовая качка корабля'
      TabOrder = 1
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton3: TRadioButton
      Tag = 2
      Left = 48
      Top = 88
      Width = 161
      Height = 17
      Caption = 'Курс + Рыскание корабля'
      TabOrder = 2
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton4: TRadioButton
      Tag = 3
      Left = 48
      Top = 112
      Width = 249
      Height = 17
      Caption = 'Ошибка измерения килевой качки корабля'
      TabOrder = 3
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton5: TRadioButton
      Tag = 4
      Left = 48
      Top = 128
      Width = 249
      Height = 17
      Caption = 'Ошибка измерения бортовой качки корабля'
      TabOrder = 4
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton6: TRadioButton
      Tag = 5
      Left = 48
      Top = 144
      Width = 249
      Height = 17
      Caption = 'Ошибка измерения курсового угла корабля'
      TabOrder = 5
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton18: TRadioButton
      Tag = 17
      Left = 48
      Top = 16
      Width = 233
      Height = 17
      Caption = 'Скорость корабля'
      TabOrder = 6
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton19: TRadioButton
      Tag = 18
      Left = 48
      Top = 32
      Width = 225
      Height = 17
      Caption = 'Вертикальное перемещения корабля'
      TabOrder = 7
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton20: TRadioButton
      Tag = 5
      Left = 48
      Top = 160
      Width = 249
      Height = 17
      Caption = 'Нестабильность врaщения антенны'
      TabOrder = 8
      OnMouseDown = RadioButton18MouseDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 21
    Width = 425
    Height = 185
    BevelInner = bvLowered
    TabOrder = 3
    object RadioButton11: TRadioButton
      Tag = 10
      Left = 48
      Top = 40
      Width = 350
      Height = 17
      Caption = 'Угловая скорость антенны по оси Z'
      TabOrder = 2
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton9: TRadioButton
      Tag = 8
      Left = 48
      Top = 8
      Width = 350
      Height = 17
      Caption = 'Угловая скорость антенны по оси Х'
      TabOrder = 0
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton10: TRadioButton
      Tag = 9
      Left = 48
      Top = 24
      Width = 350
      Height = 17
      Caption = 'Угловая скорость антенны по оси Y'
      TabOrder = 1
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton12: TRadioButton
      Tag = 11
      Left = 48
      Top = 64
      Width = 350
      Height = 17
      Caption = 'Линейная скорость точки установки антенны в КСК по оси Х'
      TabOrder = 3
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton13: TRadioButton
      Tag = 12
      Left = 48
      Top = 80
      Width = 350
      Height = 17
      Caption = 'Линейная скорость точки установки антенны в КСК по оси Y'
      TabOrder = 4
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton14: TRadioButton
      Tag = 13
      Left = 48
      Top = 96
      Width = 350
      Height = 17
      Caption = 'Линейная скорость точки установки антенны в КСК по оси Z'
      TabOrder = 5
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton15: TRadioButton
      Tag = 14
      Left = 48
      Top = 120
      Width = 350
      Height = 17
      Caption = 'Угловые ускорения точки установки антенны в КСК по оси Х'
      TabOrder = 6
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton16: TRadioButton
      Tag = 15
      Left = 48
      Top = 136
      Width = 350
      Height = 17
      Caption = 'Угловые ускорения точки установки антенны в КСК по оси Y'
      TabOrder = 7
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton17: TRadioButton
      Tag = 16
      Left = 48
      Top = 152
      Width = 350
      Height = 17
      Caption = 'Угловые ускорения точки установки антенны в КСК по оси Z'
      TabOrder = 8
      OnMouseDown = RadioButton18MouseDown
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 21
    Width = 425
    Height = 185
    BevelInner = bvLowered
    TabOrder = 4
    object RadioButton7: TRadioButton
      Tag = 6
      Left = 48
      Top = 56
      Width = 320
      Height = 17
      Caption = '[  DeltaQ   ]   Азимутальный угол отклонения луча от нормали ФАР'
      TabOrder = 0
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton8: TRadioButton
      Tag = 7
      Left = 48
      Top = 72
      Width = 320
      Height = 17
      Caption = '[ DeltaAlfa ]   Угломестное отклонения луча от нормали ФАР'
      TabOrder = 1
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton21: TRadioButton
      Tag = 6
      Left = 48
      Top = 16
      Width = 320
      Height = 17
      Caption = '[   TETA    ]    Угол отклонения оси луча от нормали'
      TabOrder = 2
      OnMouseDown = RadioButton18MouseDown
    end
    object RadioButton22: TRadioButton
      Tag = 7
      Left = 48
      Top = 32
      Width = 320
      Height = 17
      Caption = '[       FI      ]   Угол поворота оси луча в плоскости ФАР'
      TabOrder = 3
      OnMouseDown = RadioButton18MouseDown
    end
  end
  object BitBtn1: TBitBtn
    Left = 175
    Top = 209
    Width = 75
    Height = 25
    Caption = 'Да'
    Default = True
    ModalResult = 1
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
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 425
    Height = 21
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 108
    Caption = 'ToolBar1'
    EdgeBorders = []
    Flat = True
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = '  Входные задания  '
      Down = True
      Grouped = True
      ImageIndex = 0
      Style = tbsCheck
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 112
      Top = 0
      AutoSize = True
      Caption = '  Вынос антенны  '
      Grouped = True
      ImageIndex = 1
      Style = tbsCheck
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 214
      Top = 0
      AutoSize = True
      Caption = '  Луч ФАР  '
      Grouped = True
      ImageIndex = 2
      Style = tbsCheck
      OnClick = ToolButton3Click
    end
  end
end
