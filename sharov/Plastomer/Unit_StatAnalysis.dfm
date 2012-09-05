object frmStatAnalysis: TfrmStatAnalysis
  Left = 261
  Top = 152
  BorderStyle = bsDialog
  Caption = 'frmStatAnalysis'
  ClientHeight = 340
  ClientWidth = 439
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 142
    Height = 13
    Caption = 'Вычисление азимута окном'
  end
  object Label2: TLabel
    Left = 156
    Top = 37
    Width = 6
    Height = 13
    Caption = '+'
    Transparent = True
  end
  object Label3: TLabel
    Left = 157
    Top = 42
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
  object Label4: TLabel
    Left = 219
    Top = 40
    Width = 14
    Height = 13
    Caption = 'гр.'
  end
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 102
    Height = 13
    Cursor = crHandPoint
    Caption = 'Интервал глубин'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = Label5Click
  end
  object Label6: TLabel
    Left = 189
    Top = 8
    Width = 8
    Height = 13
    Caption = 'м'
  end
  object Label7: TLabel
    Left = 278
    Top = 8
    Width = 8
    Height = 13
    Caption = 'м'
  end
  object Label8: TLabel
    Left = 8
    Top = 68
    Width = 217
    Height = 13
    Caption = 'Строить статистики по углу наклона       от'
  end
  object Label9: TLabel
    Left = 282
    Top = 68
    Width = 14
    Height = 13
    Caption = 'гр.'
  end
  object Label10: TLabel
    Left = 377
    Top = 68
    Width = 14
    Height = 13
    Caption = 'гр.'
  end
  object Label11: TLabel
    Left = 306
    Top = 68
    Width = 12
    Height = 13
    Caption = 'до'
  end
  object Label12: TLabel
    Left = 8
    Top = 96
    Width = 197
    Height = 13
    Caption = '№ максимума азимута и угла падения'
  end
  object seAzimWindow: TSpinEdit
    Left = 167
    Top = 37
    Width = 50
    Height = 22
    Color = clSilver
    MaxLength = 90
    MaxValue = 90
    MinValue = 1
    TabOrder = 2
    Value = 11
    OnChange = seAzimWindowChange
  end
  object Edit1: TEdit
    Left = 120
    Top = 4
    Width = 65
    Height = 21
    Hint = 'Начальная глубина проведения статистики'
    Color = clSilver
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = '0'
    OnChange = Edit1Chang
  end
  object Edit2: TEdit
    Left = 208
    Top = 4
    Width = 65
    Height = 21
    Hint = 'Конечная глубина проведения статистики'
    Color = clSilver
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '0'
    OnChange = Edit1Chang
  end
  object seNumberAzim: TSpinEdit
    Left = 211
    Top = 93
    Width = 50
    Height = 22
    Color = clSilver
    MaxLength = 90
    MaxValue = 90
    MinValue = 1
    TabOrder = 5
    Value = 1
    OnChange = seNumberAzimChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 120
    Width = 425
    Height = 217
    Caption = 'GroupBox1'
    TabOrder = 6
    object GroupBox2: TGroupBox
      Left = 8
      Top = 16
      Width = 201
      Height = 193
      Caption = 'GroupBox2'
      TabOrder = 0
      object Image1: TImage
        Left = 2
        Top = 15
        Width = 197
        Height = 176
        Align = alClient
      end
    end
    object GroupBox3: TGroupBox
      Left = 216
      Top = 16
      Width = 201
      Height = 193
      Caption = 'GroupBox2'
      TabOrder = 1
      object Image2: TImage
        Left = 2
        Top = 15
        Width = 197
        Height = 176
        Align = alClient
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 354
    Top = 4
    Width = 80
    Height = 25
    Caption = 'Расчет'
    Default = True
    TabOrder = 7
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
    Left = 354
    Top = 32
    Width = 80
    Height = 25
    Caption = 'Закрыть'
    TabOrder = 8
    Kind = bkCancel
  end
  object seBeginAlfa: TSpinEdit
    Left = 231
    Top = 65
    Width = 50
    Height = 22
    Color = clSilver
    MaxLength = 90
    MaxValue = 80
    MinValue = 0
    TabOrder = 3
    Value = 0
    OnChange = seBeginAlfaChange
  end
  object seEndAlfa: TSpinEdit
    Left = 323
    Top = 65
    Width = 50
    Height = 22
    Color = clSilver
    MaxLength = 90
    MaxValue = 90
    MinValue = 0
    TabOrder = 4
    Value = 90
    OnChange = seEndAlfaChange
  end
end
