unit flRuleStore;

// This Class stores the rules.

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
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
  keyword: array of string;
  seed: array of real;
  increment: array of real;

implementation

constructor TRuleStore.Create();
begin
  SetLength(keyword, 0);
  SetLength(seed, 0);
  SetLength(increment, 0);
end;

// Returns keyword[I]
function TRuleStore.getKeyword(I: integer): string;
begin
  getKeyword := keyword[I];
end;

// Returns seed[I]
function TRuleStore.getSeed(I: integer): real;
begin
  getSeed := seed[I];
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
  // Todo.
end;

// Adds a rule
procedure TRuleStore.addRule(pKeyword: string; pSeed: real; pIncrement: real);
begin
  // Length(Arrays) += 1
  SetLength(keyword, Length(keyword) + 1);
  SetLength(seed, Length(seed) + 1);
  SetLength(increment, Length(increment) + 1);

  // Add rule at the end of the arrays
  keyword[Length(keyword) - 1] := pKeyword;
  seed[Length(seed) - 1] := pSeed;
  increment[Length(increment) - 1] := pIncrement;
end;

function TRuleStore.getLength() : Integer;
begin
  getLength := Length(keyword);
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

