unit SpeechLib_TLB;

// ************************************************************************  //
// Type Lib: C:\WINDOWS\System32\Speech\Common\sapi.dll (1)
// LIBID: {C866CA3A-32F7-11D2-9602-00C04F8EE628}
// ************************************************************************ //

// Modified by ichin 2024-05-23 ¸ñ ¿ÀÀü 6:18:32
{ Partial import of sapi.dll type library }

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses
  Winapi.Windows,
  System.Classes,
  System.Variants,
  System.Win.StdVCL,
  Vcl.Graphics,
  Vcl.OleServer,
  Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//

const
  // TypeLibrary Major and minor versions
  SpeechLibMajorVersion = 5;
  SpeechLibMinorVersion = 4;

  LIBID_SpeechLib: TGUID = '{C866CA3A-32F7-11D2-9602-00C04F8EE628}';

  IID_ISpeechDataKey: TGUID = '{CE17C09B-4EFA-44D5-A4C9-59D9585AB0CD}';
  IID_ISpeechObjectToken: TGUID = '{C74A3ADC-B727-4500-A84A-B526721C8B8C}';
  IID_ISpeechObjectTokenCategory: TGUID = '{CA7EAC50-2D01-4145-86D4-5AE7D70F4469}';
  IID_ISpeechObjectTokens: TGUID = '{9285B776-2E7B-4BC0-B53E-580EB6FA967F}';
  IID_ISpeechAudioBufferInfo: TGUID = '{11B103D8-1142-4EDF-A093-82FB3915F8CC}';
  IID_ISpeechAudioStatus: TGUID = '{C62D9C91-7458-47F6-862D-1EF86FB0B278}';
  IID_ISpeechAudioFormat: TGUID = '{E6E9C590-3E18-40E3-8299-061F98BDE7C7}';
  IID_ISpeechWaveFormatEx: TGUID = '{7A1EF0D5-1581-4741-88E4-209A49F11A10}';
  IID_ISpeechBaseStream: TGUID = '{6450336F-7D49-4CED-8097-49D6DEE37294}';
  IID_ISpeechAudio: TGUID = '{CFF8E175-019E-11D3-A08E-00C04F8EF9B5}';
  IID_ISpeechVoice: TGUID = '{269316D8-57BD-11D2-9EEE-00C04F797396}';
  IID_ISpeechVoiceStatus: TGUID = '{8BE47B07-57F6-11D2-9EEE-00C04F797396}';
  DIID__ISpeechVoiceEvents: TGUID = '{A372ACD1-3BEF-4BBD-8FFB-CB3E2B416AF8}';
  IID_ISpNotifySink: TGUID = '{259684DC-37C3-11D2-9603-00C04F8EE628}';
  CLASS_SpNotifyTranslator: TGUID = '{E2AE5372-5D40-11D2-960E-00C04F8EE628}';
  IID_ISpDataKey: TGUID = '{14056581-E16C-11D2-BB90-00C04F8EE6C0}';
  IID_ISpObjectTokenCategory: TGUID = '{2D3D3845-39AF-4850-BBF9-40B49780011D}';
  CLASS_SpObjectTokenCategory: TGUID = '{A910187F-0C7A-45AC-92CC-59EDAFB77B53}';
  IID_IEnumSpObjectTokens: TGUID = '{06B64F9E-7FDA-11D2-B4F2-00C04F797396}';
  IID_ISpObjectToken: TGUID = '{14056589-E16C-11D2-BB90-00C04F8EE6C0}';
  CLASS_SpObjectToken: TGUID = '{EF411752-3736-4CB4-9C8C-8EF4CCB58EFE}';
  IID_IStream: TGUID = '{0000000C-0000-0000-C000-000000000046}';
  IID_ISpNotifySource: TGUID = '{5EFF4AEF-8487-11D2-961C-00C04F8EE628}';
  IID_ISpEventSource: TGUID = '{BE7A9CCE-5F9E-11D2-960F-00C04F8EE628}';
  IID_ISpEventSink: TGUID = '{BE7A9CC9-5F9E-11D2-960F-00C04F8EE628}';
  IID_ISpObjectWithToken: TGUID = '{5B559F40-E952-11D2-BB91-00C04F8EE6C0}';
  CLASS_SpStream: TGUID = '{715D9C59-4442-11D2-9605-00C04F8EE628}';
  IID_ISpVoice: TGUID = '{6C44DF74-72B9-4992-A1EC-EF996E0422D4}';
  CLASS_SpVoice: TGUID = '{96749377-3391-11D2-9EE3-00C04F797396}';
  CLASS_SpAudioFormat: TGUID = '{9EF96870-E160-4792-820D-48CF0649E4EC}';
  CLASS_SpWaveFormatEx: TGUID = '{C79A574C-63BE-44B9-801F-283F87F898BE}';
  CLASS_SpCustomStream: TGUID = '{8DBEF13F-1948-4AA8-8CF0-048EEBED95D8}';
  CLASS_SpFileStream: TGUID = '{947812B3-2AE1-4644-BA86-9E90DED7EC91}';
  CLASS_SpMemoryStream: TGUID = '{5FB7EF7D-DFF4-468A-B6B7-2FCBD188F994}';
  IID_IEnumString: TGUID = '{00000101-0000-0000-C000-000000000046}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum SpeechDataKeyLocation
type
  SpeechDataKeyLocation = TOleEnum;
const
  SDKLDefaultLocation = $00000000;
  SDKLCurrentUser     = $00000001;
  SDKLLocalMachine    = $00000002;
  SDKLCurrentConfig   = $00000005;

  // Constants for enum SpeechTokenContext
type
  SpeechTokenContext = TOleEnum;
const
  STCInprocServer  = $00000001;
  STCInprocHandler = $00000002;
  STCLocalServer   = $00000004;
  STCRemoteServer  = $00000010;
  STCAll           = $00000017;

  // Constants for enum SpeechTokenShellFolder
type
  SpeechTokenShellFolder = TOleEnum;
const
  STSF_AppData       = $0000001A;
  STSF_LocalAppData  = $0000001C;
  STSF_CommonAppData = $00000023;
  STSF_FlagCreate    = $00008000;

  // Constants for enum SpeechAudioState
type
  SpeechAudioState = TOleEnum;
const
  SASClosed = $00000000;
  SASStop   = $00000001;
  SASPause  = $00000002;
  SASRun    = $00000003;

  // Constants for enum SpeechAudioFormatType
type
  SpeechAudioFormatType = TOleEnum;
const
  SAFTDefault                 = $FFFFFFFF;
  SAFTNoAssignedFormat        = $00000000;
  SAFTText                    = $00000001;
  SAFTNonStandardFormat       = $00000002;
  SAFTExtendedAudioFormat     = $00000003;
  SAFT8kHz8BitMono            = $00000004;
  SAFT8kHz8BitStereo          = $00000005;
  SAFT8kHz16BitMono           = $00000006;
  SAFT8kHz16BitStereo         = $00000007;
  SAFT11kHz8BitMono           = $00000008;
  SAFT11kHz8BitStereo         = $00000009;
  SAFT11kHz16BitMono          = $0000000A;
  SAFT11kHz16BitStereo        = $0000000B;
  SAFT12kHz8BitMono           = $0000000C;
  SAFT12kHz8BitStereo         = $0000000D;
  SAFT12kHz16BitMono          = $0000000E;
  SAFT12kHz16BitStereo        = $0000000F;
  SAFT16kHz8BitMono           = $00000010;
  SAFT16kHz8BitStereo         = $00000011;
  SAFT16kHz16BitMono          = $00000012;
  SAFT16kHz16BitStereo        = $00000013;
  SAFT22kHz8BitMono           = $00000014;
  SAFT22kHz8BitStereo         = $00000015;
  SAFT22kHz16BitMono          = $00000016;
  SAFT22kHz16BitStereo        = $00000017;
  SAFT24kHz8BitMono           = $00000018;
  SAFT24kHz8BitStereo         = $00000019;
  SAFT24kHz16BitMono          = $0000001A;
  SAFT24kHz16BitStereo        = $0000001B;
  SAFT32kHz8BitMono           = $0000001C;
  SAFT32kHz8BitStereo         = $0000001D;
  SAFT32kHz16BitMono          = $0000001E;
  SAFT32kHz16BitStereo        = $0000001F;
  SAFT44kHz8BitMono           = $00000020;
  SAFT44kHz8BitStereo         = $00000021;
  SAFT44kHz16BitMono          = $00000022;
  SAFT44kHz16BitStereo        = $00000023;
  SAFT48kHz8BitMono           = $00000024;
  SAFT48kHz8BitStereo         = $00000025;
  SAFT48kHz16BitMono          = $00000026;
  SAFT48kHz16BitStereo        = $00000027;
  SAFTTrueSpeech_8kHz1BitMono = $00000028;
  SAFTCCITT_ALaw_8kHzMono     = $00000029;
  SAFTCCITT_ALaw_8kHzStereo   = $0000002A;
  SAFTCCITT_ALaw_11kHzMono    = $0000002B;
  SAFTCCITT_ALaw_11kHzStereo  = $0000002C;
  SAFTCCITT_ALaw_22kHzMono    = $0000002D;
  SAFTCCITT_ALaw_22kHzStereo  = $0000002E;
  SAFTCCITT_ALaw_44kHzMono    = $0000002F;
  SAFTCCITT_ALaw_44kHzStereo  = $00000030;
  SAFTCCITT_uLaw_8kHzMono     = $00000031;
  SAFTCCITT_uLaw_8kHzStereo   = $00000032;
  SAFTCCITT_uLaw_11kHzMono    = $00000033;
  SAFTCCITT_uLaw_11kHzStereo  = $00000034;
  SAFTCCITT_uLaw_22kHzMono    = $00000035;
  SAFTCCITT_uLaw_22kHzStereo  = $00000036;
  SAFTCCITT_uLaw_44kHzMono    = $00000037;
  SAFTCCITT_uLaw_44kHzStereo  = $00000038;
  SAFTADPCM_8kHzMono          = $00000039;
  SAFTADPCM_8kHzStereo        = $0000003A;
  SAFTADPCM_11kHzMono         = $0000003B;
  SAFTADPCM_11kHzStereo       = $0000003C;
  SAFTADPCM_22kHzMono         = $0000003D;
  SAFTADPCM_22kHzStereo       = $0000003E;
  SAFTADPCM_44kHzMono         = $0000003F;
  SAFTADPCM_44kHzStereo       = $00000040;
  SAFTGSM610_8kHzMono         = $00000041;
  SAFTGSM610_11kHzMono        = $00000042;
  SAFTGSM610_22kHzMono        = $00000043;
  SAFTGSM610_44kHzMono        = $00000044;

  // Constants for enum SpeechStreamSeekPositionType
type
  SpeechStreamSeekPositionType = TOleEnum;
const
  SSSPTRelativeToStart           = $00000000;
  SSSPTRelativeToCurrentPosition = $00000001;
  SSSPTRelativeToEnd             = $00000002;

  // Constants for enum SpeechStreamFileMode
type
  SpeechStreamFileMode = TOleEnum;
const
  SSFMOpenForRead    = $00000000;
  SSFMOpenReadWrite  = $00000001;
  SSFMCreate         = $00000002;
  SSFMCreateForWrite = $00000003;

  // Constants for enum SpeechRunState
type
  SpeechRunState = TOleEnum;
const
  SRSEDone       = $00000001;
  SRSEIsSpeaking = $00000002;

  // Constants for enum SpeechVoiceEvents
type
  SpeechVoiceEvents = TOleEnum;
const
  SVEStartInputStream = $00000002;
  SVEEndInputStream   = $00000004;
  SVEVoiceChange      = $00000008;
  SVEBookmark         = $00000010;
  SVEWordBoundary     = $00000020;
  SVEPhoneme          = $00000040;
  SVESentenceBoundary = $00000080;
  SVEViseme           = $00000100;
  SVEAudioLevel       = $00000200;
  SVEPrivate          = $00008000;
  SVEAllEvents        = $000083FE;

  // Constants for enum SpeechVoicePriority
type
  SpeechVoicePriority = TOleEnum;
const
  SVPNormal = $00000000;
  SVPAlert  = $00000001;
  SVPOver   = $00000002;

  // Constants for enum SpeechVoiceSpeakFlags
type
  SpeechVoiceSpeakFlags = TOleEnum;
const
  SVSFDefault          = $00000000;
  SVSFlagsAsync        = $00000001;
  SVSFPurgeBeforeSpeak = $00000002;
  SVSFIsFilename       = $00000004;
  SVSFIsXML            = $00000008;
  SVSFIsNotXML         = $00000010;
  SVSFPersistXML       = $00000020;
  SVSFNLPSpeakPunc     = $00000040;
  SVSFParseSapi        = $00000080;
  SVSFParseSsml        = $00000100;
  SVSFParseAutodetect  = $00000000;
  SVSFNLPMask          = $00000040;
  SVSFParseMask        = $00000180;
  SVSFVoiceMask        = $000001FF;
  SVSFUnusedFlags      = $FFFFFE00;

  // Constants for enum SpeechVisemeFeature
type
  SpeechVisemeFeature = TOleEnum;
const
  SVF_None     = $00000000;
  SVF_Stressed = $00000001;
  SVF_Emphasis = $00000002;

  // Constants for enum SpeechVisemeType

type
  SpeechVisemeType = TOleEnum;
const
  SVP_0  = $00000000;
  SVP_1  = $00000001;
  SVP_2  = $00000002;
  SVP_3  = $00000003;
  SVP_4  = $00000004;
  SVP_5  = $00000005;
  SVP_6  = $00000006;
  SVP_7  = $00000007;
  SVP_8  = $00000008;
  SVP_9  = $00000009;
  SVP_10 = $0000000A;
  SVP_11 = $0000000B;
  SVP_12 = $0000000C;
  SVP_13 = $0000000D;
  SVP_14 = $0000000E;
  SVP_15 = $0000000F;
  SVP_16 = $00000010;
  SVP_17 = $00000011;
  SVP_18 = $00000012;
  SVP_19 = $00000013;
  SVP_20 = $00000014;
  SVP_21 = $00000015;


  // Constants for enum SpeechFormatType
type
  SpeechFormatType = TOleEnum;
const
  SFTInput    = $00000000;
  SFTSREngine = $00000001;

  // Constants for enum SpeechPartOfSpeech
type
  SpeechPartOfSpeech = TOleEnum;
const
  SPSNotOverriden = $FFFFFFFF;
  SPSUnknown      = $00000000;
  SPSNoun         = $00001000;
  SPSVerb         = $00002000;
  SPSModifier     = $00003000;
  SPSFunction     = $00004000;
  SPSInterjection = $00005000;
  SPSLMA          = $00007000;
  SPSSuppressWord = $0000F000;

  // Constants for enum DISPID_SpeechDataKey
type
  DISPID_SpeechDataKey = TOleEnum;
const
  DISPID_SDKSetBinaryValue = $00000001;
  DISPID_SDKGetBinaryValue = $00000002;
  DISPID_SDKSetStringValue = $00000003;
  DISPID_SDKGetStringValue = $00000004;
  DISPID_SDKSetLongValue   = $00000005;
  DISPID_SDKGetlongValue   = $00000006;
  DISPID_SDKOpenKey        = $00000007;
  DISPID_SDKCreateKey      = $00000008;
  DISPID_SDKDeleteKey      = $00000009;
  DISPID_SDKDeleteValue    = $0000000A;
  DISPID_SDKEnumKeys       = $0000000B;
  DISPID_SDKEnumValues     = $0000000C;

  // Constants for enum DISPID_SpeechObjectToken
type
  DISPID_SpeechObjectToken = TOleEnum;
const
  DISPID_SOTId                    = $00000001;
  DISPID_SOTDataKey               = $00000002;
  DISPID_SOTCategory              = $00000003;
  DISPID_SOTGetDescription        = $00000004;
  DISPID_SOTSetId                 = $00000005;
  DISPID_SOTGetAttribute          = $00000006;
  DISPID_SOTCreateInstance        = $00000007;
  DISPID_SOTRemove                = $00000008;
  DISPID_SOTGetStorageFileName    = $00000009;
  DISPID_SOTRemoveStorageFileName = $0000000A;
  DISPID_SOTIsUISupported         = $0000000B;
  DISPID_SOTDisplayUI             = $0000000C;
  DISPID_SOTMatchesAttributes     = $0000000D;

  // Constants for enum DISPID_SpeechObjectTokens
type
  DISPID_SpeechObjectTokens = TOleEnum;
const
  DISPID_SOTsCount    = $00000001;
  DISPID_SOTsItem     = $00000000;
  DISPID_SOTs_NewEnum = $FFFFFFFC;

  // Constants for enum DISPID_SpeechObjectTokenCategory
type
  DISPID_SpeechObjectTokenCategory = TOleEnum;
const
  DISPID_SOTCId              = $00000001;
  DISPID_SOTCDefault         = $00000002;
  DISPID_SOTCSetId           = $00000003;
  DISPID_SOTCGetDataKey      = $00000004;
  DISPID_SOTCEnumerateTokens = $00000005;

  // Constants for enum DISPID_SpeechVoice
type
  DISPID_SpeechVoice = TOleEnum;
const
  DISPID_SVStatus            = $00000001;
  DISPID_SVVoice             = $00000002;
  DISPID_SVAudioOutput       = $00000003;
  DISPID_SVAudioOutputStream = $00000004;
  DISPID_SVRate              = $00000005;
  DISPID_SVVolume            = $00000006;
  DISPID_SVAllowAudioOuputFormatChangesOnNextSet = $00000007;
  DISPID_SVEventInterests         = $00000008;
  DISPID_SVPriority               = $00000009;
  DISPID_SVAlertBoundary          = $0000000A;
  DISPID_SVSyncronousSpeakTimeout = $0000000B;
  DISPID_SVSpeak                  = $0000000C;
  DISPID_SVSpeakStream            = $0000000D;
  DISPID_SVPause                  = $0000000E;
  DISPID_SVResume                 = $0000000F;
  DISPID_SVSkip                   = $00000010;
  DISPID_SVGetVoices              = $00000011;
  DISPID_SVGetAudioOutputs        = $00000012;
  DISPID_SVWaitUntilDone          = $00000013;
  DISPID_SVSpeakCompleteEvent     = $00000014;
  DISPID_SVIsUISupported          = $00000015;
  DISPID_SVDisplayUI              = $00000016;


  // Constants for enum DISPID_SpeechVoiceStatus
type
  DISPID_SpeechVoiceStatus = TOleEnum;
const
  DISPID_SVSCurrentStreamNumber    = $00000001;
  DISPID_SVSLastStreamNumberQueued = $00000002;
  DISPID_SVSLastResult             = $00000003;
  DISPID_SVSRunningState           = $00000004;
  DISPID_SVSInputWordPosition      = $00000005;
  DISPID_SVSInputWordLength        = $00000006;
  DISPID_SVSInputSentencePosition  = $00000007;
  DISPID_SVSInputSentenceLength    = $00000008;
  DISPID_SVSLastBookmark           = $00000009;
  DISPID_SVSLastBookmarkId         = $0000000A;
  DISPID_SVSPhonemeId              = $0000000B;
  DISPID_SVSVisemeId               = $0000000C;

  // Constants for enum DISPID_SpeechVoiceEvent
type
  DISPID_SpeechVoiceEvent = TOleEnum;
const
  DISPID_SVEStreamStart      = $00000001;
  DISPID_SVEStreamEnd        = $00000002;
  DISPID_SVEVoiceChange      = $00000003;
  DISPID_SVEBookmark         = $00000004;
  DISPID_SVEWord             = $00000005;
  DISPID_SVEPhoneme          = $00000006;
  DISPID_SVESentenceBoundary = $00000007;
  DISPID_SVEViseme           = $00000008;
  DISPID_SVEAudioLevel       = $00000009;
  DISPID_SVEEnginePrivate    = $0000000A;

  // Constants for enum DISPIDSPTSI
type
  DISPIDSPTSI = TOleEnum;
const
  DISPIDSPTSI_ActiveOffset    = $00000001;
  DISPIDSPTSI_ActiveLength    = $00000002;
  DISPIDSPTSI_SelectionOffset = $00000003;
  DISPIDSPTSI_SelectionLength = $00000004;


  // Constants for enum SPDATAKEYLOCATION
type
  SPDATAKEYLOCATION = TOleEnum;
const
  SPDKL_DefaultLocation = $00000000;
  SPDKL_CurrentUser     = $00000001;
  SPDKL_LocalMachine    = $00000002;
  SPDKL_CurrentConfig   = $00000005;

  // Constants for enum _SPAUDIOSTATE
type
  _SPAUDIOSTATE = TOleEnum;
const
  SPAS_CLOSED = $00000000;
  SPAS_STOP   = $00000001;
  SPAS_PAUSE  = $00000002;
  SPAS_RUN    = $00000003;

  // Constants for enum SPFILEMODE
type
  SPFILEMODE = TOleEnum;
const
  SPFM_OPEN_READONLY  = $00000000;
  SPFM_OPEN_READWRITE = $00000001;
  SPFM_CREATE         = $00000002;
  SPFM_CREATE_ALWAYS  = $00000003;
  SPFM_NUM_MODES      = $00000004;

  // Constants for enum SPVISEMES
type
  SPVISEMES = TOleEnum;
const
  SP_VISEME_0  = $00000000;
  SP_VISEME_1  = $00000001;
  SP_VISEME_2  = $00000002;
  SP_VISEME_3  = $00000003;
  SP_VISEME_4  = $00000004;
  SP_VISEME_5  = $00000005;
  SP_VISEME_6  = $00000006;
  SP_VISEME_7  = $00000007;
  SP_VISEME_8  = $00000008;
  SP_VISEME_9  = $00000009;
  SP_VISEME_10 = $0000000A;
  SP_VISEME_11 = $0000000B;
  SP_VISEME_12 = $0000000C;
  SP_VISEME_13 = $0000000D;
  SP_VISEME_14 = $0000000E;
  SP_VISEME_15 = $0000000F;
  SP_VISEME_16 = $00000010;
  SP_VISEME_17 = $00000011;
  SP_VISEME_18 = $00000012;
  SP_VISEME_19 = $00000013;
  SP_VISEME_20 = $00000014;
  SP_VISEME_21 = $00000015;

  // Constants for enum SPVPRIORITY
type
  SPVPRIORITY = TOleEnum;
const
  SPVPRI_NORMAL = $00000000;
  SPVPRI_ALERT  = $00000001;
  SPVPRI_OVER   = $00000002;

  // Constants for enum SPEVENTENUM
type
  SPEVENTENUM = TOleEnum;
const
  SPEI_UNDEFINED               = $00000000;
  SPEI_START_INPUT_STREAM      = $00000001;
  SPEI_END_INPUT_STREAM        = $00000002;
  SPEI_VOICE_CHANGE            = $00000003;
  SPEI_TTS_BOOKMARK            = $00000004;
  SPEI_WORD_BOUNDARY           = $00000005;
  SPEI_PHONEME                 = $00000006;
  SPEI_SENTENCE_BOUNDARY       = $00000007;
  SPEI_VISEME                  = $00000008;
  SPEI_TTS_AUDIO_LEVEL         = $00000009;
  SPEI_TTS_PRIVATE             = $0000000F;
  SPEI_MIN_TTS                 = $00000001;
  SPEI_MAX_TTS                 = $0000000F;
  SPEI_END_SR_STREAM           = $00000022;
  SPEI_SOUND_START             = $00000023;
  SPEI_SOUND_END               = $00000024;
  SPEI_PHRASE_START            = $00000025;
  SPEI_RECOGNITION             = $00000026;
  SPEI_HYPOTHESIS              = $00000027;
  SPEI_SR_BOOKMARK             = $00000028;
  SPEI_PROPERTY_NUM_CHANGE     = $00000029;
  SPEI_PROPERTY_STRING_CHANGE  = $0000002A;
  SPEI_FALSE_RECOGNITION       = $0000002B;
  SPEI_INTERFERENCE            = $0000002C;
  SPEI_REQUEST_UI              = $0000002D;
  SPEI_RECO_STATE_CHANGE       = $0000002E;
  SPEI_ADAPTATION              = $0000002F;
  SPEI_START_SR_STREAM         = $00000030;
  SPEI_RECO_OTHER_CONTEXT      = $00000031;
  SPEI_SR_AUDIO_LEVEL          = $00000032;
  SPEI_SR_RETAINEDAUDIO        = $00000033;
  SPEI_SR_PRIVATE              = $00000034;
  SPEI_ACTIVE_CATEGORY_CHANGED = $00000035;
  SPEI_RESERVED5               = $00000036;
  SPEI_RESERVED6               = $00000037;
  SPEI_MIN_SR                  = $00000022;
  SPEI_MAX_SR                  = $00000037;
  SPEI_RESERVED1               = $0000001E;
  SPEI_RESERVED2               = $00000021;
  SPEI_RESERVED3               = $0000003F;

  // Constants for enum SPWAVEFORMATTYPE
type
  SPWAVEFORMATTYPE = TOleEnum;
const
  SPWF_INPUT    = $00000000;
  SPWF_SRENGINE = $00000001;

  // Constants for enum SPSEMANTICFORMAT
type
  SPSEMANTICFORMAT = TOleEnum;
const
  SPSMF_SAPI_PROPERTIES                 = $00000000;
  SPSMF_SRGS_SEMANTICINTERPRETATION_MS  = $00000001;
  SPSMF_SRGS_SAPIPROPERTIES             = $00000002;
  SPSMF_UPS                             = $00000004;
  SPSMF_SRGS_SEMANTICINTERPRETATION_W3C = $00000008;

  // Constants for enum SPRULESTATE
type
  SPRULESTATE = TOleEnum;
const
  SPRS_INACTIVE               = $00000000;
  SPRS_ACTIVE                 = $00000001;
  SPRS_ACTIVE_WITH_AUTO_PAUSE = $00000003;
  SPRS_ACTIVE_USER_DELIMITED  = $00000004;

  // Constants for enum SPWORDPRONOUNCEABLE
type
  SPWORDPRONOUNCEABLE = TOleEnum;
const
  SPWP_UNKNOWN_WORD_UNPRONOUNCEABLE = $00000000;
  SPWP_UNKNOWN_WORD_PRONOUNCEABLE   = $00000001;
  SPWP_KNOWN_WORD_PRONOUNCEABLE     = $00000002;

  // Constants for enum SPGRAMMARSTATE
type
  SPGRAMMARSTATE = TOleEnum;
const
  SPGS_DISABLED  = $00000000;
  SPGS_ENABLED   = $00000001;
  SPGS_EXCLUSIVE = $00000003;

  // Constants for enum SPINTERFERENCE
type
  SPINTERFERENCE = TOleEnum;
const
  SPINTERFERENCE_NONE                   = $00000000;
  SPINTERFERENCE_NOISE                  = $00000001;
  SPINTERFERENCE_NOSIGNAL               = $00000002;
  SPINTERFERENCE_TOOLOUD                = $00000003;
  SPINTERFERENCE_TOOQUIET               = $00000004;
  SPINTERFERENCE_TOOFAST                = $00000005;
  SPINTERFERENCE_TOOSLOW                = $00000006;
  SPINTERFERENCE_LATENCY_WARNING        = $00000007;
  SPINTERFERENCE_LATENCY_TRUNCATE_BEGIN = $00000008;
  SPINTERFERENCE_LATENCY_TRUNCATE_END   = $00000009;

  // Constants for enum SPAUDIOOPTIONS
type
  SPAUDIOOPTIONS = TOleEnum;
const
  SPAO_NONE         = $00000000;
  SPAO_RETAIN_AUDIO = $00000001;

  // Constants for enum SPBOOKMARKOPTIONS
type
  SPBOOKMARKOPTIONS = TOleEnum;
const
  SPBO_NONE       = $00000000;
  SPBO_PAUSE      = $00000001;
  SPBO_AHEAD      = $00000002;
  SPBO_TIME_UNITS = $00000004;

  // Constants for enum SPCONTEXTSTATE
type
  SPCONTEXTSTATE = TOleEnum;
const
  SPCS_DISABLED = $00000000;
  SPCS_ENABLED  = $00000001;

  // Constants for enum SPADAPTATIONRELEVANCE
type
  SPADAPTATIONRELEVANCE = TOleEnum;
const
  SPAR_Unknown = $00000000;
  SPAR_Low     = $00000001;
  SPAR_Medium  = $00000002;
  SPAR_High    = $00000003;

  // Constants for enum SPCATEGORYTYPE
type
  SPCATEGORYTYPE = TOleEnum;
const
  SPCT_COMMAND       = $00000000;
  SPCT_DICTATION     = $00000001;
  SPCT_SLEEP         = $00000002;
  SPCT_SUB_COMMAND   = $00000003;
  SPCT_SUB_DICTATION = $00000004;

// Constants for enum SPPARTOFSPEECH
type
  SPPARTOFSPEECH = TOleEnum;
const
  SPPS_NotOverriden = $FFFFFFFF;
  SPPS_Unknown      = $00000000;
  SPPS_Noun         = $00001000;
  SPPS_Verb         = $00002000;
  SPPS_Modifier     = $00003000;
  SPPS_Function     = $00004000;
  SPPS_Interjection = $00005000;
  SPPS_Noncontent   = $00006000;
  SPPS_LMA          = $00007000;
  SPPS_SuppressWord = $0000F000;

  // Constants for enum SPWORDTYPE
type
  SPWORDTYPE = TOleEnum;
const
  eWORDTYPE_ADDED   = $00000001;
  eWORDTYPE_DELETED = $00000002;

  // Constants for enum SPSHORTCUTTYPE
type
  SPSHORTCUTTYPE = TOleEnum;
const
  SPSHT_NotOverriden = $FFFFFFFF;
  SPSHT_Unknown      = $00000000;
  SPSHT_EMAIL        = $00001000;
  SPSHT_OTHER        = $00002000;
  SPPS_RESERVED1     = $00003000;
  SPPS_RESERVED2     = $00004000;
  SPPS_RESERVED3     = $00005000;
  SPPS_RESERVED4     = $0000F000;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ISpeechDataKey = interface;
  ISpeechDataKeyDisp = dispinterface;
  ISpeechObjectToken = interface;
  ISpeechObjectTokenDisp = dispinterface;
  ISpeechObjectTokenCategory = interface;
  ISpeechObjectTokenCategoryDisp = dispinterface;
  ISpeechObjectTokens = interface;
  ISpeechObjectTokensDisp = dispinterface;
  ISpeechAudioBufferInfo = interface;
  ISpeechAudioBufferInfoDisp = dispinterface;
  ISpeechAudioStatus = interface;
  ISpeechAudioStatusDisp = dispinterface;
  ISpeechAudioFormatDisp = dispinterface;
  ISpeechWaveFormatEx = interface;
  ISpeechWaveFormatExDisp = dispinterface;
  ISpeechBaseStream = interface;
  ISpeechAudio = interface;
  ISpeechAudioDisp = dispinterface;
  ISpeechVoice = interface;
  ISpeechVoiceDisp = dispinterface;
  ISpeechVoiceStatus = interface;
  ISpeechVoiceStatusDisp = dispinterface;
  _ISpeechVoiceEvents = dispinterface;

  ISpNotifySink = interface;
  ISpDataKey = interface;
  ISpObjectTokenCategory = interface;
  IEnumSpObjectTokens = interface;
  ISpObjectToken = interface;
  IServiceProvider = interface;
  IStream = interface;
  ISpStreamFormat = interface;
  ISpStreamFormatConverter = interface;
  ISpNotifySource = interface;
  ISpEventSource = interface;
  ISpEventSink = interface;
  ISpObjectWithToken = interface;
  ISpStream = interface;
  ISpVoice = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  SpObjectTokenCategory = ISpeechObjectTokenCategory;
  SpObjectToken = ISpeechObjectToken;
  SpStream = ISpStream;
  SpVoice = ISpeechVoice;
  SpWaveFormatEx = ISpeechWaveFormatEx;

// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  wireHWND = ^_RemotableHandle;
  PUserType10 = ^SPPHRASEPROPERTY; {*}
  PUserType16 = ^SPSHORTCUTPAIR; {*}
  POleVariant1 = ^OleVariant; {*}
  PPPrivateAlias1 = ^Pointer; {*}
  PByte1 = ^Byte; {*}
  PUINT1 = ^LongWord; {*}
  PUserType1 = ^TGUID; {*}
  PUserType2 = ^WAVEFORMATEX; {*}
  PUserType3 = ^SPEVENT; {*}
  PUserType4 = ^SPAUDIOBUFFERINFO; {*}
  PUserType5 = ^SPAUDIOOPTIONS; {*}
  PUserType6 = ^SPSERIALIZEDRESULT; {*}
  PUserType8 = ^SPSERIALIZEDPHRASE; {*}
  PUserType11 = ^SPBINARYGRAMMAR; {*}
  PWord1 = ^Word; {*}
  PUserType12 = ^SPTEXTSELECTIONINFO; {*}
  PUserType13 = ^SPPROPERTYINFO; {*}
  PUserType17 = ^SPRULE; {*}

  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;

  UINT_PTR = LongWord;
  LONG_PTR = Integer;

{$ALIGN 8}
  _LARGE_INTEGER = record
    QuadPart: Int64;
  end;

  _ULARGE_INTEGER = record
    QuadPart: Largeuint;
  end;

{$ALIGN 4}
  _FILETIME = record
    dwLowDateTime: LongWord;
    dwHighDateTime: LongWord;
  end;

{$ALIGN 8}
  tagSTATSTG = record
    pwcsName: PWideChar;
    type_: LongWord;
    cbSize: _ULARGE_INTEGER;
    mtime: _FILETIME;
    ctime: _FILETIME;
    atime: _FILETIME;
    grfMode: LongWord;
    grfLocksSupported: LongWord;
    clsid: TGUID;
    grfStateBits: LongWord;
    reserved: LongWord;
  end;

{$ALIGN 4}
  WAVEFORMATEX = record
    wFormatTag: Word;
    nChannels: Word;
    nSamplesPerSec: LongWord;
    nAvgBytesPerSec: LongWord;
    nBlockAlign: Word;
    wBitsPerSample: Word;
    cbSize: Word;
  end;

{$ALIGN 8}
  SPEVENT = record
    eEventId: Word;
    elParamType: Word;
    ulStreamNum: LongWord;
    ullAudioStreamOffset: Largeuint;
    wParam: UINT_PTR;
    lParam: LONG_PTR;
  end;

  SPEVENTSOURCEINFO = record
    ullEventInterest: Largeuint;
    ullQueuedInterest: Largeuint;
    ulCount: LongWord;
  end;

  SPAUDIOSTATE = _SPAUDIOSTATE;

  SPAUDIOSTATUS = record
    cbFreeBuffSpace: Integer;
    cbNonBlockingIO: LongWord;
    State: SPAUDIOSTATE;
    CurSeekPos: Largeuint;
    CurDevicePos: Largeuint;
    dwAudioLevel: LongWord;
    dwReserved2: LongWord;
  end;

{$ALIGN 4}
  SPAUDIOBUFFERINFO = record
    ulMsMinNotification: LongWord;
    ulMsBufferSize: LongWord;
    ulMsEventBias: LongWord;
  end;

  SPVOICESTATUS = record
    ulCurrentStream: LongWord;
    ulLastStreamQueued: LongWord;
    hrLastResult: HResult;
    dwRunningState: LongWord;
    ulInputWordPos: LongWord;
    ulInputWordLen: LongWord;
    ulInputSentPos: LongWord;
    ulInputSentLen: LongWord;
    lBookmarkId: Integer;
    PhonemeId: Word;
    VisemeId: SPVISEMES;
    dwReserved1: LongWord;
    dwReserved2: LongWord;
  end;

{$ALIGN 8}
  SPRECOGNIZERSTATUS = record
    AudioStatus: SPAUDIOSTATUS;
    ullRecognitionStreamPos: Largeuint;
    ulStreamNumber: LongWord;
    ulNumActive: LongWord;
    ClsidEngine: TGUID;
    cLangIDs: LongWord;
    aLangID: array[0..19] of Word;
    ullRecognitionStreamTime: Largeuint;
  end;

  SPSTREAMFORMATTYPE = SPWAVEFORMATTYPE;

{$ALIGN 2}
  __MIDL___MIDL_itf_sapi_0000_0020_0002 = record
    bType: Byte;
    bReserved: Byte;
    usArrayIndex: Word;
  end;

{$ALIGN 4}
  __MIDL___MIDL_itf_sapi_0000_0020_0001 = record
    case Integer of
      0: (ulId: LongWord);
      1: (__MIDL____MIDL_itf_sapi_0000_00200000: __MIDL___MIDL_itf_sapi_0000_0020_0002);
  end;


  SPPHRASEELEMENT = record
    ulAudioTimeOffset: LongWord;
    ulAudioSizeTime: LongWord;
    ulAudioStreamOffset: LongWord;
    ulAudioSizeBytes: LongWord;
    ulRetainedStreamOffset: LongWord;
    ulRetainedSizeBytes: LongWord;
    pszDisplayText: PWideChar;
    pszLexicalForm: PWideChar;
    pszPronunciation: ^Word;
    bDisplayAttributes: Byte;
    RequiredConfidence: Shortint;
    ActualConfidence: Shortint;
    reserved: Byte;
    SREngineConfidence: Single;
  end;

  SPPHRASEREPLACEMENT = record
    bDisplayAttributes: Byte;
    pszReplacementText: PWideChar;
    ulFirstElement: LongWord;
    ulCountOfElements: LongWord;
  end;

  SPSEMANTICERRORINFO = record
    ulLineNumber: LongWord;
    pszScriptLine: PWideChar;
    pszSource: PWideChar;
    pszDescription: PWideChar;
    hrResultCode: HResult;
  end;

  SPSERIALIZEDPHRASE = record
    ulSerializedSize: LongWord;
  end;

{$ALIGN 8}
  tagSPPROPERTYINFO = record
    pszName: PWideChar;
    ulId: LongWord;
    pszValue: PWideChar;
    vValue: OleVariant;
  end;

  SPPROPERTYINFO = tagSPPROPERTYINFO;

{$ALIGN 4}
  SPBINARYGRAMMAR = record
    ulTotalSerializedSize: LongWord;
  end;

  tagSPTEXTSELECTIONINFO = record
    ulStartActiveOffset: LongWord;
    cchActiveChars: LongWord;
    ulStartSelection: LongWord;
    cchSelection: LongWord;
  end;

  SPTEXTSELECTIONINFO = tagSPTEXTSELECTIONINFO;

  SPRECOCONTEXTSTATUS = record
    eInterference: SPINTERFERENCE;
    szRequestTypeOfUI: array[0..254] of Word;
    dwReserved1: LongWord;
    dwReserved2: LongWord;
  end;

  SPSERIALIZEDRESULT = record
    ulSerializedSize: LongWord;
  end;

{$ALIGN 8}
  SPRECORESULTTIMES = record
    ftStreamTime: _FILETIME;
    ullLength: Largeuint;
    dwTickCount: LongWord;
    ullStart: Largeuint;
  end;

{$ALIGN 4}
  SPSHORTCUTPAIR = record
    pNextSHORTCUTPAIR: PUserType16;
    LangId: Word;
    shType: SPSHORTCUTTYPE;
    pszDisplay: PWideChar;
    pszSpoken: PWideChar;
  end;

  SPRULE = record
    pszRuleName: PWideChar;
    ulRuleId: LongWord;
    dwAttributes: LongWord;
  end;

  ULONG_PTR = LongWord;

{$ALIGN 8}
  SPPHRASEPROPERTY = record
    pszName: PWideChar;
    __MIDL____MIDL_itf_sapi_0000_00200001: __MIDL___MIDL_itf_sapi_0000_0020_0001;
    pszValue: PWideChar;
    vValue: OleVariant;
    ulFirstElement: LongWord;
    ulCountOfElements: LongWord;
    pNextSibling: PUserType10;
    pFirstChild: PUserType10;
    SREngineConfidence: Single;
    Confidence: Shortint;
  end;

{$ALIGN 4}
  SPSHORTCUTPAIRLIST = record
    ulSize: LongWord;
    pvBuffer: ^Byte;
    pFirstShortcutPair: ^SPSHORTCUTPAIR;
  end;

// *********************************************************************//
// Interface: ISpeechDataKey
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CE17C09B-4EFA-44D5-A4C9-59D9585AB0CD}
// *********************************************************************//
  ISpeechDataKey = interface(IDispatch)
    ['{CE17C09B-4EFA-44D5-A4C9-59D9585AB0CD}']
    procedure SetBinaryValue(const ValueName: WideString; Value: OleVariant); safecall;
    function GetBinaryValue(const ValueName: WideString): OleVariant; safecall;
    procedure SetStringValue(const ValueName: WideString; const Value: WideString); safecall;
    function GetStringValue(const ValueName: WideString): WideString; safecall;
    procedure SetLongValue(const ValueName: WideString; Value: Integer); safecall;
    function GetLongValue(const ValueName: WideString): Integer; safecall;
    function OpenKey(const SubKeyName: WideString): ISpeechDataKey; safecall;
    function CreateKey(const SubKeyName: WideString): ISpeechDataKey; safecall;
    procedure DeleteKey(const SubKeyName: WideString); safecall;
    procedure DeleteValue(const ValueName: WideString); safecall;
    function EnumKeys(Index: Integer): WideString; safecall;
    function EnumValues(Index: Integer): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  ISpeechDataKeyDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CE17C09B-4EFA-44D5-A4C9-59D9585AB0CD}
// *********************************************************************//
  ISpeechDataKeyDisp = dispinterface
    ['{CE17C09B-4EFA-44D5-A4C9-59D9585AB0CD}']
    procedure SetBinaryValue(const ValueName: WideString; Value: OleVariant); dispid 1;
    function GetBinaryValue(const ValueName: WideString): OleVariant; dispid 2;
    procedure SetStringValue(const ValueName: WideString; const Value: WideString); dispid 3;
    function GetStringValue(const ValueName: WideString): WideString; dispid 4;
    procedure SetLongValue(const ValueName: WideString; Value: Integer); dispid 5;
    function GetLongValue(const ValueName: WideString): Integer; dispid 6;
    function OpenKey(const SubKeyName: WideString): ISpeechDataKey; dispid 7;
    function CreateKey(const SubKeyName: WideString): ISpeechDataKey; dispid 8;
    procedure DeleteKey(const SubKeyName: WideString); dispid 9;
    procedure DeleteValue(const ValueName: WideString); dispid 10;
    function EnumKeys(Index: Integer): WideString; dispid 11;
    function EnumValues(Index: Integer): WideString; dispid 12;
  end;

// *********************************************************************//
// Interface: ISpeechObjectToken
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C74A3ADC-B727-4500-A84A-B526721C8B8C}
// *********************************************************************//
  ISpeechObjectToken = interface(IDispatch)
    ['{C74A3ADC-B727-4500-A84A-B526721C8B8C}']
    function Get_Id: WideString; safecall;
    function Get_DataKey: ISpeechDataKey; safecall;
    function Get_Category: ISpeechObjectTokenCategory; safecall;
    function GetDescription(Locale: Integer): WideString; safecall;
    procedure SetId(const Id: WideString; const CategoryID: WideString; CreateIfNotExist: WordBool); safecall;
    function GetAttribute(const AttributeName: WideString): WideString; safecall;
    function CreateInstance(const pUnkOuter: IUnknown; ClsContext: SpeechTokenContext): IUnknown; safecall;
    procedure Remove(const ObjectStorageCLSID: WideString); safecall;
    function GetStorageFileName(const ObjectStorageCLSID: WideString; const KeyName: WideString; const FileName: WideString; Folder: SpeechTokenShellFolder): WideString; safecall;
    procedure RemoveStorageFileName(const ObjectStorageCLSID: WideString; const KeyName: WideString; DeleteFile: WordBool); safecall;
    function IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant; const Object_: IUnknown): WordBool; safecall;
    procedure DisplayUI(hWnd: Integer; const Title: WideString; const TypeOfUI: WideString; const ExtraData: OleVariant; const Object_: IUnknown); safecall;
    function MatchesAttributes(const Attributes: WideString): WordBool; safecall;
    property Id: WideString read Get_Id;
    property DataKey: ISpeechDataKey read Get_DataKey;
    property Category: ISpeechObjectTokenCategory read Get_Category;
  end;

// *********************************************************************//
// DispIntf:  ISpeechObjectTokenDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C74A3ADC-B727-4500-A84A-B526721C8B8C}
// *********************************************************************//
  ISpeechObjectTokenDisp = dispinterface
    ['{C74A3ADC-B727-4500-A84A-B526721C8B8C}']
    property Id: WideString readonly dispid 1;
    property DataKey: ISpeechDataKey readonly dispid 2;
    property Category: ISpeechObjectTokenCategory readonly dispid 3;
    function GetDescription(Locale: Integer): WideString; dispid 4;
    procedure SetId(const Id: WideString; const CategoryID: WideString; CreateIfNotExist: WordBool); dispid 5;
    function GetAttribute(const AttributeName: WideString): WideString; dispid 6;
    function CreateInstance(const pUnkOuter: IUnknown; ClsContext: SpeechTokenContext): IUnknown; dispid 7;
    procedure Remove(const ObjectStorageCLSID: WideString); dispid 8;
    function GetStorageFileName(const ObjectStorageCLSID: WideString; const KeyName: WideString; const FileName: WideString; Folder: SpeechTokenShellFolder): WideString; dispid 9;
    procedure RemoveStorageFileName(const ObjectStorageCLSID: WideString; const KeyName: WideString; DeleteFile: WordBool); dispid 10;
    function IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant; const Object_: IUnknown): WordBool; dispid 11;
    procedure DisplayUI(hWnd: Integer; const Title: WideString; const TypeOfUI: WideString; const ExtraData: OleVariant; const Object_: IUnknown); dispid 12;
    function MatchesAttributes(const Attributes: WideString): WordBool; dispid 13;
  end;

// *********************************************************************//
// Interface: ISpeechObjectTokenCategory
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CA7EAC50-2D01-4145-86D4-5AE7D70F4469}
// *********************************************************************//
  ISpeechObjectTokenCategory = interface(IDispatch)
    ['{CA7EAC50-2D01-4145-86D4-5AE7D70F4469}']
    function Get_Id: WideString; safecall;
    procedure Set_Default(const TokenId: WideString); safecall;
    function Get_Default: WideString; safecall;
    procedure SetId(const Id: WideString; CreateIfNotExist: WordBool); safecall;
    function GetDataKey(Location: SpeechDataKeyLocation): ISpeechDataKey; safecall;
    function EnumerateTokens(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens; safecall;
    property Id: WideString read Get_Id;
    property Default: WideString read Get_Default write Set_Default;
  end;

// *********************************************************************//
// DispIntf:  ISpeechObjectTokenCategoryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CA7EAC50-2D01-4145-86D4-5AE7D70F4469}
// *********************************************************************//
  ISpeechObjectTokenCategoryDisp = dispinterface
    ['{CA7EAC50-2D01-4145-86D4-5AE7D70F4469}']
    property Id: WideString readonly dispid 1;
    property Default: WideString dispid 2;
    procedure SetId(const Id: WideString; CreateIfNotExist: WordBool); dispid 3;
    function GetDataKey(Location: SpeechDataKeyLocation): ISpeechDataKey; dispid 4;
    function EnumerateTokens(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens; dispid 5;
  end;

// *********************************************************************//
// Interface: ISpeechObjectTokens
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9285B776-2E7B-4BC0-B53E-580EB6FA967F}
// *********************************************************************//
  ISpeechObjectTokens = interface(IDispatch)
    ['{9285B776-2E7B-4BC0-B53E-580EB6FA967F}']
    function Get_Count: Integer; safecall;
    function Item(Index: Integer): ISpeechObjectToken; safecall;
    function Get__NewEnum: IUnknown; safecall;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  ISpeechObjectTokensDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9285B776-2E7B-4BC0-B53E-580EB6FA967F}
// *********************************************************************//
  ISpeechObjectTokensDisp = dispinterface
    ['{9285B776-2E7B-4BC0-B53E-580EB6FA967F}']
    property Count: Integer readonly dispid 1;
    function Item(Index: Integer): ISpeechObjectToken; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: ISpeechAudioBufferInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {11B103D8-1142-4EDF-A093-82FB3915F8CC}
// *********************************************************************//
  ISpeechAudioBufferInfo = interface(IDispatch)
    ['{11B103D8-1142-4EDF-A093-82FB3915F8CC}']
    function Get_MinNotification: Integer; safecall;
    procedure Set_MinNotification(MinNotification: Integer); safecall;
    function Get_BufferSize: Integer; safecall;
    procedure Set_BufferSize(BufferSize: Integer); safecall;
    function Get_EventBias: Integer; safecall;
    procedure Set_EventBias(EventBias: Integer); safecall;
    property MinNotification: Integer read Get_MinNotification write Set_MinNotification;
    property BufferSize: Integer read Get_BufferSize write Set_BufferSize;
    property EventBias: Integer read Get_EventBias write Set_EventBias;
  end;

// *********************************************************************//
// DispIntf:  ISpeechAudioBufferInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {11B103D8-1142-4EDF-A093-82FB3915F8CC}
// *********************************************************************//
  ISpeechAudioBufferInfoDisp = dispinterface
    ['{11B103D8-1142-4EDF-A093-82FB3915F8CC}']
    property MinNotification: Integer dispid 1;
    property BufferSize: Integer dispid 2;
    property EventBias: Integer dispid 3;
  end;

// *********************************************************************//
// Interface: ISpeechAudioStatus
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C62D9C91-7458-47F6-862D-1EF86FB0B278}
// *********************************************************************//
  ISpeechAudioStatus = interface(IDispatch)
    ['{C62D9C91-7458-47F6-862D-1EF86FB0B278}']
    function Get_FreeBufferSpace: Integer; safecall;
    function Get_NonBlockingIO: Integer; safecall;
    function Get_State: SpeechAudioState; safecall;
    function Get_CurrentSeekPosition: OleVariant; safecall;
    function Get_CurrentDevicePosition: OleVariant; safecall;
    property FreeBufferSpace: Integer read Get_FreeBufferSpace;
    property NonBlockingIO: Integer read Get_NonBlockingIO;
    property State: SpeechAudioState read Get_State;
    property CurrentSeekPosition: OleVariant read Get_CurrentSeekPosition;
    property CurrentDevicePosition: OleVariant read Get_CurrentDevicePosition;
  end;

// *********************************************************************//
// DispIntf:  ISpeechAudioStatusDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C62D9C91-7458-47F6-862D-1EF86FB0B278}
// *********************************************************************//
  ISpeechAudioStatusDisp = dispinterface
    ['{C62D9C91-7458-47F6-862D-1EF86FB0B278}']
    property FreeBufferSpace: Integer readonly dispid 1;
    property NonBlockingIO: Integer readonly dispid 2;
    property State: SpeechAudioState readonly dispid 3;
    property CurrentSeekPosition: OleVariant readonly dispid 4;
    property CurrentDevicePosition: OleVariant readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ISpeechAudioFormat
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E6E9C590-3E18-40E3-8299-061F98BDE7C7}
// *********************************************************************//
  ISpeechAudioFormat = interface(IDispatch)
    ['{E6E9C590-3E18-40E3-8299-061F98BDE7C7}']
    function Get_type_: SpeechAudioFormatType; safecall;
    procedure Set_type_(AudioFormat: SpeechAudioFormatType); safecall;
    function Get_Guid: WideString; safecall;
    procedure Set_Guid(const Guid: WideString); safecall;
    function GetWaveFormatEx: ISpeechWaveFormatEx; safecall;
    procedure SetWaveFormatEx(const SpeechWaveFormatEx: ISpeechWaveFormatEx); safecall;
    property type_: SpeechAudioFormatType read Get_type_ write Set_type_;
    property Guid: WideString read Get_Guid write Set_Guid;
  end;

// *********************************************************************//
// DispIntf:  ISpeechAudioFormatDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E6E9C590-3E18-40E3-8299-061F98BDE7C7}
// *********************************************************************//
  ISpeechAudioFormatDisp = dispinterface
    ['{E6E9C590-3E18-40E3-8299-061F98BDE7C7}']
    property type_: SpeechAudioFormatType dispid 1;
    property Guid: WideString dispid 2;
    function GetWaveFormatEx: ISpeechWaveFormatEx; dispid 3;
    procedure SetWaveFormatEx(const SpeechWaveFormatEx: ISpeechWaveFormatEx); dispid 4;
  end;

// *********************************************************************//
// Interface: ISpeechWaveFormatEx
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7A1EF0D5-1581-4741-88E4-209A49F11A10}
// *********************************************************************//
  ISpeechWaveFormatEx = interface(IDispatch)
    ['{7A1EF0D5-1581-4741-88E4-209A49F11A10}']
    function Get_FormatTag: Smallint; safecall;
    procedure Set_FormatTag(FormatTag: Smallint); safecall;
    function Get_Channels: Smallint; safecall;
    procedure Set_Channels(Channels: Smallint); safecall;
    function Get_SamplesPerSec: Integer; safecall;
    procedure Set_SamplesPerSec(SamplesPerSec: Integer); safecall;
    function Get_AvgBytesPerSec: Integer; safecall;
    procedure Set_AvgBytesPerSec(AvgBytesPerSec: Integer); safecall;
    function Get_BlockAlign: Smallint; safecall;
    procedure Set_BlockAlign(BlockAlign: Smallint); safecall;
    function Get_BitsPerSample: Smallint; safecall;
    procedure Set_BitsPerSample(BitsPerSample: Smallint); safecall;
    function Get_ExtraData: OleVariant; safecall;
    procedure Set_ExtraData(ExtraData: OleVariant); safecall;
    property FormatTag: Smallint read Get_FormatTag write Set_FormatTag;
    property Channels: Smallint read Get_Channels write Set_Channels;
    property SamplesPerSec: Integer read Get_SamplesPerSec write Set_SamplesPerSec;
    property AvgBytesPerSec: Integer read Get_AvgBytesPerSec write Set_AvgBytesPerSec;
    property BlockAlign: Smallint read Get_BlockAlign write Set_BlockAlign;
    property BitsPerSample: Smallint read Get_BitsPerSample write Set_BitsPerSample;
    property ExtraData: OleVariant read Get_ExtraData write Set_ExtraData;
  end;

// *********************************************************************//
// DispIntf:  ISpeechWaveFormatExDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7A1EF0D5-1581-4741-88E4-209A49F11A10}
// *********************************************************************//
  ISpeechWaveFormatExDisp = dispinterface
    ['{7A1EF0D5-1581-4741-88E4-209A49F11A10}']
    property FormatTag: Smallint dispid 1;
    property Channels: Smallint dispid 2;
    property SamplesPerSec: Integer dispid 3;
    property AvgBytesPerSec: Integer dispid 4;
    property BlockAlign: Smallint dispid 5;
    property BitsPerSample: Smallint dispid 6;
    property ExtraData: OleVariant dispid 7;
  end;

// *********************************************************************//
// Interface: ISpeechBaseStream
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6450336F-7D49-4CED-8097-49D6DEE37294}
// *********************************************************************//
  ISpeechBaseStream = interface(IDispatch)
    ['{6450336F-7D49-4CED-8097-49D6DEE37294}']
    function Get_Format: ISpeechAudioFormat; safecall;
    procedure _Set_Format(const AudioFormat: ISpeechAudioFormat); safecall;
    function Read(out Buffer: OleVariant; NumberOfBytes: Integer): Integer; safecall;
    function Write(Buffer: OleVariant): Integer; safecall;
    function Seek(Position: OleVariant; Origin: SpeechStreamSeekPositionType): OleVariant; safecall;
    property Format: ISpeechAudioFormat read Get_Format write _Set_Format;
  end;

// *********************************************************************//
// Interface: ISpeechAudio
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CFF8E175-019E-11D3-A08E-00C04F8EF9B5}
// *********************************************************************//
  ISpeechAudio = interface(ISpeechBaseStream)
    ['{CFF8E175-019E-11D3-A08E-00C04F8EF9B5}']
    function Get_Status: ISpeechAudioStatus; safecall;
    function Get_BufferInfo: ISpeechAudioBufferInfo; safecall;
    function Get_DefaultFormat: ISpeechAudioFormat; safecall;
    function Get_Volume: Integer; safecall;
    procedure Set_Volume(Volume: Integer); safecall;
    function Get_BufferNotifySize: Integer; safecall;
    procedure Set_BufferNotifySize(BufferNotifySize: Integer); safecall;
    function Get_EventHandle: Integer; safecall;
    procedure SetState(State: SpeechAudioState); safecall;
    property Status: ISpeechAudioStatus read Get_Status;
    property BufferInfo: ISpeechAudioBufferInfo read Get_BufferInfo;
    property DefaultFormat: ISpeechAudioFormat read Get_DefaultFormat;
    property Volume: Integer read Get_Volume write Set_Volume;
    property BufferNotifySize: Integer read Get_BufferNotifySize write Set_BufferNotifySize;
    property EventHandle: Integer read Get_EventHandle;
  end;

// *********************************************************************//
// DispIntf:  ISpeechAudioDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CFF8E175-019E-11D3-A08E-00C04F8EF9B5}
// *********************************************************************//
  ISpeechAudioDisp = dispinterface
    ['{CFF8E175-019E-11D3-A08E-00C04F8EF9B5}']
    property Status: ISpeechAudioStatus readonly dispid 200;
    property BufferInfo: ISpeechAudioBufferInfo readonly dispid 201;
    property DefaultFormat: ISpeechAudioFormat readonly dispid 202;
    property Volume: Integer dispid 203;
    property BufferNotifySize: Integer dispid 204;
    property EventHandle: Integer readonly dispid 205;
    procedure SetState(State: SpeechAudioState); dispid 206;
    property Format: ISpeechAudioFormat dispid 1;
    function Read(out Buffer: OleVariant; NumberOfBytes: Integer): Integer; dispid 2;
    function Write(Buffer: OleVariant): Integer; dispid 3;
    function Seek(Position: OleVariant; Origin: SpeechStreamSeekPositionType): OleVariant; dispid 4;
  end;

// *********************************************************************//
// Interface: ISpeechVoice
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {269316D8-57BD-11D2-9EEE-00C04F797396}
// *********************************************************************//
  ISpeechVoice = interface(IDispatch)
    ['{269316D8-57BD-11D2-9EEE-00C04F797396}']
    function Get_Status: ISpeechVoiceStatus; safecall;
    function Get_Voice: ISpeechObjectToken; safecall;
    procedure _Set_Voice(const Voice: ISpeechObjectToken); safecall;
    function Get_AudioOutput: ISpeechObjectToken; safecall;
    procedure _Set_AudioOutput(const AudioOutput: ISpeechObjectToken); safecall;
    function Get_AudioOutputStream: ISpeechBaseStream; safecall;
    procedure _Set_AudioOutputStream(const AudioOutputStream: ISpeechBaseStream); safecall;
    function Get_Rate: Integer; safecall;
    procedure Set_Rate(Rate: Integer); safecall;
    function Get_Volume: Integer; safecall;
    procedure Set_Volume(Volume: Integer); safecall;
    procedure Set_AllowAudioOutputFormatChangesOnNextSet(Allow: WordBool); safecall;
    function Get_AllowAudioOutputFormatChangesOnNextSet: WordBool; safecall;
    function Get_EventInterests: SpeechVoiceEvents; safecall;
    procedure Set_EventInterests(EventInterestFlags: SpeechVoiceEvents); safecall;
    procedure Set_Priority(Priority: SpeechVoicePriority); safecall;
    function Get_Priority: SpeechVoicePriority; safecall;
    procedure Set_AlertBoundary(Boundary: SpeechVoiceEvents); safecall;
    function Get_AlertBoundary: SpeechVoiceEvents; safecall;
    procedure Set_SynchronousSpeakTimeout(msTimeout: Integer); safecall;
    function Get_SynchronousSpeakTimeout: Integer; safecall;
    function Speak(const Text: WideString; Flags: SpeechVoiceSpeakFlags): Integer; safecall;
    function SpeakStream(const Stream: ISpeechBaseStream; Flags: SpeechVoiceSpeakFlags): Integer; safecall;
    procedure Pause; safecall;
    procedure Resume; safecall;
    function Skip(const Type_: WideString; NumItems: Integer): Integer; safecall;
    function GetVoices(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens; safecall;
    function GetAudioOutputs(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens; safecall;
    function WaitUntilDone(msTimeout: Integer): WordBool; safecall;
    function SpeakCompleteEvent: Integer; safecall;
    function IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant): WordBool; safecall;
    procedure DisplayUI(hWndParent: Integer; const Title: WideString; const TypeOfUI: WideString; const ExtraData: OleVariant); safecall;
    property Status: ISpeechVoiceStatus read Get_Status;
    property Voice: ISpeechObjectToken read Get_Voice write _Set_Voice;
    property AudioOutput: ISpeechObjectToken read Get_AudioOutput write _Set_AudioOutput;
    property AudioOutputStream: ISpeechBaseStream read Get_AudioOutputStream write _Set_AudioOutputStream;
    property Rate: Integer read Get_Rate write Set_Rate;
    property Volume: Integer read Get_Volume write Set_Volume;
    property AllowAudioOutputFormatChangesOnNextSet: WordBool read Get_AllowAudioOutputFormatChangesOnNextSet write Set_AllowAudioOutputFormatChangesOnNextSet;
    property EventInterests: SpeechVoiceEvents read Get_EventInterests write Set_EventInterests;
    property Priority: SpeechVoicePriority read Get_Priority write Set_Priority;
    property AlertBoundary: SpeechVoiceEvents read Get_AlertBoundary write Set_AlertBoundary;
    property SynchronousSpeakTimeout: Integer read Get_SynchronousSpeakTimeout write Set_SynchronousSpeakTimeout;
  end;

// *********************************************************************//
// DispIntf:  ISpeechVoiceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {269316D8-57BD-11D2-9EEE-00C04F797396}
// *********************************************************************//
  ISpeechVoiceDisp = dispinterface
    ['{269316D8-57BD-11D2-9EEE-00C04F797396}']
    property Status: ISpeechVoiceStatus readonly dispid 1;
    property Voice: ISpeechObjectToken dispid 2;
    property AudioOutput: ISpeechObjectToken dispid 3;
    property AudioOutputStream: ISpeechBaseStream dispid 4;
    property Rate: Integer dispid 5;
    property Volume: Integer dispid 6;
    property AllowAudioOutputFormatChangesOnNextSet: WordBool dispid 7;
    property EventInterests: SpeechVoiceEvents dispid 8;
    property Priority: SpeechVoicePriority dispid 9;
    property AlertBoundary: SpeechVoiceEvents dispid 10;
    property SynchronousSpeakTimeout: Integer dispid 11;
    function Speak(const Text: WideString; Flags: SpeechVoiceSpeakFlags): Integer; dispid 12;
    function SpeakStream(const Stream: ISpeechBaseStream; Flags: SpeechVoiceSpeakFlags): Integer; dispid 13;
    procedure Pause; dispid 14;
    procedure Resume; dispid 15;
    function Skip(const Type_: WideString; NumItems: Integer): Integer; dispid 16;
    function GetVoices(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens; dispid 17;
    function GetAudioOutputs(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens; dispid 18;
    function WaitUntilDone(msTimeout: Integer): WordBool; dispid 19;
    function SpeakCompleteEvent: Integer; dispid 20;
    function IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant): WordBool; dispid 21;
    procedure DisplayUI(hWndParent: Integer; const Title: WideString; const TypeOfUI: WideString; const ExtraData: OleVariant); dispid 22;
  end;

// *********************************************************************//
// Interface: ISpeechVoiceStatus
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8BE47B07-57F6-11D2-9EEE-00C04F797396}
// *********************************************************************//
  ISpeechVoiceStatus = interface(IDispatch)
    ['{8BE47B07-57F6-11D2-9EEE-00C04F797396}']
    function Get_CurrentStreamNumber: Integer; safecall;
    function Get_LastStreamNumberQueued: Integer; safecall;
    function Get_LastHResult: Integer; safecall;
    function Get_RunningState: SpeechRunState; safecall;
    function Get_InputWordPosition: Integer; safecall;
    function Get_InputWordLength: Integer; safecall;
    function Get_InputSentencePosition: Integer; safecall;
    function Get_InputSentenceLength: Integer; safecall;
    function Get_LastBookmark: WideString; safecall;
    function Get_LastBookmarkId: Integer; safecall;
    function Get_PhonemeId: Smallint; safecall;
    function Get_VisemeId: Smallint; safecall;
    property CurrentStreamNumber: Integer read Get_CurrentStreamNumber;
    property LastStreamNumberQueued: Integer read Get_LastStreamNumberQueued;
    property LastHResult: Integer read Get_LastHResult;
    property RunningState: SpeechRunState read Get_RunningState;
    property InputWordPosition: Integer read Get_InputWordPosition;
    property InputWordLength: Integer read Get_InputWordLength;
    property InputSentencePosition: Integer read Get_InputSentencePosition;
    property InputSentenceLength: Integer read Get_InputSentenceLength;
    property LastBookmark: WideString read Get_LastBookmark;
    property LastBookmarkId: Integer read Get_LastBookmarkId;
    property PhonemeId: Smallint read Get_PhonemeId;
    property VisemeId: Smallint read Get_VisemeId;
  end;

// *********************************************************************//
// DispIntf:  ISpeechVoiceStatusDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8BE47B07-57F6-11D2-9EEE-00C04F797396}
// *********************************************************************//
  ISpeechVoiceStatusDisp = dispinterface
    ['{8BE47B07-57F6-11D2-9EEE-00C04F797396}']
    property CurrentStreamNumber: Integer readonly dispid 1;
    property LastStreamNumberQueued: Integer readonly dispid 2;
    property LastHResult: Integer readonly dispid 3;
    property RunningState: SpeechRunState readonly dispid 4;
    property InputWordPosition: Integer readonly dispid 5;
    property InputWordLength: Integer readonly dispid 6;
    property InputSentencePosition: Integer readonly dispid 7;
    property InputSentenceLength: Integer readonly dispid 8;
    property LastBookmark: WideString readonly dispid 9;
    property LastBookmarkId: Integer readonly dispid 10;
    property PhonemeId: Smallint readonly dispid 11;
    property VisemeId: Smallint readonly dispid 12;
  end;

// *********************************************************************//
// DispIntf:  _ISpeechVoiceEvents
// Flags:     (4096) Dispatchable
// GUID:      {A372ACD1-3BEF-4BBD-8FFB-CB3E2B416AF8}
// *********************************************************************//
  _ISpeechVoiceEvents = dispinterface
    ['{A372ACD1-3BEF-4BBD-8FFB-CB3E2B416AF8}']
    procedure StartStream(StreamNumber: Integer; StreamPosition: OleVariant); dispid 1;
    procedure EndStream(StreamNumber: Integer; StreamPosition: OleVariant); dispid 2;
    procedure VoiceChange(StreamNumber: Integer; StreamPosition: OleVariant; const VoiceObjectToken: ISpeechObjectToken); dispid 3;
    procedure Bookmark(StreamNumber: Integer; StreamPosition: OleVariant; const Bookmark: WideString; BookmarkId: Integer); dispid 4;
    procedure Word(StreamNumber: Integer; StreamPosition: OleVariant; CharacterPosition: Integer; Length: Integer); dispid 5;
    procedure Sentence(StreamNumber: Integer; StreamPosition: OleVariant; CharacterPosition: Integer; Length: Integer); dispid 7;
    procedure Phoneme(StreamNumber: Integer; StreamPosition: OleVariant; Duration: Integer; NextPhoneId: Smallint; Feature: SpeechVisemeFeature; CurrentPhoneId: Smallint); dispid 6;
    procedure Viseme(StreamNumber: Integer; StreamPosition: OleVariant; Duration: Integer; NextVisemeId: SpeechVisemeType; Feature: SpeechVisemeFeature;  CurrentVisemeId: SpeechVisemeType); dispid 8;
    procedure AudioLevel(StreamNumber: Integer; StreamPosition: OleVariant; AudioLevel: Integer); dispid 9;
    procedure EnginePrivate(StreamNumber: Integer; StreamPosition: Integer; EngineData: OleVariant); dispid 10;
  end;

// *********************************************************************//
// Interface: ISpNotifySink
// Flags:     (512) Restricted
// GUID:      {259684DC-37C3-11D2-9603-00C04F8EE628}
// *********************************************************************//
  ISpNotifySink = interface(IUnknown)
    ['{259684DC-37C3-11D2-9603-00C04F8EE628}']
    function Notify: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpDataKey
// Flags:     (512) Restricted
// GUID:      {14056581-E16C-11D2-BB90-00C04F8EE6C0}
// *********************************************************************//
  ISpDataKey = interface(IUnknown)
    ['{14056581-E16C-11D2-BB90-00C04F8EE6C0}']
    function SetData(pszValueName: PWideChar; cbData: LongWord; var pData: Byte): HResult; stdcall;
    function GetData(pszValueName: PWideChar; var pcbData: LongWord; out pData: Byte): HResult; stdcall;
    function SetStringValue(pszValueName: PWideChar; pszValue: PWideChar): HResult; stdcall;
    function GetStringValue(pszValueName: PWideChar; out ppszValue: PWideChar): HResult; stdcall;
    function SetDWORD(pszValueName: PWideChar; dwValue: LongWord): HResult; stdcall;
    function GetDWORD(pszValueName: PWideChar; out pdwValue: LongWord): HResult; stdcall;
    function OpenKey(pszSubKeyName: PWideChar; out ppSubKey: ISpDataKey): HResult; stdcall;
    function CreateKey(pszSubKey: PWideChar; out ppSubKey: ISpDataKey): HResult; stdcall;
    function DeleteKey(pszSubKey: PWideChar): HResult; stdcall;
    function DeleteValue(pszValueName: PWideChar): HResult; stdcall;
    function EnumKeys(Index: LongWord; out ppszSubKeyName: PWideChar): HResult; stdcall;
    function EnumValues(Index: LongWord; out ppszValueName: PWideChar): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpObjectTokenCategory
// Flags:     (512) Restricted
// GUID:      {2D3D3845-39AF-4850-BBF9-40B49780011D}
// *********************************************************************//
  ISpObjectTokenCategory = interface(ISpDataKey)
    ['{2D3D3845-39AF-4850-BBF9-40B49780011D}']
    function SetId(pszCategoryId: PWideChar; fCreateIfNotExist: Integer): HResult; stdcall;
    function GetId(out ppszCoMemCategoryId: PWideChar): HResult; stdcall;
    function GetDataKey(spdkl: SPDATAKEYLOCATION; out ppDataKey: ISpDataKey): HResult; stdcall;
    function EnumTokens(pzsReqAttribs: PWideChar; pszOptAttribs: PWideChar; out ppEnum: IEnumSpObjectTokens): HResult; stdcall;
    function SetDefaultTokenId(pszTokenId: PWideChar): HResult; stdcall;
    function GetDefaultTokenId(out ppszCoMemTokenId: PWideChar): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumSpObjectTokens
// Flags:     (512) Restricted
// GUID:      {06B64F9E-7FDA-11D2-B4F2-00C04F797396}
// *********************************************************************//
  IEnumSpObjectTokens = interface(IUnknown)
    ['{06B64F9E-7FDA-11D2-B4F2-00C04F797396}']
    function Next(celt: LongWord; out pelt: ISpObjectToken; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppEnum: IEnumSpObjectTokens): HResult; stdcall;
    function Item(Index: LongWord; out ppToken: ISpObjectToken): HResult; stdcall;
    function GetCount(out pCount: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpObjectToken
// Flags:     (512) Restricted
// GUID:      {14056589-E16C-11D2-BB90-00C04F8EE6C0}
// *********************************************************************//
  ISpObjectToken = interface(ISpDataKey)
    ['{14056589-E16C-11D2-BB90-00C04F8EE6C0}']
    function SetId(pszCategoryId: PWideChar; pszTokenId: PWideChar; fCreateIfNotExist: Integer): HResult; stdcall;
    function GetId(out ppszCoMemTokenId: PWideChar): HResult; stdcall;
    function GetCategory(out ppTokenCategory: ISpObjectTokenCategory): HResult; stdcall;
    function CreateInstance(const pUnkOuter: IUnknown; dwClsContext: LongWord; var riid: TGUID; out ppvObject: Pointer): HResult; stdcall;
    function GetStorageFileName(var clsidCaller: TGUID; pszValueName: PWideChar; pszFileNameSpecifier: PWideChar; nFolder: LongWord; out ppszFilePath: PWideChar): HResult; stdcall;
    function RemoveStorageFileName(var clsidCaller: TGUID; pszKeyName: PWideChar; fDeleteFile: Integer): HResult; stdcall;
    function Remove(var pclsidCaller: TGUID): HResult; stdcall;
    function IsUISupported(pszTypeOfUI: PWideChar; pvExtraData: Pointer; cbExtraData: LongWord; const punkObject: IUnknown; out pfSupported: Integer): HResult; stdcall;
    function DisplayUI(var hWndParent: _RemotableHandle; pszTitle: PWideChar; pszTypeOfUI: PWideChar; pvExtraData: Pointer; cbExtraData: LongWord;  const punkObject: IUnknown): HResult; stdcall;
    function MatchesAttributes(pszAttributes: PWideChar; out pfMatches: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IServiceProvider
// Flags:     (0)
// GUID:      {6D5140C1-7436-11CE-8034-00AA006009FA}
// *********************************************************************//
  IServiceProvider = interface(IUnknown)
    ['{6D5140C1-7436-11CE-8034-00AA006009FA}']
    function RemoteQueryService(var guidService: TGUID; var riid: TGUID; out ppvObject: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpResourceManager
// Flags:     (512) Restricted
// GUID:      {93384E18-5014-43D5-ADBB-A78E055926BD}
// *********************************************************************//
  ISpResourceManager = interface(IServiceProvider)
    ['{93384E18-5014-43D5-ADBB-A78E055926BD}']
    function SetObject(var guidServiceId: TGUID; const punkObject: IUnknown): HResult; stdcall;
    function GetObject(var guidServiceId: TGUID; var ObjectCLSID: TGUID; var ObjectIID: TGUID; fReleaseWhenLastExternalRefReleased: Integer; out ppObject: Pointer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISequentialStream
// Flags:     (0)
// GUID:      {0C733A30-2A1C-11CE-ADE5-00AA0044773D}
// *********************************************************************//
  ISequentialStream = interface(IUnknown)
    ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    function RemoteRead(out pv: Byte; cb: LongWord; out pcbRead: LongWord): HResult; stdcall;
    function RemoteWrite(var pv: Byte; cb: LongWord; out pcbWritten: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStream
// Flags:     (0)
// GUID:      {0000000C-0000-0000-C000-000000000046}
// *********************************************************************//
  IStream = interface(ISequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function RemoteSeek(dlibMove: _LARGE_INTEGER; dwOrigin: LongWord; out plibNewPosition: _ULARGE_INTEGER): HResult; stdcall;
    function SetSize(libNewSize: _ULARGE_INTEGER): HResult; stdcall;
    function RemoteCopyTo(const pstm: IStream; cb: _ULARGE_INTEGER; out pcbRead: _ULARGE_INTEGER; out pcbWritten: _ULARGE_INTEGER): HResult; stdcall;
    function Commit(grfCommitFlags: LongWord): HResult; stdcall;
    function Revert: HResult; stdcall;
    function LockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function UnlockRegion(libOffset: _ULARGE_INTEGER; cb: _ULARGE_INTEGER; dwLockType: LongWord): HResult; stdcall;
    function Stat(out pstatstg: tagSTATSTG; grfStatFlag: LongWord): HResult; stdcall;
    function Clone(out ppstm: IStream): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpStreamFormat
// Flags:     (512) Restricted
// GUID:      {BED530BE-2606-4F4D-A1C0-54C5CDA5566F}
// *********************************************************************//
  ISpStreamFormat = interface(IStream)
    ['{BED530BE-2606-4F4D-A1C0-54C5CDA5566F}']
    function GetFormat(var pguidFormatId: TGUID; out ppCoMemWaveFormatEx: PUserType2): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpStreamFormatConverter
// Flags:     (512) Restricted
// GUID:      {678A932C-EA71-4446-9B41-78FDA6280A29}
// *********************************************************************//
  ISpStreamFormatConverter = interface(ISpStreamFormat)
    ['{678A932C-EA71-4446-9B41-78FDA6280A29}']
    function SetBaseStream(const pStream: ISpStreamFormat; fSetFormatToBaseStreamFormat: Integer; fWriteToBaseStream: Integer): HResult; stdcall;
    function GetBaseStream(out ppStream: ISpStreamFormat): HResult; stdcall;
    function SetFormat(var rguidFormatIdOfConvertedStream: TGUID; var pWaveFormatExOfConvertedStream: WAVEFORMATEX): HResult; stdcall;
    function ResetSeekPosition: HResult; stdcall;
    function ScaleConvertedToBaseOffset(ullOffsetConvertedStream: Largeuint; out pullOffsetBaseStream: Largeuint): HResult; stdcall;
    function ScaleBaseToConvertedOffset(ullOffsetBaseStream: Largeuint; out pullOffsetConvertedStream: Largeuint): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpNotifySource
// Flags:     (512) Restricted
// GUID:      {5EFF4AEF-8487-11D2-961C-00C04F8EE628}
// *********************************************************************//
  ISpNotifySource = interface(IUnknown)
    ['{5EFF4AEF-8487-11D2-961C-00C04F8EE628}']
    function SetNotifySink(const pNotifySink: ISpNotifySink): HResult; stdcall;
    function SetNotifyWindowMessage(var hWnd: _RemotableHandle; Msg: SYSUINT; wParam: UINT_PTR; lParam: LONG_PTR): HResult; stdcall;
    function SetNotifyCallbackFunction(pfnCallback: PPPrivateAlias1; wParam: UINT_PTR; lParam: LONG_PTR): HResult; stdcall;
    function SetNotifyCallbackInterface(pSpCallback: PPPrivateAlias1; wParam: UINT_PTR; lParam: LONG_PTR): HResult; stdcall;
    function SetNotifyWin32Event: HResult; stdcall;
    function WaitForNotifyEvent(dwMilliseconds: LongWord): HResult; stdcall;
    function GetNotifyEventHandle: Pointer; stdcall;
  end;

// *********************************************************************//
// Interface: ISpEventSource
// Flags:     (512) Restricted
// GUID:      {BE7A9CCE-5F9E-11D2-960F-00C04F8EE628}
// *********************************************************************//
  ISpEventSource = interface(ISpNotifySource)
    ['{BE7A9CCE-5F9E-11D2-960F-00C04F8EE628}']
    function SetInterest(ullEventInterest: Largeuint; ullQueuedInterest: Largeuint): HResult; stdcall;
    function GetEvents(ulCount: LongWord; out pEventArray: SPEVENT; out pulFetched: LongWord): HResult; stdcall;
    function GetInfo(out pInfo: SPEVENTSOURCEINFO): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpEventSink
// Flags:     (512) Restricted
// GUID:      {BE7A9CC9-5F9E-11D2-960F-00C04F8EE628}
// *********************************************************************//
  ISpEventSink = interface(IUnknown)
    ['{BE7A9CC9-5F9E-11D2-960F-00C04F8EE628}']
    function AddEvents(var pEventArray: SPEVENT; ulCount: LongWord): HResult; stdcall;
    function GetEventInterest(out pullEventInterest: Largeuint): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpObjectWithToken
// Flags:     (512) Restricted
// GUID:      {5B559F40-E952-11D2-BB91-00C04F8EE6C0}
// *********************************************************************//
  ISpObjectWithToken = interface(IUnknown)
    ['{5B559F40-E952-11D2-BB91-00C04F8EE6C0}']
    function SetObjectToken(const pToken: ISpObjectToken): HResult; stdcall;
    function GetObjectToken(out ppToken: ISpObjectToken): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpStream
// Flags:     (512) Restricted
// GUID:      {12E3CCA9-7518-44C5-A5E7-BA5A79CB929E}
// *********************************************************************//
  ISpStream = interface(ISpStreamFormat)
    ['{12E3CCA9-7518-44C5-A5E7-BA5A79CB929E}']
    function SetBaseStream(const pStream: IStream; var rguidFormat: TGUID; var pWaveFormatEx: WAVEFORMATEX): HResult; stdcall;
    function GetBaseStream(out ppStream: IStream): HResult; stdcall;
    function BindToFile(pszFileName: PWideChar; eMode: SPFILEMODE; var pFormatId: TGUID; var pWaveFormatEx: WAVEFORMATEX; ullEventInterest: Largeuint): HResult; stdcall;
    function Close: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpVoice
// Flags:     (512) Restricted
// GUID:      {6C44DF74-72B9-4992-A1EC-EF996E0422D4}
// *********************************************************************//
  ISpVoice = interface(ISpEventSource)
    ['{6C44DF74-72B9-4992-A1EC-EF996E0422D4}']
    function SetOutput(const pUnkOutput: IUnknown; fAllowFormatChanges: Integer): HResult; stdcall;
    function GetOutputObjectToken(out ppObjectToken: ISpObjectToken): HResult; stdcall;
    function GetOutputStream(out ppStream: ISpStreamFormat): HResult; stdcall;
    function Pause: HResult; stdcall;
    function Resume: HResult; stdcall;
    function SetVoice(const pToken: ISpObjectToken): HResult; stdcall;
    function GetVoice(out ppToken: ISpObjectToken): HResult; stdcall;
    function Speak(pwcs: PWideChar; dwFlags: LongWord; out pulStreamNumber: LongWord): HResult; stdcall;
    function SpeakStream(const pStream: IStream; dwFlags: LongWord; out pulStreamNumber: LongWord): HResult; stdcall;
    function GetStatus(out pStatus: SPVOICESTATUS; out ppszLastBookmark: PWideChar): HResult; stdcall;
    function Skip(pItemType: PWideChar; lNumItems: Integer; out pulNumSkipped: LongWord): HResult; stdcall;
    function SetPriority(ePriority: SPVPRIORITY): HResult; stdcall;
    function GetPriority(out pePriority: SPVPRIORITY): HResult; stdcall;
    function SetAlertBoundary(eBoundary: SPEVENTENUM): HResult; stdcall;
    function GetAlertBoundary(out peBoundary: SPEVENTENUM): HResult; stdcall;
    function SetRate(RateAdjust: Integer): HResult; stdcall;
    function GetRate(out pRateAdjust: Integer): HResult; stdcall;
    function SetVolume(usVolume: Word): HResult; stdcall;
    function GetVolume(out pusVolume: Word): HResult; stdcall;
    function WaitUntilDone(msTimeout: LongWord): HResult; stdcall;
    function SetSyncSpeakTimeout(msTimeout: LongWord): HResult; stdcall;
    function GetSyncSpeakTimeout(out pmsTimeout: LongWord): HResult; stdcall;
    function SpeakCompleteEvent: Pointer; stdcall;
    function IsUISupported(pszTypeOfUI: PWideChar; pvExtraData: Pointer; cbExtraData: LongWord; out pfSupported: Integer): HResult; stdcall;
    function DisplayUI(var hWndParent: _RemotableHandle; pszTitle: PWideChar; pszTypeOfUI: PWideChar; pvExtraData: Pointer; cbExtraData: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpRecoCategory
// Flags:     (512) Restricted
// GUID:      {DA0CD0F9-14A2-4F09-8C2A-85CC48979345}
// *********************************************************************//
  ISpRecoCategory = interface(IUnknown)
    ['{DA0CD0F9-14A2-4F09-8C2A-85CC48979345}']
    function GetType(out peCategoryType: SPCATEGORYTYPE): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoSpObjectTokenCategory provides a Create and CreateRemote method to
// create instances of the default interface ISpeechObjectTokenCategory exposed by
// the CoClass SpObjectTokenCategory. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSpObjectTokenCategory = class
    class function Create: ISpeechObjectTokenCategory;
    class function CreateRemote(const MachineName: string): ISpeechObjectTokenCategory;
  end;

// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSpObjectTokenCategory
// Help String      : SpObjectTokenCategory Class
// Default Interface: ISpeechObjectTokenCategory
// Def. Intf. DISP? : No
// Event   Interface:
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TSpObjectTokenCategory = class(TOleServer)
  private
    FIntf: ISpeechObjectTokenCategory;
    function GetDefaultInterface: ISpeechObjectTokenCategory;
  protected
    procedure InitServerData; override;
    function Get_Id: WideString;
    procedure Set_Default(const TokenId: WideString);
    function Get_Default: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISpeechObjectTokenCategory);
    procedure Disconnect; override;
    procedure SetId(const Id: WideString; CreateIfNotExist: WordBool);
    function GetDataKey(Location: SpeechDataKeyLocation): ISpeechDataKey;
    function EnumerateTokens(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens;
    property DefaultInterface: ISpeechObjectTokenCategory read GetDefaultInterface;
    property Id: WideString read Get_Id;
    property Default: WideString read Get_Default write Set_Default;
  published
  end;

// *********************************************************************//
// The Class CoSpObjectToken provides a Create and CreateRemote method to
// create instances of the default interface ISpeechObjectToken exposed by
// the CoClass SpObjectToken. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSpObjectToken = class
    class function Create: ISpeechObjectToken;
    class function CreateRemote(const MachineName: string): ISpeechObjectToken;
  end;

// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSpObjectToken
// Help String      : SpObjectToken Class
// Default Interface: ISpeechObjectToken
// Def. Intf. DISP? : No
// Event   Interface:
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TSpObjectToken = class(TOleServer)
  private
    FIntf: ISpeechObjectToken;
    function GetDefaultInterface: ISpeechObjectToken;
  protected
    procedure InitServerData; override;
    function Get_Id: WideString;
    function Get_DataKey: ISpeechDataKey;
    function Get_Category: ISpeechObjectTokenCategory;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISpeechObjectToken);
    procedure Disconnect; override;
    function GetDescription(Locale: Integer): WideString;
    procedure SetId(const Id: WideString; const CategoryID: WideString; CreateIfNotExist: WordBool);
    function GetAttribute(const AttributeName: WideString): WideString;
    function CreateInstance(const pUnkOuter: IUnknown; ClsContext: SpeechTokenContext): IUnknown;
    procedure Remove(const ObjectStorageCLSID: WideString);
    function GetStorageFileName(const ObjectStorageCLSID: WideString; const KeyName: WideString; const FileName: WideString; Folder: SpeechTokenShellFolder): WideString;
    procedure RemoveStorageFileName(const ObjectStorageCLSID: WideString; const KeyName: WideString; DeleteFile: WordBool);
    function IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant; const Object_: IUnknown): WordBool;
    procedure DisplayUI(hWnd: Integer; const Title: WideString; const TypeOfUI: WideString; const ExtraData: OleVariant; const Object_: IUnknown);
    function MatchesAttributes(const Attributes: WideString): WordBool;
    property DefaultInterface: ISpeechObjectToken read GetDefaultInterface;
    property Id: WideString read Get_Id;
    property DataKey: ISpeechDataKey read Get_DataKey;
    property Category: ISpeechObjectTokenCategory read Get_Category;
  published
  end;

// *********************************************************************//
// The Class CoSpVoice provides a Create and CreateRemote method to
// create instances of the default interface ISpeechVoice exposed by
// the CoClass SpVoice. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSpVoice = class
    class function Create: ISpeechVoice;
    class function CreateRemote(const MachineName: string): ISpeechVoice;
  end;

  TSpVoiceStartStream = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant) of object;
  TSpVoiceEndStream = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant) of object;
  TSpVoiceVoiceChange = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; const VoiceObjectToken: ISpeechObjectToken) of object;
  TSpVoiceBookmark = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; const Bookmark: WideString; BookmarkId: Integer) of object;
  TSpVoiceWord = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; CharacterPosition: Integer; Length: Integer) of object;
  TSpVoiceSentence = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant;  CharacterPosition: Integer; Length: Integer) of object;
  TSpVoicePhoneme = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; Duration: Integer; NextPhoneId: Smallint; Feature: SpeechVisemeFeature; CurrentPhoneId: Smallint) of object;
  TSpVoiceViseme = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; Duration: Integer; NextVisemeId: SpeechVisemeType; Feature: SpeechVisemeFeature; CurrentVisemeId: SpeechVisemeType) of object;
  TSpVoiceAudioLevel = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: OleVariant; AudioLevel: Integer) of object;
  TSpVoiceEnginePrivate = procedure(ASender: TObject; StreamNumber: Integer; StreamPosition: Integer; EngineData: OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSpVoice
// Help String      : SpVoice Class
// Default Interface: ISpeechVoice
// Def. Intf. DISP? : No
// Event   Interface: _ISpeechVoiceEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TSpVoice = class(TOleServer)
  private
    FOnStartStream: TSpVoiceStartStream;
    FOnEndStream: TSpVoiceEndStream;
    FOnVoiceChange: TSpVoiceVoiceChange;
    FOnBookmark: TSpVoiceBookmark;
    FOnWord: TSpVoiceWord;
    FOnSentence: TSpVoiceSentence;
    FOnPhoneme: TSpVoicePhoneme;
    FOnViseme: TSpVoiceViseme;
    FOnAudioLevel: TSpVoiceAudioLevel;
    FOnEnginePrivate: TSpVoiceEnginePrivate;
    FIntf: ISpeechVoice;
    function GetDefaultInterface: ISpeechVoice;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Status: ISpeechVoiceStatus;
    function Get_Voice: ISpeechObjectToken;
    procedure _Set_Voice(const Voice: ISpeechObjectToken);
    function Get_AudioOutput: ISpeechObjectToken;
    procedure _Set_AudioOutput(const AudioOutput: ISpeechObjectToken);
    function Get_AudioOutputStream: ISpeechBaseStream;
    procedure _Set_AudioOutputStream(const AudioOutputStream: ISpeechBaseStream);
    function Get_Rate: Integer;
    procedure Set_Rate(Rate: Integer);
    function Get_Volume: Integer;
    procedure Set_Volume(Volume: Integer);
    procedure Set_AllowAudioOutputFormatChangesOnNextSet(Allow: WordBool);
    function Get_AllowAudioOutputFormatChangesOnNextSet: WordBool;
    function Get_EventInterests: SpeechVoiceEvents;
    procedure Set_EventInterests(EventInterestFlags: SpeechVoiceEvents);
    procedure Set_Priority(Priority: SpeechVoicePriority);
    function Get_Priority: SpeechVoicePriority;
    procedure Set_AlertBoundary(Boundary: SpeechVoiceEvents);
    function Get_AlertBoundary: SpeechVoiceEvents;
    procedure Set_SynchronousSpeakTimeout(msTimeout: Integer);
    function Get_SynchronousSpeakTimeout: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISpeechVoice);
    procedure Disconnect; override;
    function Speak(const Text: WideString; Flags: SpeechVoiceSpeakFlags): Integer;
    function SpeakStream(const Stream: ISpeechBaseStream; Flags: SpeechVoiceSpeakFlags): Integer;
    procedure Pause;
    procedure Resume;
    function Skip(const Type_: WideString; NumItems: Integer): Integer;
    function GetVoices(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens;
    function GetAudioOutputs(const RequiredAttributes: WideString; const OptionalAttributes: WideString): ISpeechObjectTokens;
    function WaitUntilDone(msTimeout: Integer): WordBool;
    function SpeakCompleteEvent: Integer;
    function IsUISupported(const TypeOfUI: WideString): WordBool; overload;
    function IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant): WordBool; overload;
    procedure DisplayUI(hWndParent: Integer; const Title: WideString; const TypeOfUI: WideString); overload;
    procedure DisplayUI(hWndParent: Integer; const Title: WideString; const TypeOfUI: WideString; const ExtraData: OleVariant); overload;
    property DefaultInterface: ISpeechVoice read GetDefaultInterface;
    property Status: ISpeechVoiceStatus read Get_Status;
    property Voice: ISpeechObjectToken read Get_Voice write _Set_Voice;
    property AudioOutput: ISpeechObjectToken read Get_AudioOutput write _Set_AudioOutput;
    property AudioOutputStream: ISpeechBaseStream read Get_AudioOutputStream write _Set_AudioOutputStream;
    property AllowAudioOutputFormatChangesOnNextSet: WordBool read Get_AllowAudioOutputFormatChangesOnNextSet write Set_AllowAudioOutputFormatChangesOnNextSet;
    property Rate: Integer read Get_Rate write Set_Rate;
    property Volume: Integer read Get_Volume write Set_Volume;
    property EventInterests: SpeechVoiceEvents read Get_EventInterests write Set_EventInterests;
    property Priority: SpeechVoicePriority read Get_Priority write Set_Priority;
    property AlertBoundary: SpeechVoiceEvents read Get_AlertBoundary write Set_AlertBoundary;
    property SynchronousSpeakTimeout: Integer read Get_SynchronousSpeakTimeout write Set_SynchronousSpeakTimeout;
  published
    property OnStartStream: TSpVoiceStartStream read FOnStartStream write FOnStartStream;
    property OnEndStream: TSpVoiceEndStream read FOnEndStream write FOnEndStream;
    property OnVoiceChange: TSpVoiceVoiceChange read FOnVoiceChange write FOnVoiceChange;
    property OnBookmark: TSpVoiceBookmark read FOnBookmark write FOnBookmark;
    property OnWord: TSpVoiceWord read FOnWord write FOnWord;
    property OnSentence: TSpVoiceSentence read FOnSentence write FOnSentence;
    property OnPhoneme: TSpVoicePhoneme read FOnPhoneme write FOnPhoneme;
    property OnViseme: TSpVoiceViseme read FOnViseme write FOnViseme;
    property OnAudioLevel: TSpVoiceAudioLevel read FOnAudioLevel write FOnAudioLevel;
    property OnEnginePrivate: TSpVoiceEnginePrivate read FOnEnginePrivate write FOnEnginePrivate;
  end;

implementation

uses
  System.Win.ComObj;

class function CoSpObjectTokenCategory.Create: ISpeechObjectTokenCategory;
begin
  Result := CreateComObject(CLASS_SpObjectTokenCategory) as ISpeechObjectTokenCategory;
end;

class function CoSpObjectTokenCategory.CreateRemote(const MachineName: string): ISpeechObjectTokenCategory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SpObjectTokenCategory) as ISpeechObjectTokenCategory;
end;

procedure TSpObjectTokenCategory.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{A910187F-0C7A-45AC-92CC-59EDAFB77B53}';
    IntfIID:   '{CA7EAC50-2D01-4145-86D4-5AE7D70F4469}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSpObjectTokenCategory.Connect;
begin
  if FIntf = nil then
  begin
    var _punk: IUnknown := GetServer;
    Fintf:= _punk as ISpeechObjectTokenCategory;
  end;
end;

procedure TSpObjectTokenCategory.ConnectTo(svrIntf: ISpeechObjectTokenCategory);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSpObjectTokenCategory.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSpObjectTokenCategory.GetDefaultInterface: ISpeechObjectTokenCategory;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSpObjectTokenCategory.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSpObjectTokenCategory.Destroy;
begin
  inherited Destroy;
end;

function TSpObjectTokenCategory.Get_Id: WideString;
begin
  Result := DefaultInterface.Id;
end;

procedure TSpObjectTokenCategory.Set_Default(const TokenId: WideString);
begin
  DefaultInterface.Default := TokenId;
end;

function TSpObjectTokenCategory.Get_Default: WideString;
begin
  Result := DefaultInterface.Default;
end;

procedure TSpObjectTokenCategory.SetId(const Id: WideString; CreateIfNotExist: WordBool);
begin
  DefaultInterface.SetId(Id, CreateIfNotExist);
end;

function TSpObjectTokenCategory.GetDataKey(Location: SpeechDataKeyLocation): ISpeechDataKey;
begin
  Result := DefaultInterface.GetDataKey(Location);
end;

function TSpObjectTokenCategory.EnumerateTokens(const RequiredAttributes: WideString;
                                                const OptionalAttributes: WideString): ISpeechObjectTokens;
begin
  Result := DefaultInterface.EnumerateTokens(RequiredAttributes, OptionalAttributes);
end;

class function CoSpObjectToken.Create: ISpeechObjectToken;
begin
  Result := CreateComObject(CLASS_SpObjectToken) as ISpeechObjectToken;
end;

class function CoSpObjectToken.CreateRemote(const MachineName: string): ISpeechObjectToken;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SpObjectToken) as ISpeechObjectToken;
end;

procedure TSpObjectToken.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{EF411752-3736-4CB4-9C8C-8EF4CCB58EFE}';
    IntfIID:   '{C74A3ADC-B727-4500-A84A-B526721C8B8C}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSpObjectToken.Connect;
begin
  if FIntf = nil then
  begin
    var _punk: IUnknown := GetServer;
    Fintf:= _punk as ISpeechObjectToken;
  end;
end;

procedure TSpObjectToken.ConnectTo(svrIntf: ISpeechObjectToken);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSpObjectToken.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSpObjectToken.GetDefaultInterface: ISpeechObjectToken;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSpObjectToken.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSpObjectToken.Destroy;
begin
  inherited Destroy;
end;

function TSpObjectToken.Get_Id: WideString;
begin
  Result := DefaultInterface.Id;
end;

function TSpObjectToken.Get_DataKey: ISpeechDataKey;
begin
  Result := DefaultInterface.DataKey;
end;

function TSpObjectToken.Get_Category: ISpeechObjectTokenCategory;
begin
  Result := DefaultInterface.Category;
end;

function TSpObjectToken.GetDescription(Locale: Integer): WideString;
begin
  Result := DefaultInterface.GetDescription(Locale);
end;

procedure TSpObjectToken.SetId(const Id: WideString; const CategoryID: WideString;
                               CreateIfNotExist: WordBool);
begin
  DefaultInterface.SetId(Id, CategoryID, CreateIfNotExist);
end;

function TSpObjectToken.GetAttribute(const AttributeName: WideString): WideString;
begin
  Result := DefaultInterface.GetAttribute(AttributeName);
end;

function TSpObjectToken.CreateInstance(const pUnkOuter: IUnknown; ClsContext: SpeechTokenContext): IUnknown;
begin
  Result := DefaultInterface.CreateInstance(pUnkOuter, ClsContext);
end;

procedure TSpObjectToken.Remove(const ObjectStorageCLSID: WideString);
begin
  DefaultInterface.Remove(ObjectStorageCLSID);
end;

function TSpObjectToken.GetStorageFileName(const ObjectStorageCLSID: WideString;
                                           const KeyName: WideString; const FileName: WideString;
                                           Folder: SpeechTokenShellFolder): WideString;
begin
  Result := DefaultInterface.GetStorageFileName(ObjectStorageCLSID, KeyName, FileName, Folder);
end;

procedure TSpObjectToken.RemoveStorageFileName(const ObjectStorageCLSID: WideString;
                                               const KeyName: WideString; DeleteFile: WordBool);
begin
  DefaultInterface.RemoveStorageFileName(ObjectStorageCLSID, KeyName, DeleteFile);
end;

function TSpObjectToken.IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant;
                                      const Object_: IUnknown): WordBool;
begin
  Result := DefaultInterface.IsUISupported(TypeOfUI, ExtraData, Object_);
end;

procedure TSpObjectToken.DisplayUI(hWnd: Integer; const Title: WideString;
                                   const TypeOfUI: WideString; const ExtraData: OleVariant;
                                   const Object_: IUnknown);
begin
  DefaultInterface.DisplayUI(hWnd, Title, TypeOfUI, ExtraData, Object_);
end;

function TSpObjectToken.MatchesAttributes(const Attributes: WideString): WordBool;
begin
  Result := DefaultInterface.MatchesAttributes(Attributes);
end;

class function CoSpVoice.Create: ISpeechVoice;
begin
  Result := CreateComObject(CLASS_SpVoice) as ISpeechVoice;
end;

class function CoSpVoice.CreateRemote(const MachineName: string): ISpeechVoice;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SpVoice) as ISpeechVoice;
end;

procedure TSpVoice.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{96749377-3391-11D2-9EE3-00C04F797396}';
    IntfIID:   '{269316D8-57BD-11D2-9EEE-00C04F797396}';
    EventIID:  '{A372ACD1-3BEF-4BBD-8FFB-CB3E2B416AF8}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSpVoice.Connect;
begin
  if FIntf = nil then
  begin
    var _punk: IUnknown := GetServer;
    ConnectEvents(_punk);
    Fintf:= _punk as ISpeechVoice;
  end;
end;

procedure TSpVoice.ConnectTo(svrIntf: ISpeechVoice);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TSpVoice.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TSpVoice.GetDefaultInterface: ISpeechVoice;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSpVoice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSpVoice.Destroy;
begin
  inherited Destroy;
end;

procedure TSpVoice.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnStartStream) then
         FOnStartStream(Self,
                        Params[0] {Integer},
                        Params[1] {OleVariant});
    2: if Assigned(FOnEndStream) then
         FOnEndStream(Self,
                      Params[0] {Integer},
                      Params[1] {OleVariant});
    3: if Assigned(FOnVoiceChange) then
         FOnVoiceChange(Self,
                        Params[0] {Integer},
                        Params[1] {OleVariant},
                        IUnknown(TVarData(Params[2]).VPointer) as ISpeechObjectToken {const ISpeechObjectToken});
    4: if Assigned(FOnBookmark) then
         FOnBookmark(Self,
                     Params[0] {Integer},
                     Params[1] {OleVariant},
                     Params[2] {const WideString},
                     Params[3] {Integer});
    5: if Assigned(FOnWord) then
         FOnWord(Self,
                 Params[0] {Integer},
                 Params[1] {OleVariant},
                 Params[2] {Integer},
                 Params[3] {Integer});
    7: if Assigned(FOnSentence) then
         FOnSentence(Self,
                     Params[0] {Integer},
                     Params[1] {OleVariant},
                     Params[2] {Integer},
                     Params[3] {Integer});
    6: if Assigned(FOnPhoneme) then
         FOnPhoneme(Self,
                    Params[0] {Integer},
                    Params[1] {OleVariant},
                    Params[2] {Integer},
                    Params[3] {Smallint},
                    Params[4] {SpeechVisemeFeature},
                    Params[5] {Smallint});
    8: if Assigned(FOnViseme) then
         FOnViseme(Self,
                   Params[0] {Integer},
                   Params[1] {OleVariant},
                   Params[2] {Integer},
                   Params[3] {SpeechVisemeType},
                   Params[4] {SpeechVisemeFeature},
                   Params[5] {SpeechVisemeType});
    9: if Assigned(FOnAudioLevel) then
         FOnAudioLevel(Self,
                       Params[0] {Integer},
                       Params[1] {OleVariant},
                       Params[2] {Integer});
    10: if Assigned(FOnEnginePrivate) then
         FOnEnginePrivate(Self,
                          Params[0] {Integer},
                          Params[1] {Integer},
                          Params[2] {OleVariant});
  end; {case DispID}
end;

function TSpVoice.Get_Status: ISpeechVoiceStatus;
begin
  Result := DefaultInterface.Status;
end;

function TSpVoice.Get_Voice: ISpeechObjectToken;
begin
  Result := DefaultInterface.Voice;
end;

procedure TSpVoice._Set_Voice(const Voice: ISpeechObjectToken);
begin
  DefaultInterface.Voice := Voice;
end;

function TSpVoice.Get_AudioOutput: ISpeechObjectToken;
begin
  Result := DefaultInterface.AudioOutput;
end;

procedure TSpVoice._Set_AudioOutput(const AudioOutput: ISpeechObjectToken);
begin
  DefaultInterface.AudioOutput := AudioOutput;
end;

function TSpVoice.Get_AudioOutputStream: ISpeechBaseStream;
begin
  Result := DefaultInterface.AudioOutputStream;
end;

procedure TSpVoice._Set_AudioOutputStream(const AudioOutputStream: ISpeechBaseStream);
begin
  DefaultInterface.AudioOutputStream := AudioOutputStream;
end;

function TSpVoice.Get_Rate: Integer;
begin
  Result := DefaultInterface.Rate;
end;

procedure TSpVoice.Set_Rate(Rate: Integer);
begin
  DefaultInterface.Rate := Rate;
end;

function TSpVoice.Get_Volume: Integer;
begin
  Result := DefaultInterface.Volume;
end;

procedure TSpVoice.Set_Volume(Volume: Integer);
begin
  DefaultInterface.Volume := Volume;
end;

procedure TSpVoice.Set_AllowAudioOutputFormatChangesOnNextSet(Allow: WordBool);
begin
  DefaultInterface.AllowAudioOutputFormatChangesOnNextSet := Allow;
end;

function TSpVoice.Get_AllowAudioOutputFormatChangesOnNextSet: WordBool;
begin
  Result := DefaultInterface.AllowAudioOutputFormatChangesOnNextSet;
end;

function TSpVoice.Get_EventInterests: SpeechVoiceEvents;
begin
  Result := DefaultInterface.EventInterests;
end;

procedure TSpVoice.Set_EventInterests(EventInterestFlags: SpeechVoiceEvents);
begin
  DefaultInterface.EventInterests := EventInterestFlags;
end;

procedure TSpVoice.Set_Priority(Priority: SpeechVoicePriority);
begin
  DefaultInterface.Priority := Priority;
end;

function TSpVoice.Get_Priority: SpeechVoicePriority;
begin
  Result := DefaultInterface.Priority;
end;

procedure TSpVoice.Set_AlertBoundary(Boundary: SpeechVoiceEvents);
begin
  DefaultInterface.AlertBoundary := Boundary;
end;

function TSpVoice.Get_AlertBoundary: SpeechVoiceEvents;
begin
  Result := DefaultInterface.AlertBoundary;
end;

procedure TSpVoice.Set_SynchronousSpeakTimeout(msTimeout: Integer);
begin
  DefaultInterface.SynchronousSpeakTimeout := msTimeout;
end;

function TSpVoice.Get_SynchronousSpeakTimeout: Integer;
begin
  Result := DefaultInterface.SynchronousSpeakTimeout;
end;

function TSpVoice.Speak(const Text: WideString; Flags: SpeechVoiceSpeakFlags): Integer;
begin
  Result := DefaultInterface.Speak(Text, Flags);
end;

function TSpVoice.SpeakStream(const Stream: ISpeechBaseStream; Flags: SpeechVoiceSpeakFlags): Integer;
begin
  Result := DefaultInterface.SpeakStream(Stream, Flags);
end;

procedure TSpVoice.Pause;
begin
  DefaultInterface.Pause;
end;

procedure TSpVoice.Resume;
begin
  DefaultInterface.Resume;
end;

function TSpVoice.Skip(const Type_: WideString; NumItems: Integer): Integer;
begin
  Result := DefaultInterface.Skip(Type_, NumItems);
end;

function TSpVoice.GetVoices(const RequiredAttributes: WideString;
                            const OptionalAttributes: WideString): ISpeechObjectTokens;
begin
  Result := DefaultInterface.GetVoices(RequiredAttributes, OptionalAttributes);
end;

function TSpVoice.GetAudioOutputs(const RequiredAttributes: WideString;
                                  const OptionalAttributes: WideString): ISpeechObjectTokens;
begin
  Result := DefaultInterface.GetAudioOutputs(RequiredAttributes, OptionalAttributes);
end;

function TSpVoice.WaitUntilDone(msTimeout: Integer): WordBool;
begin
  Result := DefaultInterface.WaitUntilDone(msTimeout);
end;

function TSpVoice.SpeakCompleteEvent: Integer;
begin
  Result := DefaultInterface.SpeakCompleteEvent;
end;

function TSpVoice.IsUISupported(const TypeOfUI: WideString): WordBool;
begin
  var _EmptyParam: OleVariant := System.Variants.EmptyParam;
  Result := DefaultInterface.IsUISupported(TypeOfUI, _EmptyParam);
end;

function TSpVoice.IsUISupported(const TypeOfUI: WideString; const ExtraData: OleVariant): WordBool;
begin
  Result := DefaultInterface.IsUISupported(TypeOfUI, ExtraData);
end;

procedure TSpVoice.DisplayUI(hWndParent: Integer; const Title: WideString;
                             const TypeOfUI: WideString);
begin
  var _EmptyParam: OleVariant := System.Variants.EmptyParam;
  DefaultInterface.DisplayUI(hWndParent, Title, TypeOfUI, _EmptyParam);
end;

procedure TSpVoice.DisplayUI(hWndParent: Integer; const Title: WideString;
                             const TypeOfUI: WideString; const ExtraData: OleVariant);
begin
  DefaultInterface.DisplayUI(hWndParent, Title, TypeOfUI, ExtraData);
end;

end.
