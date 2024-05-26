object DM_Rest: TDM_Rest
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 462
  Width = 662
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    Params = <>
    ReadTimeout = 60000
    SynchronizedEvents = False
    Left = 120
    Top = 32
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 120
    Top = 110
  end
  object RESTResponse1: TRESTResponse
    Left = 124
    Top = 190
  end
end
