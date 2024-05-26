unit Unit_DMRest;

interface

uses
  System.SysUtils,
  System.Classes,
  WinAPi.Windows,
  WinApi.Messages,
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TDM_Rest = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FResponseRaw: string;
    FProcessFlag: string;
    FProgressFlag: string;
  public
    procedure DMDO_Request(const ABaseUrl, AParamsBody: string);
    // property ...
    property ResponseRaw: string    read FResponseRaw;
    property ProcessFlag: string    read FProcessFlag;
    property ProgressFlag: string   read FProgressFlag;
  end;

var
  DM_Rest: TDM_Rest;

implementation

uses
  Unit_Main,
  Unit_Common;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDM_Rest.DataModuleCreate(Sender: TObject);
begin
//
end;

procedure TDM_Rest.DataModuleDestroy(Sender: TObject);
begin
//
end;

procedure TDM_Rest.DMDO_Request(const ABaseUrl: string; const AParamsBody: string);
begin
  FProcessFlag := 'Start';
  RESTClient1.BaseURL := ABaseUrl;
  RESTClient1.ContentType := CONTENTTYPE_APPLICATION_JSON;
  RESTRequest1.Method := rmPOST;
  //
  RESTRequest1.Params.Clear;
  RESTRequest1.Params.AddBody(AParamsBody, CONTENTTYPE_APPLICATION_JSON);

  RESTRequest1.ExecuteAsync(
    procedure
    begin
      FProcessFlag := 'Complete';
      FResponseRaw := RESTResponse1.Content;
      PostMessage(Form_RestOllama.Handle, WM_DMM_MESSAGE, DMM_MESSAGE_FINISH, 0);
    end,
    True, True,
    procedure(Sender: TObject)
    begin
      FProcessFlag := 'Error'; // Exception(Error).ToString;
      PostMessage(Form_RestOllama.Handle, WM_DMM_MESSAGE, DMM_MESSAGE_ERROR, 0);
    end);
end;

end.
