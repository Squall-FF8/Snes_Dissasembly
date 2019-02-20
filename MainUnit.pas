unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Menus;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    bLoadROM: TButton;
    dOpenROM: TOpenDialog;
    Label1: TLabel;
    eOffset: TEdit;
    Label2: TLabel;
    eAddress: TEdit;
    bParseCmd: TButton;
    Memo: TMemo;
    Label3: TLabel;
    cbAcc16: TCheckBox;
    cbInd16: TCheckBox;
    bParseByte: TButton;
    bParseCode: TButton;
    Panel2: TPanel;
    lbSub: TListBox;
    Panel3: TPanel;
    bAddSub: TButton;
    bLoad: TButton;
    bSave: TButton;
    dSave: TSaveDialog;
    dOpen: TOpenDialog;
    eLen: TEdit;
    Panel4: TPanel;
    lbCalls: TListBox;
    Splitter1: TSplitter;
    bAddData: TButton;
    popCalls: TPopupMenu;
    miCalls_Delete: TMenuItem;
    miCalls_Use: TMenuItem;
    mParams: TMemo;
    miCalls_SortAsc: TMenuItem;
    miCalls_SortDesc: TMenuItem;
    N1: TMenuItem;
    popSub: TPopupMenu;
    miSub_Del: TMenuItem;
    N2: TMenuItem;
    miSub_SortName: TMenuItem;
    SortbyAddress1: TMenuItem;
    procedure bLoadROMClick(Sender: TObject);
    procedure bParseCmdClick(Sender: TObject);
    procedure bAddSubClick(Sender: TObject);
    procedure lbSubDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure bSaveClick(Sender: TObject);
    procedure bLoadClick(Sender: TObject);
    procedure lbSubClick(Sender: TObject);
    procedure lbSubDblClick(Sender: TObject);
    procedure lbCallsDblClick(Sender: TObject);
    procedure miCalls_DeleteClick(Sender: TObject);
    procedure miCalls_UseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miCalls_SortAscClick(Sender: TObject);
    procedure miCalls_SortDescClick(Sender: TObject);
    procedure miSub_DelClick(Sender: TObject);
    procedure miSub_SortNameClick(Sender: TObject);
    procedure SortbyAddress1Click(Sender: TObject);
  private
    procedure Parse(Method: integer);
    procedure ParseData(Col: integer);
    procedure EmptyList;
    function AddrInList(Addr: integer): boolean;
    procedure EnableControls(State: boolean);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;


implementation
{$R *.dfm}

uses uSubroutine;


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
    (Name:'SEP';  Len:2;  Addr:1),
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

  // Parse method constants
  cMthCmd  = 1;
  cMthByte = 2;
  cMthCode = 3;

  cSubCodes: set of byte = [$20, $22, $FC];


type
  tSubroutine = record
    Kind:  byte;
    Addr,
    Off,
    Len:   integer;
    Acc16,
    Ind16: byte;
    Name:  string[20];
    Descr: string[255];
  end;
  pSubroutine = ^tSubroutine;

  tData = record
    Kind:  byte;
    Addr,
    Off,
    Len:   integer;
    RowBytes,
    RowsNum: byte;
    Name:  string[20];
    Descr: string[255];
  end;
  pData = ^tData;

  tAddress = record
    Addr,
    Off: integer;
    Acc16,
    Ind16: byte;
  end;
  pAddress = ^tAddress;

var
  ROM: array of byte;


procedure TfmMain.FormCreate(Sender: TObject);
begin
  EnableControls(false);
end;


procedure TfmMain.bLoadROMClick(Sender: TObject);
  var f, n: cardinal;
begin
  if not dOpenROM.Execute then exit;

  f := CreateFile(pchar(dOpenROM.FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  //n := GetLastError;
  //ShowMessage(IntToStr(n));
  if f = INVALID_HANDLE_VALUE then raise Exception.Create(format('Problem opening %s', [dOpen.FileName]));
  n := GetFileSize(f, nil);
  SetLength(ROM, n);
  ReadFile(f, ROM[0], n, n, nil);
  CloseHandle(f);

  Caption := dOpenROM.FileName;
  EnableControls(true);
end;


function ParseParam(Prm, Len: byte; Off, Addr: integer; List: tStrings): string;
  function Param: string;
    var s: string;
  begin
    Result := ' ';
    case Len of
      1: Result := format('$%.2x', [ ROM[Off] ]);
      2: Result := format('$%.4x', [ pWord(@ROM[Off])^ ]);
      3: Result := format('$%.6x', [ pCardinal(@ROM[Off])^ and $FFFFFF]);
    end;
    s := List.Values[Result];
    if s <> '' then
      Result := s;
  end;

  var c: shortint;
      b: smallint;
begin
  Result := '';
  case Prm of
    1..21: Result := format(cFmtAddr[Prm], [Param]);
    22: begin
      c := ROM[Off];
      Result := format(' $%.4x', [Addr + c + 2]);
     end;
    23: begin
      b := pSmallInt(@ROM[Off])^;
      Result := format(' $%.4x', [Addr + b +3]);
     end;
    24: Result := format(' $%.2x,$%.2x', [ ROM[Off], ROM[Off+1] ]);
  end;
end;

function GetParam(Addr: integer; Len: byte): integer;
  var i: integer;
begin
  Result := 0;
  for i := Len downto 1 do
    Result := Result shl 8 + ROM[Addr + i];
end;


procedure TfmMain.Parse(Method: integer);
  var i, j: integer;
      o, a, bank, off: integer;
      s: string;
      c, l, b,
      Acc16, Ind16: byte;  // 0 - 8 bit; 1 - 16 bit
      Num, NumCmd, NumByte: integer;
      v: pAddress;
      f: boolean;
begin
  Num := StrToInt(eLen.Text);
  NumCmd  := 0;
  NumByte := 0;
  c := 0;

  Acc16 := ord(cbAcc16.Checked);
  Ind16 := ord(cbInd16.Checked);

  o    := StrToInt(eOffset.Text);
  a    := StrToInt(eAddress.Text);
  off  := a-o;
  bank := a and $FF0000;
  Memo.Clear;

  while ( (Method = cMthCmd)  and (NumCmd < Num) ) or
        ( (Method = cMthByte) and (NumByte < Num) ) or
        ( (Method = cMthCode) and not (c in [$60, $6B, $40, $4C, $80]) ) do begin
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
    s := s + ParseParam(CPU[c].Addr, l-1, o+1, a and $FFFF, mParams.Lines);

    b := ROM[o+1];
    if c = $C2 then begin                 // REP
      if (b and $20) > 0 then Acc16 := 1;
      if (b and $10) > 0 then Ind16 := 1;
    end else if c = $E2 then begin        // SEP
      if (b and $20) > 0 then Acc16 := 0;
      if (b and $10) > 0 then Ind16 := 0;
    end;

    if c in cSubCodes then begin          // JSR
      j := GetParam(o, l-1);
      if l < 4 then inc(j, bank);
      f := not AddrInList(j);
      for i := 0 to lbCalls.Count -1 do
        if pAddress(lbCalls.Items.Objects[i]).Addr = j then
          f := false;
      if f then begin
        New(v);
        FillChar(v^, SizeOf(v^), 0);
        v.Addr  := j;
        v.Off   := off;
        v.Acc16 := Acc16;
        v.Ind16 := Ind16;
        lbCalls.AddItem(IntToHex(j, 6), tObject(v));
      end;
    end;


    inc(o, l);
    inc(a, l);
    inc(NumCmd);
    inc(NumByte, l);
    Memo.Lines.Add(s);
  end;

  if Method = cMthCode then eLen.Text := IntToStr(NumByte);
end;


procedure TfmMain.ParseData(Col: integer);
  var i, j: integer;
      o, a, Num: integer;
      s: string;
begin
  o   := StrToInt(eOffset.Text);
  a   := StrToInt(eAddress.Text);
  Num := StrToInt(eLen.Text);
  Memo.Clear;

  i := 0;
  while i < Num do begin
    s := format('%.6x:  ', [a+i]);
    for j := 1 to Col do begin
      if i >= Num then break;
      s := s + format('%.2x ', [ROM[o + i]]);
      inc(i);
    end;
    Memo.Lines.Add(s);
  end;
end;


procedure TfmMain.bParseCmdClick(Sender: TObject);
begin
  Parse(tButton(Sender).Tag);
end;


procedure TfmMain.bAddSubClick(Sender: TObject);
  var v: pSubroutine;
      Kind: byte;
begin
  Kind := tButton(Sender).Tag;
  fmSubroutine.SetKind(Kind);

  fmSubroutine.eAddress.Text   := eAddress.Text;
  fmSubroutine.eOffset.Text    := eOffset.Text;
  fmSubroutine.eLen.Text       := eLen.Text;
  fmSubroutine.cbAcc16.Checked := cbAcc16.Checked;
  fmSubroutine.cbInd16.Checked := cbInd16.Checked;
  fmSubroutine.eDataCol.Text   := '4';

  if fmSubroutine.ShowModal <> mrOK then exit;

  New(v);
  FillChar(v^, Sizeof(v^), 0);
  v.Kind  := Kind;
  v.Addr  := StrToInt(fmSubroutine.eAddress.Text);
  v.Off   := StrToInt(fmSubroutine.eOffset.Text);
  v.Len   := StrToInt(fmSubroutine.eLen.Text);
  v.Acc16 := ord(fmSubroutine.cbAcc16.Checked);
  v.Ind16 := ord(fmSubroutine.cbInd16.Checked);
  if Kind = 2 then v.Acc16 := StrToInt(fmSubroutine.eDataCol.Text);
  v.Name  := fmSubroutine.eSubName.Text;
  v.Descr := fmSubroutine.eDescr.Text;

  lbSub.AddItem(v.Name, tObject(v));
end;


procedure TfmMain.lbSubDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
  var v: pSubroutine;
      r: tRect;
begin
  v := Pointer(lbSub.Items.Objects[Index]);

  r := Rect;
  r.Bottom := r.Top +15;
  lbSub.Canvas.Font.Style := [fsBold];
  lbSub.Canvas.TextRect(r, r.Left+5, r.Top+2, v.Name);
  //lbSub.Canvas.TextOut(r.Left+1, r.Top+1, v.Name);

  r := Rect;
  inc(r.Top, 15);
  lbSub.Canvas.Font.Style := [];
  //lbSub.Canvas.TextOut(r.Left+1, r.Top+1, v.Descr);
  lbSub.Canvas.TextRect(r, r.Left+1, r.Top+1, v.Descr);

  r := Rect;
  r.Left := 170;
  r.Bottom := r.Top +15;
  lbSub.Canvas.TextRect(r, r.Left+1, r.Top+2, IntToHex(v.Addr, 6));
end;


procedure TfmMain.EmptyList;
  var i: integer;
begin
  for i := 0 to lbSub.Count - 1 do
    Dispose(pointer(lbSub.Items.Objects[i]));
  lbSub.Clear;
end;


procedure TfmMain.bSaveClick(Sender: TObject);
  var i: integer;
      f: file of tSubroutine;
begin
  if not dSave.Execute then exit;

  AssignFile(f, dSave.FileName);
  Rewrite(f);
  for i := 0 to lbSub.Count -1 do
    Write(f, pSubroutine(lbSub.Items.Objects[i])^);
  CloseFile(f);
end;


procedure TfmMain.bLoadClick(Sender: TObject);
  var i, n: integer;
      f: file of tSubroutine;
      v: pSubroutine;
begin
  if not dOpen.Execute then exit;

  AssignFile(f, dOpen.FileName);
  Reset(f);
  n := FileSize(f);  // return number of records, no size in bytes
  EmptyList;
  for i := 1 to n do begin
    New(v);
    Read(f, v^);
    lbSub.AddItem(v.Name, tObject(v));
  end;
  CloseFile(f);
end;


procedure TfmMain.lbSubClick(Sender: TObject);
  var v: pSubroutine;
begin
  if lbSub.ItemIndex < 0 then exit;
  v := pointer(lbSub.Items.Objects[lbSub.ItemIndex]);

  eOffset.Text    := format('$%.6x',[v.Off]);
  eAddress.Text   := format('$%.6x',[v.Addr]);
  eLen.Text       := IntToStr(v.Len);
  cbAcc16.Checked := v.Acc16 = 1;
  cbInd16.Checked := v.Ind16 = 1;
  if v.Kind = 1 then Parse(cMthByte)
                else ParseData(v.Acc16);
end;


procedure TfmMain.lbSubDblClick(Sender: TObject);
  var v: pSubroutine;
      Kind: byte;
begin
  if lbSub.ItemIndex < 0 then exit;
  v := pointer(lbSub.Items.Objects[lbSub.ItemIndex]);
  Kind := v.Kind;
  fmSubroutine.SetKind(Kind);

  fmSubroutine.eSubName.Text   := v.Name;
  fmSubroutine.eDescr.Text     := v.Descr;
  fmSubroutine.eAddress.Text   := format('$%.6x',[v.Addr]);
  fmSubroutine.eOffset.Text    := format('$%.6x',[v.Off]);
  fmSubroutine.eLen.Text       := IntToStr(v.Len);
  fmSubroutine.cbAcc16.Checked := v.Acc16 = 1;
  fmSubroutine.cbInd16.Checked := v.Ind16 = 1;
  fmSubroutine.eDataCol.Text   := IntToStr(v.Acc16);

  if fmSubroutine.ShowModal <> mrOK then exit;

  FillChar(v^, Sizeof(v^), 0);
  v.Kind  := Kind;
  v.Addr  := StrToInt(fmSubroutine.eAddress.Text);
  v.Off   := StrToInt(fmSubroutine.eOffset.Text);
  v.Len   := StrToInt(fmSubroutine.eLen.Text);
  v.Acc16 := ord(fmSubroutine.cbAcc16.Checked);
  v.Ind16 := ord(fmSubroutine.cbInd16.Checked);
  v.Name  := fmSubroutine.eSubName.Text;
  v.Descr := fmSubroutine.eDescr.Text;
  if Kind = 2 then v.Acc16 := StrToInt(fmSubroutine.eDataCol.Text);
end;


procedure TfmMain.EnableControls(State: boolean);
begin
  bParseCmd.Enabled := State;
  bParseByte.Enabled := State;
  bParseCode.Enabled := State;
  bAddSub.Enabled    := State;
  bAddData.Enabled   := State;
  lbSub.Enabled      := State;
end;


procedure TfmMain.miSub_DelClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbSub.ItemIndex;
  if ind < 0 then exit;
  Dispose(pointer(lbSub.Items.Objects[ind]));
  lbSub.Items.Delete(ind);
end;


procedure TfmMain.miSub_SortNameClick(Sender: TObject);
  var i, j, m: integer;
begin
  for i := 0 to lbSub.Count -2 do begin
    m := i;
    for j := i + 1 to lbSub.Count -1 do
      if pData(lbSub.Items.Objects[m]).Name > pData(lbSub.Items.Objects[j]).Name then
        m := j;
    if m <> i then
      lbSub.Items.Exchange(m, i);
  end;
end;


procedure TfmMain.SortbyAddress1Click(Sender: TObject);
  var i, j, m: integer;
begin
  for i := 0 to lbSub.Count -2 do begin
    m := i;
    for j := i + 1 to lbSub.Count -1 do
      if pData(lbSub.Items.Objects[m]).Addr > pData(lbSub.Items.Objects[j]).Addr then
        m := j;
    if m <> i then
      lbSub.Items.Exchange(m, i);
  end;
end;



// ==========================
// Address Handling
// ==========================
function TfmMain.AddrInList(Addr: integer): boolean;
  var i: integer;
begin
  Result := false;
  for i := 0 to lbSub.Count -1 do
    if pSubroutine(lbSub.Items.Objects[i])^.Addr = Addr then
      Result := true;
end;


procedure TfmMain.lbCallsDblClick(Sender: TObject);
  var ind: integer;
      v: pAddress;
begin
  ind := lbCalls.ItemIndex;
  if ind < 0 then exit;
  v := pAddress(lbCalls.Items.Objects[ind]);

  Memo.Clear;
  eAddress.Text   := format('$%.6x',[v.Addr]);
  eOffset.Text    := format('$%.6x',[v.Addr - v.Off]);
  cbAcc16.Checked := v.Acc16 = 1;
  cbInd16.Checked := v.Ind16 = 1;
end;


procedure TfmMain.miCalls_DeleteClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbCalls.ItemIndex;
  if ind < 0 then exit;
  Dispose(pointer(lbCalls.Items.Objects[ind]));
  lbCalls.Items.Delete(ind);
end;


procedure TfmMain.miCalls_UseClick(Sender: TObject);
begin
  lbCallsDblClick(nil);
end;


procedure TfmMain.miCalls_SortAscClick(Sender: TObject);
  var i, j, m: integer;
begin
  for i := 0 to lbCalls.Count -2 do begin
    m := i;
    for j := i + 1 to lbCalls.Count -1 do
      if pAddress(lbCalls.Items.Objects[m]).Addr > pAddress(lbCalls.Items.Objects[j]).Addr then
        m := j;
    if m <> i then
      lbCalls.Items.Exchange(m, i);
  end;
end;

procedure TfmMain.miCalls_SortDescClick(Sender: TObject);
  var i, j, m: integer;
begin
  for i := 0 to lbCalls.Count -2 do begin
    m := i;
    for j := i + 1 to lbCalls.Count -1 do
      if pAddress(lbCalls.Items.Objects[m]).Addr < pAddress(lbCalls.Items.Objects[j]).Addr then
        m := j;
    if m <> i then
      lbCalls.Items.Exchange(m, i);
  end;
end;

end.
