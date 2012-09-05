object frmTargetList: TfrmTargetList
  Left = 1016
  Top = 696
  BorderStyle = bsToolWindow
  Caption = 'frmTargetList'
  ClientHeight = 206
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CheckListBox1: TCheckListBox
    Left = 4
    Top = 40
    Width = 245
    Height = 148
    OnClickCheck = CheckListBox1ClickCheck
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    Items.Strings = (
      '*11111'
      '  2222222'
      '  3333333'
      '*4444444'
      '  55555555'
      '  666666666'
      '*777777777'
      '  88888888'
      '  666666666'
      '*777777777'
      '  88888888'
      '  666666666')
    ParentFont = False
    TabOrder = 0
    OnClick = CheckListBox1Click
    OnDblClick = CheckListBox1DblClick
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 252
    Height = 21
    AutoSize = True
    ButtonHeight = 21
    ButtonWidth = 78
    Caption = 'ToolBar1'
    EdgeBorders = []
    Flat = True
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = '  Загрузить  '
      Grouped = True
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object ToolButton3: TToolButton
      Left = 75
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 83
      Top = 0
      AutoSize = True
      Caption = '  Сохранить  '
      Grouped = True
      ImageIndex = 1
      OnClick = ToolButton2Click
    end
    object ToolButton4: TToolButton
      Left = 159
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbParam: TToolButton
      Left = 167
      Top = 0
      AutoSize = True
      Caption = '  Параметры  '
      Grouped = True
      ImageIndex = 2
      OnClick = tbParamClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 187
    Width = 252
    Height = 19
    Panels = <
      item
        Text = 'Ro:'
        Width = 50
      end
      item
        Text = 'Bo:'
        Width = 50
      end
      item
        Text = 'Vo:'
        Width = 50
      end
      item
        Text = 'Ho:'
        Width = 50
      end
      item
        Text = 'Ko:'
        Width = 50
      end>
    SimplePanel = False
  end
  object SaveDialog1: TSaveDialog
    Left = 16
    Top = 48
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 48
  end
end
