object frmMain: TfrmMain
  Left = 225
  Top = 114
  Width = 500
  Height = 500
  Caption = 'Rotation of axes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 40
    Top = 8
    object N444441: TMenuItem
      Caption = '��������� ��������'
      OnClick = N444441Click
    end
    object N111111111: TMenuItem
      Caption = '  1 ���  '
      OnClick = N111111111Click
    end
    object N2222222221: TMenuItem
      Caption = '  2 ���  '
      OnClick = N2222222221Click
    end
    object N333333331: TMenuItem
      Caption = '  3 ���  '
      OnClick = N333333331Click
    end
    object N1: TMenuItem
      Caption = '���������'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = '  � ���������  '
      OnClick = N2Click
    end
    object z1: TMenuItem
      Caption = 'z'
      OnClick = z1Click
    end
  end
end
