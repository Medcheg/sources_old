object form_DeviceParam: Tform_DeviceParam
  Left = 0
  Top = 0
  ActiveControl = Panel1
  BorderStyle = bsNone
  Caption = 'form_DeviceParam'
  ClientHeight = 211
  ClientWidth = 299
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 299
    Height = 211
    Align = alClient
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      295
      207)
    object Label1: TLabel
      Left = 4
      Top = 3
      Width = 41
      Height = 13
      Caption = 'Device:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 51
      Top = 3
      Width = 30
      Height = 13
      Caption = '------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object label_N1: TLabel
      Left = 8
      Top = 24
      Width = 10
      Height = 13
      Caption = '1.'
    end
    object label_Name1: TLabel
      Left = 23
      Top = 24
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N2: TLabel
      Left = 8
      Top = 42
      Width = 10
      Height = 13
      Caption = '2.'
    end
    object label_Name2: TLabel
      Left = 23
      Top = 42
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N3: TLabel
      Left = 8
      Top = 60
      Width = 10
      Height = 13
      Caption = '3.'
    end
    object label_Name3: TLabel
      Left = 23
      Top = 60
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N4: TLabel
      Left = 8
      Top = 78
      Width = 10
      Height = 13
      Caption = '4.'
    end
    object label_Name4: TLabel
      Left = 23
      Top = 78
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N5: TLabel
      Left = 8
      Top = 96
      Width = 10
      Height = 13
      Caption = '5.'
    end
    object label_Name5: TLabel
      Left = 23
      Top = 96
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N6: TLabel
      Left = 8
      Top = 114
      Width = 10
      Height = 13
      Caption = '6.'
    end
    object label_Name6: TLabel
      Left = 23
      Top = 114
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N7: TLabel
      Left = 8
      Top = 132
      Width = 10
      Height = 13
      Caption = '7.'
    end
    object label_Name7: TLabel
      Left = 23
      Top = 132
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N8: TLabel
      Left = 8
      Top = 150
      Width = 10
      Height = 13
      Caption = '8.'
    end
    object label_Name8: TLabel
      Left = 23
      Top = 150
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object label_N9: TLabel
      Left = 8
      Top = 168
      Width = 10
      Height = 13
      Caption = '9.'
    end
    object label_Name9: TLabel
      Left = 23
      Top = 168
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'CoutReadBytes_FromOne_Request :'
    end
    object SpeedButton1: TSpeedButton
      Left = 263
      Top = 1
      Width = 18
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'X'
      Flat = True
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'WST_Czec'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
      ExplicitLeft = 275
    end
    object SpeedButton2: TSpeedButton
      Left = 201
      Top = 0
      Width = 54
      Height = 18
      Caption = 'ACCEPT'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object Label3: TLabel
      Left = 4
      Top = 187
      Width = 57
      Height = 13
      Caption = 'SP param:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 66
      Top = 187
      Width = 30
      Height = 13
      Caption = '------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edit_Val1: TEdit
      Left = 207
      Top = 21
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 0
      Text = 'edit_Val1'
    end
    object edit_Val2: TEdit
      Left = 207
      Top = 39
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 1
      Text = 'Edit1'
    end
    object edit_Val3: TEdit
      Left = 207
      Top = 57
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 2
      Text = 'Edit1'
    end
    object edit_Val4: TEdit
      Left = 207
      Top = 75
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 3
      Text = 'Edit1'
    end
    object edit_Val5: TEdit
      Left = 207
      Top = 93
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 4
      Text = 'Edit1'
    end
    object edit_Val6: TEdit
      Left = 207
      Top = 111
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 5
      Text = 'Edit1'
    end
    object edit_Val7: TEdit
      Left = 207
      Top = 129
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 6
      Text = 'Edit1'
    end
    object edit_Val8: TEdit
      Left = 207
      Top = 147
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 7
      Text = 'Edit1'
    end
    object edit_Val9: TEdit
      Left = 207
      Top = 165
      Width = 82
      Height = 18
      AutoSize = False
      TabOrder = 8
      Text = 'Edit1'
    end
  end
end
