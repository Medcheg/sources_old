object Form19: TForm19
  Left = 0
  Top = 0
  Caption = 'Form19'
  ClientHeight = 508
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 293
    Width = 130
    Height = 13
    Caption = 'MULL Matrix [A*A^-1]:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 85
    Width = 91
    Height = 13
    Caption = 'Base Matrix [A]:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 641
    Top = 293
    Width = 337
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1042#1088#1077#1084#1103' '#1089#1095#1077#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 104
    Width = 970
    Height = 185
    ColCount = 10
    DefaultColWidth = 96
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    ScrollBars = ssNone
    TabOrder = 0
    OnExit = StringGrid2Exit
  end
  object StringGrid2: TStringGrid
    Left = 8
    Top = 312
    Width = 970
    Height = 185
    ColCount = 10
    DefaultColWidth = 96
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    ScrollBars = ssNone
    TabOrder = 1
    OnExit = StringGrid2Exit
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
end
