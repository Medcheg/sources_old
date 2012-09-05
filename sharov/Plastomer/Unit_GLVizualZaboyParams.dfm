object frmGLVizualZaboyParams: TfrmGLVizualZaboyParams
  Left = 215
  Top = 69
  Width = 293
  Height = 232
  BorderIcons = [biSystemMenu]
  Caption = 'Параметры визуализации скважины'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 1
    Width = 285
    Height = 104
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 104
      Height = 13
      Caption = 'Ввизуализировать с'
    end
    object Label2: TLabel
      Left = 98
      Top = 76
      Width = 12
      Height = 13
      Caption = 'по'
    end
    object Label3: TLabel
      Left = 10
      Top = 8
      Width = 200
      Height = 16
      Caption = 'Введите номера башмаков'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 160
      Top = 40
      Width = 46
      Height = 13
      Caption = 'башмака'
    end
    object Label5: TLabel
      Left = 164
      Top = 77
      Width = 40
      Height = 13
      Caption = 'башмак'
    end
    object Edit1: TEdit
      Left = 120
      Top = 40
      Width = 33
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 120
      Top = 72
      Width = 33
      Height = 21
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 200
    Top = 178
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Panel2: TPanel
    Left = 0
    Top = 107
    Width = 285
    Height = 65
    BevelInner = bvLowered
    TabOrder = 2
    object Label6: TLabel
      Left = 9
      Top = 10
      Width = 169
      Height = 13
      Caption = 'Расстояние между плоскостями '
    end
    object Label7: TLabel
      Left = 11
      Top = 34
      Width = 149
      Height = 13
      Caption = 'Размер точки(след башмака)'
    end
    object edSegmentRasst: TEdit
      Left = 192
      Top = 8
      Width = 73
      Height = 21
      TabOrder = 0
    end
    object edPointSize: TEdit
      Left = 192
      Top = 32
      Width = 73
      Height = 21
      TabOrder = 1
    end
  end
end
