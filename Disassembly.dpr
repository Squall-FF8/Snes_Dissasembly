program Disassembly;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {fmMain},
  uSubroutine in 'uSubroutine.pas' {fmSubroutine},
  uParam in 'uParam.pas' {fmParam};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmSubroutine, fmSubroutine);
  Application.CreateForm(TfmParam, fmParam);
  Application.Run;
end.
