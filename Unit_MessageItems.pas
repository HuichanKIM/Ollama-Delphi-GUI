unit Unit_MessageItems;

interface

uses
  System.SysUtils,
  System.Classes,
  System.UITypes,
  WinApi.Windows,
  WinApi.Messages,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  System.Skia,
  Vcl.Skia;

type
  TMSGCollection = class;
  TLocation       = (acLeft=0, acRight);
  TMSGCollectionItem = class(TCollectionItem)
  private
    FParent: TMSGCollection;
    FSkLabel: TSkLabel;
    FUser: string;
    FMessage_0: string;
    FTimeStamp: TTime;
    FTextColor: TColor;
    FImageIndex: Integer;
    FLocation: TLocation;
    FOpacity: Byte;
    FHint: string;
    FSelected: Boolean;
    FEnabled: Boolean;
    FOnDestroy: TNotifyEvent;
    procedure SetEnabled(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetLocation(const Value: TLocation);
    procedure SetMessage_0(const Value: string);
    procedure SetSelected(Value: Boolean);
    procedure SetTextColor(Value: TColor);
    procedure SetTimeStamp(const Value: TTime);
    procedure SetUser(const Value: string);
    procedure SetOpacity(const Value: Byte);
  protected
    procedure Update; virtual;
    function  GetDisplayName: string; override;
    procedure DoDestroy;
  public
    constructor Create(Collection: System.Classes.TCollection); override;
    destructor Destroy; override;
    procedure Remove; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure AssignParameter(const AName: string; const AAge: integer); virtual;
    { property }
    property User: string                read FUser             write SetUser;
    property Message_0: string           read FMessage_0        write SetMessage_0;
    property TimeStamp: TTime            read FTimeStamp        write SetTimeStamp;
    property TextColor: TColor           read FTextColor        write SetTextColor default clBlack;
    property ImageIndex: Integer         read FImageIndex       write SetImageIndex;
    property Location: TLocation         read FLocation         write SetLocation;
    property Opacity: Byte               read FOpacity          write SetOpacity;
    property Selected: Boolean           read FSelected         write SetSelected;
    property OnDestroy: TNotifyEvent     read FOnDestroy        write FOnDestroy;
  end;

  TMSGCollection = class(TCollection)
  protected
    function GetItem(Index: Integer): TMSGCollectionItem; virtual;
    procedure SetItem(Index: Integer; Value: TMSGCollectionItem); virtual;
    function IndexOf(const AName: string): Integer; virtual;
  public
    constructor Create;
    function Add: TMSGCollectionItem;
    procedure AddParameter(const AName: string; const AAge: Integer);
    procedure DeleteParameter(const AName: string);
    property Items[Index: Integer]: TMSGCollectionItem read GetItem write SetItem;
  end;

implementation

uses
  System.Math,
  System.Types;

{ TMSGCollectionItem }

procedure TMSGCollectionItem.AssignParameter(const AName: string; const AAge: Integer);
begin
  //
end;

constructor TMSGCollectionItem.Create(Collection: System.Classes.TCollection);
begin
  inherited Create(Collection);

  FParent       := TMSGCollection(Collection);
  FEnabled      := True;

  FSkLabel      := TSkLabel.Create(nil);

  FTextColor    := clBlack;
  FSelected     := False;
  FImageIndex   := Collection.Count - 1;

  Update;
end;

destructor TMSGCollectionItem.Destroy;
begin
  DoDestroy;
  FSkLabel.Free;
  inherited Destroy;
end;

procedure TMSGCollectionItem.DoDestroy;
begin
  if Assigned(OnDestroy) then
  OnDestroy(Self);
end;

procedure TMSGCollectionItem.Remove;
begin
  inherited Free;
end;

procedure TMSGCollectionItem.Assign(Source: TPersistent);
begin
  if Source is TMSGCollectionItem then
    begin
      ImageIndex  := TMSGCollectionItem(Source).ImageIndex;
      TextColor   := TMSGCollectionItem(Source).TextColor;
    end
  else
    inherited Assign(Source);
end;

procedure TMSGCollectionItem.Update;
begin
//
end;

function TMSGCollectionItem.GetDisplayName: string;
begin
  //Result := CaptionID;
  if Result = '' then
  Result := inherited GetDisplayName;
end;

procedure TMSGCollectionItem.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Update;
  end;
end;

procedure TMSGCollectionItem.SetSelected(Value: Boolean);
begin
  if FSelected <> Value then
  begin
    FSelected := Value;
    Update;
  end;
end;

procedure TMSGCollectionItem.SetTextColor(Value: TColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Update;
  end;
end;

procedure TMSGCollectionItem.SetTimeStamp(const Value: TTime);
begin
  FTimeStamp := Value;
end;

procedure TMSGCollectionItem.SetUser(const Value: string);
begin
  FUser := Value;
end;

procedure TMSGCollectionItem.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Update;
  end;
end;

procedure TMSGCollectionItem.SetLocation(const Value: TLocation);
begin
  FLocation := Value;
end;

procedure TMSGCollectionItem.SetMessage_0(const Value: string);
begin
  FMessage_0 := Value;
end;

procedure TMSGCollectionItem.SetOpacity(const Value: Byte);
begin
  FOpacity := Value;
end;


{ TMSGCollection }

function TMSGCollection.Add: TMSGCollectionItem;
begin
  Result := TMSGCollectionItem(inherited Add);
end;

procedure TMSGCollection.AddParameter(const AName: string; const AAge: Integer);
begin
  Add.AssignParameter(AName, AAge);
end;

constructor TMSGCollection.Create;
begin
  inherited Create(TMSGCollectionItem);
end;

procedure TMSGCollection.DeleteParameter(const AName: string);
begin
  Items[IndexOf(AName)].Free;
end;

function TMSGCollection.GetItem(Index: Integer): TMSGCollectionItem;
begin
  Result := TMSGCollectionItem(inherited GetItem(Index));
end;

function TMSGCollection.IndexOf(const AName: string): Integer;
begin
  //for Result := 0 to Count - 1 do
  //  if Items[Result].Name = AName then
  //    Exit;

  raise Exception.CreateFmt('Error: Parameter "%s" does not exist', [AName]);
end;

procedure TMSGCollection.SetItem(Index: Integer; Value: TMSGCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{

var MyList : TMSGCollection;

implementation

// 데이타 관리 클래스 생성
procedure TMainForm.FormCreate(Sender: TObject);
begin
  MyList := TMSGCollection.Create;
end;

// 데이타 관리 클래스 파괴
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MyList.Free;
end;

// 데이타 추가
procedure AddData;
begin
  MyList.AddParameter('One', 1);
  MyList.AddParameter('Two', 2);
  MyList.AddParameter('Three', 3);
  MyList.AddParameter('Four', 4);
  MyList.AddParameter('Five', 5);
end;

// 데이타 리스트 출력
procedure ShowList;
var i : integer;
begin
 for i := 0 to MyList.Count - 1 do
 ShowMessage(MyList.Items[i].Name + ' : ' + IntToStr(MyList.Items[i].Age));
end;

// 레코드 삭제하는 함수다.
procedure DeleteData(Index : integer);
begin
  MyList.Items[Index].Free;
end;

}

end.
