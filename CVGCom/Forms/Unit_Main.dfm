object form_Main: Tform_Main
  Left = 0
  Top = 559
  Caption = 'form_Main'
  ClientHeight = 459
  ClientWidth = 978
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 978
    Height = 56
    AutoSize = True
    ButtonHeight = 28
    ButtonWidth = 242
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
      DropdownMenu = pmFile
      Grouped = True
      ImageIndex = 0
    end
    object tbDeviceAndPortSetting: TToolButton
      Left = 71
      Top = 0
      Action = Action_DeviceParam
      AutoSize = True
      Grouped = True
    end
    object tbDeviceAndPortSetting_RSSwitch: TToolButton
      Left = 317
      Top = 0
      Action = Action_DeviceParamSW
      AutoSize = True
      Grouped = True
      Wrap = True
    end
    object tbAnalisys: TToolButton
      Left = 0
      Top = 28
      AutoSize = True
      Caption = '  Analysis   '
      Grouped = True
      ImageIndex = 2
      OnClick = Action_GraphsExecute
    end
    object tbAllan: TToolButton
      Left = 103
      Top = 28
      Action = Action_AllanCalculate
      AutoSize = True
      Grouped = True
    end
    object tbTools: TToolButton
      Left = 272
      Top = 28
      AutoSize = True
      Caption = '  Tools  '
      DropdownMenu = pmTools
      Grouped = True
      ImageIndex = 5
    end
    object tbWindow: TToolButton
      Left = 347
      Top = 28
      AutoSize = True
      Caption = '   Help   '
      Enabled = False
      Grouped = True
      ImageIndex = 4
    end
  end
  object Panel_Info: TPanel
    Left = 0
    Top = 56
    Width = 978
    Height = 43
    Align = alTop
    BevelInner = bvLowered
    Color = 13291733
    ParentBackground = False
    TabOrder = 1
    object Image2: TImage
      Left = 696
      Top = 2
      Width = 280
      Height = 39
      Cursor = crHandPoint
      Align = alRight
      AutoSize = True
      Picture.Data = {
        0A544A504547496D616765E8090000FFD8FFE000104A46494600010101006000
        600000FFE100B845786966000049492A00080000000500120103000100000001
        00C04E310102001C0000004A0000003201020014000000660000001302030001
        0000000100000069870400010000007A00000000000000414344205379737465
        6D73204469676974616C20496D6167696E6700323030353A31323A3037203138
        3A30313A30350004000090070004000000303232309092020004000000353030
        0002A00400010000008D00000003A00400010000002700000000000000FFDB00
        4300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E
        1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E33
        3432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232
        3232323232323232323232323232323232323232323232323232323232323232
        32323232323232FFC00011080027011803012200021101031101FFC4001F0000
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
        EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F5214E14D14E1599
        63C53C53053C5021E29C29A29C2980F14F14C14F14C43C53C53053C5003853C5
        3053C508078A78A60A78A603969EB4C5A7AD021EB4B483A52D300A2933556F2E
        FECD01654691FA2A2F563E952DD95D8D26C75DDE4165034D7122C71AF56638AE
        3EFF00C6D24F29874C858F6DE50B13F45FF1AD25F0EC9A95C2DD6B73F9841CA5
        B4648441F5EAC7DF8ADEB7B3B4B3411DBC1144BE88A05724D56ABB3E55F89D30
        74A9FC4B99FE079BCF36AB72CD25D586A1703FDB6751F82A802AAC72E96F3795
        77632DA1CE0C91CA495FA83DABD59A6895D519D43374527935CE78B6C6CEEB4E
        91DDA25BA45262E406623F87DF3D315C75704E31E752BBF33AE963537C8E364F
        B5CCDD05AF34AD7BFB31E533DB4B1992263C8C7623D3B8C57702B9DB18AD3481
        693EA1711C72A5B2C0BBD80C773FD3F2AE852449543A302A790477AEEC247963
        CB7F97638710F9A5CD6F9F71F451457598051451400514514005145140051451
        401C90A70A68A70ACCB1E29E29829E2810F14E14D14E14C078A78A60A78A621E
        29E29829E2801C29E29829E28403C53C53053C5301CB4F14C5A78A043874A752
        2D14019569A74F6DA95DDCCB7D2CB14C46C85BA47F4ACFD1EC5EEB549B598750
        69ECA704471E4E08CE3E98E38F635535ED6A6935CB9D02CDCADC0D2E6B85C1E5
        A43F2A01F4E4FE55C7FC3AF88DA7E9FA543A26B32FD95ADF2914AE0ED2B93C37
        F748E9CF14D611CA3749E9AFDE43C4A8CACDEFA1DF3E8178FE284D505E91001C
        C7CE7A631E98EF55AF7C377D71E278F518EEC0894A923277003A81DB9FEB5A43
        C59E1F68FCC1ADE9DB319CFDA53FC6B1354F8A3E17D351B66A1F6B907F05B297
        CFFC0BEEFEB59FD4B9B4B3DEE6DF5BE5D6EB6B06B9E17D46FF005F5BC8A7458B
        E5F98B10D1E3D3F9FE35575CD06EB5BD61A5B09A39910089CB363CA23A8FEBC5
        57B0D4BC4FE3D60D1472687A137DE981FDFDC2FA21FE107FBC3F026BBDD3EC6D
        B4CB38AD2D2258E08D76AAAFF9E4FBF7ACAA6029ABA7BB7734A78DA8DA6B64AC
        709E2CD22E565B594DC4442C4222659550E4724FCC46735D6786EC9F4FD12086
        6915980CFCAD90327381F9D707F1C31FD83A7671FF001F2DD7FDC6ACA8A7F106
        AFE37D4746B1D7EE2C6DE0B5591557E60A02270A38C72DD7EB5D1432D847F7A9
        D9B39EB661292F64D688F69CD266BE7B6F1878864F055B4C356B85B85D49A0F3
        837CCC9B0300C7BE0935D0C7AC6BDE16F1EAD8EA3AE5C5FDB4968F7130641818
        476F957B60A76C6735D4F0CD75D4E7FACAEC7B2645539F55B0B6B98EDA7BD822
        9E4C7971BC8033678E07535E0D378A354B9D2EEB52875DD4965593E432EA11C6
        7B7020504B75ED81F9526A3AE3DDEB7E0DD6354994308A3926948E30B3302C40
        F619A3EACD6EC5F595D11F436454173796F670B4D733470C2BF7A49182A8FC4D
        793F8BBC5E6F3C456763A76AB7D140D02CBFB99E3B78DC32EE07CD6C91C63A8F
        D6B959BC45A9DDE97E24D2AE6FDEEED23816488C93898A112A0E24006EE1BA8E
        38E288E19B49DC72C4A4EC8FA120B986EA159A0952489C655D1B2187B1A9735F
        3B2EBD7BA3F87B46BAD2FC533CF79B84674D18D91A8CE14AF7EC39EB9E2AEEAB
        AFEBADACEA2F2EB724891EE648ECB50483C800F20A30CB11D0AF5C8A7F54937A
        327EB4ADB1ED171AF59DBEBF67A33F99F6ABA8DE44C212A02FA9E9EBF97B8A2B
        96F8793DA788B4B83589C4D73A85A33DBADCDCA2F9801009195E1873D7AF2DEA
        68AE5A89C25CA7541A92B9A229C28A2B3341E29E28A2810F14E14514C078A78A
        28A621E29E28A2801C29E28A28403C53C5145301CB4F5A28A043D68A28A6079D
        78EFC1DAB5E6B76BE22F0F5C2C7A8DBA8428CD8DC0670413C772083C115E717F
        A85BEADA83C7AB785E33AA17C493595E793BDBD4821949F7A28AF430AF9B4679
        D89569686D587C2EBDBFC38D2E0B18C9CEFBBBD33B63D9630A3F335DD685F0C3
        43D2A44B8BA5FB7DC29CA995008D0FFB318E3F1393EF4515856C4547A5CE8A54
        6164EC7701428C01C52D145731D254BBD3EC750511DEDA4170AA77059A30E01F
        C6923D334F8AE5AE63B2B64B875DAD22C4A19871C13DFA0A28A2EC56443FD81A
        3F9421FECAB1F2C3F9813ECE9B777AE31D7DEA77D32C24BB5BB7B2B76B951B56
        631297039E3775EE7F3A28A2EC3951563F0DE8713398F46D3D1A40558ADB20DC
        3D0F14E7F0FE8D22C68FA4D8B2A0C2036E8428CE78E38E49A28A399872A126F0
        E68972B1ACDA45848B10DB187B643B07A0E3814E3A0E904C84E97644B808E4DB
        AFCC38C03C72381F951451CCC395089A068F14C93C7A55924B1E3648B02865C7
        4C1C714DBBF0DE897D399EEF49B29E53D5E581589FC48A28A7CD2BEE1CB1EC5E
        B7B582CE0582DA18E1897EEA46A140FC0514514867FFD9}
      ExplicitLeft = 500
    end
    object Image1: TImage
      Left = 2
      Top = 2
      Width = 280
      Height = 39
      Align = alLeft
      AutoSize = True
      Picture.Data = {
        0A544A504547496D6167654C040000FFD8FFE000104A46494600010101006000
        600000FFE100B845786966000049492A00080000000500120103000100000001
        000000310102001C0000004A0000003201020014000000660000001302030001
        0000000100000069870400010000007A00000000000000414344205379737465
        6D73204469676974616C20496D6167696E6700323030353A31323A3037203138
        3A30313A30350004000090070004000000303232309092020004000000353030
        0002A00400010000008D00000003A00400010000002700000000000000FFDB00
        4300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E
        1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E33
        3432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232
        3232323232323232323232323232323232323232323232323232323232323232
        32323232323232FFC00011080027011803012200021101031101FFC4001F0000
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
        EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA28A2800A28A2
        800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A28011A98D
        4F3D298D400C6A69A73534D201869869E6986818C34D34E34D348061A61A79A6
        1A0061A61A79A61A0069A61A79A61A431869869E6986900D345068A0675B4514
        5684051451400514514005145140051451400514514005145140051451400514
        51400D6A69A7B530D2018D4D34E6A69A0061A61A79A61A0630D34D38D34D2018
        69869E6986801869869E6986801A69869E698690C61A61A79A61A4034D141A28
        19D6D14515A10145145001451450014514500145145001451450014514500145
        145001451450023531A8A28018D4D345148061A61A28A0630D34D14520186986
        8A2801869868A2801A69868A290C61A61A28A4034D145140CFFFD9}
    end
    object bStop: TBitBtn
      Left = 220
      Top = 6
      Width = 181
      Height = 31
      Caption = 'STOP sampling process'
      DoubleBuffered = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        8E0B0000424D8E0B00000000000036000000280000002C000000160000000100
        180000000000580B000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5EA2DB5EA2DB2A84D01378CC1378CC2A84
        D05EA2DB5EA2DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9D9D9D9D9D9D7D7D7D707070707070
        7D7D7D9D9D9D9D9D9DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF5EA2DB1378CC469AD865A8E055AFE555AFE535
        A2E31B8BDD1B8BDD117ED8117ED85EA2DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9D9D9D7070708F8F8FA3A3A39D9D9D9D9D
        9D8C8C8C7C7C7C7C7C7C7575757575759D9D9DFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF046EC55EA2DBA5D1EF77C4EB77C4EB55AFE5
        35A2E32996DE2996DE2996DE2996DE2A84D0117ED8117ED8FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6565659D9D9DCACACAB1B1B1B1B1B19D
        9D9D8C8C8C8484848484848484848484847D7D7D757575757575FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1378CC86BAE6E3F3FBA5D1EF77C4EB35A2
        E335A2E335A2E33FAFEA35A2E335A2E335A2E335A2E32996DE1B8BDD117ED8FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF707070B6B6B6EFEFEFCACACAB1B1B1
        8C8C8C8C8C8C8C8C8C9595958C8C8C8C8C8C8C8C8C8C8C8C8484847C7C7C7575
        75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF046EC586BAE6E3F3FBA5D1EF55AFE535
        A2E33FAFEA3FAFEA3FAFEA3FAFEA4CB3EA3FAFEA3FAFEA35A2E335A2E32996DE
        1B8BDD117ED8FFFFFFFFFFFFFFFFFFFFFFFF656565B6B6B6EFEFEFCACACA9D9D
        9D8C8C8C9595959595959595959595959B9B9B9595959595958C8C8C8C8C8C84
        84847C7C7C757575FFFFFFFFFFFFFFFFFF5EA2DB65A8E0ECF6FCA5D1EF57BBED
        3FAFEA4CB3EA4CB3EA57BBED57BBED57BBED57BBED57BBED4CB3EA4CB3EA3FAF
        EA3FAFEA35A2E32996DE5EA2DBFFFFFFFFFFFF9D9D9DA3A3A3F4F4F4CACACAA2
        A2A29595959B9B9B9B9B9BA2A2A2A2A2A2A2A2A2A2A2A2A2A2A29B9B9B9B9B9B
        9595959595958C8C8C8484849D9D9DFFFFFFFFFFFF1378CCB9E4F7A5D1EF77C4
        EB3FAFEA57BBED57BBED57BBED57BBED57BBED57BBED57BBED57BBED57BBED57
        BBED57BBED4CB3EA4CB3EA469AD81B8BDDFFFFFFFFFFFF707070D8D8D8CACACA
        B1B1B1959595A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2
        A2A2A2A2A2A2A29B9B9B9B9B9B8F8F8F7C7C7CFFFFFF7CB9EE65A8E0ECF6FCAB
        DFF64CB3EA57BBED57BBED004080004080004080004080004080004080004080
        00408073CDF561C2F161C2F157BBED77C4EB2899F266B5EDB5B5B5A3A3A3F4F4
        F4D1D1D19B9B9BA2A2A2A2A2A240404040404040404040404040404040404040
        4040404040B4B4B4A9A9A9A9A9A9A2A2A2B1B1B18D8D8DAAAAAA5EA2DB86BAE6
        DCF4FC7FCAEE57BBED66B5ED6DC3F10040800040800040800040800040800040
        8000408000408073CDF573CDF56DC3F177C4EB77C4EB66B5ED2996DE9D9D9DB6
        B6B6ECECECB7B7B7A2A2A2AAAAAAAFAFAF404040404040404040404040404040
        404040404040404040B4B4B4B4B4B4AFAFAFB1B1B1B1B1B1AAAAAA8484842A84
        D0D1ECF8D1ECF877C4EB57BBED6DC3F17BCDF300408000408000408000408000
        408000408000408000408098D9F686D5F786D5F773CDF590CEF688CEF12996DE
        7D7D7DE5E5E5E5E5E5B1B1B1A2A2A2AFAFAFB7B7B74040404040404040404040
        40404040404040404040404040C7C7C7BFBFBFBFBFBFB4B4B4C3C3C3BDBDBD84
        8484117ED8ECF6FCC3EAF977C4EB6DC3F17BCDF386D5F7004080004080004080
        00408000408000408000408000408098D9F698D9F686D5F786D5F7A5D1EFABDF
        F62996DE757575F4F4F4DEDEDEB1B1B1AFAFAFB7B7B7BFBFBF40404040404040
        4040404040404040404040404040404040C7C7C7C7C7C7BFBFBFBFBFBFCACACA
        D1D1D1848484117ED8ECF6FCB9E4F77BCDF37FCAEE86D5F798D9F60040800040
        8000408000408000408000408000408000408098D9F698D9F698D9F698D9F6B9
        E4F7B9E4F72996DE757575F4F4F4D8D8D8B7B7B7B7B7B7BFBFBFC7C7C7404040
        404040404040404040404040404040404040404040C7C7C7C7C7C7C7C7C7C7C7
        C7D8D8D8D8D8D8848484469AD8C3EAF9C3EAF988CEF188CEF198D9F6ABDFF600
        4080004080004080004080004080004080004080004080B9E4F7B9E4F798D9F6
        ABDFF6B9E4F7ABDFF62996DE8F8F8FDEDEDEDEDEDEBDBDBDBDBDBDC7C7C7D1D1
        D1404040404040404040404040404040404040404040404040D8D8D8D8D8D8C7
        C7C7D1D1D1D8D8D8D1D1D184848465A8E0A5D1EFD1ECF898D9F698D9F6B9E4F7
        B9E4F7004080004080004080004080004080004080004080004080CCEFFBC3EA
        F9C3EAF9B9E4F7D1ECF890CEF65EA2DBA3A3A3CACACAE5E5E5C7C7C7C7C7C7D8
        D8D8D8D8D8404040404040404040404040404040404040404040404040E4E4E4
        DEDEDEDEDEDED8D8D8E5E5E5C3C3C39D9D9D7CB9EE65A8E0DCF4FCA5D1EFABDF
        F6B9E4F7C3EAF9004080004080004080004080004080004080004080004080D4
        F3FDD4F3FDD1ECF8D1ECF8E5E8F85EA2DB7CB9EEB5B5B5A3A3A3ECECECCACACA
        D1D1D1D8D8D8DEDEDE4040404040404040404040404040404040404040404040
        40E9E9E9E9E9E9E5E5E5E5E5E5EFEFEF9D9D9DB5B5B5FFFFFF2899F2ABDFF6D1
        ECF8B9E4F7C3EAF9CCEFFBE2F7FEE2F7FEE2F7FEE2F7FEE2F7FEE2F7FEE2F7FE
        E2F7FEE2F7FEDCF4FCDCF4FCDCF4FCB9E4F73DA3F4FFFFFFFFFFFF8D8D8DD1D1
        D1E5E5E5D8D8D8DEDEDEE4E4E4F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
        F0F0F0F0F0F0F0F0ECECECECECECECECECD8D8D8999999FFFFFFFFFFFF7CB9EE
        66B5EDC3EAF9B9E4F7B9E4F7CCEFFBD1ECF8DCF4FCDCF4FCE2F7FEE2F7FEE2F7
        FEE2F7FEE2F7FEE3F3FBE2F7FEE3F3FBE3F3FB7CB9EE7CB9EEFFFFFFFFFFFFB5
        B5B5AAAAAADEDEDED8D8D8D8D8D8E4E4E4E5E5E5ECECECECECECF0F0F0F0F0F0
        F0F0F0F0F0F0F0F0F0EFEFEFF0F0F0EFEFEFEFEFEFB5B5B5B5B5B5FFFFFFFFFF
        FFFFFFFF1B8BDD6DC3F1ABDFF6B9E4F7C3EAF9CCEFFBD4F3FDDCF4FCE2F7FEE2
        F7FEE2F7FEECF6FCE2F7FEECF6FCE3F3FBE3F3FB90CEF62899F2FFFFFFFFFFFF
        FFFFFFFFFFFF7C7C7CAFAFAFD1D1D1D8D8D8DEDEDEE4E4E4E9E9E9ECECECF0F0
        F0F0F0F0F0F0F0F4F4F4F0F0F0F4F4F4EFEFEFEFEFEFC3C3C38D8D8DFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF1B8BDD66B5EDA5D1EFB9E4F7B9E4F7CCEFFBD1ECF8
        DCF4FCDCF4FCE3F3FBE3F3FBE3F3FBE5E8F8DCF4FC88CEF13DA3F4FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7CAAAAAACACACAD8D8D8D8D8D8E4E4E4E5
        E5E5ECECECECECECEFEFEFEFEFEFEFEFEFEFEFEFECECECBDBDBD999999FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1B8BDD4CB3EA7FCAEEABDFF6B9E4
        F7C3EAF9D1ECF8D4F3FDD1ECF8DCF4FCD1ECF8B9E4F76DC3F12899F2FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C9B9B9BB7B7B7D1D1D1
        D8D8D8DEDEDEE5E5E5E9E9E9E5E5E5ECECECE5E5E5D8D8D8AFAFAF8D8D8DFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7CB9EE2899F23D
        A3F46DC3F188CEF1ABDFF6ABDFF698D9F67CB9EE57BBED2899F24CB3EAFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5B5B58D8D
        8D999999AFAFAFBDBDBDD1D1D1D1D1D1C7C7C7B5B5B5A2A2A28D8D8D9B9B9BFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF7CB9EE7CB9EE4CB3EA3DA3F43DA3F43DA3F47CB9EE7CB9EEFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFB5B5B5B5B5B59B9B9B999999999999999999B5B5B5B5B5B5FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnClick = bStopClick
    end
    object bStart: TBitBtn
      Left = 18
      Top = 6
      Width = 182
      Height = 31
      Caption = 'START sampling process'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        8E0B0000424D8E0B00000000000036000000280000002C000000160000000100
        180000000000580B000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5EA2DB5EA2DB2A84D01378CC1378CC2A84
        D05EA2DB5EA2DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9D9D9D9D9D9D7D7D7D707070707070
        7D7D7D9D9D9D9D9D9DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF5EA2DB1378CC469AD865A8E055AFE555AFE535
        A2E31B8BDD1B8BDD117ED8117ED85EA2DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9D9D9D7070708F8F8FA3A3A39D9D9D9D9D
        9D8C8C8C7C7C7C7C7C7C7575757575759D9D9DFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF046EC55EA2DBA5D1EF77C4EB77C4EB55AFE5
        35A2E32996DE2996DE2996DE2996DE2A84D0117ED8117ED8FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6565659D9D9DCACACAB1B1B1B1B1B19D
        9D9D8C8C8C8484848484848484848484847D7D7D757575757575FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1378CC86BAE6E3F3FBA5D1EF77C4EB35A2
        E335A2E335A2E33FAFEA35A2E335A2E335A2E335A2E32996DE1B8BDD117ED8FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF707070B6B6B6EFEFEFCACACAB1B1B1
        8C8C8C8C8C8C8C8C8C9595958C8C8C8C8C8C8C8C8C8C8C8C8484847C7C7C7575
        75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF046EC586BAE6E3F3FBA5D1EF55AFE535
        A2E33FAFEA3FAFEA3FAFEA3FAFEA4CB3EA3FAFEA3FAFEA35A2E335A2E32996DE
        1B8BDD117ED8FFFFFFFFFFFFFFFFFFFFFFFF656565B6B6B6EFEFEFCACACA9D9D
        9D8C8C8C9595959595959595959595959B9B9B9595959595958C8C8C8C8C8C84
        84847C7C7C757575FFFFFFFFFFFFFFFFFF5EA2DB65A8E0ECF6FCA5D1EF57BBED
        3FAFEA4CB3EA4CB3EA57BBED57BBED57BBED57BBED57BBED4CB3EA4CB3EA3FAF
        EA3FAFEA35A2E32996DE5EA2DBFFFFFFFFFFFF9D9D9DA3A3A3F4F4F4CACACAA2
        A2A29595959B9B9B9B9B9BA2A2A2A2A2A2A2A2A2A2A2A2A2A2A29B9B9B9B9B9B
        9595959595958C8C8C8484849D9D9DFFFFFFFFFFFF1378CCB9E4F7A5D1EF77C4
        EB3FAFEA4CB3EA4CB3EA57BBED61C2F161C2F161C2F161C2F161C2F161C2F157
        BBED57BBED4CB3EA4CB3EA469AD81B8BDDFFFFFFFFFFFF707070D8D8D8CACACA
        B1B1B19595959B9B9B9B9B9BA2A2A2A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9A9
        A9A2A2A2A2A2A29B9B9B9B9B9B8F8F8F7C7C7CFFFFFF7CB9EE65A8E0ECF6FCAB
        DFF64CB3EA57BBED57BBED6DC3F12A84D0469AD873CDF586D5F773CDF573CDF5
        73CDF573CDF561C2F161C2F157BBED77C4EB2899F266B5EDB5B5B5A3A3A3F4F4
        F4D1D1D19B9B9BA2A2A2A2A2A2AFAFAF7D7D7D8F8F8FB4B4B4BFBFBFB4B4B4B4
        B4B4B4B4B4B4B4B4A9A9A9A9A9A9A2A2A2B1B1B18D8D8DAAAAAA5EA2DB86BAE6
        DCF4FC7FCAEE57BBED66B5ED6DC3F173CDF50178C60A6A9E2A84D0469AD886D5
        F786D5F786D5F773CDF573CDF56DC3F177C4EB77C4EB66B5ED2996DE9D9D9DB6
        B6B6ECECECB7B7B7A2A2A2AAAAAAAFAFAFB4B4B46464645454547D7D7D8F8F8F
        BFBFBFBFBFBFBFBFBFB4B4B4B4B4B4AFAFAFB1B1B1B1B1B1AAAAAA8484842A84
        D0D1ECF8D1ECF877C4EB57BBED6DC3F17BCDF386D5F70367B70367B70367B703
        67B7356AA3469AD886D5F798D9F686D5F786D5F773CDF590CEF688CEF12996DE
        7D7D7DE5E5E5E5E5E5B1B1B1A2A2A2AFAFAFB7B7B7BFBFBF5D5D5D5D5D5D5D5D
        5D5D5D5D6C6C6C8F8F8FBFBFBFC7C7C7BFBFBFBFBFBFB4B4B4C3C3C3BDBDBD84
        8484117ED8ECF6FCC3EAF977C4EB6DC3F17BCDF386D5F786D5F70367B7024CAA
        024CAA054798054798023B84356AA34883B798D9F686D5F786D5F7A5D1EFABDF
        F62996DE757575F4F4F4DEDEDEB1B1B1AFAFAFB7B7B7BFBFBFBFBFBF5D5D5D56
        56565656564F4F4F4F4F4F4343436C6C6C808080C7C7C7BFBFBFBFBFBFCACACA
        D1D1D1848484117ED8ECF6FCB9E4F77BCDF37FCAEE86D5F798D9F6ABDFF6024C
        AA024CAA023B84023B84002C6E002C6E355E906793BA98D9F698D9F698D9F6B9
        E4F7B9E4F72996DE757575F4F4F4D8D8D8B7B7B7B7B7B7BFBFBFC7C7C7D1D1D1
        565656565656434343434343373737373737636363919191C7C7C7C7C7C7C7C7
        C7D8D8D8D8D8D8848484469AD8C3EAF9C3EAF988CEF188CEF198D9F6ABDFF6AB
        DFF6054798023B84002C6E002C6E355E906793BAC3EAF9B9E4F7B9E4F798D9F6
        ABDFF6B9E4F7ABDFF62996DE8F8F8FDEDEDEDEDEDEBDBDBDBDBDBDC7C7C7D1D1
        D1D1D1D14F4F4F434343373737373737636363919191DEDEDED8D8D8D8D8D8C7
        C7C7D1D1D1D8D8D8D1D1D184848465A8E0A5D1EFD1ECF898D9F698D9F6B9E4F7
        B9E4F7C3EAF9023B84002C6E355E9079A0BFCCEFFBD4F3FDD4F3FDCCEFFBC3EA
        F9C3EAF9B9E4F7D1ECF890CEF65EA2DBA3A3A3CACACAE5E5E5C7C7C7C7C7C7D8
        D8D8D8D8D8DEDEDE4343433737376363639C9C9CE4E4E4E9E9E9E9E9E9E4E4E4
        DEDEDEDEDEDED8D8D8E5E5E5C3C3C39D9D9D7CB9EE65A8E0DCF4FCA5D1EFABDF
        F6B9E4F7C3EAF9C3EAF9356AA388AFCDD4F3FDD4F3FDDCF4FCDCF4FCDCF4FCD4
        F3FDD4F3FDD1ECF8D1ECF8E5E8F85EA2DB7CB9EEB5B5B5A3A3A3ECECECCACACA
        D1D1D1D8D8D8DEDEDEDEDEDE6C6C6CABABABE9E9E9E9E9E9ECECECECECECECEC
        ECE9E9E9E9E9E9E5E5E5E5E5E5EFEFEF9D9D9DB5B5B5FFFFFF2899F2ABDFF6D1
        ECF8B9E4F7C3EAF9CCEFFBD4F3FDD4F3FDDCF4FCDCF4FCE2F7FEE2F7FEE2F7FE
        E2F7FEE2F7FEDCF4FCDCF4FCDCF4FCB9E4F73DA3F4FFFFFFFFFFFF8D8D8DD1D1
        D1E5E5E5D8D8D8DEDEDEE4E4E4E9E9E9E9E9E9ECECECECECECF0F0F0F0F0F0F0
        F0F0F0F0F0F0F0F0ECECECECECECECECECD8D8D8999999FFFFFFFFFFFF7CB9EE
        66B5EDC3EAF9B9E4F7B9E4F7CCEFFBD1ECF8DCF4FCDCF4FCE2F7FEE2F7FEE2F7
        FEE2F7FEE2F7FEE3F3FBE2F7FEE3F3FBE3F3FB7CB9EE7CB9EEFFFFFFFFFFFFB5
        B5B5AAAAAADEDEDED8D8D8D8D8D8E4E4E4E5E5E5ECECECECECECF0F0F0F0F0F0
        F0F0F0F0F0F0F0F0F0EFEFEFF0F0F0EFEFEFEFEFEFB5B5B5B5B5B5FFFFFFFFFF
        FFFFFFFF1B8BDD6DC3F1ABDFF6B9E4F7C3EAF9CCEFFBD4F3FDDCF4FCE2F7FEE2
        F7FEE2F7FEECF6FCE2F7FEECF6FCE3F3FBE3F3FB90CEF62899F2FFFFFFFFFFFF
        FFFFFFFFFFFF7C7C7CAFAFAFD1D1D1D8D8D8DEDEDEE4E4E4E9E9E9ECECECF0F0
        F0F0F0F0F0F0F0F4F4F4F0F0F0F4F4F4EFEFEFEFEFEFC3C3C38D8D8DFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF1B8BDD66B5EDA5D1EFB9E4F7B9E4F7CCEFFBD1ECF8
        DCF4FCDCF4FCE3F3FBE3F3FBE3F3FBE5E8F8DCF4FC88CEF13DA3F4FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7CAAAAAACACACAD8D8D8D8D8D8E4E4E4E5
        E5E5ECECECECECECEFEFEFEFEFEFEFEFEFEFEFEFECECECBDBDBD999999FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1B8BDD4CB3EA7FCAEEABDFF6B9E4
        F7C3EAF9D1ECF8D4F3FDD1ECF8DCF4FCD1ECF8B9E4F76DC3F12899F2FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C9B9B9BB7B7B7D1D1D1
        D8D8D8DEDEDEE5E5E5E9E9E9E5E5E5ECECECE5E5E5D8D8D8AFAFAF8D8D8DFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7CB9EE2899F23D
        A3F46DC3F188CEF1ABDFF6ABDFF698D9F67CB9EE57BBED2899F24CB3EAFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5B5B58D8D
        8D999999AFAFAFBDBDBDD1D1D1D1D1D1C7C7C7B5B5B5A2A2A28D8D8D9B9B9BFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF7CB9EE7CB9EE4CB3EA3DA3F43DA3F43DA3F47CB9EE7CB9EEFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFB5B5B5B5B5B59B9B9B999999999999999999B5B5B5B5B5B5FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 1
      OnClick = bStartClick
    end
    object panel_ExternalDeviceCommand: TPanel
      Left = 416
      Top = 6
      Width = 348
      Height = 31
      BevelInner = bvLowered
      TabOrder = 2
      Visible = False
      object button_ResetIntegrator: TButton
        Left = 184
        Top = 5
        Width = 94
        Height = 21
        Caption = 'Reset Integrator'
        TabOrder = 0
        OnClick = button_ResetIntegratorClick
      end
      object button_Calibrate: TButton
        Left = 281
        Top = 5
        Width = 61
        Height = 21
        Caption = 'Calibrate'
        TabOrder = 1
        OnClick = button_CalibrateClick
      end
      object RadioButton1: TRadioButton
        Left = 6
        Top = 7
        Width = 82
        Height = 17
        Caption = 'Integrate'
        TabOrder = 2
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 94
        Top = 7
        Width = 82
        Height = 17
        Caption = 'Increment'
        TabOrder = 3
        OnClick = RadioButton2Click
      end
    end
  end
  object panel_ChartManager: TPanel
    Left = 0
    Top = 99
    Width = 978
    Height = 334
    Align = alClient
    BevelInner = bvLowered
    Color = 12615680
    TabOrder = 2
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 433
    Width = 978
    Height = 26
    Panels = <
      item
        Width = 140
      end
      item
        Width = 75
      end
      item
        Width = 40
      end
      item
        Width = 186
      end
      item
        Width = 110
      end
      item
        Width = 190
      end
      item
        Width = 230
      end
      item
        Width = 50
      end>
    object lUrl: TLabel
      Left = 13
      Top = 6
      Width = 116
      Height = 14
      Cursor = crHandPoint
      Hint = 'http://www.innalabs.com'
      Caption = 'www.innalabs.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object lCountData: TLabel
      Left = 263
      Top = 6
      Width = 175
      Height = 14
      Hint = 'Packed count'
      Alignment = taCenter
      AutoSize = False
      Caption = 'Packed count = xxxxxxxxxx'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object lComName: TLabel
      Left = 159
      Top = 6
      Width = 42
      Height = 14
      Caption = 'COMxx'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
    end
    object lPackedLength: TLabel
      Left = 221
      Top = 6
      Width = 32
      Height = 14
      Hint = 'Packed length'
      Alignment = taCenter
      AutoSize = False
      Caption = 'xx'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object lTimeElabsed: TLabel
      Left = 455
      Top = 6
      Width = 84
      Height = 14
      Hint = 'Elapsed time | hhh : mm : ss : msec'
      Alignment = taCenter
      Caption = '00:00:00:000'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object labelFalsPacked: TLabel
      Left = 748
      Top = 6
      Width = 218
      Height = 14
      Hint = 'Count error packed / '
      AutoSize = False
      Caption = '   CEP / CWV = xxxxx'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object ProgressBar1: TProgressBar
      Left = 559
      Top = 6
      Width = 179
      Height = 17
      Smooth = True
      TabOrder = 0
    end
    object panel_error: TPanel
      Left = 3
      Top = 3
      Width = 8
      Height = 22
      BevelInner = bvLowered
      Caption = 'DATA ERROR'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object Timer_onIdleTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer_onIdleTimerTimer
    Left = 40
    Top = 104
  end
  object ActionList1: TActionList
    Left = 120
    Top = 104
    object Action_Start: TAction
      Caption = 'Action_Start'
      ShortCut = 116
      OnExecute = Action_StartExecute
    end
    object Action_Stop: TAction
      Caption = 'Action_Stop'
      ShortCut = 117
      OnExecute = Action_StopExecute
    end
    object Action_DeviceParam: TAction
      Caption = '   Device and Port Settings    '
      ShortCut = 118
      OnExecute = Action_DeviceParamExecute
    end
    object Action_DeviceParamSW: TAction
      Caption = '   Device and Port Settings    '
      OnExecute = Action_DeviceParamExecute
    end
    object Action_AllanCalculate: TAction
      Caption = '  RW && BI by Allan  '
      OnExecute = Action_AllanCalculateExecute
    end
    object Action_OpenDataFile: TAction
      Caption = 'Open data file'
      ShortCut = 114
      OnExecute = Action_OpenDataFileExecute
    end
    object Action_OpenDataFile_ext: TAction
      Caption = 'Open data file extended'
      OnExecute = Action_OpenDataFile_extExecute
    end
    object Action_Close: TAction
      Caption = 'Exit...'
      OnExecute = Action_CloseExecute
    end
    object Action_Graphs: TAction
      Category = 'Analisys'
      Caption = '0.  Graphs'
      OnExecute = Action_GraphsExecute
    end
    object Action_SaveDataFile: TAction
      Caption = 'Save Data As ...'
      OnExecute = Action_SaveDataFileExecute
    end
  end
  object pmFile: TPopupMenu
    Left = 176
    Top = 104
    object miOpenDataFile: TMenuItem
      Action = Action_OpenDataFile
    end
    object Opendatafileextended1: TMenuItem
      Action = Action_OpenDataFile_ext
    end
    object RWBIbyAllan1: TMenuItem
      Caption = '-'
    end
    object Savedata1: TMenuItem
      Action = Action_SaveDataFile
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miExit: TMenuItem
      Action = Action_Close
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.txt'
    Options = [ofHideReadOnly, ofNoNetworkButton, ofEnableSizing, ofDontAddToRecent]
    Title = 'CVGCom - Open data file'
    Left = 232
    Top = 104
  end
  object pmAnalisys: TPopupMenu
    Left = 312
    Top = 104
    object N0Gpraphs1: TMenuItem
      Action = Action_Graphs
    end
    object mi2DCharts: TMenuItem
      Caption = '1.  2D - '#1043#1088#1072#1092#1080#1082#1080
      Enabled = False
    end
    object miRezonatorTemperature: TMenuItem
      Caption = '2.  '#1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1085#1099#1077' '#1080#1089#1087#1099#1090#1072#1085#1080#1103' '#1088#1077#1079#1086#1085#1072#1090#1086#1088#1072
      Enabled = False
    end
    object miTermoCorrection: TMenuItem
      Caption = '3. '#1058#1077#1088#1084#1086'-'#1082#1086#1088#1088#1077#1082#1094#1080#1103
      Enabled = False
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miGyroTransformFactor: TMenuItem
      Caption = '4. Gyro transform factor'
      Enabled = False
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object FFTTransform1: TMenuItem
      Caption = '5. FFT Transform'
      Enabled = False
    end
  end
  object pmTools: TPopupMenu
    Left = 376
    Top = 104
    object miCalcRegresionCoef: TMenuItem
      Caption = 'Calc Regression Coef'
      OnClick = miCalcRegresionCoefClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object ResonatorResearch1: TMenuItem
      Caption = 'Resonator Research'
      OnClick = ResonatorResearch1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object miMultiAnalys: TMenuItem
      Caption = 'Multi Analys'
      OnClick = miMultiAnalysClick
    end
    object SendDataToCCGProg: TMenuItem
      Caption = 'Send data to CCGProg'
      OnClick = SendDataToCCGProgClick
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 232
    Top = 160
  end
  object pmCorretion: TPopupMenu
    Left = 432
    Top = 104
    object miAlfaQAlfaECorrection: TMenuItem
      Caption = '  AlfaE Alfaq '
    end
    object miScaleFactorCorrection: TMenuItem
      Caption = '  Scale Factor  '
    end
    object miStaticCorrection: TMenuItem
      Caption = '  Static  '
    end
  end
end
