{
  @abstract(Interfaces, base classes and support classes for GMLib.)
  @author(Xavier Martinez (cadetill) <cadetill@gmail.com>)
  @created(Septembre 30, 2015)
  @lastmod(Octobre 1, 2015)

  The GMClasses unit provides access to interfaces and base classes used into GMLib.
}
unit GMClasses;

{$I ..\gmlib.inc}

interface

uses
  {$IFDEF DELPHIXE2}
  System.SysUtils, System.Classes,
  {$ELSE}
  SysUtils, Classes,
  {$ENDIF}

  GMSets;

type
  { ************************************************************************** }
  { ***********************  Interfaces definition  ************************** }
  { ************************************************************************** }

  // @include(..\docs\GMClasses.IGMAPIUrl.txt)
  IGMAPIUrl = interface(IInterface)
    ['{BF91F436-B314-4128-ADA3-02147063A90C}']
    // @exclude
    function GetAPIUrl: string;
    // @include(..\docs\GMClasses.IGMAPIUrl.APIUrl.txt)
    property APIUrl: string read GetAPIUrl;
  end;

  // @include(..\docs\GMClasses.IGMToStr.txt)
  IGMToStr = interface(IInterface)
    ['{314C6DAD-B258-4D0C-A275-229491430B65}']
    // @include(..\docs\GMClasses.IGMToStr.PropToString.txt)
    function PropToString: string;
  end;

  // @include(..\docs\GMClasses.IGMControlChanges.txt)
  IGMControlChanges = interface(IInterface)
    ['{4731A754-4D4B-4AA2-978E-AF2838925A06}']
    // @include(..\docs\GMClasses.IGMControlChanges.PropertyChanged.txt)
    procedure PropertyChanged(Prop: TPersistent);
  end;

  // @include(..\docs\GMClasses.IGMOwnerLang.txt)
  IGMOwnerLang = interface(IInterface)
    ['{98DE1EC1-454C-494A-893A-2B57DC4C341F}']
    // @include(..\docs\GMClasses.IGMOwnerLang.GetOwnerLang.txt)
    function GetOwnerLang: TGMLang;
  end;

  // @include(..\docs\GMClasses.IGMExecJS.txt)
  IGMExecJS = interface(IInterface)
    ['{C1C87DC5-BDFD-4AA1-9BF7-C5FF01290339}']
    // @include(..\docs\GMClasses.IGMExecJS.ExecuteScript.txt)
    function ExecuteScript(NameFunct, Params: string): Boolean;
  end;

  { ************************************************************************** }
  { *************************  classes definition  *************************** }
  { ************************************************************************** }

  // @include(..\docs\GMClasses.EGMException.txt)
  EGMException = class(Exception)
  public
    // @include(..\docs\GMClasses.EGMException.Create_1.txt)
    constructor Create(const Msg: string; const Args: array of const; Lang: TGMLang); reintroduce; overload; virtual;
    // @include(..\docs\GMClasses.EGMException.Create_2.txt)
    constructor Create(const Idx: Integer; const Args: array of const; Lang: TGMLang); reintroduce; overload; virtual;
  end;

  // @include(..\docs\GMClasses.EGMNotValidRealNumber.txt)
  EGMNotValidRealNumber = class(EGMException);
  // @include(..\docs\GMClasses.EGMWithoutOwner.txt)
  EGMWithoutOwner = class(EGMException);
  // @include(..\docs\GMClasses.EGMOwnerWithoutJS.txt)
  EGMOwnerWithoutJS = class(EGMException);
  // @include(..\docs\GMClasses.EGMJSError.txt)
  EGMJSError = class(EGMException);
  // @include(..\docs\GMClasses.EGMUnassignedObject.txt)
  EGMUnassignedObject = class(EGMException);
  // @include(..\docs\GMClasses.EGMMapIsActive.txt)
  EGMMapIsActive = class(EGMException);

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMObject.txt)
  TGMObject = class(TInterfacedObject, IGMAPIUrl)
  protected
    // @exclude
    function GetAPIUrl: string; virtual;

    // @include(..\docs\GMClasses.TGMObject.APIUrl.txt)
    property APIUrl: string read GetAPIUrl;
  public
    // @include(..\docs\GMClasses.TGMObject.Assign.txt)
    procedure Assign(Source: TObject); virtual;
  end;

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMInterfacedOwnedPersistent.txt)
  TGMInterfacedOwnedPersistent = class(TInterfacedPersistent)
  private
    FOwner: TPersistent;
    FOnChange: TNotifyEvent;
  protected
    // @include(..\docs\GMClasses.TGMInterfacedOwnedPersistent.GetOwner.txt)
    function GetOwner: TPersistent; override;
    // @exclude
    procedure ControlChanges; virtual;

    // @include(..\docs\GMClasses.TGMInterfacedOwnedPersistent.OnChange.txt)
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    // @include(..\docs\GMClasses.TGMInterfacedOwnedPersistent.Create.txt)
    constructor Create(AOwner: TPersistent); virtual;
  end;

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMPersistent.txt)
  TGMPersistent = class(TGMInterfacedOwnedPersistent, IGMAPIUrl)
  protected
    // @exclude
    function GetAPIUrl: string; virtual;

    // @include(..\docs\GMClasses.TGMPersistent.APIUrl.txt)
    property APIUrl: string read GetAPIUrl;
  end;

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMPersistentStr.txt)
  TGMPersistentStr = class(TGMPersistent, IGMToStr, IGMOwnerLang)
  protected
    // @include(..\docs\GMClasses.TGMPersistentStr.PropToString.txt)
    function PropToString: string; virtual; abstract;

    // @include(..\docs\GMClasses.TGMPersistentStr.GetOwnerLang.txt)
    function GetOwnerLang: TGMLang; virtual;
  end;

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMComponent.txt)
  TGMComponent = class(TComponent, IGMAPIUrl)
  private
    FLanguage: TGMLang;
    FAboutGMLib: string;
  protected
    // @exclude
    function GetAPIUrl: string; virtual;

    // @include(..\docs\GMClasses.TGMComponent.APIUrl.txt)
    property APIUrl: string read GetAPIUrl;

    // @include(..\docs\GMClasses.TGMComponent.Language.txt)
    property Language: TGMLang read FLanguage write FLanguage default lnEnglish;
    // @include(..\docs\GMClasses.TGMComponent.AboutGMLib.txt)
    property AboutGMLib: string read FAboutGMLib stored False;
  public
    // @include(..\docs\GMClasses.TGMComponent.Create.txt)
    constructor Create(AOwner: TComponent); override;

    // @include(..\docs\GMClasses.TGMComponent.Assign.txt)
    procedure Assign(Source: TPersistent); override;
  end;

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.txt)
  TGMInterfacedCollectionItem = class(TCollectionItem, IGMToStr, IGMOwnerLang, IGMAPIUrl)
  private
    FOnChange: TNotifyEvent;
    FFObject: TObject;
    FTag: Integer;
    FName: string;
  protected
    // @exclude
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    // @exclude
    function _AddRef: Integer; virtual; stdcall;
    // @exclude
    function _Release: Integer; virtual; stdcall;
    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.GetDisplayName.txt)
    function GetDisplayName: string; override;

    // @exclude
    function GetAPIUrl: string; virtual;

    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.PropToString.txt)
    function PropToString: string; virtual; abstract;

    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.GetOwnerLang.txt)
    function GetOwnerLang: TGMLang; virtual;

    // @exclude
    procedure ControlChanges; virtual;

    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.OnChange.txt)
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.Assign.txt)
    procedure Assign(Source: TPersistent); override;

    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.APIUrl.txt)
    property APIUrl: string read GetAPIUrl;

    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.FObject.txt)
    property FObject: TObject read FFObject write FFObject;
  published
    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.Tag.txt)
    property Tag: Integer read FTag write FTag default 0;
    // @include(..\docs\GMClasses.TGMInterfacedCollectionItem.Name.txt)
    property Name: string read FName write FName;
  end;

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMInterfacedCollection.txt)
  TGMInterfacedCollection = class(TCollection, IGMControlChanges, IGMOwnerLang)
  private
    FOnChange: TNotifyEvent;
    FOwner: TPersistent;
  protected
    // @exclude
    function GetItems(I: Integer): TGMInterfacedCollectionItem;
    // @exclude
    procedure SetItems(I: Integer; const Value: TGMInterfacedCollectionItem);

    // @exclude
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    // @exclude
    function _AddRef: Integer; virtual; stdcall;
    // @exclude
    function _Release: Integer; virtual; stdcall;

    // @include(..\docs\GMClasses.TGMInterfacedCollection.GetOwnerLang.txt)
    function GetOwnerLang: TGMLang; virtual;

    // @include(..\docs\GMClasses.TGMInterfacedCollection.GetOwner.txt)
    function GetOwner: TPersistent; override;

    // @exclude
    procedure ControlChanges; virtual;

    // @include(..\docs\GMClasses.TGMInterfacedCollection.PropertyChanged.txt)
    procedure PropertyChanged(Prop: TPersistent);

    // @include(..\docs\GMClasses.TGMInterfacedCollection.Delete.txt)
    procedure Delete(Index: Integer);
    // @include(..\docs\GMClasses.TGMInterfacedCollection.Move.txt)
    procedure Move(CurIndex, NewIndex: Integer);
    // @include(..\docs\GMClasses.TGMInterfacedCollection.Clear.txt)
    procedure Clear;

    // @include(..\docs\GMClasses.TGMInterfacedCollection.OnChange.txt)
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    // @include(..\docs\GMClasses.TGMInterfacedCollection.Items.txt)
    property Items[I: Integer]: TGMInterfacedCollectionItem read GetItems write SetItems; default;
  public
    // @include(..\docs\GMClasses.TGMInterfacedCollection.Create.txt)
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass); virtual;

    // @include(..\docs\GMClasses.TGMInterfacedCollection.Assign.txt)
    procedure Assign(Source: TPersistent); override;
  end;

  { -------------------------------------------------------------------------- }
  // @include(..\docs\GMClasses.TGMTransform.txt)
  TGMTransform = record
  public
    // @include(..\docs\GMClasses.TGMTransform.GMBoolToStr.txt)
    class function GMBoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string; static;

    // @include(..\docs\GMClasses.TGMTransform.MapTypeIdsToStr.txt)
    class function MapTypeIdsToStr(MapTypeIds: TGMMapTypeIds; Delimiter: Char = ';'): string; static;

    // @include(..\docs\GMClasses.TGMTransform.VisibilityToStr.txt)
    class function VisibilityToStr(Visibility: TGMVisibility): string; static;
    // @include(..\docs\GMClasses.TGMTransform.StrToVisibility.txt)
    class function StrToVisibility(Visibility: string): TGMVisibility; static;
    // @include(..\docs\GMClasses.TGMTransform.PositionToStr.txt)
    class function PositionToStr(Position: TGMControlPosition): string; static;
    // @include(..\docs\GMClasses.TGMTransform.MapTypeControlStyleToStr.txt)
    class function MapTypeControlStyleToStr(MapTypeControlStyle: TGMMapTypeControlStyle): string; static;
    // @include(..\docs\GMClasses.TGMTransform.ScaleControlStyleToStr.txt)
    class function ScaleControlStyleToStr(ScaleControlStyle: TGMScaleControlStyle): string; static;
    // @include(..\docs\GMClasses.TGMTransform.ZoomControlStyleToStr.txt)
    class function ZoomControlStyleToStr(ZoomControlStyle: TGMZoomControlStyle): string; static;
    // @include(..\docs\GMClasses.TGMTransform.MapTypeStyleElementTypeToStr.txt)
    class function MapTypeStyleElementTypeToStr(MapTypeStyleElementType: TGMMapTypeStyleElementType): string; static;
    // @include(..\docs\GMClasses.TGMTransform.MapTypeStyleFeatureTypeToStr.txt)
    class function MapTypeStyleFeatureTypeToStr(MapTypeStyleFeatureType: TGMMapTypeStyleFeatureType): string; static;
    // @include(..\docs\GMClasses.TGMTransform.MapTypeIdToStr.txt)
    class function MapTypeIdToStr(MapTypeId: TGMMapTypeId): string; static;
  end;

implementation

uses
  {$IFDEF DELPHIXE2}
  System.TypInfo,
  {$ELSE}
  TypInfo,
  {$ENDIF}

  GMTranslations;

{ TGMObject }

procedure TGMObject.Assign(Source: TObject);
begin
  //
end;

function TGMObject.GetAPIUrl: string;
begin
  Result := 'https://developers.google.com/maps/documentation/javascript/reference';
end;

{ EGMException }

constructor EGMException.Create(const Msg: string; const Args: array of const;
  Lang: TGMLang);
begin
  inherited Create(GetTranslateText(Msg, Args, Lang));
end;

constructor EGMException.Create(const Idx: Integer; const Args: array of const;
  Lang: TGMLang);
begin
  inherited Create(GetTranslateText(Idx, Args, Lang));
end;

{ TGMComponent }

procedure TGMComponent.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TGMComponent then
  begin
    Language := TGMComponent(Source).Language;
  end;
end;

constructor TGMComponent.Create(AOwner: TComponent);
begin
  inherited;

  FLanguage := lnEnglish;
end;

function TGMComponent.GetAPIUrl: string;
begin
  Result := 'https://developers.google.com/maps/documentation/javascript/reference';
end;

{ TGMInterfacedOwnedPersistent }

procedure TGMInterfacedOwnedPersistent.ControlChanges;
var
  Intf: IGMControlChanges;
begin
  if (FOwner <> nil) and Supports(FOwner, IGMControlChanges, Intf) then
    Intf.PropertyChanged(Self)
  else
    if Assigned(FOnChange) then FOnChange(Self);
end;

constructor TGMInterfacedOwnedPersistent.Create(AOwner: TPersistent);
begin
  FOwner := AOwner;
end;

function TGMInterfacedOwnedPersistent.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TGMPersistent }

function TGMPersistent.GetAPIUrl: string;
begin
  Result := 'https://developers.google.com/maps/documentation/javascript/reference';
end;

{ TGMTransform }

class function TGMTransform.GMBoolToStr(B, UseBoolStrs: Boolean): string;
const
  cSimpleBoolStrs: array [boolean] of string = ('0', '-1');
begin
  if UseBoolStrs then
  begin
    if B then Result := 'true'
    else Result := 'false';
  end
  else
    Result := cSimpleBoolStrs[B];
end;

class function TGMTransform.MapTypeControlStyleToStr(
  MapTypeControlStyle: TGMMapTypeControlStyle): string;
begin
  Result := GetEnumName(TypeInfo(TGMMapTypeControlStyle), Ord(MapTypeControlStyle));
end;

class function TGMTransform.MapTypeIdsToStr(MapTypeIds: TGMMapTypeIds;
  Delimiter: Char): string;
begin
  Result := '';

  if mtHYBRID in MapTypeIds then
    Result := Result + 'mtHYBRID';

  if mtROADMAP in MapTypeIds then
  begin
    if Result <> '' then Result := Result + Delimiter;
    Result := Result + 'mtROADMAP';
  end;

  if mtSATELLITE in MapTypeIds then
  begin
    if Result <> '' then Result := Result + Delimiter;
    Result := Result + 'mtSATELLITE';
  end;

  if mtTERRAIN in MapTypeIds then
  begin
    if Result <> '' then Result := Result + Delimiter;
    Result := Result + 'mtTERRAIN';
  end;

  if mtOSM in MapTypeIds then
  begin
    if Result <> '' then Result := Result + Delimiter;
    Result := Result + 'mtOSM';
  end;
end;

class function TGMTransform.MapTypeIdToStr(MapTypeId: TGMMapTypeId): string;
begin
  Result := GetEnumName(TypeInfo(TGMMapTypeId), Ord(MapTypeId));
end;

class function TGMTransform.MapTypeStyleElementTypeToStr(
  MapTypeStyleElementType: TGMMapTypeStyleElementType): string;
begin
  Result := GetEnumName(TypeInfo(TGMMapTypeStyleElementType), Ord(MapTypeStyleElementType));
end;

class function TGMTransform.MapTypeStyleFeatureTypeToStr(
  MapTypeStyleFeatureType: TGMMapTypeStyleFeatureType): string;
begin
  Result := GetEnumName(TypeInfo(TGMMapTypeStyleFeatureType), Ord(MapTypeStyleFeatureType));
end;

class function TGMTransform.PositionToStr(Position: TGMControlPosition): string;
begin
  Result := GetEnumName(TypeInfo(TGMControlPosition), Ord(Position));
end;

class function TGMTransform.ScaleControlStyleToStr(
  ScaleControlStyle: TGMScaleControlStyle): string;
begin
  Result := GetEnumName(TypeInfo(TGMScaleControlStyle), Ord(ScaleControlStyle));
end;

class function TGMTransform.StrToVisibility(Visibility: string): TGMVisibility;
begin
  Result := TGMVisibility(GetEnumValue(TypeInfo(TGMVisibility), Visibility));
end;

class function TGMTransform.VisibilityToStr(Visibility: TGMVisibility): string;
begin
  Result := GetEnumName(TypeInfo(TGMVisibility), Ord(Visibility));
end;

class function TGMTransform.ZoomControlStyleToStr(
  ZoomControlStyle: TGMZoomControlStyle): string;
begin
  Result := GetEnumName(TypeInfo(TGMZoomControlStyle), Ord(ZoomControlStyle));
end;

{ TGMPersistentStr }

function TGMPersistentStr.GetOwnerLang: TGMLang;
var
  Intf: IGMOwnerLang;
begin
  Result := lnEnglish;

  if not Assigned(GetOwner()) then Exit;
  if not Supports(GetOwner(), IGMOwnerLang, Intf) then Exit;

  Result := Intf.GetOwnerLang;
end;

{ TGMInterfacedCollectionItem }

procedure TGMInterfacedCollectionItem.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TGMInterfacedCollectionItem then
  begin
    Name := TGMInterfacedCollectionItem(Source).Name;
    Tag := TGMInterfacedCollectionItem(Source).Tag;
    FObject := TGMInterfacedCollectionItem(Source).FObject;
  end;
end;

procedure TGMInterfacedCollectionItem.ControlChanges;
var
  Intf: IGMControlChanges;
begin
  if (GetOwner <> nil) and Supports(GetOwner, IGMControlChanges, Intf) then
    Intf.PropertyChanged(Self)
  else
    if Assigned(FOnChange) then FOnChange(Self);
end;

function TGMInterfacedCollectionItem.GetAPIUrl: string;
begin
  Result := 'https://developers.google.com/maps/documentation/javascript/reference';
end;

function TGMInterfacedCollectionItem.GetDisplayName: string;
begin
  if Length(FName) > 0 then
  begin
    if Length(FName) > 15 then
      Result := Copy(FName, 0, 15) + '...'
    else
      Result := FName;
  end
  else
  begin
    Result := inherited GetDisplayName;
    FName := Result;
  end;
end;

function TGMInterfacedCollectionItem.GetOwnerLang: TGMLang;
var
  Intf: IGMOwnerLang;
begin
  Result := lnEnglish;

  if not Assigned(Collection) then Exit;
  if not Supports(Collection, IGMOwnerLang, Intf) then Exit;

  Result := Intf.GetOwnerLang;
end;

function TGMInterfacedCollectionItem.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
end;

function TGMInterfacedCollectionItem._AddRef: Integer;
begin
  Result := -1;
end;

function TGMInterfacedCollectionItem._Release: Integer;
begin
  Result := -1;
end;

{ TGMInterfacedCollection }

procedure TGMInterfacedCollection.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TGMInterfacedCollection then
    FOwner := TGMInterfacedCollection(Source).FOwner;
end;

procedure TGMInterfacedCollection.Clear;
begin
  inherited Clear;

  ControlChanges;
end;

procedure TGMInterfacedCollection.ControlChanges;
var
  Intf: IGMControlChanges;
begin
  if (GetOwner <> nil) and Supports(GetOwner, IGMControlChanges, Intf) then
    Intf.PropertyChanged(Self)
  else
    if Assigned(FOnChange) then FOnChange(Self);
end;

constructor TGMInterfacedCollection.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);

  FOwner := AOwner;
end;

procedure TGMInterfacedCollection.Delete(Index: Integer);
begin
  inherited Delete(Index);

  ControlChanges;
end;

function TGMInterfacedCollection.GetItems(
  I: Integer): TGMInterfacedCollectionItem;
begin
  Result := TGMInterfacedCollectionItem(inherited Items[I]);
end;

function TGMInterfacedCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TGMInterfacedCollection.GetOwnerLang: TGMLang;
var
  Intf: IGMOwnerLang;
begin
  Result := lnEnglish;

  if not Assigned(FOwner) then Exit;
  if not Supports(FOwner, IGMOwnerLang, Intf) then Exit;

  Result := Intf.GetOwnerLang;
end;

procedure TGMInterfacedCollection.Move(CurIndex, NewIndex: Integer);
begin
  Items[CurIndex].Index := NewIndex;

  ControlChanges;
end;

procedure TGMInterfacedCollection.PropertyChanged(Prop: TPersistent);
begin
  ControlChanges;
end;

function TGMInterfacedCollection.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
end;

procedure TGMInterfacedCollection.SetItems(I: Integer;
  const Value: TGMInterfacedCollectionItem);
begin
  inherited SetItem(I, Value);
end;

function TGMInterfacedCollection._AddRef: Integer;
begin
  Result := -1;
end;

function TGMInterfacedCollection._Release: Integer;
begin
  Result := -1;
end;

end.