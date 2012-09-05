object frmReportOfWell2_Param: TfrmReportOfWell2_Param
  Left = 321
  Top = 253
  BorderStyle = bsDialog
  Caption = 'frmReportOfWell2_Param'
  ClientHeight = 269
  ClientWidth = 363
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
  object Panel1: TPanel
    Left = 0
    Top = 232
    Width = 363
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Да'
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
    object BitBtn2: TBitBtn
      Left = 264
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Отмена'
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 363
    Height = 232
    ActivePage = TabSheet1
    Align = alClient
    HotTrack = True
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = ' Параметры отображения '
      object Bevel2: TBevel
        Left = 0
        Top = 73
        Width = 353
        Height = 89
      end
      object Label2: TLabel
        Left = 4
        Top = 16
        Width = 168
        Height = 13
        Caption = 'Начальная глубина отображения'
      end
      object Label3: TLabel
        Left = 11
        Top = 40
        Width = 161
        Height = 13
        Caption = 'Конечная глубина отображения'
      end
      object Label4: TLabel
        Left = 306
        Top = 16
        Width = 8
        Height = 13
        Caption = 'м'
      end
      object Label5: TLabel
        Left = 306
        Top = 40
        Width = 8
        Height = 13
        Caption = 'м'
      end
      object Label1: TLabel
        Left = 80
        Top = 112
        Width = 124
        Height = 13
        Caption = 'Количество линий вуали'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 353
        Height = 73
      end
      object Bevel3: TBevel
        Left = 0
        Top = 162
        Width = 353
        Height = 38
      end
      object Label6: TLabel
        Left = 8
        Top = 136
        Width = 202
        Height = 13
        Caption = 'Коэффициент прозрачности вуали (0..1)'
      end
      object Edit2: TEdit
        Left = 180
        Top = 12
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit3: TEdit
        Left = 180
        Top = 36
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 88
        Width = 121
        Height = 17
        Caption = 'Отображать вуаль'
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object Edit1: TEdit
        Left = 220
        Top = 109
        Width = 37
        Height = 21
        TabOrder = 3
        Text = '75'
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 171
        Width = 161
        Height = 17
        Caption = 'Включить след скважины'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = CheckBox2Click
      end
      object Button1: TButton
        Left = 319
        Top = 9
        Width = 26
        Height = 49
        Caption = 'V'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = Button1Click
      end
      object Edit4: TEdit
        Left = 220
        Top = 133
        Width = 37
        Height = 21
        TabOrder = 6
        Text = '0.3'
      end
    end
  end
end
