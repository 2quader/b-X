unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Output, AddRule;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnAddRule: TButton;
    btnDropRule: TButton;
    lblCInput: TLabel;
    lblCRules: TLabel;
    ListBox1: TListBox;
    meIn: TMemo;
    procedure btnAddRuleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure refreshFrmOutPos();
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
  refreshFrmOutPos();
  frmOut.Show;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
  refreshFrmOutPos();
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  refreshFrmOutPos();
end;

procedure TfrmMain.btnAddRuleClick(Sender: TObject);
var
  frmAddRule: TfrmAddRule;
begin
  frmAddRule := TfrmAddRule.Create(self);
  frmAddRule.ShowModal;
end;

procedure TfrmMain.refreshFrmOutPos();
begin
  frmOut.Left:=frmMain.Left;
  frmOut.Top:=frmMain.Top + frmMain.Height + 24;
end;

end.

