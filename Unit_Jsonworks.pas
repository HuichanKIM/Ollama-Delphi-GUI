unit Unit_Jsonworks;

{$I OllmaClient_Defines.inc}

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types,
  System.UITypes,
  Vcl.ExtCtrls,
  Unit_Common;

const
  GC_BaseURL_Generate     = 'http://localhost:11434/api/generate';
  GC_BaseURL_Chat         = 'http://localhost:11434/api/chat';
  GC_BaseURL_Models       = 'http://localhost:11434/api/tags';

  { Deprecated ... }
  GC_LoadModelChat        = '{"model": "%model%","messages": []}';
  GC_UnLoadModelChat      = '{"model": "%model%","messages": [],"keep_alive": 0}';

  GC_GeneratePrompt       = '{"model": "%model%","prompt": "%prompts%"}'; // option - "format":"json","stream":false}';
  GC_GeneratePrompt_opt   = '{"model": "%model%","prompt": "%prompts%","options": {"seed": %seed%, "temperature": 0}}';
  GC_GeneratePrompt4Image = '{"model": "%model%","prompt": "%prompts%","images": ["%images%"]}';  // "stream": false,
  GC_ChatContent          = '{"model": "%model%","messages": [{"role": "user","content": "%content%"}]}';
  GC_ChatContent_opt      = '{"model": "%model%","messages": [{"role": "user","content": "%content%"}],"options": {"seed": %seed%, "temperature": 0}}';
  GC_ChatContent4Image    = '{"model": "%model%","messages": [{"role": "user","content": "%content%","images": ["%images%"]}]}';
  { / Deprecated ... }

function Get_RequestModel_Chat(const ALoadFlag: Boolean; const AModel: string): string;
function Get_RequestParams_Generate(const AModel: string;
                                    const APrompt: string;
                                    const ASeedFlag: Boolean;
                                    const ASeed: Integer;
                                    const AImageFlag: Boolean;
                                    const AImage:TImage): string;
function Get_RequestParams_Chat(const AModel: string;
                                const AContent: string;
                                const ASeedFlag: Boolean;
                                const ASeed: Integer;
                                const AImageFlag: Boolean;
                                const AImage: TImage;
                                const AReasoning: Boolean=False): string;

function Get_DisplayJson(const ADisplay_Type: TDisplay_Type; const ARespStr: string): string;
function Get_DisplayJson_LoadModel(const ARespStr: string): string;
function Get_DisplayJson_Models(const ARespStr: string; var ACount: Integer; var AModelsList: TStringList): string;

function Get_Base64Endoeings(const AImage: TImage): string;

implementation

uses
  System.NetEncoding,
  System.JSON,
  System.JSON.Readers,
  System.JSON.Writers,
  System.JSON.Types,
  System.JSON.Serializers,
  EasyJson;

function FormatJSON(const JSONStr: string): string;
begin
  var _JSONValue: TJSONValue := TJSONObject.ParseJSONValue(JSONStr);
  if Assigned(_JSONValue) then
    try
      Result := _JSONValue.Format(2);
    finally
      _JSONValue.Free;
    end
  else
    Result := JSONStr;
end;

function JSONQuote(const AValue: string): string;
begin
  var _JSONStr: TJSONString := TJSONString.Create(AValue);
  try
    Result := _JSONStr.ToJSON;
  finally
    _JSONStr.Free;
  end;
end;

{ EasyJson to Request ------------------------------------------------------- }

function Get_RequestModel_Chat(const ALoadFlag: Boolean; const AModel: string): string;
begin
  var _ejson := TEasyJson.Create;
  try
    _ejson.Put('model', AModel)
          .AddArray('messages');
    if not ALoadFlag then
      _ejson.Root.Put('keep_alive', 0);

    Result := _ejson.ToString;
  finally
    _ejson.Free;
  end;
end;

function Get_RequestParams_Generate(const AModel: string;
                                    const APrompt: string;
                                    const ASeedFlag: Boolean;
                                    const ASeed: Integer;
                                    const AImageFlag: Boolean;
                                    const AImage:TImage): string;
begin
  var _ejson := TEasyJson.Create;
  try
    _ejson.Put('model', AModel)
          .Put('prompt', APrompt);
    if AImageFlag then
    begin
      var _ImageData := Get_Base64Endoeings(AImage);
      _ejson.AddArray('images')
            .Put(0, _ImageData);
    end;
    if ASeedFlag then
      _ejson.Root.AddObject('options')
                 .Put('seed', ASeed)
                 .Put('temperature', 0)
    else
      // experimental - Recover from SeedFlag settings as before - Usefull, Effective ?
      _ejson.Root.AddObject('options')
                   .Put('seed', 0)           // -1 : Negative value(expected random seed) show error ?
                   .Put('temperature', 1.0); // Regardless of temperature ?  if seed = 0 then use a randomly generated seed each time ?

    Result := _ejson.ToString;
  finally
    _ejson.Free;
  end;
end;

function Get_RequestParams_Chat(const AModel: string;
                                const AContent: string;
                                const ASeedFlag: Boolean;
                                const ASeed: Integer;
                                const AImageFlag: Boolean;
                                const AImage:TImage;
                                const AReasoning: Boolean=False): string;
begin
  var _ej_asmb :=  TEasyJson.Create;
  var _ej_body :=  TEasyJson.Create;
  var _ej_think := TEasyJson.Create;
  var _isGranite: Boolean := Pos('granite', LowerCase(AModel)) > 0;
  try
    _ej_body.Put('role', 'user')
            .Put('content', AContent);
    if AImageFlag then
    begin
      var _ImageData := 'Image Data';
      if AImage <> nil then
        _ImageData := Get_Base64Endoeings(AImage);
      _ej_body.AddArray('images')
              .Put(0, _ImageData);
    end;

    if AReasoning then
    begin
      if _isGranite then
        _ej_think.Put('role', 'control')
                 .Put('content', 'thinking')
      else
        _ej_think.Put('role', 'system')
                 .Put('content', 'Enable deep thinking subroutine.');
    end;

    if AReasoning then
      begin
        _ej_asmb.Put('model', AModel)
                .AddArray('messages')
                .Put(0, _ej_think)
                .Put(1, _ej_body);
      end
    else
      begin
        _ej_asmb.Put('model', AModel)
                .AddArray('messages')
                .Put(0, _ej_body);
      end;

    if ASeedFlag then
      _ej_asmb.Root.AddObject('options')
                   .Put('seed', ASeed)
                   .Put('temperature', 0.0)
    else
      // experimental - Recover from SeedFlag settings as before - Usefull, Effective ?
      _ej_asmb.Root.AddObject('options')
                   .Put('seed', 0)           // -1 : Negative value(expected random seed) show error ? - response Internal server error
                   .Put('temperature', 1.0); // Regardless of temperature ?  if seed = 0 then use a randomly generated seed each time ?

    Result := _ej_asmb.ToString;
  finally
    _ej_think.Free;
    _ej_body.Free;
    _ej_asmb.Free;
  end;
end;

{ /EasyJson to Request ------------------------------------------------------ }

{ Display JSon ... }

{TStringHelper.TrimRight -> ZEROBASEDSTRINGS ON }

function TrimRight_Ex(const ASource: string): string;
begin
  Result := ASource;
  var _I := Length(ASource);
  if _I < 1 then Exit;

  if (_I >= 1) and (ASource[_I] > ' ') then
    Result := ASource
  else
    begin
      while (_I >= 1) and (ASource[_I] <= ' ') do Dec(_I);
      Result := System.Copy(ASource, 1, _I);
    end;
end;

function Get_DisplayJson(const ADisplay_Type: TDisplay_Type; const ARespStr: string): string;
const
  c_Display_Type: array [TDisplay_Type] of string = ('response', 'content', 'trans');
const
  _OldPatterns: array [0..2] of string =('<think>','</think>','<response>');
  _NewPatterns: array [0..2] of string =('<think>'+sLineBreak,sLineBreak+'</think>'+sLineBreak,sLineBreak+'<response>'+sLineBreak);
begin
  Result := '';
  var _parsingsrc_0 := StringReplace(ARespStr, GC_UTF8_LFH, ',', [rfIgnoreCase, rfReplaceAll]);
  var _parsingsrc_1 := '{"Ollama":['+_parsingsrc_0+']}';
  var _acceptflag: Boolean := False;
  var _firstflag: Boolean := True;
  var _key := c_Display_Type[ADisplay_Type];
  var _StringReader := TStringReader.Create(_parsingsrc_1);
  var _JsonReader := TJsonTextReader.Create(_StringReader);
  try
    while _JsonReader.Read do
      case _JsonReader.TokenType of
        TJsonToken.PropertyName:
          begin
            _acceptflag := SameText(_JsonReader.Value.ToString, _key);
            if not _acceptflag then
            Continue;
          end;
        TJsonToken.String:
          if _acceptflag then
          begin
            _acceptflag := False;
            if _firstflag then
              begin
                _firstflag := False;
                Result := _JsonReader.Value.ToString.TrimLeft;
              end
            else
              Result := Result + _JsonReader.Value.ToString;
          end;
      end;

    // Worried about the overhead ? / ignore replacing last "</response>" ...
    var _checkings: string := Copy(Result, 1, 25);
    if Pos('<think>', _checkings) > 0 then
      for var _i := Low(_OldPatterns) to High(_OldPatterns) do
        Result := StringReplace(Result, _OldPatterns[_i], _NewPatterns[_i], [rfIgnoreCase]);

    Result := TrimRight_Ex(Result);
  finally
    FreeAndNil(_JsonReader);
    FreeAndNil(_StringReader);
  end;
end;


function Get_DisplayJson_LoadModel(const ARespStr: string): string;
begin
  Result := '';
  var _parsingsrc_0 := StringReplace(ARespStr, GC_UTF8_LFH, ',', [rfIgnoreCase, rfReplaceAll]);
  var _parsingsrc_1 := '{"Ollama":['+_parsingsrc_0+']}';
  var _acceptflag: Integer := -1;
  var _key0 := 'model';
  var _key1 := 'done_reason';
  var _model := '';
  var _loaded := '';
  Result := '* Model - ';

  var _StringReader := TStringReader.Create(_parsingsrc_1);
  var _JsonReader := TJsonTextReader.Create(_StringReader);
  try
    while _JsonReader.Read do
      case _JsonReader.TokenType of
        TJsonToken.PropertyName:
          begin
            if SameText(_JsonReader.Value.ToString, _key0) then
              _acceptflag := 0 else
            if SameText(_JsonReader.Value.ToString, _key1) then
              _acceptflag := 1
            else
              Continue;
          end;
        TJsonToken.String:
          begin
            if _acceptflag = 0 then
               _model := _JsonReader.Value.ToString else
            if _acceptflag = 1 then
               _loaded := _JsonReader.Value.ToString;
            _acceptflag := -1;
          end;
      end;

    Result := Result + _model + ' : ' + _loaded;
  finally
    FreeAndNil(_JsonReader);
    FreeAndNil(_StringReader);
  end;
end;

function Get_DisplayJson_Models(const ARespStr: string; var ACount: Integer; var AModelsList: TStringList): string;
begin
  Result := 'Models List at '+FormatDateTime('yyyy-mm-dd HH:NN:SS', Now) +GC_CRLF+GC_CRLF;

  var _StringReader := TStringReader.Create(ARespStr);
  var _JsonReader := TJsonTextReader.Create(_StringReader);
  var _firstflag: Boolean := True;
  var _childflag: Boolean := False;
  var _sizeflag: Boolean := False;
  var _modelflag: Boolean := False;
  var _propname: string := '';
  var _prefix: string := '';
  var _arrayflag: Boolean := False;
  var _key: string := 'name';
  var _fstobject: string := 'models';
  var _newvalue: string := '';
  AModelsList.Clear;
  try
    while _JsonReader.Read do
      case _JsonReader.TokenType of
        TJsonToken.StartObject:
          if _modelflag then
            begin
              _prefix := '';
              _childflag := False;
              _arrayflag := False;
              _sizeflag  := False;
            end;
        TJsonToken.Startarray:
          if not SameText(_JsonReader.Path, _fstobject) then
            _arrayflag := True;
        TJsonToken.PropertyName:
          begin
            if _firstflag then
            begin
              _firstflag := False;    // Skip for "models"
              Continue;
            end;

            _propname := _JsonReader.Value.ToString;
            if SameText(_propname, _key) then
              begin
                _modelflag := True;
                Inc(ACount);
                Result := Result + 'Models ['+ACount.ToString+'] : ';
                Continue;
              end else
            if SameText(_propname, 'details') then
              begin
                Result := Result + _prefix + _propname +' : '+ GC_CRLF;
                _prefix := '    - ';
                _childflag := True;
                Continue;
              end
            else
              begin
                if not _childflag then
                  _prefix := '  . ';
              end;

            _sizeflag := SameText(_propname, 'size');
            Result := Result + _prefix + _propname +' : ';
          end;
        TJsonToken.String:
          if _arrayflag then
             Result := Result + _JsonReader.Value.ToString +', '
          else
            begin
              if _modelflag then
                AModelsList.Add(_JsonReader.Value.ToString);
              _modelflag := False;
              Result := Result + _JsonReader.Value.ToString+ GC_CRLF;
            end;
        TJsonToken.Float, TJsonToken.Boolean:
          if _arrayflag then
            Result := Result + _JsonReader.Value.ToString +', '
          else
            Result := Result + _JsonReader.Value.ToString+ GC_CRLF;
        TJsonToken.Integer:
          if _sizeflag then
            begin
              _newvalue := BytesToKMG(_JsonReader.Value.AsInt64);
              Result := Result + _newvalue+ GC_CRLF;
              _sizeflag := False;
            end;
        TJsonToken.Null:
          Result := Result + 'null'+GC_CRLF;
        TJsonToken.Endarray:
          begin
            if not SameText(_JsonReader.Path, _fstobject) then
              begin
                Result := Result + GC_CRLF;
              end;
            _arrayflag := False;
          end;
        TJsonToken.EndObject:
          begin
            _prefix := '';
            _childflag := False;
            _arrayflag := False;
            _sizeflag  := False;
          end;
      end;
  finally
    FreeAndNil(_JsonReader);
    FreeAndNil(_StringReader);
  end;
end;

{ ... JSon }

const
    ICS_Base64OutA: array [0..64] of AnsiChar = (
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/', '='
    );

function ICS_Base64Encode(const AInput : PAnsiChar; ALen: Integer) : AnsiString;
begin
  var _Count := 0;
  var _I := ALen;
  while (_I mod 3) > 0 do
    Inc(_I);
  _I := (_I div 3) * 4;
  SetLength(Result, _I);
  _I := 0;
  while _Count < ALen do
  begin
    Inc(_I);
    Result[_I] := ICS_Base64OutA[(Byte(AInput[_Count]) and $FC) shr 2];
    if (_Count + 1) < ALen then
      begin
        Inc(_I);
        Result[_I] := ICS_Base64OutA[((Byte(AInput[_Count]) and $03) shl 4) +
                                     ((Byte(AInput[_Count + 1]) and $F0) shr 4)];
        if (_Count + 2) < ALen then
          begin
            Inc(_I);
            Result[_I] := ICS_Base64OutA[((Byte(AInput[_Count + 1]) and $0F) shl 2) +
                                         ((Byte(AInput[_Count + 2]) and $C0) shr 6)];
            Inc(_I);
            Result[_I] := ICS_Base64OutA[(Byte(AInput[_Count + 2]) and $3F)];
          end
        else
          begin
            Inc(_I);
            Result[_I] := ICS_Base64OutA[(Byte(AInput[_Count + 1]) and $0F) shl 2];
            Inc(_I);
            Result[_I] := '=';
          end
      end
    else
      begin
        Inc(_I);
        Result[_I] := ICS_Base64OutA[(Byte(AInput[_Count]) and $03) shl 4];
        Inc(_I);
        Result[_I] := '=';
        Inc(_I);
        Result[_I] := '=';
      end;

    Inc(_Count, 3);
  end;
end;

function Get_Base64Endoeings(const AImage: TImage): string;
begin
  Result := '';
  var _Input  := TMemoryStream.Create;
  try
    AImage.Picture.SaveToStream(_Input);
    _Input.Position := 0;
    Result := string(ICS_Base64Encode(_Input.Memory, _Input.Size));
  finally
    _Input.Free;
  end;
end;

{ Overhead ... }
function Get_Base64Endoeings2(const AImage: TImage): string;
begin
  Result := '';
  var _Input  := TMemoryStream.Create;
  var _Base64 := System.NetEncoding.TBase64Encoding.Create(0);  // CharsPerLine = 0 means no line breaks
  try
    AImage.Picture.SaveToStream(_Input);
    _Input.Position := 0;
    Result := _Base64.EncodeBytesToString(_Input.Memory, _Input.Size);
  finally
    _Base64.Free;
    _Input.Free;
  end;
end;

{ Reference .... }
function MemoryStreamToBase64(const MemoryStream: TMemoryStream): string;
var
  OutputStringStream: TStringStream;
  Base64Encoder: TBase64Encoding;
  MimeType: string;
begin
  MemoryStream.Position := 0;
  OutputStringStream := TStringStream.Create('', TEncoding.ASCII);
  try
    Base64Encoder := TBase64Encoding.Create;
    try
      Base64Encoder.Encode(MemoryStream, OutputStringStream);
      MimeType := 'image/png';
      Result := 'data:' + MimeType + ';base64,' + OutputStringStream.DataString.Replace(#13#10,'');
    finally
      Base64Encoder.Free;
    end;
  finally
    OutputStringStream.Free;
  end;
end;


{ Reference .... }
{ from https://qiita.com/p_kato/items/d01322e2cf7efbc23453 }

function OllamaGenerateRequestJSON(AModel,APrompt:string):string;
type
  TOllamaGenerateRequest = record
    model:string;
    prompt:string;
    stream:boolean;
  end;
var
  OllamaGenerateRequest: TOllamaGenerateRequest;
begin
  OllamaGenerateRequest.model  := AModel;
  OllamaGenerateRequest.prompt := APrompt;
  OllamaGenerateRequest.stream := False;
  var JsonSerializer := TJsonSerializer.Create;
  try
    JsonSerializer.Formatting := TJsonFormatting.Indented;
    Result :=
      JsonSerializer.Serialize<TOllamaGenerateRequest>(OllamaGenerateRequest);
  finally
    JsonSerializer.Free;
  end;
end;

function OllamaGenerateResponseJSON(AContent:string):string;
type
  TOllamaGenerateResponse=record
    response:string;
  end;
begin
  var JsonSerializer := TJsonSerializer.Create;
  try
    var JSONResponse := JsonSerializer.Deserialize<TOllamaGenerateResponse>(AContent);
    Result := JSONResponse.response;
  finally
    JsonSerializer.Free;
  end;
end;

end.
