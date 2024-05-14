object Form_AliveOllama: TForm_AliveOllama
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '  Ollama Alive Checker'
  ClientHeight = 246
  ClientWidth = 306
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poMainFormCenter
  RoundedCorners = rcOn
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object Result: TLabel
    Left = 16
    Top = 91
    Width = 32
    Height = 15
    Caption = 'Result'
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 16
    Width = 266
    Height = 65
    Caption = 'Ollama IP'
    TabOrder = 0
    object Edit1: TEdit
      Left = 24
      Top = 23
      Width = 169
      Height = 21
      TabOrder = 0
      Text = 'http://localhost:11434'
    end
    object Button_Alive: TButton
      Left = 204
      Top = 21
      Width = 50
      Height = 25
      Caption = 'Check'
      TabOrder = 1
      OnClick = Button_AliveClick
    end
  end
  object Memo1: TMemo
    Left = 16
    Top = 118
    Width = 266
    Height = 73
    TabOrder = 1
  end
  object Button_OK: TButton
    Left = 207
    Top = 206
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
end
