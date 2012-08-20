unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, Output, AddRule;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnAddRule: TButton;
    btnDropRule: TButton;
    lblCLoops: TLabel;
    lblCInput: TLabel;
    lblCRules: TLabel;
    ListBox1: TListBox;
    meIn: TMemo;
    nudLoops: TSpinEdit;
    procedure btnAddRuleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmMain: TfrmMain;
  frmOut: TfrmOut;
implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmOut:=TfrmOut.Create(self);
  frmOut.Left:=frmMain.Left;
  frmOut.Top:=frmMain.Top + frmMain.Height + 42;
  frmOut.Show;
end;

procedure TfrmMain.btnAddRuleClick(Sender: TObject);
var
  frmAddRule: TfrmAddRule;
  over: Integer;
begin
  frmAddRule:=TfrmAddRule.Create(self);
  frmAddRule.Top:=Round((self.Top + (self.Height / 2)) - (frmAddRule.Height / 2));

  over:=Round((frmAddrule.Width - self.Width)/2);
  if self.Left < over then
    frmAddRule.Left:=self.Left
  else if (self.Left + self.Width + over) > Monitor.Width then
    frmAddRule.Left:=Round((self.Left - over * 2))
  else
    frmAddRule.Left:=Round((self.Left - over));

  frmAddRule.ShowModal;
end;

end.

