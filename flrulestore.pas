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
    function getCalc(I: integer): string;
    function getSeed(I: integer): real;
    function getIncrement(I: integer): real;
    procedure setKeyword(I: integer; NewValue: string);
    procedure setCalc(I: integer; NewValue: string);
    procedure setSeed(I: integer; NewValue: real);
    procedure setIncrement(I: integer; NewValue: real);
    procedure deleteRule(I: integer);
    procedure addRule(pKeyword: string; pCalc: string; pSeed: real; pIncrement: real);
  end;

var
  keyword: array of string;
  calc: array of string;
  seed: array of real;
  increment: array of real;

implementation

constructor TRuleStore.Create();
begin
  SetLength(keyword, 1);
  SetLength(calc, 1);
  SetLength(seed, 1);
  SetLength(increment, 1);
end;

// Returns keyword[I]
function TRuleStore.getKeyword(I: integer): string;
begin
  getKeyword := keyword[I];
end;

// Returns calc[I]
function TRuleStore.getCalc(I: integer): string;
begin
  getCalc := calc[I];
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

// Sets calc[I] to NewValue
procedure TRuleStore.setCalc(I: integer; NewValue: string);
begin
  calc[I] := NewValue;
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
// ERROR / TODO!
procedure TRuleStore.addRule(pKeyword: string; pCalc: string;
  pSeed: real; pIncrement: real);
begin
  // Length(Arrays) += 1
  SetLength(keyword, Length(keyword) + 1);
  SetLength(calc, Length(calc) + 1);
  SetLength(seed, Length(seed) + 1);
  SetLength(increment, Length(increment) + 1);

  // Add rule at the end of the arrays
  keyword[Length(keyword)] := pKeyword;
  calc[Length(calc)] := pCalc;
  seed[Length(seed)] := pSeed;
  increment[Length(increment)] := pIncrement;
end;

end.

