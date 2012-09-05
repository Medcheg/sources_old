object frmBKParams: TfrmBKParams
  Left = 196
  Top = 39
  BorderStyle = bsDialog
  Caption = 'Параметры блока коррекции'
  ClientHeight = 487
  ClientWidth = 403
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 385
    Height = 73
    Caption = 'Интеграл'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 241
      Height = 13
      Caption = 'Коэффициент усиления интегрирующего звена'
    end
    object edtKintegral: TEdit
      Left = 16
      Top = 40
      Width = 353
      Height = 21
      TabOrder = 0
      Text = 'edtKintegral'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 88
    Width = 385
    Height = 177
    Caption = '1-е апериодическое звено с форсировкой'
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 340
      Height = 13
      Caption = 'Коэффициент усиления апериодического звена с форсировкой (К)'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 334
      Height = 13
      Caption = 'Постоянная времени апериодического звена с форсировкой (Т1)'
    end
    object Label4: TLabel
      Left = 16
      Top = 120
      Width = 195
      Height = 13
      Caption = 'Постоянная времени форсировки (Т2)'
    end
    object edtK1: TEdit
      Left = 16
      Top = 40
      Width = 353
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object edtT11: TEdit
      Left = 16
      Top = 88
      Width = 353
      Height = 21
      TabOrder = 1
      Text = 'Edit1'
    end
    object edtT21: TEdit
      Left = 16
      Top = 136
      Width = 353
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 272
    Width = 385
    Height = 177
    Caption = '2-е апериодическое звено с форсировкой'
    TabOrder = 2
    object Label5: TLabel
      Left = 16
      Top = 24
      Width = 340
      Height = 13
      Caption = 'Коэффициент усиления апериодического звена с форсировкой (К)'
    end
    object Label6: TLabel
      Left = 16
      Top = 72
      Width = 334
      Height = 13
      Caption = 'Постоянная времени апериодического звена с форсировкой (Т1)'
    end
    object Label7: TLabel
      Left = 16
      Top = 120
      Width = 195
      Height = 13
      Caption = 'Постоянная времени форсировки (Т2)'
    end
    object edtK2: TEdit
      Left = 16
      Top = 40
      Width = 353
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object edtT12: TEdit
      Left = 16
      Top = 88
      Width = 353
      Height = 21
      TabOrder = 1
      Text = 'Edit1'
    end
    object edtT22: TEdit
      Left = 16
      Top = 136
      Width = 353
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
    end
  end
  object btnCancel: TBitBtn
    Left = 320
    Top = 458
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 3
    Kind = bkCancel
  end
  object btnOk: TBitBtn
    Left = 232
    Top = 458
    Width = 75
    Height = 25
    Caption = 'Да'
    TabOrder = 4
    OnClick = btnOkClick
    Kind = bkOK
  end
end
