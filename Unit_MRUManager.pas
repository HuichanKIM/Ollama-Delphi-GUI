unit Unit_MRUManager;

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
  MRU_MAX_ITEMS = 30;

type
  TMRU_Manager = class
  private
    FMruItems : TStringList;
    FMruFileName : string;
    procedure LoadFromMruFile;
    procedure SaveToMruFile;
  public
    constructor Create(AFile: string);
    destructor Destroy; override;
    procedure AddItem(const APrompt: string);
    function RemoveItem( const APrompt : string ) : Boolean;
    property MruItems: TStringList  read FMruItems;
  end;

implementation

{ TMRU }

constructor TMRU_Manager.Create(AFile: string);
begin
  var _FilePath := ExtractFilePath( paramStr( 0 ) );
  FMruFileName := IncludeTrailingPathDelimiter(_FilePath)+ AFile;

  FMruItems := TStringList.Create;
  LoadFromMruFile;
end;

destructor TMRU_Manager.Destroy;
begin
  SaveToMruFile;
  FMruItems.Free;

  inherited;
end;

procedure TMRU_Manager.LoadFromMruFile;
begin
  if FileExists(FMruFileName) then
    try
      FMruItems.BeginUpdate;
      FMruItems.LoadFromFile(FMruFileName);
    finally
      FMruItems.EndUpdate;
    end;
end;

procedure TMRU_Manager.SaveToMruFile;
begin
  if FMruItems.Count > MRU_MAX_ITEMS then
  for var _i := FMruItems.Count -1 downto MRU_MAX_ITEMS-1 do
  begin
    FMruItems.Delete(_i);
  end;
  FMruItems.SaveToFile(FMruFileName);
end;

procedure TMRU_Manager.AddItem(const APrompt: string);
begin
  if APrompt <> '' then
  with FMruItems do
  begin
    BeginUpdate;
    try
      var _index := IndexOf( APrompt );
      if _index >= 0 then
        Delete( _index );
      Insert( 0, APrompt );
    finally
      EndUpdate;
    end;
  end;
end;

function TMRU_Manager.RemoveItem(const APrompt: string): Boolean;
begin
  var _index: Integer := FMruItems.IndexOf(APrompt);
  if _index >= 0 then
    begin
      FMruItems.Delete(_index);
      Result := True;
    end
  else
    Result := False;
end;

{ ... }

end.
