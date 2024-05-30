unit Unit_ChattingBoxClass;

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
  Vcl.VirtualImageList;

type
  PMessageRec = ^TMessageRec;
  TMessageRec = record
    FUser: string;
    FCaption: String;
    FTime: TDateTime;
    FTag: Integer;
  end;

type
  TFrame_ChattingBoxClass = class(TFrame)
    VST_ChattingBox: TVirtualStringTree;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    procedure VST_ChattingBoxGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST_ChattingBoxBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VST_ChattingBoxEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure VST_ChattingBoxFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VST_ChattingBoxInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure VST_ChattingBoxMeasureItem(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: TDimension);
    procedure VST_DrawTitle(Sender: TBaseVirtualTree; Node: PVirtualNode; var Title, TimeStamp: string; var Tag: Integer);
    procedure VST_ChattingBoxResize(Sender: TObject);
  private
    FNewFontSize: Integer;
    procedure SetNewFontSize(const Value: Integer);
  public
    procedure InitializeEx(const AFlag: Integer = 0);
    procedure Add_ChattingMessage(const AUser: string; const AFlag, ALocation: Integer; const APrompt: string);
    procedure Insert_ChattingMessage(const AIndex: Integer; const AUser: string; const AFlag, ALocation: Integer; const APrompt: string);
    //
    function Get_NodeText(): string;
    function Get_NodeRequest(): string;
    procedure Do_ScrollToTop(const AFlag: Integer = 0);
    procedure Do_ScrollToBottom(const AFlag: Integer = 0);
    function Do_SaveAllText(const AFile: string): Boolean;
    function Do_DeleteNode(): Boolean;
    //
    property NewFontSize: Integer  read FNewFontSize  write SetNewFontSize;
  end;

implementation

{$R *.dfm}

procedure TFrame_ChattingBoxClass.InitializeEx(const AFlag: Integer);
begin
  with VST_ChattingBox do
  begin
    NodeDataSize := SizeOf(TMessageRec);
    TreeOptions.MiscOptions := TreeOptions.MiscOptions + [TVTMiscOption.toVariablenodeHeight];
    TextMargin := 20;
    OffsetMagin := 30;
    NodeHeightOffSet := 50;
    OnDrawTitle := VST_DrawTitle;
  end;
end;

procedure TFrame_ChattingBoxClass.Add_ChattingMessage(const AUser: string; const AFlag, ALocation: Integer; const APrompt: string);
begin
  with VST_ChattingBox do
  begin
    ClearSelection;
    var _Node: PVirtualNode := AddChild(nil);
    var _Data: PMessageRec := GetNodeData(_Node);
    _Data^.FUser :=    AUser;
    _Data^.FCaption := APrompt;
    _Data^.FTime :=    Now;
    _Data^.FTag :=     ALocation;

    FocusedNode := _Node;
    Selected[_Node] := True;
    InvalidateToBottom(_Node);
  end;

  SendMessage(VST_ChattingBox.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFrame_ChattingBoxClass.Insert_ChattingMessage(const AIndex: Integer; const AUser: string; const AFlag, ALocation: Integer; const APrompt: string);
begin
  var _bottomflag: Boolean := False;
  with VST_ChattingBox do
  begin
    var _Node: PVirtualNode := GetFirstSelected();
    if _Node <> nil then
      begin
        var _next: PVirtualNode := _Node.NextSibling;
        if _next <> nil then
          _Node := InsertNode(_next, amInsertBefore)
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

    ClearSelection;
    var _Data: PMessageRec := GetNodeData(_Node);
    _Data^.FUser :=    AUser;
    _Data^.FCaption := APrompt;
    _Data^.FTime :=    Now;
    _Data^.FTag :=     ALocation;

    FocusedNode := _Node;
    Selected[_Node] := True;
  end;

  if _bottomflag then
    SendMessage(VST_ChattingBox.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFrame_ChattingBoxClass.SetNewFontSize(const Value: Integer);
begin
  FNewFontSize := Value;
  VST_ChattingBox.Font.Size := Value;
  VST_ChattingBox.Invalidate;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  if _Data^.FTag = 0 then
    ContentRect.Right := TargetCanvas.ClipRect.Right  - VST_ChattingBox.OffsetMagin
  else
    ContentRect.Left := TargetCanvas.ClipRect.Left + VST_ChattingBox.OffsetMagin;
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
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  if Assigned(_Data) then
    CellText := _Data^.FCaption;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Include(InitialStates, ivsMultiline);
  Node.States := Node.States + [vsMultiline, vsHeightMeasured];
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxMeasureItem(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: TDimension);
begin
  if Sender.MultiLine[Node] then
  begin
    TargetCanvas.Font := Sender.Font;
    var _s: string := PMessageRec(VST_ChattingBox.GetNodeData(Node))^.FCaption;
    NodeHeight := VST_ChattingBox.ComputeNodeHeight(TargetCanvas, Node, 0, _s) + 50;   // Title + TimeStamp
  end;
end;

procedure TFrame_ChattingBoxClass.VST_ChattingBoxResize(Sender: TObject);
begin
  with VST_ChattingBox do
  begin
    Header.Columns[0].Width := ClientWidth - 20;
    var _node := GetFirstSelected();
    if Assigned(_node) then
    IsVisible[_node] := True;
    UpdateScrollBars(True);
    Invalidate;
  end;
end;

procedure TFrame_ChattingBoxClass.VST_DrawTitle(Sender: TBaseVirtualTree; Node: PVirtualNode; var Title, TimeStamp: string; var Tag: Integer);
begin
  var _Data: PMessageRec := Sender.GetNodeData(Node);
  if Assigned(_Data) then
  begin
    Title := _Data^.FUser;
    TimeStamp := FormatDateTime('( hh:nn:ss )', _Data^.FTime);
    Tag := _Data^.FTag;
  end;
end;

function TFrame_ChattingBoxClass.Get_NodeRequest: string;
begin
  Result := '';
  with VST_ChattingBox do
  begin
    var _node := GetFirstSelected();
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
    var _node := GetFirstSelected();
    if Assigned(_node) then
    begin
      var _Data: PMessageRec := GetNodeData(_node);
      if (_Data <> nil) then
      Result := _Data^.FCaption;
    end;
  end;
end;

function TFrame_ChattingBoxClass.Do_DeleteNode: Boolean;
begin
  Result := False;
  with VST_ChattingBox do
  begin
    var _node := GetFirstSelected();
    if Assigned(_node) then
    begin
      DeleteNode(_node);
      Result := True;
    end;
  end;
end;

function TFrame_ChattingBoxClass.Do_SaveAllText(const AFile: string): Boolean;
begin
  Result := VST_ChattingBox.SaveToCSVFile(AFile, False);
end;

procedure TFrame_ChattingBoxClass.Do_ScrollToTop(const AFlag: Integer);
begin
  with VST_ChattingBox do
  begin
    Header.Columns[0].Width := VST_ChattingBox.ClientWidth - 20;
    var _node := GetFirst();
    if Assigned(_node) then
    begin
      ClearSelection;
      IsVisible[_node] := True;
      Selected[_node] := True;
    end;
    Invalidate;
    UpdateScrollBars(True);
  end;
  SendMessage(VST_ChattingBox.Handle, WM_VSCROLL, SB_TOP, 0);
end;

procedure TFrame_ChattingBoxClass.Do_ScrollToBottom(const AFlag: Integer);
begin
  with VST_ChattingBox do
  begin
    Header.Columns[0].Width := ClientWidth - 20;
    var _node := GetLast();
    if Assigned(_node) then
    begin
      ClearSelection;
      IsVisible[_node] := True;
      Selected[_node] := True;
    end;
    Invalidate;
    UpdateScrollBars(True);
  end;

  SendMessage(VST_ChattingBox.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

end.
