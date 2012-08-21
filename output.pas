unit Output;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Clipbrd, ExtCtrls;

type

  { TfrmOut }

  TfrmOut = class(TForm)
    meOut: TMemo;
    pnlCopied: TPanel;
    tmrHidePnl: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure meOutDblClick(Sender: TObject);
    procedure tmrHidePnlTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmOut: TfrmOut;

implementation

{$R *.lfm}

{ TfrmOut }

procedure TfrmOut.FormCreate(Sender: TObject);
begin
  meOut.Width := self.Width;
  meOut.Height := self.Height;
end;

procedure TfrmOut.FormResize(Sender: TObject);
begin
  meOut.Width := self.Width;
  meOut.Height := self.Height;
end;

procedure TfrmOut.meOutDblClick(Sender: TObject);
begin
  Clipboard.AsText := meOut.Text;
  pnlCopied.Top := Round((self.Height / 2) - (pnlCopied.Height / 2));
  pnlCopied.Left := Round((self.Width / 2) - (pnlCopied.Width / 2));
  pnlCopied.Visible := True;
  tmrHidePnl.Enabled := True;
end;

procedure TfrmOut.tmrHidePnlTimer(Sender: TObject);
begin
  pnlCopied.Visible := False;
end;

procedure TfrmOut.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caNone;
end;

end.

