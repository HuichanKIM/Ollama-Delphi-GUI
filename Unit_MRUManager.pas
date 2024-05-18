﻿unit Unit_MRUManager;

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

const
  MRU_MAX_ROOT = 20;
  MRU_MAX_CHILD = 30;

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
    { Methods }
    function WriteTreeViewToJSON(): Boolean;
    procedure ReadJsonToTreeView();
    function GetSeedRandom(): string;
    function AddInsertNode(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string): string;
    procedure DeleteNode(const AFlag: Integer);
    procedure Rename_TopicPrompt(const AOld, ANew: string);
    { Property }
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

function TMRU_Manager.AddInsertNode(const AFlag: Integer; const ANode: TTreeNode; const APrompt: string): string;
LABEL L_Finish;

begin
  Result := '';
  var _nodedata: PTopicData;
  var _firstnode: TTreeNode := FTreeView.Items.GetFirstNode;
  if _firstnode <> nil then
   _firstnode := _firstnode.getNextSibling;

  FTreeView.Items.BeginUpdate;
  var _Indexflag :=  FTopicList.IndexOf(APrompt);
  var _newnode: TTreeNode := nil;

  if _Indexflag >= 0 then
    goto L_Finish;

  case AFlag of
    0:
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
    1:
      begin
        New(_nodedata);
        with _nodedata^ do
          begin
            td_Topic := APrompt;
            td_Seed := GetSeedRandom();
            td_Level := 0;
          end;
        _newnode := FTreeView.Items.InsertObject(_firstnode, APrompt, _nodedata);
      end;
    2:
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
            _newnode := FTreeView.Items.InsertObject(_firstnode, APrompt, _nodedata);
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

 L_Finish:

  if _Indexflag >= 0 then
  begin
    _newnode := TTreeNode(FTopicList.Objects[_Indexflag]);
    _nodedata := PTopicData(_newnode.Data);
    if _newnode.Parent <> nil then
    _newnode.MoveTo(_newnode.Parent, naAddChildFirst);
  end;
  FTreeView.Items.EndUpdate;

  if Assigned(_newnode) then
  begin
    _newnode.Selected := True;
    _newnode.MakeVisible;
  end;
  Result := _nodedata^.td_Seed;

  if _Indexflag < 0 then
  FTopicList.AddObject(APrompt, TObject(_newnode));
end;

procedure TMRU_Manager.DeleteNode(const AFlag: Integer);
begin
  var _node: TTreeNode := FTreeView.Selected;
  if Assigned(_node) and (_node <> FTreeView.Items.GetFirstNode) then
  begin
    var _index :=  FTopicList.IndexOf(_node.Text);
    with FTreeView.Items do
    begin
      BeginUpdate;
      Delete(_node);
      EndUpdate;
    end;
    if _index >= 0 then
    begin
      FTopicList.BeginUpdate;
      FTopicList.Delete(_index);
      FTopicList.EndUpdate;
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
  FTopicList := TStringList.Create;
  FTopicList.Sorted := True;

  FDefaultTopic.td_Topic := 'Hello';
  FDefaultTopic.td_Topic := '';
  FDefaultTopic.td_Level := 0;
end;

destructor TMRU_Manager.Destroy;
begin
  WriteTreeViewToJSON();

  FSeedList.Free;
  FTopicList.Clear;
  FTopicList.Free;
  inherited;
end;

function TMRU_Manager.GetSeedRandom(): string;
begin
  Result := '';
  var _seed: Integer := RandomRange(10000, 99999);
  while True do
    begin
      if FSeedList.IndexOf( _seed.ToString) < 0 then
      Break;
      _seed := RandomRange(10000, 99999);
    end;

  Result := _seed.ToString;
  FSeedList.Add(Result);
end;

{ TreeView to JSON ... }

function TMRU_Manager.WriteTreeViewToJSON(): Boolean;
LABEL L_Return;
var
  _counts: Integer;

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

    Inc(_counts);
  end;

begin
  Result := False;
  if not Assigned(FTreeView)  then  Exit;
  if FTreeView.Items.Count < 1 then
  begin
    IOUtils_WriteAllText(FMruJsonFile, '');
    Exit;
  end;

  _counts := 0;
  var _StringWriter: TStringWriter := TStringWriter.Create();
  var _Writer: TJsonTextWriter := TJsonTextWriter.Create(_StringWriter);
  try
    _Writer.Formatting := TJsonFormatting.Indented;

    _Writer.WriteStartObject;
      _Writer.WritePropertyName('Topics');
        _Writer.WriteStartArray;

        var _TopicData: PTopicData;
        var _PromptData: PTopicData;
        var _Tree: TTreeNode := FTreeView.Items.GetFirstNode;
        var _countroot: Integer := 0;
        while _Tree <> nil do
          begin
            _TopicData := PTopicData(_Tree.Data);
            if _TopicData = nil then
              goto L_Return;
            Write_Object( _Writer,  _TopicData);

            if _Tree.HasChildren then
            begin
              _Writer.WriteStartArray;
              var _Sub:  TTreeNode := _Tree.getFirstChild;
              var _countsub: Integer := 0;
              while _Sub <> nil do
                begin
                  _PromptData := PTopicData(_Sub.Data);
                  if _PromptData <> nil then
                  begin
                    Write_Object( _Writer,  _PromptData);
                    Inc(_countsub);
                    if _countsub > MRU_MAX_CHILD then
                    Break;
                  end;
                  _Sub := _Sub.getNextSibling;
                end;
              _Writer.WriteEndArray;
            end;

            Inc(_countroot);
            if _countroot > MRU_MAX_ROOT then
            Break;
 L_Return:
            _Tree := _Tree.getNextSibling;
          end;

         _Writer.WriteEndArray;
    _Writer.WriteEndObject;

    IOUtils_WriteAllText(FMruJsonFile, _StringWriter.ToString);
  finally
    FreeAndNil(_StringWriter);
    FreeAndNil(_Writer);
  end;

  Result := FileExists(FMruJsonFile) and (FTreeView.Items.Count = _counts);
end;

procedure TMRU_Manager.ReadJsonToTreeView();
begin
  if not FileExists(FMruJsonFile) then Exit;

  var _RespStr := IOUtils_ReadAllText(FMruJsonFile);
  if Length(_RespStr) < 10 then Exit;

  var _StringReader: TStringReader := TStringReader.Create(_RespStr);
  var _JsonReader: TJsonTextReader := TJsonTextReader.Create(_StringReader);
  var _firstflag: Boolean := True;
  var _childflag: Boolean := False;
  var _pname: string := '';
  var _token: Integer := -1;
  var _TopicData: TTopicData;
  var _root: TTreeNode := nil;
  var _sub: TTreeNode := nil;

  try
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
    FTopicList.EndUpdate;
    FSeedList.EndUpdate;
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

procedure TMRU_Manager.Rename_TopicPrompt(const AOld, ANew: string);
begin
 var _index: Integer := FTopicList.IndexOf(AOld);
 if _index >= 0 then
 begin
   FTopicList.Sorted := False;
   FTopicList.BeginUpdate;
   FTopicList.Strings[_index] := ANew;
   FTopicList.EndUpdate;
   FTopicList.Sorted := True;
 end;
end;

{ ... }

end.