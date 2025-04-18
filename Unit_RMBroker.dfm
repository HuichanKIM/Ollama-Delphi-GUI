object Form_RMBroker: TForm_RMBroker
  Left = 0
  Top = 0
  ActiveControl = Memo_Log_Rm
  BorderStyle = bsDialog
  Caption = 'Ollama Broker / Server'
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
      Left = 33
      Top = 3
      Width = 40
      Height = 15
      Margins.Left = 5
      Align = alLeft
      Caption = 'Current'
      Layout = tlCenter
    end
    object Label_Connection: TLabel
      AlignWithMargins = True
      Left = 86
      Top = 3
      Width = 257
      Height = 19
      Margins.Left = 10
      Align = alClient
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
      ExplicitLeft = 63
      ExplicitWidth = 274
    end
    object SpeedButton_GetUsers: TSpeedButton
      AlignWithMargins = True
      Left = 349
      Top = 3
      Width = 40
      Height = 19
      Cursor = crHandPoint
      Align = alRight
      Caption = 'Users'
      ImageIndex = 68
      ImageName = 'logonicon'
      OnClick = SpeedButton_GetUsersClick
      ExplicitLeft = 352
      ExplicitTop = 0
      ExplicitHeight = 25
    end
    object SkSvg_RMBroker: TSkSvg
      AlignWithMargins = True
      Left = 3
      Top = 2
      Width = 22
      Height = 20
      Margins.Top = 2
      Align = alLeft
      ExplicitTop = -1
    end
    object CheckBox_Logoption: TCheckBox
      Left = 392
      Top = 0
      Width = 102
      Height = 25
      Margins.Right = 10
      Align = alRight
      Caption = 'Log Contents'
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
  object RESTClient_RM: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    Params = <>
    ReadTimeout = 60000
    SynchronizedEvents = False
    BindSource.AutoActivate = False
    BindSource.AutoEdit = False
    BindSource.AutoPost = False
    OnSendData = RESTClient_RMSendData
    OnReceiveData = RESTClient_RMReceiveData
    Left = 160
    Top = 104
  end
  object RESTRequest_RM: TRESTRequest
    Client = RESTClient_RM
    Method = rmPOST
    Params = <>
    Response = RESTResponse_RM
    SynchronizedEvents = False
    BindSource.AutoActivate = False
    BindSource.AutoEdit = False
    BindSource.AutoPost = False
    Left = 264
    Top = 102
  end
  object RESTResponse_RM: TRESTResponse
    BindSource.AutoActivate = False
    BindSource.AutoEdit = False
    BindSource.AutoPost = False
    Left = 220
    Top = 151
  end
end
