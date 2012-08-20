unit Output;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmOut }

  TfrmOut = class(TForm)
    meOut: TMemo;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
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
  meOut.Width:=self.Width;
  meOut.Height:=self.Height;
end;

procedure TfrmOut.FormResize(Sender: TObject);
begin
  meOut.Width:=self.Width;
  meOut.Height:=self.Height;
end;

procedure TfrmOut.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction:=caNone;
end;

end.

