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
    procedure FreeListObjects;
    procedure UpdateHistory(const AFlag: Integer = 0);
    procedure Clearance_HistoryFiles_All(const AFlag: Integer = 0);
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
    function GetOverwriteFlag(const ASubject: string): Boolean;
    function Get_HistoryData(const AIndex: Integer): string;
    function Get_HistoryFile(const ASubject: string): string;
    // Property ...
    property ListBox: TListBox  read FListBox  write FListBox;
  end;

implementation

uses
  System.Threading,
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

function THistoryManager.GetOverwriteFlag(const ASubject: string): Boolean;
begin
  Result := FListBox.Items.IndexOf(ASubject) >= 0;
end;

function THistoryManager.AddToHistory(const AFlag: Integer; const ASubject, AFile: string): Integer;
begin
  Result := -1;
  var _index0 := FListBox.Items.IndexOf(ASubject);
  if _index0 < 0 then
    begin
      var _hisObject: THisObject := THisObject.Create(AFile);
      FListBox.AddItem(ASubject, TObject(_hisObject));
      Result := FListBox.Items.Count-1;
    end
  else
    begin
      Result := _index0;
      THisObject(FListBox.Items.Objects[_index0]).ho_Filename := AFile;
    end;

  TTask.Run(
    procedure
    begin
      UpdateHistory(2);
    end);
end;

procedure THistoryManager.FreeListObjects();
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

function THistoryManager.Get_HistoryFile(const ASubject: string): string;
begin
  Result := '';
  var _index := FListBox.Items.IndexOf(ASubject);
  if _index >= 0 then
    Result := THisObject(FListBox.Items.Objects[_index]).ho_Filename;
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

    TTask.Run(
      procedure
      begin
        UpdateHistory(1);
      end);
  end;
end;

procedure THistoryManager.Clearance_HistoryFiles(const AFlag: Integer = 0);
begin
  if not FileExists(FAttachedFile) then
  Exit;

  var _srec: TSearchRec;
  if FindFirst(CV_HisPath + '*.*', faAnyFile, _srec) = 0 then
  begin
    var _AttachedFiles:= TStringList.Create;
    _AttachedFiles.LoadFromFile(FAttachedFile);
    var _clearancelist:= TStringList.Create;
    _clearancelist.CaseSensitive := False;
    _clearancelist.Duplicates := dupIgnore;
    _clearancelist.Sorted := True;
    var _fname := '';
    for var _i := 0 to _AttachedFiles.Count-1 do
      begin
        _fname := ExtractFileName(_AttachedFiles.Strings[_i]);
        _clearancelist.Add(_fname);
      end;
    var _ext := '.dat';
    try
      repeat
        _fname := _srec.Name;
        _ext := ExtractFileExt(_fname);
        if SameText(_ext, '.dat') and (_clearancelist.IndexOf(_fname) < 0) then
          if not DeleteFile(CV_HisPath + _fname) then
          RaiseLastOSError;
      until FindNext(_srec) <> 0;
    finally
      FindClose(_srec);
      _AttachedFiles.Free;
      _clearancelist.Free;
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
  FreeListObjects();
  DeleteFile(FHistoricFile);
  DeleteFile(FAttachedFile);
  Clearance_HistoryFiles_All(0);

  TTask.Run(
    procedure
    begin
      UpdateHistory(3);
    end);
end;

procedure THistoryManager.Clear_ViewAll(const AFlag: Integer = 0);
begin
  UpdateHistory(4);
  FreeListObjects();
end;

end.
