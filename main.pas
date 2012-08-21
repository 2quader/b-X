unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, Menus, Output, AddRule, EditRule, flRuleStore;

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
    MainMenu: TMainMenu;
    meIn: TMemo;
    miSep2: TMenuItem;
    miSep1: TMenuItem;
    miExit: TMenuItem;
    miSave: TMenuItem;
    miSaveAs: TMenuItem;
    miOpen: TMenuItem;
    miNew: TMenuItem;
    miFile: TMenuItem;
    nudLoops: TSpinEdit;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure btnAddRuleClick(Sender: TObject);
    procedure btnDropRuleClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure cbDelimiterChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lbxRulesDblClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miNewClick(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miSaveClick(Sender: TObject);
    procedure save(path: String);
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
  filePath: String;
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
  meIn.Height := self.Height - meIn.Top - 32;
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

procedure TfrmMain.lbxRulesDblClick(Sender: TObject);
var
  frmEditRule: TfrmEditRule;
  over: Integer;
begin
  if lbxRules.ItemIndex > -1 then
  begin
    frmEditRule := TfrmEditRule.Create(self);
    frmEditRule.Top := Round((self.Top + (self.Height / 2)) - (frmEditRule.Height / 2));

    over := Round((frmEditRule.Width - self.Width)/2);
    if self.Left < over then
      frmEditRule.Left := self.Left
    else if (self.Left + self.Width + over) > Monitor.Width then
      frmEditRule.Left := Round((self.Left - over * 2))
    else
      frmEditRule.Left := Round((self.Left - over));

    frmEditRule.recvData(ruleStore, lbxRules.ItemIndex);
    frmEditRule.ShowModal;
    refillLbxRules();
  end;
end;

procedure TfrmMain.miExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfrmMain.miNewClick(Sender: TObject);
begin
  ruleStore.clear;
  refillLbxRules();
  meIn.Clear;
  frmOut.meOut.Clear;

  miSave.Enabled := False;
  miSave.ShortCut := 0;
  miSaveAs.ShortCut := 16467;

  self.Caption := 'b+X [Main Window]';
  filePath := '';
  nudLoops.Value := 10;
  cbDelimiter.ItemIndex := 0;
end;

procedure TfrmMain.miOpenClick(Sender: TObject);
var
  list: TStringList;
  splitList: TStringList;
  path: String;
  delimiter: String;
  rule: String;
  i: Integer;
  i2: Integer;
begin
  OpenDialog.Execute;
  path := OpenDialog.FileName;

  if path <> '' then
  begin
    filePath := path;
    list := TStringList.Create;
    list.LoadFromFile(path);
    nudLoops.Value := StrToInt(list[1]);
    delimiter := list[2];

    if (delimiter <> 'New line') and (delimiter <> 'Space') then
      cbDelimiter.ItemIndex := cbDelimiter.Items.Add(delimiter);

    i := 4;
    rule := list[4];
    splitList := TStringList.Create;
    while rule <> '[In]' do
    begin
      splitList.Delimiter := '|';
      splitList.DelimitedText := rule;
      ruleStore.addRule(splitList[1], StrToFloat(splitList[2]), StrToFloat(splitList[3]));
      i := i + 1;
      rule := list[i];
    end;
    for i2 := i + 1 to list.Count - 1 do
      meIn.Lines.Add(list[i2]);

    meIn.Text := TrimRight(meIn.Text);

    list.Free;
    splitList.Free;
    refillLbxRules();
    miSave.Enabled := True;
    miSave.ShortCut := 16467;
    miSaveAs.ShortCut := 0;
    self.Caption := 'b+X [Main Window] - ' + filePath;
  end;
end;

procedure TfrmMain.miSaveAsClick(Sender: TObject);
var
  path: String;
begin
  SaveDialog.Execute;
  path := SaveDialog.FileName;

  save(path);
end;

procedure TfrmMain.miSaveClick(Sender: TObject);
begin
   save(filePath);
end;


procedure TfrmMain.save(path: String);
var
  list: TStringList;
  i: Integer;
begin
  if path <> '""' then
    filePath := path;
    list := TStringList.Create;
    try
      list.Add('[Settings]');
      list.Add(IntToStr(nudLoops.Value));
      list.Add(cbDelimiter.Text);
      list.Add('[Rules]');
      for i := 0 to ruleStore.getLength() - 1 do
      begin
        list.Add(IntToStr(i) + '|' + ruleStore.getKeyword(i) +
                               '|' + FloatToStr(ruleStore.getSeed(i)) +
                               '|' + FloatToStr(ruleStore.getIncrement(i)));
      end;
      list.add('[In]');
      list.Add(meIn.Text);
      list.SaveToFile(filePath);
      self.Caption := 'b+X [Main Window] - ' + filePath;
      miSave.Enabled := True;
      miSave.ShortCut := 16467;
      miSaveAs.ShortCut := 0;
    finally
    end;
end;

procedure TfrmMain.btnAddRuleClick(Sender: TObject);
var
  frmAddRule: TfrmAddRule;
  over: Integer;
begin
  frmAddRule := TfrmAddRule.Create(self);
  frmAddRule.Top := Round((self.Top + (self.Height / 2)) - (frmAddRule.Height / 2));

  over := Round((frmAddRule.Width - self.Width)/2);
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

procedure TfrmMain.btnDropRuleClick(Sender: TObject);
begin
  ruleStore.deleteRule(lbxRules.ItemIndex);
  refillLbxRules();
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
var
  i: Integer;
  i2: Integer;
  tmpStr: String;
  delimiter: String;
begin
  frmOut.meOut.Lines.Clear;
  tmpStr := meIn.Text;

  for i := 1 to nudLoops.Value do
  begin
    tmpStr := meIn.Text;
    for i2 := 0 to ruleStore.getLength() - 1 do
    begin
      tmpStr := StringReplace(tmpStr, '{' + ruleStore.getKeyword(i2) + '}',
                  FloatToStr((i + ruleStore.getSeed(i2) - 1) * ruleStore.getIncrement(i2)),
                  [rfReplaceAll]);
    end;

    if cbDelimiter.ItemIndex = 0 then
      delimiter := sLineBreak
    else if cbDelimiter.ItemIndex = 1 then
      delimiter := ' '
    else if cbDelimiter.ItemIndex > 2 then
      delimiter := StringReplace(cbDelimiter.Text, '{newline}', sLineBreak, [rfReplaceAll]);

    frmOut.meOut.Text := frmOut.meOut.Text + tmpStr + delimiter;
  end;
  frmOut.meOut.Text := LeftStr(frmOut.meOut.Text, Length(frmOut.meOut.Text) - Length(delimiter));
end;

procedure TfrmMain.cbDelimiterChange(Sender: TObject);
var
  input: String;
begin
  if cbDelimiter.ItemIndex = 2 then
  begin
    input := InputBox('b+X [Custom Delimiter]', '{newline} creates a new line.', '');
    if input <> '' then
      cbDelimiter.ItemIndex := cbDelimiter.Items.Add(input)
    else
      cbDelimiter.ItemIndex := 0
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if filePath <> '' then
  begin
    if Application.MessageBox('Save changes?', 'b+X [Message]', 36) = 6 then
      save(filePath);
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

