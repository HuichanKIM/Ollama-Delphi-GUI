unit Unit_ChattingBoxClass;

{$I OllmaClient_Defines.inc}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  VirtualTrees.Types,
  VirtualTrees.BaseAncestorVCL,
  VirtualTrees.BaseTree,
  VirtualTrees.AncestorVCL,
  VirtualTrees,
  Vcl.BaseImageCollection,
  Vcl.ImageCollection,
  System.ImageList,
  Vcl.ImgList,
  Vcl.VirtualImageList,
  Vcl.Menus;

type
  TMessageRec = packed record
    FUser: string;
    FCaption: string;
    FTime: TDateTime;
    FTag: Integer;
    FLvTag: Integer;
    FSession: Integer;  { Reserved ... }
  end;
  PMessageRec = ^TMessageRec;

type
  TFrame_ChattingBoxClass = class(TFrame)
    VST_ChattingBox: TVirtualStringTree;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    PopupMenu1: TPopupMenu;
    pmn_SelectedColor: TMenuItem;
    N1: TMenuItem;
    pmn_Delete: TMenuItem;
    pmn_CopyText: TMenuItem;
    pmn_ColorSettings: TMenuItem;
    N2: TMenuItem;
    pmn_TextToSpeech: TMenuItem;
    pmn_ScrollToTop: TMenuItem;
    pmn_ScrollToBottom: TMenuItem;
    pmn_ClearChattingBox: TMenuItem;
    N3: TMenuItem;
    pmn_ShowLogs: TMenuItem;
    procedure VST_ChattingBoxGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST_ChattingBoxBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VST_ChattingBoxEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure VST_ChattingBoxFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VST_ChattingBoxInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure VST_ChattingBoxMeasureItem(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: TDimension);
    procedure VST_DrawTitle(Sender: TBaseVirtualTree; Node: PVirtualNode; var Title, TimeStamp: string; var Tag, LvTag: Integer);
    procedure VST_ChattingBoxResize(Sender: TObject);
    procedure VST_ChattingBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VST_ChattingBoxDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure VST_ChattingBoxColumnResize(Sender: TVTHeader; Column: TColumnIndex);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure pmn_DeleteClick(Sender: TObject);
    procedure pmn_SelectedColorClick(Sender: TObject);
    procedure pmn_CopyTextClick(Sender: TObject);
    procedure pmn_ColorSettingsClick(Sender: TObject);
    procedure VST_ChattingBoxLoadNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);
    procedure VST_ChattingBoxSaveNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);
  private
    FVST_NBodyFontSize: Integer;
    FVST_NHeaderColor: TColor;
    FVST_NBodyColor: TColor;
    FVST_NFooterColor: TColor;
    FVST_NSelectionColor: TColor;
    FVST_ColumnOffset: Integer;
    FVST_SecondIndent: Integer;
    FVST_FontName: string;
    FVST_FontSize: Integer;
    FVST_NodeHeightOffSet: Integer;
    function GetSelectionColor: TColor;
    procedure SetVST_NBodyFontSize(const Value: Integer);
    procedure SetVST_NSelectionColor(const Value: TColor);
    procedure SetVST_NBodyColor(const Value: TColor);
    procedure SetVST_NFooterColor(const Value: TColor);
    procedure SetVST_NHeaderColor(const Value: TColor);
    procedure SetVST_Fontname(const Value: string);
    procedure SetVST_FontSize(const Value: Integer);
    procedure SetVST_NodeHeightOffSet(const Value: Integer);
  public
    procedure InitializeEx(const AHeaderColor, ABodyColor, AFooterColor: TColor);
    procedure FinalizeEx(const AFlag: Integer);
    //
    procedure Add_Chatting_Message(const AUser: string; const ALocation, ALvTag: Integer; const APrompt: string; const ALockFocus: Boolean = False);
    procedure Insert_Chatting_Translation(const AIndex: Integer; const AUser: string; const ALocation: Integer; const APrompt: string);
    //
    function Get_NodeText(): string;
    function Get_NodeTextLocation(var VIndex, VLocation: Integer): string;
    function Get_IsResponseNode(const AFlag: Integer = 0): Boolean;
    function Get_NodeRequest(): string;
    function Get_SelectedColor(): TColor;
    procedure Do_ScrollToTop(const AFlag: Integer = 0; const ALockFocus: Boolean = False);
    procedure Do_ScrollToBottom(const AFlag: Integer = 0; const ALockFocus: Boolean = False);
    function Do_SaveAllText(const AFile: string): Boolean;
    function Do_DeleteNode(): Boolean;
    procedure Do_RestoreDefaultColor(const AFontOnlyFlag: Integer = 0);
    procedure Do_SetCustomFont(const AFlag: Integer; const AFontName: string; const AFontSize: Integer);
    procedure Do_SetCustomColor(const AFlag: Integer; const ASelColor, AHeaderColor, ABodyColor, AFooterColor: TColor);
    function Get_CustomColor(var VHeaderColor, VBodyColor, VFooterColor: TColor): TColor;
    procedure Set_FontEx(AFont: TFont);
    // History Manager
    procedure Do_LoadAllData(const ALFile: string);
    procedure Add_DummyHistorySubject(const AIndex: Integer; const AUser: string; const ALocation: Integer; const APrompt: string; const ALockFocus: Boolean = False);
    function Do_SaveAllData(const ASFile: string): Boolean;
    function Get_HistorySubject(): string;
    function Get_ChatHistory(const ANodeOneFlag: Boolean = False): string;
    //
    property VST_NBodyFontSize: Integer     read FVST_NBodyFontSize       write SetVST_NBodyFontSize;
    property VST_NSelectionColor: TColor    read FVST_NSelectionColor     write SetVST_NSelectionColor;
    property VST_NHeaderColor: TColor       read FVST_NHeaderColor        write SetVST_NHeaderColor;
    property VST_NBodyColor: TColor         read FVST_NBodyColor          write SetVST_NBodyColor;
    property VST_NFooterColor: TColor       read FVST_NFooterColor        write SetVST_NFooterColor;
    property VST_FontName: string           read FVST_FontName            write SetVST_FontName;
    property VST_FontSize: Integer          read FVST_FontSize            write SetVST_FontSize;
    property VST_NodeHeightOffSet: Integer  read FVST_NodeHeightOffSet    write SetVST_NodeHeightOffSet;
  end;

implementation

uses
  System.UITypes,
  Vcl.Clipbrd,
  Unit_Common,
  Unit_About;

{$R *.dfm}

procedure TFrame_ChattingBoxClass.InitializeEx(const AHeaderColor, ABodyColor, AFooterColor: TColor);
begin
  FVST_NHeaderColor :=    AHeaderColor;
  FVST_NBodyColor :=      ABodyColor;
  FVST_NFooterColor :=    AFooterColor;
  FVST_NSelectionColor := GC_SkinSelColor;
  FVST_NBodyFontSize :=   GC_SkinFontSize;
  FVST_ColumnOffset :=    15;    // Local ...
  FVST_SecondIndent :=    35;    // Reference of Indent for Ollama Response ...
  FVST_FontName :=        VST_ChattingBox.Font.Name;
  FVST_FontSize :=        GC_SkinFontSize;
  FVST_NodeHeightOffSet := 15;

  with VST_ChattingBox do
  begin
    TextMargin := 20;
    SelectionCurveRadius := 20;
    NodeDataSize := SizeOf(TMessageRec);
    NodeAlignment := TVTNodeAlignment.naFromTop;
    Header.Options := Header.Options - [hoAutoResize];
    Header.Columns[0].Width := ClientWidth - FVST_ColumnOffset;
    TreeOptions.AnimationOptions := [];
    TreeOptions.MiscOptions :=      TreeOptions.MiscOptions +      [TVTMiscOption.toVariablenodeHeight];
    TreeOptions.AutoOptions :=      TreeOptions.AutoOptions -      [TVTAutoOption.toAutoSpanColumns];    // too much overhead ...
    TreeOptions.StringOptions :=    TreeOptions.StringOptions -    [TVTStringOption.toShowStaticText];
    TreeOptions.SelectionOptions := TreeOptions.SelectionOptions + [TVTSelectionOption.toSelectNextNodeOnRemoval]-[TVTSelectionOption.toMultiSelect];
    {  Custom ... }
    Images := VirtualImageList1;
    OffsetWRMagin := 30;
    NodeHeightOffSet :=   FVST_NodeHeightOffSet;
    SelectedBrushColor := FVST_NSelectionColor;  // in TBaseVirtualTree.pas ...
    Node_HeaderColor :=   FVST_NHeaderColor;
    Node_BodyColor :=     FVST_NBodyColor;
    Node_FooterColor :=   FVST_NFooterColor;
    //
    OnDrawTitle := VST_DrawTitle;
  end;
end;

procedure TFrame_ChattingBoxClass.FinalizeEx(const AFlag: Integer);
begin
  with VST_ChattingBox do
  begin
    Clear;
  end;
end;

procedure TFrame_ChattingBoxClass.Add_Chatting_Message(const AUser: string; const ALocation, ALvTag: Integer; const APrompt: string; const ALockFocus: Boolean = False);
begin
  var _FNode := VST_ChattingBox.FocusedNode;
  with VST_ChattingBox do
  begin
    BeginUpdate;
    ClearSelection;
    var _Node := AddChild(nil);
    MultiLine[_Node] := True; // Modified by ichin 2025-05-06 화 오후 3:48:09
    try
      var _Data: PMessageRec := GetNodeData(_Node);
      with _Data^ do
      begin
        FUser :=    AUser;
        FCaption := APrompt;
        FTime :=    Now;
        FTag :=     ALocation;
        FLvTag :=   IIF.CastBool<Integer>(ALocation = 0, ALvTag, -1);
        FSession := 0;
      end;
    finally
      EndUpdate;
    end;

    FocusedNode := _Node;
    Selected[_Node] := True;
    InvalidateToBottom(_Node);
    Perform(WM_VSCROLL, SB_BOTTOM, 0);

    if ALockFocus and (_FNode <> nil) then
    begin
      FocusedNode := _FNode;
      Selected[_FNode] := True;
      Perform(WM_VSCROLL, SB_BOTTOM, 0);
    end;
  end;
end;

procedure TFrame_ChattingBoxClass.Insert_Chatting_Translation(const AIndex: Integer; const AUser: string; const ALocation: Integer; const APrompt: string);
begin
  var _bottomflag: Boolean := False;
  with VST_ChattingBox do
  begin
    BeginUpdate;
    var _Node := FocusedNode;
    ClearSelection;
    try
      if (_Node <> nil) and (_Node.Index = AIndex) then
        begin
          var _next: PVirtualNode := _Node.NextSibling;
          if _next <> nil then
            begin
              _Node := InsertNode(_next, amInsertBefore);
            end
          else
            begin
              _bottomflag := True;
              _Node := AddChild(nil);
            end;
        end
      else
        begin
          _bottomflag := True;
          _Node := AddChild(nil);
        end;

      MultiLine[_Node] := True; // Modified by ichin 2025-05-06 화 오후 3:48:09
      var _Data: PMessageRec := GetNodeData(_Node);
      with _Data^ do
      begin
        FUser :=    AUser;
        FCaption := APrompt;
        FTime :=    Now;
        FTag :=     ALocation; // = 2
        FLvTag :=   -1;
        FSession := 0;
      end;
    finally
      EndUpdate;
    end;

    FocusedNode := _Node;
    Selected[_Node] := True;
    InvalidateNode(_Node);  // Modified by ichin 2025-05-06 화 오후 3:38:19
    if _bottomflag then
    Perform(WM_VSCROLL, SB_BOTTOM, 0);
  end;
end;

procedure TFrame_ChattingBoxClass.Add_DummyHistorySubject(const AIndex: Integer; const AUser: string; const ALocation: Integer; const APrompt: string; const ALockFocus: Boolean = False);
begin
  var _FNode := VST_ChattingBox.FocusedNode;
  with VST_ChattingBox do
  begin
    BeginUpdate;
    ClearSelection;
    var _Node := GetFirst;
    try
      if _Node <> nil then
        begin
          var _next := _Node.NextSibling;
          if _next <> nil then
            _Node := InsertNode(_Node, amInsertBefore)
          else
            _Node := AddChild(nil);
        end
      else
        _Node := AddChild(nil);

      MultiLine[_Node] := True; // Modified by ichin 2025-05-06 화 오후 3:48:09
      var _Data: PMessageRec := GetNodeData(_Node);
      with _Data^ do
      begin
        FUser :=    AUser;
        FCaption := APrompt;
        FTime :=    Now;
        FTag :=     ALocation;
        FLvTag :=   -1;
        FSession := 0;
      end;

      var _second := _Node.NextSibling;
      if _second <> nil then
      begin
        var _seconddata: PMessageRec := GetNodeData(_second);
        if (_seconddata^.FTag = 0) and SameText(_seconddata^.FUser, AUser) then      // V_Username + ' (history)';
          try
            DeleteNode(_second);
          except
            Abort;
          end;
      end;
    finally
      EndUpdate;
    end;

    FocusedNode := _Node;
    Selected[_Node] := True;
    InvalidateNode(_Node); // Modified by ichin 2025-05-06 화 오후 3:38:28
    Perform(WM_VSCROLL, SB_TOP, 0);

    if ALockFocus and (_FNode <> nil) then
    begin
      FocusedNode := _FNode;
      Selected[_FNode] := True;
      InvalidateNode(_FNode);     // Modified by ichin 2025-05-06 화 오후 3:38:45
      Perform(WM_VSCROLL, SB_TOP, 0);
    end;
  end;
end;

procedure TFrame_ChattingBoxClass.Do_ScrollToTop(const AFlag: Integer; const ALockFocus: Boolean);
begin
  if ALockFocus then
  with VST_ChattingBox do
  begin
    UpdateScrollBars(True);
    Invalidate;
    Perform(WM_VSCROLL, SB_TOP, 0);
    Exit;
  end;

  with VST_ChattingBox do
  begin
    var _node := GetFirst();
    if Assigned(_node) then
    begin
      ClearSelection;
      IsVisible[_node] := True;
      Selected[_node] := True;
      FocusedNode := _node;
    end;
    UpdateScrollBars(True);
    Invalidate;

    Perform(WM_VSCROLL, SB_TOP, 0);
  end;
end;

procedure TFrame_ChattingBoxClass.Do_ScrollToBottom(const AFlag: Integer; const ALockFocus: Boolean);
begin
  if ALockFocus then
  with VST_ChattingBox do
  begin
    UpdateScrollBars(True);
    Invalidate;
    Perform(WM_VSCROLL, SB_BOTTOM, 0);
    Exit;
  end;

  with VST_ChattingBox do
  begin
    var _node := GetLast();
    if Assigned(_node) then
    begin
      ClearSelection;
      IsVisible[_node] := True;
      Selected[_node] := True;
      FocusedNode := _node;
    end;
    UpdateScrollBars(True);
    Invalidate;

    Perform(WM_VSCROLL, SB_BOTTOM, 0);
  end;
end;

procedure TFrame_ChattingBoxClass.pmn_DeleteClick(Sender: TObject);
begin
  Do_DeleteNode();
end;

procedure TFrame_ChattingBoxClass.pmn_SelectedColorClick(Sender: TObject);
begin
  with TColorDialog.Create(Self) do
  try
    Color := VST_ChattingBox.SelectedBrushColor;
    if Execute() then
    begin
      Self.VST_NSelectionColor := Color;
    end;
  finally
    Free;
  end;
end;

procedure TFrame_ChattingBoxClass.PopupMenu1Popup(Sender: TObject);
begin
  var _selbool: Boolean := VST_ChattingBox.SelectedCount > 0;
  pmn_CopyText.Enabled :=     _selbool;
  pmn_Delete.Enabled :=       _selbool;
  pmn_TextToSpeech.Enabled := _selbool;
end;

procedure TFrame_ChattingBoxClass.SetVST_NBodyFontSize(const Value: Integer);
begin
  if FVST_NBodyFontSize <> Value then
  begin
    FVST_NBodyFontSize := Value;
    FVST_FontSize := Value;
    VST_ChattingBox.Font.Size := Value;
    VST_ChattingBox.Invalidate;
  end;
end;

function TFrame_ChattingBoxClass.GetSelectionColor: TColor;
begin
  Result := VST_ChattingBox.SelectedBrushColor;
end;

procedure TFrame_ChattingBoxClass.SetVST_NSelectionColor(const Value: TColor);
begin
  if FVST_NSelectionColor <> Value then
  begin
    FVST_NSelectionColor := Value;
    VST_ChattingBox.SelectedBrushColor := Value;
  end;
end;

procedure TFrame_ChattingBoxClass.Set_FontEx(AFont: TFont);
begin
  VST_ChattingBox.Font.Assign(AFont);
  FVST_NBodyFontSize := AFont.Size;
  FVST_FontName := AFont.Name;
  FVST_FontSize := AFont.Size;
end;

procedure TFrame_ChattingBoxClass.SetVST_FontName(const Value: string);
begin
  if FVST_FontName <> Value then
  begin
    FVST_FontName := Value;
    VST_ChattingBox.Font.Name := Value;
  end;
end;

procedure TFrame_ChattingBoxClass.SetVST_FontSize(const Value: Integer);
begin
  if FVST_FontSize <> Value then
  begin
    FVST_FontSize := Value;
    VST_ChattingBox.Font.Size := Value;
  end;
end;

procedure TFrame_ChattingBoxClass.SetVST_NBodyColor(const Value: TColor);
begin
  if FVST_NBodyColor <> Value then
  begin
    FVST_NBodyColor := Value;
    VST_ChattingBox.Node_BodyColor := Value;
  end;
end;

procedure TFrame_ChattingBoxClass.SetVST_NFooterColor(const Value: TColor);
begin
  if FVST_NFooterColor <> Value then
  begin
    FVST_NFooterColor := Value;
    VST_ChattingBox.Node_FooterColor := Value;
  end;
end;

procedure TFrame_ChattingBoxClass.SetVST_NHeaderColor(const Value: TColor);
begin
  if FVST_NHeaderColor <> Value then
  begin
    FVST_NHeaderColor := Value;
    VST_ChattingBox.Node_HeaderColor := Value;
  end;
end;

procedure TFrame_ChattingBoxClass.SetVST_NodeHeightOffSet(const Value: Integer);
begin
  if FVST_NodeHeightOffSet <>  Value then
  begin
    FVST_NodeHeightOffSet := Value;
    VST_ChattingBox.NodeHeightOffSet := Value;
    VST_ChattingBox.Invalidate;
  end;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  if _Data^.FTag > 0 then
    ContentRect.Left := TargetCanvas.ClipRect.Left + FVST_SecondIndent;  { = CellRect ... }
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxColumnResize(Sender: TVTHeader; Column: TColumnIndex);
begin
  VST_ChattingBox.Header.Columns[0].Width := VST_ChattingBox.ClientWidth - FVST_ColumnOffset;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  Finalize(_Data^);
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
  case Column of
    0:
      begin
        var _Data: PMessageRec := Sender.GetNodeData(Node);
        if Assigned(_Data) then
          CellText := _Data^.FCaption;
      end;
  end;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  VST_ChattingBox.Header.Columns[0].Width := VST_ChattingBox.ClientWidth - FVST_ColumnOffset;
  Include(InitialStates, ivsMultiline);   // *** //
  Node.States := Node.States + [vsMultiline, vsHeightMeasured];
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    Key := 0;
    Do_DeleteNode();
  end;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxMeasureItem(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: TDimension);
begin
  VST_ChattingBox.Header.Columns[0].Width := VST_ChattingBox.ClientWidth - FVST_ColumnOffset;
  if Sender.MultiLine[Node] then
  begin
    TargetCanvas.Font := Sender.Font;
    var _text: string := PMessageRec(VST_ChattingBox.GetNodeData(Node))^.FCaption;
    NodeHeight := VST_ChattingBox.ComputeNodeHeight(TargetCanvas, Node, 0, _text);
  end;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxResize(Sender: TObject);
begin
  with VST_ChattingBox do
  begin
    Header.Columns[0].Width := ClientWidth - FVST_ColumnOffset;
    var _node := FocusedNode;
    if Assigned(_node) then
    begin
      IsVisible[_node] := True;
      FocusedNode := _node;
    end;
    UpdateScrollBars(True);
    Invalidate;
  end;
end;

procedure TFrame_ChattingBoxClass.VST_DrawTitle(Sender: TBaseVirtualTree; Node: PVirtualNode; var Title, TimeStamp: string; var Tag, LvTag: Integer);
begin
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  if Assigned(_Data) then
  begin
    Title := _Data^.FUser;
    TimeStamp := FormatDateTime('( hh:nn:ss )', _Data^.FTime);
    Tag :=   _Data^.FTag;
    LvTag := _Data^.FLvTag;
  end;
end;

function TFrame_ChattingBoxClass.Get_CustomColor(var VHeaderColor, VBodyColor, VFooterColor: TColor): TColor;
begin
  Result :=       FVST_NSelectionColor;
  VHeaderColor := FVST_NHeaderColor;
  VBodyColor :=   FVST_NBodyColor;
  VFooterColor := FVST_NFooterColor;
end;

function TFrame_ChattingBoxClass.Get_NodeRequest: string;
begin
  Result := '';
  with VST_ChattingBox do
  begin
    var _node := FocusedNode;
    if Assigned(_node) then
    begin
      _node := _node.PrevSibling;
      if _node <> nil then
      begin
        var _Data: PMessageRec := GetNodeData(_node);
        if (_Data <> nil) and (_Data^.FTag = 0) then
        Result := _Data^.FCaption;
      end;
    end;
  end;
end;

function TFrame_ChattingBoxClass.Get_NodeText: string;
begin
  Result := '';
  with VST_ChattingBox do
  begin
    var _node := FocusedNode;
    if Assigned(_node) then
    begin
      var _Data: PMessageRec := GetNodeData(_node);
      if (_Data <> nil) then
      Result := _Data^.FCaption;
    end;
  end;
end;

function TFrame_ChattingBoxClass.Get_NodeTextLocation(var VIndex, VLocation: Integer): string;
begin
  Result := '';
  with VST_ChattingBox do
  begin
    var _node := FocusedNode;
    if Assigned(_node) then
    begin
      VIndex := _node.Index;
      var _Data: PMessageRec := GetNodeData(_node);
      if (_Data <> nil) then
      begin
        VLocation := _Data^.FTag;
        Result := _Data^.FCaption;
      end;
    end;
  end;
end;

function TFrame_ChattingBoxClass.Get_IsResponseNode(const AFlag: Integer): Boolean;
begin
  Result := False;
  with VST_ChattingBox do
  begin
    var _node := FocusedNode;
    if Assigned(_node) then
    begin
      var _Data: PMessageRec := GetNodeData(_node);
      Result := (_Data <> nil) and (_Data^.FTag = 1);
    end;
  end;
end;

function TFrame_ChattingBoxClass.Get_SelectedColor: TColor;
begin
  Result := VST_ChattingBox.SelectedBrushColor;
end;

procedure TFrame_ChattingBoxClass.pmn_ColorSettingsClick(Sender: TObject);
begin
  with TForm_About.Create(Self) do
  try
    Show_Flag := GC_AboutSkinFlag;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrame_ChattingBoxClass.pmn_CopyTextClick(Sender: TObject);
begin
  var _ItemStr := Get_NodeText;
  if _ItemStr <> '' then
  begin
    Clipboard.Clear;
    Clipboard.AsText := _ItemStr;
  end;
end;

function TFrame_ChattingBoxClass.Do_DeleteNode: Boolean;
begin
  Result := False;
  with VST_ChattingBox do
  begin
    var _node := FocusedNode;
    if Assigned(_node) then
    begin
      DeleteNode(_node);
      Result := True;
    end;
  end;
end;

procedure TFrame_ChattingBoxClass.Do_RestoreDefaultColor(const AFontOnlyFlag: Integer);
begin
  if AFontOnlyFlag = 1 then
  begin
    FVST_NBodyFontSize := 10;
    with VST_ChattingBox do
    try
      BeginUpdate;
      Font.Name := Self.Font.Name;
      Font.Size := FVST_NBodyFontSize;
    finally
      EndUpdate;
    end;

    FVST_FontName := Self.Font.name;
    FVST_FontSize := 10;

    Exit;
  end;

  FVST_NSelectionColor := GC_SkinSelColor;
  FVST_NHeaderColor :=    GC_SkinHeadColor;
  FVST_NBodyColor :=      GC_SkinBodyColor;
  FVST_NFooterColor :=    GC_SkinFootColor;
  FVST_NBodyFontSize :=   GC_SkinFontSize;
  FVST_FontSize :=        GC_SkinFontSize;

  GV_ReservedColor[0] := FVST_NSelectionColor;
  GV_ReservedColor[1] := FVST_NHeaderColor;
  GV_ReservedColor[2] := FVST_NBodyColor;
  GV_ReservedColor[3] := FVST_NFooterColor;

  with VST_ChattingBox do
  try
    BeginUpdate;
    Node_HeaderColor :=   FVST_NHeaderColor;
    Node_BodyColor :=     FVST_NBodyColor;
    Node_FooterColor :=   FVST_NFooterColor;
    Font.Name :=          FVST_FontName;
    Font.Size :=          FVST_NBodyFontSize;
    SelectedBrushColor := FVST_NSelectionColor;  { > Include Invalidation ... }
  finally
    EndUpdate;
  end;
end;

procedure TFrame_ChattingBoxClass.Do_SetCustomColor(const AFlag: Integer; const ASelColor, AHeaderColor, ABodyColor, AFooterColor: TColor);
begin
  if AFlag = 1 then
  begin
    GV_ReservedColor[0] := FVST_NSelectionColor;
    GV_ReservedColor[1] := FVST_NHeaderColor;
    GV_ReservedColor[2] := FVST_NBodyColor;
    GV_ReservedColor[3] := FVST_NFooterColor;
  end;

  FVST_NSelectionColor := ASelColor;
  FVST_NHeaderColor :=    AHeaderColor;
  FVST_NBodyColor :=      ABodyColor;
  FVST_NFooterColor :=    AFooterColor;

  if AFlag = 0 then      // for Restore Colors ...
  begin
    GV_ReservedColor[0] := FVST_NSelectionColor;
    GV_ReservedColor[1] := FVST_NHeaderColor;
    GV_ReservedColor[2] := FVST_NBodyColor;
    GV_ReservedColor[3] := FVST_NFooterColor;
  end;

  with VST_ChattingBox do
  try
    BeginUpdate;
    Node_HeaderColor :=   FVST_NHeaderColor;
    Node_BodyColor :=     FVST_NBodyColor;
    Node_FooterColor :=   FVST_NFooterColor;
    SelectedBrushColor := FVST_NSelectionColor;  { > Include Invalidation ... }
  finally
    EndUpdate;
  end;
end;

procedure TFrame_ChattingBoxClass.Do_SetCustomFont(const AFlag: Integer; const AFontName: string; const AFontSize: Integer);
begin
  VST_FontName := AFontName;
  VST_FontSize := AFontSize;
  VST_ChattingBox.Invalidate;
end;

function TFrame_ChattingBoxClass.Do_SaveAllText(const AFile: string): Boolean;
begin
  Result := False;
  if VST_ChattingBox.RootNodeCount < 1 then
  Exit;

  var _sourcelist := TStringList.Create;
  var _Data: PMessageRec := nil;
  var _index: Integer := 0;
  var _qtag: Integer := 0;
  var _prefixn: string := '';
  var _prefixr: string := 'Q';
  var _AddString: string := '';
  var _CellText: string := '';
  try
    _sourcelist.BeginUpdate;
    try
      var _Node  : PVirtualNode := VST_ChattingBox.GetFirst;
      while Assigned(_Node) do
      begin
        _AddString := EmptyStr;
        _Data := VST_ChattingBox.GetNodeData(_Node);
        if _Data <> nil then
        begin
          _qtag := _Data^.FTag;
            if _qtag = 0 then
              begin
                _prefixr := 'Q';
                Inc(_index);
              end
            else
              _prefixr := 'R';
          _prefixn := Format('[%s.%.3d] ', [ _prefixr, _index]);
          _CellText :=  _prefixn + _Data^.FUser;
          _AddString := _AddString + _CellText +sLineBreak;
          _CellText :=  _Data^.FCaption+ FormatDateTime('( hh:nn:ss )', _Data^.FTime);
          _AddString := _AddString + _CellText +sLineBreak;

          _sourcelist.Add(_AddString);
        end;

        _Node := _Node.NextSibling;
      end;
    finally
      _sourcelist.EndUpdate;
    end;
    if _sourcelist.Count > 0 then
    _sourcelist.SaveToFile(AFile);
  finally
    _sourcelist.Free;
  end;

  Result := FileExists(AFile);
end;

{ Save/Load Node Data for History Manager ------------------------------------ }

procedure TFrame_ChattingBoxClass.VST_ChattingBoxSaveNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);
begin
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  with Stream do
  begin
    var _len:= Length(_Data^.FUser);
    Write(_len, SizeOf(_len));
    Write(PChar(_Data^.FUser)^, _len * SizeOf(Char));
    _len := Length(_Data^.FCaption);
    Write(_len, SizeOf(_len));
    Write(PChar(_Data^.FCaption)^, _len * SizeOf(Char));

    _len := SizeOf(_Data^.FTime);
    Write(_len, SizeOf(_len));
    Write(_Data^.FTime, _len);
    _len := SizeOf(_Data^.FTag);
    Write(_len, SizeOf(_len));
    Write(_Data^.FTag, _len);
    _len := SizeOf(_Data^.FLvTag);
    Write(_len, SizeOf(_len));
    Write(_Data^.FLvTag, _len);
    //
    _len := SizeOf(_Data^.FSession);
    Write(_len, SizeOf(_len));
    Write(_Data^.FSession, _len);
  end;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxLoadNode(Sender: TBaseVirtualTree; Node: PVirtualNode; Stream: TStream);
begin
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  var _leno: Integer := 0;
  var _lenn: Int64 := Stream.Size;                         { Cover for Version < 1.1.1 }
  var _imagetag: Integer := -1;
  with Stream do
  begin
    Read(_leno, SizeOf(_leno));
    SetLength(_Data^.FUser, _leno);
    Read(PChar(_Data^.FUser)^, _leno * SizeOf(Char));        _lenn := _lenn - _leno* SizeOf(Char);
    Read(_leno, SizeOf(_leno));
    SetLength(_Data^.FCaption, _leno);
    Read(PChar(_Data^.FCaption)^, _leno * SizeOf(Char));     _lenn := _lenn - _leno* SizeOf(Char);

    Read(_leno, SizeOf(_leno));                              _lenn := _lenn - _leno;
    Read(_Data^.FTime, _leno);
    Read(_leno, SizeOf(_leno));                              _lenn := _lenn - _leno;
    Read(_Data^.FTag, _leno);
    Read(_leno, SizeOf(_leno));                              _lenn := _lenn - _leno;
    Read(_imagetag, _leno);

    if _lenn > 0 then                                       { Cover for Version < 1.1.1 }
      begin
        Read(_leno, SizeOf(_leno));
        Read(_Data^.FSession, _leno);
      end
    else
      _Data^.FSession := 0;
  end;
  if (_imagetag > 0) and (_Data^.FTime < GV_DateTime) then
    _imagetag := 0; // Virtual Image Index ...
  _Data^.FLvTag := _imagetag;
end;

function TFrame_ChattingBoxClass.Do_SaveAllData(const ASFile: string): Boolean;
begin
  Result := False;
  if VST_ChattingBox.RootNodeCount < 1 then
  begin
    MessageDlg('The list is empty. Nothing to save.', mtWarning, [mbOk], 0);
    Exit;
  end;
  // ------------------------------------------------------------------------ //
  VST_ChattingBox.SaveToFile(ASFile);
  // ------------------------------------------------------------------------ //
  Result := FileExists(ASFile);
end;

procedure TFrame_ChattingBoxClass.Do_LoadAllData(const ALFile: string);
begin
  if not FileExists(ALFile) then Exit;

  with VST_ChattingBox do
  begin
    Clear;
    NodeDataSize := SizeOf(TMessageRec);
    BeginUpdate;
    try
    // ------------------------------------------------------------------------ //
    LoadFromFile(ALFile);
    // ------------------------------------------------------------------------ //
    finally
      EndUpdate;
    end;
    var _Node: PVirtualNode := GetFirst;
    FocusedNode := _Node;
    Selected[_Node] := True;

    Perform(WM_VSCROLL, SB_TOP, 0);
  end;
end;

function TFrame_ChattingBoxClass.Get_HistorySubject: string;
begin
  Result := '';
  var _Node: PVirtualNode := VST_ChattingBox.GetFirst;
  if Assigned(_Node) then
  begin
    var _Data: PMessageRec := nil;
    _Data := VST_ChattingBox.GetNodeData(_Node);
    if _Data^.FTag = 0 then
      Result := _Data^.FCaption;
  end;
end;

function TFrame_ChattingBoxClass.Get_ChatHistory(const ANodeOneFlag: Boolean = False): string;
begin
  Result := '';
  if VST_ChattingBox.RootNodeCount < 1 then Exit;

  if ANodeOneFlag then
    begin
      var _Node: PVirtualNode := VST_ChattingBox.FocusedNode;
      if Assigned(_Node) then
      begin
        var _Data: PMessageRec := nil;
        _Data := VST_ChattingBox.GetNodeData(_Node);
        if (_Data <> nil) and (_Data^.FTag = 1) then
          Result := _Data^.FCaption;
      end;
    end
  else
    begin
      var _Data: PMessageRec := nil;
      var _Node: PVirtualNode := VST_ChattingBox.GetFirst;
      while Assigned(_Node) do
      try
        _Data := VST_ChattingBox.GetNodeData(_Node);
        if (_Data <> nil) and (_Data^.FTag = 1) then
          Result := Result + _Data^.FCaption+sLineBreak;
        _Node := _Node.NextSibling;
      except
        Abort;
      end;
    end;
end;

{ / Save/Load Node Data for History Manger ----------------------------------- }

end.
