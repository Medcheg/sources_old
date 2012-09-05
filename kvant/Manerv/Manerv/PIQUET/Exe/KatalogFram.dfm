object KatalogFrame: TKatalogFrame
  Left = 0
  Top = 0
  Width = 134
  Height = 97
  TabOrder = 0
  object shpSelect: TShape
    Left = 0
    Top = 0
    Width = 134
    Height = 80
    Cursor = crHandPoint
    Brush.Style = bsClear
    Pen.Color = clHighlight
    Pen.Width = 2
    Visible = False
    OnMouseDown = stxtTraekNameMouseDown
  end
  object Panel1: TPanel
    Left = 3
    Top = 3
    Width = 129
    Height = 75
    BevelInner = bvLowered
    TabOrder = 0
    OnClick = imgTraekClick
    object imgTraek: TImage
      Left = 2
      Top = 2
      Width = 125
      Height = 70
      Cursor = crHandPoint
      OnMouseDown = stxtTraekNameMouseDown
    end
    object lblNo: TLabel
      Left = 4
      Top = 3
      Width = 6
      Height = 13
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCaptionText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object stxtTraekName: TStaticText
    Left = 0
    Top = 80
    Width = 19
    Height = 17
    Cursor = crHandPoint
    Alignment = taCenter
    Caption = '-----'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    OnMouseDown = stxtTraekNameMouseDown
  end
end
