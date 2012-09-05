object form_Main: Tform_Main
  Left = 0
  Top = 0
  Caption = 'form_Main'
  ClientHeight = 639
  ClientWidth = 994
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 994
    Height = 28
    AutoSize = True
    ButtonHeight = 28
    ButtonWidth = 99
    Caption = 'ToolBar1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ShowCaptions = True
    TabOrder = 0
    object tbFile: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = '   File   '
      DropdownMenu = PopupMenu1
      Grouped = True
      ImageIndex = 0
    end
    object tbSetting: TToolButton
      Left = 71
      Top = 0
      AutoSize = True
      Caption = '  Settings  '
      Grouped = True
      OnClick = tbSettingClick
    end
    object tbAnalisys: TToolButton
      Left = 170
      Top = 0
      AutoSize = True
      Caption = '  Analysis   '
      Enabled = False
      Grouped = True
      ImageIndex = 2
    end
    object tbWindow: TToolButton
      Left = 273
      Top = 0
      AutoSize = True
      Caption = '   Help   '
      Enabled = False
      Grouped = True
      ImageIndex = 4
    end
  end
  object panel_SoundCard: TPanel
    Left = 0
    Top = 28
    Width = 994
    Height = 58
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 7
      Width = 64
      Height = 13
      BiDiMode = bdRightToLeft
      Caption = 'Sound Card'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 174
      Top = 7
      Width = 126
      Height = 13
      Caption = 'Sound Card Frequency'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 348
      Top = 7
      Width = 93
      Height = 13
      Caption = 'Time Work [sec]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object iLogo: TImage
      Left = 797
      Top = 2
      Width = 195
      Height = 54
      Align = alRight
      AutoSize = True
      Picture.Data = {
        0A544A504547496D616765D90C0000FFD8FFE000104A46494600010101006000
        600000FFE100B845786966000049492A00080000000500120103000100000001
        000000310102001C0000004A0000003201020014000000660000001302030001
        0000000100000069870400010000007A00000000000000414344205379737465
        6D73204469676974616C20496D6167696E6700323030363A30313A3136203136
        3A34343A33340004000090070004000000303232309092020004000000373334
        0002A0040001000000C300000003A00400010000003600000000000000FFDB00
        4300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E
        1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E33
        3432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232
        3232323232323232323232323232323232323232323232323232323232323232
        32323232323232FFC0001108003600C303012200021101031101FFC4001F0000
        010501010101010100000000000000000102030405060708090A0BFFC400B510
        0002010303020403050504040000017D01020300041105122131410613516107
        227114328191A1082342B1C11552D1F02433627282090A161718191A25262728
        292A3435363738393A434445464748494A535455565758595A63646566676869
        6A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7
        A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2
        E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301010101010101
        01010000000000000102030405060708090A0BFFC400B5110002010204040304
        0705040400010277000102031104052131061241510761711322328108144291
        A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738
        393A434445464748494A535455565758595A636465666768696A737475767778
        797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4
        B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9
        EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28A2800A28AA
        BA86A36DA65AB5C5D481235FCC9F403B9A52928ABBD869393B22D1200C938AE7
        B52F17E9F64E628375DCE382B111B47D5BA0AC0B9BCD7BC58E63B281EDEC0F19
        276861FED377FA0E2AD597C3E89541BDBC673DD211B47E6735E6CF155EAE9868
        E9DDFE87A10C350A5AE225AF65FA99D77E2BBDBA3F35FC76687F82D63323FF00
        DF4702B39AE74A9DB37775ACCCC7AB164FE449AEE62F0668918C1B42FEEF2B1F
        EB4CB8F04E8D329090C909F58E43FD735CB3C16327AC9A7EADFF00C31D30C661
        21A4535E897FC39C9DB689A56A876E99AB48973FC30DCA6D27F11FD3352E99AB
        EA9E1ED5D2C75067680B0564918B6013C329F4AA5AEF876E7409A39565F32066
        FDDCCBC156EA33E87DEB7AF6DDB5FB5F0F4CC3FD2256FDE1C7F081963FA7EB5C
        F4A128C9DA3CB38DB6D99BD59C5C5733E684AFBEE8EDC10466969ABD29D5F488
        F9E0A28A2980514514005145140051451400514514005145140051451400138A
        6472C728CC6EAE01C654E79A6DCC42E2DE484B1512295241E464638AC8F0EF87
        86830CE82E5A6F3581FBBB40C7B7AD67294D4D24B4EE5A8C5C5B6F5EC69DCDFD
        B5AB2A4B322CAFF710B0DCDF41DEB24E8EB7770751D6995F60CC7013FBA857DF
        FBC7D4F4ACCD4FC3C9E22D6E5B9B6BE50B0388671B72559403853EB823E87F1A
        E8B55D38EA5A4CF641F6191301BD0D6125526E4A70D16DE66C9C20A2E13D5EFE
        44B657F657B113653C52A2707CB39C54375AEE9967762D6E2F238E738F949E99
        F5F4FC6B2BC31E19B8D164B896E674779542858F380073939ACAD67C197D7BAC
        CD716F2C5E4CEDB8972729D33C77ACE55B12A929287BDD8D63470EEB38B9FBBD
        19D8DFEA16BA65A9B8BB94471838CE3249F403B9A8B4CD6AC7578DDECE6DDB3E
        F291865FC0D64F893409F51D1EDE0B470D2DB1040738DFC63AFAD54F097876F3
        4B967B9BCC46D22796B1AB6E38CE724F4A72AD88F6EA0A1EEF72552A1EC1CDCB
        DEEC33C51E21D2EF2C6E74C490B4C485126DF915830EA7DAB52E2F34EF0DE976
        CF292E52311441796618E71F9039FA57127C27A9CD7256D5127B7663B2E55C6C
        233D4F7AE83C4FE1DBB9B4CB01681AE1AD23F2D907DE6181C81DFA74AE38D5C4
        BF695250F7968B4FEAE75CA961BF774D4F47ABD7FAB1B1A2F8A6CB5999A04578
        67033B24C723DB15B82BCF7C23A06A11EB11DEDC4125BC7083FEB060B1231C03
        DB9AF43AEEC0D5AB569735556671E369D2A7579693BA0A28A2BB0E40A28A2800
        A28A2800A28A2800A28A2800A28A85EEA08E6585E54591FEEA93C9A009A8A28A
        00435877FE204B7BEBCB484077B2B26BB9FF00D9EBB17EA76B1FC07AD6D9E95E
        33A578960D37E2BF88ED7597096BA8486DCBC870ABB784C9ECA54E33EE2B6A34
        DCEEFB18D5A9C965DCD8F83DE228EFF4DBDD3EE66CEA02E1EE8863CC8AF8248F
        5C3673F515EA02BE6DF11F8375BF06EABF6BB2170D668FBEDAFADB3F2AF6C91F
        7481C7A1AD0D3FE31F892CE358EE3EC5798E374D1956FCD481FA57655C1BAAFD
        A51774CE5A78AF66B92AAD4FA0A909AF114F8BFE27BD422CB46B427BBAC72381
        F8E703F1AC69FC57E3AF13DD7D82D6F269246E0C1A780A147FB4EBD07D5AB258
        0A9F69A46AF190E89B3DAF5EF17E89E1C889D46FA3497191027CF237D1473F9F
        15CC69B7DACFC4293CE7864D2FC320FDDDD89AF7D8B0E89EB8EBD3279C66F84F
        E11C56F2ADFF0089645BAB82770B50C5901FF6DBF8CFB74FAD7AA22246811142
        AA8C003A0159CFD953D21ABEFF00E45C154A9ACF45D848E28E18D23891511005
        55518000E800AE63E23BB47F0FF577462AC2252194E08F9D7BD7555CFF008DB4
        BBAD67C21A8E9F648AF733A054566DA09DC0F5FC2B1A4D29A6FB9AD44F91A479
        2F84BC5FA8F877C1BAAEAAB8BC9CDFC311FB53B37050FBE7B569C9F173C4E74A
        8F508BC3D02DA86D925CB2C8D116CF4078C761D4F355EDFE1C78953C117DA635
        A43F6A96FA29D17CF5C1455209CFD71C574B27847586F83D1F874411FF006902
        098FCD1B47EFB7FDEE9D2BD19CB0EE57693BBFC0E082ADCB6575A15756F8AD77
        0785747D5ECAC2DCC978F2C73452B3108C98E846339CE6B32EFE2DF896DA0B5B
        D7F0EC30594E06C926F30094E39DADD3D71C1FC6AB5EFC38F12CFE0CD2B4E4B4
        84DCDBDCCF248BF685002B6DDBCFE06BA6F18784758D63C09A169567046F7769
        E579CAD285036C454E09EBCD4AFABC5A564F57D4A6F10EEF55A1A1ACF8DF508B
        C3DA66A5A2E8C6EBEDD1094B4D20448781F29391939CFA74AE5EFF00E27789B4
        74826BDB6D027494E0C56B75BE45EFCE18E3EBEB59FE20F86BE26BBD37443043
        14CD6B64B6F2DBF9CA0C6C1892467820E474F4A7EA5E00F12EABA4C690787344
        D2CC6E098EDDC0964E08C9724F03D33CE7DA9D3861D25769FF005EBFA04E75DE
        C994BE28EBA35A83C3DA9DA99618EE6CDE4D9BC8DA770C838EB839AF59B1BE9A
        C3C07657905AC97B34761132C08D8691B62F193D3DCFA66BCD35BF875E25BFD0
        3C3D690DA4466B2B79229C1B851825F231EBC568B785FC75A9F832EF43D49E25
        31F926D009502B226418D8AFE041391C7353515394231525A3FC2E10752336DC
        5EA87BFC41F187D9E7BA7B2F0FDA470E4F9571763CC6006781BF9FEB59BACF8F
        25F17FC38D57CCB716B796935BEFF29CED6567E08EE39078FA543A2780BC4D6F
        67258CBE19D192472DFF00130BC2B23C608EC013923B714DD37E1BF89EDBC35A
        DD8C967089AEFECE6202E1483B1C96C9CFA1AD52C3C75BABA6BFADD90DD67A6B
        6686F85FC5DE2CD27C1BBF4BD152E6C2D1E469AEE72CD9C9C9E3703819E7AFE1
        5BC7E31E7C29F6F5D357FB445C081A2321F2C654B07CE338E0F1ED59B69E19F8
        8FA4F8624D12D21B37B4B90E1D04A86488370C371207239EFD6AD69FF0DF5FD2
        3C253C76E74CB8BFB9955E7B5B98C491EC50428048E18124E7DFAF14A6B0EDB7
        2B6FD1FE6387B64928DF6EABF21907C4AF15CF6D05D430F87E7594FF00C7BA5C
        85953FDE52E08E95E87A4C6FADC165ABDE59C96377D5A0670FB48E3861C10703
        FF00ADCD7905D7C3FF00135EDA2DBFFC225A7DB5C07CB5D437217239E36EF2B8
        FC3B57ABF803C3B77E18F0BC5A7DECE92CFE6348421255377F0827FCE49AC713
        1A4A3785AFE5FF000E6D8795472B4AF63A8A28A2B80EC12B82F1B7C34B3F14DC
        9BFB69FEC7A8950ACE57724B8E9B87AE38C8EDD8D1455D3A92A72BC599D48467
        1B491E6534FE2DF03DE1D360D70AAC670111CBC63E81C71F8574FA269DE37F14
        41F68FEDAD3204EEFF00628CBFFE8BFEB4515ECD6495353B2BFA1E5D26DCF96F
        A7A9D25AFC31B59DC3EBFAC6A1ABB29FF54F218E2FFBE41FEB5DA69DA658E956
        C2DAC2D21B6857F82240A3FF00AF4515E3CEACE7A499EA429C63B22E51451599
        A051451400514514005145140051451400514514005145140051451400628A28
        A0028A28A00FFFD9}
      ExplicitLeft = 779
    end
    object combobox_SoundCard: TComboBox
      Left = 8
      Top = 26
      Width = 160
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = combobox_SoundCardChange
    end
    object combobox_SoundFreq: TComboBox
      Left = 174
      Top = 26
      Width = 160
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = combobox_SoundFreqChange
    end
    object bStart: TButton
      Left = 560
      Top = 17
      Width = 100
      Height = 30
      Caption = 'Start'
      Enabled = False
      TabOrder = 2
      OnClick = bStartClick
    end
    object bStop: TButton
      Left = 668
      Top = 17
      Width = 100
      Height = 30
      Caption = 'Stop'
      Enabled = False
      TabOrder = 3
      OnClick = bStopClick
    end
    object eWorkTime: TEdit
      Left = 348
      Top = 26
      Width = 109
      Height = 21
      TabOrder = 4
      Text = '15'
    end
  end
  object Panel5: TPanel
    Left = 795
    Top = 86
    Width = 199
    Height = 553
    Align = alRight
    Alignment = taRightJustify
    BevelInner = bvLowered
    TabOrder = 2
    object Panel6: TPanel
      Left = 2
      Top = 2
      Width = 195
      Height = 199
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label15: TLabel
        Left = 44
        Top = 4
        Width = 97
        Height = 13
        Caption = #1041#1099#1089#1090#1088#1072#1103' '#1086#1094#1077#1085#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bBPF_Start: TButton
        Left = 6
        Top = 21
        Width = 181
        Height = 31
        Caption = 'Calculate FFT'
        Enabled = False
        TabOrder = 0
        OnClick = bBPF_StartClick
      end
      object listbox_DTFFreqs: TListBox
        Left = 0
        Top = 57
        Width = 199
        Height = 60
        ItemHeight = 13
        TabOrder = 1
        OnClick = listbox_DTFFreqsClick
      end
      object button_calcTau: TButton
        Left = 6
        Top = 123
        Width = 181
        Height = 31
        Caption = 'Calculate TAU'
        Enabled = False
        TabOrder = 2
        OnClick = button_calcTauClick
      end
      object button_StartDTFCalc: TButton
        Left = 6
        Top = 160
        Width = 181
        Height = 31
        Caption = 'Calculate DFT'
        Default = True
        Enabled = False
        TabOrder = 3
        OnClick = button_StartDTFCalcClick1
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 440
      Width = 195
      Height = 111
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 1
      object Label11: TLabel
        Left = 104
        Top = 33
        Width = 49
        Height = 13
        Caption = '( on Tau ) '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 4
        Top = 33
        Width = 62
        Height = 13
        Caption = 'Q-factor 1:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 103
        Top = 73
        Width = 56
        Height = 13
        Caption = '( Level 0.7) '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 3
        Top = 73
        Width = 62
        Height = 13
        Caption = 'Q-factor 2:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object e_Dobrotnost1: TEdit
        Left = 12
        Top = 52
        Width = 76
        Height = 15
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = '---------'
      end
      object e_Dobrotnost2: TEdit
        Left = 12
        Top = 92
        Width = 76
        Height = 15
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Text = '---------'
      end
      object Panel9: TPanel
        Left = 2
        Top = 2
        Width = 191
        Height = 25
        Align = alTop
        BevelInner = bvLowered
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
    end
    object mLog: TRichEdit
      Left = 2
      Top = 201
      Width = 195
      Height = 239
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvRaised
      BevelKind = bkSoft
      BorderStyle = bsNone
      Color = clSkyBlue
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'qweqwe')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 86
    Width = 795
    Height = 553
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = '    RAW data   '
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Chart4: TChart
        Left = 0
        Top = 0
        Width = 787
        Height = 525
        Legend.Visible = False
        Title.AdjustFrame = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        View3D = False
        Zoom.Pen.Color = clBlack
        Align = alClient
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
        object Series5: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '    FFT transform    '
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Chart5: TChart
        Left = 0
        Top = 41
        Width = 787
        Height = 484
        Legend.Visible = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        OnScroll = Chart5AfterDraw
        OnUndoZoom = Chart5AfterDraw
        OnZoom = Chart5AfterDraw
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMaximum = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.Maximum = 0.319999999999999800
        DepthAxis.Minimum = -0.680000000000000300
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 0.319999999999999800
        DepthTopAxis.Minimum = -0.680000000000000300
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Maximum = 359.149999999999900000
        LeftAxis.Minimum = -48.350000000000160000
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        View3D = False
        Zoom.Pen.Color = clBlack
        OnAfterDraw = Chart5AfterDraw
        Align = alClient
        Color = clWhite
        TabOrder = 0
        object LineSeries1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object LineSeries2: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clBlue
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series4: TPointSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Callout.Distance = 10
          Marks.Style = smsXValue
          Marks.Visible = True
          SeriesColor = clYellow
          ClickableLine = False
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object panel_FFt_param: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 41
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 1
        object checkbox_isLogarithmicScale: TCheckBox
          Left = 18
          Top = 13
          Width = 129
          Height = 17
          Caption = 'Logarithmic scale'
          TabOrder = 0
          OnClick = checkbox_isLogarithmicScaleClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = '    TAU    '
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 43
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 0
        object Label17: TLabel
          Left = 46
          Top = 13
          Width = 92
          Height = 13
          Caption = 'Begin interval [sec]'
        end
        object Label18: TLabel
          Left = 253
          Top = 13
          Width = 84
          Height = 13
          Caption = 'End interval [sec]'
        end
        object edit_tau_t1: TEdit
          Left = 144
          Top = 10
          Width = 65
          Height = 21
          TabOrder = 0
        end
        object edit_tau_t2: TEdit
          Left = 343
          Top = 10
          Width = 65
          Height = 21
          TabOrder = 1
        end
        object Button1: TButton
          Left = 435
          Top = 7
          Width = 126
          Height = 25
          Caption = 'Clear Intervals'
          TabOrder = 2
          OnClick = Button1Click
        end
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 43
        Width = 787
        Height = 482
        ActivePage = TabSheet9
        Align = alClient
        TabOrder = 1
        object TabSheet7: TTabSheet
          Caption = '    Determination of TAU on demodulation    '
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Chart6: TChart
            Left = 0
            Top = 0
            Width = 779
            Height = 454
            Legend.Alignment = laBottom
            Legend.Font.Height = -15
            Legend.Font.Style = [fsBold]
            Legend.TextStyle = ltsPlain
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            DepthAxis.Automatic = False
            DepthAxis.AutomaticMaximum = False
            DepthAxis.AutomaticMinimum = False
            DepthAxis.Maximum = 0.229999999999999800
            DepthAxis.Minimum = -0.770000000000000400
            DepthTopAxis.Automatic = False
            DepthTopAxis.AutomaticMaximum = False
            DepthTopAxis.AutomaticMinimum = False
            DepthTopAxis.Maximum = 0.229999999999999800
            DepthTopAxis.Minimum = -0.770000000000000400
            LeftAxis.Automatic = False
            LeftAxis.AutomaticMaximum = False
            LeftAxis.AutomaticMinimum = False
            LeftAxis.Maximum = 104.261250000000000000
            LeftAxis.Minimum = -37.363750000000030000
            RightAxis.Automatic = False
            RightAxis.AutomaticMaximum = False
            RightAxis.AutomaticMinimum = False
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            Color = clWhite
            TabOrder = 0
            object Series3: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = 8567732
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries8: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              Title = #1042#1093#1086#1076#1085#1086#1081' '#1089#1080#1075#1085#1072#1083' ( '#1076#1077#1084#1086#1076#1091#1083#1103#1094#1080#1103' )'
              LinePen.Width = 2
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries14: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clNavy
              Title = #1040#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' '#1076#1077#1084#1086#1076#1091#1083#1103#1094#1080#1080
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = '    TAU log   '
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Chart8: TChart
            Left = 0
            Top = 0
            Width = 779
            Height = 454
            Legend.Alignment = laBottom
            Legend.Font.Height = -16
            Legend.Font.Style = [fsBold]
            Legend.TextStyle = ltsPlain
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            Color = clWhite
            TabOrder = 0
            object LineSeries11: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              Title = #1042#1093#1086#1076#1085#1086#1081' '#1089#1080#1075#1085#1072#1083' ( '#1076#1077#1084#1086#1076#1091#1083#1103#1094#1080#1103' )'
              LinePen.Width = 2
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries12: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clNavy
              Title = #1040#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' '#1076#1077#1084#1086#1076#1091#1083#1103#1094#1080#1080
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = '    PLL frequency  '
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Chart7: TChart
            Left = 0
            Top = 0
            Width = 779
            Height = 454
            Legend.Visible = False
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            View3D = False
            Zoom.Pen.Color = clBlack
            Align = alClient
            Color = clWhite
            TabOrder = 0
            object LineSeries9: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = 4227327
              LinePen.Width = 2
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
            object LineSeries10: TLineSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              SeriesColor = clNavy
              LinePen.Width = 2
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.Name = 'X'
              XValues.Order = loAscending
              YValues.Name = 'Y'
              YValues.Order = loNone
            end
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = '    DFT    '
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 62
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 0
        object Label10: TLabel
          Left = 510
          Top = 38
          Width = 60
          Height = 13
          Caption = 'Frequency 2'
        end
        object Label7: TLabel
          Left = 510
          Top = 11
          Width = 60
          Height = 13
          Caption = 'Frequency 1'
        end
        object Label9: TLabel
          Left = 657
          Top = 38
          Width = 12
          Height = 13
          Caption = #1043#1094
        end
        object Label8: TLabel
          Left = 657
          Top = 11
          Width = 12
          Height = 13
          Caption = #1043#1094
        end
        object button_StopDTFCalc: TButton
          Left = 690
          Top = 7
          Width = 90
          Height = 49
          Caption = 'STOP'
          Default = True
          Enabled = False
          TabOrder = 0
          OnClick = button_StopDTFCalcClick
        end
        object e_Freq1: TEdit
          Left = 575
          Top = 8
          Width = 76
          Height = 21
          TabOrder = 1
          Text = '0'
        end
        object e_Freq2: TEdit
          Left = 575
          Top = 35
          Width = 76
          Height = 21
          TabOrder = 2
          Text = '0'
        end
      end
      object Chart2: TChart
        Left = 0
        Top = 62
        Width = 787
        Height = 463
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Legend.Visible = False
        Title.AdjustFrame = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMaximum = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.Maximum = 1.069999999999978000
        DepthAxis.Minimum = 0.069999999999977550
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 1.069999999999978000
        DepthTopAxis.Minimum = 0.069999999999977550
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Maximum = 669.849999999996000000
        LeftAxis.Minimum = 314.849999999995800000
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        View3D = False
        View3DWalls = False
        Zoom.Pen.Color = clBlack
        Align = alClient
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 1
        object lsDPF: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Style = smsXValue
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series2: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clYellow
          LinePen.Visible = False
          Pointer.HorizSize = 8
          Pointer.InflateMargins = True
          Pointer.Pen.Width = 3
          Pointer.Style = psStar
          Pointer.VertSize = 8
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series6: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = -1
          LinePen.Width = 2
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series7: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 168
    Top = 184
  end
  object PopupMenu1: TPopupMenu
    Left = 88
    Top = 184
    object N1: TMenuItem
      Caption = 'Load data'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'Save data'
      OnClick = N2Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 128
    Top = 184
  end
end
