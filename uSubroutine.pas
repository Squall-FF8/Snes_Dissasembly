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
    lDataCol: TLabel;
    lLInes: TLabel;
    seBytes: TSpinEdit;
    seLines: TSpinEdit;
    Label7: TLabel;
    lpLines: TLabel;
    sePerRow: TSpinEdit;
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
  sePerRow.Visible := Kind = 2;
  lLines.Visible   := Kind = 1;
  lpLines.Visible  := Kind = 1;
  seLines.Visible  := Kind = 1;
  cbAcc16.Visible  := Kind = 1;
  cbInd16.Visible  := Kind = 1;
end;

end.
