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
    cbType: TComboBox;
    lblSeed: TLabel;
    nudSeed: TFloatSpinEdit;
    nudIncrement: TFloatSpinEdit;
    lblCIncrement: TLabel;
    txtKeyword: TEdit;
    lblC: TLabel;
    lblCB2: TLabel;
    lblCB1: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure recvRuleStore(pRuleStore: TRuleStore);
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

procedure TfrmAddRule.btnAddClick(Sender: TObject);
begin
  ruleStore.addRule(txtKeyword.Text, cbType.Text, nudSeed.Value, nudIncrement.Value);
  self.Close;
end;

procedure TfrmAddRule.recvRuleStore(pRuleStore: TRuleStore);
begin
  ruleStore := pRuleStore;
end;

end.

