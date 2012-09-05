object frmPlanshetParam: TfrmPlanshetParam
  Left = 243
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Plastomer -'
  ClientHeight = 136
  ClientWidth = 385
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
    Width = 385
    Height = 136
    Align = alClient
    Shape = bsFrame
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 9
    Top = 3
    Width = 152
    Height = 13
    Caption = 'Масштаб горизонтальной оси'
    Visible = False
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 228
    Height = 13
    Caption = 'Количество единиц (см) в одном сантиметре'
    Visible = False
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 205
    Height = 13
    Caption = 'Количество горизонтальных линий поля'
    Visible = False
  end
  object Label4: TLabel
    Left = 16
    Top = 80
    Width = 214
    Height = 13
    Caption = 'Шаг в пикселях вертикальных линий поля'
    Visible = False
  end
  object Edit1: TEdit
    Left = 254
    Top = 29
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '10'
    Visible = False
  end
  object Edit2: TEdit
    Left = 256
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '6'
    Visible = False
  end
  object Edit3: TEdit
    Left = 256
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '100'
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Да'
    TabOrder = 3
    OnClick = BitBtn1Click
    Kind = bkOK
  end
end
