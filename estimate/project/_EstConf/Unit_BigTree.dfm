object frmBigTree: TfrmBigTree
  Left = 327
  Top = 133
  BorderStyle = bsDialog
  Caption = 'frmBigTree'
  ClientHeight = 122
  ClientWidth = 221
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tvElement: TTreeView
    Left = 0
    Top = 0
    Width = 221
    Height = 122
    Align = alClient
    DragMode = dmAutomatic
    Images = frmMain.ImageList1
    Indent = 19
    TabOrder = 0
    OnChanging = tvElementChanging
    OnDeletion = tvElementDeletion
    OnDragDrop = tvElementDragDrop
    OnDragOver = tvElementDragOver
  end
end
