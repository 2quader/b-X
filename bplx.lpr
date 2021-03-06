program bplx;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Main, Output, AddRule, flRuleStore, EditRule;

{$R *.res}

begin
  Application.Title:='b+X';
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOut, frmOut);
  Application.CreateForm(TfrmAddRule, frmAddRule);
  Application.CreateForm(TfrmEditRule, frmEditRule);
  Application.Run;
end.

