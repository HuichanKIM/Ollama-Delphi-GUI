unit Unit_HistoryManager;

{$I OllmaClient_Defines.inc}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.SyncObjs,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;


type
  THisObject = class
    ho_Session: Integer;
    ho_Filename: string;
    constructor Create(const AFileName: string);
  end;

type
  THistoryManager = class
  private
    FHistoryFile: string;
    FLinkedFile: string;
    FListBox: TListBox;
    FLinkedFileList : TStringList;
    FCriticalSection: TCriticalSection;
    procedure FreeListObjects(const AClearFlag: Boolean = False);
    procedure UpdateHistory(const AFlag: Integer = 0);
    procedure Clearance_HistoryFiles_All(const AFlag: Integer = 0);
    function Get_OverwriteFlag(const ASubject: string): Boolean;
    procedure Clearance_ListBox;
    procedure Lock();
    procedure Unlock();
  public
    constructor Create(AListBox: TListBox);
    destructor Destroy; override;
    //
    function AddToHistory(const AFlag: Integer; const ASubject, AFile: string): Integer;
    function DeleteHistory(const AIndex: Integer): Boolean;
    procedure Load_HstoryList(const AListfile: string = '');
    procedure Clear_ViewAll(const AFlag: Integer = 0);
    procedure Clear_ListData(const AFlag: Integer = 0);
    function Clearance_HistoryFiles(const AFlag: Integer = 0): Integer;
    procedure SetSelectionOfSubject(const ASubject: string);
    function Is_HistorySubject(const ASubject: string): Integer;
    function Get_HistoryCurrent(): string;
    function Get_HistoryFile(const ASubject: string; var VOvereriteFlag:  Boolean): string;  overload;
    function Get_HistoryFile(const AIndex: Integer): string; overload;
    function Get_HistoryFileSession(const AIndex: Integer; var VSession: Integer): string;
  end;

implementation

uses
  System.Math,
  System.IOUtils,
  Unit_Common;

{ THisObject }

constructor THisObject.Create(const AFileName: string);
begin
  ho_Session :=  RandomRange(1000000, 9999999);
  ho_Filename := AFileName;
end;

{ THistory_Manager ... }

constructor THistoryManager.Create(AListBox: TListBox);
begin
  Randomize;
  FHistoryFile := CV_HisPath+'history.lst';
  FLinkedFile :=  CV_HisPath+'attached.txt';   // in preparation for a very long string of history subject ...
  FListBox := AListBox;
  FCriticalSection := TCriticalSection.Create;
  FLinkedFileList := TStringList.Create;
  Load_HstoryList();
end;

procedure THistoryManager.Load_HstoryList(const AListfile: string='');
begin
  if FileExists(FHistoryFile) and FileExists(FLinkedFile) then
  begin
    Screen.Cursor := crAppStart;
    var _HistoryList := TStringList.Create;
      _HistoryList.LoadFromFile(FHistoryFile);
    FLinkedFileList.Clear;
    FLinkedFileList.LoadFromFile(FLinkedFile);
    try
      if _HistoryList.Count <= FLinkedFileList.Count  then   // To cope with an error situation
      FListBox.Clear;
      FListBox.Items.BeginUpdate;
      with FListBox do
      try
        var _hisObject: THisObject := nil;
        var _Subject: string := '';
        var _File: string := '';
        for var _i := 0 to _HistoryList.Count-1 do
          begin
            _Subject :=   _HistoryList.Strings[_i];
            _File :=      FLinkedFileList.Strings[_i];
            _hisObject := THisObject.Create(_File);
            AddItem(_Subject, TObject(_hisObject));
          end;
      finally
        Items.EndUpdate;
      end;
    finally
      _HistoryList.Free;
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

procedure THistoryManager.Lock;
begin
  FCriticalSection.Enter();
end;

procedure THistoryManager.Unlock;
begin
  FCriticalSection.Leave();
end;

procedure THistoryManager.UpdateHistory(const AFlag: Integer = 0);
begin
  if AFlag > 0 then Lock();
  try
    FLinkedFileList.Clear;
    var _file: string := '';
    with FListBox.Items do
    for var _idx := 0 to Count -1 do
      begin
        _file := THisObject(Objects[_idx]).ho_Filename;
        FLinkedFileList.Add(_file);
      end;
    if AFlag = 0 then
    begin
      FListBox.Items.SaveToFile(FHistoryFile);      // OverWrite ...
      FLinkedFileList.SaveToFile(FLinkedFile);      // OverWrite ...
    end;
  finally
    if AFlag > 0 then UnLock();
  end;
end;

destructor THistoryManager.Destroy;
begin
  var _dlinkedlist := TStringList.Create;
  if FListBox.Items.Count > HIS_MAX_ITEMS then
  begin
    FListBox.Items.BeginUpdate;
    with FListBox.Items do
    for var _i := Count-1 downto HIS_MAX_ITEMS do
      try
        _dlinkedlist.Add(THisObject(Objects[_i]).ho_Filename);
        THisObject(Objects[_i]).Free;
        Objects[_i] := nil;
      finally
        Delete(_i);
      end;
    FListBox.Items.EndUpdate;
  end;

  try
    if _dlinkedlist.Count > 0 then
    begin
      with _dlinkedlist do
      for var _i := 0 to Count-1 do
        Safety_DeleteFile(Strings[_i]);
    end;
  finally
    _dlinkedlist.Free;
  end;

  if FListBox.Items.Count = 0 then
    begin
      Safety_DeleteFile(FHistoryFile);
      Safety_DeleteFile(FLinkedFile);
    end
  else
    begin
      UpdateHistory(0);     // SaveToFile ...
      FreeListObjects();
    end;

  FLinkedFileList.Free;
  FCriticalSection.Free;
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

function THistoryManager.AddToHistory(const AFlag: Integer; const ASubject, AFile: string): Integer;
begin
  Result := -1;
  var _index := FListBox.Items.IndexOf(ASubject);

  FListBox.Items.BeginUpdate;
  with FListBox do
  try
    if _index < 0 then
      begin
        var _hisObject: THisObject := THisObject.Create(AFile);
        if Items.Count = 0 then
          AddItem(ASubject, TObject(_hisObject))
        else
          Items.InsertObject(0, ASubject, TObject(_hisObject));
        Result := 0;
      end
    else
      begin
        Result := _index;
        THisObject(Items.Objects[_index]).ho_Filename := AFile;
      end;
  finally
    Items.EndUpdate;
  end;

  UpdateHistory(2);
end;

procedure THistoryManager.FreeListObjects(const AClearFlag: Boolean = False);
begin
  FListBox.Items.BeginUpdate;
  with FListBox do
  try
    for var _idx := Count -1 downto 0 do
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

function THistoryManager.Get_HistoryFile(const ASubject: string; var VOvereriteFlag:  Boolean): string;
begin
  Result := '';
  VOvereriteFlag := False;
  var _index := FListBox.Items.IndexOf(ASubject);
  if _index >= 0 then
  begin
    VOvereriteFlag := True;
    Result := THisObject(FListBox.Items.Objects[_index]).ho_Filename;
  end;
end;

function THistoryManager.Get_HistoryFile(const AIndex: Integer): string;
begin
  Result := '';
  if FListBox.Count > 0 then
  begin
    if (AIndex >= 0) and (AIndex < FListBox.Count) then
    Result := THisObject(FListBox.Items.Objects[AIndex]).ho_Filename;
  end;
end;

function THistoryManager.Get_HistoryFileSession(const AIndex: Integer; var VSession: Integer): string;
begin
  Result := '';
  if FListBox.Count > 0 then
  begin
    if (AIndex >= 0) and (AIndex < FListBox.Count) then
    begin
      VSession := THisObject(FListBox.Items.Objects[AIndex]).ho_Session;
      Result :=   THisObject(FListBox.Items.Objects[AIndex]).ho_Filename;
    end;
  end;
end;

function THistoryManager.Get_HistoryCurrent: string;
begin
  Result := '';
  if (FListBox.Count > 0) and (FListBox.ItemIndex >= 0) then
  begin
    Result := FListBox.Items.Strings[FListBox.ItemIndex];
  end;
end;

function THistoryManager.DeleteHistory(const AIndex: Integer): Boolean;
begin
  Result := False;
  if (FListBox.Count > 0) and
     ((AIndex >= 0) and (AIndex <= FListBox.Count-1)) then
  begin
    var _hfile := Get_HistoryFile(AIndex);
    FListBox.Items.BeginUpdate;
    with FListBox.Items do
    try
      THisObject(Objects[AIndex]).Free;
      Objects[AIndex] := nil;
      Delete(AIndex);
    finally
      EndUpdate;
    end;

    Safety_DeleteFile(_hfile);
    Result := not FileExists(_hfile);
    UpdateHistory(1);
  end;
end;

procedure THistoryManager.Clearance_ListBox();
begin
  FListBox.Items.BeginUpdate;
  with FListBox do
  try
    var _ofilename: string := '';
    var _delindex: Integer := -1;
    for var _idx := Count -1 downto 0 do
      begin
        _ofilename := THisObject(Items.Objects[_idx]).ho_Filename;
        if not FileExists(_ofilename) then
        begin
          THisObject(Items.Objects[_idx]).Free;
          Items.Objects[_idx] := nil;
          Items.Delete(_idx);
        end;
      end;
  finally
    Items.EndUpdate;
  end;

  UpdateHistory(3);
end;

function THistoryManager.Clearance_HistoryFiles(const AFlag: Integer = 0): Integer;
begin
  Result := 0;

  Clearance_ListBox();
  if FLinkedFileList.Count < 1 then Exit;

  var _srec: TSearchRec;
  if FindFirst(CV_HisPath + '*.*', faAnyFile, _srec) = 0 then
  begin
    var _fname := '';
    var _ext := '.dat';
    try
      repeat
        _fname := CV_HisPath + _srec.Name;
        _ext := ExtractFileExt(_srec.Name);
        if SameText(_ext, '.dat') and (FLinkedFileList.IndexOf(_fname) < 0) then
          if Safety_DeleteFile(_fname) then
            Inc(Result);;
      until FindNext(_srec) <> 0;
    finally
      FindClose(_srec);
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
        _fname := CV_HisPath + _srec.Name;
        _ext := ExtractFileExt(_fname);
        if SameText(_ext, '.dat') then
          TFile.Delete(_fname);
      until FindNext(_srec) <> 0;
    finally
      FindClose(_srec);
    end;
  end;
end;

procedure THistoryManager.Clear_ListData(const AFlag: Integer = 0);
begin
  FreeListObjects(True);
  Safety_DeleteFile(FHistoryFile);
  Safety_DeleteFile(FLinkedFile);
  Clearance_HistoryFiles_All(0);
end;

procedure THistoryManager.Clear_ViewAll(const AFlag: Integer = 0);
begin
  UpdateHistory(0);
  FreeListObjects(True);
end;

{ Referance ...

  TFileStream.WriteComponent(ListBox_History);
  TFileStream.ReadComponent(ListBox_History);

 ... Referance }

end.
