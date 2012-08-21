unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, Output, AddRule, flRuleStore;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnAddRule: TButton;
    btnDropRule: TButton;
    btnStart: TButton;
    cbDelimiter: TComboBox;
    lblCDelimiter: TLabel;
    lblCLoops: TLabel;
    lblCInput: TLabel;
    lblCRules: TLabel;
    lbxRules: TListBox;
    meIn: TMemo;
    nudLoops: TSpinEdit;
    procedure btnAddRuleClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure cbDelimiterChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure refillLbxRules();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmMain: TfrmMain;
  frmOut: TfrmOut;
  ruleStore: TRuleStore;
implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmOut := TfrmOut.Create(self);
  frmOut.Left := frmMain.Left;
  frmOut.Top := frmMain.Top + frmMain.Height + 42;
  frmOut.Show;

  ruleStore := TRuleStore.Create;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  meIn.Height := self.Height - meIn.Top - 8;
  lbxRules.Width := self.Width - 16;
  meIn.Width := self.Width - 16;
  btnStart.Left := lbxRules.Left + lbxRules.Width - btnStart.Width;

  btnStart.Top := lbxRules.Top + lbxRules.Height;
  btnAddRule.Top := lbxRules.Top + lbxRules.Height;
  btnDropRule.Top := lbxRules.Top + lbxRules.Height;
  lblCLoops.Top := lbxRules.Top + lbxRules.Height + 4;
  nudLoops.Top := lbxRules.Top + lbxRules.Height + 2;
  lblCDelimiter.Top := lbxRules.Top + lbxRules.Height + 4;
  cbDelimiter.Top := lbxRules.Top + lbxRules.Height + 2;

  lblCInput.Top := lbxRules.Top + lbxRules.Height + 32;
  meIn.Top := lbxRules.Top + lbxRules.Height + 48;
end;

procedure TfrmMain.btnAddRuleClick(Sender: TObject);
var
  frmAddRule: TfrmAddRule;
  over: Integer;
begin
  frmAddRule := TfrmAddRule.Create(self);
  frmAddRule.Top := Round((self.Top + (self.Height / 2)) - (frmAddRule.Height / 2));

  over := Round((frmAddrule.Width - self.Width)/2);
  if self.Left < over then
    frmAddRule.Left := self.Left
  else if (self.Left + self.Width + over) > Monitor.Width then
    frmAddRule.Left := Round((self.Left - over * 2))
  else
    frmAddRule.Left := Round((self.Left - over));

  frmAddRule.recvRuleStore(ruleStore);
  frmAddRule.ShowModal;
  refillLbxRules();
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
var
  i: Integer;
  i2: Integer;
  tmpStr: String;
begin
  frmOut.meOut.Lines.Clear;
  tmpStr := meIn.Text;

  for i := 1 to nudLoops.Value do
  begin
    tmpStr := meIn.Text;
    for i2 := 0 to ruleStore.getLength() - 1 do
    begin
      tmpStr := StringReplace(tmpStr, '{' + ruleStore.getKeyword(i2) + '}',
                  FloatToStr((i - ruleStore.getSeed(i2) - 1) * ruleStore.getIncrement(i2)),
                  [rfReplaceAll]);
    end;

    if cbDelimiter.ItemIndex = 0 then
      frmOut.meOut.Lines.Add(tmpStr)
    else if cbDelimiter.ItemIndex = 1 then
      frmOut.meOut.Text := frmOut.meOut.Text + tmpStr + ' '
    else if cbDelimiter.ItemIndex > 2 then
      frmOut.meOut.Text := frmOut.meOut.Text + tmpStr + cbDelimiter.Text;
  end;
end;

procedure TfrmMain.cbDelimiterChange(Sender: TObject);
var
  input: String;
begin
  if cbDelimiter.ItemIndex = 2 then
  begin
    input := InputBox('b+X [Custom Delimiter]', '', '');
    if input <> '' then
      cbDelimiter.ItemIndex := cbDelimiter.Items.Add(input)
    else
      cbDelimiter.ItemIndex := 0
  end;
end;

procedure TfrmMain.refillLbxRules();
var
  i: Integer;
begin
  lbxRules.Items.Clear;
  for i := 0 to ruleStore.getLength() - 1 do
    lbxRules.Items.Add('{' + ruleStore.getKeyword(i) + '} | Seed: ' +
                       FloatToStr(ruleStore.getSeed(i)) + ' | Increment: ' +
                       FloatToStr(ruleStore.getIncrement(i)));
end;

end.

