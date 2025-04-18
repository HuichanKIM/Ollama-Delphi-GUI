object Form_DosCommander: TForm_DosCommander
  Left = 0
  Top = 0
  ActiveControl = Button_OK
  BorderStyle = bsDialog
  Caption = 'Dos Commander'
  ClientHeight = 140
  ClientWidth = 396
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
  RoundedCorners = rcOn
  OnClick = Label_ListClick
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 377
    Height = 81
    Caption = 'Command / Flag'
    TabOrder = 0
    object Label_Ollama: TLabel
      Left = 19
      Top = 28
      Width = 49
      Height = 15
      Caption = 'Ollama +'
    end
    object Label_Help: TLabel
      Tag = 2
      Left = 150
      Top = 53
      Width = 33
      Height = 15
      Cursor = crHandPoint
      Caption = '--help'
      OnClick = Label_ListClick
    end
    object Label_Version: TLabel
      Tag = 3
      Left = 191
      Top = 53
      Width = 48
      Height = 15
      Cursor = crHandPoint
      Caption = '--version'
      OnClick = Label_ListClick
    end
    object Label_List: TLabel
      Left = 94
      Top = 53
      Width = 15
      Height = 15
      Cursor = crHandPoint
      Caption = 'list'
      OnClick = Label_ListClick
    end
    object Label_Ps: TLabel
      Tag = 1
      Left = 124
      Top = 53
      Width = 12
      Height = 15
      Cursor = crHandPoint
      Caption = 'ps'
      OnClick = Label_ListClick
    end
    object Label_Reserved: TLabel
      Left = 24
      Top = 53
      Width = 58
      Height = 15
      Caption = '[ reserved ]'
      StyleElements = [seClient, seBorder]
    end
    object Label_Run: TLabel
      Tag = 4
      Left = 300
      Top = 53
      Width = 18
      Height = 15
      Cursor = crHandPoint
      Caption = 'run'
      StyleElements = [seClient, seBorder]
      OnClick = Label_ListClick
    end
    object Label_Pull: TLabel
      Tag = 6
      Left = 333
      Top = 53
      Width = 15
      Height = 15
      Cursor = crHandPoint
      Caption = 'rm'
      StyleElements = [seClient, seBorder]
      OnClick = Label_ListClick
    end
    object Label_Show: TLabel
      Tag = 3
      Left = 256
      Top = 53
      Width = 28
      Height = 15
      Cursor = crHandPoint
      Caption = 'show'
      OnClick = Label_ListClick
    end
    object Edit_CommandFlag: TEdit
      Left = 80
      Top = 26
      Width = 273
      Height = 21
      TabOrder = 0
      Text = '--help'
      OnKeyPress = Edit_CommandFlagKeyPress
    end
  end
  object Button_OK: TButton
    Left = 244
    Top = 102
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button_Cancel: TButton
    Left = 332
    Top = 102
    Width = 53
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
