unit uSubroutine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TfmSubroutine = class(TForm)
    Label1: TLabel;
    eSubName: TEdit;
    Label2: TLabel;
    eDescr: TEdit;
    bOK: TButton;
    bCancel: TButton;
    Label3: TLabel;
    eAddress: TEdit;
    Label4: TLabel;
    eOffset: TEdit;
    Label5: TLabel;
    cbAcc16: TCheckBox;
    cbInd16: TCheckBox;
    eDataCol: TEdit;
    lDataCol: TLabel;
    Label6: TLabel;
    seBytes: TSpinEdit;
    seLines: TSpinEdit;
  private
    { Private declarations }
  public
    procedure SetKind(Kind: byte);
  end;

var
  fmSubroutine: TfmSubroutine;

implementation
{$R *.dfm}


procedure TfmSubroutine.SetKind(Kind: byte);
begin
  if Kind = 1 then Caption := 'Subroutine Property'
              else Caption := 'Data-Block Property';
  lDataCol.Visible := Kind = 2;
  eDataCol.Visible := Kind = 2;
  cbAcc16.Visible  := Kind = 1;
  cbInd16.Visible  := Kind = 1;
end;

end.
