object Form_Translator: TForm_Translator
  Left = 0
  Top = 0
  ActiveControl = Button_OK
  BorderStyle = bsDialog
  Caption = 'Translator  - https://translate.googleapis.com'
  ClientHeight = 399
  ClientWidth = 514
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object Panel_Buttons: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 361
    Width = 508
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      508
      35)
    object Button_OK: TButton
      Left = 419
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object CheckBox_Pushtochatbox: TCheckBox
      Left = 272
      Top = 12
      Width = 129
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Push to chat box'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      StyleElements = [seClient, seBorder]
    end
  end
  object Memo_Translates: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 39
    Width = 508
    Height = 316
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'Memo_Translates')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    StyleElements = [seClient, seBorder]
  end
  object Panel_Tollbar: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 508
    Height = 30
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object Label_Prompt: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 495
      Height = 24
      Margins.Right = 10
      Align = alClient
      AutoSize = False
      Caption = 'Prompt   '
      EllipsisPosition = epEndEllipsis
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 49
      ExplicitHeight = 15
    end
  end
end
