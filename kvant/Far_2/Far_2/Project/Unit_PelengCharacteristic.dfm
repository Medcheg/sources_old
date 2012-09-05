object frmPelengCharacteristic: TfrmPelengCharacteristic
  Left = 378
  Top = 414
  ActiveControl = BitBtn1
  BorderStyle = bsDialog
  Caption = 'frmPelengCharacteristic'
  ClientHeight = 370
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 73
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 207
      Height = 13
      Caption = 'Строить пеленгационные х-ки для углов '
    end
    object Label2: TLabel
      Left = 219
      Top = 12
      Width = 13
      Height = 20
      Caption = 'Q'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 240
      Top = 16
      Width = 11
      Height = 13
      Caption = 'от'
    end
    object Label4: TLabel
      Left = 359
      Top = 16
      Width = 12
      Height = 13
      Caption = 'до'
    end
    object Label5: TLabel
      Left = 311
      Top = 16
      Width = 41
      Height = 13
      Caption = 'гр .........'
    end
    object Label6: TLabel
      Left = 428
      Top = 16
      Width = 11
      Height = 13
      Caption = 'гр'
    end
    object Label7: TLabel
      Left = 107
      Top = 48
      Width = 107
      Height = 13
      Caption = 'Шаг изменения угла '
    end
    object Label8: TLabel
      Left = 219
      Top = 44
      Width = 13
      Height = 20
      Caption = 'Q'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Symbol'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 311
      Top = 48
      Width = 11
      Height = 13
      Caption = 'гр'
    end
    object egBeginTeta: TEdit
      Left = 256
      Top = 12
      Width = 49
      Height = 21
      TabOrder = 0
      Text = 'GradusEdit1'
    end
    object egEndTeta: TEdit
      Left = 375
      Top = 12
      Width = 49
      Height = 21
      TabOrder = 1
      Text = 'GradusEdit1'
    end
    object BitBtn1: TBitBtn
      Left = 456
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Построить'
      Default = True
      TabOrder = 2
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
    object egTetaStep: TEdit
      Left = 256
      Top = 44
      Width = 49
      Height = 21
      TabOrder = 3
      Text = 'GradusEdit1'
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 73
    Width = 553
    Height = 297
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 1E-7
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 1E-6
    Legend.LegendStyle = lsSeries
    View3D = False
    View3DWalls = False
    OnBeforeDrawSeries = Chart1BeforeDrawSeries
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 1
  end
end
