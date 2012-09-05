object frmSetupAngleNet: TfrmSetupAngleNet
  Left = 367
  Top = 262
  BorderStyle = bsDialog
  Caption = 'frmSetupAngleNet'
  ClientHeight = 311
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 163
    Height = 13
    Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1091#1075#1083#1086#1084#1077#1089#1090#1085#1099#1093' '#1086#1090#1084#1077#1090#1086#1082
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 161
    Height = 249
    Columns = 3
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
    OnKeyDown = ListBox1KeyDown
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 280
    Width = 75
    Height = 25
    Caption = #1044#1072
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 317
    Top = 280
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
  end
  object ToolBar1: TToolBar
    Left = 176
    Top = 24
    Width = 221
    Height = 25
    Align = alNone
    ButtonHeight = 21
    ButtonWidth = 107
    Caption = 'ToolBar1'
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Flat = True
    ShowCaptions = True
    TabOrder = 3
    object tbDeleteTick: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = ' '#1059#1076#1072#1083#1080#1090#1100' '#1086#1090#1084#1077#1090#1082#1091' '
      Enabled = False
      ImageIndex = 0
      OnClick = tbDeleteTickClick
    end
    object tbAddTick: TToolButton
      Left = 104
      Top = 0
      AutoSize = True
      Caption = ' '#1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1090#1084#1077#1090#1082#1091' '
      ImageIndex = 1
      OnClick = tbAddTickClick
    end
  end
  object Panel1: TPanel
    Left = 176
    Top = 56
    Width = 217
    Height = 217
    BevelInner = bvLowered
    TabOrder = 4
    object Label2: TLabel
      Left = 16
      Top = 16
      Width = 73
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1091#1075#1083#1072
      Enabled = False
    end
    object Label3: TLabel
      Left = 168
      Top = 16
      Width = 11
      Height = 13
      Caption = #1075#1088
      Enabled = False
    end
    object Edit1: TEdit
      Left = 96
      Top = 12
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 0
      OnKeyDown = Edit1KeyDown
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 40
      Width = 137
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1090#1084#1077#1090#1082#1091
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object bbApply: TBitBtn
      Left = 8
      Top = 184
      Width = 105
      Height = 25
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Default = True
      TabOrder = 2
      Visible = False
      OnClick = bbApplyClick
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
    object bbCancel: TBitBtn
      Left = 136
      Top = 184
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 3
      Visible = False
      OnClick = bbCancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
