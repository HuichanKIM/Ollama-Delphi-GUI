object Form_RequestDialog: TForm_RequestDialog
  Left = 0
  Top = 0
  Cursor = crHandPoint
  ActiveControl = Memo_Request
  BorderStyle = bsDialog
  Caption = 'Chatting Dialog'
  ClientHeight = 230
  ClientWidth = 345
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
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 97
    Height = 15
    Caption = 'Prompt / Message'
  end
  object Label_Clear: TLabel
    Left = 315
    Top = 9
    Width = 26
    Height = 13
    Cursor = crHandPoint
    Caption = 'Clear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
    OnClick = Label_ClearClick
  end
  object SpeedButton_Trans: TSpeedButton
    Left = 241
    Top = 6
    Width = 67
    Height = 17
    Caption = 'Trans.'
    ImageIndex = 39
    ImageName = 'ic_format_size_48px'
    Images = Form_RestOllama.SVGIconVirtualImageList1
    OnClick = SpeedButton_TransClick
  end
  object Label2: TLabel
    Left = 8
    Top = 184
    Width = 170
    Height = 15
    Caption = '* Invalid characters:  ",  {, },  [,  ]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    StyleElements = [seClient, seBorder]
  end
  object Button_OK: TButton
    Left = 256
    Top = 192
    Width = 82
    Height = 25
    Caption = 'Request'
    ImageIndex = 12
    ImageName = 'All\ic_send_48px'
    Images = Form_RestOllama.SVGIconVirtualImageList1
    ModalResult = 1
    TabOrder = 0
  end
  object Memo_Request: TMemo
    AlignWithMargins = True
    Left = 5
    Top = 29
    Width = 335
    Height = 144
    Lines.Strings = (
      'Memo_Request')
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
