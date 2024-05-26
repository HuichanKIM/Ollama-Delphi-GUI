object Form_AliveOllama: TForm_AliveOllama
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '  Ollama Alive Checker'
  ClientHeight = 232
  ClientWidth = 224
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poDesigned
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object Result: TLabel
    Left = 3
    Top = 87
    Width = 32
    Height = 15
    Caption = 'Result'
  end
  object GroupBox1: TGroupBox
    Left = 3
    Top = 9
    Width = 213
    Height = 65
    Caption = 'Ollama IP'
    TabOrder = 0
    object Edit1: TEdit
      Left = 12
      Top = 25
      Width = 136
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = 'http://localhost:11434'
    end
    object Button_Alive: TButton
      Left = 154
      Top = 23
      Width = 50
      Height = 25
      Caption = 'Check'
      TabOrder = 1
      OnClick = Button_AliveClick
    end
  end
  object Memo1: TMemo
    Left = 15
    Top = 105
    Width = 201
    Height = 73
    TabOrder = 1
  end
  object Button_OK: TButton
    Left = 158
    Top = 198
    Width = 58
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
end
