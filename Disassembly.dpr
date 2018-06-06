program Disassembly;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {fmMain},
  uSubroutine in 'uSubroutine.pas' {fmSubroutine};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmSubroutine, fmSubroutine);
  Application.Run;
end.
