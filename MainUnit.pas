unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    bLoad: TButton;
    dOpen: TOpenDialog;
    Label1: TLabel;
    eOffset: TEdit;
    Label2: TLabel;
    eAddress: TEdit;
    bStart: TButton;
    Memo: TMemo;
    seLen: TSpinEdit;
    Label3: TLabel;
    procedure bLoadClick(Sender: TObject);
    procedure bStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.dfm}

type
  tCPU = record
    Name: string[3];
    Len:  byte;
    Addr: byte;
  end;

const
  CPU: array[$00..$FF] of tCPU = (
    (Name:'BRK';  Len:2;  Addr:0),
    (Name:'ORA';  Len:2;  Addr:6),
    (Name:'COP';  Len:2;  Addr:15),
    (Name:'ORA';  Len:2;  Addr:19),
    (Name:'TSB';  Len:2;  Addr:16),
    (Name:'ORA';  Len:2;  Addr:16),
    (Name:'ASL';  Len:2;  Addr:16),
    (Name:'ORA';  Len:2;  Addr:9),
    (Name:'PHP';  Len:1;  Addr:0),
    (Name:'ORA';  Len:2;  Addr:1),
    (Name:'ASL';  Len:1;  Addr:11),
    (Name:'PHD';  Len:1;  Addr:0),
    (Name:'TSB';  Len:3;  Addr:12),
    (Name:'ORA';  Len:3;  Addr:12),
    (Name:'ASL';  Len:3;  Addr:12),
    (Name:'ORA';  Len:4;  Addr:20),
    (Name:'BPL';  Len:2;  Addr:22),
    (Name:'ORA';  Len:2;  Addr:5),
    (Name:'ORA';  Len:2;  Addr:4),
    (Name:'ORA';  Len:2;  Addr:7),
    (Name:'TRB';  Len:2;  Addr:16),
    (Name:'ORA';  Len:2;  Addr:17),
    (Name:'ASL';  Len:2;  Addr:17),
    (Name:'ORA';  Len:2;  Addr:10),
    (Name:'CLC';  Len:1;  Addr:0),
    (Name:'ORA';  Len:3;  Addr:14),
    (Name:'INC';  Len:1;  Addr:11),
    (Name:'TCS';  Len:1;  Addr:0),
    (Name:'TRB';  Len:3;  Addr:12),
    (Name:'ORA';  Len:3;  Addr:13),
    (Name:'ASL';  Len:3;  Addr:13),
    (Name:'ORA';  Len:4;  Addr:21),
    (Name:'JSR';  Len:3;  Addr:12),
    (Name:'AND';  Len:2;  Addr:6),
    (Name:'JSR';  Len:4;  Addr:20),
    (Name:'AND';  Len:2;  Addr:19),
    (Name:'BIT';  Len:2;  Addr:16),
    (Name:'AND';  Len:2;  Addr:16),
    (Name:'ROL';  Len:2;  Addr:16),
    (Name:'AND';  Len:2;  Addr:9),
    (Name:'PLP';  Len:1;  Addr:0),
    (Name:'AND';  Len:2;  Addr:1),
    (Name:'ROL';  Len:1;  Addr:11),
    (Name:'PLD';  Len:1;  Addr:0),
    (Name:'BIT';  Len:3;  Addr:12),
    (Name:'AND';  Len:3;  Addr:12),
    (Name:'ROL';  Len:3;  Addr:12),
    (Name:'AND';  Len:4;  Addr:20),
    (Name:'BMI';  Len:2;  Addr:22),
    (Name:'AND';  Len:2;  Addr:5),
    (Name:'AND';  Len:2;  Addr:4),
    (Name:'AND';  Len:2;  Addr:7),
    (Name:'BIT';  Len:2;  Addr:17),
    (Name:'AND';  Len:2;  Addr:17),
    (Name:'ROL';  Len:2;  Addr:17),
    (Name:'AND';  Len:2;  Addr:10),
    (Name:'SEC';  Len:1;  Addr:0),
    (Name:'AND';  Len:3;  Addr:14),
    (Name:'DEC';  Len:1;  Addr:11),
    (Name:'TSC';  Len:1;  Addr:0),
    (Name:'BIT';  Len:3;  Addr:13),
    (Name:'AND';  Len:3;  Addr:13),
    (Name:'ROL';  Len:3;  Addr:13),
    (Name:'AND';  Len:4;  Addr:21),
    (Name:'RTI';  Len:1;  Addr:0),
    (Name:'EOR';  Len:2;  Addr:6),
    (Name:'WDM';  Len:2;  Addr:0),
    (Name:'EOR';  Len:2;  Addr:19),
    (Name:'MVN';  Len:3;  Addr:24),
    (Name:'EOR';  Len:2;  Addr:16),
    (Name:'LSR';  Len:2;  Addr:16),
    (Name:'EOR';  Len:2;  Addr:9),
    (Name:'PHA';  Len:1;  Addr:0),
    (Name:'EOR';  Len:2;  Addr:1),
    (Name:'LSR';  Len:1;  Addr:11),
    (Name:'PHK';  Len:1;  Addr:0),
    (Name:'JMP';  Len:3;  Addr:12),
    (Name:'EOR';  Len:3;  Addr:12),
    (Name:'LSR';  Len:3;  Addr:12),
    (Name:'EOR';  Len:4;  Addr:20),
    (Name:'BVC';  Len:2;  Addr:22),
    (Name:'EOR';  Len:2;  Addr:5),
    (Name:'EOR';  Len:2;  Addr:4),
    (Name:'EOR';  Len:2;  Addr:7),
    (Name:'MVN';  Len:3;  Addr:24),
    (Name:'EOR';  Len:2;  Addr:17),
    (Name:'LSR';  Len:2;  Addr:17),
    (Name:'EOR';  Len:2;  Addr:10),
    (Name:'CLI';  Len:1;  Addr:0),
    (Name:'EOR';  Len:3;  Addr:14),
    (Name:'PHY';  Len:1;  Addr:0),
    (Name:'TCD';  Len:1;  Addr:0),
    (Name:'JMP';  Len:4;  Addr:20),
    (Name:'EOR';  Len:3;  Addr:13),
    (Name:'LSR';  Len:3;  Addr:13),
    (Name:'EOR';  Len:4;  Addr:21),
    (Name:'RTS';  Len:1;  Addr:0),
    (Name:'ADC';  Len:2;  Addr:6),
    (Name:'PER';  Len:3;  Addr:23),
    (Name:'ADC';  Len:2;  Addr:19),
    (Name:'STZ';  Len:2;  Addr:16),
    (Name:'ADC';  Len:2;  Addr:16),
    (Name:'ROR';  Len:2;  Addr:16),
    (Name:'ADC';  Len:2;  Addr:9),
    (Name:'PLA';  Len:1;  Addr:0),
    (Name:'ADC';  Len:2;  Addr:1),
    (Name:'ROR';  Len:1;  Addr:11),
    (Name:'RTL';  Len:1;  Addr:0),
    (Name:'JMP';  Len:3;  Addr:2),
    (Name:'ADC';  Len:3;  Addr:12),
    (Name:'ROR';  Len:3;  Addr:12),
    (Name:'ADC';  Len:4;  Addr:20),
    (Name:'BVS';  Len:2;  Addr:22),
    (Name:'ADC';  Len:2;  Addr:5),
    (Name:'ADC';  Len:2;  Addr:4),
    (Name:'ADC';  Len:2;  Addr:7),
    (Name:'STZ';  Len:2;  Addr:17),
    (Name:'ADC';  Len:2;  Addr:17),
    (Name:'ROR';  Len:2;  Addr:17),
    (Name:'ADC';  Len:2;  Addr:10),
    (Name:'SEI';  Len:1;  Addr:0),
    (Name:'ADC';  Len:3;  Addr:14),
    (Name:'PLY';  Len:1;  Addr:0),
    (Name:'TDC';  Len:1;  Addr:0),
    (Name:'JMP';  Len:3;  Addr:3),
    (Name:'ADC';  Len:3;  Addr:13),
    (Name:'ROR';  Len:3;  Addr:13),
    (Name:'ADC';  Len:4;  Addr:21),
    (Name:'BRA';  Len:2;  Addr:22),
    (Name:'STA';  Len:2;  Addr:6),
    (Name:'BRL';  Len:3;  Addr:23),
    (Name:'STA';  Len:2;  Addr:19),
    (Name:'STY';  Len:2;  Addr:16),
    (Name:'STA';  Len:2;  Addr:16),
    (Name:'STX';  Len:2;  Addr:16),
    (Name:'STA';  Len:2;  Addr:9),
    (Name:'DEY';  Len:1;  Addr:0),
    (Name:'BIT';  Len:2;  Addr:1),
    (Name:'TXA';  Len:1;  Addr:0),
    (Name:'PHB';  Len:1;  Addr:0),
    (Name:'STY';  Len:3;  Addr:12),
    (Name:'STA';  Len:3;  Addr:12),
    (Name:'STX';  Len:3;  Addr:12),
    (Name:'STA';  Len:4;  Addr:20),
    (Name:'BCC';  Len:2;  Addr:22),
    (Name:'STA';  Len:2;  Addr:5),
    (Name:'STA';  Len:2;  Addr:4),
    (Name:'STA';  Len:2;  Addr:7),
    (Name:'STY';  Len:2;  Addr:17),
    (Name:'STA';  Len:2;  Addr:0),
    (Name:'STX';  Len:2;  Addr:18),
    (Name:'STA';  Len:2;  Addr:10),
    (Name:'TYA';  Len:1;  Addr:0),
    (Name:'STA';  Len:3;  Addr:14),
    (Name:'TXS';  Len:1;  Addr:0),
    (Name:'TXY';  Len:1;  Addr:0),
    (Name:'STZ';  Len:3;  Addr:12),
    (Name:'STA';  Len:3;  Addr:13),
    (Name:'STZ';  Len:3;  Addr:13),
    (Name:'STA';  Len:4;  Addr:21),
    (Name:'LDY';  Len:2;  Addr:1),
    (Name:'LDA';  Len:2;  Addr:6),
    (Name:'LDX';  Len:2;  Addr:1),
    (Name:'LDA';  Len:2;  Addr:19),
    (Name:'LDY';  Len:2;  Addr:16),
    (Name:'LDA';  Len:2;  Addr:16),
    (Name:'LDX';  Len:2;  Addr:16),
    (Name:'LDA';  Len:2;  Addr:9),
    (Name:'TAY';  Len:1;  Addr:0),
    (Name:'LDA';  Len:2;  Addr:1),
    (Name:'TAX';  Len:1;  Addr:0),
    (Name:'PLB';  Len:1;  Addr:0),
    (Name:'LDY';  Len:3;  Addr:12),
    (Name:'LDA';  Len:3;  Addr:12),
    (Name:'LDX';  Len:3;  Addr:12),
    (Name:'LDA';  Len:4;  Addr:20),
    (Name:'BCS';  Len:2;  Addr:22),
    (Name:'LDA';  Len:2;  Addr:5),
    (Name:'LDA';  Len:2;  Addr:4),
    (Name:'LDA';  Len:2;  Addr:7),
    (Name:'LDY';  Len:2;  Addr:17),
    (Name:'LDA';  Len:2;  Addr:17),
    (Name:'LDX';  Len:2;  Addr:18),
    (Name:'LDA';  Len:2;  Addr:10),
    (Name:'CLV';  Len:1;  Addr:0),
    (Name:'LDA';  Len:3;  Addr:14),
    (Name:'TSX';  Len:1;  Addr:0),
    (Name:'TYX';  Len:1;  Addr:0),
    (Name:'LDY';  Len:3;  Addr:13),
    (Name:'LDA';  Len:3;  Addr:13),
    (Name:'LDX';  Len:3;  Addr:14),
    (Name:'LDA';  Len:4;  Addr:21),
    (Name:'CPY';  Len:2;  Addr:1),
    (Name:'CMP';  Len:2;  Addr:6),
    (Name:'REP';  Len:2;  Addr:1),
    (Name:'CMP';  Len:2;  Addr:19),
    (Name:'CPY';  Len:2;  Addr:16),
    (Name:'CMP';  Len:2;  Addr:16),
    (Name:'DEC';  Len:2;  Addr:16),
    (Name:'CMP';  Len:2;  Addr:9),
    (Name:'INY';  Len:1;  Addr:0),
    (Name:'CMP';  Len:2;  Addr:1),
    (Name:'DEX';  Len:1;  Addr:0),
    (Name:'WAI';  Len:1;  Addr:0),
    (Name:'CPY';  Len:3;  Addr:12),
    (Name:'CMP';  Len:3;  Addr:12),
    (Name:'DEC';  Len:3;  Addr:12),
    (Name:'CMP';  Len:4;  Addr:20),
    (Name:'BNE';  Len:2;  Addr:22),
    (Name:'CMP';  Len:2;  Addr:5),
    (Name:'CMP';  Len:2;  Addr:4),
    (Name:'CMP';  Len:2;  Addr:7),
    (Name:'PEI';  Len:2;  Addr:4),
    (Name:'CMP';  Len:2;  Addr:17),
    (Name:'DEC';  Len:2;  Addr:17),
    (Name:'CMP';  Len:2;  Addr:10),
    (Name:'CLD';  Len:1;  Addr:0),
    (Name:'CMP';  Len:3;  Addr:14),
    (Name:'PHX';  Len:1;  Addr:0),
    (Name:'STP';  Len:1;  Addr:0),
    (Name:'JMP';  Len:3;  Addr:8),
    (Name:'CMP';  Len:3;  Addr:13),
    (Name:'DEC';  Len:3;  Addr:13),
    (Name:'CMP';  Len:4;  Addr:21),
    (Name:'CPX';  Len:2;  Addr:1),
    (Name:'SBC';  Len:2;  Addr:6),
    (Name:'SEP';  Len:2;  Addr:0),
    (Name:'SBC';  Len:2;  Addr:19),
    (Name:'CPX';  Len:2;  Addr:16),
    (Name:'SBC';  Len:2;  Addr:16),
    (Name:'INC';  Len:2;  Addr:16),
    (Name:'SBC';  Len:2;  Addr:9),
    (Name:'INX';  Len:1;  Addr:0),
    (Name:'SBC';  Len:2;  Addr:1),
    (Name:'NOP';  Len:1;  Addr:0),
    (Name:'XBA';  Len:1;  Addr:0),
    (Name:'CPX';  Len:3;  Addr:12),
    (Name:'SBC';  Len:3;  Addr:12),
    (Name:'INC';  Len:3;  Addr:12),
    (Name:'SBC';  Len:4;  Addr:20),
    (Name:'BEQ';  Len:2;  Addr:22),
    (Name:'SBC';  Len:2;  Addr:5),
    (Name:'SBC';  Len:2;  Addr:4),
    (Name:'SBC';  Len:2;  Addr:7),
    (Name:'PEA';  Len:3;  Addr:12),
    (Name:'SBC';  Len:2;  Addr:17),
    (Name:'INC';  Len:2;  Addr:17),
    (Name:'SBC';  Len:2;  Addr:10),
    (Name:'SED';  Len:1;  Addr:0),
    (Name:'SBC';  Len:3;  Addr:14),
    (Name:'PLX';  Len:1;  Addr:0),
    (Name:'XCE';  Len:1;  Addr:0),
    (Name:'JSR';  Len:3;  Addr:3),
    (Name:'SBC';  Len:3;  Addr:13),
    (Name:'INC';  Len:3;  Addr:13),
    (Name:'SBC';  Len:4;  Addr:21)
  );

cFmtAddr: array[1..23] of string = (
    ' #%s',      //#const
    ' (%s)',     //(addr)
    ' (%s,X)',   //(addr,X)
    ' (%s)',     //(dp)
    ' (%s),Y',   //(dp),Y
    ' (%s,X)',   //(dp,X)
    ' (%s,S),Y', //(sr,S),Y
    ' [%s]',     //[addr]
    ' [%s]',     //[dp]
    ' [%s],Y',   //[dp],Y
    ' A',        //A
    ' %s',       //addr
    ' %s,X',     //addr,X
    ' %s,Y',     //addr,Y
    '',          //const
    ' %s',       //dp
    ' %s,X',     //dp,X
    ' %s,Y',     //dp,Y
    ' %s,S',     //sr,S
    ' %s',       //long
    ' %s,X',     //long,X
    ' ???',      // nearlabel
    ' ???'       //label
                 //srcbk,destbk
  );


var
  ROM: array of byte;



procedure TForm1.bLoadClick(Sender: TObject);
  var f, n: cardinal;
begin
  if not dOpen.Execute then exit;

  f := CreateFile(pchar(dOpen.FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  //n := GetLastError;
  //ShowMessage(IntToStr(n));
  if f = INVALID_HANDLE_VALUE then raise Exception.Create(format('Problem opening %s', [dOpen.FileName]));
  n := GetFileSize(f, nil);
  SetLength(ROM, n);
  ReadFile(f, ROM[0], n, n, nil);
  CloseHandle(f);
end;


function ParseParam(Prm, Len: byte; Off, Addr: integer): string;
  function Param: string;
  begin
    Result := ' ';
    case Len of
      1: Result := format('$%.2x', [ ROM[Off] ]);
      2: Result := format('$%.4x', [ pWord(@ROM[Off])^ ]);
      3: Result := format('$%.6x', [ pCardinal(@ROM[Off])^ and $FFFFFF]);
    end;
  end;

  var c: shortint;
      b: smallint;
begin
  Result := ' ';
  if (Prm > 0) and (Prm < 22) then Result := format(cFmtAddr[Prm], [Param])
  else if Prm = 22 then begin
    c := ROM[Off];
    Result := format(' $%.4x', [Addr + c + 2]);
  end else if Prm = 23 then begin
    b := pSmallInt(@ROM[Off])^;
    Result := format(' $%.4x', [Addr + b +3]);
  end else if Prm = 24 then
    Result := format(' $%d,$%d', [ ROM[Off], ROM[Off+1] ]);
end;


procedure TForm1.bStartClick(Sender: TObject);
  var i, j: integer;
      o, a: integer;
      s: string;
      c, l, b,
      Acc16, Ind16: byte;  // 0 - 8 bit; 1 - 16 bit
begin
  Acc16 := 0;
  Ind16 := 0;

  o := StrToInt(eOffset.Text);
  a := StrToInt(eAddress.Text);
  Memo.Clear;

  for i := 1 to seLen.Value do begin
    c := ROM[o];
    l := CPU[c].Len;
    if c in [$69, $29, $89, $C9, $49, $A9, $09, $E9] then
      l := l + Acc16;
    if c in [$E0, $C0, $A2, $A0] then
      l := l + Ind16;
    s := format('%.6x:  ', [a]);

    for j := 0 to l-1 do
      s := s + format('%.2x ', [ROM[o + j]]);
    for j := l to 3 do
      s := s + '   ';
    s := s + CPU[c].Name;
    s := s + ParseParam(CPU[c].Addr, l-1, o+1, a);

    b := ROM[o+1];
    if c = $C2 then begin  // REP
      Acc16 := (b and $20) shr 5;
      Ind16 := (b and $10) shr 4;
    end else if c = $E2 then begin  // SEP
      b := b xor $30; //lets invert the 2 bits
      Acc16 := (b and $20) shr 5;
      Ind16 := (b and $10) shr 4;
    end;


    inc(o, l);
    inc(a, l);
    Memo.Lines.Add(s);
  end;
end;


end.
