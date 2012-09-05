object RefTableForm: TRefTableForm
  Left = 388
  Top = 271
  BorderStyle = bsToolWindow
  Caption = 'Справка'
  ClientHeight = 227
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StaticText1: TStaticText
    Left = 0
    Top = 0
    Width = 263
    Height = 227
    Align = alClient
    Caption = 
      '                   Коэффициент доверия 90%'#13#10'  Относительная погр' +
      'ешность   Число испытаний'#13#10'                         45%         ' +
      '                   40'#13#10'                         30%             ' +
      '               80'#13#10'                         20%                 ' +
      '           160   '#13#10'                         15%                 ' +
      '           280'#13#10'                         14,4%                  ' +
      '       300 '#13#10'                         10%                       ' +
      '     600 '#13#10#13#10'                   Коэффициент доверия 95%'#13#10'  Относ' +
      'ительная погрешность   Число испытаний'#13#10'                        ' +
      ' 40%                           70'#13#10'                         29% ' +
      '                          120'#13#10'                         20%     ' +
      '                      220'#13#10'                         18%         ' +
      '                  280'#13#10'                         17,5%           ' +
      '             300'#13#10'                         15%                  ' +
      '         400'
    TabOrder = 0
  end
  object btnForEsc: TButton
    Left = 0
    Top = 96
    Width = 1
    Height = 1
    Cancel = True
    Caption = 'btnForEsc'
    ModalResult = 2
    TabOrder = 1
  end
end
