unit AddRule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Spin;

type

  { TfrmAddRule }

  TfrmAddRule = class(TForm)
    btnAdd: TButton;
    cbType: TComboBox;
    lblSeed: TLabel;
    nudSeed: TFloatSpinEdit;
    nudIncrement: TFloatSpinEdit;
    lblCIncrement: TLabel;
    txtIn: TEdit;
    lblC: TLabel;
    lblCB2: TLabel;
    lblCB1: TLabel;
    procedure btnAddClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmAddRule: TfrmAddRule;

implementation

{$R *.lfm}

{ TfrmAddRule }

procedure TfrmAddRule.btnAddClick(Sender: TObject);
begin
  self.Close;
end;

end.

