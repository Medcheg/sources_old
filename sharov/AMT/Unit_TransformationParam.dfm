object frmTransformationParam: TfrmTransformationParam
  Left = 374
  Top = 159
  BorderStyle = bsToolWindow
  Caption = 'АМТ - Трансформация (мультипликативная, аддитивная)'
  ClientHeight = 260
  ClientWidth = 193
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 127
    Width = 193
    Height = 129
    Shape = bsFrame
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 193
    Height = 129
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 7
    Top = 8
    Width = 178
    Height = 28
    Alignment = taCenter
    AutoSize = False
    Caption = 'Коэффициент мультипликативной трасформации'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 46
    Top = 40
    Width = 101
    Height = 20
    Caption = 'f(x) = f(x) * K'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 7
    Top = 64
    Width = 27
    Height = 20
    Caption = 'K ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 7
    Top = 135
    Width = 178
    Height = 29
    Alignment = taCenter
    AutoSize = False
    Caption = 'Коэффициент аддитивной трасформации'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 44
    Top = 167
    Width = 105
    Height = 20
    Caption = 'f(x) = f(x) + B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 7
    Top = 191
    Width = 28
    Height = 20
    Caption = 'B ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 39
    Top = 64
    Width = 148
    Height = 21
    TabOrder = 0
    Text = '1'
  end
  object Button1: TButton
    Left = 7
    Top = 96
    Width = 180
    Height = 25
    Caption = 'Ввод значений'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 37
    Top = 191
    Width = 148
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Button2: TButton
    Left = 5
    Top = 223
    Width = 180
    Height = 25
    Caption = 'Ввод значений'
    TabOrder = 3
    OnClick = Button2Click
  end
end
