unit uSubroutine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

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
    eLen: TEdit;
    cbAcc16: TCheckBox;
    cbInd16: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSubroutine: TfmSubroutine;

implementation
{$R *.dfm}

end.
