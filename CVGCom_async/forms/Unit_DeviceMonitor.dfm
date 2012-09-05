object form_DeviceMonitor: Tform_DeviceMonitor
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'form_DeviceMonitor'
  ClientHeight = 222
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tabcontrol_DeviceInfo: TTabControl
    Left = 0
    Top = 0
    Width = 253
    Height = 222
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'Tab1'
      'Tab2'
      'Tab3'
      'Tab4')
    TabIndex = 0
    ExplicitHeight = 234
    object StringGrid1: TStringGrid
      Left = 4
      Top = 24
      Width = 245
      Height = 194
      Align = alClient
      ColCount = 2
      DefaultColWidth = 119
      DefaultRowHeight = 18
      DrawingStyle = gdsClassic
      FixedCols = 0
      RowCount = 10
      ScrollBars = ssNone
      TabOrder = 0
      OnEnter = StringGrid1Enter
      ExplicitHeight = 210
    end
  end
end
