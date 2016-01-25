{
  @abstract(Exceptions and messages translations from GMLib.)
  @author(Xavier Martinez (cadetill) <cadetill@gmail.com>)
  @created(Septembre 30, 2015)
  @lastmod(Septembre 30, 2015)

  The GMTranslations contains all translations for the exceptions raised by GMLib.
}
unit GMTranslations;

{$I ..\gmlib.inc}

interface

uses
  GMSets;

const
  // @exclude
  MaxArray = 6;

  // Array with exception messages in Spanish language.
  // @exclude
  Lang_ES: array[0..MaxArray] of string = (
      '�ndice fuera de rango.',
      '%d no es un n�mero v�lido.',
      'Propietatio no asignado.',
      'El objeto (o su propietario) no suportan llamadas JavaScript.',
      'Error ejecutando la funci�n JavaScript %s.',
      'Objeto %s no asignado.',
      'El mapa est� activo. Desact�velo antes de cambiar esta propiedad.'
  );

  // Array with exception messages in English language.
  // @exclude
  Lang_EN: array[0..MaxArray] of string = (
      'Index out of range.',
      '%d is not a valid real value.',
      'Owner not assigned.',
      'The object (or its owner) does not support JavaScript calls.',
      'An error occurs executing %s JavaScript function.',
      'Object %s unassigned.',
      'The map is active. Please, deactivate it before change this property.'
  );

  // Array with exception messages in French language.
  // @exclude
  Lang_FR: array[0..MaxArray] of string = (
      'Indice hors limites.',
      '%d n''est pas un numero valide.',
      'Sans propri�taire.',
      'L''objet (ou son propri�taire) ne supporte pas appels JavaScript.',
      'Une erreur est survenue a l''ex�cution de la fonction javascript %s.',
      'Objet %s non initialis�.',
      'La carte est active. D�sactive cette propri�t� avant de la changer.'
  );

  {*----------------------------------------------------------------------------
    @abstract(@code(GetTranslateText) function retrieves a translated string into the Lang language.)
    Is used to generate exception messages.@br
    The language of @code(Text) param must be in English language.@br@br
    @bold(For internal use only!)
    @param Text String to translate
    @param Args Array of arguments to apply to the message
    @param Lang Destination language
    @return Translated string
  }
  function GetTranslateText(Text: string; const Args: array of const; Lang: TGMLang): string; overload;

  {*----------------------------------------------------------------------------
    @abstract(@code(GetTranslateText) fucntion retrieves a translated string into the Lang language.)
    Is used to generate exception messages.@br@br
    @bold(For internal use only!)
    @param Idx Index of array
    @param Args Array of arguments to apply to the message
    @param Lang Destination language
    @return Translated string
  }
  function GetTranslateText(Idx: Integer; const Args: array of const; Lang: TGMLang): string; overload;

implementation

uses
  {$IFDEF DELPHIXE2}
  System.SysUtils;
  {$ELSE}
  SysUtils;
  {$ENDIF}

function GetTranslateText(Text: string; const Args: array of const;
  Lang: TGMLang): string;
var
  Idx: Integer;
begin
  Result := '';

  Idx := 0;
  while Idx <= MaxArray do
    if SameText(Text, Lang_EN[Idx]) then
    begin
      Result := GetTranslateText(Idx, Args, Lang);
      Break;
    end;

  if Result = '' then
    Result := GetTranslateText(0, Args, Lang);
end;

function GetTranslateText(Idx: Integer; const Args: array of const;
  Lang: TGMLang): string;
begin
  if Idx > MaxArray then Idx := 0;

  case Lang of
    lnEspanol: Result := Lang_ES[Idx];
    lnFrench: Result := Lang_FR[Idx];
    else Result := Lang_EN[Idx];
  end;

  Result := Format(Result, Args);
end;

end.