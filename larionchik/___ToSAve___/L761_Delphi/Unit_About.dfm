object frmAbout: TfrmAbout
  Left = 221
  Top = 190
  BorderStyle = bsDialog
  Caption = 'О программе... '
  ClientHeight = 217
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 139
    Top = 187
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 337
    Height = 169
    BevelInner = bvLowered
    TabOrder = 1
    object Panel2: TPanel
      Left = 8
      Top = 12
      Width = 321
      Height = 150
      BevelOuter = bvNone
      TabOrder = 0
      object Panel3: TPanel
        Left = 16
        Top = -112
        Width = 298
        Height = 257
        BevelOuter = bvNone
        TabOrder = 0
        object Bevel1: TBevel
          Left = 16
          Top = 96
          Width = 273
          Height = 89
          Shape = bsFrame
          Style = bsRaised
        end
        object Label2: TLabel
          Left = 37
          Top = 24
          Width = 217
          Height = 37
          Caption = 'Техсис && DST'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 24
          Top = 104
          Width = 70
          Height = 13
          Caption = 'Исполнители:'
        end
        object Label4: TLabel
          Left = 56
          Top = 128
          Width = 79
          Height = 13
          Caption = 'Лариончик В.Н.'
        end
        object Label5: TLabel
          Left = 120
          Top = 152
          Width = 71
          Height = 13
          Caption = 'Марусык П.И.'
        end
        object Label6: TLabel
          Left = 187
          Top = 128
          Width = 57
          Height = 13
          Caption = 'Цисаж В.В.'
        end
        object Label8: TLabel
          Left = 24
          Top = 192
          Width = 118
          Height = 13
          Caption = 'Контактные телефоны:'
        end
        object Label9: TLabel
          Left = 80
          Top = 216
          Width = 120
          Height = 13
          Caption = '+38 - (044) - 278 - 85 - 18'
        end
      end
    end
  end
  object Timer1: TTimer
    Interval = 1500
    OnTimer = Timer1Timer
    Left = 8
    Top = 184
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer2Timer
    Left = 304
    Top = 184
  end
end
