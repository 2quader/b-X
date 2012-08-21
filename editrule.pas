unit EditRule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Spin, flRuleStore;

type

  { TfrmEditRule }

  TfrmEditRule = class(TForm)
    btnEdit: TButton;
    lblSeed: TLabel;
    nudSeed: TFloatSpinEdit;
    nudIncrement: TFloatSpinEdit;
    lblCIncrement: TLabel;
    txtKeyword: TEdit;
    lblC: TLabel;
    lblCB2: TLabel;
    lblCB1: TLabel;
    procedure editRule();
    procedure btnEditClick(Sender: TObject);
    procedure recvData(pRuleStore: TRuleStore; pRuleId: Integer);
    procedure txtKeywordKeyPress(Sender: TObject; var Key: char);
    procedure nudSeedKeyPress(Sender: TObject; var Key: char);
    procedure nudIncrementKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmEditRule: TfrmEditRule;
  ruleStore: TRuleStore;
  ruleId: Integer;

implementation

{$R *.lfm}

{ TfrmEditRule }

procedure TfrmEditRule.editRule();
begin
   if txtKeyword.Text <> '' then
    begin
      ruleStore.setKeyword(ruleId, txtKeyword.Text);
      ruleStore.setSeed(ruleId, nudSeed.Value);
      ruleStore.setIncrement(ruleId, nudIncrement.Value);
      self.close;
    end
   else
     Application.MessageBox('Keyword is empty!', 'b+X [Message]', 64);
end;

procedure TfrmEditRule.btnEditClick(Sender: TObject);
begin
  editRule();
end;

procedure TfrmEditRule.recvData(pRuleStore: TRuleStore; pRuleId: Integer);
begin
  ruleStore := pRuleStore;
  ruleId := pRuleId;
  txtKeyword.Text := ruleStore.getKeyword(ruleId);
  nudSeed.Value := ruleStore.getSeed(ruleId);
  nudIncrement.Value := ruleStore.getIncrement(ruleId);
end;

procedure TfrmEditRule.txtKeywordKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    nudSeed.SetFocus;
end;

procedure TfrmEditRule.nudSeedKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    nudIncrement.SetFocus;
end;

procedure TfrmEditRule.nudIncrementKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    editRule();
end;

end.

