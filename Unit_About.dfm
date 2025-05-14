object Form_About: TForm_About
  Left = 0
  Top = 0
  ActiveControl = Button_OK
  BorderStyle = bsDialog
  Caption = 'About / Skin / Color Setting'
  ClientHeight = 476
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  Position = poMainFormCenter
  RoundedCorners = rcOn
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object Label_Title: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 10
    Width = 380
    Height = 15
    Cursor = crHandPoint
    Hint = 'https://github.com/HuichanKIM/Ollama-Delphi-GUI'
    Margins.Top = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Ollama GUI  -  Version 0.9 - beta  ( Deploy  :  2024.05.13 )'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label_TitleClick
    ExplicitWidth = 313
  end
  object Panel_Buttons: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 437
    Width = 380
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button_OK: TButton
      Left = 311
      Top = 5
      Width = 59
      Height = 25
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object Panel_Body: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 38
    Width = 380
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 10
      Top = 3
      Width = 360
      Height = 387
      Margins.Left = 10
      Margins.Right = 10
      ActivePage = TabSheet_Settings
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Style = tsFlatButtons
      TabOrder = 0
      StyleElements = [seClient, seBorder]
      object TabSheet_About: TTabSheet
        Caption = 'About     '
        object Label_Development: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 82
          Width = 332
          Height = 269
          Margins.Left = 10
          Margins.Right = 10
          Align = alClient
          Caption = 'Development Tool  (GUI)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          StyleElements = [seClient, seBorder]
          ExplicitWidth = 130
          ExplicitHeight = 15
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 352
          Height = 79
          Align = alTop
          BevelOuter = bvNone
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          object Image1: TImage
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 60
            Height = 60
            Center = True
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D49484452000000640000
              0064080600000070E2955400000185694343504943432070726F66696C650000
              28917D913D48C3401CC55FD36A45AA0E761071C8509DECE007E258AA58040BA5
              ADD0AA83C9A51F42938624C5C551702D38F8B158757071D6D5C15510043F40DC
              0527451729F17F49A1458C07C7FD7877EF71F70E101A15A69A8118A06A96914E
              C4C55C7E450CBE22806E0431817E89997A32B39085E7F8BA878FAF77519EE57D
              EECFD1A7144C06F844E218D30D8B789D7866D3D239EF138759595288CF89C70D
              BA20F123D76597DF38971C167866D8C8A6E788C3C462A983E50E666543259E26
              8E28AA46F942CE6585F31667B55263AD7BF217860ADA7286EB344790C0229248
              41848C1A3650818528AD1A2926D2B41FF7F00F3BFE14B964726D8091631E55A8
              901C3FF81FFCEED62C4E4DBA49A138D0F562DB1FA340701768D66DFBFBD8B69B
              2780FF19B8D2DAFE6A0398FD24BDDED62247C0C0367071DDD6E43DE07207187A
              D2254372243F4DA15804DECFE89BF2C0E02DD0BBEAF6D6DAC7E90390A5AE966E
              80834360AC44D96B1EEFEEE9ECEDDF33ADFE7E00881572AFBFF9F14F00000006
              624B4744004000440050BD4897DE00000009704859730000144D0000144D0194
              CA8D2F0000000774494D4507E904060734108EA6ECE00000001974455874436F
              6D6D656E74004372656174656420776974682047494D5057810E17000013F749
              44415478DAED5D099815C5B5AEEEBE97993BFBCAB0C300C3269B087109CF440C
              6E28D12808A8516322824BA2C644137D9A677C1AF573210AE24B22F13D05018D
              26517CC6E87B792F6EE8082AFBBE33C0ECFB9D7BBBDFFFDFAE667A9A3B732FB3
              74DF97EF9EEFABAF6E555777559FBFAB4E9D53A7EA2A224909458AD70D48525B
              4A029260940424C12809488251129004A3242009464940128C92802418250149
              304A029260940424C12809488251129004A32420094609034855F59E898AA23C
              809F67203422BC6318C6BFE4640F3ED0CDF5F4473DFF8C9FE72104103E423D0F
              A09E755EF38094108054D7EC9D8EE88F08A98E4B8710CEC9CE1AB4A59BEA1989
              E87D84BE8E4B4D083351CF5FBCE685E7805456ED2E5455950CCF6DA7C8368489
              60564357EA01186988D80B4ADA6B8AAEEB237373861CF5921F9E030246FD12D1
              CF65720B868F69888B30ACBC83B840E6FF04803CD6C57AEE42F4A84C1E433D1C
              B2CA50CF7B8847CAFC8750CFBD5EF2C35340C024D6BF176180CC9A0E86BC2BAF
              CD41B45CE69721F4C335BD93F5A8880E2214C9ACB978D60A79ED5B88ACA16A3F
              C2205C33BCE289D7808C45F4A5C50C3062A075ADA6769F82AF78177E0E669A5F
              34046FA7C67808F2E9B2C791F6E0777156E6C0E34C473BF689D68F621CDAF195
              573CF11A909B102D91C917C1886B1DD7394CFD58261FC5F59F3AAEF743340A61
              00006B417C1072E0CBBCDCE20A47B95F21FA894C3E8EE7DCE5B8FE7B44DF95C9
              05B8FE9C573CF11A10BEF87C99BC0D8CF8B5FD3ABEEC69F89AFF2A93A5B87E1A
              F20A90B710E979A275EC77D2E7006819CAFD3BEEA9443D9F216F122F20FF5CF4
              B4F71CEDB815D122995C8A7B6EF28A275E03C26164BA4C9E0B46B461146660A9
              9881D5E0A71F81430C05EE3D081971565189C049C3E3F25D5BD083B230936A72
              B48313090BF8BFA01DE779C513AF01E13474824C8E0623364729F311A2D3DB79
              0495C60F84A9AF507053DE9C8590DF4EF98F51C71951EAE0B0B74926D7A3CC44
              AF78E23520471015F277381CCEC5D85FE52C5355BDF73945393EAC59F43E869E
              5F60E8F9EF28CFF421BA5098BDE96BF66B862196E6649F381C5554EECAD134AD
              52268F0290DE5EF1C46B40428834FE06134E680BE4450AE4C087F879AACCE250
              730BCAFE36D6B33FFEE45D65E4C8925B713F05BA6501D80520CF04906551DA62
              CDBAC278BECF2B9E780D08B56FDA93447D7D434A46467A0B1846413D45983A03
              BFF469B238ED5B173BE54C1C754C45F4264296CCE234FB4561EA366B01D896BA
              BA7A7F7A7A5AB3550FEA48F38A275E03F205A27132F982300D7EFDDB293E078C
              7AA593F510144E2002512E1F90D7AE97E92F51CF78AF78E235209F223A2D8EA2
              4F83493FEA625D770A73B6158B3E435D93BDE28967808041D4CAD78A56738645
              3B11382C7106C661643318F4BFDD54E7B9888A1152103893E27038D4518C43D9
              14D4B9CF0BBE7802880483D3D501B6EC3F233C08467CE2725B3813BB0FE1625B
              366D5A6779018AEB80483338997E8ACCAA43B8012FBFD2EDB638DA351B11676F
              96D2B901E16B5D35FB9F2C7901C8D3886E93C95A84F3F1D21FBADD8E76DA7626
              A2FF44C894598BD0B61FBAD9065701C10B8F40B45148DD03F41DBCF01FDC6C43
              1C6DBC0CD16B3219461883366E75AB7EB701A165D7D29457E34567B959FF49B4
              7315A22B64F239B473815B75BB0D4839A23CFED6757D526ECE90CFDDAC3F5EAA
              ACDA7DAAAAAAA532590140F2BBF4C09320D70001189CDBAF95C9AD78C9915D79
              9E0BEDE53AFF0899E434F85337EA751390EB84A98D937E8B17FCBE5B7577B2BD
              BF4174834C5E8FF62E73A35E3701A1F5F54199FC395EF05FA3953B7A6C7B2F10
              3D43F6A04C5D8C67161886718AA228394CE3771D7E6FC07D8763DCC7A9EDE060
              30B8ADB06078B09D323F43F4904CDE8767FED20D3EB909887D19F556BCE03351
              CAD0A84881CA750D4E892F77FA4A5555EF4907D3D9BB7E205A7519277156B402
              72EA19A75B8FF4017B559853DB3D08B350C75AE70350EE1644D60AE609CBC73D
              45AE0102462E002317CBE45378C1DBA330818B44A36C595FA1DC38DB752A6F04
              B2D0712BCDF2F448715A69EB11EEC23396D89E416BEF585B199A66464769CB93
              8822F633F4BC8539D983970817C84D406600903FCBE45B60C28C284C70BADF6C
              42B931F2DADD881E96F9CD60D24B781E7B137B80E5D9381CF918BE94CB1445D0
              61225BE62FC17316CAE7500F6A0340B4B51894A3C9FE22FEC6332F06206FBAC1
              273701E903061E9249AE93178111CEB56D2A8997DAB222431BF2AFC2EFFF9079
              B4815D83FC9DC8A76190C393256B281B46F01AEAA3B31D05B365A3BA1DF94F39
              8622D2EBC8BFCCD10E2E68D1C818594301207D01488772A9BBC86D3DC4BE3E7E
              3518F192E33A194AB34A3198F02698F03A748200740202C9AFFDEFC274A66B94
              E52907E813FC4DF988FF12A68F6EADBCCE75F6B710CE17A64C1A826B1500EB52
              80C51E4ABFAF45CEC983E30388BA0EDF53E436201C369E95490E1DE3F1B2E118
              F7B0C758E69553507E23F268B27F0442FB3980552D5AF59B29C8CB461EAD0177
              A36C99EC2987E4BB5E8BBC1763D447B30E17CEC6C8AC9B71CF62E112B90A0898
              9309E6F0ABB434DFC8301283419C1ED3F5670BCA8E92798384B9146B2DCB5AA0
              5A36320E89F440DC2BCB5B0B61318D85284B41FEA44C96A3A716A3A7D6BAC523
              2FACBD9CAE3E2F93F4361CDB91F10EE5B9CAC7D5BECF516E922DFF1C612E64D1
              6C6FE908D47538139B86B2EFDBCA5A80FC1AF9B77550173573BA91FA65D68D28
              FF6F6EF2C70B40C8D4CF6C59D403567750DE72BAC6C72AFAE7640F3A24F3B93E
              4ED71D0AE539328F0ED41CE2726D72867B41B8E0A4E201F3F1B53FDF415D3428
              AEB2659D86E7940A17C90B40F882965B0F17AACEC64B37B7571E423D17328143
              0F05FE1B287BA9ED59962BAA2563385B6AE30A8A32AF23FAB63067628329D43B
              681B9776FF265AFDB9DAF44A37C86DA14E73BBB532588D2F761CBED898CBA40E
              1D84BD800ED15592818F20584EDA749AA6306FC6359A5338EDBD5C5EBB07F98F
              C4AA0B726E20E41CE593A5C3CCC67DAB62DDD75DE43620FCFAFE49264F6A130E
              EEFD9D6875D5A14EB0549843D9566B3F07F79B84C3E1319AA6518E700DC3D2E8
              5F4099EF9D445DF6CD3DFF837BCF768B47AE01525EB1B3B7CFE7B37C70E9B158
              D4D1F0E124B95F84429B1B36ED9E85542EB7CBDF34E9FB6DD7E878F70086BC87
              EDFB41621100E19A4D99AC470F85427DF3F3861E71834F6E1A1767227A43263B
              ED612EB5F33B84399B2A6CA718CD291CDA9E403DBB3B598FDD33FFDB78CE1FDD
              E0939B8070E38D35443D8917BCA38BCFA3CE41C3231538EE45640F288762F8D5
              D1A3E55F8D2839AD53DBDF6CCF7F02916500A581321E27BB2E534299DF1389FE
              E1CDEF4940E2233701A186FCB44C2EC60BDEDCD5671A6BDEF689DADA1142D74D
              276A556D12E9693B9419339ABAF868B69736B78532F943B47751579E172FB909
              C80588D6C8E4DFF182533BF31C63D5EA6200C0E9EF85D0DDA9606A8E22BA5094
              0DB8F686D0B4E5CAAC2B3676B2BDF427FEBA4C5E88F6BEED069FDC0484A6729A
              3AC8400AE07EB1D6BEED0420868A709886C6D9C7DBADE1513E8D3DC32CA4E3B1
              A110B763D96F5D8DEBF72BB367C50D0CDADA4798FBDA590F1F966B99F47B9ADC
              560C3975BC4426E39E6919AFAC5C802F9EB39ED40808018C5029BD4C4048AAB1
              5C28C6CB82CBBF61F531F420219A9B856868B4C009A2D7DCAF5C393BA6A62EDB
              699F61FD09ED9CE9168FDC36BFDBB739D3897952AC836500C6B3006321182A20
              1F4C3054A51C7D8CB6AD944821CDB80F694D18CAE588C7B579402340A9AB8F6C
              30C43356E0FE6B95999704DBAB4F1E50437B5B647D3EDA36EA9E242F8C8B3C3A
              E35C99DC8E17FE3A5E38AA160C309E01476E8E0C4939D9189E4C05BDA5977A96
              AF45BF4531C43CF486D7F116C385A2461C170C457C19F6A94FE2FAEF702FD080
              2C0985BF0955BF4FA4B728CACBE8295745AB0F1F4C6F7C305C951C2EB3FE8A0F
              E65B6EF2C77540AAAAF70EC3C7CECD3896DB7FD429A5B172D50D60F66F2260E4
              E6B40E4FA0DAAC5E4519752D1F28BA310C4C7E58B4342F1629812D60761AC098
              0620866B61E37961E8FB4530789108B5F84420BD5454560909CA5D00E50445CF
              3135AF43A79A98933D68879BFCF1A2877048E012692F99751D00F9BDBD0CC0E8
              0F30E812941901C3EF6FFB10B6BAD532A5A3EC5230F97B082900E43E35ACDF8E
              DE937742E514F804C5309A00F038CCC0B63BDA46ABF13299E4B036BEBBCEEA8A
              97BC0084FB2F2C3BD6DB78E10B9D6530542D05D36E146969C2C8486F69D2FC67
              FB0C7D8366E82B55C3B80002BC142DFF48E8CAC218D51D006E9F28E63A89490D
              0DA64C51943FA0977C274AFB3835BF4026DF41FBCE77933F6ECFB2B821E6038B
              35E170786C5E6EF12E7B1963F5AB7DF125EF01C3FCA2209F8C436750C8A43A5C
              BD48A1B04D0BF617CDFEF92224EE8FCCA65A42E6CD7EC8989494C83D91670965
              5DB3A69DEDD3F5CB00A8D90B29DCCB2BE87E1F422F198A5ED2663DA6A27257B1
              A6695CC6B59CEECE72734391DB80D0E3E31A99A44EC2191737797E2C4C015A8D
              DEB1104C7B56A4A642CAA43D03613D150C3EF1A80B0251536B32D84E2A5E2933
              D304464446B6CD86A2BC859E75077AD66148FD3E911EC29E226509DAC5C5284E
              34E8A23454FEB64EB8E30136DF152E919BEB21193E9F8FCA56663B45F899BF1A
              58BF2DE83F70EC6ACCAA1408F45960F070A16A0FB729190C7276C05FE11AA3AC
              B24E94710958C9127D533394425376E440F6F4F25B6F794068FA5CE1D38F8826
              DF66D1D2425962B4F4CB7FA571E208F280AB8AED9DDE501B0A85FAE5E70DEDD0
              F1BBBBC81540E4522BD717E25A79D3AAEB4A033BCAF2219C37E31B6F442FB934
              AC294B54DDB846A1FEC12107B3A5C3C6C6A395C6166ECEA452C8AE32275F1933
              A1B732B2203245CE931FB9627C2254B10A32E76E94CAD735754FE3D0DEE5E1EC
              8C78D7CBB9D2795E476BFFDD456E01623F178BCAD662CCF7B95784BD85A72650
              707231A8F52BD58DC369DB0E96F96A1B2718AAB2A929A09D92DA103EA4844245
              0424249AABB7E96B5E18336F791BA7ED8D2FCFBD77843AE34E4DF8732232C832
              AB480A6506D63794F42B42CFEB63CF16E6317F9C707006588B365E2FCFE5B2C8
              9573B47A1C10285B93F062F42CB438C3C3639E7596937BD7B95FFC07B6ECDAC0
              B683DB7C3590FF3EF55D287BF744A6AE15950464DB0EF5BDB1A3662F3B41EB0E
              AD786993267CA3447E5E447F81B2884E02D99F9D56DA58D28F7B4FECC326FDAE
              1E8CB6271D6DA245DA5A26D001D21428B13DEA16D4E380E0A5E88C70A34CBE8A
              17BF2246790E6B1C82AC334F2A32BED87D4C0D86CCED6514E2478FF1570DBEFE
              6265F6AC36EBF2D061FA6206B58B3A097B087AD79B477BA7CDCC527B4D0DF62F
              A0BB90A59FF08C937968CFDF62B4C7BE01F479949F2F7A90DC0084E7EE5AA688
              33F0421FC7710F7B0BCFC22A8E3452D7D7646ED8FA0B11F4AD810CC815B5985D
              35367196F4014099634D5D8D55AB4740B62CC3CF33455A00B334D318801EB2B5
              7642F101E1D3CE915570AAFD8D784E6A405B38F3FA4826B7E39E9258F77485DC
              00E4F89958D03B52A07704E3BC6FB2648469330987C667ADDF750904F343915E
              525565E91F5C3BDF206F1B1B79276AF6B47D497D24949EB2AE61F4406BEA4CF3
              EF19F16EE2845ED20B7A8925CC7BFC2C2D3700E12E26CB729A8731B8F224EEA5
              E0BF8EBFFDE535A5815D474E3DDE668242F33AADB9BAF4678898E6534D8BB0D2
              FA6A8DC5BD4B5BF2B3AC19D53230F5FA78DB0019980B19680D8B0DB837BD27F9
              E5062014E8D6714727757203EEE5C9A3913D245A7D5369FAA6FD93D053382168
              129AEFCEE305090801B08100C08E223C86BC09F563068E0EA7A75A805C8536BC
              7C126DB09FECF029EE9DD293FC7203101E236E79A7D34573325E2ADE61EBB8EB
              9056D7F80500C91465FBC688DE03DE86ECF8C6F182C5558638921E16F57E1F84
              F887002247D18D5E420F139069F563068D0A6704AC43C9E276E941FD34807268
              B3D658EEC5BD0FC5736F67C90D4078A0244DD896B99D7BF5AE706E678B721F05
              3A27001167B8947DC7D6A794559580C91BA0B94F3916C8AADA9B9E1B9E58BE2F
              4B1D8211A5B056159B8AC27A7DCA53219FBAD8DF12FE5C314CF3477351CEFAE6
              8105D6E9A774A23B1DF5EF8A513FB7B5D12BDFDA0B494D7D18EEEB510F465714
              438CC337611CB6EF62E5FAF6225DD7DFCACD19D266A603460C81ACB906E5B9BC
              1BD97F8E21695F66E9CE143436725AE8FE8CFC9AD7FA0C0B9C5A575937F5F0F6
              7445A037640583A211EA798BAA0090E91AB57ADD88386143DA1CA99D34AC19CA
              A075947915EA78421EB4BCDB5E7F65D5EE81AAAA72B327BD64AC5D54947F0B20
              FF7AFCC46B379D1C8E6F337610CF3FB13683F2E870E73A464DDADA8D3B7D95F5
              132306436ADEAA2274BFDF00E3DA6F3FED554D981CE9E10822A19CB4750D9347
              D37098E52849817D50FEE65E9268E79A44DDC6DD13E4B6B5772E227A8E0C89F3
              960FC35B372CC9D85EF62BBF08F43DE12A1D1DA86BD856132302BEAECE04A32D
              0583030A1E6C1A5FC2AFFFCC38EBDF8DF03380B13CCEF25D262F16A8388FE7C2
              1037DE70C632CCD60E1A08A948D2276A85758AC3A6E5F34E4F350A1E0F28F9E3
              01CC614DF80B339442C0E037BF76F61C8262799B604A1C162DB5C78C1DA2D128
              D78462EC578476E590B94FAD936DA0DD8CBBAEE81B56E2A89FF28E33436EF479
              0D6D08B9C91FCFFFD0A5BC62A7E6F3F92C3B97DEDEAEDCCD2BAF0DE8A1E07CF0
              8CEBEF7D14A136162AE3EB73954169AAD06C2738184DD5C6E1BAC346699A2E82
              F4A57A5451B4A5A3E7BE541FEDB9D2693B527F2814D2F3F38676B82BB8A7C973
              404E9636BD72B562E8612EFB5E82EF793280E99FA61441374FF7E9A2A5AAC138
              B23F241AB91EFF2755F3BF33EACA177BDC64DE9DF4FF0E907F744A0292609404
              24C12809488251129004A3242009464940128C92802418250149304A02926094
              0424C12809488251129004A3242009464940128CFE0F4F25DFCE65EE47880000
              000049454E44AE426082}
            Proportional = True
            Transparent = True
          end
          object GroupBox1: TGroupBox
            Left = 72
            Top = 0
            Width = 274
            Height = 67
            Caption = 'Ollama'
            TabOrder = 0
            object Label3: TLabel
              Left = 13
              Top = 21
              Width = 39
              Height = 15
              Caption = '. Home'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clSilver
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              StyleElements = [seClient, seBorder]
            end
            object Label_OllamaWeb: TLabel
              Left = 75
              Top = 21
              Width = 108
              Height = 15
              Cursor = crHandPoint
              Caption = 'https://ollama.com/'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clSilver
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsUnderline]
              ParentFont = False
              StyleElements = [seClient, seBorder]
              OnClick = Label_GitHubClick
            end
            object Label7: TLabel
              Left = 13
              Top = 41
              Width = 44
              Height = 15
              Caption = '. GitHub'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clSilver
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              StyleElements = [seClient, seBorder]
            end
            object Label_OllamaGitHub: TLabel
              Left = 75
              Top = 41
              Width = 184
              Height = 15
              Cursor = crHandPoint
              Caption = 'https://github.com/ollama/ollama'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clSilver
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsUnderline]
              ParentFont = False
              StyleElements = [seClient, seBorder]
              OnClick = Label_GitHubClick
            end
          end
        end
      end
      object TabSheet_SysInfo: TTabSheet
        Caption = 'System Info.     '
        ImageIndex = 2
        object Label_SystemInfo: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 3
          Width = 332
          Height = 348
          Hint = 'Click to update'
          Margins.Left = 10
          Margins.Right = 10
          Align = alClient
          AutoSize = False
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          StyleElements = [seClient, seBorder]
          OnClick = Label_SystemInfoClick
          ExplicitLeft = 104
          ExplicitTop = 72
          ExplicitWidth = 40
          ExplicitHeight = 15
        end
      end
      object TabSheet_Shortcuts: TTabSheet
        Caption = 'Shortcuts     '
        ImageIndex = 1
        object ListView_Shortcuts: TListView
          Left = 0
          Top = 0
          Width = 352
          Height = 354
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Columns = <
            item
              Caption = 'Shortcut'
              Width = 70
            end
            item
              Caption = 'Description'
              Width = 260
            end>
          ColumnClick = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          FlatScrollBars = True
          Items.ItemData = {
            05E60100000F00000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
            0002460031000048C3653F00000000FFFFFFFFFFFFFFFF01000000FFFFFFFF00
            00000002460032000008C5653F00000000FFFFFFFFFFFFFFFF00000000FFFFFF
            FF00000000024600330000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF0000
            0000024600340000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF0000000002
            4600350000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF0000000002460036
            0000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF0000000002460037000000
            0000FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000024600380000000000FF
            FFFFFFFFFFFFFF00000000FFFFFFFF00000000024600390000000000FFFFFFFF
            FFFFFFFF00000000FFFFFFFF000000000346003100300000000000FFFFFFFFFF
            FFFFFF00000000FFFFFFFF000000000541006C0074002B00410000000000FFFF
            FFFFFFFFFFFF00000000FFFFFFFF000000000541006C0074002B004200000000
            00FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000541006C0074002B004300
            00000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000541006C0074002B
            00460000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF0000000000FFFFFFFF}
          StyleElements = [seClient, seBorder]
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object TabSheet_Settings: TTabSheet
        Caption = 'Settings'
        ImageIndex = 3
        object Label2: TLabel
          Left = 8
          Top = 9
          Width = 58
          Height = 15
          Caption = 'Skin / Style'
          StyleElements = [seClient, seBorder]
        end
        object SpeedButton_DefaultColor: TSpeedButton
          Left = 8
          Top = 165
          Width = 52
          Height = 23
          Caption = 'Default'
          Flat = True
          OnClick = SpeedButton_DefaultColorClick
        end
        object SpeedButton_CancelColors: TSpeedButton
          Left = 228
          Top = 165
          Width = 52
          Height = 23
          Caption = 'Cancel'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnFace
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          StyleElements = [seClient, seBorder]
          OnClick = SpeedButton_CancelColorsClick
        end
        object SpeedButton_ApplyColors: TSpeedButton
          Left = 288
          Top = 165
          Width = 52
          Height = 23
          Caption = 'Apply'
          Flat = True
          OnClick = SpeedButton_ApplyColorsClick
        end
        object SpeedButton_ApplySkin: TSpeedButton
          Left = 288
          Top = 6
          Width = 52
          Height = 23
          Caption = 'Apply'
          Flat = True
          OnClick = SpeedButton_ApplySkinClick
        end
        object ComboBox_VclStyles: TComboBox
          Left = 76
          Top = 6
          Width = 206
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'Windows10 SlateGray'
          Items.Strings = (
            'Windows10 SlateGray'
            'Windows11 Impressive Dark'
            'Windows11 Modern Dark')
        end
        object GroupBox_Colors: TGroupBox
          Left = 8
          Top = 41
          Width = 338
          Height = 125
          Margins.Right = 10
          Caption = 'Chatting Box Node Colors'
          TabOrder = 1
          StyleElements = [seClient, seBorder]
          object Label9: TLabel
            Left = 155
            Top = 26
            Width = 55
            Height = 15
            Caption = '-----------'
            StyleElements = [seClient, seBorder]
          end
          object Label4: TLabel
            Left = 16
            Top = 47
            Width = 52
            Height = 15
            Caption = '[ Header ]'
            StyleElements = [seClient, seBorder]
          end
          object Label5: TLabel
            Left = 16
            Top = 71
            Width = 41
            Height = 15
            Caption = '[ Body ]'
            StyleElements = [seClient, seBorder]
          end
          object Label6: TLabel
            Left = 16
            Top = 95
            Width = 48
            Height = 15
            Caption = '[ Footer ]'
            StyleElements = [seClient, seBorder]
          end
          object SpeedButton_Header: TSpeedButton
            Tag = 1
            Left = 86
            Top = 45
            Width = 71
            Height = 22
            Caption = 'Set Color'
            Flat = True
            OnClick = SpeedButton_HeaderClick
          end
          object SpeedButton_Body: TSpeedButton
            Tag = 2
            Left = 86
            Top = 69
            Width = 71
            Height = 22
            Caption = 'Set Color'
            Flat = True
            OnClick = SpeedButton_HeaderClick
          end
          object SpeedButton_Footer: TSpeedButton
            Tag = 3
            Left = 86
            Top = 93
            Width = 71
            Height = 22
            Caption = 'Set Color'
            Flat = True
            OnClick = SpeedButton_HeaderClick
          end
          object Label8: TLabel
            Left = 16
            Top = 24
            Width = 62
            Height = 15
            Caption = '[ Selection ]'
            StyleElements = [seClient, seBorder]
          end
          object Shape_Selection: TShape
            Left = 205
            Top = 19
            Width = 124
            Height = 97
            Brush.Color = clDarkslateblue
          end
          object SpeedButton_Selection: TSpeedButton
            Left = 86
            Top = 22
            Width = 71
            Height = 22
            Caption = 'Set Color'
            Flat = True
            OnClick = SpeedButton_HeaderClick
          end
          object Shape_Header: TShape
            Left = 163
            Top = 47
            Width = 20
            Height = 20
            Brush.Color = clBtnFace
          end
          object Shape_Body: TShape
            Left = 163
            Top = 71
            Width = 20
            Height = 20
            Brush.Color = clBtnFace
          end
          object Shape_Footer: TShape
            Left = 163
            Top = 95
            Width = 20
            Height = 20
            Brush.Color = clSilver
          end
          object Label_Header: TLabel
            Left = 215
            Top = 33
            Width = 38
            Height = 15
            Caption = 'Ollama'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnFace
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            StyleElements = [seClient, seBorder]
          end
          object Label_Body: TLabel
            Left = 215
            Top = 50
            Width = 100
            Height = 42
            AutoSize = False
            Caption = 'Get up and running with large language models.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnFace
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            WordWrap = True
            StyleElements = [seClient, seBorder]
          end
          object Label_Footer: TLabel
            Left = 278
            Top = 100
            Width = 42
            Height = 13
            Caption = '12:30:30'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clSilver
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            StyleElements = [seClient, seBorder]
          end
        end
        object GroupBox_Options: TGroupBox
          Left = 8
          Top = 193
          Width = 338
          Height = 155
          Caption = 'More control ...'
          TabOrder = 2
          object Label10: TLabel
            Left = 16
            Top = 107
            Width = 83
            Height = 15
            Caption = 'MRU Topic Max'
            StyleElements = [seClient, seBorder]
          end
          object Label11: TLabel
            Left = 170
            Top = 107
            Width = 88
            Height = 15
            Caption = 'Sub Prompt Max'
            StyleElements = [seClient, seBorder]
          end
          object Label12: TLabel
            Left = 170
            Top = 128
            Width = 93
            Height = 15
            Caption = 'ChatBox H-Offset'
            StyleElements = [seClient, seBorder]
          end
          object Label14: TLabel
            Left = 16
            Top = 128
            Width = 75
            Height = 15
            Caption = 'HIS Items Max'
            StyleElements = [seClient, seBorder]
          end
          object CheckBox_BeepSound: TCheckBox
            Left = 16
            Top = 72
            Width = 113
            Height = 17
            Caption = 'Use Beep Sound'
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
            StyleElements = [seClient, seBorder]
            OnClick = CheckBox_BeepSoundClick
          end
          object CheckBox_SaveOnCLose: TCheckBox
            AlignWithMargins = True
            Left = 189
            Top = 48
            Width = 132
            Height = 17
            Caption = 'Save Logs on Close'
            TabOrder = 1
            StyleElements = [seClient, seBorder]
            OnClick = CheckBox_SaveOnCLoseClick
          end
          object CheckBox_NoCheckAlive: TCheckBox
            Left = 16
            Top = 23
            Width = 297
            Height = 17
            Caption = 'Without Checking Ollama Alive on Start ( * Restart)'
            TabOrder = 2
            StyleElements = [seClient, seBorder]
            OnClick = CheckBox_NoCheckAliveClick
          end
          object ComboBox_MRUROOT_Max: TComboBox
            Left = 110
            Top = 104
            Width = 40
            Height = 23
            Style = csDropDownList
            DropDownCount = 10
            ItemIndex = 3
            TabOrder = 3
            Text = '25'
            StyleElements = [seClient, seBorder]
            OnChange = ComboBox_MRUROOT_MaxChange
            Items.Strings = (
              '10'
              '15'
              '20'
              '25'
              '30'
              '35'
              '40'
              '45'
              '50')
          end
          object ComboBox_MRUCHILD_Max: TComboBox
            Left = 275
            Top = 104
            Width = 40
            Height = 23
            Style = csDropDownList
            DropDownCount = 10
            ItemIndex = 3
            TabOrder = 4
            Text = '25'
            StyleElements = [seClient, seBorder]
            OnChange = ComboBox_MRUCHILD_MaxChange
            Items.Strings = (
              '10'
              '15'
              '20'
              '25'
              '30'
              '35'
              '40'
              '45'
              '50')
          end
          object ComboBox_ChatBoxHOffset: TComboBox
            Left = 275
            Top = 125
            Width = 40
            Height = 23
            Style = csDropDownList
            DropDownCount = 10
            ItemIndex = 1
            TabOrder = 5
            Text = '15'
            StyleElements = [seClient, seBorder]
            OnChange = ComboBox_ChatBoxHOffsetChange
            Items.Strings = (
              '10'
              '15'
              '20'
              '25'
              '30')
          end
          object CheckBox_SaveContents: TCheckBox
            Left = 16
            Top = 48
            Width = 153
            Height = 17
            Caption = 'Save Contents on Close'
            TabOrder = 6
            StyleElements = [seClient, seBorder]
            OnClick = CheckBox_SaveContentsClick
          end
          object ComboBox_MaxHistory: TComboBox
            Left = 110
            Top = 125
            Width = 40
            Height = 23
            Style = csDropDownList
            DropDownCount = 10
            ItemIndex = 3
            TabOrder = 7
            Text = '25'
            StyleElements = [seClient, seBorder]
            OnChange = ComboBox_MaxHistoryChange
            Items.Strings = (
              '10'
              '15'
              '20'
              '25'
              '30'
              '35'
              '40'
              '45'
              '50')
          end
          object CheckBox_Experimental: TCheckBox
            AlignWithMargins = True
            Left = 189
            Top = 72
            Width = 132
            Height = 17
            Caption = 'Experimental Seed (*)'
            TabOrder = 8
            StyleElements = [seClient, seBorder]
            OnClick = CheckBox_ExperimentalClick
          end
        end
      end
    end
  end
  object ColorDialog_Colors: TColorDialog
    Left = 57
    Top = 436
  end
end
