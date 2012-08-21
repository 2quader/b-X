unit AddRule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Spin, flRuleStore;

type

  { TfrmAddRule }

  TfrmAddRule = class(TForm)
    btnAdd: TButton;
    lblSeed: TLabel;
    nudSeed: TFloatSpinEdit;
    nudIncrement: TFloatSpinEdit;
    lblCIncrement: TLabel;
    txtKeyword: TEdit;
    lblC: TLabel;
    lblCB2: TLabel;
    lblCB1: TLabel;
    procedure addRule();
    procedure btnAddClick(Sender: TObject);
    procedure recvRuleStore(pRuleStore: TRuleStore);
    procedure txtKeywordKeyPress(Sender: TObject; var Key: char);
    procedure nudSeedKeyPress(Sender: TObject; var Key: char);
    procedure nudIncrementKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmAddRule: TfrmAddRule;
  ruleStore: TRuleStore;

implementation

{$R *.lfm}

{ TfrmAddRule }

procedure TfrmAddRule.addRule();
begin
   if txtKeyword.Text <> '' then
     if ruleStore.checkKeyword(txtKeyword.Text) then
      begin
        ruleStore.addRule(txtKeyword.Text, nudSeed.Value, nudIncrement.Value);
        self.Close;
      end
     else
      begin
        Application.MessageBox('Check keyword!', 'b+X [Message]', 64);
        txtKeyword.SetFocus;
      end
  else
    Application.MessageBox('Keyword is empty!', 'b+X [Message]', 64);
end;

procedure TfrmAddRule.btnAddClick(Sender: TObject);
begin
  addRule();
end;

procedure TfrmAddRule.recvRuleStore(pRuleStore: TRuleStore);
begin
  ruleStore := pRuleStore;
end;

procedure TfrmAddRule.txtKeywordKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    nudSeed.SetFocus;
end;

procedure TfrmAddRule.nudSeedKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    nudIncrement.SetFocus;
end;

procedure TfrmAddRule.nudIncrementKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    addRule();
end;

end.

