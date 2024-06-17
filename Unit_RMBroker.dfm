object Form_RMBroker: TForm_RMBroker
  Left = 0
  Top = 0
  ActiveControl = Memo_Log_Rm
  BorderStyle = bsDialog
  Caption = 'Remote Broker'
  ClientHeight = 369
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poMainFormCenter
  RoundedCorners = rcOn
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 40
      Height = 19
      Margins.Left = 10
      Align = alLeft
      Caption = 'Current'
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object Label_Connection: TLabel
      AlignWithMargins = True
      Left = 63
      Top = 3
      Width = 274
      Height = 19
      Margins.Left = 10
      Align = alLeft
      AutoSize = False
      Caption = '...'
      EllipsisPosition = epEndEllipsis
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
    end
    object CheckBox_Logoption: TCheckBox
      Left = 392
      Top = 0
      Width = 102
      Height = 25
      Margins.Right = 10
      Align = alRight
      Caption = 'Log Contents'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object StatusBar_RM: TStatusBar
    Left = 0
    Top = 350
    Width = 494
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Memo_Log_Rm: TMemo
    Left = 0
    Top = 25
    Width = 494
    Height = 325
    Align = alClient
    Lines.Strings = (
      'Memo_Log_Rm')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object HttpRestOllama_RM: TSslHttpRest
    LocalAddr = '0.0.0.0'
    LocalAddr6 = '::'
    ProxyPort = '80'
    Agent = 'Ollama Client'
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptLanguage = 'utf-8, *;q=0.8'
    Username = 'user'
    NoCache = False
    ResponseNoException = False
    ContentTypePost = 'application/json'
    LmCompatLevel = 0
    RequestVer = '1.1'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    ServerAuth = httpAuthNone
    ProxyAuth = httpAuthNone
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = [httpoNoBasicAuth, httpoNoNTLMAuth, httpoEnableContentCoding, httpoNoDigestAuth]
    Timeout = 300
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    SocketFamily = sfAny
    SocketErrs = wsErrFriendly
    RestParams.PContent = PContUrlencoded
    RestParams.RfcStrict = False
    RestParams.FormDataUtf8 = True
    RestParams = <>
    DebugLevel = DebugNone
    MaxBodySize = 1024000
    SslCliSecurity = sslCliSecNone
    SslSessCache = False
    CertVerMethod = CertVerNone
    SslRootFile = 'RootCaCertsBundle.pem'
    SslRevocation = False
    SslReportChain = False
    SslAllowSelfSign = False
    HttpMemStrategy = HttpStratMem
    HttpDownReplace = False
    ResumeMinSize = 65535
    ProgIntSecs = 1
    ShowProgress = True
    HttpUploadStrat = HttpUploadNone
    SharedSslCtx = False
    NoSSL = True
    MaxLogParams = 4096
    OnHttpRestProg = HttpRestOllama_RMHttpRestProg
    OnRestRequestDone = HttpRestOllama_RMRestRequestDone
    Left = 140
    Top = 128
  end
  object Timer_Repeater_Rm: TTimer
    Enabled = False
    OnTimer = Timer_Repeater_RmTimer
    Left = 219
    Top = 224
  end
end
