object Form_RequestDialog: TForm_RequestDialog
  Left = 0
  Top = 0
  Cursor = crHandPoint
  ActiveControl = Memo_Request
  BorderStyle = bsDialog
  Caption = 'Chatting Dialog'
  ClientHeight = 230
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poDefault
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    364
    230)
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 97
    Height = 15
    Caption = 'Prompt / Message'
  end
  object Label_Clear: TLabel
    Left = 334
    Top = 9
    Width = 26
    Height = 13
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
    OnClick = Label_ClearClick
    ExplicitLeft = 315
  end
  object SpeedButton_Trans: TSpeedButton
    Left = 260
    Top = 6
    Width = 67
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Trans.'
    ImageIndex = 39
    ImageName = 'ic_format_size_48px'
    Images = Form_RestOllama.SVGIconVirtualImageList1
    OnClick = SpeedButton_TransClick
    ExplicitLeft = 241
  end
  object Label2: TLabel
    Left = 8
    Top = 196
    Width = 170
    Height = 15
    Caption = '* Invalid characters:  ",  {, },  [,  ]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    StyleElements = [seClient, seBorder]
  end
  object Button_OK: TButton
    Left = 275
    Top = 192
    Width = 82
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Request'
    ImageIndex = 12
    ImageName = 'All\ic_send_48px'
    Images = Form_RestOllama.SVGIconVirtualImageList1
    ModalResult = 1
    TabOrder = 0
    ExplicitLeft = 256
  end
  object Memo_Request: TMemo
    AlignWithMargins = True
    Left = 5
    Top = 29
    Width = 354
    Height = 149
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo_Request')
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 335
  end
end
