unit uParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmParam = class(TForm)
    Label1: TLabel;
    eAddress: TEdit;
    Label2: TLabel;
    eName: TEdit;
    bOK: TButton;
    bCancel: TButton;
    Label3: TLabel;
    Label4: TLabel;
    procedure eAddressKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParam: TfmParam;

implementation
{$R *.dfm}

procedure TfmParam.eAddressKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    Key := #0;
    ModalResult := mrOk;
  end;
  if Key = #27 then begin
    Key := #0;
    ModalResult := mrCancel;
  end;
end;

end.
