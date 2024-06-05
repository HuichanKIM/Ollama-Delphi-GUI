object Form_AliveOllama: TForm_AliveOllama
  Left = 0
  Top = 0
  ActiveControl = Button_OK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '  Ollama Alive Checker'
  ClientHeight = 203
  ClientWidth = 224
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clSilver
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 3
    Top = 8
    Width = 213
    Height = 65
    Caption = 'Ollama IP'
    TabOrder = 0
    object SpeedButton_Check: TSpeedButton
      Left = 155
      Top = 25
      Width = 47
      Height = 21
      Caption = 'Check'
      OnClick = SpeedButton_CheckClick
    end
    object Edit1: TEdit
      Left = 12
      Top = 25
      Width = 136
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = 'http://localhost:11434'
    end
  end
  object Memo_Alive: TMemo
    Left = 3
    Top = 83
    Width = 213
    Height = 73
    TabOrder = 1
    StyleElements = [seClient, seBorder]
  end
  object Button_OK: TButton
    Left = 158
    Top = 168
    Width = 58
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
end
