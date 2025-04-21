unit Unit_HistoryManager;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;


type
  THisObject = class
    ho_Filename: string;
    constructor Create(const AFileName: string);
  end;

type
  THistoryManager = class
  private
    FHistoricFile: string;
    FAttachedFile: string;
    FListBox: TListBox;
    procedure FreeListObjects(const AClearFlag: Boolean = False);
    procedure UpdateHistory(const AFlag: Integer = 0);
    procedure Clearance_HistoryFiles_All(const AFlag: Integer = 0);
    function Get_OverwriteFlag(const ASubject: string): Boolean;
  public
    constructor Create(AListBox: TListBox);
    destructor Destroy; override;
    //
    function AddToHistory(const AFlag: Integer; const ASubject, AFile: string): Integer;
    procedure DeleteHistory(const AIndex: Integer);
    procedure Load_HstoryList(const AListfile: string = '');
    procedure Clear_ViewAll(const AFlag: Integer = 0);
    procedure Clear_ListData(const AFlag: Integer = 0);
    procedure Clearance_HistoryFiles(const AFlag: Integer = 0);
    procedure SetSelectionOfSubject(const ASubject: string);
    function Is_HistorySubject(const ASubject: string): Integer;
    function Get_HistorySubject(): string;
    function Get_HistoryData(const AIndex: Integer): string;
    function Get_HistoryFile(const ASubject: string; var AOvereriteFlag:  Boolean): string;  overload;
    function Get_HistoryFile(const AIndex: Integer): string; overload;
    // Property ...
    property ListBox: TListBox  read FListBox  write FListBox;
  end;

implementation

uses
  Unit_Common;

{ THisObject }

constructor THisObject.Create(const AFileName: string);
begin
  ho_Filename := AFileName;
end;

{ THistory_Manager ... }

constructor THistoryManager.Create(AListBox: TListBox);
begin
  FHistoricFile := CV_HisPath+'history.lst';
  FAttachedFile := CV_HisPath+'attached.txt';   // in preparation for a very long string of history subject ...
  FListBox := AListBox;
  Load_HstoryList();
end;

procedure THistoryManager.Load_HstoryList(const AListfile: string='');
begin
  if FileExists(FHistoricFile) and
     FileExists(FAttachedFile) then
  begin
    Screen.Cursor := crAppStart;
    var _HistoryList := TStringList.Create;
      _HistoryList.LoadFromFile(FHistoricFile);
    var _AttachedFiles:= TStringList.Create;
      _AttachedFiles.LoadFromFile(FAttachedFile);
    try
      if _HistoryList.Count <= _AttachedFiles.Count  then   // To cope with an error situation
        begin
          FListBox.Clear;
          FListBox.Items.BeginUpdate;
          var _hisObject: THisObject := nil;
          var _Subject: string := '';
          var _AFile: string := '';
          for var _i := 0 to _HistoryList.Count-1 do
            begin
              _Subject := _HistoryList.Strings[_i];
              _AFile :=   _AttachedFiles.Strings[_i];
              _hisObject := THisObject.Create(_AFile);
              FListBox.AddItem(_Subject, TObject(_hisObject));
            end;
          FListBox.Items.EndUpdate;
        end;
    finally
      _HistoryList.Free;
      _AttachedFiles.Free;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure THistoryManager.SetSelectionOfSubject(const ASubject: string);
begin
  var _index := FListBox.Items.IndexOf(ASubject);
  if _index >= 0 then
  begin
    FListBox.ClearSelection;
    FListBox.Selected[_index] := True;
  end;
end;

procedure THistoryManager.UpdateHistory(const AFlag: Integer = 0);
begin
  var _HistoryList := TStringList.Create;
  var _AttachedFiles:= TStringList.Create;
  try
    var _subject: string := '';
    var _afile: string := '';
    with FListBox.Items do
    for var _idx := 0 to Count -1 do
    begin
      _subject := Strings[_idx];
      _afile := THisObject(Objects[_idx]).ho_Filename;
      _HistoryList.Add(_subject);
      _AttachedFiles.Add(_afile);
    end;

    _HistoryList.SaveToFile(FHistoricFile);
    _AttachedFiles.SaveToFile(FAttachedFile);
  finally
    _HistoryList.Free;
    _AttachedFiles.Free;
  end;
end;

destructor THistoryManager.Destroy;
begin
  if FListBox.Items.Count > HIS_MAX_ITEMS then
  begin
    var _delcount:= FListBox.Items.Count - HIS_MAX_ITEMS;
    FListBox.Items.BeginUpdate;
    for var _i := 1 to _delcount do
      with FListBox.Items do
        try
          THisObject(Objects[0]).Free;
          Objects[0] := nil;
        finally
          Delete(0);
        end;
    FListBox.Items.EndUpdate;
  end;

  if FListBox.Items.Count = 0 then
    begin
      if FileExists(FHistoricFile) then
        DeleteFile(FHistoricFile);
      if FileExists(FAttachedFile) then
       DeleteFile(FAttachedFile);
    end
  else
    begin
      UpdateHistory(0);
      FreeListObjects();
    end;

  inherited;
end;

function THistoryManager.Get_OverwriteFlag(const ASubject: string): Boolean;
begin
  Result := FListBox.Items.IndexOf(ASubject) >= 0;
end;

function THistoryManager.Is_HistorySubject(const ASubject: string): Integer;
begin
  Result := FListBox.Items.IndexOf(ASubject);
end;

function THistoryManager.Get_HistoryFile(const AIndex: Integer): string;
begin
  Result := THisObject(FListBox.Items.Objects[AIndex]).ho_Filename;
end;

function THistoryManager.AddToHistory(const AFlag: Integer; const ASubject, AFile: string): Integer;
begin
  Result := -1;
  var _index := FListBox.Items.IndexOf(ASubject);
  if _index < 0 then
    begin
      var _hisObject: THisObject := THisObject.Create(AFile);
      FListBox.AddItem(ASubject, TObject(_hisObject));
      Result := FListBox.Items.Count-1;
    end
  else
    begin
      Result := _index;
      THisObject(FListBox.Items.Objects[_index]).ho_Filename := AFile;
    end;

  UpdateHistory(2);
end;

procedure THistoryManager.FreeListObjects(const AClearFlag: Boolean = False);
begin
  FListBox.Items.BeginUpdate;
  with FListBox do
  try
    for var _idx := 0 to Count -1 do
    begin
      THisObject(Items.Objects[_idx]).Free;
      Items.Objects[_idx] := nil;
    end;
  finally
    if AClearFlag then
      Clear;
  end;
  FListBox.Items.EndUpdate;
end;

function THistoryManager.Get_HistoryData(const AIndex: Integer): string;
begin
  Result := '';
  if FListBox.Count > 0 then
  begin
    if (AIndex >= 0) and (AIndex < FListBox.Count) then
    Result := THisObject(FListBox.Items.Objects[AIndex]).ho_Filename;
  end;
end;

function THistoryManager.Get_HistoryFile(const ASubject: string; var AOvereriteFlag:  Boolean): string;
begin
  Result := '';
  AOvereriteFlag := False;
  var _index := FListBox.Items.IndexOf(ASubject);
  if _index >= 0 then
  begin
    AOvereriteFlag := True;
    Result := THisObject(FListBox.Items.Objects[_index]).ho_Filename;
  end;
end;

function THistoryManager.Get_HistorySubject: string;
begin
  Result := '';
  if (FListBox.Count > 0) and (FListBox.ItemIndex >= 0) then
  begin
    Result := FListBox.Items.Strings[FListBox.ItemIndex];
  end;
end;

procedure THistoryManager.DeleteHistory(const AIndex: Integer);
begin
  if (FListBox.Count > 0) and
     ((AIndex >= 0) and (AIndex <= FListBox.Count-1)) then
  begin
    var _hfile := Get_HistoryData(AIndex);
    FListBox.Items.BeginUpdate;
    with FListBox.Items do
    try
      THisObject(Objects[AIndex]).Free;
      Objects[AIndex] := nil;
      Delete(AIndex);
    finally
      EndUpdate;
    end;

    if FileExists(_hfile) then
      DeleteFile(_hfile);

    UpdateHistory(1);
  end;
end;

procedure THistoryManager.Clearance_HistoryFiles(const AFlag: Integer = 0);
begin
  if not FileExists(FAttachedFile) then Exit;

  var _srec: TSearchRec;
  if FindFirst(CV_HisPath + '*.*', faAnyFile, _srec) = 0 then
  begin
    var _AttachedFiles:= TStringList.Create;
    with _AttachedFiles do
    begin
      CaseSensitive := False;
      Duplicates := dupIgnore;
      Sorted := True;
      LoadFromFile(FAttachedFile);
    end;

    var _fname := '';
    var _ext := '.dat';
    try
      repeat
        _fname := CV_HisPath + _srec.Name;
        _ext := ExtractFileExt(_srec.Name);
        if SameText(_ext, '.dat') and (_AttachedFiles.IndexOf(_fname) < 0) then
          if not DeleteFile(_fname) then
            RaiseLastOSError;
      until FindNext(_srec) <> 0;
    finally
      FindClose(_srec);
      _AttachedFiles.Free;
    end;
  end;
end;

procedure THistoryManager.Clearance_HistoryFiles_All(const AFlag: Integer = 0);
begin
  var _srec: TSearchRec;
  if FindFirst(CV_HisPath + '*.*', faAnyFile, _srec) = 0 then
  begin
    var _fname := '';
    var _ext := '.dat';
    try
      repeat
        _fname := _srec.Name;
        _ext := ExtractFileExt(_fname);
        if SameText(_ext, '.dat') then
          if not DeleteFile(CV_HisPath + _fname) then
          RaiseLastOSError;
      until FindNext(_srec) <> 0;
    finally
      FindClose(_srec);
    end;
  end;
end;

procedure THistoryManager.Clear_ListData(const AFlag: Integer = 0);
begin
  FreeListObjects(True);
  DeleteFile(FHistoricFile);
  DeleteFile(FAttachedFile);
  Clearance_HistoryFiles_All(0);
end;

procedure THistoryManager.Clear_ViewAll(const AFlag: Integer = 0);
begin
  UpdateHistory(4);
  FreeListObjects(True);
end;

// referance

{ THisListBox ...

procedure THisListBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    LB_ADDSTRING, LB_INSERTSTRING, LB_DELETESTRING:
    begin
      // for LB_(ADD|INSERT)STRING, Message.Result is the 0-based
      // index of the added string, or a LB_ERR... error code.
      //
      // for LB_DELETESTRING, Message.Result is the number of items
      // remaining in the list, or a LB_ERR... error code.
      //
      inherited;
      if (Message.Result >= 0) and Assigned(FOnItemCountChange) then
        FOnItemCountChange(Self);
    end;
    LB_RESETCONTENT:
    begin
      // the Message.Result is not used in this message.
      //
      var OldCount := Items.Count;
      inherited;
      if (OldCount <> Items.Count) and Assigned(FOnItemCountChange) then
        FOnItemCountChange(Self);
    end;
  else
    inherited;
  end;
end;
... }

end.
