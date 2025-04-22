unit Unit_MRUManager;

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
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TTopicData = record
    td_Topic: string;
    td_Seed: string;
    td_Level: Integer;
  end;
  PTopicData = ^TTopicData;

type
  TMRU_Manager = class
  private
    FMruJsonFile: string;
    FTreeView: TTreeView;
    FSeedList: TStringList;
    FTopicList: TStringList;
    FDefaultTopic: TTopicData;
  public
    constructor Create(ATreeView: TTreeView);
    destructor Destroy; override;
    //
    function Write_TreeViewToJSON(): Boolean;
    procedure Read_JsonToTreeView();
    procedure Update_Topics(const AFlag: Integer=0);
    function GetSeedRandom(): string;
    function AddInsertNode(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string): string;
    function Rename_TopicPrompt(const AOld, ANew: string): Integer;
    procedure DeleteNode(const AFlag: Integer);
    procedure Clear_All(const AFalg: Integer = 0);
    procedure Clear_TreeData(const AFalg: Integer = 0);
    // Property ...
    property TreeView: TTreeView  read FTreeView  write FTreeView;
  end;

implementation

uses
  System.Math,
  System.JSON,
  System.JSON.Readers,
  System.JSON.Writers,
  System.JSON.Types,
  Vcl.Dialogs,
  Unit_Common;

{ TMRU_Manager ... }

{ getNextSibling - Returns the next node in the tree view "at the same level" as the calling node. }

function TMRU_Manager.AddInsertNode(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string): string;

LABEL L_Finish;

begin
  Result := '';
  var _nodedata: PTopicData := nil;
  var _insertTarget := FTreeView.Items.GetFirstNode;
  if _insertTarget <> nil then
   _insertTarget := _insertTarget.getNextSibling;      // Target Node for Insert Node

  var _Indexflag := FTopicList.IndexOf(APrompt);
  var _newnode: TTreeNode := nil;

  if _Indexflag >= 0 then
    goto L_Finish;

  FTreeView.Items.BeginUpdate;
  case AFlag of
    GC_MRU_NewRoot:
      begin
        New(_nodedata);
        with _nodedata^ do
          begin
            td_Topic := 'Hello';
            td_Seed := '';
            td_Level := 0;
          end;
        _newnode := FTreeView.Items.AddObjectFirst(nil, _nodedata^.td_Topic, _nodedata);
      end;
    GC_MRU_AddRoot:
      begin
        New(_nodedata);
        with _nodedata^ do
          begin
            td_Topic := APrompt;
            td_Seed := GetSeedRandom();
            td_Level := 0;
          end;
        _newnode := FTreeView.Items.InsertObject(_insertTarget, APrompt, _nodedata);
      end;
    GC_MRU_AddChild:
      begin
        New(_nodedata);
        with _nodedata^ do
          begin
            td_Topic := APrompt;
            td_Seed := '';
            td_Level := 0;
          end;

        if ANode = nil then
          begin
            _nodedata^.td_Seed := GetSeedRandom();
            _newnode := FTreeView.Items.InsertObject(_insertTarget, APrompt, _nodedata);
          end
        else
          begin
            _nodedata^.td_Level := 1;
            if (ANode.Level = 0) then
              begin
                if ANode.AbsoluteIndex = 0 then
                  _nodedata^.td_Seed := ''
                else
                  _nodedata^.td_Seed := PTopicData(ANode.Data)^.td_Seed;
                _newnode := FTreeView.Items.AddChildObjectFirst(ANode, APrompt, _nodedata)
              end
            else
              begin
                _nodedata^.td_Seed := PTopicData(ANode.Parent.Data)^.td_Seed;
                _newnode := FTreeView.Items.AddChildObjectFirst(ANode.Parent, APrompt, _nodedata)
              end;
          end;
      end;
  end;
  FTreeView.Items.EndUpdate;

 L_Finish:

  if (_Indexflag >= 0) then
  begin
    _newnode := TTreeNode(FTopicList.Objects[_Indexflag]);
    _nodedata := PTopicData(_newnode.Data);
    if _newnode.Parent <> nil then
    _newnode.MoveTo(_newnode.Parent, naAddChildFirst);
  end;

  if Assigned(_newnode) then
  begin
    _newnode.Selected := True;
    _newnode.MakeVisible;
  end;

  if _nodedata <> nil then
  Result := _nodedata^.td_Seed;

  if (_Indexflag < 0) and (_newnode <> nil) then
  FTopicList.AddObject(APrompt, TObject(_newnode));
end;

procedure TMRU_Manager.DeleteNode(const AFlag: Integer);
begin
  var _node := FTreeView.Selected;

  if Assigned(_node) and (_node <> FTreeView.Items.GetFirstNode) then
  begin
    var _index: Integer  := -1;
    if _node.HasChildren then
    begin
      var _TopicData: PTopicData;
      var _Sub := _node.getFirstChild;
      while _Sub <> nil do
      begin
        _index :=  FTopicList.IndexOf(_Sub.Text);
        _TopicData := PTopicData(_Sub.Data);
        if _TopicData <> nil then
        Dispose(_TopicData);

        if _index >= 0 then
        with FTopicList do
          begin
            BeginUpdate;
            Delete(_index);
            EndUpdate;
          end;
        _Sub := _Sub.getNextSibling;
      end;
    end;

    _index :=  FTopicList.IndexOf(_node.Text);
    with FTreeView.Items do
      begin
        BeginUpdate;
        Dispose(PTopicData(_node.data)); // ** //
        Delete(_node);
        EndUpdate;
      end;
    if _index >= 0 then
    with FTopicList do
      begin
        BeginUpdate;
        Delete(_index);
        EndUpdate;
      end;
  end;
end;

constructor TMRU_Manager.Create(ATreeView: TTreeView);
begin
  Randomize;

  FMruJsonFile := CV_AppPath+'mrujson.json';
  FTreeView := ATreeView;
  FSeedList := TStringList.Create;
  FSeedList.Sorted := True;
  FSeedList.Duplicates := TDuplicates.dupIgnore;
  FSeedList.CaseSensitive := False;
  FTopicList := TStringList.Create();
  FTopicList.Sorted := True;
  FTopicList.Duplicates := TDuplicates.dupIgnore;
  FTopicList.CaseSensitive := False;

  with FDefaultTopic do
  begin
    td_Topic := 'Hello';
    td_Seed  := '';
    td_Level := 0;
  end;
end;

procedure TMRU_Manager.Update_Topics(const AFlag: Integer);
begin
  // Modified by ichin 2024-06-08 토 오전 12:40:55 -------------------------- //
  FTreeView.Invalidate;        // Absolutely Needed After Change Skin/Style ...
  // ------------------------------------------------------------------------ //
  FTopicList.Clear;
  FTopicList.Sorted := False;
  FTopicList.BeginUpdate;
  FTreeView.Items.BeginUpdate;
  var _node := FTreeView.Items.GetFirstNode;
  while _node <> nil do
    begin
      FTopicList.AddObject(_node.Text, TObject(_node));
      _node := _node.GetNext;
    end;
  FTreeView.Items.EndUpdate;
  FTreeView.Update;                         // Invalidate + Update = Repaint ...
  FTopicList.EndUpdate;
  FTopicList.Sorted := True;
  FTopicList.Duplicates := TDuplicates.dupIgnore;
  FTopicList.CaseSensitive := False;
end;

procedure TMRU_Manager.Clear_TreeData(const AFalg: Integer);
begin
  var _TopicData: PTopicData;
  var _node := FTreeView.Items.GetFirstNode;

  while _node <> nil do
    begin
      _TopicData := PTopicData(_node.Data);
        if _TopicData <> nil then
        Dispose(_TopicData);
      _node := _node.GetNext;
    end;

  FTreeView.Items.Clear;
  FSeedList.Clear;
  FTopicList.Clear;
end;

procedure TMRU_Manager.Clear_All(const AFalg: Integer);
begin
  Write_TreeViewToJSON();
  var _backupfile := CV_TmpPath+ExtractFileName(FMruJsonFile);
  var _success := CopyFile(PChar(FMruJsonFile), PChar(_backupfile), False);

  Clear_TreeData();
  AddInsertNode(GC_MRU_NewRoot, nil, 'Hello');
end;

destructor TMRU_Manager.Destroy;
begin
  // Backup previous list file
  var _backupfile := CV_TmpPath+ExtractFileName(FMruJsonFile);
  var _success := CopyFile(PChar(FMruJsonFile), PChar(_backupfile), False);
  // ...
  Write_TreeViewToJSON();

  Clear_TreeData();
  FSeedList.Free;
  FTopicList.Free;
  inherited;
end;

function TMRU_Manager.GetSeedRandom(): string;
begin
  Result := '';
  var _seed := RandomRange(10000, 9999999);    // trick - Set Edit_Seed space ...
  var _dummy: Integer := 0;
  while True do
  begin
    if not FSeedList.Find(_seed.ToString, _dummy) then
    begin
      FSeedList.Add(_seed.ToString);
      Break;
    end;
    _seed := RandomRange(10000, 9999999);
  end;

  Result := _seed.ToString;
end;

{ TreeView to JSON ... }

function TMRU_Manager.Write_TreeViewToJSON(): Boolean;

  procedure Write_Object(AWriter: TJsonTextWriter; AData: PTopicData);
  begin
    with AWriter do
    begin
      WriteStartObject;
        WritePropertyName('topic');  WriteValue(AData^.td_Topic);;
        WritePropertyName('seed');   WriteValue(AData^.td_Seed);
        WritePropertyName('level');  WriteValue(AData^.td_Level);
      WriteEndObject;
    end;
  end;

LABEL L_Return;

begin
  Result := False;
  if not Assigned(FTreeView)  then  Exit;
  if FTreeView.Items.Count < 1 then
  begin
    WriteAllText_Unicode(FMruJsonFile, '');
    Exit;
  end;

  var _StringWriter := TStringWriter.Create();
  var _Writer := TJsonTextWriter.Create(_StringWriter);
  try
    _Writer.Formatting := TJsonFormatting.Indented;

    _Writer.WriteStartObject;
      _Writer.WritePropertyName('Topics');
        _Writer.WriteStartArray;

        var _TopicData: PTopicData;
        var _PromptData: PTopicData;
        var _Node := FTreeView.Items.GetFirstNode;
        var _Sub:  TTreeNode := nil;
        var _countroot: Integer := 0;
        while _Node <> nil do
          begin
            _TopicData := PTopicData(_Node.Data);
            if _TopicData = nil then
              goto L_Return;
            Write_Object( _Writer,  _TopicData);

            if _Node.HasChildren then
            begin
              _Writer.WriteStartArray;
              _Sub := _Node.getFirstChild;
              var _countsub: Integer := 0;
              while _Sub <> nil do
                begin
                  _PromptData := PTopicData(_Sub.Data);
                  if _PromptData <> nil then
                  begin
                    Write_Object( _Writer,  _PromptData);
                    Inc(_countsub);
                    if _countsub >= MRU_MAX_CHILD then
                    Break;
                  end;
                  _Sub := _Sub.getNextSibling;
                end;
              _Writer.WriteEndArray;
            end;

            Inc(_countroot);
            if _countroot >= MRU_MAX_ROOT then
            Break;
 L_Return:
            _Node := _Node.getNextSibling;
          end;

         _Writer.WriteEndArray;
    _Writer.WriteEndObject;

    var _dummy := WriteAllText_Unicode(FMruJsonFile, _StringWriter.ToString);
  finally
    FreeAndNil(_StringWriter);
    FreeAndNil(_Writer);
  end;

  Result := FileExists(FMruJsonFile);
end;

procedure TMRU_Manager.Read_JsonToTreeView();
begin
  if not FileExists(FMruJsonFile) then Exit;
  var _ReadStr := LoadFromFileBuffered_String(FMruJsonFile);
  if Length(_ReadStr) < 10 then Exit;

  var _StringReader := TStringReader.Create(_ReadStr);
  var _JsonReader := TJsonTextReader.Create(_StringReader);
  var _firstflag: Boolean := True;
  var _childflag: Boolean := False;
  var _pname: string := '';
  var _token: Integer := -1;
  var _TopicData: TTopicData;
  var _root: TTreeNode := nil;
  var _sub: TTreeNode := nil;

  try
    FTopicList.Clear;
    FTopicList.BeginUpdate;
    FSeedList.BeginUpdate;
    FTreeView.Items.BeginUpdate;
    FTreeView.Items.Clear;
    while _JsonReader.Read do
      case _JsonReader.TokenType of
        TJsonToken.StartObject:
          begin
            _token := -1;
            _childflag := False;
            _TopicData := Default(TTopicData);
          end;
        TJsonToken.Startarray:;
        TJsonToken.PropertyName:
          begin
            if _firstflag then
              begin
                _firstflag := False;    // Skip for "Topics"
                Continue;
              end;

            _pname := _JsonReader.Value.ToString;
            if SameText(_pname, 'topic') then  _token := 0 else
            if SameText(_pname, 'seed')  then  _token := 1 else
            if SameText(_pname, 'level') then  _token := 2;
           end;
        TJsonToken.String:
          begin
            case _token of
               0: _TopicData.td_Topic := _JsonReader.Value.ToString;
               1: _TopicData.td_Seed :=  _JsonReader.Value.ToString;
               2:;
            end;
          end;
        TJsonToken.Integer:
          begin
            if _token = 2 then
              begin
                _TopicData.td_Level :=  _JsonReader.Value.AsInteger;
                _childflag := _TopicData.td_Level = 1;
              end;
          end;
        TJsonToken.Null:;
        TJsonToken.Endarray:;
        TJsonToken.EndObject:
          begin
            if _token < 0 then
            Continue;

            var _nodedata: PTopicData;
            New(_nodedata);
            with _nodedata^ do
              begin
                td_Topic := _TopicData.td_Topic;
                td_Seed  := _TopicData.td_Seed;
                td_Level := _TopicData.td_Level;
              end;

            if _TopicData.td_Level = 0 then
              begin
                _root := FTreeView.Items.AddObject(nil, _TopicData.td_Topic, _nodedata);
                FTopicList.AddObject(_TopicData.td_Topic, TObject(_root));
              end else
            if _childflag then
              begin
                if Assigned(_root) then
                  begin
                    _sub := FTreeView.Items.AddChildObject(_root, _TopicData.td_Topic, _nodedata);
                    FTopicList.AddObject(_TopicData.td_Topic, TObject(_sub));
                  end;
              end;

            FSeedList.Add(_TopicData.td_Seed);
            _token := -1;
            _childflag := False;
          end;
      end;
  finally
    FTreeView.Items.EndUpdate;
    FSeedList.EndUpdate;
    FTopicList.EndUpdate;
    FreeAndNil(_JsonReader);
    FreeAndNil(_StringReader);
  end;

  FTreeView.FullExpand;
  if FTreeView.items.Count > 0 then
  with FTreeView.items.GetFirstNode do
  begin
    Selected := True;
    MakeVisible;
  end;
end;

function TMRU_Manager.Rename_TopicPrompt(const AOld, ANew: string): Integer;
begin
  Result := -1;
  var _index1 := FTopicList.IndexOf(AOld);
  var _index2 := FTopicList.IndexOf(ANew);
  if (_index1 >= 0) and (_index2 < 0) then
  begin
    var _Node := TTreeNode(FTopicList.Objects[_index1]);
    FTopicList.Delete(_index1);
    FTopicList.AddObject(ANew, TObject(_Node)) ;
    var _dummy: Boolean := FTopicList.Find(ANew, Result);
  end;
end;

{ ... }

end.
