unit Unit_Collections;

interface

uses
  Classes,
  Generics.Collections,
  SysUtils,
  System.JSON;

type

  TCollectionFactory = class
  public
    function DisplayName: string; virtual;
    function GetType: TClass; virtual; abstract;
    function GetExpression: string; virtual; abstract;
    function CreateCollection: TObject; virtual; abstract;
  end;

  TAnonCollectionFactory = class(TCollectionFactory)
  private
    FGetType: TFunc<TClass>;
    FCreateCollection: TFunc<TObject>;
    FExpression: string;
  public
    constructor Create(AGetType: TFunc<TClass>; ACreateCollection: TFunc<TObject>; const AExpression: string);
    function GetType: TClass; override;
    function CreateCollection: TObject; override;
    function GetExpression: string; override;
  end;


  TTestItem = class(TCollectionItem)
  private
    FStringField: string;
    FIntegerField: Integer;
  public
    destructor Destroy; override;
    property StringField: string read FStringField write FStringField;
    property IntegerField: Integer read FIntegerField write FIntegerField;
  end;

  TTestCollection = class(TCollection)
  end;

  TListObject = class
  private
    FStringField: string;
    FIntegerField: Integer;
  public
    constructor Create(const AString: string; AInteger: Integer);
    property StringField: string read FStringField write FStringField;
    property IntegerField: Integer read FIntegerField write FIntegerField;
  end;

  TTestRecord = record
  private
    FStringField: string;
    FIntegerField: Integer;
  public
    constructor Create(const AString: string; AInteger: Integer);
    property StringField: string read FStringField write FStringField;
    property IntegerField: Integer read FIntegerField write FIntegerField;
  end;

  function GetCollectionFactories: TArray<TCollectionFactory>;
  procedure RegisterCollectionFactory(ACollectionFactory: TCollectionFactory);

implementation

var
  FFactories: TList<TCollectionFactory>;

function GetCollectionFactories: TArray<TCollectionFactory>;
begin
  Result := FFactories.ToArray;
end;

procedure RegisterCollectionFactory(ACollectionFactory: TCollectionFactory);
begin
  FFactories.Add(ACollectionFactory);
end;

{ TAnonCollectionFactory }

constructor TAnonCollectionFactory.Create(AGetType: TFunc<TClass>;
  ACreateCollection: TFunc<TObject>; const AExpression: string);
begin
  FGetType := AGetType;
  FCreateCollection := ACreateCollection;
  FExpression := AExpression;
end;

function TAnonCollectionFactory.CreateCollection: TObject;
begin
  Result := FCreateCollection;
end;

function TAnonCollectionFactory.GetExpression: string;
begin
  Result := FExpression;
end;

function TAnonCollectionFactory.GetType: TClass;
begin
  Result := FGetType;
end;

{ TCollectionFactory }

function TCollectionFactory.DisplayName: string;
begin
  Result := GetType.ClassName;
end;

{ TListObject }

constructor TListObject.Create(const AString: string; AInteger: Integer);
begin
  FStringField := AString;
  FIntegerField := AInteger;
end;

procedure EnumerateSampleData(ACallback: TProc<string, integer>);
begin
  for var I := 1 to 100 do
    ACallback('Item' + IntToStr(I), I);
end;

{ TTestItem }

destructor TTestItem.Destroy;
begin
  //
  inherited;
end;

{ TTestRecord }

constructor TTestRecord.Create(const AString: string; AInteger: Integer);
begin
  FStringField := AString;
  FIntegerField := AInteger;
end;

const
  sQualifier = 'Current.';
  sSelf = 'Current';
initialization
  FFactories := TObjectList<TCollectionFactory>.Create;
  RegisterCollectionFactory(
    TAnonCollectionFactory.Create(
      function: TClass
      begin
        Result := TTestCollection;
      end,
      function: TObject
      var
        LCollection: TTestCollection;
      begin
        LCollection := TTestCollection.Create(TTestItem);
        Result := LCollection;
        EnumerateSampleData(
          procedure(AString: string; AInteger: Integer)
          begin
            with LCollection.Add as TTestItem do
            begin
              StringField := AString;
              IntegerField := AInteger;
            end;
          end);
      end,
      Format('''(TTestItem) StringField: '' + %0:sStringField + ''; IntegerField: '' + ToStr(%0:sIntegerField)', [sQualifier])));

finalization
  FFactories.Free;

end.
