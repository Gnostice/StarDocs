{
 Gnostice StarDocs v2
 Copyright © 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
 http://www.gnostice.com
}

unit gtxStarDocsSDK;

interface

uses
  Classes,
  Generics.Collections,
  Diagnostics,
  TypInfo,
  SysUtils,
  IdURI,
  Graphics,
  RestRequest,
  REST.Json;

type
  TgtxConnectionInfo = class;
  TgtxPreferences = class;
  TgtxAuth = class;
  TgtxStorage = class;
  TgtxDocOperations = class;
  TgtxRemoteFileUri = class;
  TgtxFileObject = class;
  TgtxDocObject = class;
  TgtxGetDocumentInfoResponse = class;
  TgtxAuthResponse = class;
  TgtxRestAPIResponseAuth = class;
  TgtxRestAPIResponseAuthFailure = class;
  TgtxRestAPIDocumentCommon = class;
  TgtxRestAPIResponseError = class;
  TgtxRestAPIResponseGetDocumentInfo = class;
  TgtxRestAPIResponseGetPropertiesPDF = class;
  TgtxPageRangeSettings = class;
  TgtxPageSeparator = class;
  TgtxEncoderSettings = class;
  TgtxDPI = class;
  TgtxSize = class;
  TgtxCanvasSize = class;
  TgtxContentAlignment = class;
  TgtxImageEncoderSettings = class;
  TgtxPDFPortfolioSettings = class;
  TgtxPDFEncoderSettings = class;
  TgtxSearchText = class;
  TgtxColor = class;
  TgtxFont = class;
  TgtxRedactFillSettings = class;
  TgtxOutline = class;
  TgtxFillRect = class;
  TgtxFillText = class;
  TgtxPen = class;
  // TgtxGetPropertiesResponse = class;
  // TgtxDocProperties = class;
  TgtxDocErrorDetails = class;
  TgtxRestAPIResponseCreateView = class;
  TgtxViewResponse = class;
  TgtxVisibleNavigationControls = class;
  TgtxVisibleZoomControls = class;
  TgtxVisibleRotationControls = class;
  TgtxVisibleColorInversionControls = class;
  TgtxSearchControls = class;
  TgtxViewerSettings = class;
  TgtxViewer = class;
  TgtxPDFFormFieldFillData = class;

  TgtxStarDocsSDK = class(TComponent)
  private
    FConnectionInfo: TgtxConnectionInfo;
    FPreferences: TgtxPreferences;
    FAuthResponse: TgtxAuthResponse;
    FAuth: TgtxAuth;
    FStorage: TgtxStorage;
    FDocOperations: TgtxDocOperations;
    FViewer: TgtxViewer;
    function GetDocUri(AFile: TgtxFileObject): string;
    function IssueGetRequestAndPoll(AUrl: string): string;
    function IssuePostPutRequestAndPoll(AUrl: string; APost: Boolean;
      AJsonStr: string): string;
    function EncodeJsonDocuments(ADocUris: TStringList; APasswords: TStringList;
      APageRanges: TObjectList<TgtxPageRangeSettings>): string;
    function GetAuth: TgtxAuth;
    procedure SetAuth(const AValue: TgtxAuth);
    function GetStorage: TgtxStorage;
    procedure SetStorage(const AValue: TgtxStorage);
    function GetDocOperations: TgtxDocOperations;
    procedure SetDocOperations(const AValue: TgtxDocOperations);
    function GetViewer: TgtxViewer;
    procedure SetViewer(const AValue: TgtxViewer);
    function GetConnectionInfo: TgtxConnectionInfo;
    procedure SetConnectionInfo(const AValue: TgtxConnectionInfo);
    function GetPreferences: TgtxPreferences;
    procedure SetPreferences(const AValue: TgtxPreferences);
  public
    property AuthResponse: TgtxAuthResponse read FAuthResponse
      write FAuthResponse;
    property Auth: TgtxAuth read GetAuth write SetAuth;
    property Storage: TgtxStorage read GetStorage write SetStorage;
    property DocOperations: TgtxDocOperations read GetDocOperations
      write SetDocOperations;
    property Viewer: TgtxViewer read GetViewer write SetViewer;
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AConnectionInfo: TgtxConnectionInfo;
      APreferences: TgtxPreferences); reintroduce; overload;
    destructor Destroy; override;
  published
    property ConnectionInfo: TgtxConnectionInfo read GetConnectionInfo
      write SetConnectionInfo;
    property Preferences: TgtxPreferences read GetPreferences
      write SetPreferences;
  end;

  TgtxConnectionInfo = class(TPersistent)
  private
    FApiServerVersion: string;
    FApiServerUri: TIdURI;
    FAppKey: string;
    FAppSecret: string;
    FServerTimeout: Integer;
    FDocOperationTimeout: Integer;
    FPollInterval: Integer;
  public
    constructor Create(AUri: TIdURI; AAppKey: string; AAppSecret: string;
      AServerTimeout: Integer = -1; ADocOperationTimeout: Integer = -1);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

  published
    property ApiServerUri: TIdURI read FApiServerUri write FApiServerUri;
    property AppKey: string read FAppKey write FAppKey;
    property AppSecret: string read FAppSecret write FAppSecret;
    property ApiServerVersion: string read FApiServerVersion
      write FApiServerVersion;
    property ServerTimeout: Integer read FServerTimeout write FServerTimeout;
    property DocOperationTimeout: Integer read FDocOperationTimeout
      write FDocOperationTimeout;
    property PollInterval: Integer read FPollInterval write FPollInterval;
  end;

  TgtxDocPasswordSettings = class(TPersistent)
  private
    FForceFullPermission: Boolean;
  public
    constructor Create(AForceFullPermission: Boolean);

  published
    procedure Assign(Source: TPersistent); override;
    property ForceFullPermission: Boolean read FForceFullPermission
      write FForceFullPermission;
  end;

  TgtxPreferences = class(TPersistent)
  private
    FDocPasswordSettings: TgtxDocPasswordSettings;

    function GetDocPasswordSettings: TgtxDocPasswordSettings;
    procedure SetDocPasswordSettings(const AValue: TgtxDocPasswordSettings);
  public
    constructor Create(ADocPasswordSettings: TgtxDocPasswordSettings);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property DocPasswordSettings: TgtxDocPasswordSettings
      read GetDocPasswordSettings write SetDocPasswordSettings;
  end;

  // Service groups
  TgtxAuth = class
  private
    FStarDocs: TgtxStarDocsSDK;
    constructor Create(AStarDocs: TgtxStarDocsSDK);
  public
    function loginApp(AEntity: string = ''): TgtxAuthResponse;
  end;

  TgtxStorage = class
  private
    FStarDocs: TgtxStarDocsSDK;
    constructor Create(AStarDocs: TgtxStarDocsSDK);
  public
    function Upload(AFileNameWithPath: string; APassword: string = '')
      : TgtxDocObject; overload;
    function Upload(AStream: TStream; AfileName: string; APassword: string = '')
      : TgtxDocObject; overload;
    procedure Download(AFile: TgtxFileObject; AFilePath: string); overload;
    procedure Download(AFile: TgtxFileObject; FOutStream: TStream); overload;
  end;

  { TgtxDocOperations }

  TgtxPDFEncryptionLevel = (pelNone, pelAES_128bit, pelRC4_128bit,
    pelRC4_40bit);
  TgtxTextSearchMode = (tsmLiteral, tsmRegex);
  TgtxDocumentItem = (ditDocumentProperties, ditBookmarks, ditBookmarkActions,
    ditAnnotations, ditAnnotationActions);
  TgtxDocumentItems = set of TgtxDocumentItem;
  TgtxRedactCleanupSetting = (rcsRemoveEmptyBookmarks,
    rcsRemoveEmptyBookmarkActions, rcsRemoveEmptyAnnotations,
    rcsRemoveEmptyAnnotationActions, rcsRemoveAffectedLinkActions);
  TgtxRedactCleanupSettings = set of TgtxRedactCleanupSetting;
  TgtxColoringMode = (cmoNone, cmUseColor);
  TgtxPenStyle = (pstSolid, pstDash, pstDashDot, pstDashDotDot);
  TgtxBrushPattern = (bptSolid, bptForwardDiagonal, bptBackwardDiagonal,
    bptCross, bptDiagonalCross, bptHorizontal, bptVertical);
  TgtxFontSelectionMode = (fsmUseFont);
  TgtxFontSizingMode = (fsmAutoFit, fsmUseFontSize);
  TgtxFontColoringMode = (fcmSource, fcmUseFontColor);
  TgtxFontStyle = (fstBold, fstItalic, fstUnderline);
  TgtxFontStyles = set of TgtxFontStyle;
  TgtxFontEffect = (fefNone);
  TgtxFontEffects = set of TgtxFontEffect;
  TgtxPDFDocPermission = (pdpAllowAccessibility, pdpAllowAssembly, pdpAllowCopy,
    pdpAllowFormFill, pdpAllowHighResPrint, pdpAllowModifyAnnotations,
    pdpAllowModifyContents, pdpAllowPrinting);
  TgtxPDFDocPermissions = set of TgtxPDFDocPermission;
  TgtxResolutionMode = (rmmUseSource, rmmUseSpecifiedDPI);
  TgtxPaperSize = (psiA2, psiA3, psiA4, psiA5, psiA6, psiCustom);
  TgtxMeasurementUnit = (munMillimeters, munCentimeters, munInches, munPicas,
    munPixels, munPoints, munTwips);
  TgtxHorizontalAlignmentType = (hatLeft, hatRight, hatCenter);
  TgtxVerticalAlignmentType = (vatTop, vatBottom, vatCenter);
  TgtxCanvasSizingMode = (csmUseSource, csmUseSpecifiedSize,
    csmUseSpecifiedRelativeSize);
  TgtxContentScaling = (cscFitWithAspect, cscStretch, cscCrop);
  TgtxTIFFCompressionType = (tctNone, tctDeflate, tctCCITT_3, tctCCITT_4,
    tctCCITT_RLE, tctEXIF_JPEG, tctJPEG, tctLZW, tctPackBits, tctZLib);
  TgtxMTIFFConversionMode = (tcmConvertToSeparateFiles, tcmConvertToSingleFile);
  TgtxPDFConversionMode = (pcmConvertToSeparateFiles, pcmConvertToSingleFile,
    pcmConvertFirstFileAndAttachRestAsOriginal,
    pcmCreateNewFileAndAttachAllAsOriginal);
  TgtxPDFPortfolioCreationMode = (pcmOff, pcmAlways, pcmWhenInputIsPortfolio,
    pcmOnlyWhenAttachmentsExist);
  TgtxPDFPortfolioInitialLayout = (pilDetails, pilTile, pilHidden);
  TgtxFontEmbeddingType = (fetNone, fetSubset, fetFull);

  TgtxDocOperations = class
  private
    FStarDocs: TgtxStarDocsSDK;
    constructor Create(AStarDocs: TgtxStarDocsSDK);
    function EncodeJsonPageRanges(APageRanges
      : TObjectList<TgtxPageRangeSettings>): string;
    function EncodeJsonSearchText(ASearchText
      : TObjectList<TgtxSearchText>): string;
    function ConvertToImage(AUrlPath: string;
      AFiles: TObjectList<TgtxFileObject>; APasswords: TStringList;
      APageRanges: TObjectList<TgtxPageRangeSettings>;
      AImageEncoderSettings: TgtxImageEncoderSettings)
      : TObjectList<TgtxDocObject>;
    function SetToCSV(ADocumentItems: TgtxDocumentItems): string; overload;
    function SetToCSV(ARedactCleanupSettings: TgtxRedactCleanupSettings)
      : string; overload;
    function SetToCSV(APDFDocPermissions: TgtxPDFDocPermissions)
      : string; overload;
    function EncodeFormFieldFillData(AformFields
      : TObjectList<TgtxPDFFormFieldFillData>): string;

  public
    { GetProperties }
    // function GetProperties(AFile: TgtxFileObject; APassword: string = ''): TgtxGetPropertiesResponse;

    { SetProperties }
    // function SetProperties(AFile: TgtxFileObject; APassword: string; AProperties: TgtxDocProperties): TgtxDocObject;

    { GetDocumentInfo }
    function GetDocumentInfo(AFile: TgtxFileObject;
      APassword: string = ''): TgtxGetDocumentInfoResponse;

    { Merge }
    function Merge(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil): TgtxDocObject;

    { Split }
    function SplitByPageRange(AFile: TgtxFileObject; APassword: string = '';
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil)
      : TObjectList<TgtxDocObject>;

    function SplitBySeparatorPage(AFile: TgtxFileObject; APassword: string = '';
      APageSeparator: TgtxPageSeparator = nil): TObjectList<TgtxDocObject>;

    { Encrypt }
    function Encrypt(AFile: TgtxFileObject; APassword: string;
      APDFEncryptionLevel: TgtxPDFEncryptionLevel = TgtxPDFEncryptionLevel.
      pelAES_128bit; ANewOpenPassword: string = '';
      ANewPermissionsPassword: string = '';
      ANewPermissions: TgtxPDFDocPermissions = []): TgtxDocObject;

    { Redact }
    function RedactText(AFile: TgtxFileObject; APassword: string;
      APageRange: TgtxPageRangeSettings; ATextSearchMode: TgtxTextSearchMode;
      ASearchText: TObjectList<TgtxSearchText>;
      AFillSettings: TgtxRedactFillSettings = nil;
      AIncludeAdditionalItems: TgtxDocumentItems = [];
      ACleanupSettings: TgtxRedactCleanupSettings = []): TgtxDocObject;

    { Convert }
    function ConvertToTIFF(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
      AImageEncoderSettings: TgtxImageEncoderSettings = nil;
      ATIFFCompressionType: TgtxTIFFCompressionType = TgtxTIFFCompressionType.
      tctDeflate): TObjectList<TgtxDocObject>;
    function ConvertToMTIFF(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
      AImageEncoderSettings: TgtxImageEncoderSettings = nil;
      ATIFFCompressionType: TgtxTIFFCompressionType = TgtxTIFFCompressionType.
      tctDeflate;
      AConversionMode: TgtxMTIFFConversionMode = TgtxMTIFFConversionMode.
      tcmConvertToSeparateFiles): TObjectList<TgtxDocObject>;
    function ConvertToJPEG(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
      AImageEncoderSettings: TgtxImageEncoderSettings = nil)
      : TObjectList<TgtxDocObject>;
    function ConvertToGIF(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
      AImageEncoderSettings: TgtxImageEncoderSettings = nil)
      : TObjectList<TgtxDocObject>;
    function ConvertToBMP(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
      AImageEncoderSettings: TgtxImageEncoderSettings = nil)
      : TObjectList<TgtxDocObject>;
    function ConvertToPNG(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
      AImageEncoderSettings: TgtxImageEncoderSettings = nil)
      : TObjectList<TgtxDocObject>;
    function ConvertToPDF(AFiles: TObjectList<TgtxFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
      APDFEncoderSettings: TgtxPDFEncoderSettings = nil;
      AConversionMode: TgtxPDFConversionMode = TgtxPDFConversionMode.
      pcmConvertToSeparateFiles): TObjectList<TgtxDocObject>;
    function FillForm(AFile: TgtxFileObject; APassword: string;
      AformFields: TObjectList<TgtxPDFFormFieldFillData>): TgtxDocObject;
  end;

  { Enumerations }
  TgtxMimeType = (mtUnrecognizable, mtApplication_pdf, mtImage_jpeg,
    mtImage_gif, mtImage_bmp, mtImage_tiff, mtImage_png,
    mtApplication_vnd_openxmlformats_officedocument_wordprocessingml_document);

  TgtxExceptionStatusCode = (escHTTPBadRequest = 400, escHTTPUnauthorized = 401,
    escHTTPNotFound = 404, escHTTPConflict = 500, escOperationFailed = 1000,
    escFileCorrupt = 1010, escPasswordRequired = 1020,
    escFileFormatNotSupported = 1030, escInsufficientRights = 1040,
    escJobNotFound = 1050, escUnexpectedResponse = 10000,
    escOperationTimedOut = 10001);

  { TgtxAuthResponse }
  TgtxAuthResponse = class
  private
    FAccessToken: string;
    FTokenType: string;
    FExpiresIn: Longint;
  public
    constructor Create(ARestAPIResponseAuth: TgtxRestAPIResponseAuth);
    property AccessToken: string read FAccessToken;
    property TokenType: string read FTokenType;
    property ExpiresIn: Longint read FExpiresIn;
  end;

  { TgtxRemoteFileUri }
  TgtxRemoteFileUri = class
  private
    FUri: TIdURI;
    procedure Assign(Source: TgtxRemoteFileUri);
  public
    constructor Create(AUri: TIdURI); overload;
    constructor Create(AUri: string); overload;
    destructor Destroy; override;
    property Uri: TIdURI read FUri;
  end;

  { TgtxFileObject }
  TgtxFileObject = class
  private
    FFileUploaded: Boolean;
    FStream: TStream;
    FStreamFileName: string;
    FRemoteFileUri: TgtxRemoteFileUri;
    FLocalFilePath: string;
    function GetFileNameFromUri: string;
    { procedure SetUploaded(AUri: string); }
    function GetStream: TStream;
    procedure SetStream(const AValue: TStream);
    function GetRemoteFileUri: TgtxRemoteFileUri;
    procedure SetRemoteFileUri(const AValue: TgtxRemoteFileUri);
  public
    constructor Create(ARemoteFileUri: TgtxRemoteFileUri); overload;
    constructor Create(AStream: TStream; AStreamFileName: string); overload;
    constructor Create(ALocalFilePath: string); overload;
    destructor Destroy; override;
    property FileUploaded: Boolean read FFileUploaded;
    property Stream: TStream read GetStream Write SetStream;
    property StreamFileName: string read FStreamFileName;
    property RemoteFileUri: TgtxRemoteFileUri read GetRemoteFileUri
      write SetRemoteFileUri;
    property LocalFilePath: string read FLocalFilePath;
  end;

  { TgtxDocObject }
  TgtxDocObject = class(TgtxFileObject)
  private
    FFileName: string;
    FFileSize: Longint;
    FExpiryTime: Longint;
    FPageCount: Integer;
    FMimeType: TgtxMimeType;
    function ParseMimeType(AMimeType: string): TgtxMimeType;
    constructor Create(AApiResponse: TgtxRestAPIDocumentCommon);
  public
    property FileName: string read FFileName;
    property FileSize: Longint read FFileSize;
    property ExpiryTime: Longint read FExpiryTime;
    property PageCount: Integer read FPageCount;
    property MimeType: TgtxMimeType read FMimeType;
  end;

  { TgtxGetDocumentInfoResponse }
  TgtxGetDocumentInfoResponse = class(TgtxDocObject)
  private
    FUnsupportedMimeTypeOrCorrupt: Boolean;
    FPasswordProtected: Boolean;
    FPasswordCorrect: Boolean;
  public
    constructor Create(AApiResponse: TgtxRestAPIResponseGetDocumentInfo);
    property UnsupportedMimeTypeOrCorrupt: Boolean read FUnsupportedMimeTypeOrCorrupt;
    property PasswordProtected: Boolean read FPasswordProtected;
    property PasswordCorrect: Boolean read FPasswordCorrect;
  end;

  {
    TgtxDocProperties
    TgtxDocProperties = class
    private
    FTitle: string;
    FAuthor: string;
    FSubject: string;
    FKeywords: TStringList;
    FCreator: string;
    function ToJson(): string;
    public
    constructor Create(ATitle, AAuthor, ASubject, AKeywords,
    ACreator: string); overload;
    constructor Create(ATitle, AAuthor, ASubject: string;
    AKeywords: TStringList; ACreator: string); overload;
    procedure Assign(Source: TgtxDocProperties);
    property Title: string read FTitle write FTitle;
    property Author: string read FAuthor write FAuthor;
    property Subject: string read FSubject write FSubject;
    property Keywords: TStringList read FKeywords write FKeywords;
    property Creator: string read FCreator write FCreator;
    end;

    TgtxPDFDocProperties
    TgtxPDFDocProperties = class(TgtxDocProperties)
    private
    FProducer: string;
    FHasExPropertySecurity: Boolean;
    constructor Create(ATitle, AAuthor, ASubject: string;
    AKeywords: TStringList; ACreator, AProducer: string;
    AHasExPropertySecurity: Boolean = False);
    public
    property Producer: string read FProducer;
    property HasExPropertySecurity: Boolean read FHasExPropertySecurity;
    end;

    TgtxGetPropertiesResponse

    TgtxGetPropertiesResponse = class(TgtxDocObject)
    private
    FDocProperties: TgtxDocProperties;
    function GetDocProperties: TgtxDocProperties;
    procedure SetDocProperties(const AValue: TgtxDocProperties);
    public
    constructor Create(AApiResponse: TgtxRestAPIResponseGetPropertiesPDF);
    property DocProperties: TgtxDocProperties read GetDocProperties
    write SetDocProperties;
    end;
  }
  // Exception class
  TgtxDocErrorDetails = class
  private
    FUri: string;
  public
    constructor Create(AUri: string);
    property Uri: string read FUri write FUri;
  end;

  EgtxStarDocsException = class(Exception)
  private
    FHttpStatusCode: Integer;
    FErrorCode: TgtxExceptionStatusCode;
    FDocuments: TObjectList<TgtxDocErrorDetails>;
  public
    constructor Create(AHttpStatusCode: Integer;
      AErrorCode: TgtxExceptionStatusCode; const AMessage: string); overload;
    constructor Create(AApiResponse: TgtxRestAPIResponseError); overload;
    constructor Create(AHttpStatusCode: Integer;
      AApiResponseStr: string); overload;
    constructor Create(AHttpStatusCode: Integer;
      AApiResponse: TgtxRestAPIResponseError); overload;
    property HttpStatusCode: Integer read FHttpStatusCode;
    property ErrorCode: TgtxExceptionStatusCode read FErrorCode;
    property Documents: TObjectList<TgtxDocErrorDetails> read FDocuments;
  end;

  // Classes used for passing parameters to the Doc Operations API

  { TgtxPageRange }
  TgtxPageRange = class
  private
    FRange: string;
    { procedure Assign(ASource: TgtxPageRange); }
  public
    constructor Create(ARange: string);
    property Range: string read FRange write FRange;
    procedure AddPage(APage: Integer);
    procedure AddPages(APages: TList<Integer>);
    procedure AddRange(AStartPage: Integer; AEndPage: Integer);
    procedure Clear();
  end;

  { TgtxPageRangeSettings }
  TgtxPageSubRangeMode = (psmAll, psmEven, psmOdd);

  TgtxPageRangeSettings = class
  private
    FPageRange: TgtxPageRange;
    FPageSubRangeMode: TgtxPageSubRangeMode;
    FReverseOrder: Boolean;
    function ToJson(AExcludeOrdering: Boolean = False): string;
    function GetPageRange: TgtxPageRange;
    procedure SetPageRange(const AValue: TgtxPageRange);
  public
    constructor Create(APageRange: string;
      APageSubRangeMode: TgtxPageSubRangeMode = TgtxPageSubRangeMode.psmAll;
      AReverseOrder: Boolean = False); overload;
    constructor Create(APageRange: TgtxPageRange;
      APageSubRangeMode: TgtxPageSubRangeMode = TgtxPageSubRangeMode.psmAll;
      AReverseOrder: Boolean = False); overload;
    property PageRange: TgtxPageRange read GetPageRange write SetPageRange;
    property PageSubRangeMode: TgtxPageSubRangeMode read FPageSubRangeMode
      write FPageSubRangeMode;
    property ReverseOrder: Boolean read FReverseOrder write FReverseOrder;
  end;

  { TgtxPageSeparator }
  TgtxPageSeparatorType = (pstEmptyPage);

  TgtxPageSeparator = class
  private
    FPageSeparatorType: TgtxPageSeparatorType;
  public
    constructor Create(APageSeparatorType: TgtxPageSeparatorType);
    property SeparatorType: TgtxPageSeparatorType read FPageSeparatorType
      write FPageSeparatorType;
    function EncodeString: string;
  end;

  { TgtxSearchText }
  TgtxSearchText = class
  private
    FText: string;
    FCaseSensitive: Boolean;
    FWholeWord: Boolean;
  public
    constructor Create(AText: string; ACaseSensitive: Boolean = False;
      AWholeWord: Boolean = False);
    property Text: string read FText write FText;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive;
    property WholeWord: Boolean read FWholeWord write FWholeWord;
  end;

  { TgtxColor }
  TgtxColor = class
  private
    FRed: Byte;
    FGreen: Byte;
    FBlue: Byte;
    FAlpha: Byte;
    function EncodeString(AEncodeAlpha: boolean = True): string;
  public
    constructor Create(ARed: Byte; AGreen: Byte; ABlue: Byte;
      AAlpha: Byte = 100);
    procedure Assign(Source: TgtxColor);
    property Red: Byte read FRed;
    property Green: Byte read FGreen;
    property Blue: Byte read FBlue;
    property Alpha: Byte read FAlpha;
  end;

  { TgtxRedactFillSettings }
  TgtxRedactFillSettings = class
  private
    FOutline: TgtxOutline;
    FFillRect: TgtxFillRect;
    FFillText: TgtxFillText;
    function ToJson: string;
    function GetOutline: TgtxOutline;
    function GetFillRect: TgtxFillRect;
    function GetFillText: TgtxFillText;
  public
    constructor Create(AOutline: TgtxOutline = nil;
      AFillRect: TgtxFillRect = nil; AFillText: TgtxFillText = nil);
    property Outline: TgtxOutline read GetOutline;
    property FillRect: TgtxFillRect read GetFillRect;
    property FillText: TgtxFillText read GetFillText;
  end;

  { TgtxPen }
  TgtxPen = class
  private
    FColor: TgtxColor;
    FWidth: Integer;
    FStyle: TgtxPenStyle;
    function GetColor: TgtxColor;
  public
    constructor Create(AColor: TgtxColor = nil;
      AStyle: TgtxPenStyle = TgtxPenStyle.pstSolid; AWidth: Integer = 1);
    property Color: TgtxColor read GetColor;
    property Width: Integer read FWidth;
    property Style: TgtxPenStyle read FStyle;
  end;

  { TgtxBrush }
  TgtxBrush = class
  private
    FColor: TgtxColor;
    FPattern: TgtxBrushPattern;
    function GetColor: TgtxColor;
  public
    constructor Create(AColor: TgtxColor = nil;
      APattern: TgtxBrushPattern = TgtxBrushPattern.bptSolid);
    property Color: TgtxColor read GetColor;
    property Pattern: TgtxBrushPattern read FPattern;
  end;

  { TgtxOutline }
  TgtxOutline = class
  private
    FPenColoringMode: TgtxColoringMode;
    FPen: TgtxPen;
    function ToJson: string;
    function GetPen: TgtxPen;
  public
    constructor Create(APenColoringMode
      : TgtxColoringMode = TgtxColoringMode.cmoNone; APen: TgtxPen = nil);
    property PenColoringMode: TgtxColoringMode read FPenColoringMode;
    property Pen: TgtxPen read GetPen;
  end;

  { TgtxFont }
  TgtxFont = class
  private
    FName: String;
    FSize: Integer;
    FColor: TgtxColor;
    FStyles: TgtxFontStyles;
    FEffects: TgtxFontEffects;
    function ToJson(AFontSizingMode: TgtxFontSizingMode;
      AFontColoringMode: TgtxFontColoringMode): string;
    function GetColor: TgtxColor;
  public
    constructor Create(AName: String; ASize: Integer; AColor: TgtxColor = nil;
      AStyles: TgtxFontStyles = []; AEffects: TgtxFontEffects = []);
    property Name: String read FName;
    property Size: Integer read FSize;
    property Color: TgtxColor read GetColor;
    property Styles: TgtxFontStyles read FStyles;
    property Effects: TgtxFontEffects read FEffects;
  end;

  { TgtxFillText }
  TgtxFillText = class
  private
    FReplaceText: string;
    FFontSelectionMode: TgtxFontSelectionMode;
    FFontSizingMode: TgtxFontSizingMode;
    FFontColoringMode: TgtxFontColoringMode;
    FFont: TgtxFont;
    function ToJson: string;
    function GetFont: TgtxFont;
  public
    constructor Create(AReplaceText: String;
      AFontSelectionMode: TgtxFontSelectionMode = TgtxFontSelectionMode.
      fsmUseFont; AFontSizingMode: TgtxFontSizingMode = TgtxFontSizingMode.
      fsmAutoFit; AFontColoringMode
      : TgtxFontColoringMode = TgtxFontColoringMode.fcmSource;
      AFont: TgtxFont = nil);
    property ReplaceText: String read FReplaceText;
    property FontSelectionMode: TgtxFontSelectionMode read FFontSelectionMode;
    property FontSizingMode: TgtxFontSizingMode read FFontSizingMode;
    property FontColoringMode: TgtxFontColoringMode read FFontColoringMode;
    property Font: TgtxFont read GetFont;
  end;

  { TgtxFillRect }
  TgtxFillRect = class
  private
    FBrushColoringMode: TgtxColoringMode;
    FBrush: TgtxBrush;
    function ToJson: string;
  public
    constructor Create(ABrushColoringMode
      : TgtxColoringMode = TgtxColoringMode.cmoNone; ABrush: TgtxBrush = nil);
  end;

  { TgtxEncoderSettings }
  TgtxEncoderSettings = class
  protected
    function ToJson(): string; virtual;
  end;

  { TgtxDPI }
  TgtxDPI = class
  private
    FResolutionMode: TgtxResolutionMode;
    FX: Integer;
    FY: Integer;
    function ToJson: String;
  public
    constructor Create(AResolutionMode: TgtxResolutionMode = TgtxResolutionMode.
      rmmUseSource; AX: Integer = 72; AY: Integer = 72);
    property ResolutionMode: TgtxResolutionMode read FResolutionMode
      write FResolutionMode;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
  end;

  { TgtxSize }
  TgtxSize = class
  private
    FPaperSize: TgtxPaperSize;
    FWidth: Integer;
    FHeight: Integer;
    FMeasurementUnit: TgtxMeasurementUnit;
    function EncodeString: String;
  public
    constructor Create(APaperSize: TgtxPaperSize = TgtxPaperSize.psiA4;
      AWidth: Integer = 0; AHeight: Integer = 0;
      AMeasurementUnit: TgtxMeasurementUnit = TgtxMeasurementUnit.
      munMillimeters);
    property PaperSize: TgtxPaperSize read FPaperSize write FPaperSize;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property MeasurementUnit: TgtxMeasurementUnit read FMeasurementUnit
      write FMeasurementUnit;
  end;

  { TgtxCanvasSize }
  TgtxCanvasSize = class
  private
    FSizingMode: TgtxCanvasSizingMode;
    FSize: TgtxSize;
    FRelativeSizeX: Integer;
    FRelativeSizeY: Integer;
    function ToJson: String;
  public
    constructor Create(ASizingMode: TgtxCanvasSizingMode = TgtxCanvasSizingMode.
      csmUseSource; ASize: TgtxSize = nil; ARelativeSizeX: Integer = 100;
      ARelativeSizeY: Integer = 100);
  end;

  { TgtxContentAlignment }
  TgtxContentAlignment = class
  private
    FHorizontalAlignmentType: TgtxHorizontalAlignmentType;
    FHorizontalOffset: Integer;
    FVerticalAlignmentType: TgtxVerticalAlignmentType;
    FVerticalOffset: Integer;
    function ToJson: String;
  public
    constructor Create(AHorizontalAlignmentType
      : TgtxHorizontalAlignmentType = TgtxHorizontalAlignmentType.hatCenter;
      AHorizontalOffset: Integer = 0;
      AVerticalAlignmentType: TgtxVerticalAlignmentType =
      TgtxVerticalAlignmentType.vatCenter; AVerticalOffset: Integer = 0);
    procedure Assign(Source: TgtxContentAlignment);
    property HorizontalAlignmentType: TgtxHorizontalAlignmentType
      read FHorizontalAlignmentType write FHorizontalAlignmentType;
    property HorizontalOffset: Integer read FHorizontalOffset
      write FHorizontalOffset;
    property VerticalAlignmentType: TgtxVerticalAlignmentType
      read FVerticalAlignmentType write FVerticalAlignmentType;
    property VerticalOffset: Integer read FVerticalOffset write FVerticalOffset;
  end;

  { TgtxImageEncoderSettings }
  TgtxImageEncoderSettings = class(TgtxEncoderSettings)
  private
    FDPI: TgtxDPI;
    FQuality: Byte;
    FCanvasSize: TgtxCanvasSize;
    FContentScaling: TgtxContentScaling;
    FContentAlignment: TgtxContentAlignment;
    function GetContentAlignment: TgtxContentAlignment;
    procedure SetContentAlignment(const AValue: TgtxContentAlignment);
  public
    function ToJson(): string; override;
    constructor Create(ADPI: TgtxDPI = nil; AQuality: Byte = 80;
      ACanvasSize: TgtxCanvasSize = nil;
      AScaling: TgtxContentScaling = TgtxContentScaling.cscFitWithAspect;
      AAlignment: TgtxContentAlignment = nil);
    property DPI: TgtxDPI read FDPI write FDPI;
    property Quality: Byte read FQuality write FQuality;
    property CanvasSize: TgtxCanvasSize read FCanvasSize write FCanvasSize;
    property ContentScaling: TgtxContentScaling read FContentScaling
      write FContentScaling;
    property ContentAlignment: TgtxContentAlignment read GetContentAlignment
      write SetContentAlignment;
  end;

  { TgtxPDFPortfolioSettings }
  TgtxPDFPortfolioSettings = class
  private
    FPDFPortfolioCreationMode: TgtxPDFPortfolioCreationMode;
    FPDFPortfolioInitialLayout: TgtxPDFPortfolioInitialLayout;
    function ToJson: String;
  public
    constructor Create(APDFPortfolioCreationMode
      : TgtxPDFPortfolioCreationMode = TgtxPDFPortfolioCreationMode.
      pcmWhenInputIsPortfolio;
      APDFPortfolioInitialLayout: TgtxPDFPortfolioInitialLayout =
      TgtxPDFPortfolioInitialLayout.pilDetails);
  end;

  { TgtxPDFEncoderSettings }
  TgtxPDFEncoderSettings = class(TgtxEncoderSettings)
  private
    FPDFPortfolioSettings: TgtxPDFPortfolioSettings;
    FFontEmbeddingType: TgtxFontEmbeddingType;
    FOverrideFontEmbeddingRestriction: Boolean;

    function GetPDFPortfolioSettings: TgtxPDFPortfolioSettings;
    procedure SetPDFPortfolioSettings(const AValue: TgtxPDFPortfolioSettings);
  public
    constructor Create(APDFPortfolioSettings: TgtxPDFPortfolioSettings;
      AFontEmbeddingType: TgtxFontEmbeddingType = TgtxFontEmbeddingType.
      fetSubset; AOverrideFontEmbeddingRestriction: Boolean = False);
    function ToJson: string; override;
    property PDFPortfolioSettings: TgtxPDFPortfolioSettings
      read GetPDFPortfolioSettings write SetPDFPortfolioSettings;
    property FontEmbeddingType: TgtxFontEmbeddingType read FFontEmbeddingType
      write FFontEmbeddingType;
    property OverrideFontEmbeddingRestriction: Boolean
      read FOverrideFontEmbeddingRestriction
      write FOverrideFontEmbeddingRestriction;
  end;

  // Classes for accepting parsed JSON responses
  // These are meant to be internal
  TgtxRestAPIResponseAuth = class
  private
    FAccess_Token: string;
    FToken_Type: string;
    FExpires_In: Longint;
  public
    property AccessToken: string read FAccess_Token;
    property TokenType: string read FToken_Type;
    property ExpiresIn: Longint read FExpires_In;
  end;

  TgtxRestAPIResponseAuthFailure = class
  private
    FError: string;
    FErrorDescription: string;
    FErrorURI: string;
  public
    property Error: string read FError write FError;
    property ErrorDescription: string read FErrorDescription
      write FErrorDescription;
    property ErrorUri: string read FErrorURI write FErrorURI;
  end;

  TgtxRestAPIDocumentCommon = class
  private
    FUrl: string;
    FFileName: string;
    FFileSize: Integer;
    FFileExpiry: Longint;
    FPageCount: Integer;
    FMimeType: string;
  public
    property Url: string read FUrl write FUrl;
    property FileName: string read FFileName write FFileName;
    property FileSize: Integer read FFileSize write FFileSize;
    property FileExpiry: Longint read FFileExpiry write FFileExpiry;
    property PageCount: Integer read FPageCount write FPageCount;
    property MimeType: string read FMimeType write FMimeType;
  end;

  TgtxRestAPIResponseGetDocumentInfo = class(TgtxRestAPIDocumentCommon)
  private
    FUnsupportedMimeTypeOrCorrupt: Boolean;
    FPasswordProtected: Boolean;
    FPasswordCorrect: Boolean;

  public
    property UnsupportedMimeTypeOrCorrupt: Boolean read FUnsupportedMimeTypeOrCorrupt
      write FUnsupportedMimeTypeOrCorrupt;
    property PasswordProtected: Boolean read FPasswordProtected
      write FPasswordProtected;
    property PasswordCorrect: Boolean read FPasswordCorrect
      write FPasswordCorrect;
  end;

  TgtxRestAPIResponseCommon = class
  private
    FDocuments: TArray<TgtxRestAPIDocumentCommon>;
    function GetDocuments: TArray<TgtxRestAPIDocumentCommon>;
    procedure SetDocuments(const AValue: TArray<TgtxRestAPIDocumentCommon>);
  public
    property Documents: TArray<TgtxRestAPIDocumentCommon> read GetDocuments
      write SetDocuments;
  end;

  TgtxRestAPIDocPropertiesCommon = class
  private
    FTitle: string;
    FAuthor: string;
    FSubject: string;
    FKeywords: string;
    FCreator: string;
    FProducer: string;
  public
    procedure Assign(Source: TgtxRestAPIDocPropertiesCommon);
    property Title: string read FTitle write FTitle;
    property Author: string read FAuthor write FAuthor;
    property Subject: string read FSubject write FSubject;
    property Keywords: string read FKeywords write FKeywords;
    property Creator: string read FCreator write FCreator;
    property Producer: string read FProducer write FProducer;
  end;

  TgtxRestAPIDocExPropertiesPDF = class
  private
    FHasBookmarks: Boolean;
    FHasSecurity: Boolean;
  public
    property HasBookmarks: Boolean read FHasBookmarks write FHasBookmarks;
    property HasSecurity: Boolean read FHasSecurity write FHasSecurity;
  end;

  TgtxRestAPIDocumentGetPropertiesPDF = class(TgtxRestAPIDocumentCommon)
  private
    FProperties: TgtxRestAPIDocPropertiesCommon;
    FExtendedProperties: TgtxRestAPIDocExPropertiesPDF;
    function GetExtendedProperties: TgtxRestAPIDocExPropertiesPDF;
    procedure SetExtendedProperties(const AValue
      : TgtxRestAPIDocExPropertiesPDF);
    function GetProperties: TgtxRestAPIDocPropertiesCommon;
    procedure SetProperties(const AValue: TgtxRestAPIDocPropertiesCommon);
  public
    property Properties: TgtxRestAPIDocPropertiesCommon read GetProperties
      write SetProperties;
    property ExtendedProperties: TgtxRestAPIDocExPropertiesPDF
      read GetExtendedProperties write SetExtendedProperties;
  end;

  TgtxRestAPIDocPermissionsPDF = class
  private
    FAllowAssembly: Boolean;
    FAllowModifyAnnotations: Boolean;
    FAllowCopy: Boolean;
    FAllowModifyContents: Boolean;
    FAllowAccessibility: Boolean;
    FAllowPrinting: Boolean;
    FAllowHighResPrint: Boolean;
    FAllowFormFill: Boolean;
  public
    procedure Assign(Source: TgtxRestAPIDocPermissionsPDF);
    property AllowAssembly: Boolean read FAllowAssembly write FAllowAssembly;
    property AllowModifyAnnotations: Boolean read FAllowModifyAnnotations
      write FAllowModifyAnnotations;
    property AllowCopy: Boolean read FAllowCopy write FAllowCopy;
    property AllowModifyContents: Boolean read FAllowModifyContents
      write FAllowModifyContents;
    property AllowAccessibility: Boolean read FAllowAccessibility
      write FAllowAccessibility;
    property AllowPrinting: Boolean read FAllowPrinting write FAllowPrinting;
    property AllowHighResPrint: Boolean read FAllowHighResPrint
      write FAllowHighResPrint;
    property AllowFormFill: Boolean read FAllowFormFill write FAllowFormFill;
  end;

  TgtxRestAPIDocPropertiesSecurity = class
  private
    FSecurityMethod: string;
    FEncryptionLevel: string;
    FSuppliedPassword: string;
    FHasOpenPassword: Boolean;
    FHasPermissionsPassword: Boolean;
    FPermissions: TgtxRestAPIDocPermissionsPDF;
    function GetPermissions: TgtxRestAPIDocPermissionsPDF;
    procedure SetPermissions(const AValue: TgtxRestAPIDocPermissionsPDF);
  public
    procedure Assign(Source: TgtxRestAPIDocPropertiesSecurity);
    property SecurityMethod: string read FSecurityMethod write FSecurityMethod;
    property EncryptionLevel: string read FEncryptionLevel
      write FEncryptionLevel;
    property SuppliedPassword: string read FSuppliedPassword
      write FSuppliedPassword;
    property HasOpenPassword: Boolean read FHasOpenPassword
      write FHasOpenPassword;
    property HasPermissionsPassword: Boolean read FHasPermissionsPassword
      write FHasPermissionsPassword;
    property Permissions: TgtxRestAPIDocPermissionsPDF read GetPermissions
      write SetPermissions;
  end;

  TgtxRestAPIDocumentGetPropertiesSecurityPDF = class(TgtxRestAPIDocumentCommon)
  private
    FExtendedPropertiesSecurity: TgtxRestAPIDocPropertiesSecurity;
    function GetExtendedPropertiesSecurity: TgtxRestAPIDocPropertiesSecurity;
    procedure SetExtendedPropertiesSecurity(const AValue
      : TgtxRestAPIDocPropertiesSecurity);
  public
    property ExtendedPropertiesSecurity: TgtxRestAPIDocPropertiesSecurity
      read GetExtendedPropertiesSecurity write SetExtendedPropertiesSecurity;
  end;

  TgtxRestAPIResponseGetPropertiesPDF = class
  private
    FOprStatusCode: Integer;
    FDocuments: TArray<TgtxRestAPIDocumentGetPropertiesPDF>;
    function GetDocuments: TArray<TgtxRestAPIDocumentGetPropertiesPDF>;
    procedure SetDocuments(const AValue
      : TArray<TgtxRestAPIDocumentGetPropertiesPDF>);
  public
    property OprStatusCode: Integer read FOprStatusCode write FOprStatusCode;
    property Documents: TArray<TgtxRestAPIDocumentGetPropertiesPDF>
      read GetDocuments write SetDocuments;
  end;

  TgtxRestAPIResponseGetPropertiesSecurityPDF = class
  private
    FOprStatusCode: Integer;
    FDocuments: TArray<TgtxRestAPIDocumentGetPropertiesSecurityPDF>;
    function GetDocuments: TArray<TgtxRestAPIDocumentGetPropertiesSecurityPDF>;
    procedure SetDocuments(const AValue
      : TArray<TgtxRestAPIDocumentGetPropertiesSecurityPDF>);
  public
    property OprStatusCode: Integer read FOprStatusCode write FOprStatusCode;
    property Documents: TArray<TgtxRestAPIDocumentGetPropertiesSecurityPDF>
      read GetDocuments write SetDocuments;
  end;

  TgtxRestAPIDocumentError = class
  private
    FUrl: string;
  public
    property Url: string read FUrl write FUrl;
  end;

  TgtxRestAPIResponseError = class
  private
    FErrorCode: Integer;
    FErrorMessage: string;
    FDocuments: TArray<TgtxRestAPIDocumentError>;

  public
    property ErrorCode: Integer read FErrorCode write FErrorCode;
    property ErrorMessage: string read FErrorMessage write FErrorMessage;
    property Documents: TArray<TgtxRestAPIDocumentError> read FDocuments
      write FDocuments;
  end;

  TgtxRestAPIResponseJob = class
  private
    FUri: string;
  public
    property Uri: string read FUri write FUri;
  end;

  TgtxRestAPIResponseJobs = class
  private
    FOprStatusCode: Integer;
    FJobs: TArray<TgtxRestAPIResponseJob>;

  public
    property OprStatusCode: Integer read FOprStatusCode write FOprStatusCode;
    property Jobs: TArray<TgtxRestAPIResponseJob> read FJobs write FJobs;
  end;

  { TgtxRestAPIResponseCreateView }
  TgtxRestAPIResponseCreateView = class
  private
    FUrl: String;
    FTimeToLive: Longint;
  public
    property Url: string read FUrl write FUrl;
    property TimeToLive: Longint read FTimeToLive write FTimeToLive;
  end;

  { TgtxViewResponse }
  TgtxViewResponse = class
  private
    FUrl: String;
    FTimeToLive: Longint;
  public
    constructor Create(AApiResponse: TgtxRestAPIResponseCreateView);
    property Url: string read FUrl write FUrl;
    property TimeToLive: Longint read FTimeToLive write FTimeToLive;
  end;

  { TgtxVisibleNavigationControls }
  TgtxVisibleNavigationControls = class
  private
    FFirstPage: Boolean;
    FLastPage: Boolean;
    FPrevPage: Boolean;
    FNextPage: Boolean;
    FPageIndicator: Boolean;
    FGotoPage: Boolean;
    function ToJson(): String;
  public
    constructor Create(AFirstPage: Boolean = True; ALastPage: Boolean = True;
      APrevPage: Boolean = True; ANextPage: Boolean = True;
      APageIndicator: Boolean = True; AGotoPage: Boolean = True);
    procedure Assign(Source: TgtxVisibleNavigationControls);
    property FirstPage: Boolean read FFirstPage write FFirstPage;
    property LastPage: Boolean read FLastPage write FLastPage;
    property PrevPage: Boolean read FPrevPage write FPrevPage;
    property NextPage: Boolean read FNextPage write FNextPage;
    property PageIndicator: Boolean read FPageIndicator write FPageIndicator;
    property GotoPage: Boolean read FGotoPage write FGotoPage;
  end;

  TgtxVisibleZoomControls = class
  private
    FFixedSteps: Boolean;
    FZoomIn: Boolean;
    FZoomOut: Boolean;
    function ToJson(): String;
  public
    constructor Create(AFixedSteps: Boolean = True; AzoomIn: Boolean = True;
      AZoomout: Boolean = True);
    procedure Assign(Source: TgtxVisibleZoomControls);
    property FixedSteps: Boolean read FFixedSteps write FFixedSteps;
    property ZoomIn: Boolean read FZoomIn write FZoomIn;
    property ZoomOut: Boolean read FZoomOut write FZoomOut;
  end;

  TgtxVisibleRotationControls = class
  private
    FClockwise: Boolean;
    FCounterClockwise: Boolean;
    function ToJson(): String;
  public
    constructor Create(AClockwise: Boolean = True;
      ACounterClockwise: Boolean = True);
    property Clockwise: Boolean read FClockwise write FClockwise;
    property CounterClockwise: Boolean read FCounterClockwise
      write FCounterClockwise;
  end;

  TgtxVisibleColorInversionControls = class
  private
    FAllPages: Boolean;
    function ToJson(): String;
  public
    constructor Create(AAllPages: Boolean = True);
    property AllPages: Boolean read FAllPages write FAllPages;
  end;

  TgtxSearchControls = class
  private
    FEnableQuickSearch: Boolean;
    FHighlightColor: TgtxColor;
    function ToJson(): String;
    function GetHighlightColor: TgtxColor;
    procedure SetHighlightColor(const AValue: TgtxColor);
  public

    constructor Create(AEnableQuickSearch: Boolean = True;
      AHighlightColor: TgtxColor = nil);
    procedure Assign(Source: TgtxSearchControls);
    property EnableQuickSearch: Boolean read FEnableQuickSearch
      write FEnableQuickSearch;
    property HighlightColor: TgtxColor read GetHighlightColor
      write SetHighlightColor;
  end;

  TgtxViewerSettings = class
  private
    FToolbarVisible: Boolean;
    FVisibleNavigationControls: TgtxVisibleNavigationControls;
    FVisibleZoomControls: TgtxVisibleZoomControls;
    FVisibleRotationControls: TgtxVisibleRotationControls;
    FVisibleColorInversionControls: TgtxVisibleColorInversionControls;
    FSearchControls: TgtxSearchControls;
    function GetVisibleNavigationControls: TgtxVisibleNavigationControls;
    function GetVisibleZoomControls: TgtxVisibleZoomControls;
    function GetVisibleRotationControls: TgtxVisibleRotationControls;
    function GetVisibleColorInversionControls
      : TgtxVisibleColorInversionControls;
    function GetSearchControls: TgtxSearchControls;
    procedure SetVisibleNavigationControls(const AValue
      : TgtxVisibleNavigationControls);
    procedure SetVisibleZoomControls(const AValue: TgtxVisibleZoomControls);
    procedure SetVisibleRotationControls(const AValue
      : TgtxVisibleRotationControls);
    procedure SetVisibleColorInversionControls(const AValue
      : TgtxVisibleColorInversionControls);
    procedure SetSearchControls(const AValue: TgtxSearchControls);
    function ToJson(): String;
  public
    constructor Create(AToolbarVisible: Boolean = True;
      AVisibleNavigationControls: TgtxVisibleNavigationControls = nil;
      AVisibleZoomControls: TgtxVisibleZoomControls = nil;
      AVisibleRotationControls: TgtxVisibleRotationControls = nil;
      AVisibleColorInversionControls: TgtxVisibleColorInversionControls = nil;
      ASearchControls: TgtxSearchControls = nil);
    property ToolbarVisible: Boolean read FToolbarVisible write FToolbarVisible;
    property VisibleNavigationControls: TgtxVisibleNavigationControls
      read GetVisibleNavigationControls write SetVisibleNavigationControls;
    property VisibleZoomControls: TgtxVisibleZoomControls
      read GetVisibleZoomControls write SetVisibleZoomControls;
    property VisibleRotationControls: TgtxVisibleRotationControls
      read GetVisibleRotationControls write SetVisibleRotationControls;
    property VisibleColorInversionControls: TgtxVisibleColorInversionControls
      read GetVisibleColorInversionControls
      write SetVisibleColorInversionControls;
    property SearchControls: TgtxSearchControls read GetSearchControls
      write SetSearchControls;
  end;

  TgtxViewer = class
  private
    FStarDocs: TgtxStarDocsSDK;
    constructor Create(AStarDocs: TgtxStarDocsSDK);

  public
    function CreateView(AFile: TgtxFileObject; APassword: string;
      AViewerSettings: TgtxViewerSettings): TgtxViewResponse;
  end;

  { TgtxPDFFormFieldFillData }
  TgtxPDFFormFieldFillData = class
  private
    FFieldName: string;
    FFieldValue: string;
    FFlattenField: Boolean;
  public
    constructor Create(AfieldName: string = ''; AfieldValue: string = '';
      AFlattenField: Boolean = False);
    property FieldName: string read FFieldName write FFieldName;
    property FieldValue: string read FFieldValue write FFieldValue;
    property FlattenField: Boolean read FFlattenField write FFlattenField;
  end;

implementation

{ Helper routines }
const
  BooleanToStringName: array [False .. True] of string = ('false', 'true');

  { TgtxStarDocsSDK }

constructor TgtxStarDocsSDK.Create(AOwner: TComponent);
begin
  inherited;
  FConnectionInfo := TgtxConnectionInfo.Create(nil, '', '', -1, -1);
  FPreferences := TgtxPreferences.Create(TgtxDocPasswordSettings.Create(False));
  { Instantiate service groups }
  FAuth := TgtxAuth.Create(Self);
  FStorage := TgtxStorage.Create(Self);
  FDocOperations := TgtxDocOperations.Create(Self);
  FViewer := TgtxViewer.Create(Self);
end;

constructor TgtxStarDocsSDK.Create(AOwner: TComponent;
  AConnectionInfo: TgtxConnectionInfo; APreferences: TgtxPreferences);
begin
  Create(AOwner);
  FConnectionInfo.Assign(AConnectionInfo);
  FPreferences.Assign(APreferences);
end;

destructor TgtxStarDocsSDK.Destroy;
begin

  inherited;
end;

function TgtxStarDocsSDK.EncodeJsonDocuments(ADocUris, APasswords: TStringList;
  APageRanges: TObjectList<TgtxPageRangeSettings>): string;
var
  LJsonStr: string;
  LIndex: Integer;
  LPageRange: TgtxPageRangeSettings;
begin
  LJsonStr := '"documents":[';
  for LIndex := 0 to ADocUris.Count - 1 do
  begin
    if LIndex > 0 then
      LJsonStr := LJsonStr + ',';
    LJsonStr := LJsonStr + '{"url":"' + ADocUris[LIndex] + '"';
    if (APasswords <> nil) And (LIndex < APasswords.Count) then
      LJsonStr := LJsonStr + ',"password":"' + APasswords[LIndex] + '"';
    if (APageRanges <> nil) And (LIndex < APageRanges.Count) then
    begin
      LPageRange := APageRanges[LIndex];
      LJsonStr := LJsonStr + (',"pageRange":' + LPageRange.ToJson());
    end;
    LJsonStr := LJsonStr + '}';
  end;
  LJsonStr := LJsonStr + ']';
  Result := LJsonStr;
end;

function TgtxStarDocsSDK.GetAuth: TgtxAuth;
begin
  Result := FAuth;
end;

function TgtxStarDocsSDK.GetConnectionInfo: TgtxConnectionInfo;
begin
  Result := FConnectionInfo;
end;

function TgtxStarDocsSDK.GetDocOperations: TgtxDocOperations;
begin
  Result := FDocOperations;
end;

function TgtxStarDocsSDK.GetDocUri(AFile: TgtxFileObject): string;
var
  LOutDoc: TgtxDocObject;
begin
  LOutDoc := nil;
  if AFile.FFileUploaded then
    Result := AFile.FRemoteFileUri.FUri.Uri
  else
  begin
    if AFile.FStream <> nil then
      Result := Storage.Upload(AFile.Stream, AFile.FStreamFileName)
        .FRemoteFileUri.FUri.Uri
    else
      try
        LOutDoc := Storage.Upload(AFile.FLocalFilePath);
        Result := LOutDoc.FRemoteFileUri.FUri.Uri;
      finally
        LOutDoc.Free;
      end;
  end;

end;

function TgtxStarDocsSDK.GetPreferences: TgtxPreferences;
begin
  Result := FPreferences;
end;

function TgtxStarDocsSDK.GetStorage: TgtxStorage;
begin
  Result := FStorage;
end;

function TgtxStarDocsSDK.GetViewer: TgtxViewer;
begin
  Result := FViewer;
end;

function TgtxStarDocsSDK.IssueGetRequestAndPoll(AUrl: string): string;
var
  LRestResp: THttpResponse;
  LRestRequestGet: TRestRequest;
  LRestRequestGetPoll: TRestRequest;
  LFullJobUri: string;
  LSleepTime: Integer;
  LStopWatch: TStopWatch;
begin
  LRestRequestGet := TRestRequest.Create();
  LRestRequestGetPoll := TRestRequest.Create();
  LStopWatch := TStopWatch.Create;
  try
    LRestRequestGet.Domain(AUrl).WithReadTimeout
      (FConnectionInfo.FServerTimeout).WithBearerToken
      (FAuthResponse.AccessToken);
    LRestResp := LRestRequestGet.Get;
    if (LRestResp.ResponseCode = 201) OR (LRestResp.ResponseCode = 200) then
    begin
      // Poll not required, return response
      Result := LRestResp.ResponseStr;
      Exit;
    end;

    if LRestResp.ResponseCode <> 202 then
      raise EgtxStarDocsException.Create(LRestResp.ResponseCode,
        LRestResp.ResponseStr);

    // Get the job URL and start polling for completion
    LFullJobUri := LRestResp.LocationHeader;
    LRestRequestGetPoll.Domain(LFullJobUri)
      .WithReadTimeout(FConnectionInfo.FServerTimeout)
      .WithBearerToken(FAuthResponse.AccessToken);
    LSleepTime := ConnectionInfo.PollInterval;
    LStopWatch.Start;
    while True do
    begin
      Sleep(LSleepTime);
      LRestResp := LRestRequestGetPoll.Get;
      if (LRestResp.ResponseCode = 201) OR (LRestResp.ResponseCode = 200) then
      begin
        // Request is done, return response
        Result := LRestResp.ResponseStr;
        Exit;
      end
      else if LRestResp.ResponseCode <> 202 then
      begin
        // Something went wrong
        raise EgtxStarDocsException.Create(LRestResp.ResponseCode,
          LRestResp.ResponseStr);
      end;

      // Check if operation is taking too long
      if ConnectionInfo.DocOperationTimeout > 0 then
      begin
        LStopWatch.Stop;
        if LStopWatch.ElapsedMilliseconds > ConnectionInfo.DocOperationTimeout
        then
          raise EgtxStarDocsException.Create(0,
            TgtxExceptionStatusCode.escOperationTimedOut,
            'The server is taking too long. Try increasing the timeout value.');
      end;
    end;
  finally
    LStopWatch.Reset;
    LRestRequestGet.Free;
    LRestRequestGetPoll.Free;
  end;
end;

function TgtxStarDocsSDK.IssuePostPutRequestAndPoll(AUrl: string;
  APost: Boolean; AJsonStr: string): string;
var
  LRestResp: THttpResponse;
  LRestRequestPost: TRestRequest;
  LRestRequestGet: TRestRequest;
  // LResponseError: TgtxRestAPIResponseError;
  // LJobsResponse: TgtxRestAPIResponseJobs;
  LFullJobUri: string;
  LSleepTime: Integer;
  LStopWatch: TStopWatch;
begin
  LRestRequestPost := TRestRequest.Create();
  LRestRequestGet := TRestRequest.Create();
  LStopWatch := TStopWatch.Create;
  try
    LRestRequestPost.Domain(AUrl).WithReadTimeout
      (FConnectionInfo.FServerTimeout).WithBearerToken
      (FAuthResponse.AccessToken);
    if APost then
      LRestResp := LRestRequestPost.Post(AJsonStr)
    else
      LRestResp := LRestRequestPost.Put(AJsonStr);
    if (LRestResp.ResponseCode = 201) OR (LRestResp.ResponseCode = 200) then
    begin
      // Poll not required, return response
      Result := LRestResp.ResponseStr;
      Exit;
    end;

    if LRestResp.ResponseCode <> 202 then
      raise EgtxStarDocsException.Create(LRestResp.ResponseCode,
        LRestResp.ResponseStr);

    // Get the job URL and start polling for completion
    // LJobsResponse := TJSON.JsonToObject<TgtxRestAPIResponseJobs>(LRestResp.ResponseStr);
    // LFullJobUri := LJobsResponse.Jobs[0].Uri;
    LFullJobUri := LRestResp.LocationHeader;
    LRestRequestGet.Domain(LFullJobUri)
      .WithReadTimeout(FConnectionInfo.FServerTimeout)
      .WithBearerToken(FAuthResponse.AccessToken);
    LSleepTime := ConnectionInfo.PollInterval;
    LStopWatch.Start;
    while True do
    begin
      Sleep(LSleepTime);
      LRestResp := LRestRequestGet.Get;
      if (LRestResp.ResponseCode = 201) OR (LRestResp.ResponseCode = 200) then
      begin
        // Poll not required, return response
        Result := LRestResp.ResponseStr;
        Exit;
      end
      else if LRestResp.ResponseCode <> 202 then
      begin
        // Something went wrong
        raise EgtxStarDocsException.Create(LRestResp.ResponseCode,
          LRestResp.ResponseStr);
      end;

      // Check if operation is taking too long
      if ConnectionInfo.DocOperationTimeout > 0 then
      begin
        LStopWatch.Stop;
        if LStopWatch.ElapsedMilliseconds > ConnectionInfo.DocOperationTimeout
        then
          raise EgtxStarDocsException.Create(0,
            TgtxExceptionStatusCode.escOperationTimedOut,
            'The server is taking too long. Try increasing the timeout value.');
      end;
    end;
  finally
    LStopWatch.Reset;
    LRestRequestGet.Free;
    LRestRequestPost.Free;
  end;
end;

procedure TgtxStarDocsSDK.SetAuth(const AValue: TgtxAuth);
begin
  FAuth := AValue;
end;

procedure TgtxStarDocsSDK.SetConnectionInfo(const AValue: TgtxConnectionInfo);
begin
  FConnectionInfo.Assign(AValue);
end;

procedure TgtxStarDocsSDK.SetDocOperations(const AValue: TgtxDocOperations);
begin
  FDocOperations := AValue;
end;

procedure TgtxStarDocsSDK.SetPreferences(const AValue: TgtxPreferences);
begin
  FPreferences.Assign(AValue);
end;

procedure TgtxStarDocsSDK.SetStorage(const AValue: TgtxStorage);
begin
  FStorage := AValue;
end;

procedure TgtxStarDocsSDK.SetViewer(const AValue: TgtxViewer);
begin
  FViewer := AValue;
end;

{ TgtxConnectionInfo }
constructor TgtxConnectionInfo.Create(AUri: TIdURI; AAppKey: string;
  AAppSecret: string; AServerTimeout: Integer = -1;
  ADocOperationTimeout: Integer = -1);
begin
  FApiServerVersion := '';
  FPollInterval := 1000;
  if AUri <> nil then
    FApiServerUri := TIdURI.Create(AUri.Uri)
  else
    FApiServerUri := TIdURI.Create();
  FAppKey := AAppKey;
  FAppSecret := AAppSecret;
  FServerTimeout := AServerTimeout;
  FDocOperationTimeout := ADocOperationTimeout;
end;

procedure TgtxConnectionInfo.Assign(Source: TPersistent);
begin
  if Source is TgtxConnectionInfo then
  begin
    FApiServerVersion := TgtxConnectionInfo(Source).FApiServerVersion;
    FPollInterval := TgtxConnectionInfo(Source).FPollInterval;
    FApiServerUri.Uri := TgtxConnectionInfo(Source).FApiServerUri.Uri;
    FAppKey := TgtxConnectionInfo(Source).FAppKey;
    FAppSecret := TgtxConnectionInfo(Source).FAppSecret;
    FServerTimeout := TgtxConnectionInfo(Source).FServerTimeout;
    FDocOperationTimeout := TgtxConnectionInfo(Source).FDocOperationTimeout;
    Exit;
    // else
    // TODO: Throw error
  end;
  inherited Assign(Source)
end;

destructor TgtxConnectionInfo.Destroy;
begin
  FApiServerUri.Free;
  inherited;
end;

{ TgtxDocPasswordSettings }
constructor TgtxDocPasswordSettings.Create(AForceFullPermission: Boolean);
begin
  FForceFullPermission := AForceFullPermission;
end;

procedure TgtxDocPasswordSettings.Assign(Source: TPersistent);
begin
  if Source is TgtxDocPasswordSettings then
  begin
    FForceFullPermission := TgtxDocPasswordSettings(Source)
      .FForceFullPermission;
    Exit;
  end;
  inherited Assign(Source);
  // else
  // TODO: Throw error
end;

{ TgtxPreferences }
constructor TgtxPreferences.Create(ADocPasswordSettings
  : TgtxDocPasswordSettings);
begin
  FDocPasswordSettings := TgtxDocPasswordSettings.Create(False);
  FDocPasswordSettings.Assign(ADocPasswordSettings);
end;

procedure TgtxPreferences.Assign(Source: TPersistent);
begin
  if Source is TgtxPreferences then
  begin
    FDocPasswordSettings.Assign(TgtxPreferences(Source).FDocPasswordSettings);
    Exit;
  end;
  inherited Assign(Source);
  // else
  // TODO: Throw error
end;

destructor TgtxPreferences.Destroy;
begin
  FDocPasswordSettings.Free;
  inherited;
end;

function TgtxPreferences.GetDocPasswordSettings: TgtxDocPasswordSettings;
begin
  Result := FDocPasswordSettings;
end;

procedure TgtxPreferences.SetDocPasswordSettings(const AValue
  : TgtxDocPasswordSettings);
begin
  FDocPasswordSettings.Assign(AValue);
end;

{ TgtxDocObject }
constructor TgtxDocObject.Create(AApiResponse: TgtxRestAPIDocumentCommon);
var
  LRemoteFileUri: TgtxRemoteFileUri;
begin
  LRemoteFileUri := TgtxRemoteFileUri.Create(AApiResponse.Url);
  inherited Create(LRemoteFileUri);
  FFileName := AApiResponse.FileName;
  FFileSize := AApiResponse.FileSize;
  FPageCount := AApiResponse.PageCount;
  FMimeType := ParseMimeType(AApiResponse.MimeType);
end;

function TgtxDocObject.ParseMimeType(AMimeType: string): TgtxMimeType;
var
  LMimeType: TgtxMimeType;
begin
  LMimeType := TgtxMimeType.mtUnrecognizable;
  if AMimeType.Equals('application/pdf') then
    LMimeType := TgtxMimeType.mtApplication_pdf
  else if AMimeType.Equals('image/bmp') then
    LMimeType := TgtxMimeType.mtImage_bmp
  else if AMimeType.Equals('image/gif') then
    LMimeType := TgtxMimeType.mtImage_gif
  else if AMimeType.Equals('image/jpeg') then
    LMimeType := TgtxMimeType.mtImage_jpeg
  else if AMimeType.Equals('image/png') then
    LMimeType := TgtxMimeType.mtImage_png
  else if AMimeType.Equals('image/tiff') then
    LMimeType := TgtxMimeType.mtImage_tiff
  else if AMimeType.Equals
    ('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
  then
    LMimeType :=
      TgtxMimeType.
      mtApplication_vnd_openxmlformats_officedocument_wordprocessingml_document;
  Result := LMimeType
end;

{ TgtxAuthResponse }
constructor TgtxAuthResponse.Create(ARestAPIResponseAuth
  : TgtxRestAPIResponseAuth);
begin
  FAccessToken := ARestAPIResponseAuth.AccessToken;
  FTokenType := ARestAPIResponseAuth.TokenType;
  FExpiresIn := ARestAPIResponseAuth.ExpiresIn;
end;

{ TgtxFileObject }
constructor TgtxFileObject.Create(ARemoteFileUri: TgtxRemoteFileUri);
begin
  // Assume file is uploaded
  FStream := nil;
  FStreamFileName := '';
  FFileUploaded := True;
  FRemoteFileUri := TgtxRemoteFileUri.Create('');
  FRemoteFileUri.Assign(ARemoteFileUri);
  FLocalFilePath := '';
end;

constructor TgtxFileObject.Create(AStream: TStream; AStreamFileName: string);
begin
  FStream := AStream;
  FStreamFileName := AStreamFileName;
  FFileUploaded := False;
  FRemoteFileUri := nil;
  FLocalFilePath := '';
end;

constructor TgtxFileObject.Create(ALocalFilePath: string);
begin
  FStream := nil;
  FStreamFileName := '';
  FFileUploaded := False;
  FRemoteFileUri := nil;
  FLocalFilePath := ALocalFilePath;
end;

destructor TgtxFileObject.Destroy;
begin
  if FRemoteFileUri <> nil then
    FRemoteFileUri.Free;
  inherited;
end;

function TgtxFileObject.GetFileNameFromUri: string;
begin
  Result := TIdURI.URLDecode(RemoteFileUri.FUri.Document);
end;

function TgtxFileObject.GetRemoteFileUri: TgtxRemoteFileUri;
begin
  Result := FRemoteFileUri;
end;

function TgtxFileObject.GetStream: TStream;
begin
  Result := FStream;
end;

procedure TgtxFileObject.SetRemoteFileUri(const AValue: TgtxRemoteFileUri);
begin
  FRemoteFileUri.Assign(AValue);
end;

procedure TgtxFileObject.SetStream(const AValue: TStream);
begin
  FStream := AValue;
end;

{
  procedure TgtxFileObject.SetUploaded(AUri: string);
  begin
  FFileUploaded := True;
  FRemoteFileUri := TgtxRemoteFileUri.Create(AUri);
  end;
}

{ TgtxRemoteFileUri }
constructor TgtxRemoteFileUri.Create(AUri: TIdURI);
begin
  FUri := TIdURI.Create(AUri.Uri);
end;

constructor TgtxRemoteFileUri.Create(AUri: string);
begin
  FUri := TIdURI.Create(AUri);
end;

destructor TgtxRemoteFileUri.Destroy;
begin
  FUri.Free;
end;

procedure TgtxRemoteFileUri.Assign(Source: TgtxRemoteFileUri);
begin
  if Source <> nil then
    FUri := Source.FUri;
  // else
  // TODO: Throw error
end;

constructor TgtxGetDocumentInfoResponse.Create(AApiResponse: TgtxRestAPIResponseGetDocumentInfo);
begin
  inherited Create(AApiResponse);
  FUnsupportedMimeTypeOrCorrupt := AApiResponse.UnsupportedMimeTypeOrCorrupt;
  FPasswordProtected := AApiResponse.PasswordProtected;
  FPasswordCorrect := AApiResponse.PasswordCorrect;
end;

{
  TgtxDocProperties
  constructor TgtxDocProperties.Create(ATitle, AAuthor, ASubject, AKeywords,
  ACreator: string);
  begin
  Title := ATitle;
  Author := AAuthor;
  Subject := ASubject;
  Keywords := TStringList.Create;
  Keywords.AddStrings(AKeywords.Split([';']));
  Creator := ACreator;
  end;

  procedure TgtxDocProperties.Assign(Source: TgtxDocProperties);
  begin
  if Source <> nil then
  begin
  FTitle := Source.FTitle;
  FAuthor := Source.FAuthor;
  FSubject := Source.FSubject;
  FKeywords := Source.FKeywords;
  FCreator := Source.FCreator;
  end;
  end;

  constructor TgtxDocProperties.Create(ATitle, AAuthor, ASubject: string;
  AKeywords: TStringList; ACreator: string);
  begin
  Title := ATitle;
  Author := AAuthor;
  Subject := ASubject;
  Keywords := AKeywords;
  Creator := ACreator;
  end;

  function TgtxDocProperties.ToJson: string;
  var
  LJsonStr: string;
  begin
  LJsonStr := '"properties":';
  LJsonStr := LJsonStr + '"title":"' + Title + '"';
  LJsonStr := LJsonStr + ',"author":"' + Author + '"';
  LJsonStr := LJsonStr + ',"subject":"' + Subject + '"';
  LJsonStr := LJsonStr + ',"keywords":"' + string.Join(';',
  Keywords.ToStringArray) + '"';
  LJsonStr := LJsonStr + ',"creator":"' + Creator + '"';
  LJsonStr := LJsonStr + '';
  Result := LJsonStr;
  end;

  constructor TgtxPDFDocProperties.Create(ATitle, AAuthor, ASubject: string;
  AKeywords: TStringList; ACreator, AProducer: string;
  AHasExPropertySecurity: Boolean);
  begin
  inherited Create(ATitle, AAuthor, ASubject, AKeywords, ACreator);

  FProducer := AProducer;
  FHasExPropertySecurity := AHasExPropertySecurity;
  end;

  TgtxGetPropertiesResponse
  constructor TgtxGetPropertiesResponse.Create(AApiResponse
  : TgtxRestAPIResponseGetPropertiesPDF);
  var
  LCommonProps: TgtxRestAPIDocPropertiesCommon;
  LExProps: TgtxRestAPIDocExPropertiesPDF;
  LKeywords: TStringList;
  begin
  inherited Create(AApiResponse.Documents[0]);

  LCommonProps := AApiResponse.Documents[0].Properties;
  LExProps := AApiResponse.Documents[0].ExtendedProperties;

  // Parse the semi-colon-seperated keywords into a list
  LKeywords := TStringList.Create;
  LKeywords.AddStrings(LCommonProps.Keywords.Split([';']));
  FDocProperties := TgtxPDFDocProperties.Create(LCommonProps.Title,
  LCommonProps.Author, LCommonProps.Subject, LKeywords, LCommonProps.Creator,
  LCommonProps.Producer, LExProps.HasBookmarks);
  end;

  function TgtxGetPropertiesResponse.GetDocProperties: TgtxDocProperties;
  begin
  Result := FDocProperties;
  end;

  procedure TgtxGetPropertiesResponse.SetDocProperties(const AValue
  : TgtxDocProperties);
  begin
  FDocProperties.Assign(AValue);
  end;
}
{ TgtxDocErrorDetails }
constructor TgtxDocErrorDetails.Create(AUri: string);
begin
  FUri := AUri;
end;

{ EgtxStarDocsException }
constructor EgtxStarDocsException.Create(AHttpStatusCode: Integer;
  AErrorCode: TgtxExceptionStatusCode; const AMessage: string);
begin
  inherited Create(AMessage);
  FHttpStatusCode := AHttpStatusCode;
  FErrorCode := AErrorCode;
end;

constructor EgtxStarDocsException.Create(AHttpStatusCode: Integer;
  AApiResponseStr: string);
var
  FRestAPIResponseError: TgtxRestAPIResponseError;
begin
  if (AApiResponseStr.Length > 0) then
  begin
    FRestAPIResponseError := TJSON.JsonToObject<TgtxRestAPIResponseError>
      (AApiResponseStr);
    Create(AHttpStatusCode, FRestAPIResponseError);
  end
  else
    Create(AHttpStatusCode, TgtxExceptionStatusCode(0), '');
end;

constructor EgtxStarDocsException.Create(AHttpStatusCode: Integer;
  AApiResponse: TgtxRestAPIResponseError);
var
  Li: Integer;
  LNumDocs: Integer;
begin
  inherited Create(AApiResponse.FErrorMessage);
  FHttpStatusCode := AHttpStatusCode;
  FErrorCode := TgtxExceptionStatusCode(AApiResponse.ErrorCode);
  FDocuments := TObjectList<TgtxDocErrorDetails>.Create();
  LNumDocs := Length(AApiResponse.Documents);
  for Li := 0 to LNumDocs - 1 do
    FDocuments.Add(TgtxDocErrorDetails.Create(AApiResponse.FDocuments
      [Li].FUrl));
end;

constructor EgtxStarDocsException.Create(AApiResponse
  : TgtxRestAPIResponseError);
begin

end;

{ TgtxPageRange }
constructor TgtxPageRange.Create(ARange: string);
begin
  FRange := ARange.Trim
end;

{
  procedure TgtxPageRange.Assign(ASource: TgtxPageRange);
  begin
  if ASource <> nil then
  Range := ASource.Range.Trim;
  end;
}

procedure TgtxPageRange.AddPage(APage: Integer);
begin
  if Length(Range) > 0 then
    FRange := FRange + ',';
  FRange := FRange + IntToStr(APage);
end;

procedure TgtxPageRange.AddPages(APages: TList<Integer>);
var
  LIndex: Integer;
  LPageCount: Integer;
begin
  if APages.Count < 1 then
    Exit;
  if Length(FRange) > 0 then
    FRange := FRange + ',';
  LPageCount := APages.Count;
  for LIndex := 0 to LPageCount - 1 do
  begin
    FRange := FRange + IntToStr(APages[LIndex]);
    if (LIndex <> (LPageCount - 1)) then
      FRange := FRange + ',';
  end;
end;

procedure TgtxPageRange.AddRange(AStartPage: Integer; AEndPage: Integer);
begin
  if Length(FRange) > 0 then
    FRange := FRange + ',';
  FRange := FRange + IntToStr(AStartPage) + '-' + IntToStr(AEndPage);
end;

procedure TgtxPageRange.Clear();
begin
  FRange := '';
end;

{ TgtxPageRangeSettings }
constructor TgtxPageRangeSettings.Create(APageRange: string;
  APageSubRangeMode: TgtxPageSubRangeMode = TgtxPageSubRangeMode.psmAll;
  AReverseOrder: Boolean = False);
begin
  FPageRange := TgtxPageRange.Create(APageRange.Trim);
  FPageSubRangeMode := APageSubRangeMode;
  FReverseOrder := AReverseOrder;
end;

constructor TgtxPageRangeSettings.Create(APageRange: TgtxPageRange;
  APageSubRangeMode: TgtxPageSubRangeMode = TgtxPageSubRangeMode.psmAll;
  AReverseOrder: Boolean = False);
var
  LPageRange: string;
begin
  LPageRange := '';
  if APageRange <> nil then
    LPageRange := APageRange.FRange;
  FPageRange := TgtxPageRange.Create(LPageRange);
  FPageSubRangeMode := APageSubRangeMode;
  FReverseOrder := AReverseOrder;
end;

function TgtxPageRangeSettings.GetPageRange: TgtxPageRange;
begin
  Result := FPageRange;
end;

procedure TgtxPageRangeSettings.SetPageRange(const AValue: TgtxPageRange);
begin
  FPageRange := AValue;
end;

function TgtxPageRangeSettings.ToJson(AExcludeOrdering
  : Boolean = False): string;
begin
  Result := '{"range":"' + FPageRange.FRange + '","subRangeMode":"' +
    GetEnumName(TypeInfo(TgtxPageSubRangeMode), Integer(FPageSubRangeMode))
    .Substring(3) + '"';
  if not AExcludeOrdering then
    Result := Result + ',"reverseOrder":' + BooleanToStringName[FReverseOrder];
  Result := Result + '}';
end;

{ TgtxPageSeparator }
constructor TgtxPageSeparator.Create(APageSeparatorType: TgtxPageSeparatorType);
begin
  FPageSeparatorType := APageSeparatorType;
end;

function TgtxPageSeparator.EncodeString: string;
begin
  Result := GetEnumName(TypeInfo(TgtxPageSubRangeMode),
    Integer(FPageSeparatorType)).Substring(3)
end;

{ TgtxSearchText }

constructor TgtxSearchText.Create(AText: string;
  ACaseSensitive: Boolean = False; AWholeWord: Boolean = False);
begin
  FText := AText;
  FCaseSensitive := ACaseSensitive;
  FWholeWord := AWholeWord;
end;

{ TgtxColor }
procedure TgtxColor.Assign(Source: TgtxColor);
begin
  if Source <> nil then
  begin
    FRed := Source.FRed;
    FGreen := Source.FGreen;
    FBlue := Source.FBlue;
    FAlpha := Source.FAlpha;
  end;
end;

constructor TgtxColor.Create(ARed: Byte; AGreen: Byte; ABlue: Byte;
  AAlpha: Byte = 100);
begin
  FRed := ARed;
  FGreen := AGreen;
  FBlue := ABlue;
  FAlpha := AAlpha;
end;

function TgtxColor.EncodeString(AEncodeAlpha: boolean): string;
begin
  // Convert each component to hex string and concatenate them as RRGGBBAA
  Result := '#' + IntToHex(Red, 2) + IntToHex(Green, 2) + IntToHex(Blue, 2);
  if AEncodeAlpha then
    Result := Result + IntToHex(Alpha, 2);
end;

{ TgtxPen }
constructor TgtxPen.Create(AColor: TgtxColor = nil;
  AStyle: TgtxPenStyle = TgtxPenStyle.pstSolid; AWidth: Integer = 1);
begin
  FColor := AColor;
  if FColor = nil then
    FColor := TgtxColor.Create(0, 0, 0);
  FStyle := AStyle;
  FWidth := AWidth;
end;

function TgtxPen.GetColor: TgtxColor;
begin
  Result := FColor;
end;

{ TgtxBrush }
constructor TgtxBrush.Create(AColor: TgtxColor = nil;
  APattern: TgtxBrushPattern = TgtxBrushPattern.bptSolid);
begin
  FColor := AColor;
  if FColor = nil then
    FColor := TgtxColor.Create(0, 0, 0);
  FPattern := APattern;
end;

function TgtxBrush.GetColor: TgtxColor;
begin
  Result := FColor;
end;

{ TgtxOutline }
constructor TgtxOutline.Create(APenColoringMode
  : TgtxColoringMode = TgtxColoringMode.cmoNone; APen: TgtxPen = nil);
begin
  FPenColoringMode := APenColoringMode;
  FPen := APen;
  if FPen = nil then
    FPen := TgtxPen.Create();
end;

function TgtxOutline.GetPen: TgtxPen;
begin
  Result := FPen;
end;

function TgtxOutline.ToJson: string;
begin
  Result := '"outline":{';
  // Encode Color
  Result := Result + '"color":';
  if FPenColoringMode = TgtxColoringMode.cmUseColor then
    Result := Result + ('"' + Pen.Color.EncodeString + '"')
  else
    Result := Result + '"none"';
  // Encode Width
  Result := Result + ',"width":' + IntToStr(Pen.Width);
  // Encode PenStyle
  Result := Result + ',"style":"' + GetEnumName(TypeInfo(TgtxPenStyle),
    Integer(FPen.Style)).Substring(3) + '"';
  Result := Result + '}';
end;

{ TgtxFillRect }
constructor TgtxFillRect.Create(ABrushColoringMode
  : TgtxColoringMode = TgtxColoringMode.cmoNone; ABrush: TgtxBrush = nil);
begin
  FBrushColoringMode := ABrushColoringMode;
  FBrush := ABrush;
  if FBrush = nil then
    FBrush := TgtxBrush.Create();
end;

function TgtxFillRect.ToJson: string;
begin
  Result := '"fill":{';
  // Encode Color
  Result := Result + '"color":';
  if FBrushColoringMode = TgtxColoringMode.cmUseColor then
    Result := Result + ('"' + FBrush.Color.EncodeString + '"')
  else
    Result := Result + '"none"';
  // Encode Pattern
  Result := Result + ',"pattern":"' + GetEnumName(TypeInfo(TgtxBrushPattern),
    Integer(FBrush.Pattern)).Substring(3) + '"';
  Result := Result + '}';
end;

{ TgtxFont }
constructor TgtxFont.Create(AName: String; ASize: Integer;
  AColor: TgtxColor = nil; AStyles: TgtxFontStyles = [];
  AEffects: TgtxFontEffects = []);
begin
  FName := AName;
  FSize := ASize;
  FColor := AColor;
  if FColor = nil then
    FColor := FColor.Create(0, 0, 0);
  FStyles := AStyles;
  FEffects := AEffects;
end;

function TgtxFont.GetColor: TgtxColor;
begin
  Result := FColor;
end;

function TgtxFont.ToJson(AFontSizingMode: TgtxFontSizingMode;
  AFontColoringMode: TgtxFontColoringMode): string;
begin
  Result := '"font":{';
  // Encode Name
  Result := Result + '"name":"' + Name + '"';
  // Encode Style
  Result := Result + ',"style":{';
  Result := Result + '"bold":' + BooleanToStringName[fstBold in FStyles];
  Result := Result + ',"italic":' + BooleanToStringName[fstItalic in FStyles];
  Result := Result + ',"underline":' + BooleanToStringName[fstUnderline in FStyles];
  Result := Result + '}';
  // Encode Size
  if AFontSizingMode = fsmUseFontSize then
    Result := Result + ',"size":' + IntToStr(Size)
  else
    Result := Result + ',"size":"autoFit"';
  // Encode Color
  Result := Result + ',"color":';
  if AFontColoringMode = fcmUseFontColor then
    Result := Result + FColor.EncodeString
  else
    Result := Result + '"source"';

  // Encode Effects
  Result := Result + '}';
end;

{ TgtxFillText }
constructor TgtxFillText.Create(AReplaceText: String;
  AFontSelectionMode: TgtxFontSelectionMode = TgtxFontSelectionMode.fsmUseFont;
  AFontSizingMode: TgtxFontSizingMode = TgtxFontSizingMode.fsmAutoFit;
  AFontColoringMode: TgtxFontColoringMode = TgtxFontColoringMode.fcmSource;
  AFont: TgtxFont = nil);
begin
  FReplaceText := AReplaceText;
  FFontSelectionMode := AFontSelectionMode;
  FFontSizingMode := AFontSizingMode;
  FFontColoringMode := AFontColoringMode;
  FFont := AFont;
  if FFont = nil then
    FFont := TgtxFont.Create('Arial', 10, TgtxColor.Create(0, 0, 0));
end;

function TgtxFillText.GetFont: TgtxFont;
begin
  Result := FFont;
end;

function TgtxFillText.ToJson: string;
begin
  Result := '"text":{';
  // Encode Text
  Result := Result + '"replaceText":"' + ReplaceText + '"';
  // Encode Font
  if FFontSelectionMode = TgtxFontSelectionMode.fsmUseFont then
    Result := Result + ',' + FFont.ToJson(FFontSizingMode, FFontColoringMode)
  else
    Result := Result + ',"font":"source"';
  // Encode Alignment
  // jsonStr += ",\"hAlign\":\"" + EnumToString.HAlignmentTypeToString(HAlign) + "\"";
  // jsonStr += ",\"vAlign\":\"" + EnumToString.VAlignmentTypeToString(VAlign) + "\"";
  // Encode Repeat and Wrap
  // jsonStr += ",\"repeat\":" + Repeat.ToString().ToLower();
  // jsonStr += ",\"wrap\":" + Wrap.ToString().ToLower();
  Result := Result + '}';
end;

{ TgtxRedactFillSettings }

constructor TgtxRedactFillSettings.Create(AOutline: TgtxOutline = nil;
  AFillRect: TgtxFillRect = nil; AFillText: TgtxFillText = nil);
begin
  FOutline := AOutline;
  if FOutline = nil then
    FOutline := TgtxOutline.Create();
  FFillRect := AFillRect;
  if FFillRect = nil then
    FFillRect := TgtxFillRect.Create();
  FFillText := AFillText;
  if FFillText = nil then
    FFillText := TgtxFillText.Create('');
end;

function TgtxRedactFillSettings.GetFillRect: TgtxFillRect;
begin
  Result := FFillRect;
end;

function TgtxRedactFillSettings.GetFillText: TgtxFillText;
begin
  Result := FFillText;
end;

function TgtxRedactFillSettings.GetOutline: TgtxOutline;
begin
  Result := FOutline;
end;

function TgtxRedactFillSettings.ToJson(): string;
begin
  Result := '"fillSettings":{';
  Result := Result + FOutline.ToJson;
  Result := Result + ',' + FFillRect.ToJson;
  Result := Result + ',' + FFillText.ToJson;
  Result := Result + '}';
end;

{ TgtxEncoderSettings }
function TgtxEncoderSettings.ToJson: string;
begin
  Result := '';
end;

{ TgtxDPI }
constructor TgtxDPI.Create(AResolutionMode
  : TgtxResolutionMode = TgtxResolutionMode.rmmUseSource; AX: Integer = 72;
  AY: Integer = 72);
begin
  FResolutionMode := AResolutionMode;
  FX := AX;
  FY := AY;
end;

function TgtxDPI.ToJson: String;
begin
  Result := '"dpi": {"resolutionMode":"' +
    GetEnumName(TypeInfo(TgtxResolutionMode), Integer(FResolutionMode))
    .Substring(3) + '"';
  if FResolutionMode = TgtxResolutionMode.rmmUseSpecifiedDPI then
  begin
    Result := Result + ',"x":' + IntToStr(FX);
    Result := Result + ',"y":' + IntToStr(FY);
  end;
  Result := Result + '}';
end;

{ TgtxSize }
constructor TgtxSize.Create(APaperSize: TgtxPaperSize = TgtxPaperSize.psiA4;
  AWidth: Integer = 0; AHeight: Integer = 0;
  AMeasurementUnit: TgtxMeasurementUnit = TgtxMeasurementUnit.munMillimeters);
begin
  FPaperSize := APaperSize;
  FWidth := AWidth;
  FHeight := AHeight;
  FMeasurementUnit := AMeasurementUnit;
end;

function TgtxSize.EncodeString: String;
begin
  if FPaperSize = TgtxPaperSize.psiCustom then
    Result := IntToStr(FWidth) + ';' + IntToStr(FHeight) + ';' +
      GetEnumName(TypeInfo(TgtxPaperSize), Integer(FPaperSize)).Substring(3)
  else
    Result := GetEnumName(TypeInfo(TgtxPaperSize), Integer(FPaperSize))
      .Substring(3);
end;

{ TgtxCanvasSize }
constructor TgtxCanvasSize.Create(ASizingMode
  : TgtxCanvasSizingMode = TgtxCanvasSizingMode.csmUseSource;
  ASize: TgtxSize = nil; ARelativeSizeX: Integer = 100;
  ARelativeSizeY: Integer = 100);
begin
  FSizingMode := ASizingMode;
  FSize := ASize;
  if FSize = nil then
    FSize := TgtxSize.Create();
  FRelativeSizeX := ARelativeSizeX;
  FRelativeSizeY := ARelativeSizeY;
end;

function TgtxCanvasSize.ToJson: String;
begin
  Result := '"canvasSize": { "sizingMode": "' +
    GetEnumName(TypeInfo(TgtxCanvasSizingMode), Integer(FSizingMode))
    .Substring(3) + '"';
  if FSizingMode = TgtxCanvasSizingMode.csmUseSpecifiedSize then
    Result := Result + ',"size": "' + FSize.EncodeString() + '"'
  else if FSizingMode = TgtxCanvasSizingMode.csmUseSpecifiedRelativeSize then
  begin
    Result := Result + ',"relativeSizeX": ' + IntToStr(FRelativeSizeX);
    Result := Result + ',"relativeSizeY": ' + IntToStr(FRelativeSizeY);
  end;
  Result := Result + '}';
end;

{ TgtxContentAlignment }
procedure TgtxContentAlignment.Assign(Source: TgtxContentAlignment);
begin
  if Source <> nil then
  begin
    FHorizontalAlignmentType := Source.FHorizontalAlignmentType;
    FHorizontalOffset := Source.FHorizontalOffset;
    FVerticalAlignmentType := Source.FVerticalAlignmentType;
    FVerticalOffset := Source.FVerticalOffset;
  end;
end;

constructor TgtxContentAlignment.Create(AHorizontalAlignmentType
  : TgtxHorizontalAlignmentType = TgtxHorizontalAlignmentType.hatCenter;
  AHorizontalOffset: Integer = 0;
  AVerticalAlignmentType: TgtxVerticalAlignmentType = TgtxVerticalAlignmentType.
  vatCenter; AVerticalOffset: Integer = 0);
begin
  FHorizontalAlignmentType := AHorizontalAlignmentType;
  FHorizontalOffset := AHorizontalOffset;
  FVerticalAlignmentType := AVerticalAlignmentType;
  FVerticalOffset := AVerticalOffset;
end;

function TgtxContentAlignment.ToJson: String;
begin
  Result := '"contentAlignment ": { "horizontalAlignment": "' +
    GetEnumName(TypeInfo(TgtxHorizontalAlignmentType),
    Integer(FHorizontalAlignmentType)).Substring(3) + '"';
  Result := Result + ',"horizontalOffset": ' + IntToStr(FHorizontalOffset);
  Result := Result + ',"verticalAlignment": "' +
    GetEnumName(TypeInfo(TgtxVerticalAlignmentType),
    Integer(FVerticalAlignmentType)).Substring(3) + '"';
  Result := Result + ',"verticalOffset": ' + IntToStr(FVerticalOffset);
  Result := Result + '}';
end;

{ TgtxImageEncoderSettings }
constructor TgtxImageEncoderSettings.Create(ADPI: TgtxDPI = nil;
  AQuality: Byte = 80; ACanvasSize: TgtxCanvasSize = nil;
  AScaling: TgtxContentScaling = TgtxContentScaling.cscFitWithAspect;
  AAlignment: TgtxContentAlignment = nil);
begin
  FDPI := ADPI;
  if FDPI = nil then
    FDPI := TgtxDPI.Create();
  FQuality := AQuality;
  FCanvasSize := ACanvasSize;
  if FCanvasSize = nil then
    FCanvasSize := TgtxCanvasSize.Create();
  FContentScaling := AScaling;
  FContentAlignment := AAlignment;
  if FContentAlignment = nil then
    FContentAlignment := TgtxContentAlignment.Create();
end;

function TgtxImageEncoderSettings.GetContentAlignment: TgtxContentAlignment;
begin
  Result := FContentAlignment;
end;

procedure TgtxImageEncoderSettings.SetContentAlignment
  (const AValue: TgtxContentAlignment);
begin
  FContentAlignment.Assign(AValue);
end;

function TgtxImageEncoderSettings.ToJson(): string;
begin
  Result := '"imageEncoderSettings":{';
  Result := Result + FDPI.ToJson();
  Result := Result + ',"quality":' + IntToStr(FQuality);
  Result := Result + ',' + FCanvasSize.ToJson();
  Result := Result + ',"contentScaling":"' +
    GetEnumName(TypeInfo(TgtxContentScaling), Integer(FContentScaling))
    .Substring(3) + '"';
  Result := Result + ',' + FContentAlignment.ToJson();
  Result := Result + '}';
end;

{ TgtxPDFPortfolioSettings }
constructor TgtxPDFPortfolioSettings.Create(APDFPortfolioCreationMode
  : TgtxPDFPortfolioCreationMode = TgtxPDFPortfolioCreationMode.
  pcmWhenInputIsPortfolio; APDFPortfolioInitialLayout
  : TgtxPDFPortfolioInitialLayout = TgtxPDFPortfolioInitialLayout.pilDetails);
begin
  FPDFPortfolioCreationMode := APDFPortfolioCreationMode;
  FPDFPortfolioInitialLayout := APDFPortfolioInitialLayout;
end;

function TgtxPDFPortfolioSettings.ToJson: String;
begin
  Result := '"portfolioSettings":{';
  Result := Result + '"creationMode": "' +
    GetEnumName(TypeInfo(TgtxPDFPortfolioCreationMode),
    Integer(FPDFPortfolioCreationMode)).Substring(3) + '"';
  Result := Result + ',"initialLayout": "' +
    GetEnumName(TypeInfo(TgtxPDFPortfolioInitialLayout),
    Integer(FPDFPortfolioInitialLayout)).Substring(3) + '"';
  Result := Result + '}';
end;

{ TgtxPDFEncoderSettings }
constructor TgtxPDFEncoderSettings.Create(APDFPortfolioSettings
  : TgtxPDFPortfolioSettings;
  AFontEmbeddingType: TgtxFontEmbeddingType = TgtxFontEmbeddingType.fetSubset;
  AOverrideFontEmbeddingRestriction: Boolean = False);
begin
  FPDFPortfolioSettings := APDFPortfolioSettings;
  if FPDFPortfolioSettings = nil then
    FPDFPortfolioSettings := TgtxPDFPortfolioSettings.Create();
  FFontEmbeddingType := AFontEmbeddingType;
  FOverrideFontEmbeddingRestriction := AOverrideFontEmbeddingRestriction;
end;

function TgtxPDFEncoderSettings.GetPDFPortfolioSettings
  : TgtxPDFPortfolioSettings;
begin
  Result := FPDFPortfolioSettings;
end;

procedure TgtxPDFEncoderSettings.SetPDFPortfolioSettings
  (const AValue: TgtxPDFPortfolioSettings);
begin
  FPDFPortfolioSettings := AValue;
end;

function TgtxPDFEncoderSettings.ToJson(): string;
begin
  Result := '"pdfEncoderSettings":{';
  Result := Result + FPDFPortfolioSettings.ToJson();
  Result := Result + '"fontEmbedding":"' +
    GetEnumName(TypeInfo(TgtxFontEmbeddingType), Integer(FFontEmbeddingType))
    .Substring(3) + '"';
  Result := Result + ',"overrideFontEmbeddingRestriction":' +
    BooleanToStringName[FOverrideFontEmbeddingRestriction];
  Result := Result + '}';
end;

{ TgtxAuth }
constructor TgtxAuth.Create(AStarDocs: TgtxStarDocsSDK);
begin
  FStarDocs := AStarDocs;
end;

function TgtxAuth.loginApp(AEntity: string = ''): TgtxAuthResponse;
var
  LRestRequest: TRestRequest;
  LRestResp: THttpResponse;
  LResponseError: TgtxRestAPIResponseAuthFailure;
  LResponseSuccess: TgtxRestAPIResponseAuth;
begin
  LRestRequest := TRestRequest.Create();
  Result := nil;
  try
    LRestRequest.Domain(FStarDocs.FConnectionInfo.FApiServerUri.Uri)
      .Path('auth/token').WithCredentials(FStarDocs.FConnectionInfo.FAppKey,
      FStarDocs.FConnectionInfo.FAppSecret);
    if AEntity <> '' then
    begin
      LRestRequest.Param('entity_id', AEntity);
    end;
    // LRestRequest.Param('grant_type', 'client_credentials');
    LRestRequest.ContentType := 'application/x-www-form-urlencoded';
    LRestResp := LRestRequest.Post('grant_type=client_credentials');
    if LRestResp.ResponseCode <> 200 then
    begin
      if LRestResp.ResponseContentType.Equals('application/json') = True then
      begin
        LResponseError := TJSON.JsonToObject<TgtxRestAPIResponseAuthFailure>
          (LRestResp.ResponseStr);
        raise EgtxStarDocsException.Create(LRestResp.ResponseCode,
          TgtxExceptionStatusCode(0), LResponseError.Error + ':' +
          LResponseError.ErrorDescription + ':' + LResponseError.ErrorUri);
      end;
      raise EgtxStarDocsException.Create(LRestResp.ResponseCode,
        TgtxExceptionStatusCode(0), LRestResp.ResponseStr);
    end;
    LResponseSuccess := TJSON.JsonToObject<TgtxRestAPIResponseAuth>
      (LRestResp.ResponseStr);
    Result := TgtxAuthResponse.Create(LResponseSuccess);
  finally
    LRestRequest.Free;
  end;
end;

{ TgtxStorage }
constructor TgtxStorage.Create(AStarDocs: TgtxStarDocsSDK);
begin
  FStarDocs := AStarDocs;
end;

function TgtxStorage.Upload(AFileNameWithPath: string; APassword: string = '')
  : TgtxDocObject;
var
  LRestResponse: THttpResponse;
  LRestRequest: TRestRequest;
  LResponseCommon: TgtxRestAPIResponseCommon;
  // LResponseError: TgtxRestAPIResponseError;
begin
  LRestRequest := TRestRequest.Create();
  Result := nil;
  try
    LRestRequest.Domain(FStarDocs.FConnectionInfo.FApiServerUri.Uri)
      .Path('docs').WithReadTimeout(FStarDocs.FConnectionInfo.FServerTimeout)
      .WithBearerToken(FStarDocs.FAuthResponse.AccessToken);
    LRestRequest.FileParam('fileUpload', AFileNameWithPath);
    LRestRequest.Param('password', APassword);
    LRestRequest.Param('forceFullPermission',
      BooleanToStringName[FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission]);
    LRestResponse := LRestRequest.Post('');
    if LRestResponse.ResponseCode <> 200 then
      raise EgtxStarDocsException.Create(LRestResponse.ResponseCode,
        LRestResponse.ResponseStr);
    LResponseCommon := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
      (LRestResponse.ResponseStr);
    Result := TgtxDocObject.Create(LResponseCommon.Documents[0]);
  finally
    LRestRequest.Free;
  end;
end;

function TgtxStorage.Upload(AStream: TStream; AfileName: string;
  APassword: string = ''): TgtxDocObject;
var
  LRestResp: THttpResponse;
  LRestRequest: TRestRequest;
  LResponseCommon: TgtxRestAPIResponseCommon;
  // LResponseError: TgtxRestAPIResponseError;
begin
  Result := nil;
  LRestRequest := TRestRequest.Create();
  try
    LRestRequest.Domain(FStarDocs.FConnectionInfo.FApiServerUri.Uri)
      .Path('docs').WithReadTimeout(FStarDocs.FConnectionInfo.FServerTimeout)
      .WithBearerToken(FStarDocs.FAuthResponse.AccessToken);
    LRestRequest.FileParam('fileUpload', AfileName, AStream);
    LRestRequest.Param('password', APassword);
    LRestRequest.Param('forceFullPermission',
      BooleanToStringName[FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission]);
    LRestResp := LRestRequest.Post('');
    if LRestResp.ResponseCode <> 200 then
      raise EgtxStarDocsException.Create(LRestResp.ResponseCode,
        LRestResp.ResponseStr);
    LResponseCommon := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
      (LRestResp.ResponseStr);
    Result := TgtxDocObject.Create(LResponseCommon.Documents[0]);
  finally
    LRestRequest.Free;
  end;
end;

procedure TgtxStorage.Download(AFile: TgtxFileObject; AFilePath: string);
var
  LOutStream: TFileStream;
  LFileName: string;
begin
  // Ensure we have a valid URI
  if (not AFile.FileUploaded) or (AFile.RemoteFileUri = nil) then
    // Invalid URI
    raise Exception.Create('File not on server or invalid URI');

  AFilePath := AFilePath.Trim;
  if AFilePath = '' then
    AFilePath := GetCurrentDir
  else
    // Check if directory exists, if not create it
    if not DirectoryExists(AFilePath) then
      CreateDir(AFilePath);

  // Check if the file name is present in the path
  if ExtractFileName(AFilePath) = '' then
  begin
    if AFile.ClassType = TgtxDocObject then
      LFileName := TgtxDocObject(AFile).FileName
    else
      // Append file name from URI
      LFileName := AFile.GetFileNameFromUri;
    if AFilePath.EndsWith(PathDelim) then
      AFilePath := AFilePath + LFileName
    else
      AFilePath := AFilePath + PathDelim + LFileName
  end;

  LOutStream := nil;
  try
    LOutStream := TFileStream.Create(AFilePath, fmCreate);
    Download(AFile, LOutStream);
  finally
    LOutStream.Free;
  end;
end;

procedure TgtxStorage.Download(AFile: TgtxFileObject; FOutStream: TStream);
var
  LRestRequest: TRestRequest;
  LRestResponse: THttpResponse;
  LDocUri: string;
begin
  LDocUri := AFile.RemoteFileUri.Uri.Uri;
  LRestRequest := TRestRequest.Create;
  LRestRequest.Domain(LDocUri).WithReadTimeout
    (FStarDocs.FConnectionInfo.FServerTimeout)
    .WithBearerToken(FStarDocs.FAuthResponse.AccessToken);
  try
    LRestResponse := LRestRequest.GetToStream(FOutStream);
    if LRestResponse.ResponseCode <> 200 then
      raise EgtxStarDocsException.Create(LRestResponse.ResponseCode,
        LRestResponse.ResponseStr);
    if not LRestResponse.ResponseContentType.Equals('multipart/form-data') then
      raise EgtxStarDocsException.Create(0,
        TgtxExceptionStatusCode.escUnexpectedResponse,
        'Unexpected response type during download');
  finally
    LRestRequest.Free;
  end;
end;

{ TgtxDocOperations }
constructor TgtxDocOperations.Create(AStarDocs: TgtxStarDocsSDK);
begin
  FStarDocs := AStarDocs;
end;

function TgtxDocOperations.GetDocumentInfo(AFile: TgtxFileObject;
  APassword: string = ''): TgtxGetDocumentInfoResponse;
var
  LUrl: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseGetDocumentInfo;
begin
  LUrl := FStarDocs.GetDocUri(AFile) + '/info';
  LUrl :=  LUrl + ('?force-full-permission=' +
    BooleanToStringName[FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission]);
  if APassword <> '' then
    LUrl :=  LUrl + ('&password=' + APassword);
  LJsonResponseStr := FStarDocs.IssueGetRequestAndPoll(LUrl);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseGetDocumentInfo>
    (LJsonResponseStr);
  Result := TgtxGetDocumentInfoResponse.Create(LJsonResponse);
end;

(*
  function TgtxDocOperations.GetProperties(AFile: TgtxFileObject; APassword: string = ''): TgtxGetPropertiesResponse;
  var
  LDocUri: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseGetPropertiesPDF;
  begin
  LDocUri := GetDocUri(AFile);
  LJsonStr := '{"operation":"getProperties","documents":[{"uri":"' + LDocUri + '"';
  LJsonStr := LJsonStr + ',"password":"' + APassword + '"}]';
  LJsonStr := LJsonStr + '}';

  LJsonResponseStr := IssueRequestAndPoll(LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseGetPropertiesPDF>(LJsonResponseStr);
  Result := TgtxGetPropertiesResponse.Create(LJsonResponse);
  end;

  function TgtxDocOperations.SetProperties(AFile: TgtxFileObject; APassword: string; AProperties: TgtxDocProperties)
  : TgtxDocObject;
  var
  LDocUri: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
  begin
  LDocUri := GetDocUri(AFile);
  LJsonStr := '{"operation":"setProperties","documents":[{"uri":"' + LDocUri + '"';
  LJsonStr := LJsonStr + ',"password":"' + APassword + '"';
  LJsonStr := LJsonStr + ',' + AProperties.ToJson;
  LJsonStr := LJsonStr + '}]';
  if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
  LJsonStr := LJsonStr + ',"forceFullPermission":true';
  LJsonStr := LJsonStr + '}';

  LJsonResponseStr := IssueRequestAndPoll(LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>(LJsonResponseStr);
  Result := TgtxDocObject.Create(LJsonResponse.Documents[0]);
  end;
*)

function TgtxDocOperations.Merge(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil): TgtxDocObject;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LNumFiles := AFiles.Count;
  LDocUris := TStringList.Create;
  try
    for LIndex := 0 to LNumFiles - 1 do
      LDocUris.Add(FStarDocs.GetDocUri(AFiles[LIndex]));

    LJsonStr := '{' + FStarDocs.EncodeJsonDocuments(LDocUris, APasswords,
      APageRanges);
    if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
      LJsonStr := LJsonStr + ',"forceFullPermission":true';
    LJsonStr := LJsonStr + '}';
    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri + '/docs/ops/merge';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TgtxDocObject.Create(LJsonResponse.Documents[0]);
  finally
    LDocUris.Free;
  end;
end;

function TgtxDocOperations.SplitByPageRange(AFile: TgtxFileObject;
  APassword: string = ''; APageRanges: TObjectList<TgtxPageRangeSettings> = nil)
  : TObjectList<TgtxDocObject>;
var
  LDocUrl: string;
  LUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);
  LJsonStr := '{"documents":[{"url":"' + LDocUrl + '","password":"' +
    APassword + '"';
  if APageRanges <> nil then
    LJsonStr := LJsonStr + ',' + EncodeJsonPageRanges(APageRanges);
  LJsonStr := LJsonStr + '}]}';
  LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri + '/docs/ops/split-range';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TObjectList<TgtxDocObject>.Create;
  LNumFiles := Length(LJsonResponse.Documents);
  for LIndex := 0 to LNumFiles - 1 do
    Result.Add(TgtxDocObject.Create(LJsonResponse.Documents[LIndex]));
end;

function TgtxDocOperations.SplitBySeparatorPage(AFile: TgtxFileObject;
  APassword: string = ''; APageSeparator: TgtxPageSeparator = nil)
  : TObjectList<TgtxDocObject>;
var
  LDocUrl: string;
  LUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);
  LJsonStr := '{"documents":[{"url":"' + LDocUrl + '","password":"' +
    APassword + '"';
  if APageSeparator = nil then
    APageSeparator := TgtxPageSeparator.Create
      (TgtxPageSeparatorType.pstEmptyPage);
  LJsonStr := LJsonStr + ',"separatorType":"' +
    APageSeparator.EncodeString + '"';
  LJsonStr := LJsonStr + '}]}';
  LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
    '/docs/ops/split-separator';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TObjectList<TgtxDocObject>.Create;
  LNumFiles := Length(LJsonResponse.Documents);
  for LIndex := 0 to LNumFiles - 1 do
    Result.Add(TgtxDocObject.Create(LJsonResponse.Documents[LIndex]));
end;

function TgtxDocOperations.Encrypt(AFile: TgtxFileObject; APassword: string;
  APDFEncryptionLevel: TgtxPDFEncryptionLevel = TgtxPDFEncryptionLevel.
  pelAES_128bit; ANewOpenPassword: string = '';
  ANewPermissionsPassword: string = '';
  ANewPermissions: TgtxPDFDocPermissions = []): TgtxDocObject;
var
  LUrl: string;
  LDocUrl: string;
  LEncryptionLevelStr: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);
  LEncryptionLevelStr := GetEnumName(TypeInfo(TgtxPDFEncryptionLevel),
    Integer(APDFEncryptionLevel)).Substring(3);

  LJsonStr := '{"encryptionLevel":"' + LEncryptionLevelStr + '"';
  LJsonStr := LJsonStr + ',"password":"' + APassword + '"';
  if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
    LJsonStr := LJsonStr + ',"forceFullPermission":true';

  LJsonStr := LJsonStr + ',"newOpenPassword":"' + ANewOpenPassword + '"';
  LJsonStr := LJsonStr + ',"newPermissionsPassword":"' +
    ANewPermissionsPassword + '"';
  LJsonStr := LJsonStr + ',"newPermissions":{' +
    SetToCSV(ANewPermissions) + '}';
  LJsonStr := LJsonStr + '}';

  LUrl := LDocUrl + '/ops/encrypt';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, False,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TgtxDocObject.Create(LJsonResponse.Documents[0]);
end;

function TgtxDocOperations.FillForm(AFile: TgtxFileObject; APassword: string;
  AformFields: TObjectList<TgtxPDFFormFieldFillData>) : TgtxDocObject;
var
  LUrl: string;
  LDocUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);

  LJsonStr := '{';
  LJsonStr := LJsonStr + ',"forceFullPermission":' + BooleanToStringName[FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission];

  if APassword <> '' then
    LJsonStr := LJsonStr + ',"password":"' + APassword + '"';

  if AformFields <> Nil then
    LJsonStr := LJsonStr + ',' + EncodeFormFieldFillData(AformFields);

  LJsonStr := LJsonStr + '}';

  LUrl := LDocUrl + '/ops/fill-form';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, False,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TgtxDocObject.Create(LJsonResponse.Documents[0]);
end;

function TgtxDocOperations.RedactText(AFile: TgtxFileObject; APassword: string;
  APageRange: TgtxPageRangeSettings; ATextSearchMode: TgtxTextSearchMode;
  ASearchText: TObjectList<TgtxSearchText>;
  AFillSettings: TgtxRedactFillSettings = nil;
  AIncludeAdditionalItems: TgtxDocumentItems = [];
  ACleanupSettings: TgtxRedactCleanupSettings = []): TgtxDocObject;
var
  LUrl: string;
  LDocUrl: string;
  LTextSearchModeStr: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);
  LTextSearchModeStr := GetEnumName(TypeInfo(TgtxTextSearchMode),
    Integer(ATextSearchMode)).Substring(3);

  LJsonStr := '{"searchMode":"' + LTextSearchModeStr + '"';
  LJsonStr := LJsonStr + ',"password":"' + APassword + '"';

  if APageRange <> nil then
    LJsonStr := LJsonStr + ',"pageRange":' + APageRange.ToJson();

  if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
    LJsonStr := LJsonStr + ',"forceFullPermission":true';

  LJsonStr := LJsonStr + ',' + EncodeJsonSearchText(ASearchText);

  if AFillSettings <> nil then
    LJsonStr := LJsonStr + ',' + AFillSettings.ToJson();

  LJsonStr := LJsonStr + ', "includeAdditionalItems": {' +
    SetToCSV(AIncludeAdditionalItems) + '}';
  LJsonStr := LJsonStr + ', "cleanupSettings": {' +
    SetToCSV(ACleanupSettings) + '}';
  LJsonStr := LJsonStr + '}';

  LUrl := LDocUrl + '/ops/redact-text';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, False,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TgtxDocObject.Create(LJsonResponse.Documents[0]);
end;

function TgtxDocOperations.ConvertToTIFF(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
  AImageEncoderSettings: TgtxImageEncoderSettings = nil;
  ATIFFCompressionType: TgtxTIFFCompressionType = TgtxTIFFCompressionType.
  tctDeflate): TObjectList<TgtxDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LNumFiles := AFiles.Count;
  LDocUris := TStringList.Create;
  try
    for LIndex := 0 to LNumFiles - 1 do
      LDocUris.Add(FStarDocs.GetDocUri(AFiles[LIndex]));

    LJsonStr := '{' + FStarDocs.EncodeJsonDocuments(LDocUris, APasswords,
      APageRanges);
    if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
      LJsonStr := LJsonStr + ',"forceFullPermission":true';
    if AImageEncoderSettings <> nil then
      LJsonStr := LJsonStr + (',' + AImageEncoderSettings.ToJson());
    LJsonStr := LJsonStr + ',"tiffCompressionType":"' +
      GetEnumName(TypeInfo(TgtxTIFFCompressionType),
      Integer(ATIFFCompressionType)).Substring(3) + '"';
    LJsonStr := LJsonStr + '}';

    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
      '/docs/ops/convert-tiff';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtxDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtxDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtxDocOperations.ConvertToMTIFF(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
  AImageEncoderSettings: TgtxImageEncoderSettings = nil;
  ATIFFCompressionType: TgtxTIFFCompressionType = TgtxTIFFCompressionType.
  tctDeflate; AConversionMode
  : TgtxMTIFFConversionMode = TgtxMTIFFConversionMode.tcmConvertToSeparateFiles)
  : TObjectList<TgtxDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LNumFiles := AFiles.Count;
  LDocUris := TStringList.Create;
  try
    for LIndex := 0 to LNumFiles - 1 do
      LDocUris.Add(FStarDocs.GetDocUri(AFiles[LIndex]));

    LJsonStr := '{' + FStarDocs.EncodeJsonDocuments(LDocUris, APasswords,
      APageRanges);
    if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
      LJsonStr := LJsonStr + ',"forceFullPermission":true';
    if AImageEncoderSettings <> nil then
      LJsonStr := LJsonStr + (',' + AImageEncoderSettings.ToJson());
    LJsonStr := LJsonStr + ',"tiffCompressionType":"' +
      GetEnumName(TypeInfo(TgtxTIFFCompressionType),
      Integer(ATIFFCompressionType)).Substring(3) + '"';
    LJsonStr := LJsonStr + ',"conversionMode":"' +
      GetEnumName(TypeInfo(TgtxMTIFFConversionMode), Integer(AConversionMode))
      .Substring(3) + '"';
    LJsonStr := LJsonStr + '}';

    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
      '/docs/ops/convert-mtiff';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtxDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtxDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtxDocOperations.ConvertToJPEG(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
  AImageEncoderSettings: TgtxImageEncoderSettings = nil)
  : TObjectList<TgtxDocObject>;
begin
  Result := ConvertToImage('convert-jpeg', AFiles, APasswords, APageRanges,
    AImageEncoderSettings);
end;

function TgtxDocOperations.ConvertToGIF(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
  AImageEncoderSettings: TgtxImageEncoderSettings = nil)
  : TObjectList<TgtxDocObject>;
begin
  Result := ConvertToImage('convert-gif', AFiles, APasswords, APageRanges,
    AImageEncoderSettings);
end;

function TgtxDocOperations.ConvertToBMP(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
  AImageEncoderSettings: TgtxImageEncoderSettings = nil)
  : TObjectList<TgtxDocObject>;
begin
  Result := ConvertToImage('convert-bmp', AFiles, APasswords, APageRanges,
    AImageEncoderSettings);
end;

function TgtxDocOperations.ConvertToPNG(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
  AImageEncoderSettings: TgtxImageEncoderSettings = nil)
  : TObjectList<TgtxDocObject>;
begin
  Result := ConvertToImage('convert-png', AFiles, APasswords, APageRanges,
    AImageEncoderSettings);
end;

function TgtxDocOperations.ConvertToPDF(AFiles: TObjectList<TgtxFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtxPageRangeSettings> = nil;
  APDFEncoderSettings: TgtxPDFEncoderSettings = nil;
  AConversionMode: TgtxPDFConversionMode = TgtxPDFConversionMode.
  pcmConvertToSeparateFiles): TObjectList<TgtxDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LNumFiles := AFiles.Count;
  LDocUris := TStringList.Create;
  try
    for LIndex := 0 to LNumFiles - 1 do
      LDocUris.Add(FStarDocs.GetDocUri(AFiles[LIndex]));

    LJsonStr := '{' + FStarDocs.EncodeJsonDocuments(LDocUris, APasswords,
      APageRanges);
    if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
      LJsonStr := LJsonStr + ',"forceFullPermission":true';
    if TgtxPDFEncoderSettings <> nil then
      LJsonStr := LJsonStr + (',' + APDFEncoderSettings.ToJson);
    LJsonStr := LJsonStr + ',"conversionMode": ' +
      GetEnumName(TypeInfo(TgtxPDFConversionMode), Integer(AConversionMode))
      .Substring(3) + '"';
    LJsonStr := LJsonStr + '}';

    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
      '/docs/ops/convert-pdf';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtxDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtxDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtxDocOperations.ConvertToImage(AUrlPath: string;
  AFiles: TObjectList<TgtxFileObject>; APasswords: TStringList;
  APageRanges: TObjectList<TgtxPageRangeSettings>;
  AImageEncoderSettings: TgtxImageEncoderSettings): TObjectList<TgtxDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCommon;
begin
  LNumFiles := AFiles.Count;
  LDocUris := TStringList.Create;
  try
    for LIndex := 0 to LNumFiles - 1 do
      LDocUris.Add(FStarDocs.GetDocUri(AFiles[LIndex]));

    LJsonStr := '{' + FStarDocs.EncodeJsonDocuments(LDocUris, APasswords,
      APageRanges);
    if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
      LJsonStr := LJsonStr + ',"forceFullPermission":true';
    if AImageEncoderSettings <> nil then
      LJsonStr := LJsonStr + (',' + AImageEncoderSettings.ToJson());
    LJsonStr := LJsonStr + '}';

    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri + '/docs/ops/'
      + AUrlPath;
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtxDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtxDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtxDocOperations.EncodeFormFieldFillData
  (AformFields: TObjectList<TgtxPDFFormFieldFillData>): string;
var
  LJsonStr: String;
  I: Integer;
  LformField: TgtxPDFFormFieldFillData;
begin
  LJsonStr := '"fields": [';
  for I := 0 to AformFields.Count - 1 do
  begin
    LformField := AformFields[I];
    if (I > 0) then
      LJsonStr := LJsonStr + ',';

    LJsonStr := LJsonStr + '{';
    LJsonStr := LJsonStr + '"fieldName":"' + LformField.FieldName + '"';
    LJsonStr := LJsonStr + ',"fieldValue":"' + LformField.FieldValue + '"';
    LJsonStr := LJsonStr + ',"flattenField":' + BooleanToStringName[LformField.FlattenField];
    LJsonStr := LJsonStr + '}';
  end;
  LJsonStr := LJsonStr + ']';
  Result := LJsonStr;
end;

function TgtxDocOperations.EncodeJsonPageRanges(APageRanges
  : TObjectList<TgtxPageRangeSettings>): string;
var
  LIndex: Integer;
begin
  Result := '"pageRanges":[';
  if APageRanges = nil then
  begin
    Result := Result + ']';
    Exit;
  end;
  for LIndex := 0 to APageRanges.Count - 1 do
  begin
    if LIndex > 0 then
      Result := Result + ',';
    Result := Result + APageRanges[LIndex].ToJson(True);
  end;
  Result := Result + ']';
end;

function TgtxDocOperations.EncodeJsonSearchText(ASearchText
  : TObjectList<TgtxSearchText>): string;
var
  LJsonStr: string;
  LIndex: Integer;
  LSearchText: TgtxSearchText;
begin
  LJsonStr := '"searchText":[';
  for LIndex := 0 to ASearchText.Count - 1 do
  begin
    if LIndex > 0 then
      LJsonStr := LJsonStr + ',';
    LSearchText := ASearchText[LIndex];
    LJsonStr := LJsonStr + '{"text":"' + LSearchText.Text + '","caseSensitive":'
      + BooleanToStringName[LSearchText.CaseSensitive] + ',"wholeWord":' +
      BooleanToStringName[LSearchText.WholeWord] + '}';
  end;
  LJsonStr := LJsonStr + ']';
  Result := LJsonStr;
end;

function TgtxDocOperations.SetToCSV(ADocumentItems: TgtxDocumentItems): string;
begin
  Result := '';
  Result := Result + '"documentProperties":' +
    BooleanToStringName[ditDocumentProperties in ADocumentItems];
  Result := Result + ',"bookmarks":' + BooleanToStringName[ditBookmarks in ADocumentItems];
  Result := Result + ',"bookmarkActions":' +
    BooleanToStringName[ditBookmarkActions in ADocumentItems];
  Result := Result + ',"annotations":' +
    BooleanToStringName[ditAnnotations in ADocumentItems];
  Result := Result + ',"annotationActions":' +
    BooleanToStringName[ditAnnotationActions in ADocumentItems];
end;

function TgtxDocOperations.SetToCSV(ARedactCleanupSettings
  : TgtxRedactCleanupSettings): string;
begin
  Result := '';
  Result := Result + '"removeEmptyBookmarks":' +
    BooleanToStringName[rcsRemoveEmptyBookmarks in ARedactCleanupSettings];
  Result := Result + ',"removeEmptyBookmarkActions":' +
    BooleanToStringName[rcsRemoveEmptyBookmarkActions in ARedactCleanupSettings];
  Result := Result + ',"removeEmptyAnnotations":' +
    BooleanToStringName[rcsRemoveEmptyAnnotations in ARedactCleanupSettings];
  Result := Result + ',"removeEmptyAnnotationActions":' +
    BooleanToStringName[rcsRemoveEmptyAnnotationActions in ARedactCleanupSettings];
  Result := Result + ',"removeAffectedLinkActions":' +
    BooleanToStringName[rcsRemoveAffectedLinkActions in ARedactCleanupSettings];
end;

function TgtxDocOperations.SetToCSV(APDFDocPermissions
  : TgtxPDFDocPermissions): string;
begin
  Result := '';
  Result := Result + '"allowAccessibility":' +
    BooleanToStringName[pdpAllowAccessibility in APDFDocPermissions];
  Result := Result + ',"allowAssembly":' +
    BooleanToStringName[pdpAllowAssembly in APDFDocPermissions];
  Result := Result + ',"allowCopy":' +
    BooleanToStringName[pdpAllowCopy in APDFDocPermissions];
  Result := Result + ',"allowFormFill":' +
    BooleanToStringName[pdpAllowFormFill in APDFDocPermissions];
  Result := Result + ',"allowHighResPrint":' +
    BooleanToStringName[pdpAllowHighResPrint in APDFDocPermissions];
  Result := Result + ',"allowModifyAnnotations":' +
    BooleanToStringName[pdpAllowModifyAnnotations in APDFDocPermissions];
  Result := Result + ',"allowModifyContents":' +
    BooleanToStringName[pdpAllowModifyContents in APDFDocPermissions];
  Result := Result + ',"allowPrinting":' +
    BooleanToStringName[pdpAllowPrinting in APDFDocPermissions];
end;

{ TgtxViewResponse }

constructor TgtxViewResponse.Create(AApiResponse
  : TgtxRestAPIResponseCreateView);
begin
  FUrl := AApiResponse.Url;
  FTimeToLive := AApiResponse.FTimeToLive;
end;

{ TgtxVisibleNavigationControls }

procedure TgtxVisibleNavigationControls.Assign
  (Source: TgtxVisibleNavigationControls);
begin
  if (Source <> nil) then
  begin
    FFirstPage := Source.FFirstPage;
    FLastPage := Source.FLastPage;
    FPrevPage := Source.FPrevPage;
    FNextPage := Source.FNextPage;
    FPageIndicator := Source.FPageIndicator;
    FGotoPage := Source.FGotoPage;
  end;
end;

constructor TgtxVisibleNavigationControls.Create(AFirstPage: Boolean = True;
  ALastPage: Boolean = True; APrevPage: Boolean = True;
  ANextPage: Boolean = True; APageIndicator: Boolean = True;
  AGotoPage: Boolean = True);
begin
  FFirstPage := AFirstPage;
  FLastPage := ALastPage;
  FPrevPage := APrevPage;
  FNextPage := ANextPage;
  FPageIndicator := APageIndicator;
  FGotoPage := AGotoPage;
end;

function TgtxVisibleNavigationControls.ToJson: String;
begin
  Result := '"visibleNavigationControls":{' + '"firstPage":"' +
    BooleanToStringName[FFirstPage] + '"' + ',"lastPage":"' + BooleanToStringName
    [FLastPage] + '"' + ',"prevPage":"' + BooleanToStringName[FPrevPage] + '"' +
    ',"nextPage":"' + BooleanToStringName[FNextPage] + '"' + ',"pageIndicator":"'
    + BooleanToStringName[FPageIndicator] + '"' + ',"gotoPage":"' +
    BooleanToStringName[FGotoPage] + '"' + '}';

end;

{ TgtxVisibleZoomControls }

procedure TgtxVisibleZoomControls.Assign(Source: TgtxVisibleZoomControls);
begin
  if (Source <> nil) then
  begin
    FFixedSteps := Source.FFixedSteps;
    FZoomIn := Source.FZoomIn;
    FZoomOut := Source.FZoomOut;
  end;
end;

constructor TgtxVisibleZoomControls.Create(AFixedSteps: Boolean = True;
  AzoomIn: Boolean = True; AZoomout: Boolean = True);
begin
  FFixedSteps := AFixedSteps;
  FZoomIn := AzoomIn;
  FZoomOut := AZoomout;
end;

function TgtxVisibleZoomControls.ToJson: String;
begin
  Result := '"visibleZoomControls":{' + '"fixedSteps":"' + BooleanToStringName
    [FFixedSteps] + '"' + ',"zoomIn":"' + BooleanToStringName[FZoomIn] + '"' +
    ',"zoomOut":"' + BooleanToStringName[FZoomOut] + '"' + '}';

end;

{ TgtxVisibleRotationControls }

constructor TgtxVisibleRotationControls.Create(AClockwise, ACounterClockwise
  : Boolean);
begin
  FClockwise := AClockwise;
  FCounterClockwise := ACounterClockwise;
end;

function TgtxVisibleRotationControls.ToJson: String;
begin
  Result := '"visibleRotationControls":{' + '"clockwise":"' + BooleanToStringName
    [FClockwise] + '"' + ',"counterClockwise":"' + BooleanToStringName
    [FCounterClockwise] + '"' + '}';
end;

{ TgtxVisibleColorInversionControls }

constructor TgtxVisibleColorInversionControls.Create(AAllPages: Boolean);
begin
  FAllPages := AAllPages;
end;

function TgtxVisibleColorInversionControls.ToJson: String;
begin
  Result := '"visibleColorInversionControls":{' + '"allPages":"' +
    BooleanToStringName[FAllPages] + '"' + '}';

end;

{ TgtxSearchControls }

procedure TgtxSearchControls.Assign(Source: TgtxSearchControls);
begin
  if (Source <> nil) then
  begin
    FEnableQuickSearch := Source.FEnableQuickSearch;
    FHighlightColor.Assign(Source.FHighlightColor);
  end;
end;

constructor TgtxSearchControls.Create(AEnableQuickSearch: Boolean;
  AHighlightColor: TgtxColor);
begin
  FEnableQuickSearch := AEnableQuickSearch;
  if FHighlightColor <> nil then
    FHighlightColor := AHighlightColor
  else
    FHighlightColor := TgtxColor.Create(255, 255, 0);
end;

function TgtxSearchControls.GetHighlightColor: TgtxColor;
begin
  Result := FHighlightColor;
end;

procedure TgtxSearchControls.SetHighlightColor(const AValue: TgtxColor);
begin
  FHighlightColor.Assign(AValue);
end;

function TgtxSearchControls.ToJson: String;
begin
  Result := '"searchControls":{' + '"enableQuickSearch":"' + BooleanToStringName
    [FEnableQuickSearch] + '",' + '"highlightColor":"' +
    FHighlightColor.EncodeString(false) + '"' + '}';
end;

{ TgtxViewerSettings }

constructor TgtxViewerSettings.Create(AToolbarVisible: Boolean = True;
  AVisibleNavigationControls: TgtxVisibleNavigationControls = nil;
  AVisibleZoomControls: TgtxVisibleZoomControls = nil;
  AVisibleRotationControls: TgtxVisibleRotationControls = nil;
  AVisibleColorInversionControls: TgtxVisibleColorInversionControls = nil;
  ASearchControls: TgtxSearchControls = nil);
begin
  FToolbarVisible := AToolbarVisible;
  if AVisibleNavigationControls <> nil then
    FVisibleNavigationControls := AVisibleNavigationControls
  else
    FVisibleNavigationControls := TgtxVisibleNavigationControls.Create(True,
      True, True, True, True, True);
  if AVisibleZoomControls <> nil then
    FVisibleZoomControls := AVisibleZoomControls
  else
    FVisibleZoomControls := TgtxVisibleZoomControls.Create(True, True, True);
  if AVisibleRotationControls <> nil then
    FVisibleRotationControls := AVisibleRotationControls
  else
    FVisibleRotationControls := TgtxVisibleRotationControls.Create(True, True);
  if AVisibleColorInversionControls <> nil then
    FVisibleColorInversionControls := AVisibleColorInversionControls
  else
    FVisibleColorInversionControls :=
      TgtxVisibleColorInversionControls.Create(True);
  if ASearchControls <> nil then
    FSearchControls := ASearchControls
  else
    FSearchControls := TgtxSearchControls.Create(True, nil);
end;

function TgtxViewerSettings.GetSearchControls: TgtxSearchControls;
begin
  Result := FSearchControls;
end;

function TgtxViewerSettings.GetVisibleColorInversionControls
  : TgtxVisibleColorInversionControls;
begin
  Result := FVisibleColorInversionControls;
end;

function TgtxViewerSettings.GetVisibleNavigationControls
  : TgtxVisibleNavigationControls;
begin
  Result := FVisibleNavigationControls;
end;

function TgtxViewerSettings.GetVisibleRotationControls
  : TgtxVisibleRotationControls;
begin
  Result := FVisibleRotationControls;
end;

function TgtxViewerSettings.GetVisibleZoomControls: TgtxVisibleZoomControls;
begin
  Result := FVisibleZoomControls;
end;

procedure TgtxViewerSettings.SetSearchControls(const AValue
  : TgtxSearchControls);
begin
  FSearchControls.Assign(AValue);
end;

procedure TgtxViewerSettings.SetVisibleColorInversionControls
  (const AValue: TgtxVisibleColorInversionControls);
begin
  FVisibleColorInversionControls.AllPages := AValue.AllPages;
end;

procedure TgtxViewerSettings.SetVisibleNavigationControls
  (const AValue: TgtxVisibleNavigationControls);
begin
  FVisibleNavigationControls.Assign(AValue);
end;

procedure TgtxViewerSettings.SetVisibleRotationControls
  (const AValue: TgtxVisibleRotationControls);
begin
  FVisibleRotationControls.Clockwise := AValue.Clockwise;
  FVisibleRotationControls.CounterClockwise := AValue.CounterClockwise;
end;

procedure TgtxViewerSettings.SetVisibleZoomControls(const AValue
  : TgtxVisibleZoomControls);
begin
  FVisibleZoomControls.Assign(AValue);
end;

function TgtxViewerSettings.ToJson: String;
begin
  Result := '"viewerSettings":{' + '"toolbarVisible":"' + BooleanToStringName
    [ToolbarVisible] + '"' + ',' + FVisibleNavigationControls.ToJson() + ',' +
    FVisibleZoomControls.ToJson() + ',' + FVisibleRotationControls.ToJson() +
    ',' + FVisibleColorInversionControls.ToJson() + ',' +
    FSearchControls.ToJson() + '}';
end;

{ TgtxViewer }

constructor TgtxViewer.Create(AStarDocs: TgtxStarDocsSDK);
begin
  FStarDocs := AStarDocs;
end;

function TgtxViewer.CreateView(AFile: TgtxFileObject; APassword: string;
  AViewerSettings: TgtxViewerSettings): TgtxViewResponse;
var
  LUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtxRestAPIResponseCreateView;
  LDocUris: TStringList;
  LPasswords: TStringList;
begin
  try
    LDocUris := TStringList.Create;
    LPasswords := TStringList.Create;
    LDocUris.Add(FStarDocs.GetDocUri(AFile));
    LPasswords.Add(APassword);
    LJsonStr := '{' + FStarDocs.EncodeJsonDocuments(LDocUris, LPasswords, nil);
    if (AViewerSettings <> nil) then
    begin
      LJsonStr := LJsonStr + (',' + AViewerSettings.ToJson());
    end;
    if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
      LJsonStr := LJsonStr + ',"forceFullPermission":true';
    LJsonStr := LJsonStr + '}';
    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri + '/viewsessions';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtxRestAPIResponseCreateView>
      (LJsonResponseStr);
    Result := TgtxViewResponse.Create(LJsonResponse);
  finally
    LDocUris.Free;
    LPasswords.Free;
  end;
end;

{ TgtxRestAPIResponseCommon }

function TgtxRestAPIResponseCommon.GetDocuments
  : TArray<TgtxRestAPIDocumentCommon>;
begin
  Result := FDocuments;
end;

procedure TgtxRestAPIResponseCommon.SetDocuments(const AValue
  : TArray<TgtxRestAPIDocumentCommon>);
begin
  FDocuments := AValue;
end;

{ TgtxRestAPIDocumentGetPropertiesPDF }

function TgtxRestAPIDocumentGetPropertiesPDF.GetExtendedProperties
  : TgtxRestAPIDocExPropertiesPDF;
begin
  Result := FExtendedProperties;
end;

function TgtxRestAPIDocumentGetPropertiesPDF.GetProperties
  : TgtxRestAPIDocPropertiesCommon;
begin
  Result := FProperties;
end;

procedure TgtxRestAPIDocumentGetPropertiesPDF.SetExtendedProperties
  (const AValue: TgtxRestAPIDocExPropertiesPDF);
begin
  FExtendedProperties.HasSecurity := AValue.HasSecurity;
  FExtendedProperties.HasBookmarks := AValue.HasBookmarks;
end;

procedure TgtxRestAPIDocumentGetPropertiesPDF.SetProperties
  (const AValue: TgtxRestAPIDocPropertiesCommon);
begin
  FProperties.Assign(AValue);
end;

{ TgtxRestAPIDocPropertiesSecurity }

procedure TgtxRestAPIDocPropertiesSecurity.Assign
  (Source: TgtxRestAPIDocPropertiesSecurity);
begin
  if (Source <> nil) then
  begin
    FSecurityMethod := Source.FSecurityMethod;
    FEncryptionLevel := Source.FEncryptionLevel;
    FSuppliedPassword := Source.FSuppliedPassword;
    FHasOpenPassword := Source.FHasOpenPassword;
    FHasPermissionsPassword := Source.FHasPermissionsPassword;
    FPermissions.Assign(Source.FPermissions)
  end;
end;

function TgtxRestAPIDocPropertiesSecurity.GetPermissions
  : TgtxRestAPIDocPermissionsPDF;
begin
  Result := FPermissions;
end;

procedure TgtxRestAPIDocPropertiesSecurity.SetPermissions
  (const AValue: TgtxRestAPIDocPermissionsPDF);
begin
  FPermissions.Assign(AValue);
end;

{ TgtxRestAPIDocumentGetPropertiesSecurityPDF }

function TgtxRestAPIDocumentGetPropertiesSecurityPDF.
  GetExtendedPropertiesSecurity: TgtxRestAPIDocPropertiesSecurity;
begin
  Result := FExtendedPropertiesSecurity;
end;

procedure TgtxRestAPIDocumentGetPropertiesSecurityPDF.
  SetExtendedPropertiesSecurity(const AValue: TgtxRestAPIDocPropertiesSecurity);
begin
  FExtendedPropertiesSecurity.Assign(AValue);
end;

{ TgtxRestAPIDocPropertiesCommon }

procedure TgtxRestAPIDocPropertiesCommon.Assign
  (Source: TgtxRestAPIDocPropertiesCommon);
begin
  if Source <> nil then
  begin
    FAuthor := Source.FAuthor;
    FTitle := Source.FTitle;
    FSubject := Source.FSubject;
    FCreator := Source.FCreator;
    FKeywords := Source.FKeywords;
    FProducer := Source.FProducer;
  end;
end;

{ TgtxRestAPIDocPermissionsPDF }

procedure TgtxRestAPIDocPermissionsPDF.Assign
  (Source: TgtxRestAPIDocPermissionsPDF);
begin
  if Source <> nil then
  begin
    FAllowAssembly := Source.FAllowAssembly;
    FAllowModifyAnnotations := Source.FAllowModifyAnnotations;
    FAllowCopy := Source.FAllowCopy;
    FAllowModifyContents := Source.FAllowModifyContents;
    FAllowAccessibility := Source.FAllowAccessibility;
    FAllowPrinting := Source.FAllowPrinting;
    FAllowHighResPrint := Source.FAllowHighResPrint;
    FAllowFormFill := Source.FAllowFormFill;
  end;
end;

{ TgtxRestAPIResponseGetPropertiesPDF }

function TgtxRestAPIResponseGetPropertiesPDF.GetDocuments
  : TArray<TgtxRestAPIDocumentGetPropertiesPDF>;
begin
  Result := FDocuments;
end;

procedure TgtxRestAPIResponseGetPropertiesPDF.SetDocuments
  (const AValue: TArray<TgtxRestAPIDocumentGetPropertiesPDF>);
begin
  FDocuments := AValue;
end;

{ TgtxRestAPIResponseGetPropertiesSecurityPDF }

function TgtxRestAPIResponseGetPropertiesSecurityPDF.GetDocuments
  : TArray<TgtxRestAPIDocumentGetPropertiesSecurityPDF>;
begin
  Result := FDocuments;
end;

procedure TgtxRestAPIResponseGetPropertiesSecurityPDF.SetDocuments
  (const AValue: TArray<TgtxRestAPIDocumentGetPropertiesSecurityPDF>);
begin
  FDocuments := AValue;
end;

{ TgtxPDFFormFieldFillData }

constructor TgtxPDFFormFieldFillData.Create(AFieldName, AFieldValue: string;
  AFlattenField: Boolean);
begin
  FFieldName := AFieldName;
  FFieldValue := AFieldValue;
  FFlattenField := AFlattenField;
end;

end.
