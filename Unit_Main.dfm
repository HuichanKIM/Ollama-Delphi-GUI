object Form_RestOllama: TForm_RestOllama
  Left = 0
  Top = 0
  ActiveControl = Button_Home
  Caption = 'Ollama Chat Client 1.0 (2024)'
  ClientHeight = 847
  ClientWidth = 1181
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Constraints.MinHeight = 800
  Constraints.MinWidth = 900
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clSilver
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  RoundedCorners = rcOn
  ShowHint = True
  StyleElements = [seClient, seBorder]
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object Panel_ChattingBase: TPanel
    Left = 0
    Top = 30
    Width = 1181
    Height = 798
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel_Models: TPanel
      Left = 0
      Top = 0
      Width = 218
      Height = 798
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      object Panel_CaptionModelTopics: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 217
        Height = 26
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Model / Topics'
        TabOrder = 0
        StyleElements = [seClient, seBorder]
      end
      object Panel_RequestButtons: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 769
        Width = 212
        Height = 26
        Align = alBottom
        Alignment = taLeftJustify
        BevelOuter = bvNone
        TabOrder = 1
        object SpeedButton_AddToTopics: TSpeedButton
          AlignWithMargins = True
          Left = 187
          Top = 3
          Width = 22
          Height = 20
          Hint = 'Add to Topics'
          Margins.Left = 0
          Align = alRight
          ImageIndex = 50
          ImageName = 'ic_queue_48px'
          Images = SVGIconVirtualImageList1
          OnClick = SpeedButton_AddToTopicsClick
          ExplicitLeft = 203
          ExplicitTop = -3
        end
        object CheckBox_AutoLoadTopic: TCheckBox
          Left = 0
          Top = 0
          Width = 97
          Height = 26
          Margins.Left = 10
          Margins.Right = 100
          Margins.Bottom = 20
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 'Auto list up  - '
          Checked = True
          State = cbChecked
          TabOrder = 0
          StyleElements = [seClient, seBorder]
        end
      end
      object GroupBox_Multimodel: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 88
        Width = 212
        Height = 70
        Align = alTop
        Caption = 'Multimodal / Reasoning'
        TabOrder = 2
        StyleElements = [seClient, seBorder]
        object CheckBox_ProcessImage: TCheckBox
          Left = 11
          Top = 42
          Width = 190
          Height = 17
          Hint = 'Llava, Gemma3 ...'
          Caption = 'Analysis Image'
          TabOrder = 0
          StyleElements = [seClient, seBorder]
          OnClick = CheckBox_ProcessImageClick
        end
        object CheckBox_Reasoning: TCheckBox
          Left = 11
          Top = 20
          Width = 190
          Height = 17
          Hint = 'Cogito, Deepseek, Granite ...'
          Caption = 'Add Resoning'
          TabOrder = 1
          StyleElements = [seClient, seBorder]
          OnClick = CheckBox_ReasoningClick
        end
      end
      object GroupBox_Model: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 29
        Width = 212
        Height = 53
        Align = alTop
        Caption = 'Model'
        TabOrder = 3
        StyleElements = [seClient, seBorder]
        object SpeedButton_ListModels: TSpeedButton
          Left = 5
          Top = 20
          Width = 23
          Height = 25
          Hint = 'Request / Update for List Models'
          ImageIndex = 9
          ImageName = 'All\ic_settings_applications_48px'
          Images = SVGIconVirtualImageList1
          OnClick = SpeedButton_ListModelsClick
        end
        object SpeedButton_ModelLoad: TSpeedButton
          Tag = 1
          Left = 182
          Top = 20
          Width = 23
          Height = 25
          Hint = 'Model Load/UnLoad'
          ImageIndex = 45
          ImageName = 'ic_more_horiz_48px'
          Images = SVGIconVirtualImageList1
          OnClick = SpeedButton_ModelLoadClick
        end
        object ComboBox_Models: TComboBox
          Left = 30
          Top = 22
          Width = 145
          Height = 23
          Style = csDropDownList
          DragMode = dmAutomatic
          DropDownCount = 20
          ItemIndex = 0
          TabOrder = 0
          Text = 'phi3'
          OnChange = ComboBox_ModelsChange
          Items.Strings = (
            'phi3'
            'llama3'
            'gemma'
            'llava')
        end
      end
      object GroupBox_MultimodelImage: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 164
        Width = 212
        Height = 210
        Align = alTop
        Caption = 'Image for Multimodel'
        Enabled = False
        TabOrder = 4
        StyleElements = [seClient, seBorder]
        object Panel_ImageSourceBase: TPanel
          Left = 2
          Top = 17
          Width = 208
          Height = 191
          Align = alClient
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          ShowCaption = False
          TabOrder = 0
          object Image_Source: TImage
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 202
            Height = 185
            Hint = 'Drop Image-file (*.jpg, *.jpeg, *.png, *.webp, *.gif)'
            Align = alClient
            Center = True
            Proportional = True
            Stretch = True
            Transparent = True
            OnDblClick = Image_SourceDblClick
            ExplicitLeft = 4
            ExplicitTop = 8
          end
          object SpeedButton_ImageLoad: TSpeedButton
            Left = 0
            Top = 0
            Width = 23
            Height = 22
            Cursor = crHandPoint
            Action = Action_LoadImageSource
            Images = SVGIconVirtualImageList1
          end
          object SpeedButton_ImagePrev: TSpeedButton
            Left = 165
            Top = 0
            Width = 20
            Height = 22
            Cursor = crHandPoint
            Hint = 'Prev Source'
            ImageIndex = 19
            ImageName = 'ic_chevron_left_48px'
            Images = SVGIconVirtualImageList1
          end
          object SpeedButton_ImageNext: TSpeedButton
            Left = 188
            Top = 0
            Width = 20
            Height = 22
            Cursor = crHandPoint
            Hint = 'Next Source'
            ImageIndex = 20
            ImageName = 'ic_chevron_right_48px'
            Images = SVGIconVirtualImageList1
          end
        end
      end
      object GroupBox_Topics: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 380
        Width = 212
        Height = 383
        Align = alClient
        Caption = 'Topics / Prompt'
        TabOrder = 5
        StyleElements = [seClient, seBorder]
        object TreeView_Topics: TTreeView
          AlignWithMargins = True
          Left = 5
          Top = 46
          Width = 202
          Height = 332
          Hint = 'Request Dialog'
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = False
          DragMode = dmAutomatic
          HideSelection = False
          Indent = 10
          MultiSelectStyle = []
          ParentCtl3D = False
          ParentShowHint = False
          PopupMenu = PopupMenu_Topics
          ReadOnly = True
          RowSelect = True
          ShowHint = False
          ShowLines = False
          TabOrder = 0
          OnChange = TreeView_TopicsChange
          OnClick = TreeView_TopicsClick
          OnCustomDrawItem = TreeView_TopicsCustomDrawItem
          OnDblClick = TreeView_TopicsDblClick
          OnDragDrop = TreeView_TopicsDragDrop
          OnDragOver = TreeView_TopicsDragOver
        end
        object Panel_TopicButtons: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 20
          Width = 202
          Height = 20
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object SpeedButton_AddTopic: TSpeedButton
            Left = 69
            Top = 0
            Width = 23
            Height = 20
            Hint = 'Insert New Child Node'
            Align = alLeft
            ImageIndex = 14
            ImageName = 'ic_add_48px'
            Images = SVGIconVirtualImageList1
            OnClick = SpeedButton_AddTopicClick
            ExplicitLeft = 8
          end
          object SpeedButton_DeleteTopic: TSpeedButton
            Left = 92
            Top = 0
            Width = 23
            Height = 20
            Hint = 'Delete from Topics'
            Align = alLeft
            ImageIndex = 49
            ImageName = 'ic_remove_48px'
            Images = SVGIconVirtualImageList1
            OnClick = SpeedButton_DeleteTopicClick
            ExplicitLeft = 29
          end
          object SpeedButton_RunRequest: TSpeedButton
            Left = 179
            Top = 0
            Width = 23
            Height = 20
            Hint = 'Request node text'
            Align = alRight
            ImageIndex = 12
            ImageName = 'All\ic_send_48px'
            Images = SVGIconVirtualImageList1
            OnClick = SpeedButton_RunRequestClick
            ExplicitLeft = 180
          end
          object Label_NodeSeed: TLabel
            AlignWithMargins = True
            Left = 125
            Top = 0
            Width = 24
            Height = 15
            Margins.Left = 10
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alLeft
            Caption = 'seed'
            StyleElements = [seClient, seBorder]
          end
          object SpeedButton_NewRootnode: TSpeedButton
            Left = 23
            Top = 0
            Width = 23
            Height = 20
            Hint = 'Insert New Root Node'
            Align = alLeft
            ImageIndex = 53
            ImageName = 'ic_add_box_48px'
            Images = SVGIconVirtualImageList1
            OnClick = SpeedButton_NewRootnodeClick
            ExplicitLeft = 17
          end
          object SpeedButton_ExpandFull: TSpeedButton
            Tag = 1
            Left = 0
            Top = 0
            Width = 23
            Height = 20
            Hint = 'Full Expand / Collapse'
            Align = alLeft
            ImageIndex = 56
            ImageName = 'ic_unfold_more_48px'
            Images = SVGIconVirtualImageList1
            OnClick = SpeedButton_ExpandFullClick
            ExplicitTop = 1
          end
          object SpeedButton_RenameTopic: TSpeedButton
            Left = 46
            Top = 0
            Width = 23
            Height = 20
            Hint = 'Rename'
            Align = alLeft
            ImageIndex = 57
            ImageName = 'ic_explicit_48px'
            Images = SVGIconVirtualImageList1
            OnClick = pmn_RenameTopicClick
            ExplicitLeft = 40
          end
        end
      end
    end
    object Panel_Options: TPanel
      Left = 940
      Top = 0
      Width = 241
      Height = 798
      Align = alRight
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ShowCaption = False
      TabOrder = 1
      object Image_Logo: TImage
        Left = 200
        Top = 710
        Width = 35
        Height = 60
        Center = True
        Enabled = False
        Proportional = True
        Visible = False
      end
      object Splitter2: TSplitter
        AlignWithMargins = True
        Left = 3
        Top = 653
        Width = 235
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = 0
        ExplicitTop = 428
        ExplicitWidth = 233
      end
      object RadioGroup_PromptType: TRadioGroup
        AlignWithMargins = True
        Left = 3
        Top = 29
        Width = 235
        Height = 50
        Align = alTop
        Caption = 'Request Mode'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'Generate'
          'Chat (*)')
        TabOrder = 0
        StyleElements = [seClient, seBorder]
        OnClick = RadioGroup_PromptTypeClick
      end
      object GroupBox_Username: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 85
        Width = 235
        Height = 56
        Align = alTop
        Caption = 'User / Nickname'
        TabOrder = 1
        StyleElements = [seClient, seBorder]
        object Edit_Nickname: TEdit
          Left = 17
          Top = 24
          Width = 192
          Height = 21
          TabOrder = 0
          Text = 'User'
          OnChange = Edit_NicknameChange
        end
      end
      object Panel_Setting: TPanel
        Left = 0
        Top = 144
        Width = 241
        Height = 25
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 2
        StyleElements = [seClient, seBorder]
        object SpeedButton_DefaultSet: TSpeedButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 21
          Height = 19
          Action = Action_DefaultRefresh
          Align = alLeft
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 4
        end
        object SpeedButton_OllamaAlive: TSpeedButton
          AlignWithMargins = True
          Left = 30
          Top = 3
          Width = 20
          Height = 19
          Action = Action_InetAlive
          Align = alLeft
          Images = SVGIconVirtualImageList1
        end
        object SpeedButton_SelectionColor: TSpeedButton
          AlignWithMargins = True
          Left = 211
          Top = 3
          Width = 20
          Height = 19
          Margins.Right = 10
          Action = Action_SelectionColor
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 167
        end
        object SpeedButton_TtsControl: TSpeedButton
          AlignWithMargins = True
          Left = 56
          Top = 3
          Width = 23
          Height = 19
          Action = Action_TTSControl
          Align = alLeft
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 130
        end
        object SpeedButton_Help: TSpeedButton
          AlignWithMargins = True
          Left = 112
          Top = 3
          Width = 21
          Height = 19
          Hint = 'Help / Shortcuts'
          Align = alLeft
          ImageIndex = 36
          ImageName = 'ic_help_outline_24px'
          Images = SVGIconVirtualImageList1
          OnClick = SpeedButton_HelpClick
          ExplicitLeft = 154
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 155
          Top = 3
          Width = 50
          Height = 15
          Align = alClient
          Alignment = taRightJustify
          Caption = 'Options -'
          Layout = tlCenter
          StyleElements = [seClient, seBorder]
        end
        object SpeedButton_Broker: TSpeedButton
          AlignWithMargins = True
          Left = 85
          Top = 3
          Width = 21
          Height = 19
          Hint = 'Log / Broker Window'
          Action = Action_Logs
          Align = alLeft
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 162
        end
      end
      object GroupBox_GlobalFontSize: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 172
        Width = 235
        Height = 53
        Align = alTop
        Caption = 'Chatting Box'
        TabOrder = 3
        StyleElements = [seClient, seBorder]
        object Label_FontSize: TLabel
          Left = 16
          Top = 24
          Width = 47
          Height = 15
          Caption = 'Font Size'
          StyleElements = [seClient, seBorder]
        end
        object Label_Font_Size: TLabel
          Left = 170
          Top = 25
          Width = 12
          Height = 15
          Caption = '10'
          StyleElements = [seClient, seBorder]
        end
        object SpeedButton_SetFont: TSpeedButton
          Left = 200
          Top = 20
          Width = 23
          Height = 22
          Hint = 'Set New Font'
          Caption = 'Ff'
          Images = SVGIconVirtualImageList1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          StyleElements = [seClient, seBorder]
          OnClick = SpeedButton_SetFontClick
        end
        object TrackBar_GlobalFontSize: TTrackBar
          AlignWithMargins = True
          Left = 75
          Top = 20
          Width = 100
          Height = 20
          Hint = '10'
          Margins.Right = 15
          DoubleBuffered = True
          Max = 20
          Min = 8
          ParentDoubleBuffered = False
          Position = 10
          ShowSelRange = False
          TabOrder = 0
          TickStyle = tsNone
          OnChange = TrackBar_GlobalFontSizeChange
        end
      end
      object GroupBox_TopicOption: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 753
        Width = 235
        Height = 45
        Margins.Bottom = 0
        Align = alBottom
        Caption = 'Topic Option'
        TabOrder = 4
        StyleElements = [seClient, seBorder]
        object Label_SeedGet: TLabel
          Left = 127
          Top = 20
          Width = 32
          Height = 15
          Cursor = crHandPoint
          Hint = 'Get Random Seed'
          Caption = '/ seed'
          StyleElements = [seClient, seBorder]
          OnClick = Label_SeedGetClick
        end
        object CheckBox_UseTopicSeed: TCheckBox
          Left = 16
          Top = 20
          Width = 105
          Height = 17
          Caption = 'Use Topic Seed'
          TabOrder = 0
          StyleElements = [seClient, seBorder]
        end
        object Edit_TopicSeed: TEdit
          Left = 172
          Top = 18
          Width = 50
          Height = 21
          TabOrder = 1
          StyleElements = [seClient, seBorder]
        end
      end
      object GroupBox_Tranlation: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 231
        Width = 235
        Height = 56
        Align = alTop
        Caption = 'Translation (by Google)'
        TabOrder = 5
        StyleElements = [seClient, seBorder]
        object SpeedButton_Translate: TSpeedButton
          Left = 15
          Top = 24
          Width = 30
          Height = 22
          Action = Action_TransMessage
          Images = SVGIconVirtualImageList1
        end
        object Label_TransDir: TLabel
          Left = 115
          Top = 27
          Width = 11
          Height = 15
          Caption = 'to'
          StyleElements = [seClient, seBorder]
        end
        object ComboBox_TransSource: TComboBox
          Left = 56
          Top = 23
          Width = 50
          Height = 23
          Style = csDropDownList
          DropDownCount = 15
          ItemIndex = 0
          TabOrder = 0
          Text = 'en'
          StyleElements = [seClient, seBorder]
          Items.Strings = (
            'en'
            'ko')
        end
        object ComboBox_TransTarget: TComboBox
          Left = 138
          Top = 23
          Width = 50
          Height = 23
          Style = csDropDownList
          DropDownCount = 15
          ItemIndex = 0
          TabOrder = 1
          Text = 'ko'
          StyleElements = [seClient, seBorder]
          Items.Strings = (
            'ko'
            'en')
        end
        object CheckBox_AutoTranslation: TCheckBox
          Left = 204
          Top = 26
          Width = 17
          Height = 17
          Hint = 'Sync. Auto Translation of Response'
          TabOrder = 2
          StyleElements = [seClient, seBorder]
        end
      end
      object GroupBox_TTSEngine: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 293
        Width = 231
        Height = 132
        Margins.Left = 5
        Margins.Right = 5
        Align = alTop
        Caption = 'TTS Control'
        TabOrder = 6
        StyleElements = [seClient, seBorder]
        DesignSize = (
          231
          132)
        object Label4: TLabel
          Left = 30
          Top = 76
          Width = 23
          Height = 15
          Caption = 'Rate'
          FocusControl = TrackBar_Rate
          StyleElements = [seClient, seBorder]
        end
        object Label_Rate: TLabel
          Left = 200
          Top = 76
          Width = 6
          Height = 15
          Caption = '0'
          StyleElements = [seClient, seBorder]
        end
        object Label5: TLabel
          Left = 30
          Top = 104
          Width = 19
          Height = 15
          Alignment = taCenter
          Caption = 'Vol.'
          FocusControl = TrackBar_Volume
          StyleElements = [seClient, seBorder]
        end
        object Label_Volume: TLabel
          Left = 200
          Top = 104
          Width = 6
          Height = 15
          Caption = '0'
          StyleElements = [seClient, seBorder]
        end
        object Shape_TTS: TShape
          Left = 198
          Top = 53
          Width = 10
          Height = 10
          Brush.Color = clGray
          Shape = stCircle
        end
        object SpeedButton_TTSPlay: TSpeedButton
          Left = 16
          Top = 47
          Width = 23
          Height = 22
          ImageIndex = 61
          ImageName = 'ic_play_circle_outline_24px'
          Images = SVGIconVirtualImageList1
          OnClick = SpeedButton_TTSPlayClick
        end
        object SpeedButton_TTSPause: TSpeedButton
          Tag = 1
          Left = 38
          Top = 47
          Width = 23
          Height = 22
          ImageIndex = 46
          ImageName = 'ic_pause_circle_outline_48px'
          Images = SVGIconVirtualImageList1
          OnClick = SpeedButton_TTSPlayClick
        end
        object SpeedButton_TTSStop: TSpeedButton
          Tag = 2
          Left = 60
          Top = 47
          Width = 23
          Height = 22
          ImageIndex = 66
          ImageName = 'stop-button'
          Images = SVGIconVirtualImageList1
          OnClick = SpeedButton_TTSPlayClick
        end
        object ComboBox_TTSEngine: TComboBox
          Left = 18
          Top = 18
          Width = 198
          Height = 23
          DropDownCount = 10
          TabOrder = 0
          Text = 'ComboBox_TTSEngine'
          StyleElements = [seClient, seBorder]
          OnChange = ComboBox_TTSEngineChange
        end
        object TrackBar_Rate: TTrackBar
          Left = 60
          Top = 73
          Width = 130
          Height = 20
          Min = -10
          TabOrder = 1
          TickStyle = tsNone
          StyleElements = [seClient, seBorder]
          OnChange = TrackBar_RateChange
        end
        object TrackBar_Volume: TTrackBar
          Left = 60
          Top = 100
          Width = 130
          Height = 20
          Max = 100
          Position = 100
          TabOrder = 2
          TickStyle = tsNone
          StyleElements = [seClient, seBorder]
          OnChange = TrackBar_VolumeChange
        end
        object ProgressBar_TTS: TProgressBar
          Left = 96
          Top = 55
          Width = 87
          Height = 6
          Anchors = [akLeft, akTop, akRight]
          Smooth = True
          TabOrder = 3
        end
      end
      object GroupBox_History: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 431
        Width = 231
        Height = 216
        Margins.Left = 5
        Margins.Right = 5
        Align = alClient
        Caption = 'History'
        TabOrder = 7
        StyleElements = [seClient, seBorder]
        object Panel_HistoryButtons: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 19
          Width = 223
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          OnClick = Panel_HistoryButtonsClick
          object SpeedButton_DelToHistory: TSpeedButton
            AlignWithMargins = True
            Left = 58
            Top = 3
            Width = 23
            Height = 16
            Margins.Right = 0
            Action = Action_DelToHistory
            Align = alLeft
            Images = SVGIconVirtualImageList1
            ExplicitTop = 6
          end
          object SpeedButton_HistoryMore: TSpeedButton
            Tag = 1
            Left = 200
            Top = 0
            Width = 23
            Height = 22
            Hint = 'More ...'
            Align = alRight
            ImageIndex = 45
            ImageName = 'ic_more_horiz_48px'
            Images = SVGIconVirtualImageList1
            OnClick = SpeedButton_HistoryMoreClick
            ExplicitLeft = 0
            ExplicitTop = 1
            ExplicitHeight = 20
          end
          object SpeedButton_AddToHistory2: TSpeedButton
            AlignWithMargins = True
            Left = 32
            Top = 3
            Width = 23
            Height = 16
            Margins.Right = 0
            Action = Action_AddToHistory
            Align = alLeft
            Images = SVGIconVirtualImageList1
            ExplicitLeft = -2
            ExplicitHeight = 14
          end
          object SpeedButton_AddToHistory1: TSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 23
            Height = 16
            Action = Action_LoadHistory
            Align = alLeft
            Images = SVGIconVirtualImageList1
            ExplicitTop = 6
          end
          object Label_HistoryCount: TLabel
            AlignWithMargins = True
            Left = 84
            Top = 3
            Width = 23
            Height = 15
            Align = alClient
            Alignment = taCenter
            Caption = '0 / 0'
            Layout = tlCenter
            StyleElements = [seClient, seBorder]
          end
        end
        object ListBox_History: TListBox
          AlignWithMargins = True
          Left = 4
          Top = 47
          Width = 223
          Height = 145
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          DoubleBuffered = True
          ItemHeight = 15
          ParentDoubleBuffered = False
          TabOrder = 1
          StyleElements = [seClient, seBorder]
          OnClick = ListBox_HistoryClick
        end
        object Panel_HistoryFile: TPanel
          Left = 1
          Top = 195
          Width = 229
          Height = 20
          Align = alBottom
          Alignment = taLeftJustify
          Caption = '...'
          TabOrder = 2
          StyleElements = [seClient, seBorder]
        end
      end
      object Panel_OptionsTop: TPanel
        AlignWithMargins = True
        Left = 1
        Top = 0
        Width = 240
        Height = 26
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Alignment = taRightJustify
        BevelOuter = bvNone
        Caption = 'Protocol  / History  '
        TabOrder = 8
        StyleElements = [seClient, seBorder]
      end
      object GroupBox_Memo: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 662
        Width = 235
        Height = 85
        Align = alBottom
        Caption = 'Memo'
        TabOrder = 9
        StyleElements = [seClient, seBorder]
        object Memo_Memo: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 19
          Width = 227
          Height = 62
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object Panel_Chatting: TPanel
      Left = 218
      Top = 0
      Width = 722
      Height = 798
      Align = alClient
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      object Panel_ChattingButtons: TPanel
        Left = 0
        Top = 0
        Width = 722
        Height = 26
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '  Chatting Box'
        TabOrder = 0
        StyleElements = [seClient, seBorder]
        object SpeedButton_ScrollTop: TSpeedButton
          AlignWithMargins = True
          Left = 520
          Top = 3
          Width = 23
          Height = 20
          Action = Action_Pop_ScrollToTop
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 272
          ExplicitTop = 8
          ExplicitHeight = 22
        end
        object SpeedButton_ScrollBottom: TSpeedButton
          AlignWithMargins = True
          Left = 549
          Top = 3
          Width = 23
          Height = 20
          Action = Action_Pop_ScrollToBottom
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 457
          ExplicitTop = 0
        end
        object SpeedButton_DeleteChatMessage: TSpeedButton
          AlignWithMargins = True
          Left = 578
          Top = 3
          Width = 23
          Height = 20
          Action = Action_Pop_DeleteItem
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 75
          ExplicitTop = 6
        end
        object SpeedButton_CopyToClipboard: TSpeedButton
          AlignWithMargins = True
          Left = 607
          Top = 3
          Width = 23
          Height = 20
          Action = Action_Pop_CopyText
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 107
          ExplicitTop = 6
        end
        object SpeedButton_SaveAllText: TSpeedButton
          AlignWithMargins = True
          Left = 636
          Top = 3
          Width = 23
          Height = 20
          Action = Action_Pop_SaveAllText
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 637
          ExplicitTop = 0
        end
        object SpeedButton_ClearChatBox: TSpeedButton
          AlignWithMargins = True
          Left = 696
          Top = 3
          Width = 23
          Height = 20
          Action = Action_ClearChatting
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 705
          ExplicitTop = 6
        end
        object SpeedButton_TTS: TSpeedButton
          AlignWithMargins = True
          Left = 665
          Top = 3
          Width = 23
          Height = 20
          Margins.Right = 5
          Action = Action_TTS
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 712
          ExplicitTop = 6
        end
        object Label_HistoryCation: TLabel
          AlignWithMargins = True
          Left = 464
          Top = 3
          Width = 21
          Height = 20
          Hint = 'on view history'
          Margins.Left = 100
          Align = alRight
          Alignment = taRightJustify
          AutoSize = False
          Caption = '*'
          EllipsisPosition = epEndEllipsis
          StyleElements = [seBorder]
        end
        object SpeedButton_AddToHistory0: TSpeedButton
          AlignWithMargins = True
          Left = 491
          Top = 3
          Width = 23
          Height = 20
          Action = Action_LoadHistory
          Align = alRight
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 11
          ExplicitTop = 6
        end
      end
      object PageControl_Chatting: TPageControl
        Left = 0
        Top = 26
        Width = 722
        Height = 740
        ActivePage = Tabsheet_Chatting
        Align = alClient
        TabOrder = 1
        OnChange = PageControl_ChattingChange
        OnResize = PageControl_ChattingResize
        object Tabsheet_Chatting: TTabSheet
          Caption = 'CHAT'
          DesignSize = (
            714
            710)
          inline Frame_ChattingBox: TFrame_ChattingBoxClass
            Left = 0
            Top = 0
            Width = 714
            Height = 710
            Align = alClient
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 2
            ExplicitWidth = 714
            ExplicitHeight = 710
            inherited VST_ChattingBox: TVirtualStringTree
              Width = 714
              Height = 710
              DragOperations = [doCopy, doMove]
              ExplicitWidth = 714
              ExplicitHeight = 710
              Columns = <
                item
                  Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coVisible, coAllowFocus, coStyleColor]
                  Position = 0
                  Text = 'Chatting'
                  Width = 714
                end>
            end
          end
          object SkAnimatedImage_ChatProcess: TSkAnimatedImage
            Left = 335
            Top = 660
            Width = 50
            Height = 50
            Anchors = [akRight, akBottom]
            Opacity = 200
            Animation.Enabled = False
            Animation.Speed = 0.500000000000000000
          end
          object SkAnimatedImage_Chat: TSkAnimatedImage
            Left = 295
            Top = 270
            Width = 120
            Height = 120
            Opacity = 130
            OnClick = SkAnimatedImage_ChatClick
            Animation.Loop = False
          end
        end
        object TabSheet_LogsBroker: TTabSheet
          Caption = 'LOG'
          ImageIndex = 1
          object Splitter1: TSplitter
            Left = 0
            Top = 556
            Width = 714
            Height = 4
            Cursor = crVSplit
            Align = alBottom
            ExplicitTop = 557
          end
          object Memo_LogWin: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 23
            Width = 708
            Height = 530
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clSilver
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
            WordWrap = False
          end
          object Panel_CaptionLog: TPanel
            Left = 0
            Top = 0
            Width = 714
            Height = 20
            Margins.Left = 0
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '       Logs ...'
            TabOrder = 1
            StyleElements = [seClient, seBorder]
            object SpeedButton_ClearLogBox: TSpeedButton
              Left = 691
              Top = 0
              Width = 23
              Height = 20
              Hint = 'Clear LogBox'
              Align = alRight
              ImageIndex = 7
              ImageName = 'All\ic_delete_sweep_48px'
              Images = SVGIconVirtualImageList1
              OnClick = SpeedButton_ClearLogBoxClick
              ExplicitLeft = 428
              ExplicitTop = 6
            end
            object SpeedButton_GotoChatting: TSpeedButton
              Left = 0
              Top = 0
              Width = 15
              Height = 20
              Cursor = crHandPoint
              Hint = 'Goto Chatting'
              Margins.Left = 0
              Align = alLeft
              ImageIndex = 19
              ImageName = 'ic_chevron_left_48px'
              Images = SVGIconVirtualImageList1
              OnClick = Action_ChattingExecute
            end
            object SpeedButton_SaveAllLoges: TSpeedButton
              AlignWithMargins = True
              Left = 665
              Top = 3
              Width = 23
              Height = 14
              Hint = 'Save All Logs'
              Align = alRight
              ImageIndex = 26
              ImageName = 'ic_save_48px'
              Images = SVGIconVirtualImageList1
              OnClick = SpeedButton_SaveAllLogesClick
              ExplicitLeft = 675
            end
            object CheckBox_DebugToLog: TCheckBox
              AlignWithMargins = True
              Left = 542
              Top = 3
              Width = 110
              Height = 14
              Margins.Right = 10
              Align = alRight
              Caption = 'Response to Log'
              TabOrder = 0
              StyleElements = [seClient, seBorder]
            end
          end
          object Panel_ServerChatting: TPanel
            Left = 0
            Top = 560
            Width = 714
            Height = 150
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            object Panel_BanList: TPanel
              AlignWithMargins = True
              Left = 591
              Top = 3
              Width = 120
              Height = 144
              Margins.Left = 0
              Align = alRight
              BevelOuter = bvNone
              ShowCaption = False
              TabOrder = 0
              object Label2: TLabel
                Left = 0
                Top = 0
                Width = 120
                Height = 20
                Align = alTop
                AutoSize = False
                Caption = '* Checked -> Ban'
                StyleElements = [seClient, seBorder]
                ExplicitWidth = 130
              end
              object CheckListBox_ConnIPs: TCheckListBox
                Left = 0
                Top = 20
                Width = 120
                Height = 124
                Align = alClient
                ItemHeight = 17
                Items.Strings = (
                  '192.168.123.123'
                  '127.0.0.1')
                TabOrder = 0
                OnClickCheck = CheckListBox_ConnIPsClickCheck
              end
            end
            object Panel_RemoteChattBase: TPanel
              Left = 0
              Top = 0
              Width = 591
              Height = 150
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object Memo_ServerChattings: TMemo
                AlignWithMargins = True
                Left = 3
                Top = 23
                Width = 585
                Height = 124
                Align = alClient
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Ctl3D = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clSilver
                Font.Height = -13
                Font.Name = 'Segoe UI'
                Font.Style = []
                Lines.Strings = (
                  'Serve as Remote Chatting'
                  '- Under Construction ...')
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                ScrollBars = ssVertical
                TabOrder = 0
                StyleElements = [seClient, seBorder]
              end
              object Panel_RemoteBroker: TPanel
                Left = 0
                Top = 0
                Width = 591
                Height = 20
                Align = alTop
                Alignment = taLeftJustify
                BevelOuter = bvNone
                Caption = '* Broker'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBtnFace
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object SpeedButton_ShutdownClients: TSpeedButton
                  AlignWithMargins = True
                  Left = 563
                  Top = 0
                  Width = 23
                  Height = 20
                  Hint = 'ShutDowm Broker / All Client'
                  Margins.Left = 0
                  Margins.Top = 0
                  Margins.Right = 5
                  Margins.Bottom = 0
                  Align = alRight
                  ImageIndex = 31
                  ImageName = 'ic_highlight_off_48px'
                  Images = SVGIconVirtualImageList1
                  OnClick = SpeedButton_ShutdownClientsClick
                  ExplicitLeft = 689
                end
                object SpeedButton_ShowRmBroker: TSpeedButton
                  Left = 517
                  Top = 0
                  Width = 23
                  Height = 20
                  Hint = 'Show Ollama Broker'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Align = alRight
                  ImageIndex = 48
                  ImageName = 'ic_storage_48px'
                  Images = SVGIconVirtualImageList1
                  OnClick = SpeedButton_ShowRmBrokerClick
                  ExplicitLeft = 552
                end
                object SpeedButton_GetIPs: TSpeedButton
                  Left = 494
                  Top = 0
                  Width = 23
                  Height = 20
                  Hint = 'Get IP - Local, Public'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Align = alRight
                  ImageIndex = 64
                  ImageName = 'grade_black_24dp'
                  Images = SVGIconVirtualImageList1
                  OnClick = SpeedButton_GetIPsClick
                  ExplicitLeft = 593
                  ExplicitTop = 3
                end
                object SpeedButton_ActivateBroker: TSpeedButton
                  Left = 540
                  Top = 0
                  Width = 23
                  Height = 20
                  Hint = 'Activate Ollama Broker'
                  Margins.Top = 0
                  Margins.Bottom = 0
                  Align = alRight
                  ImageIndex = 61
                  ImageName = 'ic_play_circle_outline_24px'
                  Images = SVGIconVirtualImageList1
                  OnClick = SpeedButton_ActivateBrokerClick
                  ExplicitLeft = 662
                end
                object Label_IP_Port: TLabel
                  AlignWithMargins = True
                  Left = 60
                  Top = 3
                  Width = 431
                  Height = 14
                  Margins.Left = 60
                  Align = alClient
                  AutoSize = False
                  Caption = 'IPs ...'
                  EllipsisPosition = epEndEllipsis
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clSilver
                  Font.Height = -12
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Layout = tlCenter
                  StyleElements = [seClient, seBorder]
                  ExplicitWidth = 28
                  ExplicitHeight = 15
                end
              end
            end
          end
        end
      end
      object Panel_ChatRequestBox: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 769
        Width = 722
        Height = 26
        Margins.Left = 0
        Margins.Right = 0
        Align = alBottom
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 2
        object SpeedButton_ReqMultiline: TSpeedButton
          AlignWithMargins = True
          Left = 0
          Top = 3
          Width = 22
          Height = 20
          Margins.Left = 0
          Action = Action_RequestDialog
          Align = alLeft
          Images = SVGIconVirtualImageList1
          ExplicitLeft = 30
          ExplicitTop = 4
          ExplicitHeight = 22
        end
        object Edit_ReqContent: TEdit
          AlignWithMargins = True
          Left = 28
          Top = 3
          Width = 654
          Height = 20
          Align = alClient
          TabOrder = 0
          OnKeyPress = Edit_ReqContentKeyPress
          ExplicitHeight = 21
        end
        object Button_SendRequest: TButton
          AlignWithMargins = True
          Left = 688
          Top = 3
          Width = 31
          Height = 20
          Action = Action_SendRequest
          Align = alRight
          ImageMargins.Left = 5
          Images = SVGIconVirtualImageList1
          TabOrder = 1
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 828
    Width = 1181
    Height = 19
    DoubleBuffered = True
    Panels = <
      item
        Text = 'Ready ...'
        Width = 600
      end
      item
        Text = 'Elap. 0.000'
        Width = 120
      end
      item
        Alignment = taRightJustify
        Text = 'Stand by'
        Width = 50
      end>
    ParentDoubleBuffered = False
    ParentFont = True
    UseSystemFont = False
    StyleElements = [seClient, seBorder]
  end
  object Panel_Toolbar: TPanel
    Left = 0
    Top = 0
    Width = 1181
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object Label_StartRequest: TLabel
      AlignWithMargins = True
      Left = 99
      Top = 3
      Width = 45
      Height = 24
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Request'
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
    end
    object Label_Caption: TLabel
      AlignWithMargins = True
      Left = 256
      Top = 0
      Width = 819
      Height = 30
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Model in use - phi3'
      EllipsisPosition = epEndEllipsis
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
      ExplicitLeft = 246
      ExplicitWidth = 105
      ExplicitHeight = 15
    end
    object SkSvg_Broker: TSkSvg
      AlignWithMargins = True
      Left = 1090
      Top = 5
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Hint = 'Remote Access (as Broker)'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      OnClick = SkSvg_BrokerClick
      ExplicitLeft = 1050
    end
    object SkSvg_OllamaAlive: TSkSvg
      AlignWithMargins = True
      Left = 71
      Top = 5
      Width = 20
      Height = 20
      Hint = 'Ollama Off'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
    end
    object Button_StartRequest: TButton
      AlignWithMargins = True
      Left = 150
      Top = 3
      Width = 27
      Height = 24
      Action = Action_StartRequest
      Align = alLeft
      Anchors = [akTop, akBottom]
      ImageMargins.Left = 3
      Images = SVGIconVirtualImageList1
      TabOrder = 0
    end
    object Button_Abort: TButton
      AlignWithMargins = True
      Left = 183
      Top = 3
      Width = 27
      Height = 24
      Action = Action_Abort
      Align = alLeft
      Anchors = [akTop, akBottom]
      ImageMargins.Left = 3
      Images = SVGIconVirtualImageList1
      TabOrder = 1
    end
    object Button_About: TButton
      AlignWithMargins = True
      Left = 1151
      Top = 3
      Width = 27
      Height = 24
      Action = Action_About
      Align = alRight
      ImageMargins.Left = 3
      Images = SVGIconVirtualImageList1
      TabOrder = 2
    end
    object Button_Options: TButton
      AlignWithMargins = True
      Left = 1118
      Top = 3
      Width = 27
      Height = 24
      Action = Action_Options
      Align = alRight
      ImageMargins.Left = 3
      Images = SVGIconVirtualImageList1
      TabOrder = 3
    end
    object Button_Chatting: TButton
      AlignWithMargins = True
      Left = 36
      Top = 3
      Width = 27
      Height = 24
      Action = Action_Chatting
      Align = alLeft
      ImageMargins.Left = 3
      Images = SVGIconVirtualImageList1
      TabOrder = 4
    end
    object Button_Home: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 27
      Height = 24
      Action = Action_Home
      Align = alLeft
      ImageMargins.Left = 3
      Images = SVGIconVirtualImageList1
      TabOrder = 5
    end
    object Button_DosCommand: TButton
      AlignWithMargins = True
      Left = 216
      Top = 3
      Width = 27
      Height = 24
      Action = Action_DosCommand
      Align = alLeft
      ImageMargins.Left = 3
      Images = SVGIconVirtualImageList1
      TabOrder = 6
    end
  end
  object ActionList_Ollma: TActionList
    Images = SVGIconVirtualImageList1
    OnUpdate = ActionList_OllmaUpdate
    Left = 416
    Top = 208
    object Action_Options: TAction
      Hint = 'Settings Visable / Toggle'
      ImageIndex = 45
      ImageName = 'ic_more_horiz_48px'
      ShortCut = 32848
      OnExecute = Action_OptionsExecute
    end
    object Action_Exit: TAction
      Caption = 'Exit'
      ImageIndex = 0
      ImageName = 'All\ic_exit_to_app_48px'
      ShortCut = 16474
      OnExecute = Action_ExitExecute
    end
    object Action_StartRequest: TAction
      Hint = 'Start Request  - Multi Lines (F1)'
      ImageIndex = 43
      ImageName = 'chat-118'
      OnExecute = Action_StartRequestExecute
    end
    object Action_Home: TAction
      Hint = 'Got o Welcome'
      ImageIndex = 65
      ImageName = 'llama-svgrepo-com'
      ShortCut = 114
      OnExecute = Action_HomeExecute
    end
    object Action_Chatting: TAction
      Hint = 'Chatting Window'
      ImageIndex = 44
      ImageName = 'ic_border_all_24px'
      ShortCut = 115
      OnExecute = Action_ChattingExecute
    end
    object Action_Logs: TAction
      Hint = 'Log Window'
      ImageIndex = 48
      ImageName = 'ic_storage_48px'
      ShortCut = 32844
      OnExecute = Action_LogsExecute
    end
    object Action_InetAlive: TAction
      Hint = 'Check Alive Ollama'
      ImageIndex = 38
      ImageName = 'ic_panorama_fish_eye_48px'
      ShortCut = 32833
      OnExecute = Action_InetAliveExecute
    end
    object Action_SendRequest: TAction
      Hint = 'Sen Request'
      ImageIndex = 12
      ImageName = 'All\ic_send_48px'
      ShortCut = 113
      OnExecute = Action_SendRequestExecute
    end
    object Action_Abort: TAction
      Hint = 'Stop / Abort'
      ImageIndex = 51
      ImageName = 'ic_pause_48px'
      ShortCut = 16449
      OnExecute = Action_AbortExecute
    end
    object Action_Pop_CopyText: TAction
      Hint = 'Copy Text of Selected Massage'
      ImageIndex = 25
      ImageName = 'ic_copyright_48px'
      ShortCut = 32835
      OnExecute = Action_Pop_CopyTextExecute
    end
    object Action_Pop_DeleteItem: TAction
      Hint = 'Delete Selected Message'
      ImageIndex = 31
      ImageName = 'ic_highlight_off_48px'
      ShortCut = 32836
      OnExecute = Action_Pop_DeleteItemExecute
    end
    object Action_Pop_ScrollToTop: TAction
      Hint = 'Scroll to Top'
      ImageIndex = 35
      ImageName = 'ic_file_upload_48px'
      ShortCut = 32852
      OnExecute = Action_Pop_ScrollToTopExecute
    end
    object Action_Pop_ScrollToBottom: TAction
      Hint = 'Scroll To Bottom'
      ImageIndex = 34
      ImageName = 'ic_file_download_48px'
      ShortCut = 32834
      OnExecute = Action_Pop_ScrollToBottomExecute
    end
    object Action_Pop_SaveAllText: TAction
      Hint = 'Save All Message to Text'
      ImageIndex = 26
      ImageName = 'ic_save_48px'
      ShortCut = 32851
      OnExecute = Action_Pop_SaveAllTextExecute
    end
    object Action_TTS: TAction
      Hint = 'TTS - Start / Stop'
      ImageIndex = 47
      ImageName = 'ic_record_voice_over_48px'
      ShortCut = 32854
      OnExecute = Action_TTSExecute
    end
    object Action_TransMessage: TAction
      Hint = 'Translation'
      ImageIndex = 40
      ImageName = 'ic_text_fields_48px'
      ShortCut = 117
      OnExecute = Action_TranslationCommon
    end
    object Action_TransMessagePush: TAction
      Tag = 2
      Caption = 'Trans And Insert'
      ImageIndex = 40
      ImageName = 'ic_text_fields_48px'
      OnExecute = Action_TranslationCommon
    end
    object Action_TransPrompt: TAction
      Tag = 1
      Hint = 'TransLation'
      ImageIndex = 39
      ImageName = 'ic_format_size_48px'
      ShortCut = 116
      OnExecute = Action_TranslationCommon
    end
    object Action_TransPromptPush: TAction
      Tag = 3
      Caption = 'Action_TransPromptPush'
      ImageIndex = 39
      ImageName = 'ic_format_size_48px'
      OnExecute = Action_TranslationCommon
    end
    object Action_DefaultRefresh: TAction
      Hint = 'Reset'
      ImageIndex = 24
      ImageName = 'ic_refresh_48px'
      ShortCut = 16466
      OnExecute = Action_DefaultRefreshExecute
    end
    object Action_DosCommand: TAction
      Hint = 'Dos Command Mode'
      ImageIndex = 67
      ImageName = 'DosIcon_48'
      OnExecute = Action_DosCommandExecute
    end
    object Action_ClearChatting: TAction
      Hint = 'Clear Chattings'
      ImageIndex = 33
      ImageName = 'ic_crop_din_48px'
      ShortCut = 121
      OnExecute = Action_ClearChattingExecute
    end
    object Action_LoadImageSource: TAction
      Hint = 'Image for Llava'
      ImageIndex = 14
      ImageName = 'ic_add_48px'
      ShortCut = 32839
      OnExecute = Action_LoadImageSourceExecute
    end
    object Action_RequestDialog: TAction
      Hint = 'Request Dialog - Multi Lines'
      ImageIndex = 43
      ImageName = 'chat-118'
      ShortCut = 112
      OnExecute = Action_RequestDialogExecute
    end
    object Action_About: TAction
      Hint = 'About'
      ImageIndex = 11
      ImageName = 'All\ic_settings_48px'
      ShortCut = 32855
      OnExecute = Action_AboutExecute
    end
    object Action_SelectionColor: TAction
      Hint = 'Skin / Colors'
      ImageIndex = 63
      ImageName = 'ic_apps_48px'
      ShortCut = 32837
      OnExecute = Action_SelectionColorExecute
    end
    object Action_CustomFontColor: TAction
      Hint = 'Custon Font Color'
      ImageIndex = 58
      ImageName = 'ic_title_48px'
    end
    object Action_TTSControl: TAction
      Hint = 'TTS Control'
      ImageIndex = 30
      ImageName = 'ic_surround_sound_48px'
      ShortCut = 32849
      OnExecute = Action_TTSControlExecute
    end
    object Action_HelpShortcuts: TAction
      Caption = 'Help-Shortcuts'
      ShortCut = 32840
      OnExecute = Action_HelpShortcutsExecute
    end
    object Action_ApplyChange: TAction
      Caption = 'Action_ApplyChange'
      OnExecute = Action_ApplyChangeExecute
    end
    object Action_SHowBroker: TAction
      Caption = 'Action_SHowBroker'
      OnExecute = Action_SHowBrokerExecute
    end
    object Action_LoadHistory: TAction
      Hint = 'Load History'
      ImageIndex = 16
      ImageName = 'ic_alarm_on_24px'
      ShortCut = 32838
      OnExecute = Action_LoadHistoryExecute
    end
    object Action_AddToHistory: TAction
      Hint = 'Add / Update to History'
      ImageIndex = 14
      ImageName = 'ic_add_48px'
      ShortCut = 32841
      OnExecute = Action_AddToHistoryExecute
    end
    object Action_DelToHistory: TAction
      Hint = 'Delete to History View'
      ImageIndex = 49
      ImageName = 'ic_remove_48px'
      OnExecute = Action_DelToHistoryExecute
    end
    object Action_ClearHistory: TAction
      Caption = 'Clear History'
      Hint = 'Clear History'
      ImageIndex = 33
      ImageName = 'ic_crop_din_48px'
      OnExecute = Action_ClearHistoryExecute
    end
    object Action_ClearAllHistory: TAction
      Caption = 'Clear All History Data'
      ImageIndex = 15
      ImageName = 'ic_close_48px'
      OnExecute = Action_ClearAllHistoryExecute
    end
    object Action_CLearanceHistory: TAction
      Caption = 'Clearance History (View=Data)'
      Hint = 'Update History'
      ImageIndex = 15
      ImageName = 'ic_close_48px'
      OnExecute = Action_CLearanceHistoryExecute
    end
    object Action_SaveToHistory: TAction
      Hint = 'Save / Replace'
      ImageIndex = 57
      ImageName = 'ic_explicit_48px'
      ShortCut = 32843
      OnExecute = Action_SaveToHistoryExecute
    end
  end
  object SVGIconVirtualImageList1: TSVGIconVirtualImageList
    AutoFill = True
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'All\ic_exit_to_app_48px'
        Name = 'All\ic_exit_to_app_48px'
      end
      item
        CollectionIndex = 1
        CollectionName = 'All\ic_stop_48px'
        Name = 'All\ic_stop_48px'
      end
      item
        CollectionIndex = 2
        CollectionName = 'All\ic_home_48px'
        Name = 'All\ic_home_48px'
      end
      item
        CollectionIndex = 3
        CollectionName = 'All\ic_info_outline_48px'
        Name = 'All\ic_info_outline_48px'
      end
      item
        CollectionIndex = 4
        CollectionName = 'All\ic_hourglass_empty_48px'
        Name = 'All\ic_hourglass_empty_48px'
      end
      item
        CollectionIndex = 5
        CollectionName = 'All\ic_insert_emoticon_48px'
        Name = 'All\ic_insert_emoticon_48px'
      end
      item
        CollectionIndex = 6
        CollectionName = 'All\ic_delete_48px'
        Name = 'All\ic_delete_48px'
      end
      item
        CollectionIndex = 7
        CollectionName = 'All\ic_delete_sweep_48px'
        Name = 'All\ic_delete_sweep_48px'
      end
      item
        CollectionIndex = 8
        CollectionName = 'All\ic_dehaze_48px'
        Name = 'All\ic_dehaze_48px'
      end
      item
        CollectionIndex = 9
        CollectionName = 'All\ic_settings_applications_48px'
        Name = 'All\ic_settings_applications_48px'
      end
      item
        CollectionIndex = 10
        CollectionName = 'All\ic_settings_input_component_48px'
        Name = 'All\ic_settings_input_component_48px'
      end
      item
        CollectionIndex = 11
        CollectionName = 'All\ic_settings_48px'
        Name = 'All\ic_settings_48px'
      end
      item
        CollectionIndex = 12
        CollectionName = 'All\ic_send_48px'
        Name = 'All\ic_send_48px'
      end
      item
        CollectionIndex = 13
        CollectionName = 'All\ic_adjust_48px'
        Name = 'All\ic_adjust_48px'
      end
      item
        CollectionIndex = 14
        CollectionName = 'ic_add_48px'
        Name = 'ic_add_48px'
      end
      item
        CollectionIndex = 15
        CollectionName = 'ic_close_48px'
        Name = 'ic_close_48px'
      end
      item
        CollectionIndex = 16
        CollectionName = 'ic_alarm_on_24px'
        Name = 'ic_alarm_on_24px'
      end
      item
        CollectionIndex = 17
        CollectionName = 'ic_center_focus_weak_48px'
        Name = 'ic_center_focus_weak_48px'
      end
      item
        CollectionIndex = 18
        CollectionName = 'ic_change_history_48px'
        Name = 'ic_change_history_48px'
      end
      item
        CollectionIndex = 19
        CollectionName = 'ic_chevron_left_48px'
        Name = 'ic_chevron_left_48px'
      end
      item
        CollectionIndex = 20
        CollectionName = 'ic_chevron_right_48px'
        Name = 'ic_chevron_right_48px'
      end
      item
        CollectionIndex = 21
        CollectionName = 'ic_info_outline_48px'
        Name = 'ic_info_outline_48px'
      end
      item
        CollectionIndex = 22
        CollectionName = 'ic_settings_power_48px'
        Name = 'ic_settings_power_48px'
      end
      item
        CollectionIndex = 23
        CollectionName = 'ic_settings_input_antenna_48px'
        Name = 'ic_settings_input_antenna_48px'
      end
      item
        CollectionIndex = 24
        CollectionName = 'ic_refresh_48px'
        Name = 'ic_refresh_48px'
      end
      item
        CollectionIndex = 25
        CollectionName = 'ic_copyright_48px'
        Name = 'ic_copyright_48px'
      end
      item
        CollectionIndex = 26
        CollectionName = 'ic_save_48px'
        Name = 'ic_save_48px'
      end
      item
        CollectionIndex = 27
        CollectionName = 'ic_check_48px'
        Name = 'ic_check_48px'
      end
      item
        CollectionIndex = 28
        CollectionName = 'ic_expand_less_48px'
        Name = 'ic_expand_less_48px'
      end
      item
        CollectionIndex = 29
        CollectionName = 'ic_expand_more_48px'
        Name = 'ic_expand_more_48px'
      end
      item
        CollectionIndex = 30
        CollectionName = 'ic_surround_sound_48px'
        Name = 'ic_surround_sound_48px'
      end
      item
        CollectionIndex = 31
        CollectionName = 'ic_highlight_off_48px'
        Name = 'ic_highlight_off_48px'
      end
      item
        CollectionIndex = 32
        CollectionName = 'ic_control_point_48px'
        Name = 'ic_control_point_48px'
      end
      item
        CollectionIndex = 33
        CollectionName = 'ic_crop_din_48px'
        Name = 'ic_crop_din_48px'
      end
      item
        CollectionIndex = 34
        CollectionName = 'ic_file_download_48px'
        Name = 'ic_file_download_48px'
      end
      item
        CollectionIndex = 35
        CollectionName = 'ic_file_upload_48px'
        Name = 'ic_file_upload_48px'
      end
      item
        CollectionIndex = 36
        CollectionName = 'ic_help_outline_24px'
        Name = 'ic_help_outline_24px'
      end
      item
        CollectionIndex = 37
        CollectionName = 'ic_more_vert_48px'
        Name = 'ic_more_vert_48px'
      end
      item
        CollectionIndex = 38
        CollectionName = 'ic_panorama_fish_eye_48px'
        Name = 'ic_panorama_fish_eye_48px'
      end
      item
        CollectionIndex = 39
        CollectionName = 'ic_format_size_48px'
        Name = 'ic_format_size_48px'
      end
      item
        CollectionIndex = 40
        CollectionName = 'ic_text_fields_48px'
        Name = 'ic_text_fields_48px'
      end
      item
        CollectionIndex = 41
        CollectionName = 'ic_chat_48px'
        Name = 'ic_chat_48px'
      end
      item
        CollectionIndex = 42
        CollectionName = 'ic_favorite_border_48px'
        Name = 'ic_favorite_border_48px'
      end
      item
        CollectionIndex = 43
        CollectionName = 'chat-118'
        Name = 'chat-118'
      end
      item
        CollectionIndex = 44
        CollectionName = 'ic_border_all_24px'
        Name = 'ic_border_all_24px'
      end
      item
        CollectionIndex = 45
        CollectionName = 'ic_more_horiz_48px'
        Name = 'ic_more_horiz_48px'
      end
      item
        CollectionIndex = 46
        CollectionName = 'ic_pause_circle_outline_48px'
        Name = 'ic_pause_circle_outline_48px'
      end
      item
        CollectionIndex = 47
        CollectionName = 'ic_record_voice_over_48px'
        Name = 'ic_record_voice_over_48px'
      end
      item
        CollectionIndex = 48
        CollectionName = 'ic_storage_48px'
        Name = 'ic_storage_48px'
      end
      item
        CollectionIndex = 49
        CollectionName = 'ic_remove_48px'
        Name = 'ic_remove_48px'
      end
      item
        CollectionIndex = 50
        CollectionName = 'ic_queue_48px'
        Name = 'ic_queue_48px'
      end
      item
        CollectionIndex = 51
        CollectionName = 'ic_pause_48px'
        Name = 'ic_pause_48px'
      end
      item
        CollectionIndex = 52
        CollectionName = 'bubble_chart_black_24dp'
        Name = 'bubble_chart_black_24dp'
      end
      item
        CollectionIndex = 53
        CollectionName = 'ic_add_box_48px'
        Name = 'ic_add_box_48px'
      end
      item
        CollectionIndex = 54
        CollectionName = 'ic_format_align_left_18px'
        Name = 'ic_format_align_left_18px'
      end
      item
        CollectionIndex = 55
        CollectionName = 'ic_swap_vert_48px'
        Name = 'ic_swap_vert_48px'
      end
      item
        CollectionIndex = 56
        CollectionName = 'ic_unfold_more_48px'
        Name = 'ic_unfold_more_48px'
      end
      item
        CollectionIndex = 57
        CollectionName = 'ic_explicit_48px'
        Name = 'ic_explicit_48px'
      end
      item
        CollectionIndex = 58
        CollectionName = 'ic_title_48px'
        Name = 'ic_title_48px'
      end
      item
        CollectionIndex = 59
        CollectionName = 'ic_attachment_48px'
        Name = 'ic_attachment_48px'
      end
      item
        CollectionIndex = 60
        CollectionName = 'ic_insert_photo_48px'
        Name = 'ic_insert_photo_48px'
      end
      item
        CollectionIndex = 61
        CollectionName = 'ic_play_circle_outline_24px'
        Name = 'ic_play_circle_outline_24px'
      end
      item
        CollectionIndex = 62
        CollectionName = 'ic_build_48px'
        Name = 'ic_build_48px'
      end
      item
        CollectionIndex = 63
        CollectionName = 'ic_apps_48px'
        Name = 'ic_apps_48px'
      end
      item
        CollectionIndex = 64
        CollectionName = 'grade_black_24dp'
        Name = 'grade_black_24dp'
      end
      item
        CollectionIndex = 65
        CollectionName = 'llama-svgrepo-com'
        Name = 'llama-svgrepo-com'
      end
      item
        CollectionIndex = 66
        CollectionName = 'stop-button'
        Name = 'stop-button'
      end
      item
        CollectionIndex = 67
        CollectionName = 'DosIcon_48'
        Name = 'DosIcon_48'
      end
      item
        CollectionIndex = 68
        CollectionName = 'logonicon'
        Name = 'logonicon'
      end
      item
        CollectionIndex = 69
        CollectionName = 'All\Connection'
        Name = 'All\Connection'
      end
      item
        CollectionIndex = 70
        CollectionName = 'ic_record_voice2'
        Name = 'ic_record_voice2'
      end>
    ImageCollection = SVGIconImageCollection1
    PreserveItems = True
    Left = 660
    Top = 183
  end
  object SVGIconImageCollection1: TSVGIconImageCollection
    SVGIconItems = <
      item
        IconName = 'All\ic_exit_to_app_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M20.17 31.17L23 34l10-10-10-10-2.83 2.83L25.34 22H6' +
          'v4h19.34l-5.17 5.17zM38 6H10c-2.21 0-4 1.79-4 4v8h4v-8h28v28H10v' +
          '-8H6v8c0 2.21 1.79 4 4 4h28c2.21 0 4-1.79 4-4V10c0-2.21-1.79-4-4' +
          '-4z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_stop_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M12 12h24v24H12z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_home_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M20 40V28h8v12h10V24h6L24 6 4 ' +
          '24h6v16z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_info_outline_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M22 34h4V22h-4v12zm2-30C12.95 4 4 12.95 4 24s8.95 2' +
          '0 20 20 20-8.95 20-20S35.05 4 24 4zm0 36c-8.82 0-16-7.18-16-16S1' +
          '5.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm-2-22h4v-4h-4v4z"/>'#13#10'</' +
          'svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_hourglass_empty_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M12 5v10l9 9-9 9v10h24V33l-9-9' +
          ' 9-9V5H12zm20 29v5H16v-5l8-8 8 8zm-8-12l-8-8V9h16v5l-8 8z"/>'#13#10'  ' +
          '  <path fill="none" d="M0 0h48v48H0V0z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_insert_emoticon_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M23.99 4C12.94 4 4 12.95 4 24s8.94 20 19.99 20C35.0' +
          '4 44 44 35.05 44 24S35.04 4 23.99 4zM24 40c-8.84 0-16-7.16-16-16' +
          'S15.16 8 24 8s16 7.16 16 16-7.16 16-16 16zm7-18c1.66 0 3-1.34 3-' +
          '3s-1.34-3-3-3-3 1.34-3 3 1.34 3 3 3zm-14 0c1.66 0 3-1.34 3-3s-1.' +
          '34-3-3-3-3 1.34-3 3 1.34 3 3 3zm7 13c4.66 0 8.61-2.91 10.21-7H13' +
          '.79c1.6 4.09 5.55 7 10.21 7z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_delete_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M12 38c0 2.21 1.79 4 4 4h16c2.' +
          '21 0 4-1.79 4-4V14H12v24zM38 8h-7l-2-2H19l-2 2h-7v4h28V8z"/>'#13#10'  ' +
          '  <path d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_delete_sweep_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M30 32h8v4h-8zm0-16h14v4H30zm0' +
          ' 8h12v4H30zM6 36c0 2.2 1.8 4 4 4h12c2.2 0 4-1.8 4-4V16H6v20zm22-' +
          '26h-6l-2-2h-8l-2 2H4v4h24z"/>'#13#10'    <path fill="none" d="M0 0h48v' +
          '48H0z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_dehaze_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M4 31v4h40v-4H4zm0-10v4h40v-4H' +
          '4zm0-10v4h40v-4H4z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>' +
          #13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_settings_applications_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M24 20c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.7' +
          '9-4-4-4zM38 6H10c-2.21 0-4 1.79-4 4v28c0 2.21 1.79 4 4 4h28c2.21' +
          ' 0 4-1.79 4-4V10c0-2.21-1.79-4-4-4zm-3.5 18c0 .46-.04.92-.1 1.37' +
          'l2.96 2.32c.26.21.34.59.16.89l-2.8 4.85c-.17.3-.54.42-.86.3l-3.4' +
          '9-1.41c-.72.56-1.51 1.02-2.37 1.38l-.52 3.71c-.04.33-.33.59-.68.' +
          '59h-5.6c-.35 0-.64-.26-.69-.59l-.52-3.71c-.85-.35-1.64-.82-2.37-' +
          '1.38l-3.48 1.4c-.32.12-.68 0-.86-.3l-2.8-4.85c-.18-.3-.1-.68.16-' +
          '.89l2.96-2.31c-.06-.45-.1-.9-.1-1.37 0-.46.04-.92.1-1.37l-2.96-2' +
          '.31c-.26-.21-.34-.59-.16-.89l2.8-4.85c.18-.3.54-.42.86-.3l3.48 1' +
          '.4c.72-.55 1.51-1.02 2.37-1.38l.52-3.71c.05-.33.34-.59.69-.59h5.' +
          '6c.35 0 .64.26.69.59l.52 3.71c.85.35 1.64.82 2.37 1.38l3.48-1.4c' +
          '.32-.12.68 0 .86.3l2.8 4.85c.18.3.1.68-.16.89l-2.96 2.32c.06.44.' +
          '1.9.1 1.36z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_settings_input_component_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M10 4c0-1.1-.89-2-2-2s-2 .9-2 2v8H2v12h12V12h-4V4zm' +
          '8 28c0 2.61 1.68 4.81 4 5.63V46h4v-8.37c2.32-.83 4-3.02 4-5.63v-' +
          '4H18v4zM2 32c0 2.61 1.68 4.81 4 5.63V46h4v-8.37c2.32-.83 4-3.02 ' +
          '4-5.63v-4H2v4zm40-20V4c0-1.1-.89-2-2-2s-2 .9-2 2v8h-4v12h12V12h-' +
          '4zM26 4c0-1.1-.89-2-2-2s-2 .9-2 2v8h-4v12h12V12h-4V4zm8 28c0 2.6' +
          '1 1.68 4.81 4 5.63V46h4v-8.37c2.32-.83 4-3.02 4-5.63v-4H34v4z"/>' +
          #13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_settings_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M38.86 25.95c.08-.64.14-1.29.14-1.95s-.06-1.31-.14-' +
          '1.95l4.23-3.31c.38-.3.49-.84.24-1.28l-4-6.93c-.25-.43-.77-.61-1.' +
          '22-.43l-4.98 2.01c-1.03-.79-2.16-1.46-3.38-1.97L29 4.84c-.09-.47' +
          '-.5-.84-1-.84h-8c-.5 0-.91.37-.99.84l-.75 5.3c-1.22.51-2.35 1.17' +
          '-3.38 1.97L9.9 10.1c-.45-.17-.97 0-1.22.43l-4 6.93c-.25.43-.14.9' +
          '7.24 1.28l4.22 3.31C9.06 22.69 9 23.34 9 24s.06 1.31.14 1.95l-4.' +
          '22 3.31c-.38.3-.49.84-.24 1.28l4 6.93c.25.43.77.61 1.22.43l4.98-' +
          '2.01c1.03.79 2.16 1.46 3.38 1.97l.75 5.3c.08.47.49.84.99.84h8c.5' +
          ' 0 .91-.37.99-.84l.75-5.3c1.22-.51 2.35-1.17 3.38-1.97l4.98 2.01' +
          'c.45.17.97 0 1.22-.43l4-6.93c.25-.43.14-.97-.24-1.28l-4.22-3.31z' +
          'M24 31c-3.87 0-7-3.13-7-7s3.13-7 7-7 7 3.13 7 7-3.13 7-7 7z"/>'#13#10 +
          '</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_send_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M4.02 42L46 24 4.02 6 4 20l30 ' +
          '4-30 4z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'All\ic_adjust_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M24 4C12.97 4 4 12.97 4 24s8.9' +
          '7 20 20 20 20-8.97 20-20S35.03 4 24 4zm0 36c-8.82 0-16-7.18-16-1' +
          '6S15.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm6-16c0 3.31-2.69 6-6' +
          ' 6s-6-2.69-6-6 2.69-6 6-6 6 2.69 6 6z"/>'#13#10'    <path d="M0 0h48v4' +
          '8H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_add_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M38 26H26v12h-4V26H10v-4h12V10' +
          'h4v12h12v4z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg' +
          '>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_close_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M38 12.83L35.17 10 24 21.17 12' +
          '.83 10 10 12.83 21.17 24 10 35.17 12.83 38 24 26.83 35.17 38 38 ' +
          '35.17 26.83 24z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10'<' +
          '/svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_alarm_on_24px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" v' +
          'iewBox="0 0 24 24">'#13#10'    <path d="M0 0h24v24H0z" fill="none"/>'#13#10 +
          '    <path d="M22 5.72l-4.6-3.86-1.29 1.53 4.6 3.86L22 5.72zM7.88' +
          ' 3.39L6.6 1.86 2 5.71l1.29 1.53 4.59-3.85zM12 4c-4.97 0-9 4.03-9' +
          ' 9s4.02 9 9 9c4.97 0 9-4.03 9-9s-4.03-9-9-9zm0 16c-3.87 0-7-3.13' +
          '-7-7s3.13-7 7-7 7 3.13 7 7-3.13 7-7 7zm-1.46-5.47L8.41 12.4l-1.0' +
          '6 1.06 3.18 3.18 6-6-1.06-1.06-4.93 4.95z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_center_focus_weak_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M10 30H6v8c0 2.21 1.79 4 4 4h8v-4h-8v-8zm0-20h8V6h-' +
          '8c-2.21 0-4 1.79-4 4v8h4v-8zm28-4h-8v4h8v8h4v-8c0-2.21-1.79-4-4-' +
          '4zm0 32h-8v4h8c2.21 0 4-1.79 4-4v-8h-4v8zM24 16c-4.42 0-8 3.58-8' +
          ' 8s3.58 8 8 8 8-3.58 8-8-3.58-8-8-8zm0 12c-2.21 0-4-1.79-4-4s1.7' +
          '9-4 4-4 4 1.79 4 4-1.79 4-4 4z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_change_history_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path fill="none" d="M-838-2232H562v360' +
          '0H-838v-3600z"/>'#13#10'    <path d="M24 15.55L36.78 36H11.22L24 15.55' +
          'M24 8L4 40h40L24 8z"/>'#13#10'    <path fill="none" d="M0 0h48v48H0V0z' +
          '"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_chevron_left_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M30.83 14.83L28 12 16 24l12 12' +
          ' 2.83-2.83L21.66 24z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"' +
          '/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_chevron_right_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M20 12l-2.83 2.83L26.34 24l-9.' +
          '17 9.17L20 36l12-12z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"' +
          '/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_info_outline_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M22 34h4V22h-4v12zm2-30C12.95 4 4 12.95 4 24s8.95 2' +
          '0 20 20 20-8.95 20-20S35.05 4 24 4zm0 36c-8.82 0-16-7.18-16-16S1' +
          '5.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm-2-22h4v-4h-4v4z"/>'#13#10'</' +
          'svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_settings_power_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M14 48h4v-4h-4v4zm8 0h4v-4h-4v4zm4-44h-4v20h4V4zm7.' +
          '13 4.87l-2.89 2.89C33.69 13.87 36 17.66 36 22c0 6.63-5.37 12-12 ' +
          '12s-12-5.37-12-12c0-4.34 2.31-8.13 5.76-10.24l-2.89-2.89C10.72 1' +
          '1.76 8 16.56 8 22c0 8.84 7.16 16 16 16s16-7.16 16-16c0-5.44-2.72' +
          '-10.24-6.87-13.13zM30 48h4v-4h-4v4z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_settings_input_antenna_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M24 10c-7.73 0-14 6.27-14 14h4c0-5.52 4.48-10 10-10' +
          's10 4.48 10 10h4c0-7.73-6.27-14-14-14zm2 18.58c1.76-.77 3-2.53 3' +
          '-4.58 0-2.76-2.24-5-5-5s-5 2.24-5 5c0 2.05 1.24 3.81 3 4.58v6.59' +
          'L15.17 42 18 44.83l6-6 6 6L32.83 42 26 35.17v-6.59zM24 2C11.85 2' +
          ' 2 11.85 2 24h4c0-9.94 8.06-18 18-18s18 8.06 18 18h4c0-12.15-9.8' +
          '5-22-22-22z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_refresh_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M35.3 12.7C32.41 9.8 28.42 8 2' +
          '4 8 15.16 8 8.02 15.16 8.02 24S15.16 40 24 40c7.45 0 13.69-5.1 1' +
          '5.46-12H35.3c-1.65 4.66-6.07 8-11.3 8-6.63 0-12-5.37-12-12s5.37-' +
          '12 12-12c3.31 0 6.28 1.38 8.45 3.55L26 22h14V8l-4.7 4.7z"/>'#13#10'   ' +
          ' <path d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_copyright_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.' +
          'w3.org/1999/xlink" width="48" height="48" viewBox="0 0 48 48">'#13#10 +
          '    <defs>'#13#10'        <path id="a" d="M48 0v48H0V0h48z"/>'#13#10'    </d' +
          'efs>'#13#10'    <clipPath id="b">'#13#10'        <use xlink:href="#a" overfl' +
          'ow="visible"/>'#13#10'    </clipPath>'#13#10'    <path d="M24 4C12.95 4 4 12' +
          '.95 4 24s8.95 20 20 20 20-8.95 20-20S35.05 4 24 4zm0 36c-8.82 0-' +
          '16-7.18-16-16S15.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm-3.84-18' +
          '.27c.11-.65.31-1.23.6-1.74s.69-.92 1.18-1.23c.47-.29 1.06-.45 1.' +
          '79-.46.48.01.92.09 1.3.26.41.18.75.42 1.04.72s.51.66.67 1.06.25.' +
          '83.27 1.28h3.58c-.03-.94-.22-1.8-.55-2.58s-.81-1.45-1.41-2.02-1.' +
          '32-1-2.16-1.31-1.77-.47-2.79-.47c-1.3 0-2.43.22-3.39.67s-1.76 1.' +
          '06-2.4 1.84-1.12 1.68-1.43 2.71-.46 2.12-.46 3.27v.55c0 1.16.16 ' +
          '2.25.47 3.28s.79 1.93 1.43 2.7 1.44 1.38 2.41 1.83 2.1.67 3.4.67' +
          'c.94 0 1.82-.15 2.64-.46s1.54-.73 2.16-1.27 1.12-1.16 1.48-1.88.' +
          '57-1.48.6-2.3h-3.58c-.02.42-.12.8-.3 1.16s-.42.66-.72.91-.65.45-' +
          '1.05.59c-.38.13-.78.2-1.21.2-.72-.02-1.31-.17-1.79-.47-.5-.32-.9' +
          '-.73-1.19-1.24s-.49-1.09-.6-1.75-.15-1.3-.15-1.97v-.55c0-.68.05-' +
          '1.35.16-2z" clip-path="url(#b)"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_save_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M34 6H10c-2.21 0-4 1.79-4 4v28c0 2.21 1.79 4 4 4h28' +
          'c2.21 0 4-1.79 4-4V14l-8-8zM24 38c-3.31 0-6-2.69-6-6s2.69-6 6-6 ' +
          '6 2.69 6 6-2.69 6-6 6zm6-20H10v-8h20v8z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_check_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M18 32.34L9.66 24l-2.83 2.83L18 38l24-24-2.83-2.83z' +
          '"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_expand_less_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M24 16L12 28l2.83 2.83L24 21.6' +
          '6l9.17 9.17L36 28z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>' +
          #13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_expand_more_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M33.17 17.17L24 26.34l-9.17-9.' +
          '17L12 20l12 12 12-12z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none' +
          '"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_surround_sound_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M40 8H8c-2.21 0-4 1.79-4 4v24c0 2.21 1.79 4 4 4h32c' +
          '2.21 0 4-1.79 4-4V12c0-2.21-1.79-4-4-4zM15.51 32.49l-2.83 2.83C9' +
          '.57 32.19 8 28.1 8 24c0-4.1 1.57-8.19 4.69-11.31l2.83 2.83C13.18' +
          ' 17.85 12 20.93 12 24c0 3.07 1.17 6.15 3.51 8.49zM24 32c-4.42 0-' +
          '8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm11.31 3.31l-2.83-2.' +
          '83C34.83 30.15 36 27.07 36 24c0-3.07-1.18-6.15-3.51-8.49l2.83-2.' +
          '83C38.43 15.81 40 19.9 40 24c0 4.1-1.57 8.19-4.69 11.31zM24 20c-' +
          '2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_highlight_off_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M29.17 16L24 21.17 18.83 16 16 18.83 21.17 24 16 29' +
          '.17 18.83 32 24 26.83 29.17 32 32 29.17 26.83 24 32 18.83 29.17 ' +
          '16zM24 4C12.95 4 4 12.95 4 24s8.95 20 20 20 20-8.95 20-20S35.05 ' +
          '4 24 4zm0 36c-8.82 0-16-7.18-16-16S15.18 8 24 8s16 7.18 16 16-7.' +
          '18 16-16 16z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_control_point_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M26 14h-4v8h-8v4h8v8h4v-8h8v-4' +
          'h-8v-8zM24 4C12.97 4 4 12.97 4 24s8.97 20 20 20 20-8.97 20-20S35' +
          '.03 4 24 4zm0 36c-8.82 0-16-7.18-16-16S15.18 8 24 8s16 7.18 16 1' +
          '6-7.18 16-16 16z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_crop_din_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M38 6H10c-2.21 0-4 1.79-4 4v28c0 2.21 1.79 4 4 4h28' +
          'c2.21 0 4-1.79 4-4V10c0-2.21-1.79-4-4-4zm0 32H10V10h28v28z"/>'#13#10'<' +
          '/svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_file_download_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M38 18h-8V6H18v12h-8l14 14 14-' +
          '14zM10 36v4h28v-4H10z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none' +
          '"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_file_upload_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M18 32h12V20h8L24 6 10 20h8zm-8 4h28v4H10z"/>'#13#10'</sv' +
          'g>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_help_outline_24px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" v' +
          'iewBox="0 0 24 24">'#13#10'    <path fill="none" d="M0 0h24v24H0z"/>'#13#10 +
          '    <path d="M11 18h2v-2h-2v2zm1-16C6.48 2 2 6.48 2 12s4.48 10 1' +
          '0 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 ' +
          '8-8 8 3.59 8 8-3.59 8-8 8zm0-14c-2.21 0-4 1.79-4 4h2c0-1.1.9-2 2' +
          '-2s2 .9 2 2c0 2-3 1.75-3 5h2c0-2.25 3-2.5 3-5 0-2.21-1.79-4-4-4z' +
          '"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_more_vert_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M24 16c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.7' +
          '9 4 4 4zm0 4c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4' +
          'zm0 12c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4z"/>'#13#10 +
          '</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_panorama_fish_eye_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M24 4C12.95 4 4 12.95 4 24s8.95 20 20 20 20-8.95 20' +
          '-20S35.05 4 24 4zm0 36c-8.82 0-16-7.18-16-16S15.18 8 24 8s16 7.1' +
          '8 16 16-7.18 16-16 16z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_format_size_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M18 8v6h10v24h6V14h10V8H18zM6 24h6v14h6V24h6v-6H6v6' +
          'z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_text_fields_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.' +
          'w3.org/1999/xlink" width="48" height="48" viewBox="0 0 48 48">'#13#10 +
          '    <defs>'#13#10'        <path id="a" d="M48 48H0V0h48v48z"/>'#13#10'    </' +
          'defs>'#13#10'    <clipPath id="b">'#13#10'        <use xlink:href="#a" overf' +
          'low="visible"/>'#13#10'    </clipPath>'#13#10'    <path clip-path="url(#b)" ' +
          'd="M5 8v6h10v24h6V14h10V8H5zm38 10H25v6h6v14h6V24h6v-6z"/>'#13#10'</sv' +
          'g>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_chat_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M40 4H8C5.79 4 4.02 5.79 4.02 ' +
          '8L4 44l8-8h28c2.21 0 4-1.79 4-4V8c0-2.21-1.79-4-4-4zM12 18h24v4H' +
          '12v-4zm16 10H12v-4h16v4zm8-12H12v-4h24v4z"/>'#13#10'    <path d="M0 0h' +
          '48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_favorite_border_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M33 6c-3.48 0-6.82 1.62-9 4.17C21.82 7.62 18.48 6 1' +
          '5 6 8.83 6 4 10.83 4 17c0 7.55 6.8 13.72 17.1 23.07L24 42.7l2.9-' +
          '2.63C37.2 30.72 44 24.55 44 17c0-6.17-4.83-11-11-11zm-8.79 31.11' +
          'l-.21.19-.21-.19C14.28 28.48 8 22.78 8 17c0-3.99 3.01-7 7-7 3.08' +
          ' 0 6.08 1.99 7.13 4.72h3.73C26.92 11.99 29.92 10 33 10c3.99 0 7 ' +
          '3.01 7 7 0 5.78-6.28 11.48-15.79 20.11z"/>'#13#10'</svg>'#13#10
        FixedColor = clWindow
      end
      item
        IconName = 'chat-118'
        SVGText = 
          '<svg class="svg-icon" style="width: 1em; height: 1em;vertical-al' +
          'ign: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1' +
          '024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"><path' +
          ' d="M919.192216 976.840649a42.620541 42.620541 0 0 1-21.919135-6' +
          '.088649l-185.094919-110.675027A560.95827 560.95827 0 0 1 512 896' +
          '.249081c-274.681081 0-498.162162-192.982486-498.162162-430.19070' +
          '3C13.837838 228.850162 237.318919 35.867676 512 35.867676S1010.1' +
          '62162 228.850162 1010.162162 466.058378c0 104.64173-42.952649 20' +
          '3.637622-121.66227 281.821406l70.379243 168.683243c7.195676 17.2' +
          '69622 2.601514 37.251459-11.374703 49.567135-8.025946 7.084973-1' +
          '8.127568 10.710486-28.312216 10.710487z m-203.277838-208.45319c7' +
          '.610811 0 15.193946 2.048 21.919136 6.088649l91.108324 54.438054' +
          '-31.494919-75.443892a43.699892 43.699892 0 0 1 11.623784-49.8162' +
          '16c74.170811-64.345946 115.020108-148.729081 115.020108-237.5956' +
          '76C924.090811 276.756757 739.217297 122.713946 512 122.713946S99' +
          '.909189 276.756757 99.909189 466.058378c0 189.301622 184.873514 ' +
          '343.344432 412.090811 343.344433 65.785081 0 128.719568-12.64778' +
          '4 187.142919-37.583568 5.369081-2.297081 11.07027-3.431784 16.77' +
          '1459-3.431784zM260.953946 470.154378a56.32 56.32 0 0 1 56.347676' +
          '-56.015567 56.347676 56.347676 0 0 1 55.794162 56.596757c0 31.13' +
          '5135-24.908108 56.430703-55.794162 56.569081A56.32 56.32 0 0 1 2' +
          '60.981622 471.316757v-1.134703z m186.478703 0c0 31.965405 25.710' +
          '703 57.897514 57.399351 57.897514a57.648432 57.648432 0 0 0 57.3' +
          '71676-57.897514 57.648432 57.648432 0 0 0-57.371676-57.897513 57' +
          '.648432 57.648432 0 0 0-57.399351 57.897513z m186.506378 0a56.32' +
          ' 56.32 0 0 1 56.347676-56.015567 56.347676 56.347676 0 0 1 55.79' +
          '4162 56.596757c0 31.135135-24.908108 56.430703-55.794162 56.5690' +
          '81a56.32 56.32 0 0 1-56.347676-56.015568v-1.134703z" fill="#0000' +
          '00" /></svg>'
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_border_all_24px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" v' +
          'iewBox="0 0 24 24">'#13#10'    <path d="M3 3v18h18V3H3zm8 16H5v-6h6v6z' +
          'm0-8H5V5h6v6zm8 8h-6v-6h6v6zm0-8h-6V5h6v6z"/>'#13#10'    <path d="M0 0' +
          'h24v24H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_more_horiz_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M12 20c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.7' +
          '9-4-4-4zm24 0c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-' +
          '4zm-12 0c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4-1.79-4-4-4z"/>' +
          #13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_pause_circle_outline_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M18 32h4V16h-4v16zm6-28C12.95 4 4 12.95 4 24s8.95 2' +
          '0 20 20 20-8.95 20-20S35.05 4 24 4zm0 36c-8.82 0-16-7.18-16-16S1' +
          '5.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm2-8h4V16h-4v16z"/>'#13#10'</s' +
          'vg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_record_voice_over_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <circle cx="18" cy="18" r="8"/>'#13#10'    <p' +
          'ath d="M18 30c-5.34 0-16 2.68-16 8v4h32v-4c0-5.32-10.66-8-16-8zm' +
          '15.52-19.27l-3.37 3.38c1.68 2.37 1.68 5.41 0 7.78l3.37 3.38c4.04' +
          '-4.06 4.04-10.15 0-14.54zM40.15 4l-3.26 3.26c5.54 6.05 5.54 15.1' +
          '1-.01 21.47L40.15 32c7.8-7.77 7.8-19.91 0-28z"/>'#13#10'    <path fill' +
          '="none" d="M0 0h48v48H0z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_storage_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M4 40h40v-8H4v8zm4-6h4v4H8v-4zM4 8v8h40V8H4zm8 6H8v' +
          '-4h4v4zM4 28h40v-8H4v8zm4-6h4v4H8v-4z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_remove_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M38 26H10v-4h28v4z"/>'#13#10'    <pa' +
          'th d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_queue_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M8 12H4v28c0 2.21 1.79 4 4 4h28v-4H8V12zm32-8H16c-2' +
          '.21 0-4 1.79-4 4v24c0 2.21 1.79 4 4 4h24c2.21 0 4-1.79 4-4V8c0-2' +
          '.21-1.79-4-4-4zm-2 18h-8v8h-4v-8h-8v-4h8v-8h4v8h8v4z"/>'#13#10'</svg>'#13 +
          #10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_pause_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M12 38h8V10h-8v28zm16-28v28h8V' +
          '10h-8z"/>'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'bubble_chart_black_24dp'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0' +
          ' 0 24 24" width="24px" fill="#000000"><path d="M0 0h24v24H0V0z" ' +
          'fill="none"/><path d="M7 10c-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79' +
          ' 4-4-1.79-4-4-4zm0 6c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2z' +
          'm8.01-1c-1.65 0-3 1.35-3 3s1.35 3 3 3 3-1.35 3-3-1.35-3-3-3zm0 4' +
          'c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zM16.5 3C13.47 3 ' +
          '11 5.47 11 8.5s2.47 5.5 5.5 5.5S22 11.53 22 8.5 19.53 3 16.5 3zm' +
          '0 9c-1.93 0-3.5-1.57-3.5-3.5S14.57 5 16.5 5 20 6.57 20 8.5 18.43' +
          ' 12 16.5 12z"/></svg>'
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_add_box_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M38 6H10c-2.21 0-4 1.79-4 4v28' +
          'c0 2.21 1.79 4 4 4h28c2.21 0 4-1.79 4-4V10c0-2.21-1.79-4-4-4zm-4' +
          ' 20h-8v8h-4v-8h-8v-4h8v-8h4v8h8v4z"/>'#13#10'    <path d="M0 0h48v48H0' +
          'z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_format_align_left_18px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" v' +
          'iewBox="0 0 18 18">'#13#10'    <path d="M2 16h10v-2H2v2zM12 6H2v2h10V6' +
          'zM2 2v2h14V2H2zm0 10h14v-2H2v2z"/>'#13#10'    <path fill="none" d="M0 ' +
          '0h18v18H0z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_swap_vert_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M32 34.02V20h-4v14.02h-6L30 42' +
          'l8-7.98h-6zM18 6l-8 7.98h6V28h4V13.98h6L18 6z"/>'#13#10'    <path d="M' +
          '0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_unfold_more_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M24 11.66L30.34 18l2.83-2.83L24 6l-9.17 9.17L17.66 ' +
          '18 24 11.66zm0 24.68L17.66 30l-2.83 2.83L24 42l9.17-9.17L30.34 3' +
          '0 24 36.34z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_explicit_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M38 6H10c-2.21 0-4 1.79-4 4v28c0 2.21 1.79 4 4 4h28' +
          'c2.21 0 4-1.79 4-4V10c0-2.21-1.79-4-4-4zm-8 12h-8v4h8v4h-8v4h8v4' +
          'H18V14h12v4z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_title_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M10 8v6h11v24h6V14h11V8z"/>'#13#10' ' +
          '   <path fill="none" d="M0 0h48v48H0V0z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_attachment_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M15 36C8.92 36 4 31.07 4 25s4.' +
          '92-11 11-11h21c4.42 0 8 3.58 8 8s-3.58 8-8 8H19c-2.76 0-5-2.24-5' +
          '-5s2.24-5 5-5h15v3H19c-1.1 0-2 .89-2 2s.9 2 2 2h17c2.76 0 5-2.24' +
          ' 5-5s-2.24-5-5-5H15c-4.42 0-8 3.58-8 8s3.58 8 8 8h19v3H15z"/>'#13#10' ' +
          '   <path d="M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_insert_photo_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M42 38V10c0-2.21-1.79-4-4-4H10' +
          'c-2.21 0-4 1.79-4 4v28c0 2.21 1.79 4 4 4h28c2.21 0 4-1.79 4-4zM1' +
          '7 27l5 6.01L29 24l9 12H10l7-9z"/>'#13#10'    <path d="M0 0h48v48H0z" f' +
          'ill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_play_circle_outline_24px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" v' +
          'iewBox="0 0 24 24">'#13#10'    <path d="M0 0h24v24H0z" fill="none"/>'#13#10 +
          '    <path d="M10 16.5l6-4.5-6-4.5v9zM12 2C6.48 2 2 6.48 2 12s4.4' +
          '8 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3' +
          '.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_build_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M45.4 37.9L27.1 19.6c1.8-4.6.8' +
          '-10.1-2.9-13.8-4-4-10-4.8-14.8-2.5l8.7 8.7-6.1 6.1-8.7-8.7C1 14.' +
          '2 1.8 20.2 5.8 24.2c3.7 3.7 9.2 4.7 13.8 2.9l18.3 18.3c.8.8 2.1.' +
          '8 2.8 0l4.7-4.7c.8-.7.8-2 0-2.8z"/>'#13#10'    <path clip-rule="evenod' +
          'd" fill="none" d="M0 0h48v48H0z"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_apps_48px'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M8 16h8V8H8v8zm12 24h8v-8h-8v8' +
          'zM8 40h8v-8H8v8zm0-12h8v-8H8v8zm12 0h8v-8h-8v8zM32 8v8h8V8h-8zm-' +
          '12 8h8V8h-8v8zm12 12h8v-8h-8v8zm0 12h8v-8h-8v8z"/>'#13#10'    <path d=' +
          '"M0 0h48v48H0z" fill="none"/>'#13#10'</svg>'#13#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'grade_black_24dp'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0' +
          ' 0 24 24" width="24px" fill="#000000"><path d="M0 0h24v24H0V0z" ' +
          'fill="none"/><path d="M12 7.13l.97 2.29.47 1.11 1.2.1 2.47.21-1.' +
          '88 1.63-.91.79.27 1.18.56 2.41-2.12-1.28-1.03-.64-1.03.62-2.12 1' +
          '.28.56-2.41.27-1.18-.91-.79-1.88-1.63 2.47-.21 1.2-.1.47-1.11.97' +
          '-2.27M12 2L9.19 8.63 2 9.24l5.46 4.73L5.82 21 12 17.27 18.18 21l' +
          '-1.64-7.03L22 9.24l-7.19-.61L12 2z"/></svg>'
        FixedColor = cl3DLight
      end
      item
        IconName = 'llama-svgrepo-com'
        SVGText = 
          '<?xml version="1.0" encoding="iso-8859-1"?>'#13#10'<!-- Uploaded to: S' +
          'VG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools -->'#13#10'<' +
          'svg fill="#000000" height="800px" width="800px" version="1.1" id' +
          '="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http:' +
          '//www.w3.org/1999/xlink" '#13#10#9' viewBox="0 0 512 512" xml:space="pr' +
          'eserve">'#13#10'<g>'#13#10#9'<g>'#13#10#9#9'<path d="M451.616,165.935c19.927-17.358,3' +
          '2.558-42.887,32.558-71.326C484.174,42.441,441.732,0,389.565,0H37' +
          '2.87v49.641'#13#10#9#9#9'c-4.068-1.719-8.208-3.094-12.158-4.403c-5.339-1.' +
          '769-10.384-3.439-14.346-5.621c-3.071-1.691-6.736-4.993-10.616-8.' +
          '49'#13#10#9#9#9'c-7.811-7.041-17.534-15.803-30.946-18.904c-3.131-0.724-6.' +
          '467-1.092-9.916-1.092c-8.123,0-15.657,1.94-22.944,3.818'#13#10#9#9#9'c-5.' +
          '862,1.509-11.4,2.936-15.944,2.936c-4.545,0-10.081-1.426-15.943-2' +
          '.936c-7.286-1.878-14.821-3.818-22.945-3.818'#13#10#9#9#9'c-3.448,0-6.784,' +
          '0.367-9.915,1.092c-13.417,3.102-23.138,11.865-30.95,18.906c-3.87' +
          '9,3.498-7.543,6.8-10.614,8.49'#13#10#9#9#9'c-3.961,2.182-9.006,3.852-14.3' +
          '45,5.621c-3.95,1.309-8.09,2.685-12.157,4.402V0h-16.696C70.268,0,' +
          '27.826,42.441,27.826,94.609'#13#10#9#9#9'c0,28.439,12.631,53.968,32.558,7' +
          '1.326c-26.002,14.159-43.688,41.737-43.688,73.37c0,46.03,37.448,8' +
          '3.478,83.478,83.478'#13#10#9#9#9'c0.467,0,0.927-0.028,1.392-0.034c9.055,5' +
          '2.429,26.66,97.313,51.314,130.543C180.966,491.15,217.589,512,256' +
          ',512'#13#10#9#9#9's75.032-20.85,103.12-58.709c24.653-33.23,42.258-78.115,' +
          '51.312-130.543c0.465,0.007,0.926,0.034,1.394,0.034'#13#10#9#9#9'c46.03,0,' +
          '83.478-37.448,83.478-83.478C495.304,207.672,477.618,180.094,451.' +
          '616,165.935z M406.261,35.705'#13#10#9#9#9'c25.667,7.285,44.522,30.933,44.' +
          '522,58.903s-18.855,51.619-44.522,58.903V35.705z M146.014,84.12'#13#10 +
          #9#9#9'c2.038-2.636,9.334-5.052,15.771-7.184c6.234-2.064,13.3-4.404,' +
          '19.953-8.067c6.453-3.553,11.746-8.324,16.865-12.938'#13#10#9#9#9'c5.717-5' +
          '.153,11.117-10.021,16.117-11.177c0.668-0.155,1.471-0.233,2.391-0' +
          '.233c3.893,0,9.102,1.341,14.618,2.761'#13#10#9#9#9'c7.264,1.871,15.497,3.' +
          '991,24.272,3.991c8.775,0,17.008-2.12,24.272-3.991c5.515-1.42,10.' +
          '724-2.761,14.615-2.761'#13#10#9#9#9'c0.919,0,1.724,0.078,2.393,0.233c4.99' +
          '8,1.155,10.397,6.022,16.114,11.174c5.12,4.615,10.414,9.387,16.86' +
          '7,12.939'#13#10#9#9#9'c6.653,3.663,13.718,6.004,19.952,8.067c6.438,2.133,' +
          '13.734,4.549,15.772,7.185c3.213,4.154,2.587,12.611,1.923,21.563'#13 +
          #10#9#9#9'c-0.297,4.011-0.604,8.161-0.604,12.375s0.307,8.363,0.604,12.' +
          '375c0.663,8.951,1.291,17.408-1.923,21.563'#13#10#9#9#9'c-2.037,2.635-9.33' +
          '3,5.051-15.77,7.182c-6.234,2.064-13.301,4.404-19.954,8.067c-6.45' +
          '5,3.553-11.748,8.326-16.867,12.94'#13#10#9#9#9'c-5.717,5.152-11.115,10.02' +
          '-16.114,11.175c-0.668,0.155-1.471,0.233-2.39,0.233h-0.001c-3.892' +
          ',0-9.102-1.342-14.618-2.761'#13#10#9#9#9'c-7.264-1.871-15.497-3.991-24.27' +
          '2-3.991c-8.775,0-17.008,2.12-24.272,3.991c-5.515,1.42-10.724,2.7' +
          '61-14.615,2.761'#13#10#9#9#9'c-0.919,0-1.724-0.078-2.393-0.233c-4.998-1.1' +
          '55-10.397-6.023-16.114-11.175c-5.119-4.614-10.413-9.385-16.865-1' +
          '2.938'#13#10#9#9#9'c-6.654-3.664-13.72-6.005-19.956-8.068c-6.437-2.131-13' +
          '.733-4.548-15.771-7.184c-3.213-4.154-2.587-12.611-1.923-21.563'#13#10 +
          #9#9#9'c0.297-4.011,0.605-8.161,0.605-12.375c-0.002-4.214-0.309-8.36' +
          '2-0.608-12.375C143.427,96.731,142.799,88.274,146.014,84.12z'#13#10#9#9#9 +
          ' M105.739,35.705v117.807c-25.668-7.285-44.522-30.933-44.522-58.9' +
          '03S80.071,42.99,105.739,35.705z M100.174,189.217'#13#10#9#9#9'c21.766,0,4' +
          '0.322,13.959,47.215,33.391H52.959C59.851,203.176,78.408,189.217,' +
          '100.174,189.217z M100.174,289.391'#13#10#9#9#9'c-21.766,0-40.323-13.959-4' +
          '7.215-33.391h32.539c3.922,3.453,9.05,5.565,14.674,5.565h0.002c5.' +
          '624,0,10.752-2.113,14.675-5.565'#13#10#9#9#9'h32.54C140.497,275.433,121.9' +
          '4,289.391,100.174,289.391z M332.302,433.396c-8.775,11.828-20.964' +
          ',24.952-36.425,34.002'#13#10#9#9#9'c-10.735-0.539-22.742-4.748-23.159-37.' +
          '148c8.212-7.4,15.358-18.806,18.899-29.555c2.703-9.071-4.282-16.5' +
          '77-15.583-16.696'#13#10#9#9#9'c-13.357,0-26.713,0-40.07,0c-11.3,0.119-18.' +
          '285,7.625-15.583,16.696c3.542,10.747,10.686,22.154,18.898,29.555' +
          #13#10#9#9#9'c-0.416,32.401-12.424,36.609-23.159,37.148c-15.461-9.05-27.' +
          '65-22.174-36.425-34.002c-21.799-29.383-37.414-69.941-45.49-117.8' +
          '95'#13#10#9#9#9'c29.108-13.054,49.446-42.286,49.446-76.197c0-12.232-2.667' +
          '-23.847-7.414-34.326c0.003,0.004,0.008,0.008,0.011,0.011'#13#10#9#9#9'c7.' +
          '811,7.04,17.534,15.803,30.947,18.904c3.131,0.724,6.467,1.091,9.9' +
          '16,1.091c8.123,0,15.657-1.94,22.944-3.818'#13#10#9#9#9'c5.862-1.509,11.4-' +
          '2.936,15.944-2.936c4.543,0,10.082,1.426,15.944,2.936c7.286,1.877' +
          ',14.821,3.818,22.944,3.818'#13#10#9#9#9'c0.001,0,0.001,0,0.001,0c3.448,0,' +
          '6.784-0.367,9.915-1.091c13.416-3.102,23.137-11.865,30.947-18.905' +
          #13#10#9#9#9'c0.003-0.003,0.007-0.006,0.009-0.009c-4.748,10.478-7.414,22' +
          '.093-7.414,34.325c0,33.911,20.336,63.143,49.444,76.196'#13#10#9#9#9'C369.' +
          '716,363.454,354.103,404.013,332.302,433.396z M411.826,289.391c-2' +
          '1.766,0-40.323-13.959-47.215-33.391h32.539'#13#10#9#9#9'c3.922,3.453,9.05' +
          ',5.565,14.674,5.565h0.002c5.624,0,10.752-2.113,14.675-5.565h32.5' +
          '4'#13#10#9#9#9'C452.149,275.433,433.592,289.391,411.826,289.391z M364.611' +
          ',222.609c6.892-19.433,25.45-33.391,47.215-33.391'#13#10#9#9#9'c21.766,0,4' +
          '0.323,13.959,47.215,33.391H364.611z"/>'#13#10#9'</g>'#13#10'</g>'#13#10'</svg>'
        FixedColor = cl3DLight
      end
      item
        IconName = 'stop-button'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <path d="M0 0h48v48H0z" fill="none"/>'#13#10 +
          '    <path d="M18 32h4V16h-4v16zm6-28C12.95 4 4 12.95 4 24s8.95 2' +
          '0 20 20 20-8.95 20-20S35.05 4 24 4zm0 36c-8.82 0-16-7.18-16-16S1' +
          '5.18 8 24 8s16 7.18 16 16-7.18 16-16 16zm2-8h4V16h-4v16z"/>'#13#10'   ' +
          ' <path d="M16 16h16v16H16z"/>'#13#10'</svg>'
        FixedColor = cl3DLight
      end
      item
        IconName = 'DosIcon_48'
        SVGText = 
          '<svg version="1.0" xmlns="http://www.w3.org/2000/svg"'#10' width="48' +
          '.000000pt" height="48.000000pt" viewBox="0 0 48.000000 48.000000' +
          '"'#10' preserveAspectRatio="xMidYMid meet">'#10#10'<g transform="translate' +
          '(0.000000,48.000000) scale(0.100000,-0.100000)"'#10'fill="#000000" s' +
          'troke="none">'#10'<path d="M5 467 c-3 -7 -4 -114 -3 -237 l3 -225 235' +
          ' 0 235 0 0 235 0 235 -233'#10'3 c-183 2 -234 0 -237 -11z m453 -224 l' +
          '-3 -218 -215 0 -215 0 -3 218 -2 217'#10'220 0 220 0 -2 -217z"/>'#10'<pat' +
          'h d="M100 240 l0 -130 91 0 c101 0 134 13 163 60 19 33 21 106 2 1' +
          '38 -26'#10'48 -64 62 -163 62 l-93 0 0 -130z m168 34 c43 -30 14 -84 -' +
          '45 -84 l-33 0 0 50'#10'c0 48 1 50 28 50 15 0 38 -7 50 -16z"/>'#10'</g>'#10'<' +
          '/svg>'#10
        FixedColor = cl3DLight
      end
      item
        IconName = 'logonicon'
        SVGText = 
          '<?xml version="1.0" ?><svg viewBox="0 0 32 32" xmlns="http://www' +
          '.w3.org/2000/svg"><defs><style>.cls-1{fill:#fff;}</style></defs>' +
          '<title/><g data-name="Layer 7" id="Layer_7"><path class="cls-1" ' +
          'd="M19.75,15.67a6,6,0,1,0-7.51,0A11,11,0,0,0,5,26v1H27V26A11,11,' +
          '0,0,0,19.75,15.67ZM12,11a4,4,0,1,1,4,4A4,4,0,0,1,12,11ZM7.06,25a' +
          '9,9,0,0,1,17.89,0Z"/></g></svg>'
      end
      item
        IconName = 'All\Connection'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0' +
          ' 0 24 24" width="24px" fill="#000000">'#13#10'<path d="M0 0h24v24H0V0z' +
          '" fill="none"/>'#13#10'<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10' +
          ' 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 ' +
          '8 3.59 8 8-3.59 8-8 8zm0-12.5c-2.49 0-4.5 2.01-4.5 4.5s2.01 4.5 ' +
          '4.5 4.5 4.5-2.01 4.5-4.5-2.01-4.5-4.5-4.5zm0 5.5c-.55 0-1-.45-1-' +
          '1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/>'#13#10'</svg>'
        FixedColor = cl3DLight
      end
      item
        IconName = 'ic_record_voice2'
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" v' +
          'iewBox="0 0 48 48">'#13#10'    <circle cx="18" cy="18" r="8"/>'#13#10'    <p' +
          'ath d="M18 30c-5.34 0-16 2.68-16 8v4h32v-4c0-5.32-10.66-8-16-8zm' +
          '15.52-19.27l-3.37 3.38c1.68 2.37 1.68 5.41 0 7.78l3.37 3.38c4.04' +
          '-4.06 4.04-10.15 0-14.54zM40.15 4l-3.26 3.26c5.54 6.05 5.54 15.1' +
          '1-.01 21.47L40.15 32c7.8-7.77 7.8-19.91 0-28z"/>'#13#10'    <path fill' +
          '="none" d="M0 0h48v48H0z"/>'#13#10'</svg>'#13#10
        FixedColor = clGold
      end>
    Left = 660
    Top = 119
  end
  object OpenPictureDialog1: TOpenPictureDialog
    DefaultExt = '.jpg'
    Filter = 
      'All (*.jpg;*.jpeg;*.png;*.webp;*.gif)|*.jpg;*.jpeg;*.png;*.webp;' +
      '*.gif|JPEG Image File (*.jpg)|*.jpg|Portable Network Graphics (*' +
      '.png)|*.png'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 277
    Top = 553
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = 'Text|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Encodings.Strings = (
      'Unicode'
      'UTF-8'
      'ANSI'
      'ASCII'
      'Big Endian Unicode'
      'UTF-7')
    Left = 280
    Top = 480
  end
  object Timer_System: TTimer
    Enabled = False
    Left = 413
    Top = 280
  end
  object PopupMenu_Topics: TPopupMenu
    OnPopup = PopupMenu_TopicsPopup
    Left = 280
    Top = 400
    object pmn_RenameTopic: TMenuItem
      Caption = 'Rename Topic'
      OnClick = pmn_RenameTopicClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object pmn_ClearAll: TMenuItem
      Caption = 'Clear All / Reset'
      OnClick = pmn_ClearAllClick
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 686
    Top = 346
  end
  object RESTClient_Ollama: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    Params = <>
    ReadTimeout = 60000
    SynchronizedEvents = False
    BindSource.AutoActivate = False
    BindSource.AutoEdit = False
    BindSource.AutoPost = False
    OnSendData = RESTClient_OllamaSendData
    OnReceiveData = RESTClient_OllamaReceiveData
    Left = 448
    Top = 440
  end
  object RESTRequest_Ollama: TRESTRequest
    Client = RESTClient_Ollama
    Method = rmPOST
    Params = <>
    Response = RESTResponse_Ollama
    SynchronizedEvents = False
    BindSource.AutoActivate = False
    BindSource.AutoEdit = False
    BindSource.AutoPost = False
    Left = 448
    Top = 502
  end
  object RESTResponse_Ollama: TRESTResponse
    BindSource.AutoActivate = False
    BindSource.AutoEdit = False
    BindSource.AutoPost = False
    Left = 452
    Top = 566
  end
  object ImageList_Multimodel: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 60
    Masked = False
    ShareImages = True
    Width = 64
    Scaled = True
    Left = 646
    Top = 458
  end
  object PopupMenu_History: TPopupMenu
    Images = SVGIconVirtualImageList1
    Left = 638
    Top = 538
    object pmn_ClearHistory: TMenuItem
      Action = Action_ClearHistory
      Caption = 'Clear History (only View)'
    end
    object pmn_ClearanceHistory: TMenuItem
      Action = Action_CLearanceHistory
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pmn_ClearAllHistory: TMenuItem
      Action = Action_ClearAllHistory
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    DefaultExtension = 'dat'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'History File(*.dat)'
        FileMask = '*.dat'
      end
      item
        DisplayName = 'History List (*.lst)'
        FileMask = '*.lst'
      end>
    Options = []
    Title = 'Open the History File'
    Left = 774
    Top = 346
  end
  object PopupMenu_Models: TPopupMenu
    Images = SVGIconVirtualImageList1
    Left = 766
    Top = 530
    object pmn_LoadModel: TMenuItem
      Caption = 'Load Model'
      ImageIndex = 18
      ImageName = 'ic_change_history_48px'
      OnClick = pmn_LoadModelClick
    end
    object pmn_UnLoadModel: TMenuItem
      Caption = 'UnLoad Model'
      ImageIndex = 15
      ImageName = 'ic_close_48px'
      OnClick = pmn_UnLoadModelClick
    end
  end
end
