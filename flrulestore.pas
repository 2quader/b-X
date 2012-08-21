unit flRuleStore;

// This Class stores the rules.

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl;

type
  //TStringList = specialize TList<string>;
  //TRealList = specialize TList<real>;
  TStrList = specialize TFPGList<String>;
  TRealList = specialize TFPGList<Real>;
  TRuleStore = class(TObject)
    constructor Create();
    function getKeyword(I: integer): string;
    function getSeed(I: integer): real;
    function getIncrement(I: integer): real;
    procedure setKeyword(I: integer; NewValue: string);
    procedure setSeed(I: integer; NewValue: real);
    procedure setIncrement(I: integer; NewValue: real);
    procedure deleteRule(I: integer);
    procedure addRule(pKeyword: string; pSeed: real; pIncrement: real);
    function getLength() : Integer;
    function checkKeyword(pKeyword: String) : Boolean;
  end;

var
  keyword: TStrList;
  seed: TRealList;
  increment: TRealList;

implementation

constructor TRuleStore.Create();
begin
  keyword := TStrList.Create;
  seed := TRealList.Create;
  increment := TRealList.Create;
end;

// Returns keyword[I]
function TRuleStore.getKeyword(I: integer): string;
begin
  getKeyword := keyword[I];
end;

// Returns seed[I]
function TRuleStore.getSeed(I: integer): real;
begin
  getSeed := seed[I]
end;

// Returns increment[I]
function TRuleStore.getIncrement(I: integer): real;
begin
  getIncrement := increment[I];
end;

// Sets keyword[I] to NewValue
procedure TRuleStore.setKeyword(I: integer; NewValue: string);
begin
  keyword[I] := NewValue;
end;

// Sets seed[I] to NewValue
procedure TRuleStore.setSeed(I: integer; NewValue: real);
begin
  seed[I] := NewValue;
end;

// Sets increment[I] to NewValue
procedure TRuleStore.setIncrement(I: integer; NewValue: real);
begin
  increment[I] := NewValue;
end;

// Deletes a rule
procedure TRuleStore.deleteRule(I: integer);
begin
  keyword.Delete(I);
  seed.Delete(I);
  increment.Delete(I);
end;

// Adds a rule
procedure TRuleStore.addRule(pKeyword: string; pSeed: real; pIncrement: real);
begin
  keyword.Add(pKeyword);
  seed.Add(pSeed);
  increment.add(pIncrement);
end;

function TRuleStore.getLength() : Integer;
begin
  getLength := keyword.Count;
end;

function TRuleStore.checkKeyword(pKeyword: String) : Boolean;
var
  S: String;
begin
  for S in keyword do
    if S = pKeyword then
      checkKeyword := False
    else
      checkKeyword := True
end;

end.

