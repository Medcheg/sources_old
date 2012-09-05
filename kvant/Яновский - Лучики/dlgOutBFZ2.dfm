object frmOutBFZ2: TfrmOutBFZ2
  Left = 294
  Top = 159
  Width = 266
  Height = 242
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Выход блока БФЗ2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 152
    Width = 258
    Height = 63
    Align = alBottom
    TabOrder = 0
    object lblLeft: TLabel
      Left = 72
      Top = 8
      Width = 16
      Height = 13
      Caption = '0 В'
    end
    object lblCenter: TLabel
      Left = 72
      Top = 24
      Width = 16
      Height = 13
      Caption = '0 В'
    end
    object lblRight: TLabel
      Left = 72
      Top = 40
      Width = 16
      Height = 13
      Caption = '0 В'
    end
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 40
      Height = 13
      Caption = 'Левый :'
    end
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 37
      Height = 13
      Caption = 'Центр :'
    end
    object Label3: TLabel
      Left = 16
      Top = 40
      Width = 46
      Height = 13
      Caption = 'Правый :'
    end
  end
  object Chart: TChart
    Left = 0
    Top = 0
    Width = 258
    Height = 152
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Maximum = 11
    LeftAxis.Minimum = 1E-15
    Legend.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 1
    object Series: TBarSeries
      Marks.ArrowLength = 20
      Marks.Style = smsValue
      Marks.Visible = True
      SeriesColor = clRed
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
end
