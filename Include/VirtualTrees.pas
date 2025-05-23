﻿unit VirtualTrees;

// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at http://www.mozilla.org/MPL/
//
// Alternatively, you may redistribute this library, use and/or modify it under the terms of the
// GNU Lesser General Public License as published by the Free Software Foundation;
// either version 2.1 of the License, or (at your option) any later version.
// You may obtain a copy of the LGPL at http://www.gnu.org/copyleft/.
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for the
// specific language governing rights and limitations under the License.
//
// The original code is VirtualTrees.pas, released September 30, 2000.
//
// The initial developer of the original code is digital publishing AG (Munich, Germany, www.digitalpublishing.de),
// most code was written by Mike Lischke 2000-2009 (public@soft-gems.net, www.soft-gems.net)
//
// Portions created by digital publishing AG are Copyright
// (C) 1999-2001 digital publishing AG. All Rights Reserved.
//----------------------------------------------------------------------------------------------------------------------
//
// For a list of recent changes please see file CHANGES.TXT
//
// Credits for their valuable assistance and code donations go to:
//   Freddy Ertl, Marian Aldenhoevel, Thomas Bogenrieder, Jim Kuenemann, Werner Lehmann, Jens Treichler,
//   Paul Gallagher (IBO tree), Ondrej Kelle, Ronaldo Melo Ferraz, Heri Bender, Roland Beduerftig (BCB)
//   Anthony Mills, Alexander Egorushkin (BCB), Mathias Torell (BCB), Frank van den Bergh, Vadim Sedulin, Peter Evans,
//   Milan Vandrovec (BCB), Steve Moss, Joe White, David Clark, Anders Thomsen, Igor Afanasyev, Eugene Programmer,
//   Corbin Dunn, Richard Pringle, Uli Gerhardt, Azza, Igor Savkic, Daniel Bauten, Timo Tegtmeier, Dmitry Zegebart,
//   Andreas Hausladen, Joachim Marder, Roman Kassebaum, Vincent Parrett, Dietmar Roesler, Sanjay Kanade,
//   and everyone that sent pull requests: https://github.com/Virtual-TreeView/Virtual-TreeView/pulls?q=
// Beta testers:
//   Freddy Ertl, Hans-Juergen Schnorrenberg, Werner Lehmann, Jim Kueneman, Vadim Sedulin, Moritz Franckenstein,
//   Wim van der Vegt, Franc v/d Westelaken
// Indirect contribution (via publicly accessible work of those persons):
//   Alex Denissov, Hiroyuki Hori (MMXAsm expert)
// Documentation:
//   Markus Spoettl and toolsfactory GbR (http://www.doc-o-matic.com/, sponsoring Virtual TreeView development
//   with a free copy of the Doc-O-Matic help authoring system), Sven H. (Step by step tutorial)
// Source repository:
//   https://github.com/Virtual-TreeView/Virtual-TreeView
// Accessability implementation:
//   Marco Zehe (with help from Sebastian Modersohn)
// Port to Firemonkey:
//   Karol Bieniaszewski (github user livius2)
//----------------------------------------------------------------------------------------------------------------------

// Modified by ichin 2024-05-30 목 오후 2:56:19
{
  Customized for Vcl / MultiLine ...
  Partial modification - DoTextDrawing
  - Add Headrect, BodyRect, Footrect
}

interface

{$BOOLEVAL OFF} // Use fastest possible boolean evaluation   ? Default

// For some things to work we need code, which is classified as being unsafe for .NET.
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN UNSAFE_CODE OFF}

{$LEGACYIFEND ON}
{$WARN UNSUPPORTED_CONSTRUCT OFF}

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ActiveX,
  System.Classes,
  System.SysUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.ImgList,
  Vcl.Menus,
  Vcl.Themes,
  VirtualTrees.Types,
  VirtualTrees.Header,
  VirtualTrees.BaseTree,
  VirtualTrees.AncestorVCL;

  {$MinEnumSize 1, make enumerations as small as possible}

type
  // Some aliases for backward compatiblity
  PVirtualNode             = VirtualTrees.Types.PVirtualNode;
  TVirtualNode             = VirtualTrees.Types.TVirtualNode;
  TVTHeaderColumnLayout    = VirtualTrees.Types.TVTHeaderColumnLayout;
  TSmartAutoFitType        = VirtualTrees.Types.TSmartAutoFitType;
  TVirtualTreeStates       = VirtualTrees.Types.TVirtualTreeStates;
  TCheckState              = VirtualTrees.Types.TCheckState;
  TCheckType               = VirtualTrees.Types.TCheckType;
  TSortDirection           = VirtualTrees.Types.TSortDirection;
  TColumnIndex             = VirtualTrees.Types.TColumnIndex;
  TVTColumnOption          = VirtualTrees.Types.TVTColumnOption;
  TVTHeaderHitInfo         = VirtualTrees.Types.TVTHeaderHitInfo;
  TVTHeaderHitPosition     = VirtualTrees.Types.TVTHeaderHitPosition;
  TVTHeaderHitPositions    = VirtualTrees.Types.TVTHeaderHitPositions;
  THeaderState             = VirtualTrees.Types.THeaderState;
  THeaderStates            = VirtualTrees.Types.THeaderStates;
  TDropMode                = VirtualTrees.Types.TDropMode;
  TFormatArray             = VirtualTrees.Types.TFormatArray;
  TVTHeaderOption          = VirtualTrees.Types.TVTHeaderOption;
  TVTHeaderOptions         = VirtualTrees.Types.TVTHeaderOptions;
  TVTHeaderStyle           = VirtualTrees.Types.TVTHeaderStyle;
  TVTExportType            = VirtualTrees.Types.TVTExportType;
  TVTImageKind             = VirtualTrees.Types.TVTImageKind;
  TVTExportMode            = VirtualTrees.Types.TVTExportMode;
  TVTOperationKind         = VirtualTrees.Types.TVTOperationKind;
  TVTUpdateState           = VirtualTrees.Types.TVTUpdateState;
  TVTCellPaintMode         = VirtualTrees.Types.TVTCellPaintMode;
  TVirtualNodeState        = VirtualTrees.Types.TVirtualNodeState;
  TVirtualNodeInitState    = VirtualTrees.Types.TVirtualNodeInitState;
  TVirtualNodeInitStates   = VirtualTrees.Types.TVirtualNodeInitStates;
  TVTTooltipLineBreakStyle = VirtualTrees.Types.TVTTooltipLineBreakStyle;
  TVTNodeAttachMode        = VirtualTrees.Types.TVTNodeAttachMode;
  TNodeArray               = VirtualTrees.Types.TNodeArray;
  THitInfo                 = VirtualTrees.Types.THitInfo;
  THitPosition             = VirtualTrees.Types.THitPosition;
  TVTPaintOption           = VirtualTrees.Types.TVTPaintOption;
  TVTAutoOption            = VirtualTrees.Types.TVTAutoOption;
  TVTAutoOptions           = VirtualTrees.Types.TVTAutoOptions;
  TVTSelectionOption       = VirtualTrees.Types.TVTSelectionOption;
  TVSTTextType             = VirtualTrees.Types.TVSTTextType;
  TVTHintMode              = VirtualTrees.Types.TVTHintMode;
  TBaseVirtualTree         = VirtualTrees.BaseTree.TBaseVirtualTree;
  IVTEditLink              = VirtualTrees.BaseTree.IVTEditLink;
  TVTHeaderNotifyEvent     = VirtualTrees.BaseTree.TVTHeaderNotifyEvent;
  TVTCompareEvent          = VirtualTrees.BaseTree.TVTCompareEvent;
  TVirtualTreeColumn       = VirtualTrees.Header.TVirtualTreeColumn;
  TVirtualTreeColumns      = VirtualTrees.Header.TVirtualTreeColumns;
  TVTHeader                = VirtualTrees.Header.TVTHeader;
  TVTHeaderClass           = VirtualTrees.Header.TVTHeaderClass;
  THeaderPaintInfo         = VirtualTrees.Header.THeaderPaintInfo;
  TVTConstraintPercent     = VirtualTrees.Header.TVTConstraintPercent;
  TVTFixedAreaConstraints  = VirtualTrees.Header.TVTFixedAreaConstraints;
  TColumnsArray            = VirtualTrees.Header.TColumnsArray;
  TCanvas                  = Vcl.Graphics.TCanvas;

const
  // Aliases for increased compatibility with V7, feel free to extend by pull requests
  NoColumn                 = VirtualTrees.Types.NoColumn;
  InvalidColumn            = VirtualTrees.Types.InvalidColumn;
  sdAscending              = VirtualTrees.Types.TSortDirection.sdAscending;
  sdDescending             = VirtualTrees.Types.TSortDirection.sdDescending;
  toAutoSort               = VirtualTrees.Types.TVTAutoOption.toAutoSort;
  toCheckSupport           = VirtualTrees.Types.TVTMiscOption.toCheckSupport;
  toEditable               = VirtualTrees.Types.TVTMiscOption.toEditable;
  toShowRoot               = VirtualTrees.Types.TVTPaintOption.toShowRoot;
  ctNone                   = VirtualTrees.Types.TCheckType.ctNone;
  ctTriStateCheckBox       = VirtualTrees.Types.TCheckType.ctTriStateCheckBox;
  ctCheckBox               = VirtualTrees.Types.TCheckType.ctCheckBox;
  ctRadioButton            = VirtualTrees.Types.TCheckType.ctRadioButton;
  ctButton                 = VirtualTrees.Types.TCheckType.ctButton;

  csUncheckedNormal        = VirtualTrees.Types.TCheckState.csUncheckedNormal;
  csUncheckedPressed       = VirtualTrees.Types.TCheckState.csUncheckedPressed;
  csCheckedNormal          = VirtualTrees.Types.TCheckState.csCheckedNormal;
  csCheckedPressed         = VirtualTrees.Types.TCheckState.csCheckedPressed;
  csMixedNormal            = VirtualTrees.Types.TCheckState.csMixedNormal;
  csMixedPressed           = VirtualTrees.Types.TCheckState.csMixedPressed;
  csUncheckedDisabled      = VirtualTrees.Types.TCheckState.csUncheckedDisabled;
  csCheckedDisabled        = VirtualTrees.Types.TCheckState.csCheckedDisabled;
  csMixedDisable           = VirtualTrees.Types.TCheckState.csMixedDisabled;

  coVisible                = VirtualTrees.Types.TVTColumnOption.coVisible;
  vsDisabled               = VirtualTrees.Types.TVirtualNodeState.vsDisabled;
  etHTML                   = VirtualTrees.Types.TVTExportType.etHTML;
  hiOnItemButton           = VirtualTrees.Types.THitPosition.hiOnItemButton;
  dmOnNode                 = VirtualTrees.Types.TDropMode.dmOnNode;
  hlbForceMultiLine        = VirtualTrees.Types.TVTTooltipLineBreakStyle.hlbForceMultiLine;
  hmHintAndDefault         = VirtualTrees.Types.TVTHintMode.hmHintAndDefault;
  hmTooltip                = VirtualTrees.Types.TVTHintMode.hmTooltip;

type
  TCustomVirtualStringTree = class;
  TVTAncestor = TVTAncestorVcl;

  // Describes the source to use when converting a string tree into a string for clipboard etc.
  TVSTTextSourceType = (
    tstAll,             // All nodes are rendered. Initialization is done on the fly.
    tstInitialized,     // Only initialized nodes are rendered.
    tstSelected,        // Only selected nodes are rendered.
    tstCutCopySet,      // Only nodes currently marked as being in the cut/copy clipboard set are rendered.
    tstVisible,         // Only visible nodes are rendered.
    tstChecked          // Only checked nodes are rendered
  );

  TVSTGetTextEvent = procedure(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string) of object;
  TVSTGetHintEvent = procedure(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string) of object;
  // New text can only be set for variable caption.
  TVSTNewTextEvent = procedure(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string) of object;
  TVSTShortenStringEvent = procedure(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const S: string; TextSpace: TDimension; var Result: string; var Done: Boolean) of object;
  TVTMeasureTextEvent = procedure(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string; var Extent: TDimension) of object;
  TVTDrawTextEvent = procedure(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string; const CellRect: TRect; var DefaultDraw: Boolean) of object;
  // Modified by ichin 2024-05-30 목 오전 6:04:46
  TVTDrawTitleEvent = procedure(Sender: TBaseVirtualTree; Node: PVirtualNode; var Title, TimeStamp: string; var Tag, LvTag: Integer) of object;

  /// Event arguments of the OnGetCellText event
  TVSTGetCellTextEventArgs = record
    Node: PVirtualNode;
    Column: TColumnIndex;
    CellText: string;
    StaticText: string;
    StaticTextAlignment: TAlignment;
    ExportType: TVTExportType;
    constructor Create(pNode: PVirtualNode; pColumn: TColumnIndex; pExportType: TVTExportType = TVTExportType.etNone);
  end;

  /// Event signature which is called when text is painted on the canvas or needed for the export.
  TVSTGetCellTextEvent = procedure(Sender: TCustomVirtualStringTree; var E: TVSTGetCellTextEventArgs) of object;

  TCustomVirtualStringTree = class(TVTAncestor)
  private
    FInternalDataOffset: Cardinal;                 // offset to the internal data of the string tree
    FDefaultText: string;                          // text to show if there's no OnGetText event handler (e.g. at design time)
    FTextHeight: Integer;                          // true size of the font
    FEllipsisWidth: Integer;                       // width of '...' for the current font

    FOnGetText: TVSTGetTextEvent;                  // used to retrieve the string to be displayed for a specific node
    fOnGetCellText: TVSTGetCellTextEvent;          // used to retrieve the normal and static text of a tree node
    FOnGetHint: TVSTGetHintEvent;                  // used to retrieve the hint to be displayed for a specific node
    FOnNewText: TVSTNewTextEvent;                  // used to notify the application about an edited node caption
    FOnShortenString: TVSTShortenStringEvent;      // used to allow the application a customized string shortage
    FOnMeasureTextWidth: TVTMeasureTextEvent;      // used to adjust the width of the cells
    FOnMeasureTextHeight: TVTMeasureTextEvent;
    FOnDrawText: TVTDrawTextEvent;                 // used to custom draw the node text
    // Modified by ichin 2024-05-30 목 오전 4:59:18
    FOnDrawTitle: TVTDrawTitleEvent;
    FOffsetWRMagin: Integer;
    FNodeHeightOffSet: Integer;
    FNode_HeaderColor: TColor;
    FNode_BodyColor: TColor;
    FNode_FooterColor: TColor;
    FThumbLists: TImageList;
    /// Returns True if the property DefaultText has a value that differs from the default value, False otherwise.
    function IsDefaultTextStored(): Boolean;
    function GetImageText(Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex): string;
    function GetOptions: TCustomStringTreeOptions;
    function GetStaticText(Node: PVirtualNode; Column: TColumnIndex): string;
    function GetText(Node: PVirtualNode; Column: TColumnIndex): string;
    procedure ReadText(Reader: TReader);
    procedure WriteText(Writer: TWriter);
    procedure ResetInternalData(Node: PVirtualNode; Recursive: Boolean);
    procedure SetDefaultText(const Value: string);
    procedure SetOptions(const Value: TCustomStringTreeOptions);
    procedure SetText(Node: PVirtualNode; Column: TColumnIndex; const Value: string);
    procedure WMSetFont(var Msg: TWMSetFont); message WM_SETFONT;
    procedure GetDataFromGrid(const AStrings : TStringList; const IncludeHeading : Boolean = True);
    // Modified by ichin 2024-06-26 수 오전 11:01:44
    procedure SetNode_BodyColor(const Value: TColor);
    procedure SetNode_FooterColor(const Value: TColor);
    procedure SetNode_HeaderColor(const Value: TColor);
    function GetHeaderTextHeight(const Text: string): TSize;
  protected
    /// <summary>Contains the name of the string that should be restored as selection</summary>
    /// <seealso cref="TVTSelectionOption.toRestoreSelection">
    FPreviouslySelected: TStringList;
    procedure InitializeTextProperties(var PaintInfo: TVTPaintInfo);
    procedure PaintNormalText(var PaintInfo: TVTPaintInfo; TextOutFlags: Integer; Text: string); virtual;
    procedure PaintStaticText(const PaintInfo: TVTPaintInfo; pStaticTextAlignment: TAlignment; const Text: string); virtual; // [IPK] - private to protected
    procedure AdjustPaintCellRect(var PaintInfo: TVTPaintInfo; var NextNonEmpty: TColumnIndex); override;
    function CanExportNode(Node: PVirtualNode): Boolean;
    function CalculateStaticTextWidth(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string): TDimension; virtual;
    function CalculateTextWidth(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string): TDimension; virtual;
    function ColumnIsEmpty(Node: PVirtualNode; Column: TColumnIndex): Boolean; override;
    procedure DefineProperties(Filer: TFiler); override;
    function DoCreateEditor(Node: PVirtualNode; Column: TColumnIndex): IVTEditLink; override;
    procedure DoAddToSelection(Node: PVirtualNode); override;
    function DoGetNodeHint(Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle): string; override;
    function DoGetNodeTooltip(Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle): string; override;
    function DoGetNodeExtraWidth(Node: PVirtualNode; Column: TColumnIndex; Canvas: TCanvas = nil): TDimension; override;
    function DoGetNodeWidth(Node: PVirtualNode; Column: TColumnIndex; Canvas: TCanvas = nil): TDimension; override;
    procedure DoGetText(var pEventArgs: TVSTGetCellTextEventArgs); virtual;
    function DoIncrementalSearch(Node: PVirtualNode; const Text: string): Integer; override;
    procedure DoNewText(Node: PVirtualNode; Column: TColumnIndex; const Text: string); virtual;
    procedure DoPaintNode(var PaintInfo: TVTPaintInfo); override;
    function DoShortenString(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const S: string; Width: TDimension; EllipsisWidth: TDimension = 0): string; virtual;
    procedure DoTextDrawing(var PaintInfo: TVTPaintInfo; const Text: string; CellRect: TRect; DrawFormat: Cardinal); virtual;
    function DoTextMeasuring(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string): TSize; virtual;
    function GetOptionsClass: TTreeOptionsClass; override;
    procedure GetRenderStartValues(Source: TVSTTextSourceType; var Node: PVirtualNode; var NextNodeProc: TGetNextNodeProc);
    function InternalData(Node: PVirtualNode): Pointer;
    procedure MainColumnChanged; override;
    function ReadChunk(Stream: TStream; Version: Integer; Node: PVirtualNode; ChunkType, ChunkSize: Integer): Boolean; override;
    procedure ReadOldStringOptions(Reader: TReader);
    function RenderOLEData(const FormatEtcIn: TFormatEtc; out Medium: TStgMedium; ForClipboard: Boolean): HResult; override;
    procedure SetChildCount(Node: PVirtualNode; NewChildCount: Cardinal); override;
    procedure WriteChunks(Stream: TStream; Node: PVirtualNode); override;

    property DefaultText: string read FDefaultText write SetDefaultText stored False;// Stored via own writer
    property EllipsisWidth: Integer read FEllipsisWidth;
    property TreeOptions: TCustomStringTreeOptions read GetOptions write SetOptions;

    property OnGetHint: TVSTGetHintEvent read FOnGetHint write FOnGetHint;
    property OnGetText: TVSTGetTextEvent read FOnGetText write FOnGetText;
    property OnGetCellText: TVSTGetCellTextEvent read fOnGetCellText write fOnGetCellText;
    property OnNewText: TVSTNewTextEvent read FOnNewText write FOnNewText;
    property OnShortenString: TVSTShortenStringEvent read FOnShortenString write FOnShortenString;
    property OnMeasureTextWidth: TVTMeasureTextEvent read FOnMeasureTextWidth write FOnMeasureTextWidth;
    property OnMeasureTextHeight: TVTMeasureTextEvent read FOnMeasureTextHeight write FOnMeasureTextHeight;
    property OnDrawText: TVTDrawTextEvent read FOnDrawText write FOnDrawText;
    // Modified by ichin 2024-06-03 월 오전 12:25:19
    property OnDrawTitle: TVTDrawTitleEvent read FOnDrawTitle write FOnDrawTitle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    //
    function AddChild(Parent: PVirtualNode; UserData: Pointer = nil): PVirtualNode; override;
    function ComputeNodeHeight(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; S: string = ''): TDimension; virtual;
    function ContentToClipboard(Format: Word; Source: TVSTTextSourceType): HGLOBAL;
    procedure ContentToCustom(Source: TVSTTextSourceType);
    function ContentToHTML(Source: TVSTTextSourceType; const Caption: string = ''): String;
    function ContentToRTF(Source: TVSTTextSourceType): RawByteString;
    function ContentToText(Source: TVSTTextSourceType; Separator: Char): String; overload;
    function ContentToUnicode(Source: TVSTTextSourceType; Separator: WideChar): string; overload; deprecated 'Use ContentToText instead';
    function ContentToText(Source: TVSTTextSourceType; const Separator: string): string; overload;
    procedure GetTextInfo(Node: PVirtualNode; Column: TColumnIndex; const AFont: TFont; var R: TRect; var Text: string); override;
    function InvalidateNode(Node: PVirtualNode): TRect; override;
    function Path(Node: PVirtualNode; Column: TColumnIndex; Delimiter: Char): string;
    procedure ReinitNode(Node: PVirtualNode; Recursive: Boolean; ForceReinit: Boolean = False); override;
    procedure RemoveFromSelection(Node: PVirtualNode); override;
    function SaveToCSVFile(const FileNameWithPath: TFileName; const IncludeHeading: Boolean): Boolean;
    /// Alternate text for images used in Accessibility.
    property ImageText[Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex]: string read GetImageText;
    property StaticText[Node: PVirtualNode; Column: TColumnIndex]: string read GetStaticText;
    property Text[Node: PVirtualNode; Column: TColumnIndex]: string read GetText write SetText;
    // Modified by ichin 2024-05-30 목 오전 4:59:53
    property OffsetWRMagin: Integer    read FOffsetWRMagin     write FOffsetWRMagin;
    property NodeHeightOffSet: Integer read FNodeHeightOffSet  write FNodeHeightOffSet;
    property Node_HeaderColor: TColor  read FNode_HeaderColor  write SetNode_HeaderColor;
    property Node_BodyColor: TColor    read FNode_BodyColor    write SetNode_BodyColor;
    property Node_FooterColor: TColor  read FNode_FooterColor  write SetNode_FooterColor;
    property ThumbLists: TImageList    read FThumbLists        write FThumbLists;
  end;

  //[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  // Modified by ichin 2025-04-22 화 오전 7:37:17
  [ComponentPlatformsAttribute(pfidWindows)]
  TVirtualStringTree = class(TCustomVirtualStringTree)
  private
    function GetOptions: TStringTreeOptions;
    procedure SetOptions(const Value: TStringTreeOptions);
  protected
    function GetOptionsClass: TTreeOptionsClass; override;
  public
    property Canvas;
    property RangeX;
    property LastDragEffect;
    property CheckImageKind; // should no more be published to make #622 fix working
    // Modified by ichin 2024-05-30 목 오후 9:07:44
    property SelectedBrushColor;
    property OffsetWRMagin;
    property NodeHeightOffSet;
    property Node_HeaderColor;
    property Node_BodyColor;
    property Node_FooterColor;
    property OnDrawTitle;
    property ThumbLists;
  published
    property AccessibleName;
    property Action;
    property Align;
    property Alignment;
    property Anchors;
    property AnimationDuration;
    property AutoExpandDelay;
    property AutoScrollDelay;
    property AutoScrollInterval;
    property Background;
    property BackGroundImageTransparent;
    property BackgroundOffsetX;
    property BackgroundOffsetY;
    property BiDiMode;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderStyle;
    property BottomSpace;
    property ButtonFillMode;
    property ButtonStyle;
    property BorderWidth;
    property ChangeDelay;
    property ClipboardFormats;
    property Color;
    property Colors;
    property Constraints;
    property Ctl3D;
    property CustomCheckImages;
    property DefaultNodeHeight;
    property DefaultPasteMode;
    property DefaultText;
    property DragCursor;
    property DragHeight;
    property DragKind;
    property DragImageKind;
    property DragMode;
    property DragOperations;
    property DragType;
    property DragWidth;
    property DrawSelectionMode;
    property EditDelay;
    property EmptyListMessage;
    property Enabled;
    property Font;
    property Header;
    property HintMode;
    property HotCursor;
    property Images;
    property IncrementalSearch;
    property IncrementalSearchDirection;
    property IncrementalSearchStart;
    property IncrementalSearchTimeout;
    property Indent;
    property LineMode;
    property LineStyle;
    property Margin;
    property NodeAlignment;
    property NodeDataSize;
    property OperationCanceled;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RootNodeCount;
    property ScrollBarOptions;
    property SelectionBlendFactor;
    property SelectionCurveRadius;
    property ShowHint;
    property StateImages;
    property StyleElements;
    property StyleName;
    property TabOrder;
    property TabStop default True;
    property TextMargin;
    property TreeOptions: TStringTreeOptions read GetOptions write SetOptions;
    property Visible;
    property WantTabs;

    property OnAddToSelection;
    property OnAdvancedHeaderDraw;
    property OnAfterAutoFitColumn;
    property OnAfterAutoFitColumns;
    property OnAfterCellPaint;
    property OnAfterColumnExport;
    property OnAfterColumnWidthTracking;
    property OnAfterGetMaxColumnWidth;
    property OnAfterHeaderExport;
    property OnAfterHeaderHeightTracking;
    property OnAfterItemErase;
    property OnAfterItemPaint;
    property OnAfterNodeExport;
    property OnAfterPaint;
    property OnAfterTreeExport;
    property OnBeforeAutoFitColumn;
    property OnBeforeAutoFitColumns;
    property OnBeforeCellPaint;
    property OnBeforeColumnExport;
    property OnBeforeColumnWidthTracking;
    property OnBeforeDrawTreeLine;
    property OnBeforeGetMaxColumnWidth;
    property OnBeforeHeaderExport;
    property OnBeforeHeaderHeightTracking;
    property OnBeforeItemErase;
    property OnBeforeItemPaint;
    property OnBeforeNodeExport;
    property OnBeforePaint;
    property OnBeforeTreeExport;
    property OnCanSplitterResizeColumn;
    property OnCanSplitterResizeHeader;
    property OnCanSplitterResizeNode;
    property OnChange;
    property OnChecked;
    property OnChecking;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnColumnChecked;
    property OnColumnChecking;
    property OnColumnClick;
    property OnColumnDblClick;
    property OnColumnExport;
    property OnColumnResize;
    property OnColumnVisibilityChanged;
    property OnColumnWidthDblClickResize;
    property OnColumnWidthTracking;
    property OnCompareNodes;
    property OnContextPopup;
    property OnCreateDataObject;
    property OnCreateDragManager;
    property OnCreateEditor;
    property OnDblClick;
    property OnDragAllowed;
    property OnDragOver;
    property OnDragDrop;
    property OnDrawHint;
    property OnDrawText;
    property OnEditCancelled;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEndOperation;
    property OnEnter;
    property OnExit;
    property OnExpanded;
    property OnExpanding;
    property OnFocusChanged;
    property OnFocusChanging;
    property OnFreeNode;
    property OnGetCellText;
    property OnGetCellIsEmpty;
    property OnGetCursor;
    property OnGetHeaderCursor;
    property OnGetText;
    property OnPaintText;
    property OnGetHelpContext;
    property OnGetHintKind;
    property OnGetHintSize;
    property OnGetImageIndex;
    property OnGetImageIndexEx;
    property OnGetImageText;
    property OnGetHint;
    property OnGetLineStyle;
    property OnGetNodeDataSize;
    property OnGetPopupMenu;
    property OnGetUserClipboardFormats;
    property OnHeaderAddPopupItem;
    property OnHeaderClick;
    property OnHeaderDblClick;
    property OnHeaderDragged;
    property OnHeaderDraggedOut;
    property OnHeaderDragging;
    property OnHeaderDraw;
    property OnHeaderDrawQueryElements;
    property OnHeaderHeightDblClickResize;
    property OnHeaderHeightTracking;
    property OnHeaderMouseDown;
    property OnHeaderMouseMove;
    property OnHeaderMouseUp;
    property OnHotChange;
    property OnIncrementalSearch;
    property OnInitChildren;
    property OnInitNode;
    property OnKeyAction;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLoadNode;
    property OnLoadTree;
    property OnMeasureItem;
    property OnMeasureTextWidth;
    property OnMeasureTextHeight;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnNewText;
    property OnNodeClick;
    property OnNodeCopied;
    property OnNodeCopying;
    property OnNodeDblClick;
    property OnNodeExport;
    property OnNodeHeightDblClickResize;
    property OnNodeHeightTracking;
    property OnNodeMoved;
    property OnNodeMoving;
    property OnPaintBackground;
    property OnPrepareButtonBitmaps;
    property OnRemoveFromSelection;
    property OnRenderOLEData;
    property OnResetNode;
    property OnResize;
    property OnSaveNode;
    property OnSaveTree;
    property OnScroll;
    property OnShortenString;
    property OnShowScrollBar;
    property OnBeforeGetCheckState;
    property OnStartDock;
    property OnStartDrag;
    property OnStartOperation;
    property OnStateChange;
    property OnStructureChange;
    property OnUpdating;
    property OnCanResize;
    property OnGesture;
    property Touch;
    property OnColumnHeaderSpanning;
  end;

//----------------------------------------------------------------------------------------------------------------------

implementation

uses
  System.TypInfo,              // for migration stuff
  System.StrUtils,
  System.Types,                // prevent inline compiler warning
  System.UITypes,              // prevent inline compiler warning
  VirtualTrees.StyleHooks,
  VirtualTrees.ClipBoard,
  VirtualTrees.Utils,
  VirtualTrees.Export,
  VirtualTrees.EditLink,
  VirtualTrees.BaseAncestorVcl;  {to eliminate H2443 about inline expanding}

const
  cDefaultText = 'Node';
  RTLFlag: array[Boolean] of Integer = (0, ETO_RTLREADING);
  AlignmentToDrawFlag: array[TAlignment] of Cardinal = (DT_LEFT, DT_RIGHT, DT_CENTER);
  gInitialized: Integer = 0;           // >0 if global structures have been initialized; otherwise 0

//// initialization of stuff global to the unit
procedure InitializeGlobalStructures();
begin
  if (gInitialized > 0) or (AtomicIncrement(gInitialized) <> 1) then // Ensure threadsafe that this code is executed only once
    Exit;

  // Clipboard format registration.
  // Specialized string tree formats.
  CF_HTML :=       RegisterVTClipboardFormat(CFSTR_HTML, TCustomVirtualStringTree, 80);
  CF_VRTFNOOBJS := RegisterVTClipboardFormat(CFSTR_RTFNOOBJS, TCustomVirtualStringTree, 84);
  CF_VRTF :=       RegisterVTClipboardFormat(CFSTR_RTF, TCustomVirtualStringTree, 85);
  CF_CSV :=        RegisterVTClipboardFormat(CFSTR_CSV, TCustomVirtualStringTree, 90);
  // Predefined clipboard formats. Just add them to the internal list.
  RegisterVTClipboardFormat(CF_TEXT, TCustomVirtualStringTree, 100);
  RegisterVTClipboardFormat(CF_UNICODETEXT, TCustomVirtualStringTree, 95);
end;


//----------------- TCustomVirtualString -------------------------------------------------------------------------------

constructor TCustomVirtualStringTree.Create(AOwner: TComponent);
begin
  InitializeGlobalStructures();
  inherited;
  FPreviouslySelected := nil;
  FDefaultText := cDefaultText;
  FInternalDataOffset := AllocateInternalDataArea(SizeOf(Cardinal));

  // Modified by ichin 2024-05-30 목 오전 5:00:59
  SelectedBrushColor := TColors.DarkSlateBlue;
  FNode_HeaderColor := TColors.SysBtnFace;;
  FNode_BodyColor := TColor($7FFF00);
  FNode_FooterColor := TColors.Silver;
  FOffsetWRMagin := 30;
  FNodeHeightOffSet := 15;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.GetRenderStartValues(Source: TVSTTextSourceType; var Node: PVirtualNode; var NextNodeProc: TGetNextNodeProc);
begin
  case Source of
    tstInitialized:
      begin
        Node := GetFirstInitialized;
        NextNodeProc := GetNextInitialized;
      end;
    tstSelected:
      begin
        Node := GetFirstSelected;
        NextNodeProc := GetNextSelected;
      end;
    tstCutCopySet:
      begin
        Node := GetFirstCutCopy;
        NextNodeProc := GetNextCutCopy;
      end;
    tstVisible:
      begin
        Node := GetFirstVisible(nil, True);
        NextNodeProc := GetNextVisible;
      end;
    tstChecked:
      begin
        Node := GetFirstChecked;
        NextNodeProc := GetNextChecked;
      end;
  else // tstAll
    Node := GetFirst;
    NextNodeProc := GetNext;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.GetDataFromGrid(const AStrings: TStringList; const IncludeHeading: Boolean);
begin
  { Start from the First column. }
  var _StartIndex: Integer := 0;
  var _AddString: string := '';
  { Do it for Header first }
  if IncludeHeading then
  begin
    _AddString := EmptyStr;
    for var _ColIndex := _StartIndex to Pred(Header.Columns.Count) do
    begin
      if (_ColIndex > _StartIndex) then
        _AddString := _AddString + ',';
      _AddString := _AddString + AnsiQuotedStr(Header.Columns.Items[_ColIndex].Text, '"');
    end;
    AStrings.Add(_AddString);
  end;

  { Loop thru the virtual tree for Data }
  var _ChildNode: PVirtualNode := GetFirst;
  var _CellText: string := '';
  while Assigned(_ChildNode) do
  begin
    _AddString := EmptyStr;

    { Read for each column and then populate the text }
    for var _ColIndex := _StartIndex to Pred(Header.Columns.Count) do
    begin
      _CellText := Text[_ChildNode, _ColIndex];
      if (_CellText = EmptyStr) then
        _CellText := ' ';
      if (_ColIndex > _StartIndex) then
        _AddString := _AddString + ',';
      _AddString := _AddString + AnsiQuotedStr(_CellText, '"');
    end;

    AStrings.Add(_AddString);
    _ChildNode := _ChildNode.NextSibling;
  end;
end;

function TCustomVirtualStringTree.GetImageText(Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex): string;
begin
  Assert(Assigned(Node), 'Node must not be nil.');

  if not (vsInitialized in Node.States) then
    InitNode(Node);
  Result := '';

  DoGetImageText(Node, Kind, Column, Result);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.GetOptions: TCustomStringTreeOptions;
begin
  Result := inherited TreeOptions as TCustomStringTreeOptions;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.GetStaticText(Node: PVirtualNode; Column: TColumnIndex): string;
begin
  Assert(Assigned(Node), 'Node must not be nil.');
  var _EventArgs: TVSTGetCellTextEventArgs := TVSTGetCellTextEventArgs.Create(Node, Column);
  DoGetText(_EventArgs);
  Exit(_EventArgs.StaticText);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.InitializeTextProperties(var PaintInfo: TVTPaintInfo);
// Initializes default values for customization in PaintNormalText.
begin
  with PaintInfo do
  begin
    // Set default font values first.
    Canvas.Font.Assign(Font);
    if Enabled then // Otherwise only those colors are used, which are passed from Font to Canvas.Font.
      Canvas.Font.Color := Colors.NodeFontColor
    else
      Canvas.Font.Color := Colors.DisabledColor;

    if (toHotTrack in TreeOptions.PaintOptions) and (Node = HotNode) then
    begin
      if not (tsUseExplorerTheme in TreeStates) then
      begin
        Canvas.Font.Style := Canvas.Font.Style + [TFontStyle.fsUnderline];
        Canvas.Font.Color := Colors.HotColor;
      end;
    end;

    // Change the font color only if the node also is drawn in selected style.
    if poDrawSelection in PaintOptions then
    begin
      if (Column = FocusedColumn) or (toFullRowSelect in TreeOptions.SelectionOptions) then
      begin
        if Node = DropTargetNode then
          begin
            if ((LastDropMode = dmOnNode) or (vsSelected in Node.States)) then
            Canvas.Font.Color := Colors.GetSelectedNodeFontColor(True); // See #1083, since drop highlight color is chosen independent of the focus state, we need to choose Font color also independent of it.
          end
        else
          if vsSelected in Node.States then
          begin
            Canvas.Font.Color := Colors.GetSelectedNodeFontColor(Focused or (toPopupMode in TreeOptions.PaintOptions));
          end;
      end;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.PaintStaticText(const PaintInfo: TVTPaintInfo; pStaticTextAlignment: TAlignment; const Text: string);
// This method retrives and draws the static text bound to a particular node.
begin
  with PaintInfo do
  begin
    Canvas.Font.Assign(Font);
    if toFullRowSelect in TreeOptions.SelectionOptions then
    begin
      if Node = DropTargetNode then
        begin
          if (LastDropMode = dmOnNode) or (vsSelected in Node.States) then
            Canvas.Font.Color := Colors.GetSelectedNodeFontColor(Focused or (toPopupMode in TreeOptions.PaintOptions))
          else
            Canvas.Font.Color := Colors.NodeFontColor;
        end
      else
        if vsSelected in Node.States then
        begin
          if Focused or (toPopupMode in TreeOptions.PaintOptions) then
            Canvas.Font.Color := Colors.GetSelectedNodeFontColor(Focused or (toPopupMode in TreeOptions.PaintOptions))
          else
            Canvas.Font.Color := Colors.NodeFontColor;
        end;
    end;

    Canvas.TextFlags := 0;
    DoPaintText(Node, Canvas, Column, ttStatic);

    // Disabled node color overrides all other variants.
    if (vsDisabled in Node.States) or not Enabled then
      Canvas.Font.Color := Colors.DisabledColor;

    var _DrawFormat: Cardinal := DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE;
    var _R: TRect := ContentRect;
    if pStaticTextAlignment = taRightJustify then
      begin
        _DrawFormat := _DrawFormat or DT_RIGHT;
        Dec(_R.Right, TextMargin);
        if PaintInfo.Alignment = taRightJustify then
          Dec(_R.Right, NodeWidth); // room for node text
      end
    else
      begin
        Inc(_R.Left, TextMargin);
        if PaintInfo.Alignment = taLeftJustify then
          Inc(_R.Left, NodeWidth); // room for node text
      end;

    if Canvas.TextFlags and ETO_OPAQUE = 0 then
      SetBkMode(Canvas.Handle, TRANSPARENT)
    else
      SetBkMode(Canvas.Handle, OPAQUE);
    Winapi.Windows.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), _R, _DrawFormat);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.ReadText(Reader: TReader);
begin
  SetDefaultText(Reader.ReadString);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.SaveToCSVFile(const FileNameWithPath: TFileName; const IncludeHeading: Boolean): Boolean;
begin
  Result := False;
  if (FileNameWithPath = '') then
    Exit;

  var _LResultList : TStringList := TStringList.Create;
  try
    { Get the data from grid. }
    GetDataFromGrid(_LResultList, IncludeHeading);
    { Save File to Disk }
    _LResultList.SaveToFile(FileNameWithPath);
    Result := True;
  finally
    FreeAndNil(_LResultList);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.SetDefaultText(const Value: string);
begin
  if FDefaultText <> Value then
  begin
    FDefaultText := Value;
    if not (csLoading in ComponentState) then
      Invalidate;
  end;
end;

procedure TCustomVirtualStringTree.SetNode_BodyColor(const Value: TColor);
begin
  if FNode_BodyColor <> Value then
  begin
    FNode_BodyColor := Value;
    Invalidate;
  end;
end;

procedure TCustomVirtualStringTree.SetNode_FooterColor(const Value: TColor);
begin
  if FNode_FooterColor <> Value then
  begin
    FNode_FooterColor := Value;
    Invalidate;
  end;
end;

procedure TCustomVirtualStringTree.SetNode_HeaderColor(const Value: TColor);
begin
  if FNode_HeaderColor <> Value then
  begin
    FNode_HeaderColor := Value;
    Invalidate;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.SetOptions(const Value: TCustomStringTreeOptions);
begin
  inherited TreeOptions.Assign(Value);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.SetText(Node: PVirtualNode; Column: TColumnIndex; const Value: string);
begin
  DoNewText(Node, Column, Value);
  InvalidateNode(Node);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.WMSetFont(var Msg: TWMSetFont);
// Whenever a new font is applied to the tree some default values are determined to avoid frequent
// determination of the same value.
begin
  inherited;

  var _MemDC: HDC := CreateCompatibleDC(0);
  var _TM: TTextMetric;
  var _Size: TSize;
  try
    SelectObject(_MemDC, Msg.Font);
    WinApi.Windows.GetTextMetrics(_MemDC, _TM);
    FTextHeight := _TM.tmHeight;

    GetTextExtentPoint32W(_MemDC, '...', 3, _Size);
    FEllipsisWidth := _Size.cx;
  finally
    DeleteDC(_MemDC);
  end;

  // Have to reset all node widths.
  var _Run: PVirtualNode := RootNode.FirstChild;
  var _Data: PInteger := nil;
  while Assigned(_Run) do
  begin
    _Data := InternalData(_Run);
    if Assigned(_Data) then
      _Data^ := 0;
    _Run := GetNextNoInit(_Run);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.AddChild(Parent: PVirtualNode; UserData: Pointer): PVirtualNode;
begin
  Result := inherited AddChild(Parent, UserData);
  // Restore the prviously restored node if the caption of this node is knwon and no other node was selected
  if (toRestoreSelection in TreeOptions.SelectionOptions) and Assigned(FPreviouslySelected) and Assigned(OnGetText) then
  begin
    var _NewNodeText: string := '';
    // See if this was the previously selected node and restore it in this case
    Self.OnGetText(Self, Result, Header.RestoreSelectionColumnIndex, ttNormal, _NewNodeText);
    if FPreviouslySelected.IndexOf(_NewNodeText) >= 0 then
    begin
      // Select this node and make sure that the parent node is expanded
      TreeStates:= TreeStates + [tsPreviouslySelectedLocked];
      try
        Self.Selected[Result] := True;
      finally
        TreeStates:= TreeStates - [tsPreviouslySelectedLocked];
      end;
      // if a there is a selected node now, then make sure that it is visible
      if (Self.GetFirstSelected <> nil) then
        Self.FullyVisible[Self.GetFirstSelected]:= True;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

// Deprecated for Only One Column ...
procedure TCustomVirtualStringTree.AdjustPaintCellRect(var PaintInfo: TVTPaintInfo; var NextNonEmpty: TColumnIndex);
begin
  inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.CalculateStaticTextWidth(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string): TDimension;
begin
  Result := 0;
  if (Length(Text) > 0) and (Alignment <> taCenter) and not (vsMultiline in Node.States) then
  begin
    DoPaintText(Node, Canvas, Column, ttStatic);

    Inc(Result, DoTextMeasuring(Canvas, Node, Column, Text).cx);
    Inc(Result, TextMargin);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.CalculateTextWidth(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string): TDimension;
// Determines the width of the given text.
begin
  Result := 2 * TextMargin;
  if Length(Text) > 0 then
  begin
    Canvas.Font.Assign(Self.Font);
    DoPaintText(Node, Canvas, Column, ttNormal);

    Inc(Result, DoTextMeasuring(Canvas, Node, Column, Text).cx);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ColumnIsEmpty(Node: PVirtualNode; Column: TColumnIndex): Boolean;
// For hit tests it is necessary to consider cases where columns are empty and automatic column spanning is enabled.
// This method simply checks the given column's text and if this is empty then the column is considered as being empty.
begin
  Result := Length(Text[Node, Column]) = 0;
  // If there is no text then let the ancestor decide if the column is to be considered as being empty
  // (e.g. by asking the application). If there is text then the column is never be considered as being empty.
  if Result then
    Result := inherited ColumnIsEmpty(Node, Column);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.DefineProperties(Filer: TFiler);
begin
  inherited;

  // For backwards compatiblity
  Filer.DefineProperty('WideDefaultText', ReadText, nil, False);
  // Delphi does never store an empty string unless we define the property in code.
  Filer.DefineProperty('DefaultText', ReadText, WriteText, IsDefaultTextStored);
  Filer.DefineProperty('StringOptions', ReadOldStringOptions, nil, False);
end;

//----------------------------------------------------------------------------------------------------------------------

destructor TCustomVirtualStringTree.Destroy;
begin
  FreeAndNil(FPreviouslySelected);
  inherited;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.DoAddToSelection(Node: PVirtualNode);
begin
  inherited;
  if (toRestoreSelection in TreeOptions.SelectionOptions) and Assigned(Self.OnGetText) and not (tsPreviouslySelectedLocked in TreeStates) then
  begin
    if not Assigned(FPreviouslySelected) then
    begin
      FPreviouslySelected := TStringList.Create();
      FPreviouslySelected.Duplicates := dupIgnore;
      FPreviouslySelected.Sorted := True; //Improves performance, required to use Find()
      FPreviouslySelected.CaseSensitive := False;
    end;
    if Self.SelectedCount = 1 then
      FPreviouslySelected.Clear();
    var _SelectedNodeCaption: string := '';
    Self.OnGetText(Self, Node, Header.RestoreSelectionColumnIndex, ttNormal, _SelectedNodeCaption);
    FPreviouslySelected.Add(_SelectedNodeCaption);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.DoCreateEditor(Node: PVirtualNode; Column: TColumnIndex): IVTEditLink;
begin
  Result := inherited DoCreateEditor(Node, Column);
  // Enable generic label editing support if the application does not have own editors.
  if Result = nil then
    Result := TStringEditLink.Create;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.DoGetNodeHint(Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle): string;
begin
  Result := inherited DoGetNodeHint(Node, Column, LineBreakStyle);
  if Assigned(FOnGetHint) then
    FOnGetHint(Self, Node, Column, LineBreakStyle, Result);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.DoGetNodeTooltip(Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle): string;
begin
  Result := inherited DoGetNodeToolTip(Node, Column, LineBreakStyle);
  if Assigned(FOnGetHint) then
    FOnGetHint(Self, Node, Column, LineBreakStyle, Result)
  else
    Result := Text[Node, Column];
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.DoGetNodeExtraWidth(Node: PVirtualNode; Column: TColumnIndex; Canvas: TCanvas = nil): TDimension;
begin
  if not (toShowStaticText in TreeOptions.StringOptions) then
    Exit(0);
  if Canvas = nil then
    Canvas := Self.Canvas;
  Result := CalculateStaticTextWidth(Canvas, Node, Column, StaticText[Node, Column]);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.DoGetNodeWidth(Node: PVirtualNode; Column: TColumnIndex; Canvas: TCanvas = nil): TDimension;
begin
  Result := Header.Columns[Column].Width
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.DoIncrementalSearch(Node: PVirtualNode; const Text: string): Integer;
// Since the string tree has access to node text it can do incremental search on its own. Use the event to
// override the default behavior.
begin
  Result := 0;
  if Assigned(OnIncrementalSearch) then
    OnIncrementalSearch(Self, Node, Text, Result)
  else
    // Default behavior is to match the search string with the start of the node text.
    if not StartsText(Text, GetText(Node, FocusedColumn)) then
      Result := 1;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.DoNewText(Node: PVirtualNode; Column: TColumnIndex; const Text: string);
begin
  if Assigned(FOnNewText) then
    FOnNewText(Self, Node, Column, Text);

  // The width might have changed, so update the scrollbar.
  if UpdateCount = 0 then
    UpdateHorizontalScrollBar(True);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.GetText(Node: PVirtualNode; Column: TColumnIndex): string;
begin
  Assert(Assigned(Node), 'Node must not be nil.');
  var _EventArgs: TVSTGetCellTextEventArgs := TVSTGetCellTextEventArgs.Create(Node, Column);
  _EventArgs.CellText := FDefaultText;
  DoGetText(_EventArgs);
  Exit(_EventArgs.CellText)
end;

procedure TCustomVirtualStringTree.DoGetText(var pEventArgs: TVSTGetCellTextEventArgs);
begin
  if not (vsInitialized in pEventArgs.Node.States) then
    InitNode(pEventArgs.Node);
  if Assigned(OnGetCellText) then
    begin
      OnGetCellText(Self, pEventArgs);
    end else
  if Assigned(FOnGetText) then
    begin
      FOnGetText(Self, pEventArgs.Node, pEventArgs.Column, TVSTTextType.ttNormal, pEventArgs.CellText);
    end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.DoPaintNode(var PaintInfo: TVTPaintInfo);
// Main output routine to print the text of the given node using the space provided in PaintInfo.ContentRect.
begin
  RedirectFontChangeEvent(PaintInfo.Canvas);
  try
    // Determine main text direction as well as other text properties.
    var _TextOutFlags: Integer := ETO_CLIPPED or RTLFlag[PaintInfo.BidiMode <> bdLeftToRight];
    var _EventArgs: TVSTGetCellTextEventArgs := TVSTGetCellTextEventArgs.Create(PaintInfo.Node, PaintInfo.Column);

    _EventArgs.CellText := FDefaultText;
    //_EventArgs.StaticTextAlignment := PaintInfo.Alignment;
    DoGetText(_EventArgs);

    // Paint the normal text first...
    if not _EventArgs.CellText.IsEmpty then
      PaintNormalText(PaintInfo, _TextOutFlags, _EventArgs.CellText);
  finally
    RestoreFontChangeEvent(PaintInfo.Canvas);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.PaintNormalText(var PaintInfo: TVTPaintInfo; TextOutFlags: Integer; Text: string);
begin
  with PaintInfo do
  begin
    Canvas.Font.Assign(Self.Font);
    var _R: TRect := ContentRect;   { = CellRect ... }
    Canvas.TextFlags := 0;
    InflateRect(_R, -TextMargin, 0);

    DoPaintText(Node, Canvas, Column, ttNormal);
    var _DrawFormat: Cardinal := DT_NOPREFIX or DT_WORDBREAK or DT_TOP or AlignmentToDrawFlag[Alignment];
    if BidiMode <> bdLeftToRight then
      _DrawFormat := _DrawFormat or DT_RTLREADING;

    SetBkMode(Canvas.Handle, TRANSPARENT);
    DoTextDrawing(PaintInfo, Text, _R, _DrawFormat);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------
// Modified by ichin 2024-05-30 목 오후 8:31:47
procedure TCustomVirtualStringTree.DoTextDrawing(var PaintInfo: TVTPaintInfo; const Text: string; CellRect: TRect; DrawFormat: Cardinal);
begin
  var _DefaultDraw := True;
  var _Title: string := '';
  var _Tag: Integer := 0;
  var _TimeStamp: string := '';
  var _lavaTag: Integer := -1;
  if Assigned(FOnDrawTitle) then
    FOnDrawTitle(Self, PaintInfo.Node,  _Title, _TimeStamp, _Tag, _lavaTag);

  // ------------------------------------------------------------------------- //
  PaintInfo.Canvas.Font.Color := clBtnFace;
  // ------------------------------------------------------------------------- //
  var _Text: string := Text;
  if ((DrawFormat and DT_RIGHT) > 0) and (TFontStyle.fsItalic in PaintInfo.Canvas.Font.Style) then
    _Text := Text + ' '
  else
    _Text := Text;

  if _DefaultDraw then
    begin
      { Icon, Thumb }
      Images.Draw(PaintInfo.Canvas, CellRect.Left-13, 6, _Tag);              // Image Size = 16 x 16
      if (_Tag = 0) and (_lavaTag >= 0) and Assigned(FThumbLists) then
        FThumbLists.Draw(PaintInfo.Canvas, CellRect.Right-70, 3, _lavaTag);  // Thumb Size = 64 x 60
      { Header - Title / User / Ollama }
      var _headersize: TSize := GetHeaderTextHeight(_Title);
      var _headrect: TRect := Rect(CellRect.Left+12, 5, CellRect.Right, _headersize.cy+6);
      PaintInfo.Canvas.Font.Size  := Self.Font.Size;
      PaintInfo.Canvas.Font.Color := FNode_HeaderColor;
      PaintInfo.Canvas.Font.Style := [TFontStyle.fsBold];
      Winapi.Windows.DrawTextW(PaintInfo.Canvas.Handle, PWideChar(_Title), Length(_Title), _headrect, DrawFormat);
      { Body Content / Message }
      var _bodyrect: TRect := Rect(CellRect.Left, _headrect.Bottom+5, CellRect.Right, CellRect.Bottom-10);
      PaintInfo.Canvas.Font.Color := FNode_BodyColor;
      PaintInfo.Canvas.Font.Style := [];
      Winapi.Windows.DrawTextW(PaintInfo.Canvas.Handle, PWideChar(_Text), Length(_Text), _bodyrect, DrawFormat);
      { Footer - TimeStamp }
      var _footrect: TRect := Rect(CellRect.Right - 50, CellRect.Bottom-15, CellRect.Right+12, CellRect.Bottom-3);
      PaintInfo.Canvas.Font.Color := FNode_FooterColor;
      PaintInfo.Canvas.Font.Size  := 7;   { Fix ... }
      Winapi.Windows.DrawTextW(PaintInfo.Canvas.Handle, PWideChar(_TimeStamp), Length(_TimeStamp), _footrect, DrawFormat or DT_RIGHT);
    end;
end;
//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ComputeNodeHeight(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; S: string): TDimension;
begin
  var _BidiMode: TBidiMode := Self.BidiMode;
  var _Alignment: TAlignment := Self.Alignment;

  if Column <= NoColumn then
    begin
      _BidiMode := Self.BidiMode;
      _Alignment := Self.Alignment;
    end
  else
    begin
      _BidiMode := Header.Columns[Column].BidiMode;
      _Alignment := Header.Columns[Column].Alignment;
    end;

  if _BidiMode <> bdLeftToRight then
    ChangeBidiModeAlignment(_Alignment);

  var _DrawFormat: Cardinal := DT_CALCRECT or DT_NOPREFIX or DT_TOP or DT_WORDBREAK;
  var _Calc_Rect := Rect(0, 0, 0, 0);
  var _Offsets: TVTOffsets;
  GetOffsets(Node, _Offsets, TVTElement.ofsEndOfClientArea, Column);  // *** //
  if Column > NoColumn then
  begin
    _Calc_Rect.Right := Header.Columns[Column].Width - 2 * TextMargin - FOffsetWRMagin;
    _Calc_Rect.Left := _Offsets[TVTElement.ofsLabel];    // where drawing a selection begins
  end
  else
    _Calc_Rect.Right := ClientWidth - FOffsetWRMagin;

  if BidiMode <> bdLeftToRight then
    _DrawFormat := _DrawFormat or DT_RIGHT or DT_RTLREADING
  else
    _DrawFormat := _DrawFormat or DT_LEFT;

  if Length(S) = 0 then
    S := Text[Node, Column];
  // Modified by ichin 2024-06-12 수 오후 12:17:24
  var _SS: string := 'Ollama ...'+#13#10+S+#13#10+'00:00:00';
  Winapi.Windows.DrawTextW(Canvas.Handle, PWideChar(_SS), Length(_SS), _Calc_Rect, _DrawFormat);
  Result := _Calc_Rect.Bottom - _Calc_Rect.Top;
  Result := Result + FNodeHeightOffSet;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.GetHeaderTextHeight(const Text: string): TSize;
begin
  GetTextExtentPoint32W(Canvas.Handle, PWideChar(Text), Length(Text), Result);

  var _DrawFormat: Integer := DT_CALCRECT or DT_NOPREFIX or DT_WORDBREAK or AlignmentToDrawFlag[Alignment];
  if BiDiMode <> bdLeftToRight then
    _DrawFormat := _DrawFormat or DT_RTLREADING;

  var _R: TRect := Rect(0, 0, Result.cx, MaxInt);
  Winapi.Windows.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), _R, _DrawFormat);
  Result.cx := _R.Right - _R.Left;
end;

function TCustomVirtualStringTree.DoTextMeasuring(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string): TSize;
begin
  GetTextExtentPoint32W(Canvas.Handle, PWideChar(Text), Length(Text), Result);
  if vsMultiLine in Node.States then
  begin
    var _DrawFormat: Integer := DT_CALCRECT or DT_NOPREFIX or DT_WORDBREAK or AlignmentToDrawFlag[Alignment];
    if BidiMode <> bdLeftToRight then
      _DrawFormat := _DrawFormat or DT_RTLREADING;

    var _R: TRect := Rect(0, 0, Result.cx, MaxInt);
    Winapi.Windows.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), _R, _DrawFormat);
    Result.cx := _R.Right - _R.Left;
  end;
  if Assigned(FOnMeasureTextWidth) then
    FOnMeasureTextWidth(Self, Canvas, Node, Column, Text, Result.cx);
  if Assigned(FOnMeasureTextHeight) then
    FOnMeasureTextHeight(Self, Canvas, Node, Column, Text, Result.cy);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.DoShortenString(Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const S: string; Width: TDimension; EllipsisWidth: TDimension = 0): string;
begin
  var _Done: Boolean := False;
  if Assigned(FOnShortenString) then
    FOnShortenString(Self, Canvas, Node, Column, S, Width, Result, _Done);
  if not _Done then
    Result := ShortenString(Canvas.Handle, S, Width, EllipsisWidth);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.GetOptionsClass: TTreeOptionsClass;
begin
  Result := TCustomStringTreeOptions;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.InternalData(Node: PVirtualNode): Pointer;
begin
  if (Node = nil) or (FInternalDataOffset = 0) then
    Result := nil else
  if Node = RootNode then
    Result := PByte(Node) + FInternalDataOffset
  else
    Result := PByte(Node) + Self.NodeDataSize + FInternalDataOffset;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.MainColumnChanged;
begin
  inherited;

  // Have to reset all node widths.
  var _Run: PVirtualNode := RootNode.FirstChild;
  var _Data: PInteger := nil;
  while Assigned(_Run) do
  begin
    _Data := InternalData(_Run);
    if Assigned(_Data) then
      _Data^ := 0;
    _Run := GetNextNoInit(_Run);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ReadChunk(Stream: TStream; Version: Integer; Node: PVirtualNode; ChunkType, ChunkSize: Integer): Boolean;
// read in the caption chunk if there is one
begin
  case ChunkType of
    CaptionChunk:
      begin
        var _NewText: string := '';
        if ChunkSize > 0 then
        begin
          SetLength(_NewText, ChunkSize div 2);
          Stream.Read(PWideChar(_NewText)^, ChunkSize);
        end;
        // Do a new text event regardless of the caption content to allow removing the default string.
        Text[Node, Header.MainColumn] := _NewText;
        Result := True;
      end;
  else
    Result := inherited ReadChunk(Stream, Version, Node, ChunkType, ChunkSize);
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

type
  TOldVTStringOption = (soSaveCaptions, soShowStaticText);

procedure TCustomVirtualStringTree.ReadOldStringOptions(Reader: TReader);
// Migration helper routine to silently convert forms containing the old tree options member into the new
// sub-options structure.
begin
  // If we are at design time currently then let the designer know we changed something.
  UpdateDesigner;

  // It should never happen at this place that there is something different than the old set.
  if Reader.ReadValue = vaSet then
    with TreeOptions do
    begin
      // Remove all default values set by the constructor.
      StringOptions := [];
      var _OldOption: TOldVTStringOption := soSaveCaptions;
      var _EnumName: string := '';

      while True do
      begin
        // Sets are stored with their members as simple strings. Read them one by one and map them to the new option
        // in the correct sub-option set.
        _EnumName := Reader.ReadStr;
        if _EnumName = '' then
          Break;
        _OldOption := TOldVTStringOption(GetEnumValue(TypeInfo(TOldVTStringOption), _EnumName));
        case _OldOption of
          soSaveCaptions:
            StringOptions := StringOptions + [toSaveCaptions];
          soShowStaticText:
            StringOptions := StringOptions + [toShowStaticText];
        end;
      end;
    end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.RenderOLEData(const FormatEtcIn: TFormatEtc; out Medium: TStgMedium; ForClipboard: Boolean): HResult;
// Returns string expressions of all currently selected nodes in the Medium structure.
begin
  Result := inherited RenderOLEData(FormatEtcIn, Medium, ForClipboard);
  if Failed(Result) then
  try
    if ForClipboard then
      Medium.hGlobal := ContentToClipboard(FormatEtcIn.cfFormat, tstCutCopySet)
    else
      Medium.hGlobal := ContentToClipboard(FormatEtcIn.cfFormat, tstSelected);

    // Fill rest of the Medium structure if rendering went fine.
    if Medium.hGlobal <> 0 then
    begin
      Medium.tymed := TYMED_HGLOBAL;
      Medium.unkForRelease := nil;

      Result := S_OK;
    end;
  except
    Result := E_FAIL;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.WriteChunks(Stream: TStream; Node: PVirtualNode);
// Adds another sibling chunk for Node storing the label if the node is initialized.
// Note: If the application stores a node's caption in the node's data member (which will be quite common) and needs to
//       store more node specific data then it should use the OnSaveNode event rather than the caption autosave function
//       (take out soSaveCaption from StringOptions). Otherwise the caption is unnecessarily stored twice.
begin
  inherited;
  if (toSaveCaptions in TreeOptions.StringOptions) and (Node <> RootNode) and
     (vsInitialized in Node.States) then
  with Stream do
    begin
      // Read the node's caption (primary column only).
      var _S: string := Text[Node, Header.MainColumn];
      var _Len: Integer := 2 * Length(_S);
      if _Len > 0 then
      begin
        var ChunkHeader: TChunkHeader;
        // Write a new sub chunk.
        ChunkHeader.ChunkType := CaptionChunk;
        ChunkHeader.ChunkSize := _Len;
        Write(ChunkHeader, SizeOf(ChunkHeader));
        Write(PWideChar(_S)^, _Len);
      end;
    end;
end;

procedure TCustomVirtualStringTree.WriteText(Writer: TWriter);
begin
  Writer.WriteString(DefaultText);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ContentToClipboard(Format: Word; Source: TVSTTextSourceType): HGLOBAL;
// This method constructs a shareable memory object filled with string data in the required format. Supported are:
// CF_TEXT - plain ANSI text (Unicode text is converted using the user's current locale)
// CF_UNICODETEXT - plain Unicode text
// CF_CSV - comma separated plain ANSI text
// CF_VRTF + CF_RTFNOOBS - rich text (plain ANSI)
// CF_HTML - HTML text encoded using UTF-8
//
// Result is the handle to a globally allocated memory block which can directly be used for clipboard and drag'n drop
// transfers. The caller is responsible for freeing the memory. If for some reason the content could not be rendered
// the Result is 0.
begin
  Result := VirtualTrees.Export.ContentToClipboard(Self, Format, Source);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ContentToHTML(Source: TVSTTextSourceType; const Caption: string = ''): String;
// Renders the current tree content (depending on Source) as HTML text encoded in UTF-8.
// If Caption is not empty then it is used to create and fill the header for the table built here.
// Based on ideas and code from Frank van den Bergh and Andreas Hörstemeier.
begin
  Result := VirtualTrees.Export.ContentToHTML(Self, Source, Caption);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.CanExportNode(Node: PVirtualNode): Boolean;
begin
  case TreeOptions.ExportMode of
    emChecked:
      Result := CheckState[Node] = csCheckedNormal;
    emUnchecked:
      Result := CheckState[Node] = csUncheckedNormal;
    emVisibleDueToExpansion: //Do not export nodes that are not visible because their parent is not expanded
      Result := not Assigned(Node.Parent) or Self.Expanded[Node.Parent];
    emSelected: // export selected nodes only
      Result := Selected[Node];
    else
      Result := True;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.RemoveFromSelection(Node: PVirtualNode);
begin
  inherited;
  if (toRestoreSelection in TreeOptions.SelectionOptions) and Assigned(FPreviouslySelected) and not Self.Selected[Node] then
  begin
    if Self.SelectedCount = 0 then
      FPreviouslySelected.Clear()
    else
      begin
        var _SelectedNodeCaption: string := '';
        var _Index: Integer := 0;
        Self.OnGetText(Self, Node, Header.RestoreSelectionColumnIndex, ttNormal, _SelectedNodeCaption);
        if FPreviouslySelected.Find(_SelectedNodeCaption, _Index) then
          FPreviouslySelected.Delete(_Index);
      end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ContentToRTF(Source: TVSTTextSourceType): RawByteString;
// Renders the current tree content (depending on Source) as RTF (rich text).
// Based on ideas and code from Frank van den Bergh and Andreas Hörstemeier.
begin
  Result := VirtualTrees.Export.ContentToRTF(Self, Source);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.ContentToCustom(Source: TVSTTextSourceType);
// Generic export procedure which polls the application at every stage of the export.
begin
  VirtualTrees.Export.ContentToCustom(Self, Source);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ContentToText(Source: TVSTTextSourceType; Separator: Char): String;
begin
  Result := ContentToText(Source, string(Separator));
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ContentToUnicode(Source: TVSTTextSourceType; Separator: Char): string;
begin
  Result := Self.ContentToText(Source, string(Separator));
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.ContentToText(Source: TVSTTextSourceType; const Separator: string): string;
// Renders the current tree content (depending on Source) as Unicode text.
// If an entry contains the separator char then it is wrapped with double quotation marks.
begin
  Result := VirtualTrees.Export.ContentToUnicodeString(Self, Source, Separator);
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.GetTextInfo(Node: PVirtualNode; Column: TColumnIndex; const AFont: TFont; var R: TRect; var Text: string);
// Returns the font, the text and its bounding rectangle to the caller. R is returned as the closest
// bounding rectangle around Text.
begin
  // Get default font and initialize the other parameters.
  inherited GetTextInfo(Node, Column, AFont, R, Text);

  Canvas.Font.Assign(AFont);

  FFontChanged := False;
  RedirectFontChangeEvent(Canvas);
  DoPaintText(Node, Canvas, Column, ttNormal);
  var _NewHeight: TDimension := FTextHeight;
  if FFontChanged then
  begin
    var _TM: TTextMetric;
    AFont.Assign(Canvas.Font);
    GetTextMetrics(Canvas, _TM);
    _NewHeight := _TM.tmHeight;
  end
  else // Otherwise the correct font is already there and we only need to set the correct height.
    _NewHeight := FTextHeight;
  RestoreFontChangeEvent(Canvas);

  // Alignment to the actual text.
  Text := Self.Text[Node, Column];
  R := GetDisplayRect(Node, Column, True, not (vsMultiline in Node.States));
  if toShowHorzGridLines in TreeOptions.PaintOptions then
    Dec(R.Bottom);
  InflateRect(R, 0, -Divide(R.Bottom - R.Top - _NewHeight, 2));
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.InvalidateNode(Node: PVirtualNode): TRect;
begin
  Result := inherited InvalidateNode(Node);
  // Reset node width so changed text attributes are applied correctly.
  var _Data: PInteger := InternalData(Node);
  if Assigned(_Data) then
    _Data^ := 0;
end;

function TCustomVirtualStringTree.IsDefaultTextStored: Boolean;
begin
  Exit(DefaultText <> cDefaultText);
end;

//----------------------------------------------------------------------------------------------------------------------

function TCustomVirtualStringTree.Path(Node: PVirtualNode; Column: TColumnIndex; Delimiter: Char): string;
// Constructs a string containing the node and all its parents. The last character in the returned path is always the
// given delimiter.
begin
  if (Node = nil) or (Node = RootNode) then
    Result := Delimiter
  else
  begin
    Result := '';
    while Node <> RootNode do
    begin
      Result := Text[Node, Column] + Delimiter + Result;
      Node := Node.Parent;
    end;
  end;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.ResetInternalData(Node: PVirtualNode; Recursive: Boolean);
begin
  // Reset node width so changed text attributes are applied correctly.
  if Assigned(Node) and (Node <> RootNode) then
  begin
    var _Data: PInteger := InternalData(Node);
    if Assigned(_Data) then
      _Data^ := 0;
  end;

  if Recursive then
  begin
    var _Run: PVirtualNode := nil;
    if Assigned(Node) then
      _Run := Node.FirstChild
    else
      _Run := RootNode.FirstChild;

    while Assigned(_Run) do
    begin
      ResetInternalData(_Run, Recursive);
      _Run := _Run.NextSibling;
    end;
  end;//if Recursive
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.ReinitNode(Node: PVirtualNode; Recursive: Boolean; ForceReinit: Boolean = False);
begin
  inherited;
  ResetInternalData(Node, False);  // False because we are already in a loop inside ReinitNode
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TCustomVirtualStringTree.SetChildCount(Node: PVirtualNode; NewChildCount: Cardinal);
begin
  inherited;
  ResetInternalData(Node, False);
end;

//----------------- TVirtualStringTree ---------------------------------------------------------------------------------

function TVirtualStringTree.GetOptions: TStringTreeOptions;
begin
  Result := inherited TreeOptions as TStringTreeOptions;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TVirtualStringTree.SetOptions(const Value: TStringTreeOptions);
begin
  inherited TreeOptions.Assign(Value);
end;

//----------------------------------------------------------------------------------------------------------------------

function TVirtualStringTree.GetOptionsClass: TTreeOptionsClass;
begin
  Result := TStringTreeOptions;
end;

{ TVSTGetCellTextEventArgs }

//----------------------------------------------------------------------------------------------------------------------

constructor TVSTGetCellTextEventArgs.Create(pNode: PVirtualNode; pColumn: TColumnIndex; pExportType: TVTExportType);
begin
  Self.Node := pNode;
  Self.Column := pColumn;
  Self.ExportType := pExportType;
end;

initialization
  TCustomStyleEngine.RegisterStyleHook(TVirtualStringTree, TVclStyleScrollBarsHook);

finalization
  TCustomStyleEngine.UnRegisterStyleHook(TVirtualStringTree, TVclStyleScrollBarsHook);

end.
