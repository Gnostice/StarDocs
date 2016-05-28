{
  Gnostice StarDocs v2
  Copyright � 2002-2016 Gnostice Information Technologies Private Limited, Bangalore, India
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
  // Graphics,
  RestRequest,
  REST.Json;

type
  TgtConnectionInfo = class;
  TgtPreferences = class;
  TgtAuth = class;
  TgtStorage = class;
  TgtDocOperations = class;
  TgtRemoteFileUri = class;
  TgtFileObject = class;
  TgtDocObject = class;
  TgtGetDocumentInfoResponse = class;
  TgtAuthResponse = class;
  TgtRestAPIResponseAuth = class;
  TgtRestAPIResponseAuthFailure = class;
  TgtRestAPIDocumentCommon = class;
  TgtRestAPIResponseError = class;
  TgtRestAPIResponseGetDocumentInfo = class;
  TgtRestAPIResponseGetPropertiesPDF = class;
  TgtPageRangeSettings = class;
  TgtPageSeparator = class;
  TgtEncoderSettings = class;
  TgtDPI = class;
  TgtSize = class;
  TgtCanvasSize = class;
  TgtContentAlignment = class;
  TgtImageEncoderSettings = class;
  TgtPDFPortfolioSettings = class;
  TgtPDFEncoderSettings = class;
  TgtSearchText = class;
  TgtColor = class;
  TgtFont = class;
  TgtRedactFillSettings = class;
  TgtOutline = class;
  TgtFillRect = class;
  TgtFillText = class;
  TgtPen = class;
  // TgtGetPropertiesResponse = class;
  // TgtDocProperties = class;
  TgtDocErrorDetails = class;
  TgtRestAPIResponseCreateView = class;
  TgtViewResponse = class;
  TgtVisibleNavigationControls = class;
  TgtVisibleZoomControls = class;
  TgtVisibleRotationControls = class;
  TgtVisibleColorInversionControls = class;
  TgtSearchControls = class;
  TgtViewerSettings = class;
  TgtViewer = class;
  TgtPDFFormFieldFillData = class;

  TgtStarDocsSDK = class(TComponent)
  private
    FConnectionInfo: TgtConnectionInfo;
    FPreferences: TgtPreferences;
    FAuthResponse: TgtAuthResponse;
    FAuth: TgtAuth;
    FStorage: TgtStorage;
    FDocOperations: TgtDocOperations;
    FViewer: TgtViewer;
    function GetDocUri(AFile: TgtFileObject): string;
    function IssueGetRequestAndPoll(AUrl: string): string;
    function IssuePostPutRequestAndPoll(AUrl: string; APost: Boolean;
      AJsonStr: string): string;
    function EncodeJsonDocuments(ADocUris: TStringList; APasswords: TStringList;
      APageRanges: TObjectList<TgtPageRangeSettings>): string;
    function GetAuth: TgtAuth;
    procedure SetAuth(const AValue: TgtAuth);
    function GetStorage: TgtStorage;
    procedure SetStorage(const AValue: TgtStorage);
    function GetDocOperations: TgtDocOperations;
    function GetViewer: TgtViewer;
    function GetConnectionInfo: TgtConnectionInfo;
    procedure SetConnectionInfo(const AValue: TgtConnectionInfo);
    function GetPreferences: TgtPreferences;
    procedure SetPreferences(const AValue: TgtPreferences);
  public
    property AuthResponse: TgtAuthResponse read FAuthResponse
      write FAuthResponse;
    property Auth: TgtAuth read GetAuth write SetAuth;
    property Storage: TgtStorage read GetStorage write SetStorage;
    property DocOperations: TgtDocOperations read GetDocOperations;
    property Viewer: TgtViewer read GetViewer;
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AConnectionInfo: TgtConnectionInfo;
      APreferences: TgtPreferences); reintroduce; overload;
    destructor Destroy; override;
  published
    property ConnectionInfo: TgtConnectionInfo read GetConnectionInfo
      write SetConnectionInfo;
    property Preferences: TgtPreferences read GetPreferences
      write SetPreferences;
  end;

  TgtConnectionInfo = class(TPersistent)
  private
    FApiServerVersion: string;
    FApiServerUri: TIdURI;
    FApiKey: string;
    FApiSecret: string;
    FServerTimeout: Integer;
    FDocOperationTimeout: Integer;
    FPollInterval: Integer;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

  published
    property ApiServerUri: TIdURI read FApiServerUri write FApiServerUri;
    property ApiKey: string read FApiKey write FApiKey;
    property ApiSecret: string read FApiSecret write FApiSecret;
    property ApiServerVersion: string read FApiServerVersion
      write FApiServerVersion;
    property ServerTimeout: Integer read FServerTimeout write FServerTimeout;
    property DocOperationTimeout: Integer read FDocOperationTimeout
      write FDocOperationTimeout;
    property PollInterval: Integer read FPollInterval write FPollInterval;
  end;

  TgtDocPasswordSettings = class(TPersistent)
  private
    FForceFullPermission: Boolean;
  public
    constructor Create(AForceFullPermission: Boolean);
    destructor Destroy; override;
  published
    procedure Assign(Source: TPersistent); override;
    property ForceFullPermission: Boolean read FForceFullPermission
      write FForceFullPermission;
  end;

  TgtPreferences = class(TPersistent)
  private
    FDocPasswordSettings: TgtDocPasswordSettings;

    function GetDocPasswordSettings: TgtDocPasswordSettings;
    procedure SetDocPasswordSettings(const AValue: TgtDocPasswordSettings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property DocPasswordSettings: TgtDocPasswordSettings
      read GetDocPasswordSettings write SetDocPasswordSettings;
  end;

  // Service groups
  TgtAuth = class
  private
    FStarDocs: TgtStarDocsSDK;
  public
    constructor Create(AStarDocs: TgtStarDocsSDK);
    destructor Destroy; override;
    function loginApp(AEntity: string = ''): TgtAuthResponse;
  end;

  TgtStorage = class
  private
    FStarDocs: TgtStarDocsSDK;

  public
    constructor Create(AStarDocs: TgtStarDocsSDK);
    destructor Destroy; override;
    function Upload(AFileNameWithPath: string; APassword: string = '')
      : TgtDocObject; overload;
    function Upload(AStream: TStream; AfileName: string; APassword: string = '')
      : TgtDocObject; overload;
    procedure Download(AFile: TgtFileObject; AFilePath: string); overload;
    procedure Download(AFile: TgtFileObject; FOutStream: TStream); overload;
  end;

  { TgtDocOperations }

  TgtPDFEncryptionLevel = (pelNone, pelAES_128bit, pelRC4_128bit, pelRC4_40bit);
  TgtTextSearchMode = (tsmLiteral, tsmRegex);
  TgtDocumentItem = (ditDocumentProperties, ditBookmarks, ditBookmarkActions,
    ditAnnotations, ditAnnotationActions);
  TgtDocumentItems = set of TgtDocumentItem;
  TgtRedactCleanupSetting = (rcsRemoveEmptyBookmarks,
    rcsRemoveEmptyBookmarkActions, rcsRemoveEmptyAnnotations,
    rcsRemoveEmptyAnnotationActions, rcsRemoveAffectedLinkActions);
  TgtRedactCleanupSettings = set of TgtRedactCleanupSetting;
  TgtColoringMode = (cmoNone, cmUseColor);
  TgtPenStyle = (pstSolid, pstDash, pstDashDot, pstDashDotDot);
  TgtBrushPattern = (bptSolid, bptForwardDiagonal, bptBackwardDiagonal,
    bptCross, bptDiagonalCross, bptHorizontal, bptVertical);
  TgtFontSelectionMode = (fsmUseFont);
  TgtFontSizingMode = (fsmAutoFit, fsmUseFontSize);
  TgtFontColoringMode = (fcmSource, fcmUseFontColor);
  TgtFontStyle = (fstBold, fstItalic, fstUnderline);
  TgtFontStyles = set of TgtFontStyle;
  TgtFontEffect = (fefNone);
  TgtFontEffects = set of TgtFontEffect;
  TgtPDFDocPermission = (pdpAllowAccessibility, pdpAllowAssembly, pdpAllowCopy,
    pdpAllowFormFill, pdpAllowHighResPrint, pdpAllowModifyAnnotations,
    pdpAllowModifyContents, pdpAllowPrinting);
  TgtPDFDocPermissions = set of TgtPDFDocPermission;
  TgtResolutionMode = (rmmUseSource, rmmUseSpecifiedDPI);
  TgtPaperSize = (psiA2, psiA3, psiA4, psiA5, psiA6, psiCustom);
  TgtMeasurementUnit = (munMillimeters, munCentimeters, munInches, munPicas,
    munPixels, munPoints, munTwips);
  TgtHorizontalAlignmentType = (hatLeft, hatRight, hatCenter);
  TgtVerticalAlignmentType = (vatTop, vatBottom, vatCenter);
  TgtCanvasSizingMode = (csmUseSource, csmUseSpecifiedSize,
    csmUseSpecifiedRelativeSize);
  TgtContentScaling = (cscFitWithAspect, cscStretch, cscCrop);
  TgtTIFFCompressionType = (tctNone, tctDeflate, tctCCITT_3, tctCCITT_4,
    tctCCITT_RLE, tctEXIF_JPEG, tctJPEG, tctLZW, tctPackBits, tctZLib);
  TgtMTIFFConversionMode = (tcmConvertToSeparateFiles, tcmConvertToSingleFile);
  TgtPDFConversionMode = (pcmConvertToSeparateFiles, pcmConvertToSingleFile,
    pcmConvertFirstFileAndAttachRestAsOriginal,
    pcmCreateNewFileAndAttachAllAsOriginal);
  TgtPDFPortfolioCreationMode = (pcmOff, pcmAlways, pcmWhenInputIsPortfolio,
    pcmOnlyWhenAttachmentsExist);
  TgtPDFPortfolioInitialLayout = (pilDetails, pilTile, pilHidden);
  TgtFontEmbeddingType = (fetNone, fetSubset, fetFull);

  TgtDocOperations = class
  private
    FStarDocs: TgtStarDocsSDK;
    FRedactFillSettings: TgtRedactFillSettings;
    FPageSeparator: TgtPageSeparator;
    FImageEncoderSettings: TgtImageEncoderSettings;
    FPDFEncoderSettings: TgtPDFEncoderSettings;

    function EncodeJsonPageRanges(APageRanges
      : TObjectList<TgtPageRangeSettings>): string;
    function EncodeJsonSearchText(ASearchText
      : TObjectList<TgtSearchText>): string;
    function ConvertToImage(AUrlPath: string;
      AFiles: TObjectList<TgtFileObject>; APasswords: TStringList;
      APageRanges: TObjectList<TgtPageRangeSettings>;
      AImageEncoderSettings: TgtImageEncoderSettings)
      : TObjectList<TgtDocObject>;
    function SetToCSV(ADocumentItems: TgtDocumentItems): string; overload;
    function SetToCSV(ARedactCleanupSettings: TgtRedactCleanupSettings)
      : string; overload;
    function SetToCSV(APDFDocPermissions: TgtPDFDocPermissions)
      : string; overload;
    function EncodeFormFieldFillData(AFormFields
      : TObjectList<TgtPDFFormFieldFillData>): string;

    function GetRedactFillSettings: TgtRedactFillSettings;
    function GetPageSeparator: TgtPageSeparator;
    function GetImageEncoderSettings: TgtImageEncoderSettings;
    function GetPDFEncoderSettings: TgtPDFEncoderSettings;

  public
    constructor Create(AStarDocs: TgtStarDocsSDK);
    destructor Destroy; override;

    property RedactFillSettings: TgtRedactFillSettings
      read GetRedactFillSettings;
    property PageSeparator: TgtPageSeparator read GetPageSeparator;
    property ImageEncoderSettings: TgtImageEncoderSettings
      read GetImageEncoderSettings;
    property PDFEncoderSettings: TgtPDFEncoderSettings
      read GetPDFEncoderSettings;
    { GetProperties }
    // function GetProperties(AFile: TgtFileObject; APassword: string = ''): TgtGetPropertiesResponse;

    { SetProperties }
    // function SetProperties(AFile: TgtFileObject; APassword: string; AProperties: TgtDocProperties): TgtDocObject;

    { GetDocumentInfo }
    function GetDocumentInfo(AFile: TgtFileObject; APassword: string = '')
      : TgtGetDocumentInfoResponse;

    { Merge }
    function Merge(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil): TgtDocObject;

    { Split }
    function SplitByPageRange(AFile: TgtFileObject; APassword: string;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil)
      : TObjectList<TgtDocObject>;

    function SplitBySeparatorPage(AFile: TgtFileObject; APassword: string)
      : TObjectList<TgtDocObject>;

    { Encrypt }
    function Encrypt(AFile: TgtFileObject; APassword: string;
      APDFEncryptionLevel: TgtPDFEncryptionLevel = TgtPDFEncryptionLevel.
      pelAES_128bit; ANewOpenPassword: string = '';
      ANewPermissionsPassword: string = '';
      ANewPermissions: TgtPDFDocPermissions = []): TgtDocObject;

    { Redact }
    function RedactText(AFile: TgtFileObject; APassword: string;
      APageRange: TgtPageRangeSettings; ATextSearchMode: TgtTextSearchMode;
      ASearchText: TObjectList<TgtSearchText>;
      AIncludeAdditionalItems: TgtDocumentItems = [];
      ACleanupSettings: TgtRedactCleanupSettings = []): TgtDocObject;

    { Convert }
    function ConvertToTIFF(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil;
      ATIFFCompressionType: TgtTIFFCompressionType = TgtTIFFCompressionType.
      tctDeflate): TObjectList<TgtDocObject>;
    function ConvertToMTIFF(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil;
      ATIFFCompressionType: TgtTIFFCompressionType = TgtTIFFCompressionType.
      tctDeflate;
      AConversionMode: TgtMTIFFConversionMode = TgtMTIFFConversionMode.
      tcmConvertToSeparateFiles): TObjectList<TgtDocObject>;
    function ConvertToJPEG(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil)
      : TObjectList<TgtDocObject>;
    function ConvertToGIF(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil)
      : TObjectList<TgtDocObject>;
    function ConvertToBMP(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil)
      : TObjectList<TgtDocObject>;
    function ConvertToPNG(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil)
      : TObjectList<TgtDocObject>;
    function ConvertToPDF(AFiles: TObjectList<TgtFileObject>;
      APasswords: TStringList = nil;
      APageRanges: TObjectList<TgtPageRangeSettings> = nil;
      AConversionMode: TgtPDFConversionMode = TgtPDFConversionMode.
      pcmConvertToSeparateFiles): TObjectList<TgtDocObject>;
    function FillForm(AFile: TgtFileObject; APassword: string;
      AFormFields: TObjectList<TgtPDFFormFieldFillData>;
      AFlattenAllFields: Boolean = False): TgtDocObject;
  end;

  { Enumerations }
  TgtMimeType = (mtUnrecognizable, mtApplication_pdf, mtImage_jpeg, mtImage_gif,
    mtImage_bmp, mtImage_tiff, mtImage_png,
    mtApplication_vnd_openxmlformats_officedocument_wordprocessingml_document);

  TgtExceptionStatusCode = (
    escHTTPBadRequest = 400,
    escHTTPUnauthorized = 401,
    escHTTPNotFound = 404,
    escHTTPConflict = 500,
    escGeneralError = 1000,
    escBadRequest = 1010,
    escBadDocument = 1011,
    escPasswordRequired = 1020,
    escUnsupportedDocumentFormat = 1030,
    escInsufficientRights = 1040,
    escUnknownJob = 1050,
    escUnknownDocument = 1051,
    escUnknownPage = 1052,
    escUnknownUser = 1053,
    escInvalidApiKey = 1054,
    escUnsupportedOperationForFormat = 1060,
    escExhaustedStorageQuotaForLicense = 1070,
    escExhaustedStorageQuotaForUser = 1071,
    escExhaustedStorageQuotaForApp = 1072,
    escUploadSizeOverlimitForLicense = 1080,
    escUploadSizeOverlimitForUser = 1081,
    escUploadSizeOverlimitForApp = 1082,
    escExhaustedUsageQuotaForApp = 1090,
    escExhaustedUsageQuotaForLicense = 1091,
    escSubscriptionPaymentFailure = 1092,
    escInternalError = 2000,
    escUnexpectedResponse = 10000,
    escOperationTimedOut = 10001);

  { TgtAuthResponse }
  TgtAuthResponse = class
  private
    FAccessToken: string;
    FTokenType: string;
    FExpiresIn: Longint;
  public
    constructor Create(ARestAPIResponseAuth: TgtRestAPIResponseAuth);
    destructor Destroy; override;
    property AccessToken: string read FAccessToken;
    property TokenType: string read FTokenType;
    property ExpiresIn: Longint read FExpiresIn;
  end;

  { TgtRemoteFileUri }
  TgtRemoteFileUri = class
  private
    FUri: TIdURI;
    procedure Assign(Source: TgtRemoteFileUri);
  public
    constructor Create(AUri: TIdURI); overload;
    constructor Create(AUri: string); overload;
    destructor Destroy; override;
    property Uri: TIdURI read FUri;
  end;

  { TgtFileObject }
  TgtFileObject = class
  private
    FFileUploaded: Boolean;
    FStream: TStream;
    FStreamFileName: string;
    FRemoteFileUri: TgtRemoteFileUri;
    FLocalFilePath: string;
    function GetFileNameFromUri: string;
    { procedure SetUploaded(AUri: string); }
    function GetStream: TStream;
    procedure SetStream(const AValue: TStream);
    function GetRemoteFileUri: TgtRemoteFileUri;
    procedure SetRemoteFileUri(const AValue: TgtRemoteFileUri);
  public
    constructor Create(ARemoteFileUri: TgtRemoteFileUri); overload;
    constructor Create(AStream: TStream; AStreamFileName: string); overload;
    constructor Create(ALocalFilePath: string); overload;
    destructor Destroy; override;
    property FileUploaded: Boolean read FFileUploaded;
    property Stream: TStream read GetStream Write SetStream;
    property StreamFileName: string read FStreamFileName;
    property RemoteFileUri: TgtRemoteFileUri read GetRemoteFileUri
      write SetRemoteFileUri;
    property LocalFilePath: string read FLocalFilePath;
  end;

  { TgtDocObject }
  TgtDocObject = class(TgtFileObject)
  private
    FFileName: string;
    FFileSize: Longint;
    FExpiryTime: Longint;
    FPageCount: Integer;
    FMimeType: TgtMimeType;
    function ParseMimeType(AMimeType: string): TgtMimeType;
  public
    constructor Create(AApiResponse: TgtRestAPIDocumentCommon);
    destructor Destroy; override;
    property FileName: string read FFileName;
    property FileSize: Longint read FFileSize;
    property ExpiryTime: Longint read FExpiryTime;
    property PageCount: Integer read FPageCount;
    property MimeType: TgtMimeType read FMimeType;
  end;

  { TgtGetDocumentInfoResponse }
  TgtGetDocumentInfoResponse = class(TgtDocObject)
  private
    FUnsupportedMimeTypeOrCorrupt: Boolean;
    FPasswordProtected: Boolean;
    FPasswordCorrect: Boolean;
  public
    constructor Create(AApiResponse: TgtRestAPIResponseGetDocumentInfo);
    destructor Destroy; override;
    property UnsupportedMimeTypeOrCorrupt: Boolean
      read FUnsupportedMimeTypeOrCorrupt;
    property PasswordProtected: Boolean read FPasswordProtected;
    property PasswordCorrect: Boolean read FPasswordCorrect;
  end;

  {
    TgtDocProperties
    TgtDocProperties = class
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
    procedure Assign(Source: TgtDocProperties);
    property Title: string read FTitle write FTitle;
    property Author: string read FAuthor write FAuthor;
    property Subject: string read FSubject write FSubject;
    property Keywords: TStringList read FKeywords write FKeywords;
    property Creator: string read FCreator write FCreator;
    end;

    TgtPDFDocProperties
    TgtPDFDocProperties = class(TgtDocProperties)
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

    TgtGetPropertiesResponse

    TgtGetPropertiesResponse = class(TgtDocObject)
    private
    FDocProperties: TgtDocProperties;
    function GetDocProperties: TgtDocProperties;
    procedure SetDocProperties(const AValue: TgtDocProperties);
    public
    constructor Create(AApiResponse: TgtRestAPIResponseGetPropertiesPDF);
    property DocProperties: TgtDocProperties read GetDocProperties
    write SetDocProperties;
    end;
  }
  // Exception class
  TgtDocErrorDetails = class
  private
    FUri: string;
  public
    constructor Create(AUri: string);
    destructor Destroy; override;
    property Uri: string read FUri write FUri;
  end;

  EgtStarDocsException = class(Exception)
  private
    FHttpStatusCode: Integer;
    FErrorCode: TgtExceptionStatusCode;
    FDocuments: TObjectList<TgtDocErrorDetails>;
  public
    constructor Create(AHttpStatusCode: Integer;
      AErrorCode: TgtExceptionStatusCode; const AMessage: string); overload;
    constructor Create(AApiResponse: TgtRestAPIResponseError); overload;
    constructor Create(AHttpStatusCode: Integer;
      AApiResponseStr: string); overload;
    constructor Create(AHttpStatusCode: Integer;
      AApiResponse: TgtRestAPIResponseError); overload;
    destructor Destroy; override;
    property HttpStatusCode: Integer read FHttpStatusCode;
    property ErrorCode: TgtExceptionStatusCode read FErrorCode;
    property Documents: TObjectList<TgtDocErrorDetails> read FDocuments;
  end;

  // Classes used for passing parameters to the Doc Operations API

  { TgtPageRange }
  TgtPageRange = class
  private
    FRange: string;
    { procedure Assign(ASource: TgtPageRange); }
  public
    constructor Create(ARange: string);
    destructor Destroy; override;
    property Range: string read FRange write FRange;
    procedure AddPage(APage: Integer);
    procedure AddPages(APages: TList<Integer>);
    procedure AddRange(AStartPage: Integer; AEndPage: Integer);
    procedure Clear();
  end;

  { TgtPageRangeSettings }
  TgtPageSubRangeMode = (psmAll, psmEven, psmOdd);

  TgtPageRangeSettings = class
  private
    FPageRange: TgtPageRange;
    FPageSubRangeMode: TgtPageSubRangeMode;
    FReverseOrder: Boolean;
    function ToJson(AExcludeOrdering: Boolean = False): string;
    function GetPageRange: TgtPageRange;
    procedure SetPageRange(const AValue: TgtPageRange);
  public
    constructor Create(APageRange: string;
      APageSubRangeMode: TgtPageSubRangeMode = TgtPageSubRangeMode.psmAll;
      AReverseOrder: Boolean = False); overload;
    destructor Destroy; override;
    constructor Create(APageRange: TgtPageRange;
      APageSubRangeMode: TgtPageSubRangeMode = TgtPageSubRangeMode.psmAll;
      AReverseOrder: Boolean = False); overload;

    property PageRange: TgtPageRange read GetPageRange write SetPageRange;
    property PageSubRangeMode: TgtPageSubRangeMode read FPageSubRangeMode
      write FPageSubRangeMode;
    property ReverseOrder: Boolean read FReverseOrder write FReverseOrder;
  end;

  { TgtPageSeparator }
  TgtPageSeparatorType = (pstEmptyPage);

  TgtPageSeparator = class
  private
    FPageSeparatorType: TgtPageSeparatorType;
  public
    constructor Create;
    destructor Destroy; override;
    property SeparatorType: TgtPageSeparatorType read FPageSeparatorType
      write FPageSeparatorType;
    function EncodeString: string;
  end;

  { TgtSearchText }
  TgtSearchText = class
  private
    FText: string;
    FCaseSensitive: Boolean;
    FWholeWord: Boolean;
  public
    constructor Create(AText: string; ACaseSensitive: Boolean = False;
      AWholeWord: Boolean = False);
    destructor Destroy; override;
    property Text: string read FText write FText;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive;
    property WholeWord: Boolean read FWholeWord write FWholeWord;
  end;

  { TgtColor }
  TgtColor = class
  private
    FRed: Byte;
    FGreen: Byte;
    FBlue: Byte;
    FAlpha: Byte;
    function EncodeString(AEncodeAlpha: Boolean = True): string;
  public
    constructor Create(ARed: Byte; AGreen: Byte; ABlue: Byte;
      AAlpha: Byte = 100);
    procedure Assign(Source: TgtColor);
    destructor Destroy; override;
    property Red: Byte read FRed write FRed;
    property Green: Byte read FGreen write FGreen;
    property Blue: Byte read FBlue write FBlue;
    property Alpha: Byte read FAlpha write FAlpha;
  end;

  { TgtRedactFillSettings }
  TgtRedactFillSettings = class
  private
    FOutline: TgtOutline;
    FFillRect: TgtFillRect;
    FFillText: TgtFillText;
    function ToJson: string;
    function GetOutline: TgtOutline;
    function GetFillRect: TgtFillRect;
    function GetFillText: TgtFillText;
  public
    constructor Create;
    destructor Destroy; override;
    property Outline: TgtOutline read GetOutline;
    property FillRect: TgtFillRect read GetFillRect;
    property FillText: TgtFillText read GetFillText;
  end;

  { TgtPen }
  TgtPen = class
  private
    FColor: TgtColor;
    FWidth: Integer;
    FStyle: TgtPenStyle;
    function GetColor: TgtColor;
  public
    constructor Create;
    destructor Destroy; override;
    property Color: TgtColor read GetColor;
    property Width: Integer read FWidth;
    property Style: TgtPenStyle read FStyle;
  end;

  { TgtBrush }
  TgtBrush = class
  private
    FColor: TgtColor;
    FPattern: TgtBrushPattern;
    function GetColor: TgtColor;
  public
    constructor Create;
    destructor Destroy; override;
    property Color: TgtColor read GetColor;
    property Pattern: TgtBrushPattern read FPattern;
  end;

  { TgtOutline }
  TgtOutline = class
  private
    FPenColoringMode: TgtColoringMode;
    FPen: TgtPen;
    function ToJson: string;
    function GetPen: TgtPen;
  public
    constructor Create;
    destructor Destroy; override;
    property PenColoringMode: TgtColoringMode read FPenColoringMode
      write FPenColoringMode;
    property Pen: TgtPen read GetPen;
  end;

  { TgtFont }
  TgtFont = class
  private
    FName: String;
    FSize: Integer;
    FColor: TgtColor;
    FStyles: TgtFontStyles;
    FEffects: TgtFontEffects;
    function ToJson(AFontSizingMode: TgtFontSizingMode;
      AFontColoringMode: TgtFontColoringMode): string;
    function GetColor: TgtColor;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: String read FName;
    property Size: Integer read FSize;
    property Color: TgtColor read GetColor;
    property Styles: TgtFontStyles read FStyles;
    property Effects: TgtFontEffects read FEffects;
  end;

  { TgtFillText }
  TgtFillText = class
  private
    FReplaceText: string;
    FFontSelectionMode: TgtFontSelectionMode;
    FFontSizingMode: TgtFontSizingMode;
    FFontColoringMode: TgtFontColoringMode;
    FFont: TgtFont;
    function ToJson: string;
    function GetFont: TgtFont;
  public
    constructor Create;
    destructor Destroy; override;
    property ReplaceText: String read FReplaceText write FReplaceText;
    property FontSelectionMode: TgtFontSelectionMode read FFontSelectionMode
      write FFontSelectionMode;
    property FontSizingMode: TgtFontSizingMode read FFontSizingMode
      write FFontSizingMode;
    property FontColoringMode: TgtFontColoringMode read FFontColoringMode
      write FFontColoringMode;
    property Font: TgtFont read GetFont;
  end;

  { TgtFillRect }
  TgtFillRect = class
  private
    FBrushColoringMode: TgtColoringMode;
    FBrush: TgtBrush;
    function ToJson: string;
    function GetBrush: TgtBrush;
  public
    constructor Create;
    destructor Destroy; override;
    property BrushColoringMode: TgtColoringMode read FBrushColoringMode
      write FBrushColoringMode;
    property Brush: TgtBrush read GetBrush;
  end;

  { TgtEncoderSettings }
  TgtEncoderSettings = class
  protected
    function ToJson(): string; virtual;
  end;

  { TgtDPI }
  TgtDPI = class
  private
    FResolutionMode: TgtResolutionMode;
    FX: Integer;
    FY: Integer;
    function ToJson: String;
  public
    constructor Create;
    destructor Destroy; override;
    property ResolutionMode: TgtResolutionMode read FResolutionMode
      write FResolutionMode;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
  end;

  { TgtSize }
  TgtSize = class
  private
    FPaperSize: TgtPaperSize;
    FWidth: Integer;
    FHeight: Integer;
    FMeasurementUnit: TgtMeasurementUnit;
    function EncodeString: String;
  public
    constructor Create;
    destructor Destroy; override;
    property PaperSize: TgtPaperSize read FPaperSize write FPaperSize;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property MeasurementUnit: TgtMeasurementUnit read FMeasurementUnit
      write FMeasurementUnit;
  end;

  { TgtCanvasSize }
  TgtCanvasSize = class
  private
    FSizingMode: TgtCanvasSizingMode;
    FSize: TgtSize;
    FRelativeSizeX: Integer;
    FRelativeSizeY: Integer;
    function ToJson: String;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { TgtContentAlignment }
  TgtContentAlignment = class
  private
    FHorizontalAlignmentType: TgtHorizontalAlignmentType;
    FHorizontalOffset: Integer;
    FVerticalAlignmentType: TgtVerticalAlignmentType;
    FVerticalOffset: Integer;
    function ToJson: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TgtContentAlignment);
    property HorizontalAlignmentType: TgtHorizontalAlignmentType
      read FHorizontalAlignmentType write FHorizontalAlignmentType;
    property HorizontalOffset: Integer read FHorizontalOffset
      write FHorizontalOffset;
    property VerticalAlignmentType: TgtVerticalAlignmentType
      read FVerticalAlignmentType write FVerticalAlignmentType;
    property VerticalOffset: Integer read FVerticalOffset write FVerticalOffset;
  end;

  { TgtImageEncoderSettings }
  TgtImageEncoderSettings = class(TgtEncoderSettings)
  private
    FDPI: TgtDPI;
    FQuality: Byte;
    FCanvasSize: TgtCanvasSize;
    FContentScaling: TgtContentScaling;
    FContentAlignment: TgtContentAlignment;
    function GetContentAlignment: TgtContentAlignment;
    // procedure SetContentAlignment(const AValue: TgtContentAlignment);
  public
    function ToJson(): string; override;
    constructor Create;
    destructor Destroy; override;
    property DPI: TgtDPI read FDPI write FDPI;
    property Quality: Byte read FQuality write FQuality;
    property CanvasSize: TgtCanvasSize read FCanvasSize write FCanvasSize;
    property ContentScaling: TgtContentScaling read FContentScaling
      write FContentScaling;
    property ContentAlignment: TgtContentAlignment read GetContentAlignment;
  end;

  { TgtPDFPortfolioSettings }
  TgtPDFPortfolioSettings = class
  private
    FPDFPortfolioCreationMode: TgtPDFPortfolioCreationMode;
    FPDFPortfolioInitialLayout: TgtPDFPortfolioInitialLayout;
    function ToJson: String;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { TgtPDFEncoderSettings }
  TgtPDFEncoderSettings = class(TgtEncoderSettings)
  private
    FPDFPortfolioSettings: TgtPDFPortfolioSettings;
    FFontEmbeddingType: TgtFontEmbeddingType;
    FOverrideFontEmbeddingRestriction: Boolean;
    function GetPDFPortfolioSettings: TgtPDFPortfolioSettings;
    procedure SetPDFPortfolioSettings(const AValue: TgtPDFPortfolioSettings);
  public
    constructor Create;
    destructor Destroy; override;
    function ToJson: string; override;
    property PDFPortfolioSettings: TgtPDFPortfolioSettings
      read GetPDFPortfolioSettings write SetPDFPortfolioSettings;
    property FontEmbeddingType: TgtFontEmbeddingType read FFontEmbeddingType
      write FFontEmbeddingType;
    property OverrideFontEmbeddingRestriction: Boolean
      read FOverrideFontEmbeddingRestriction
      write FOverrideFontEmbeddingRestriction;
  end;

  // Classes for accepting parsed JSON responses
  // These are meant to be internal
  TgtRestAPIResponseAuth = class
  private
    FAccess_Token: string;
    FToken_Type: string;
    FExpires_In: Longint;
  public
    property AccessToken: string read FAccess_Token;
    property TokenType: string read FToken_Type;
    property ExpiresIn: Longint read FExpires_In;
  end;

  TgtRestAPIResponseAuthFailure = class
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

  TgtRestAPIDocumentCommon = class
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

  TgtRestAPIResponseGetDocumentInfo = class(TgtRestAPIDocumentCommon)
  private
    FUnsupportedMimeTypeOrCorrupt: Boolean;
    FPasswordProtected: Boolean;
    FPasswordCorrect: Boolean;
  public
    property UnsupportedMimeTypeOrCorrupt: Boolean
      read FUnsupportedMimeTypeOrCorrupt write FUnsupportedMimeTypeOrCorrupt;
    property PasswordProtected: Boolean read FPasswordProtected
      write FPasswordProtected;
    property PasswordCorrect: Boolean read FPasswordCorrect
      write FPasswordCorrect;
  end;

  TgtRestAPIResponseCommon = class
  private
    FDocuments: TArray<TgtRestAPIDocumentCommon>;
    function GetDocuments: TArray<TgtRestAPIDocumentCommon>;
    procedure SetDocuments(const AValue: TArray<TgtRestAPIDocumentCommon>);
  public
    property Documents: TArray<TgtRestAPIDocumentCommon> read GetDocuments
      write SetDocuments;
  end;

  TgtRestAPIDocPropertiesCommon = class
  private
    FTitle: string;
    FAuthor: string;
    FSubject: string;
    FKeywords: string;
    FCreator: string;
    FProducer: string;
  public
    procedure Assign(Source: TgtRestAPIDocPropertiesCommon);
    property Title: string read FTitle write FTitle;
    property Author: string read FAuthor write FAuthor;
    property Subject: string read FSubject write FSubject;
    property Keywords: string read FKeywords write FKeywords;
    property Creator: string read FCreator write FCreator;
    property Producer: string read FProducer write FProducer;
  end;

  TgtRestAPIDocExPropertiesPDF = class
  private
    FHasBookmarks: Boolean;
    FHasSecurity: Boolean;
  public
    property HasBookmarks: Boolean read FHasBookmarks write FHasBookmarks;
    property HasSecurity: Boolean read FHasSecurity write FHasSecurity;
  end;

  TgtRestAPIDocumentGetPropertiesPDF = class(TgtRestAPIDocumentCommon)
  private
    FProperties: TgtRestAPIDocPropertiesCommon;
    FExtendedProperties: TgtRestAPIDocExPropertiesPDF;
    function GetExtendedProperties: TgtRestAPIDocExPropertiesPDF;
    procedure SetExtendedProperties(const AValue: TgtRestAPIDocExPropertiesPDF);
    function GetProperties: TgtRestAPIDocPropertiesCommon;
    procedure SetProperties(const AValue: TgtRestAPIDocPropertiesCommon);
  public
    property Properties: TgtRestAPIDocPropertiesCommon read GetProperties
      write SetProperties;
    property ExtendedProperties: TgtRestAPIDocExPropertiesPDF
      read GetExtendedProperties write SetExtendedProperties;
  end;

  TgtRestAPIDocPermissionsPDF = class
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
    procedure Assign(Source: TgtRestAPIDocPermissionsPDF);
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

  TgtRestAPIDocPropertiesSecurity = class
  private
    FSecurityMethod: string;
    FEncryptionLevel: string;
    FSuppliedPassword: string;
    FHasOpenPassword: Boolean;
    FHasPermissionsPassword: Boolean;
    FPermissions: TgtRestAPIDocPermissionsPDF;
    function GetPermissions: TgtRestAPIDocPermissionsPDF;
    procedure SetPermissions(const AValue: TgtRestAPIDocPermissionsPDF);
  public
    procedure Assign(Source: TgtRestAPIDocPropertiesSecurity);
    property SecurityMethod: string read FSecurityMethod write FSecurityMethod;
    property EncryptionLevel: string read FEncryptionLevel
      write FEncryptionLevel;
    property SuppliedPassword: string read FSuppliedPassword
      write FSuppliedPassword;
    property HasOpenPassword: Boolean read FHasOpenPassword
      write FHasOpenPassword;
    property HasPermissionsPassword: Boolean read FHasPermissionsPassword
      write FHasPermissionsPassword;
    property Permissions: TgtRestAPIDocPermissionsPDF read GetPermissions
      write SetPermissions;
  end;

  TgtRestAPIDocumentGetPropertiesSecurityPDF = class(TgtRestAPIDocumentCommon)
  private
    FExtendedPropertiesSecurity: TgtRestAPIDocPropertiesSecurity;
    function GetExtendedPropertiesSecurity: TgtRestAPIDocPropertiesSecurity;
    procedure SetExtendedPropertiesSecurity(const AValue
      : TgtRestAPIDocPropertiesSecurity);
  public
    property ExtendedPropertiesSecurity: TgtRestAPIDocPropertiesSecurity
      read GetExtendedPropertiesSecurity write SetExtendedPropertiesSecurity;
  end;

  TgtRestAPIResponseGetPropertiesPDF = class
  private
    FOprStatusCode: Integer;
    FDocuments: TArray<TgtRestAPIDocumentGetPropertiesPDF>;
    function GetDocuments: TArray<TgtRestAPIDocumentGetPropertiesPDF>;
    procedure SetDocuments(const AValue
      : TArray<TgtRestAPIDocumentGetPropertiesPDF>);
  public
    property OprStatusCode: Integer read FOprStatusCode write FOprStatusCode;
    property Documents: TArray<TgtRestAPIDocumentGetPropertiesPDF>
      read GetDocuments write SetDocuments;
  end;

  TgtRestAPIResponseGetPropertiesSecurityPDF = class
  private
    FOprStatusCode: Integer;
    FDocuments: TArray<TgtRestAPIDocumentGetPropertiesSecurityPDF>;
    function GetDocuments: TArray<TgtRestAPIDocumentGetPropertiesSecurityPDF>;
    procedure SetDocuments(const AValue
      : TArray<TgtRestAPIDocumentGetPropertiesSecurityPDF>);
  public
    property OprStatusCode: Integer read FOprStatusCode write FOprStatusCode;
    property Documents: TArray<TgtRestAPIDocumentGetPropertiesSecurityPDF>
      read GetDocuments write SetDocuments;
  end;

  TgtRestAPIDocumentError = class
  private
    FUrl: string;
  public
    property Url: string read FUrl write FUrl;
  end;

  TgtRestAPIResponseError = class
  private
    FErrorCode: Integer;
    FErrorMessage: string;
    FDocuments: TArray<TgtRestAPIDocumentError>;
  public
    property ErrorCode: Integer read FErrorCode write FErrorCode;
    property ErrorMessage: string read FErrorMessage write FErrorMessage;
    property Documents: TArray<TgtRestAPIDocumentError> read FDocuments
      write FDocuments;
  end;

  TgtRestAPIResponseJob = class
  private
    FUri: string;
  public
    property Uri: string read FUri write FUri;
  end;

  TgtRestAPIResponseJobs = class
  private
    FOprStatusCode: Integer;
    FJobs: TArray<TgtRestAPIResponseJob>;
  public
    property OprStatusCode: Integer read FOprStatusCode write FOprStatusCode;
    property Jobs: TArray<TgtRestAPIResponseJob> read FJobs write FJobs;
  end;

  { TgtRestAPIResponseCreateView }
  TgtRestAPIResponseCreateView = class
  private
    FUrl: String;
    FTimeToLive: Longint;
  public
    property Url: string read FUrl write FUrl;
    property TimeToLive: Longint read FTimeToLive write FTimeToLive;
  end;

  { TgtViewResponse }
  TgtViewResponse = class
  private
    FUrl: String;
    FTimeToLive: Longint;
  public
    constructor Create(AApiResponse: TgtRestAPIResponseCreateView);
    destructor Destroy; override;
    property Url: string read FUrl write FUrl;
    property TimeToLive: Longint read FTimeToLive write FTimeToLive;
  end;

  { TgtVisibleNavigationControls }
  TgtVisibleNavigationControls = class
  private
    FFirstPage: Boolean;
    FLastPage: Boolean;
    FPrevPage: Boolean;
    FNextPage: Boolean;
    FPageIndicator: Boolean;
    FGotoPage: Boolean;
    function ToJson(): String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TgtVisibleNavigationControls);
    property FirstPage: Boolean read FFirstPage write FFirstPage;
    property LastPage: Boolean read FLastPage write FLastPage;
    property PrevPage: Boolean read FPrevPage write FPrevPage;
    property NextPage: Boolean read FNextPage write FNextPage;
    property PageIndicator: Boolean read FPageIndicator write FPageIndicator;
    property GotoPage: Boolean read FGotoPage write FGotoPage;
  end;

  TgtVisibleZoomControls = class
  private
    FFixedSteps: Boolean;
    FZoomIn: Boolean;
    FZoomOut: Boolean;
    function ToJson(): String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TgtVisibleZoomControls);
    property FixedSteps: Boolean read FFixedSteps write FFixedSteps;
    property ZoomIn: Boolean read FZoomIn write FZoomIn;
    property ZoomOut: Boolean read FZoomOut write FZoomOut;
  end;

  TgtVisibleRotationControls = class
  private
    FClockwise: Boolean;
    FCounterClockwise: Boolean;
    function ToJson(): String;
  public
    constructor Create;
    destructor Destroy; override;
    property Clockwise: Boolean read FClockwise write FClockwise;
    property CounterClockwise: Boolean read FCounterClockwise
      write FCounterClockwise;
  end;

  TgtVisibleColorInversionControls = class
  private
    FAllPages: Boolean;
    function ToJson(): String;
  public
    constructor Create;
    destructor Destroy; override;
    property AllPages: Boolean read FAllPages write FAllPages;
  end;

  TgtSearchControls = class
  private
    FEnableQuickSearch: Boolean;
    FHighlightColor: TgtColor;
    function ToJson(): String;
    function GetHighlightColor: TgtColor;
    procedure SetHighlightColor(const AValue: TgtColor);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TgtSearchControls);
    property EnableQuickSearch: Boolean read FEnableQuickSearch
      write FEnableQuickSearch;
    property HighlightColor: TgtColor read GetHighlightColor
      write SetHighlightColor;
  end;

  TgtViewerSettings = class
  private
    FEnableFormFilling: Boolean;
    FToolbarVisible: Boolean;
    FFullScreenVisible: Boolean;
    FVisibleNavigationControls: TgtVisibleNavigationControls;
    FVisibleZoomControls: TgtVisibleZoomControls;
    FVisibleRotationControls: TgtVisibleRotationControls;
    FVisibleColorInversionControls: TgtVisibleColorInversionControls;
    FSearchControls: TgtSearchControls;
    function GetVisibleNavigationControls: TgtVisibleNavigationControls;
    function GetVisibleZoomControls: TgtVisibleZoomControls;
    function GetVisibleRotationControls: TgtVisibleRotationControls;
    function GetVisibleColorInversionControls: TgtVisibleColorInversionControls;
    function GetSearchControls: TgtSearchControls;
    // procedure SetVisibleNavigationControls(const AValue
    // : TgtVisibleNavigationControls);
    // procedure SetVisibleZoomControls(const AValue: TgtVisibleZoomControls);
    // procedure SetVisibleRotationControls(const AValue
    // : TgtVisibleRotationControls);
    // procedure SetVisibleColorInversionControls(const AValue
    // : TgtVisibleColorInversionControls);
    // procedure SetSearchControls(const AValue: TgtSearchControls);
    function ToJson(): String;
  public
    constructor Create;
    destructor Destroy; override;
    property EnableFormFilling: Boolean read FEnableFormFilling
      write FEnableFormFilling;
    property ToolbarVisible: Boolean read FToolbarVisible write FToolbarVisible;
    property FullScreenVisible: Boolean read FFullScreenVisible
      write FFullScreenVisible;
    property VisibleNavigationControls: TgtVisibleNavigationControls
      read GetVisibleNavigationControls;
    property VisibleZoomControls: TgtVisibleZoomControls
      read GetVisibleZoomControls;
    property VisibleRotationControls: TgtVisibleRotationControls
      read GetVisibleRotationControls;
    property VisibleColorInversionControls: TgtVisibleColorInversionControls
      read GetVisibleColorInversionControls;
    property SearchControls: TgtSearchControls read GetSearchControls;
  end;

  TgtViewer = class
  private
    FStarDocs: TgtStarDocsSDK;
    FViewerSettings: TgtViewerSettings;
    function GetViewerSettings: TgtViewerSettings;
  public
    constructor Create(AStarDocs: TgtStarDocsSDK);
    destructor Destroy; override;
    property ViewerSettings: TgtViewerSettings read GetViewerSettings;
    function CreateView(AFile: TgtFileObject; APassword: string = '')
      : TgtViewResponse;
    procedure DeleteView(AResponse: TgtViewResponse);
  end;

  { TgtPDFFormFieldFillData }
  TgtPDFFormFieldFillData = class
  private
    FFieldName: string;
    FFieldValue: string;
    FFlattenField: Boolean;
  public
    constructor Create(AFieldName: string; AFieldValue: string; AFlattenField: Boolean = False);
    property FieldName: string read FFieldName write FFieldName;
    property FieldValue: string read FFieldValue write FFieldValue;
    property FlattenField: Boolean read FFlattenField write FFlattenField;
  end;

implementation

{ Helper routines }
const
  BooleanToString: array [False .. True] of string = ('False', 'True');

  { TgtStarDocsSDK }

constructor TgtStarDocsSDK.Create(AOwner: TComponent);
begin
  inherited;
  FConnectionInfo := TgtConnectionInfo.Create;
  FPreferences := TgtPreferences.Create;
  { Instantiate service groups }
  FAuth := TgtAuth.Create(Self);
  FStorage := TgtStorage.Create(Self);
  FDocOperations := TgtDocOperations.Create(Self);
  FViewer := TgtViewer.Create(Self);
end;

constructor TgtStarDocsSDK.Create(AOwner: TComponent;
  AConnectionInfo: TgtConnectionInfo; APreferences: TgtPreferences);
begin
  Create(AOwner);
  FConnectionInfo.Assign(AConnectionInfo);
  FPreferences.Assign(APreferences);
end;

destructor TgtStarDocsSDK.Destroy;
begin
  FConnectionInfo.Free;
  FPreferences.Free;
  FAuth.Free;
  FStorage.Free;
  FDocOperations.Free;
  FViewer.Free;
  inherited;
end;

function TgtStarDocsSDK.EncodeJsonDocuments(ADocUris, APasswords: TStringList;
  APageRanges: TObjectList<TgtPageRangeSettings>): string;
var
  LJsonStr: string;
  LIndex: Integer;
  LPageRange: TgtPageRangeSettings;
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

function TgtStarDocsSDK.GetAuth: TgtAuth;
begin
  Result := FAuth;
end;

function TgtStarDocsSDK.GetConnectionInfo: TgtConnectionInfo;
begin
  Result := FConnectionInfo;
end;

function TgtStarDocsSDK.GetDocOperations: TgtDocOperations;
begin
  Result := FDocOperations;
end;

function TgtStarDocsSDK.GetDocUri(AFile: TgtFileObject): string;
var
  LOutDoc: TgtDocObject;
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

function TgtStarDocsSDK.GetPreferences: TgtPreferences;
begin
  Result := FPreferences;
end;

function TgtStarDocsSDK.GetStorage: TgtStorage;
begin
  Result := FStorage;
end;

function TgtStarDocsSDK.GetViewer: TgtViewer;
begin
  Result := FViewer;
end;

function TgtStarDocsSDK.IssueGetRequestAndPoll(AUrl: string): string;
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
    LRestRequestGet.Domain(AUrl).WithReadTimeout(FConnectionInfo.FServerTimeout)
      .WithBearerToken(FAuthResponse.AccessToken);
    LRestResp := LRestRequestGet.Get;
    if (LRestResp.ResponseCode = 201) OR (LRestResp.ResponseCode = 200) then
    begin
      // Poll not required, return response
      Result := LRestResp.ResponseStr;
      Exit;
    end;

    if LRestResp.ResponseCode <> 202 then
      raise EgtStarDocsException.Create(LRestResp.ResponseCode,
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
        raise EgtStarDocsException.Create(LRestResp.ResponseCode,
          LRestResp.ResponseStr);
      end;

      // Check if operation is taking too long
      if ConnectionInfo.DocOperationTimeout > 0 then
      begin
        LStopWatch.Stop;
        if LStopWatch.ElapsedMilliseconds > ConnectionInfo.DocOperationTimeout
        then
          raise EgtStarDocsException.Create(0,
            TgtExceptionStatusCode.escOperationTimedOut,
            'The server is taking too long. Try increasing the timeout value.');
      end;
    end;
  finally
    LStopWatch.Reset;
    LRestRequestGet.Free;
    LRestRequestGetPoll.Free;
  end;
end;

function TgtStarDocsSDK.IssuePostPutRequestAndPoll(AUrl: string; APost: Boolean;
  AJsonStr: string): string;
var
  LRestResp: THttpResponse;
  LRestRequestPost: TRestRequest;
  LRestRequestGet: TRestRequest;
  // LResponseError: TgtRestAPIResponseError;
  // LJobsResponse: TgtRestAPIResponseJobs;
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
      raise EgtStarDocsException.Create(LRestResp.ResponseCode,
        LRestResp.ResponseStr);

    // Get the job URL and start polling for completion
    // LJobsResponse := TJSON.JsonToObject<TgtRestAPIResponseJobs>(LRestResp.ResponseStr);
    // LFullJobUri := LJobsResponse.Jobs[0].Uri;
    LFullJobUri := LRestResp.LocationHeader;
    LRestRequestGet.Domain(LFullJobUri).WithReadTimeout
      (FConnectionInfo.FServerTimeout).WithBearerToken
      (FAuthResponse.AccessToken);
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
        raise EgtStarDocsException.Create(LRestResp.ResponseCode,
          LRestResp.ResponseStr);
      end;

      // Check if operation is taking too long
      if ConnectionInfo.DocOperationTimeout > 0 then
      begin
        LStopWatch.Stop;
        if LStopWatch.ElapsedMilliseconds > ConnectionInfo.DocOperationTimeout
        then
          raise EgtStarDocsException.Create(0,
            TgtExceptionStatusCode.escOperationTimedOut,
            'The server is taking too long. Try increasing the timeout value.');
      end;
    end;
  finally
    LStopWatch.Reset;
    LRestRequestGet.Free;
    LRestRequestPost.Free;
  end;
end;

procedure TgtStarDocsSDK.SetAuth(const AValue: TgtAuth);
begin
  FAuth := AValue;
end;

procedure TgtStarDocsSDK.SetConnectionInfo(const AValue: TgtConnectionInfo);
begin
  FConnectionInfo.Assign(AValue);
end;

procedure TgtStarDocsSDK.SetPreferences(const AValue: TgtPreferences);
begin
  FPreferences.Assign(AValue);
end;

procedure TgtStarDocsSDK.SetStorage(const AValue: TgtStorage);
begin
  FStorage := AValue;
end;

{ TgtConnectionInfo }
constructor TgtConnectionInfo.Create;
begin
  FApiServerVersion := '';
  FPollInterval := 1000;
  FApiServerUri := TIdURI.Create;
  FApiKey := '';
  FApiSecret := '';
  FServerTimeout := -1;
  FDocOperationTimeout := -1;
end;

procedure TgtConnectionInfo.Assign(Source: TPersistent);
begin
  if Source is TgtConnectionInfo then
  begin
    FApiServerVersion := TgtConnectionInfo(Source).FApiServerVersion;
    FPollInterval := TgtConnectionInfo(Source).FPollInterval;
    FApiServerUri.Uri := TgtConnectionInfo(Source).FApiServerUri.Uri;
    FApiKey := TgtConnectionInfo(Source).FApiKey;
    FApiSecret := TgtConnectionInfo(Source).FApiSecret;
    FServerTimeout := TgtConnectionInfo(Source).FServerTimeout;
    FDocOperationTimeout := TgtConnectionInfo(Source).FDocOperationTimeout;
    Exit;
  end;
  inherited Assign(Source)
end;

destructor TgtConnectionInfo.Destroy;
begin
  FApiServerUri.Free;
  inherited;
end;

{ TgtDocPasswordSettings }
constructor TgtDocPasswordSettings.Create(AForceFullPermission: Boolean);
begin
  FForceFullPermission := AForceFullPermission;
end;

destructor TgtDocPasswordSettings.Destroy;
begin
  inherited;
end;

procedure TgtDocPasswordSettings.Assign(Source: TPersistent);
begin
  if Source is TgtDocPasswordSettings then
  begin
    FForceFullPermission := TgtDocPasswordSettings(Source).FForceFullPermission;
    Exit;
  end;
  inherited Assign(Source);
end;

{ TgtPreferences }
constructor TgtPreferences.Create;
begin
  FDocPasswordSettings := TgtDocPasswordSettings.Create(False);
end;

procedure TgtPreferences.Assign(Source: TPersistent);
begin
  if Source is TgtPreferences then
  begin
    FDocPasswordSettings.Assign(TgtPreferences(Source).FDocPasswordSettings);
    Exit;
  end;
  inherited Assign(Source);
end;

destructor TgtPreferences.Destroy;
begin
  FreeAndNil(FDocPasswordSettings);
  inherited;
end;

function TgtPreferences.GetDocPasswordSettings: TgtDocPasswordSettings;
begin
  Result := FDocPasswordSettings;
end;

procedure TgtPreferences.SetDocPasswordSettings(const AValue
  : TgtDocPasswordSettings);
begin
  FDocPasswordSettings.Assign(AValue);
end;

{ TgtDocObject }
constructor TgtDocObject.Create(AApiResponse: TgtRestAPIDocumentCommon);
var
  LRemoteFileUri: TgtRemoteFileUri;
begin
  LRemoteFileUri := TgtRemoteFileUri.Create(AApiResponse.Url);
  inherited Create(LRemoteFileUri);
  FFileName := AApiResponse.FileName;
  FFileSize := AApiResponse.FileSize;
  FPageCount := AApiResponse.PageCount;
  FMimeType := ParseMimeType(AApiResponse.MimeType);
end;

destructor TgtDocObject.Destroy;
begin

  inherited;
end;

function TgtDocObject.ParseMimeType(AMimeType: string): TgtMimeType;
var
  LMimeType: TgtMimeType;
begin
  LMimeType := TgtMimeType.mtUnrecognizable;
  if AMimeType.Equals('application/pdf') then
    LMimeType := TgtMimeType.mtApplication_pdf
  else if AMimeType.Equals('image/bmp') then
    LMimeType := TgtMimeType.mtImage_bmp
  else if AMimeType.Equals('image/gif') then
    LMimeType := TgtMimeType.mtImage_gif
  else if AMimeType.Equals('image/jpeg') then
    LMimeType := TgtMimeType.mtImage_jpeg
  else if AMimeType.Equals('image/png') then
    LMimeType := TgtMimeType.mtImage_png
  else if AMimeType.Equals('image/tiff') then
    LMimeType := TgtMimeType.mtImage_tiff
  else if AMimeType.Equals
    ('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
  then
    LMimeType :=
      TgtMimeType.
      mtApplication_vnd_openxmlformats_officedocument_wordprocessingml_document;
  Result := LMimeType
end;

{ TgtAuthResponse }
constructor TgtAuthResponse.Create(ARestAPIResponseAuth
  : TgtRestAPIResponseAuth);
begin
  FAccessToken := ARestAPIResponseAuth.AccessToken;
  FTokenType := ARestAPIResponseAuth.TokenType;
  FExpiresIn := ARestAPIResponseAuth.ExpiresIn;
end;

destructor TgtAuthResponse.Destroy;
begin
  inherited;
end;

{ TgtFileObject }
constructor TgtFileObject.Create(ARemoteFileUri: TgtRemoteFileUri);
begin
  // Assume file is uploaded
  FStream := nil;
  FStreamFileName := '';
  FFileUploaded := True;
  FRemoteFileUri := TgtRemoteFileUri.Create('');
  FRemoteFileUri.Assign(ARemoteFileUri);
  FLocalFilePath := '';
end;

constructor TgtFileObject.Create(AStream: TStream; AStreamFileName: string);
begin
  FStream := AStream;
  FStreamFileName := AStreamFileName;
  FFileUploaded := False;
  FRemoteFileUri := nil;
  FLocalFilePath := '';
end;

constructor TgtFileObject.Create(ALocalFilePath: string);
begin
  FStream := nil;
  FStreamFileName := '';
  FFileUploaded := False;
  FRemoteFileUri := nil;
  FLocalFilePath := ALocalFilePath;
end;

destructor TgtFileObject.Destroy;
begin
  if FRemoteFileUri <> nil then
    FRemoteFileUri.Free;
  inherited;
end;

function TgtFileObject.GetFileNameFromUri: string;
begin
  Result := TIdURI.URLDecode(RemoteFileUri.FUri.Document);
end;

function TgtFileObject.GetRemoteFileUri: TgtRemoteFileUri;
begin
  Result := FRemoteFileUri;
end;

function TgtFileObject.GetStream: TStream;
begin
  Result := FStream;
end;

procedure TgtFileObject.SetRemoteFileUri(const AValue: TgtRemoteFileUri);
begin
  FRemoteFileUri.Assign(AValue);
end;

procedure TgtFileObject.SetStream(const AValue: TStream);
begin
  FStream := AValue;
end;

{
  procedure TgtFileObject.SetUploaded(AUri: string);
  begin
  FFileUploaded := True;
  FRemoteFileUri := TgtRemoteFileUri.Create(AUri);
  end;
}

{ TgtRemoteFileUri }
constructor TgtRemoteFileUri.Create(AUri: TIdURI);
begin
  FUri := TIdURI.Create(AUri.Uri);
end;

constructor TgtRemoteFileUri.Create(AUri: string);
begin
  FUri := TIdURI.Create(AUri);
end;

destructor TgtRemoteFileUri.Destroy;
begin
  FUri.Free;
end;

procedure TgtRemoteFileUri.Assign(Source: TgtRemoteFileUri);
begin
  if Source <> nil then
    FUri := Source.FUri;
end;

constructor TgtGetDocumentInfoResponse.Create(AApiResponse
  : TgtRestAPIResponseGetDocumentInfo);
begin
  inherited Create(AApiResponse);
  FUnsupportedMimeTypeOrCorrupt := AApiResponse.UnsupportedMimeTypeOrCorrupt;
  FPasswordProtected := AApiResponse.PasswordProtected;
  FPasswordCorrect := AApiResponse.PasswordCorrect;
end;

{
  TgtDocProperties
  constructor TgtDocProperties.Create(ATitle, AAuthor, ASubject, AKeywords,
  ACreator: string);
  begin
  Title := ATitle;
  Author := AAuthor;
  Subject := ASubject;
  Keywords := TStringList.Create;
  Keywords.AddStrings(AKeywords.Split([';']));
  Creator := ACreator;
  end;

  procedure TgtDocProperties.Assign(Source: TgtDocProperties);
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

  constructor TgtDocProperties.Create(ATitle, AAuthor, ASubject: string;
  AKeywords: TStringList; ACreator: string);
  begin
  Title := ATitle;
  Author := AAuthor;
  Subject := ASubject;
  Keywords := AKeywords;
  Creator := ACreator;
  end;

  function TgtDocProperties.ToJson: string;
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

  constructor TgtPDFDocProperties.Create(ATitle, AAuthor, ASubject: string;
  AKeywords: TStringList; ACreator, AProducer: string;
  AHasExPropertySecurity: Boolean);
  begin
  inherited Create(ATitle, AAuthor, ASubject, AKeywords, ACreator);

  FProducer := AProducer;
  FHasExPropertySecurity := AHasExPropertySecurity;
  end;

  TgtGetPropertiesResponse
  constructor TgtGetPropertiesResponse.Create(AApiResponse
  : TgtRestAPIResponseGetPropertiesPDF);
  var
  LCommonProps: TgtRestAPIDocPropertiesCommon;
  LExProps: TgtRestAPIDocExPropertiesPDF;
  LKeywords: TStringList;
  begin
  inherited Create(AApiResponse.Documents[0]);

  LCommonProps := AApiResponse.Documents[0].Properties;
  LExProps := AApiResponse.Documents[0].ExtendedProperties;

  // Parse the semi-colon-seperated keywords into a list
  LKeywords := TStringList.Create;
  LKeywords.AddStrings(LCommonProps.Keywords.Split([';']));
  FDocProperties := TgtPDFDocProperties.Create(LCommonProps.Title,
  LCommonProps.Author, LCommonProps.Subject, LKeywords, LCommonProps.Creator,
  LCommonProps.Producer, LExProps.HasBookmarks);
  end;

  function TgtGetPropertiesResponse.GetDocProperties: TgtDocProperties;
  begin
  Result := FDocProperties;
  end;

  procedure TgtGetPropertiesResponse.SetDocProperties(const AValue
  : TgtDocProperties);
  begin
  FDocProperties.Assign(AValue);
  end;
}
{ TgtDocErrorDetails }
constructor TgtDocErrorDetails.Create(AUri: string);
begin
  FUri := AUri;
end;

destructor TgtDocErrorDetails.Destroy;
begin

  inherited;
end;

{ EgtStarDocsException }
constructor EgtStarDocsException.Create(AHttpStatusCode: Integer;
  AErrorCode: TgtExceptionStatusCode; const AMessage: string);
begin
  inherited Create(AMessage);
  FHttpStatusCode := AHttpStatusCode;
  FErrorCode := AErrorCode;
end;

constructor EgtStarDocsException.Create(AHttpStatusCode: Integer;
  AApiResponseStr: string);
var
  FRestAPIResponseError: TgtRestAPIResponseError;
begin
  if (AApiResponseStr.Length > 0) then
  begin
    FRestAPIResponseError := TJSON.JsonToObject<TgtRestAPIResponseError>
      (AApiResponseStr);
    Create(AHttpStatusCode, FRestAPIResponseError);
  end
  else
    Create(AHttpStatusCode, TgtExceptionStatusCode(0), '');
end;

constructor EgtStarDocsException.Create(AHttpStatusCode: Integer;
  AApiResponse: TgtRestAPIResponseError);
var
  Li: Integer;
  LNumDocs: Integer;
begin
  inherited Create(AApiResponse.FErrorMessage);
  FHttpStatusCode := AHttpStatusCode;
  FErrorCode := TgtExceptionStatusCode(AApiResponse.ErrorCode);
  FDocuments := TObjectList<TgtDocErrorDetails>.Create();
  LNumDocs := Length(AApiResponse.Documents);
  for Li := 0 to LNumDocs - 1 do
    FDocuments.Add(TgtDocErrorDetails.Create(AApiResponse.FDocuments[Li].FUrl));
end;

destructor EgtStarDocsException.Destroy;
begin

  inherited;
end;

constructor EgtStarDocsException.Create(AApiResponse: TgtRestAPIResponseError);
begin

end;

{ TgtPageRange }
constructor TgtPageRange.Create(ARange: string);
begin
  FRange := ARange;
end;

destructor TgtPageRange.Destroy;
begin

  inherited;
end;

{
  procedure TgtPageRange.Assign(ASource: TgtPageRange);
  begin
  if ASource <> nil then
  Range := ASource.Range.Trim;
  end;
}

procedure TgtPageRange.AddPage(APage: Integer);
begin
  if Length(Range) > 0 then
    FRange := FRange + ',';
  FRange := FRange + IntToStr(APage);
end;

procedure TgtPageRange.AddPages(APages: TList<Integer>);
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

procedure TgtPageRange.AddRange(AStartPage: Integer; AEndPage: Integer);
begin
  if Length(FRange) > 0 then
    FRange := FRange + ',';
  FRange := FRange + IntToStr(AStartPage) + '-' + IntToStr(AEndPage);
end;

procedure TgtPageRange.Clear();
begin
  FRange := '';
end;

{ TgtPageRangeSettings }

constructor TgtPageRangeSettings.Create(APageRange: TgtPageRange;
  APageSubRangeMode: TgtPageSubRangeMode = TgtPageSubRangeMode.psmAll;
  AReverseOrder: Boolean = False);
var
  LPageRange: string;
begin
  LPageRange := '';
  if APageRange <> nil then
    LPageRange := APageRange.FRange;
  FPageRange := TgtPageRange.Create(LPageRange);
  FPageSubRangeMode := APageSubRangeMode;
  FReverseOrder := AReverseOrder;
end;

constructor TgtPageRangeSettings.Create(APageRange: string;
  APageSubRangeMode: TgtPageSubRangeMode; AReverseOrder: Boolean);
begin
  FPageRange := TgtPageRange.Create(APageRange.Trim);
  FPageSubRangeMode := APageSubRangeMode;
  FReverseOrder := AReverseOrder
end;

destructor TgtPageRangeSettings.Destroy;
begin
  FPageRange.Free;
  inherited;
end;

function TgtPageRangeSettings.GetPageRange: TgtPageRange;
begin
  Result := FPageRange;
end;

procedure TgtPageRangeSettings.SetPageRange(const AValue: TgtPageRange);
begin
  FPageRange := AValue;
end;

function TgtPageRangeSettings.ToJson(AExcludeOrdering: Boolean = False): string;
begin
  Result := '{"range":"' + FPageRange.FRange + '","subRangeMode":"' +
    GetEnumName(TypeInfo(TgtPageSubRangeMode), Integer(FPageSubRangeMode))
    .Substring(3) + '"';
  if not AExcludeOrdering then
    Result := Result + ',"reverseOrder":' + BooleanToString[FReverseOrder];
  Result := Result + '}';
end;

{ TgtPageSeparator }
constructor TgtPageSeparator.Create;
begin
  FPageSeparatorType := pstEmptyPage;
end;

destructor TgtPageSeparator.Destroy;
begin
  inherited;
end;

function TgtPageSeparator.EncodeString: string;
begin
  Result := GetEnumName(TypeInfo(TgtPageSubRangeMode),
    Integer(FPageSeparatorType)).Substring(3)
end;

{ TgtSearchText }

constructor TgtSearchText.Create(AText: string; ACaseSensitive: Boolean = False;
  AWholeWord: Boolean = False);
begin
  FText := AText;
  FCaseSensitive := ACaseSensitive;
  FWholeWord := AWholeWord;
end;

destructor TgtSearchText.Destroy;
begin
  inherited;
end;

{ TgtColor }
procedure TgtColor.Assign(Source: TgtColor);
begin
  if Source <> nil then
  begin
    FRed := Source.FRed;
    FGreen := Source.FGreen;
    FBlue := Source.FBlue;
    FAlpha := Source.FAlpha;
  end;
end;

constructor TgtColor.Create(ARed: Byte; AGreen: Byte; ABlue: Byte;
  AAlpha: Byte = 100);
begin
  FRed := ARed;
  FGreen := AGreen;
  FBlue := ABlue;
  FAlpha := AAlpha;
end;

destructor TgtColor.Destroy;
begin
  inherited;
end;

function TgtColor.EncodeString(AEncodeAlpha: Boolean): string;
begin
  // Convert each component to hex string and concatenate them as RRGGBBAA
  Result := '#' + IntToHex(Red, 2) + IntToHex(Green, 2) + IntToHex(Blue, 2);
  if AEncodeAlpha then
    Result := Result + IntToHex(Alpha, 2);
end;

{ TgtPen }
constructor TgtPen.Create;
begin
  FColor := TgtColor.Create(0, 0, 0);
  FStyle := pstSolid;
  FWidth := 1;
end;

destructor TgtPen.Destroy;
begin
  FColor.Free;
  inherited;
end;

function TgtPen.GetColor: TgtColor;
begin
  Result := FColor;
end;

{ TgtBrush }
constructor TgtBrush.Create;
begin
  FColor := TgtColor.Create(0, 0, 0);
  FPattern := bptSolid;
end;

destructor TgtBrush.Destroy;
begin
  FColor.Free;
  inherited;
end;

function TgtBrush.GetColor: TgtColor;
begin
  Result := FColor;
end;

{ TgtOutline }
constructor TgtOutline.Create;
begin
  FPenColoringMode := cmoNone;
  FPen := TgtPen.Create();
end;

destructor TgtOutline.Destroy;
begin
  FPen.Free;
  inherited;
end;

function TgtOutline.GetPen: TgtPen;
begin
  Result := FPen;
end;

function TgtOutline.ToJson: string;
begin
  Result := '"outline":{';
  // Encode Color
  Result := Result + '"color":';
  if FPenColoringMode = TgtColoringMode.cmUseColor then
    Result := Result + ('"' + Pen.Color.EncodeString + '"')
  else
    Result := Result + '"none"';
  // Encode Width
  Result := Result + ',"width":' + IntToStr(Pen.Width);
  // Encode PenStyle
  Result := Result + ',"style":"' + GetEnumName(TypeInfo(TgtPenStyle),
    Integer(FPen.Style)).Substring(3) + '"';
  Result := Result + '}';
end;

{ TgtFillRect }
constructor TgtFillRect.Create;
begin
  FBrushColoringMode := cmoNone;
  FBrush := TgtBrush.Create();
end;

destructor TgtFillRect.Destroy;
begin
  FBrush.Free;
  inherited;
end;

function TgtFillRect.GetBrush: TgtBrush;
begin
  Result := FBrush;
end;

function TgtFillRect.ToJson: string;
begin
  Result := '"fill":{';
  // Encode Color
  Result := Result + '"color":';
  if FBrushColoringMode = TgtColoringMode.cmUseColor then
    Result := Result + ('"' + FBrush.Color.EncodeString + '"')
  else
    Result := Result + '"none"';
  // Encode Pattern
  Result := Result + ',"pattern":"' + GetEnumName(TypeInfo(TgtBrushPattern),
    Integer(FBrush.Pattern)).Substring(3) + '"';
  Result := Result + '}';
end;

{ TgtFont }
constructor TgtFont.Create;
begin
  FName := 'Arial';
  FSize := 10;
  FColor := TgtColor.Create(0, 0, 0, 100);
  FStyles := [];
  FEffects := [];
end;

destructor TgtFont.Destroy;
begin
  FColor.Free;
  inherited;
end;

function TgtFont.GetColor: TgtColor;
begin
  Result := FColor;
end;

function TgtFont.ToJson(AFontSizingMode: TgtFontSizingMode;
  AFontColoringMode: TgtFontColoringMode): string;
begin
  Result := '"font":{';
  // Encode Name
  Result := Result + '"name":"' + Name + '"';
  // Encode Style
  Result := Result + ',"style":{';
  Result := Result + '"bold":' + BooleanToString[fstBold in FStyles];
  Result := Result + ',"italic":' + BooleanToString[fstItalic in FStyles];
  Result := Result + ',"underline":' + BooleanToString[fstUnderline in FStyles];
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

{ TgtFillText }
constructor TgtFillText.Create;
begin
  FReplaceText := '';
  FFontSelectionMode := fsmUseFont;
  FFontSizingMode := fsmAutoFit;
  FFontColoringMode := fcmSource;
  FFont := TgtFont.Create;
end;

destructor TgtFillText.Destroy;
begin
  FFont.Free;
  inherited;
end;

function TgtFillText.GetFont: TgtFont;
begin
  Result := FFont;
end;

function TgtFillText.ToJson: string;
begin
  Result := '"text":{';
  // Encode Text
  Result := Result + '"replaceText":"' + ReplaceText + '"';
  // Encode Font
  if FFontSelectionMode = TgtFontSelectionMode.fsmUseFont then
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

{ TgtRedactFillSettings }

constructor TgtRedactFillSettings.Create;
begin

  FOutline := TgtOutline.Create;
  FFillRect := TgtFillRect.Create;
  FFillText := TgtFillText.Create;
end;

destructor TgtRedactFillSettings.Destroy;
begin
  FOutline.Free;
  FFillRect.Free;
  FFillText.Free;
  inherited;
end;

function TgtRedactFillSettings.GetFillRect: TgtFillRect;
begin
  Result := FFillRect;
end;

function TgtRedactFillSettings.GetFillText: TgtFillText;
begin
  Result := FFillText;
end;

function TgtRedactFillSettings.GetOutline: TgtOutline;
begin
  Result := FOutline;
end;

function TgtRedactFillSettings.ToJson(): string;
begin
  Result := '"fillSettings":{';
  Result := Result + FOutline.ToJson;
  Result := Result + ',' + FFillRect.ToJson;
  Result := Result + ',' + FFillText.ToJson;
  Result := Result + '}';
end;

{ TgtEncoderSettings }
function TgtEncoderSettings.ToJson: string;
begin
  Result := '';
end;

{ TgtDPI }
constructor TgtDPI.Create;
begin
  FResolutionMode := rmmUseSource;
  FX := 72;
  FY := 72;
end;

destructor TgtDPI.Destroy;
begin

  inherited;
end;

function TgtDPI.ToJson: String;
begin
  Result := '"dpi": {"resolutionMode":"' +
    GetEnumName(TypeInfo(TgtResolutionMode), Integer(FResolutionMode))
    .Substring(3) + '"';
  if FResolutionMode = TgtResolutionMode.rmmUseSpecifiedDPI then
  begin
    Result := Result + ',"x":' + IntToStr(FX);
    Result := Result + ',"y":' + IntToStr(FY);
  end;
  Result := Result + '}';
end;

{ TgtSize }
constructor TgtSize.Create;
begin
  FPaperSize := psiA4;
  FWidth := 0;
  FHeight := 0;
  FMeasurementUnit := munMillimeters;
end;

destructor TgtSize.Destroy;
begin

  inherited;
end;

function TgtSize.EncodeString: String;
begin
  if FPaperSize = TgtPaperSize.psiCustom then
    Result := IntToStr(FWidth) + ';' + IntToStr(FHeight) + ';' +
      GetEnumName(TypeInfo(TgtPaperSize), Integer(FPaperSize)).Substring(3)
  else
    Result := GetEnumName(TypeInfo(TgtPaperSize), Integer(FPaperSize))
      .Substring(3);
end;

{ TgtCanvasSize }
constructor TgtCanvasSize.Create;
begin
  FSizingMode := csmUseSource;
  FSize := TgtSize.Create();
  FRelativeSizeX := 100;
  FRelativeSizeY := 100;
end;

destructor TgtCanvasSize.Destroy;
begin
  FSize.Free;
  inherited;
end;

function TgtCanvasSize.ToJson: String;
begin
  Result := '"canvasSize": { "sizingMode": "' +
    GetEnumName(TypeInfo(TgtCanvasSizingMode), Integer(FSizingMode))
    .Substring(3) + '"';
  if FSizingMode = TgtCanvasSizingMode.csmUseSpecifiedSize then
    Result := Result + ',"size": "' + FSize.EncodeString() + '"'
  else if FSizingMode = TgtCanvasSizingMode.csmUseSpecifiedRelativeSize then
  begin
    Result := Result + ',"relativeSizeX": ' + IntToStr(FRelativeSizeX);
    Result := Result + ',"relativeSizeY": ' + IntToStr(FRelativeSizeY);
  end;
  Result := Result + '}';
end;

{ TgtContentAlignment }
procedure TgtContentAlignment.Assign(Source: TgtContentAlignment);
begin
  if Source <> nil then
  begin
    FHorizontalAlignmentType := Source.FHorizontalAlignmentType;
    FHorizontalOffset := Source.FHorizontalOffset;
    FVerticalAlignmentType := Source.FVerticalAlignmentType;
    FVerticalOffset := Source.FVerticalOffset;
  end;
end;

constructor TgtContentAlignment.Create;
begin
  FHorizontalAlignmentType := hatCenter;
  FHorizontalOffset := 0;
  FVerticalAlignmentType := vatCenter;
  FVerticalOffset := 0;
end;

destructor TgtContentAlignment.Destroy;
begin

  inherited;
end;

function TgtContentAlignment.ToJson: String;
begin
  Result := '"contentAlignment ": { "horizontalAlignment": "' +
    GetEnumName(TypeInfo(TgtHorizontalAlignmentType),
    Integer(FHorizontalAlignmentType)).Substring(3) + '"';
  Result := Result + ',"horizontalOffset": ' + IntToStr(FHorizontalOffset);
  Result := Result + ',"verticalAlignment": "' +
    GetEnumName(TypeInfo(TgtVerticalAlignmentType),
    Integer(FVerticalAlignmentType)).Substring(3) + '"';
  Result := Result + ',"verticalOffset": ' + IntToStr(FVerticalOffset);
  Result := Result + '}';
end;

{ TgtImageEncoderSettings }
constructor TgtImageEncoderSettings.Create;
begin

  FDPI := TgtDPI.Create();
  FQuality := 80;
  FCanvasSize := TgtCanvasSize.Create();
  FContentScaling := cscFitWithAspect;
  FContentAlignment := TgtContentAlignment.Create();
end;

destructor TgtImageEncoderSettings.Destroy;
begin
  FDPI.Free;
  FCanvasSize.Free;
  FContentAlignment.Free;
  inherited;
end;

function TgtImageEncoderSettings.GetContentAlignment: TgtContentAlignment;
begin
  Result := FContentAlignment;
end;

// procedure TgtImageEncoderSettings.SetContentAlignment
// (const AValue: TgtContentAlignment);
// begin
// FContentAlignment.Assign(AValue);
// end;

function TgtImageEncoderSettings.ToJson(): string;
begin
  Result := '"imageEncoderSettings":{';
  Result := Result + FDPI.ToJson();
  Result := Result + ',"quality":' + IntToStr(FQuality);
  Result := Result + ',' + FCanvasSize.ToJson();
  Result := Result + ',"contentScaling":"' +
    GetEnumName(TypeInfo(TgtContentScaling), Integer(FContentScaling))
    .Substring(3) + '"';
  Result := Result + ',' + FContentAlignment.ToJson();
  Result := Result + '}';
end;

{ TgtPDFPortfolioSettings }
constructor TgtPDFPortfolioSettings.Create;
begin
  FPDFPortfolioCreationMode := pcmWhenInputIsPortfolio;
  FPDFPortfolioInitialLayout := pilDetails;
end;

destructor TgtPDFPortfolioSettings.Destroy;
begin

  inherited;
end;

function TgtPDFPortfolioSettings.ToJson: String;
begin
  Result := '"portfolioSettings":{';
  Result := Result + '"creationMode": "' +
    GetEnumName(TypeInfo(TgtPDFPortfolioCreationMode),
    Integer(FPDFPortfolioCreationMode)).Substring(3) + '"';
  Result := Result + ',"initialLayout": "' +
    GetEnumName(TypeInfo(TgtPDFPortfolioInitialLayout),
    Integer(FPDFPortfolioInitialLayout)).Substring(3) + '"';
  Result := Result + '}';
end;

{ TgtPDFEncoderSettings }
constructor TgtPDFEncoderSettings.Create;
begin
  FPDFPortfolioSettings := TgtPDFPortfolioSettings.Create();
  FFontEmbeddingType := fetSubset;
  FOverrideFontEmbeddingRestriction := False;
end;

destructor TgtPDFEncoderSettings.Destroy;
begin
  FPDFPortfolioSettings.Free;
  inherited;
end;

function TgtPDFEncoderSettings.GetPDFPortfolioSettings: TgtPDFPortfolioSettings;
begin
  Result := FPDFPortfolioSettings;
end;

procedure TgtPDFEncoderSettings.SetPDFPortfolioSettings
  (const AValue: TgtPDFPortfolioSettings);
begin
  FPDFPortfolioSettings := AValue;
end;

function TgtPDFEncoderSettings.ToJson(): string;
begin
  Result := '"pdfEncoderSettings":{';
  Result := Result + FPDFPortfolioSettings.ToJson();
  Result := Result + '"fontEmbedding":"' +
    GetEnumName(TypeInfo(TgtFontEmbeddingType), Integer(FFontEmbeddingType))
    .Substring(3) + '"';
  Result := Result + ',"overrideFontEmbeddingRestriction":' + BooleanToString
    [FOverrideFontEmbeddingRestriction];
  Result := Result + '}';
end;

{ TgtAuth }
constructor TgtAuth.Create(AStarDocs: TgtStarDocsSDK);
begin
  FStarDocs := AStarDocs;
end;

destructor TgtAuth.Destroy;
begin

  inherited;
end;

function TgtAuth.loginApp(AEntity: string = ''): TgtAuthResponse;
var
  LRestRequest: TRestRequest;
  LRestResp: THttpResponse;
  LResponseError: TgtRestAPIResponseAuthFailure;
  LResponseSuccess: TgtRestAPIResponseAuth;
begin
  LRestRequest := TRestRequest.Create();
  Result := nil;
  try
    LRestRequest.Domain(FStarDocs.FConnectionInfo.FApiServerUri.Uri)
      .Path('auth/token').WithCredentials(FStarDocs.FConnectionInfo.FApiKey,
      FStarDocs.FConnectionInfo.FApiSecret);
    if AEntity <> '' then
    begin
      LRestRequest.UrlParam('entity_id', AEntity);
    end;
    // LRestRequest.Param('grant_type', 'client_credentials');
    LRestRequest.ContentType := 'application/x-www-form-urlencoded';
    LRestResp := LRestRequest.Post('grant_type=client_credentials');
    if LRestResp.ResponseCode <> 200 then
    begin
      FStarDocs.AuthResponse := nil;
      if LRestResp.ResponseContentType.Equals('application/json') = True then
      begin
        LResponseError := TJSON.JsonToObject<TgtRestAPIResponseAuthFailure>
          (LRestResp.ResponseStr);
        raise EgtStarDocsException.Create(LRestResp.ResponseCode,
          TgtExceptionStatusCode(0), LResponseError.Error + ':' +
          LResponseError.ErrorDescription + ':' + LResponseError.ErrorUri);
      end;
      raise EgtStarDocsException.Create(LRestResp.ResponseCode,
        TgtExceptionStatusCode(0), LRestResp.ResponseStr);
    end;
    LResponseSuccess := TJSON.JsonToObject<TgtRestAPIResponseAuth>
      (LRestResp.ResponseStr);
    Result := TgtAuthResponse.Create(LResponseSuccess);
    FStarDocs.AuthResponse := Result;
  finally
    LRestRequest.Free;
  end;
end;

{ TgtStorage }
constructor TgtStorage.Create(AStarDocs: TgtStarDocsSDK);
begin
  FStarDocs := AStarDocs;
end;

function TgtStorage.Upload(AFileNameWithPath: string; APassword: string = '')
  : TgtDocObject;
var
  LRestResponse: THttpResponse;
  LRestRequest: TRestRequest;
  LResponseCommon: TgtRestAPIResponseCommon;
  // LResponseError: TgtRestAPIResponseError;
begin
  LRestRequest := TRestRequest.Create();
  Result := nil;
  try
    LRestRequest.Domain(FStarDocs.FConnectionInfo.FApiServerUri.Uri)
      .Path('docs').WithReadTimeout(FStarDocs.FConnectionInfo.FServerTimeout)
      .WithBearerToken(FStarDocs.FAuthResponse.AccessToken);
    LRestRequest.FileParam('fileUpload', AFileNameWithPath);
    LRestRequest.BodyParam('password', APassword);
    LRestRequest.BodyParam('forceFullPermission',
      BooleanToString[FStarDocs.Preferences.DocPasswordSettings.
      ForceFullPermission]);
    LRestResponse := LRestRequest.Post('');
    if LRestResponse.ResponseCode <> 200 then
      raise EgtStarDocsException.Create(LRestResponse.ResponseCode,
        LRestResponse.ResponseStr);
    LResponseCommon := TJSON.JsonToObject<TgtRestAPIResponseCommon>
      (LRestResponse.ResponseStr);
    Result := TgtDocObject.Create(LResponseCommon.Documents[0]);
  finally
    LRestRequest.Free;
  end;
end;

function TgtStorage.Upload(AStream: TStream; AfileName: string;
  APassword: string = ''): TgtDocObject;
var
  LRestResp: THttpResponse;
  LRestRequest: TRestRequest;
  LResponseCommon: TgtRestAPIResponseCommon;
  // LResponseError: TgtRestAPIResponseError;
begin
  Result := nil;
  LRestRequest := TRestRequest.Create();
  try
    LRestRequest.Domain(FStarDocs.FConnectionInfo.FApiServerUri.Uri)
      .Path('docs').WithReadTimeout(FStarDocs.FConnectionInfo.FServerTimeout)
      .WithBearerToken(FStarDocs.FAuthResponse.AccessToken);
    LRestRequest.FileParam('fileUpload', AfileName, AStream);
    LRestRequest.BodyParam('password', APassword);
    LRestRequest.BodyParam('forceFullPermission',
      BooleanToString[FStarDocs.Preferences.DocPasswordSettings.
      ForceFullPermission]);
    LRestResp := LRestRequest.Post('');
    if LRestResp.ResponseCode <> 200 then
      raise EgtStarDocsException.Create(LRestResp.ResponseCode,
        LRestResp.ResponseStr);
    LResponseCommon := TJSON.JsonToObject<TgtRestAPIResponseCommon>
      (LRestResp.ResponseStr);
    Result := TgtDocObject.Create(LResponseCommon.Documents[0]);
  finally
    LRestRequest.Free;
  end;
end;

procedure TgtStorage.Download(AFile: TgtFileObject; AFilePath: string);
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
    if AFile.ClassType = TgtDocObject then
      LFileName := TgtDocObject(AFile).FileName
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

destructor TgtStorage.Destroy;
begin
  inherited;
end;

procedure TgtStorage.Download(AFile: TgtFileObject; FOutStream: TStream);
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
      raise EgtStarDocsException.Create(LRestResponse.ResponseCode,
        LRestResponse.ResponseStr);
    if not LRestResponse.ResponseContentType.Equals('multipart/form-data') then
      raise EgtStarDocsException.Create(0,
        TgtExceptionStatusCode.escUnexpectedResponse,
        'Unexpected response type during download');
  finally
    LRestRequest.Free;
  end;
end;

{ TgtDocOperations }
constructor TgtDocOperations.Create(AStarDocs: TgtStarDocsSDK);
begin
  FStarDocs := AStarDocs;
  FRedactFillSettings := TgtRedactFillSettings.Create;
  FPageSeparator := TgtPageSeparator.Create;
  FImageEncoderSettings := TgtImageEncoderSettings.Create;
  FPDFEncoderSettings := TgtPDFEncoderSettings.Create;
end;

destructor TgtDocOperations.Destroy;
begin
  FRedactFillSettings.Free;
  FPageSeparator.Free;
  FImageEncoderSettings.Free;
  FPDFEncoderSettings.Free;
  inherited;
end;

function TgtDocOperations.GetDocumentInfo(AFile: TgtFileObject;
  APassword: string = ''): TgtGetDocumentInfoResponse;
var
  LUrl: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseGetDocumentInfo;
begin
  LUrl := FStarDocs.GetDocUri(AFile) + '/info';
  LUrl := LUrl + ('?force-full-permission=' + BooleanToString
    [FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission]);
  if APassword <> '' then
    LUrl := LUrl + ('&password=' + APassword);
  LJsonResponseStr := FStarDocs.IssueGetRequestAndPoll(LUrl);
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseGetDocumentInfo>
    (LJsonResponseStr);
  Result := TgtGetDocumentInfoResponse.Create(LJsonResponse);
end;

function TgtDocOperations.GetImageEncoderSettings: TgtImageEncoderSettings;
begin
  Result := FImageEncoderSettings;
end;

function TgtDocOperations.GetPageSeparator: TgtPageSeparator;
begin
  Result := FPageSeparator;
end;

function TgtDocOperations.GetPDFEncoderSettings: TgtPDFEncoderSettings;
begin
  Result := FPDFEncoderSettings;
end;

function TgtDocOperations.GetRedactFillSettings: TgtRedactFillSettings;
begin
  Result := FRedactFillSettings;
end;

(*
  function TgtDocOperations.GetProperties(AFile: TgtFileObject; APassword: string = ''): TgtGetPropertiesResponse;
  var
  LDocUri: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseGetPropertiesPDF;
  begin
  LDocUri := GetDocUri(AFile);
  LJsonStr := '{"operation":"getProperties","documents":[{"uri":"' + LDocUri + '"';
  LJsonStr := LJsonStr + ',"password":"' + APassword + '"}]';
  LJsonStr := LJsonStr + '}';

  LJsonResponseStr := IssueRequestAndPoll(LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseGetPropertiesPDF>(LJsonResponseStr);
  Result := TgtGetPropertiesResponse.Create(LJsonResponse);
  end;

  function TgtDocOperations.SetProperties(AFile: TgtFileObject; APassword: string; AProperties: TgtDocProperties)
  : TgtDocObject;
  var
  LDocUri: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
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
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>(LJsonResponseStr);
  Result := TgtDocObject.Create(LJsonResponse.Documents[0]);
  end;
*)

function TgtDocOperations.Merge(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil): TgtDocObject;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
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
    LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TgtDocObject.Create(LJsonResponse.Documents[0]);
  finally
    LDocUris.Free;
  end;
end;

function TgtDocOperations.SplitByPageRange(AFile: TgtFileObject;
  APassword: string; APageRanges: TObjectList<TgtPageRangeSettings> = nil)
  : TObjectList<TgtDocObject>;
var
  LDocUrl: string;
  LUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonResponse: TgtRestAPIResponseCommon;
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
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TObjectList<TgtDocObject>.Create;
  LNumFiles := Length(LJsonResponse.Documents);
  for LIndex := 0 to LNumFiles - 1 do
    Result.Add(TgtDocObject.Create(LJsonResponse.Documents[LIndex]));
end;

function TgtDocOperations.SplitBySeparatorPage(AFile: TgtFileObject;
  APassword: string): TObjectList<TgtDocObject>;
var
  LDocUrl: string;
  LUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonResponse: TgtRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);
  LJsonStr := '{"documents":[{"url":"' + LDocUrl + '","password":"' +
    APassword + '"';
  if FPageSeparator = nil then
    FPageSeparator := TgtPageSeparator.Create();
  LJsonStr := LJsonStr + ',"separatorType":"' +
    FPageSeparator.EncodeString + '"';
  LJsonStr := LJsonStr + '}]}';
  LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
    '/docs/ops/split-separator';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TObjectList<TgtDocObject>.Create;
  LNumFiles := Length(LJsonResponse.Documents);
  for LIndex := 0 to LNumFiles - 1 do
    Result.Add(TgtDocObject.Create(LJsonResponse.Documents[LIndex]));
end;

function TgtDocOperations.Encrypt(AFile: TgtFileObject; APassword: string;
  APDFEncryptionLevel: TgtPDFEncryptionLevel = TgtPDFEncryptionLevel.
  pelAES_128bit; ANewOpenPassword: string = '';
  ANewPermissionsPassword: string = '';
  ANewPermissions: TgtPDFDocPermissions = []): TgtDocObject;
var
  LUrl: string;
  LDocUrl: string;
  LEncryptionLevelStr: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);
  LEncryptionLevelStr := GetEnumName(TypeInfo(TgtPDFEncryptionLevel),
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
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TgtDocObject.Create(LJsonResponse.Documents[0]);
end;

function TgtDocOperations.FillForm(AFile: TgtFileObject; APassword: string;
  AFormFields: TObjectList<TgtPDFFormFieldFillData>; AFlattenAllFields: Boolean): TgtDocObject;
var
  LUrl: string;
  LDocUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);

  LJsonStr := '{';
  LJsonStr := LJsonStr + '"forceFullPermission":' + BooleanToString
    [FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission];

  if APassword <> '' then
    LJsonStr := LJsonStr + ',"password":"' + APassword + '"';

  if AFormFields <> Nil then
    LJsonStr := LJsonStr + ',' + EncodeFormFieldFillData(AFormFields);

  if AFlattenAllFields then
    LJsonStr := LJsonStr + ',"flattenAllFields":' + BooleanToString[AFlattenAllFields];

  LJsonStr := LJsonStr + '}';

  LUrl := LDocUrl + '/ops/fill-form';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, False,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TgtDocObject.Create(LJsonResponse.Documents[0]);
end;

function TgtDocOperations.RedactText(AFile: TgtFileObject; APassword: string;
  APageRange: TgtPageRangeSettings; ATextSearchMode: TgtTextSearchMode;
  ASearchText: TObjectList<TgtSearchText>;
  AIncludeAdditionalItems: TgtDocumentItems = [];
  ACleanupSettings: TgtRedactCleanupSettings = []): TgtDocObject;
var
  LUrl: string;
  LDocUrl: string;
  LTextSearchModeStr: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
begin
  LDocUrl := FStarDocs.GetDocUri(AFile);
  LTextSearchModeStr := GetEnumName(TypeInfo(TgtTextSearchMode),
    Integer(ATextSearchMode)).Substring(3);

  LJsonStr := '{"searchMode":"' + LTextSearchModeStr + '"';
  LJsonStr := LJsonStr + ',"password":"' + APassword + '"';

  if APageRange <> nil then
    LJsonStr := LJsonStr + ',"pageRange":' + APageRange.ToJson();

  if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
    LJsonStr := LJsonStr + ',"forceFullPermission":true';

  LJsonStr := LJsonStr + ',' + EncodeJsonSearchText(ASearchText);

  if FRedactFillSettings <> nil then
    LJsonStr := LJsonStr + ',' + FRedactFillSettings.ToJson();

  LJsonStr := LJsonStr + ', "includeAdditionalItems": {' +
    SetToCSV(AIncludeAdditionalItems) + '}';
  LJsonStr := LJsonStr + ', "cleanupSettings": {' +
    SetToCSV(ACleanupSettings) + '}';
  LJsonStr := LJsonStr + '}';

  LUrl := LDocUrl + '/ops/redact-text';
  LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, False,
    LJsonStr);
  LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
    (LJsonResponseStr);
  Result := TgtDocObject.Create(LJsonResponse.Documents[0]);
end;

function TgtDocOperations.ConvertToTIFF(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil;
  ATIFFCompressionType: TgtTIFFCompressionType = TgtTIFFCompressionType.
  tctDeflate): TObjectList<TgtDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
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
    if FImageEncoderSettings <> nil then
      LJsonStr := LJsonStr + (',' + FImageEncoderSettings.ToJson());
    LJsonStr := LJsonStr + ',"tiffCompressionType":"' +
      GetEnumName(TypeInfo(TgtTIFFCompressionType),
      Integer(ATIFFCompressionType)).Substring(3) + '"';
    LJsonStr := LJsonStr + '}';

    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
      '/docs/ops/convert-tiff';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtDocOperations.ConvertToMTIFF(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil;
  ATIFFCompressionType: TgtTIFFCompressionType = TgtTIFFCompressionType.
  tctDeflate; AConversionMode: TgtMTIFFConversionMode = TgtMTIFFConversionMode.
  tcmConvertToSeparateFiles): TObjectList<TgtDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
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
    if FImageEncoderSettings <> nil then
      LJsonStr := LJsonStr + (',' + FImageEncoderSettings.ToJson());
    LJsonStr := LJsonStr + ',"tiffCompressionType":"' +
      GetEnumName(TypeInfo(TgtTIFFCompressionType),
      Integer(ATIFFCompressionType)).Substring(3) + '"';
    LJsonStr := LJsonStr + ',"conversionMode":"' +
      GetEnumName(TypeInfo(TgtMTIFFConversionMode), Integer(AConversionMode))
      .Substring(3) + '"';
    LJsonStr := LJsonStr + '}';

    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
      '/docs/ops/convert-mtiff';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtDocOperations.ConvertToJPEG(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil)
  : TObjectList<TgtDocObject>;
begin
  Result := ConvertToImage('convert-jpeg', AFiles, APasswords, APageRanges,
    FImageEncoderSettings);
end;

function TgtDocOperations.ConvertToGIF(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil)
  : TObjectList<TgtDocObject>;
begin
  Result := ConvertToImage('convert-gif', AFiles, APasswords, APageRanges,
    FImageEncoderSettings);
end;

function TgtDocOperations.ConvertToBMP(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil)
  : TObjectList<TgtDocObject>;
begin
  Result := ConvertToImage('convert-bmp', AFiles, APasswords, APageRanges,
    FImageEncoderSettings);
end;

function TgtDocOperations.ConvertToPNG(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil)
  : TObjectList<TgtDocObject>;
begin
  Result := ConvertToImage('convert-png', AFiles, APasswords, APageRanges,
    FImageEncoderSettings);
end;

function TgtDocOperations.ConvertToPDF(AFiles: TObjectList<TgtFileObject>;
  APasswords: TStringList = nil;
  APageRanges: TObjectList<TgtPageRangeSettings> = nil;
  AConversionMode: TgtPDFConversionMode = TgtPDFConversionMode.
  pcmConvertToSeparateFiles): TObjectList<TgtDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
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
    if TgtPDFEncoderSettings <> nil then
      LJsonStr := LJsonStr + (',' + FPDFEncoderSettings.ToJson);
    LJsonStr := LJsonStr + ',"conversionMode": ' +
      GetEnumName(TypeInfo(TgtPDFConversionMode), Integer(AConversionMode))
      .Substring(3) + '"';
    LJsonStr := LJsonStr + '}';

    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri +
      '/docs/ops/convert-pdf';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtDocOperations.ConvertToImage(AUrlPath: string;
  AFiles: TObjectList<TgtFileObject>; APasswords: TStringList;
  APageRanges: TObjectList<TgtPageRangeSettings>;
  AImageEncoderSettings: TgtImageEncoderSettings): TObjectList<TgtDocObject>;
var
  LUrl: string;
  LDocUris: TStringList;
  LNumFiles: Integer;
  LIndex: Integer;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCommon;
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
    LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCommon>
      (LJsonResponseStr);
    Result := TObjectList<TgtDocObject>.Create;
    LNumFiles := Length(LJsonResponse.Documents);
    for LIndex := 0 to LNumFiles - 1 do
      Result.Add(TgtDocObject.Create(LJsonResponse.Documents[LIndex]));
  finally
    LDocUris.Free;
  end;
end;

function TgtDocOperations.EncodeFormFieldFillData
  (AFormFields: TObjectList<TgtPDFFormFieldFillData>): string;
var
  LJsonStr: String;
  I: Integer;
  LformField: TgtPDFFormFieldFillData;
begin
  LJsonStr := '"fields": [';
  for I := 0 to AFormFields.Count - 1 do
  begin
    LformField := AFormFields[I];
    if (I > 0) then
      LJsonStr := LJsonStr + ',';

    LJsonStr := LJsonStr + '{';
    LJsonStr := LJsonStr + '"fieldName":"' + LformField.FieldName + '"';
    LJsonStr := LJsonStr + ',"fieldValue":"' + LformField.FieldValue + '"';
    LJsonStr := LJsonStr + ',"flattenField":' + BooleanToString
      [LformField.FlattenField];
    LJsonStr := LJsonStr + '}';
  end;
  LJsonStr := LJsonStr + ']';
  Result := LJsonStr;
end;

function TgtDocOperations.EncodeJsonPageRanges(APageRanges
  : TObjectList<TgtPageRangeSettings>): string;
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

function TgtDocOperations.EncodeJsonSearchText(ASearchText
  : TObjectList<TgtSearchText>): string;
var
  LJsonStr: string;
  LIndex: Integer;
  LSearchText: TgtSearchText;
begin
  LJsonStr := '"searchText":[';
  for LIndex := 0 to ASearchText.Count - 1 do
  begin
    if LIndex > 0 then
      LJsonStr := LJsonStr + ',';
    LSearchText := ASearchText[LIndex];
    LJsonStr := LJsonStr + '{"text":"' + LSearchText.Text + '","caseSensitive":'
      + BooleanToString[LSearchText.CaseSensitive] + ',"wholeWord":' +
      BooleanToString[LSearchText.WholeWord] + '}';
  end;
  LJsonStr := LJsonStr + ']';
  Result := LJsonStr;
end;

function TgtDocOperations.SetToCSV(ADocumentItems: TgtDocumentItems): string;
begin
  Result := '';
  Result := Result + '"documentProperties":' + BooleanToString
    [ditDocumentProperties in ADocumentItems];
  Result := Result + ',"bookmarks":' + BooleanToString
    [ditBookmarks in ADocumentItems];
  Result := Result + ',"bookmarkActions":' + BooleanToString
    [ditBookmarkActions in ADocumentItems];
  Result := Result + ',"annotations":' + BooleanToString
    [ditAnnotations in ADocumentItems];
  Result := Result + ',"annotationActions":' + BooleanToString
    [ditAnnotationActions in ADocumentItems];
end;

function TgtDocOperations.SetToCSV(ARedactCleanupSettings
  : TgtRedactCleanupSettings): string;
begin
  Result := '';
  Result := Result + '"removeEmptyBookmarks":' + BooleanToString
    [rcsRemoveEmptyBookmarks in ARedactCleanupSettings];
  Result := Result + ',"removeEmptyBookmarkActions":' + BooleanToString
    [rcsRemoveEmptyBookmarkActions in ARedactCleanupSettings];
  Result := Result + ',"removeEmptyAnnotations":' + BooleanToString
    [rcsRemoveEmptyAnnotations in ARedactCleanupSettings];
  Result := Result + ',"removeEmptyAnnotationActions":' + BooleanToString
    [rcsRemoveEmptyAnnotationActions in ARedactCleanupSettings];
  Result := Result + ',"removeAffectedLinkActions":' + BooleanToString
    [rcsRemoveAffectedLinkActions in ARedactCleanupSettings];
end;

function TgtDocOperations.SetToCSV(APDFDocPermissions
  : TgtPDFDocPermissions): string;
begin
  Result := '';
  Result := Result + '"allowAccessibility":' + BooleanToString
    [pdpAllowAccessibility in APDFDocPermissions];
  Result := Result + ',"allowAssembly":' + BooleanToString
    [pdpAllowAssembly in APDFDocPermissions];
  Result := Result + ',"allowCopy":' + BooleanToString
    [pdpAllowCopy in APDFDocPermissions];
  Result := Result + ',"allowFormFill":' + BooleanToString
    [pdpAllowFormFill in APDFDocPermissions];
  Result := Result + ',"allowHighResPrint":' + BooleanToString
    [pdpAllowHighResPrint in APDFDocPermissions];
  Result := Result + ',"allowModifyAnnotations":' + BooleanToString
    [pdpAllowModifyAnnotations in APDFDocPermissions];
  Result := Result + ',"allowModifyContents":' + BooleanToString
    [pdpAllowModifyContents in APDFDocPermissions];
  Result := Result + ',"allowPrinting":' + BooleanToString
    [pdpAllowPrinting in APDFDocPermissions];
end;

{ TgtViewResponse }

constructor TgtViewResponse.Create(AApiResponse: TgtRestAPIResponseCreateView);
begin
  FUrl := AApiResponse.Url;
  FTimeToLive := AApiResponse.FTimeToLive;
end;

destructor TgtViewResponse.Destroy;
begin

  inherited;
end;

{ TgtVisibleNavigationControls }

procedure TgtVisibleNavigationControls.Assign
  (Source: TgtVisibleNavigationControls);
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

constructor TgtVisibleNavigationControls.Create;
begin
  FFirstPage := True;
  FLastPage := True;
  FPrevPage := True;
  FNextPage := True;
  FPageIndicator := True;
  FGotoPage := True;
end;

destructor TgtVisibleNavigationControls.Destroy;
begin

  inherited;
end;

function TgtVisibleNavigationControls.ToJson: String;
begin
  Result := '"visibleNavigationControls":{';
  Result := Result + '"firstPage":' + BooleanToString[FFirstPage];
  Result := Result + ',"lastPage":' + BooleanToString[FLastPage];
  Result := Result + ',"prevPage":' + BooleanToString[FPrevPage];
  Result := Result + ',"nextPage":' + BooleanToString[FNextPage];
  Result := Result + ',"pageIndicator":' + BooleanToString[FPageIndicator];
  Result := Result + ',"gotoPage":' + BooleanToString[FGotoPage];
  Result := Result + '}';
end;

{ TgtVisibleZoomControls }

procedure TgtVisibleZoomControls.Assign(Source: TgtVisibleZoomControls);
begin
  if (Source <> nil) then
  begin
    FFixedSteps := Source.FFixedSteps;
    FZoomIn := Source.FZoomIn;
    FZoomOut := Source.FZoomOut;
  end;
end;

constructor TgtVisibleZoomControls.Create;
begin
  FFixedSteps := True;
  FZoomIn := True;
  FZoomOut := True;
end;

destructor TgtVisibleZoomControls.Destroy;
begin

  inherited;
end;

function TgtVisibleZoomControls.ToJson: String;
begin
  Result := '"visibleZoomControls":{';
  Result := Result + '"fixedSteps":' + BooleanToString[FFixedSteps];
  Result := Result + ',"zoomIn":' + BooleanToString[FZoomIn];
  Result := Result + ',"zoomOut":' + BooleanToString[FZoomOut];
  Result := Result + '}';
end;

{ TgtVisibleRotationControls }

constructor TgtVisibleRotationControls.Create;
begin
  FClockwise := True;
  FCounterClockwise := True;
end;

destructor TgtVisibleRotationControls.Destroy;
begin

  inherited;
end;

function TgtVisibleRotationControls.ToJson: String;
begin
  Result := '"visibleRotationControls":{';
  Result := Result + '"clockwise":' + BooleanToString[FClockwise];
  Result := Result + ',"counterClockwise":' + BooleanToString
    [FCounterClockwise];
  Result := Result + '}';
end;

{ TgtVisibleColorInversionControls }

constructor TgtVisibleColorInversionControls.Create;
begin
  FAllPages := True;
end;

destructor TgtVisibleColorInversionControls.Destroy;
begin

  inherited;
end;

function TgtVisibleColorInversionControls.ToJson: String;
begin
  Result := '"visibleColorInversionControls":{';
  Result := Result + '"allPages":' + BooleanToString[FAllPages];
  Result := Result + '}';
end;

{ TgtSearchControls }

procedure TgtSearchControls.Assign(Source: TgtSearchControls);
begin
  if (Source <> nil) then
  begin
    FEnableQuickSearch := Source.FEnableQuickSearch;
    FHighlightColor.Assign(Source.FHighlightColor);
  end;
end;

constructor TgtSearchControls.Create;
begin
  FEnableQuickSearch := True;
  FHighlightColor := TgtColor.Create(255, 255, 0);
end;

destructor TgtSearchControls.Destroy;
begin
  FHighlightColor.Free;
  inherited;
end;

function TgtSearchControls.GetHighlightColor: TgtColor;
begin
  Result := FHighlightColor;
end;

procedure TgtSearchControls.SetHighlightColor(const AValue: TgtColor);
begin
  FHighlightColor.Assign(AValue);
end;

function TgtSearchControls.ToJson: String;
begin
  Result := '"searchControls":{';
  Result := Result + '"enableQuickSearch":' + BooleanToString
    [FEnableQuickSearch];
  Result := Result + ',"highlightColor":"' + FHighlightColor.EncodeString
    (False) + '"';
  Result := Result + '}';
end;

{ TgtViewerSettings }

constructor TgtViewerSettings.Create;
begin
  FEnableFormFilling := True;
  FToolbarVisible := True;
  FFullScreenVisible := True;
  FVisibleNavigationControls := TgtVisibleNavigationControls.Create;
  FVisibleZoomControls := TgtVisibleZoomControls.Create;
  FVisibleRotationControls := TgtVisibleRotationControls.Create;
  FVisibleColorInversionControls := TgtVisibleColorInversionControls.Create;
  FSearchControls := TgtSearchControls.Create;
end;

destructor TgtViewerSettings.Destroy;
begin
  FVisibleNavigationControls.Free;
  FVisibleZoomControls.Free;
  FVisibleRotationControls.Free;
  FVisibleColorInversionControls.Free;
  FSearchControls.Free;
  inherited;
end;

function TgtViewerSettings.GetSearchControls: TgtSearchControls;
begin
  Result := FSearchControls;
end;

function TgtViewerSettings.GetVisibleColorInversionControls
  : TgtVisibleColorInversionControls;
begin
  Result := FVisibleColorInversionControls;
end;

function TgtViewerSettings.GetVisibleNavigationControls
  : TgtVisibleNavigationControls;
begin
  Result := FVisibleNavigationControls;
end;

function TgtViewerSettings.GetVisibleRotationControls
  : TgtVisibleRotationControls;
begin
  Result := FVisibleRotationControls;
end;

function TgtViewerSettings.GetVisibleZoomControls: TgtVisibleZoomControls;
begin
  Result := FVisibleZoomControls;
end;

{
  procedure TgtViewerSettings.SetSearchControls(const AValue: TgtSearchControls);
  begin
  FSearchControls.Assign(AValue);
  end;

  procedure TgtViewerSettings.SetVisibleColorInversionControls
  (const AValue: TgtVisibleColorInversionControls);
  begin
  FVisibleColorInversionControls.AllPages := AValue.AllPages;
  end;

  procedure TgtViewerSettings.SetVisibleNavigationControls
  (const AValue: TgtVisibleNavigationControls);
  begin
  FVisibleNavigationControls.Assign(AValue);
  end;

  procedure TgtViewerSettings.SetVisibleRotationControls
  (const AValue: TgtVisibleRotationControls);
  begin
  FVisibleRotationControls.Clockwise := AValue.Clockwise;
  FVisibleRotationControls.CounterClockwise := AValue.CounterClockwise;
  end;

  procedure TgtViewerSettings.SetVisibleZoomControls(const AValue
  : TgtVisibleZoomControls);
  begin
  FVisibleZoomControls.Assign(AValue);
  end;
}
function TgtViewerSettings.ToJson: String;
begin
  Result := '"viewerSettings":{';
  Result := Result + '"enableFormFilling":' + BooleanToString
    [EnableFormFilling];
  Result := Result + ',"toolbarVisible":' + BooleanToString[ToolbarVisible];
  Result := Result + ',"fullScreenVisible":' + BooleanToString
    [FullScreenVisible];
  Result := Result + ',' + FVisibleNavigationControls.ToJson();
  Result := Result + ',' + FVisibleZoomControls.ToJson();
  Result := Result + ',' + FVisibleRotationControls.ToJson();
  Result := Result + ',' + FVisibleColorInversionControls.ToJson();
  Result := Result + ',' + FSearchControls.ToJson();
  Result := Result + '}';
end;

{ TgtViewer }

constructor TgtViewer.Create(AStarDocs: TgtStarDocsSDK);
begin
  FStarDocs := AStarDocs;
  FViewerSettings := TgtViewerSettings.Create;
end;

function TgtViewer.CreateView(AFile: TgtFileObject; APassword: string)
  : TgtViewResponse;
var
  LUrl: string;
  LJsonStr: string;
  LJsonResponseStr: string;
  LJsonResponse: TgtRestAPIResponseCreateView;
  LDocUris: TStringList;
  LPasswords: TStringList;
begin
  LDocUris := TStringList.Create;
  LPasswords := TStringList.Create;
  try
    LDocUris.Add(FStarDocs.GetDocUri(AFile));
    LPasswords.Add(APassword);
    LJsonStr := '{' + FStarDocs.EncodeJsonDocuments(LDocUris, LPasswords, nil);
    if (FViewerSettings <> nil) then
    begin
      LJsonStr := LJsonStr + (',' + FViewerSettings.ToJson());
    end;
    if FStarDocs.Preferences.DocPasswordSettings.ForceFullPermission then
      LJsonStr := LJsonStr + ',"forceFullPermission":true';
    LJsonStr := LJsonStr + '}';
    LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri + '/viewsessions';
    LJsonResponseStr := FStarDocs.IssuePostPutRequestAndPoll(LUrl, True,
      LJsonStr);
    LJsonResponse := TJSON.JsonToObject<TgtRestAPIResponseCreateView>
      (LJsonResponseStr);
    Result := TgtViewResponse.Create(LJsonResponse);
  finally
    LDocUris.Free;
    LPasswords.Free;
  end;
end;

procedure TgtViewer.DeleteView(AResponse: TgtViewResponse);
var
  LRestResp: THttpResponse;
  LRestRequest: TRestRequest;
  LUrl: String;
begin
  LRestRequest := TRestRequest.Create();
  LUrl := FStarDocs.FConnectionInfo.FApiServerUri.Uri + '/viewsessions';
  LRestRequest.Domain(LUrl);
  LRestResp := LRestRequest.Delete;
  if (LRestResp.ResponseCode <> 200) and (LRestResp.ResponseCode <> 204) then
  begin
    // Something went wrong
    raise EgtStarDocsException.Create(LRestResp.ResponseCode,
      LRestResp.ResponseStr);
  end;

end;

destructor TgtViewer.Destroy;
begin
  FViewerSettings.Free;
  inherited;
end;

function TgtViewer.GetViewerSettings: TgtViewerSettings;
begin
  Result := FViewerSettings;
end;

{ TgtRestAPIResponseCommon }

function TgtRestAPIResponseCommon.GetDocuments
  : TArray<TgtRestAPIDocumentCommon>;
begin
  Result := FDocuments;
end;

procedure TgtRestAPIResponseCommon.SetDocuments(const AValue
  : TArray<TgtRestAPIDocumentCommon>);
begin
  FDocuments := AValue;
end;

{ TgtRestAPIDocumentGetPropertiesPDF }

function TgtRestAPIDocumentGetPropertiesPDF.GetExtendedProperties
  : TgtRestAPIDocExPropertiesPDF;
begin
  Result := FExtendedProperties;
end;

function TgtRestAPIDocumentGetPropertiesPDF.GetProperties
  : TgtRestAPIDocPropertiesCommon;
begin
  Result := FProperties;
end;

procedure TgtRestAPIDocumentGetPropertiesPDF.SetExtendedProperties
  (const AValue: TgtRestAPIDocExPropertiesPDF);
begin
  FExtendedProperties.HasSecurity := AValue.HasSecurity;
  FExtendedProperties.HasBookmarks := AValue.HasBookmarks;
end;

procedure TgtRestAPIDocumentGetPropertiesPDF.SetProperties
  (const AValue: TgtRestAPIDocPropertiesCommon);
begin
  FProperties.Assign(AValue);
end;

{ TgtRestAPIDocPropertiesSecurity }

procedure TgtRestAPIDocPropertiesSecurity.Assign
  (Source: TgtRestAPIDocPropertiesSecurity);
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

function TgtRestAPIDocPropertiesSecurity.GetPermissions
  : TgtRestAPIDocPermissionsPDF;
begin
  Result := FPermissions;
end;

procedure TgtRestAPIDocPropertiesSecurity.SetPermissions
  (const AValue: TgtRestAPIDocPermissionsPDF);
begin
  FPermissions.Assign(AValue);
end;

{ TgtRestAPIDocumentGetPropertiesSecurityPDF }

function TgtRestAPIDocumentGetPropertiesSecurityPDF.
  GetExtendedPropertiesSecurity: TgtRestAPIDocPropertiesSecurity;
begin
  Result := FExtendedPropertiesSecurity;
end;

procedure TgtRestAPIDocumentGetPropertiesSecurityPDF.
  SetExtendedPropertiesSecurity(const AValue: TgtRestAPIDocPropertiesSecurity);
begin
  FExtendedPropertiesSecurity.Assign(AValue);
end;

{ TgtRestAPIDocPropertiesCommon }

procedure TgtRestAPIDocPropertiesCommon.Assign
  (Source: TgtRestAPIDocPropertiesCommon);
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

{ TgtRestAPIDocPermissionsPDF }

procedure TgtRestAPIDocPermissionsPDF.Assign
  (Source: TgtRestAPIDocPermissionsPDF);
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

{ TgtRestAPIResponseGetPropertiesPDF }

function TgtRestAPIResponseGetPropertiesPDF.GetDocuments
  : TArray<TgtRestAPIDocumentGetPropertiesPDF>;
begin
  Result := FDocuments;
end;

procedure TgtRestAPIResponseGetPropertiesPDF.SetDocuments
  (const AValue: TArray<TgtRestAPIDocumentGetPropertiesPDF>);
begin
  FDocuments := AValue;
end;

{ TgtRestAPIResponseGetPropertiesSecurityPDF }

function TgtRestAPIResponseGetPropertiesSecurityPDF.GetDocuments
  : TArray<TgtRestAPIDocumentGetPropertiesSecurityPDF>;
begin
  Result := FDocuments;
end;

procedure TgtRestAPIResponseGetPropertiesSecurityPDF.SetDocuments
  (const AValue: TArray<TgtRestAPIDocumentGetPropertiesSecurityPDF>);
begin
  FDocuments := AValue;
end;

{ TgtPDFFormFieldFillData }

constructor TgtPDFFormFieldFillData.Create(AFieldName: string; AFieldValue: string; AFlattenField: Boolean);
begin
  FFieldName := AFieldName;
  FFieldValue := AFieldValue;
  FFlattenField := AFlattenField;
end;

destructor TgtGetDocumentInfoResponse.Destroy;
begin

  inherited;
end;

end.
