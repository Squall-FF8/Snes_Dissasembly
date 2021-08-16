{+-----------------------------------------------------------------------------+
 | Class:       TSynSampleSyn
 | Created:     2021-06-25
 | Last change: 2021-06-25
 | Author:      aniki
 | Description: Syntax Parser/Highlighter
 | Version:     0.1
 |
 | Copyright (c) 2021 aniki. All rights reserved.
 |
 | Generated with SynGen.
 +----------------------------------------------------------------------------+}

{$IFNDEF QSYNHIGHLIGHTERSAMPLE}
unit SynHighlighterSample;
{$ENDIF}

{$I SynEdit.inc}

interface

uses
{$IFDEF SYN_CLX}
  QGraphics,
  QSynEditTypes,
  QSynEditHighlighter,
  QSynUnicode,
{$ELSE}
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
  SynUnicode,
{$ENDIF}
  SysUtils,
  Classes;

type
  TtkTokenKind = (
    tkComment,
    tkDirectives,
    tkIdentifier,
    tkNull,
    tkNumber,
    tkOpcodes,
    tkSpace,
    tkString,
    tkUnknown);

  TRangeState = (rsUnKnown, rsBraceComment, rsCStyleComment, rsAsmComment, rsString, rsString1);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function (Index: Integer): TtkTokenKind of object;

type
  TSynSampleSyn = class(TSynCustomHighlighter)
  private
    fRange: TRangeState;
    fTokenID: TtkTokenKind;
    fIdentFuncTable: array[0..358] of TIdentFuncTableFunc;
    fCommentAttri: TSynHighlighterAttributes;
    fDirectivesAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fOpcodesAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    function HashKey(Str: PWideChar): Cardinal;
    function FuncAdc(Index: Integer): TtkTokenKind;
    function FuncAnd(Index: Integer): TtkTokenKind;
    function FuncAsl(Index: Integer): TtkTokenKind;
    function FuncBcc(Index: Integer): TtkTokenKind;
    function FuncBcs(Index: Integer): TtkTokenKind;
    function FuncBeq(Index: Integer): TtkTokenKind;
    function FuncBit(Index: Integer): TtkTokenKind;
    function FuncBmi(Index: Integer): TtkTokenKind;
    function FuncBne(Index: Integer): TtkTokenKind;
    function FuncBpl(Index: Integer): TtkTokenKind;
    function FuncBra(Index: Integer): TtkTokenKind;
    function FuncBrk(Index: Integer): TtkTokenKind;
    function FuncBrl(Index: Integer): TtkTokenKind;
    function FuncBvc(Index: Integer): TtkTokenKind;
    function FuncBvs(Index: Integer): TtkTokenKind;
    function FuncByte(Index: Integer): TtkTokenKind;
    function FuncClc(Index: Integer): TtkTokenKind;
    function FuncCld(Index: Integer): TtkTokenKind;
    function FuncCli(Index: Integer): TtkTokenKind;
    function FuncClv(Index: Integer): TtkTokenKind;
    function FuncCmp(Index: Integer): TtkTokenKind;
    function FuncCop(Index: Integer): TtkTokenKind;
    function FuncCpx(Index: Integer): TtkTokenKind;
    function FuncCpy(Index: Integer): TtkTokenKind;
    function FuncDec(Index: Integer): TtkTokenKind;
    function FuncDex(Index: Integer): TtkTokenKind;
    function FuncDey(Index: Integer): TtkTokenKind;
    function FuncEor(Index: Integer): TtkTokenKind;
    function FuncInc(Index: Integer): TtkTokenKind;
    function FuncInclude(Index: Integer): TtkTokenKind;
    function FuncInx(Index: Integer): TtkTokenKind;
    function FuncIny(Index: Integer): TtkTokenKind;
    function FuncJml(Index: Integer): TtkTokenKind;
    function FuncJmp(Index: Integer): TtkTokenKind;
    function FuncJsl(Index: Integer): TtkTokenKind;
    function FuncJsr(Index: Integer): TtkTokenKind;
    function FuncLda(Index: Integer): TtkTokenKind;
    function FuncLdx(Index: Integer): TtkTokenKind;
    function FuncLdy(Index: Integer): TtkTokenKind;
    function FuncLsr(Index: Integer): TtkTokenKind;
    function FuncMvn(Index: Integer): TtkTokenKind;
    function FuncMvp(Index: Integer): TtkTokenKind;
    function FuncNop(Index: Integer): TtkTokenKind;
    function FuncOra(Index: Integer): TtkTokenKind;
    function FuncPea(Index: Integer): TtkTokenKind;
    function FuncPei(Index: Integer): TtkTokenKind;
    function FuncPer(Index: Integer): TtkTokenKind;
    function FuncPha(Index: Integer): TtkTokenKind;
    function FuncPhb(Index: Integer): TtkTokenKind;
    function FuncPhd(Index: Integer): TtkTokenKind;
    function FuncPhk(Index: Integer): TtkTokenKind;
    function FuncPhp(Index: Integer): TtkTokenKind;
    function FuncPhx(Index: Integer): TtkTokenKind;
    function FuncPhy(Index: Integer): TtkTokenKind;
    function FuncPla(Index: Integer): TtkTokenKind;
    function FuncPlb(Index: Integer): TtkTokenKind;
    function FuncPld(Index: Integer): TtkTokenKind;
    function FuncPlp(Index: Integer): TtkTokenKind;
    function FuncPlx(Index: Integer): TtkTokenKind;
    function FuncPly(Index: Integer): TtkTokenKind;
    function FuncRep(Index: Integer): TtkTokenKind;
    function FuncRol(Index: Integer): TtkTokenKind;
    function FuncRor(Index: Integer): TtkTokenKind;
    function FuncRti(Index: Integer): TtkTokenKind;
    function FuncRtl(Index: Integer): TtkTokenKind;
    function FuncRts(Index: Integer): TtkTokenKind;
    function FuncSbc(Index: Integer): TtkTokenKind;
    function FuncSec(Index: Integer): TtkTokenKind;
    function FuncSed(Index: Integer): TtkTokenKind;
    function FuncSegment(Index: Integer): TtkTokenKind;
    function FuncSei(Index: Integer): TtkTokenKind;
    function FuncSep(Index: Integer): TtkTokenKind;
    function FuncSetcpu(Index: Integer): TtkTokenKind;
    function FuncSta(Index: Integer): TtkTokenKind;
    function FuncStp(Index: Integer): TtkTokenKind;
    function FuncStx(Index: Integer): TtkTokenKind;
    function FuncSty(Index: Integer): TtkTokenKind;
    function FuncStz(Index: Integer): TtkTokenKind;
    function FuncTax(Index: Integer): TtkTokenKind;
    function FuncTay(Index: Integer): TtkTokenKind;
    function FuncTcd(Index: Integer): TtkTokenKind;
    function FuncTcs(Index: Integer): TtkTokenKind;
    function FuncTdc(Index: Integer): TtkTokenKind;
    function FuncTrb(Index: Integer): TtkTokenKind;
    function FuncTsb(Index: Integer): TtkTokenKind;
    function FuncTsc(Index: Integer): TtkTokenKind;
    function FuncTsx(Index: Integer): TtkTokenKind;
    function FuncTxa(Index: Integer): TtkTokenKind;
    function FuncTxs(Index: Integer): TtkTokenKind;
    function FuncTxy(Index: Integer): TtkTokenKind;
    function FuncTya(Index: Integer): TtkTokenKind;
    function FuncTyx(Index: Integer): TtkTokenKind;
    function FuncWai(Index: Integer): TtkTokenKind;
    function FuncWdm(Index: Integer): TtkTokenKind;
    function FuncXba(Index: Integer): TtkTokenKind;
    function FuncXce(Index: Integer): TtkTokenKind;
    procedure IdentProc;
    procedure NumberProc;
    procedure UnknownProc;
    function AltFunc(Index: Integer): TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PWideChar): TtkTokenKind;
    procedure NullProc;
    procedure SpaceProc;
    procedure CRProc;
    procedure LFProc;
    procedure BraceCommentOpenProc;
    procedure BraceCommentProc;
    procedure CStyleCommentOpenProc;
    procedure CStyleCommentProc;
    procedure AsmCommentOpenProc;
    procedure AsmCommentProc;
    procedure StringOpenProc;
    procedure StringProc;
    procedure String1OpenProc;
    procedure String1Proc;
  protected
    function GetSampleSource: UnicodeString; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetFriendlyLanguageName: UnicodeString; override;
    class function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: Integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetTokenID: TtkTokenKind;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: Integer; override;
    function IsIdentChar(AChar: WideChar): Boolean; override;
    procedure Next; override;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property DirectivesAttri: TSynHighlighterAttributes read fDirectivesAttri write fDirectivesAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property OpcodesAttri: TSynHighlighterAttributes read fOpcodesAttri write fOpcodesAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
  end;

implementation

uses
{$IFDEF SYN_CLX}
  QSynEditStrConst;
{$ELSE}
  SynEditStrConst;
{$ENDIF}

resourcestring
  SYNS_Filter = 'All files (*.*)|*.*';
  SYNS_Lang = '';
  SYNS_FriendlyLang = '';
  SYNS_AttrDirectives = 'Directives';
  SYNS_FriendlyAttrDirectives = 'Directives';
  SYNS_AttrOpcodes = 'Opcodes';
  SYNS_FriendlyAttrOpcodes = 'Opcodes';

const
  // as this language is case-insensitive keywords *must* be in lowercase
  KeyWords: array[0..95] of UnicodeString = (
    'adc', 'and', 'asl', 'bcc', 'bcs', 'beq', 'bit', 'bmi', 'bne', 'bpl', 'bra', 
    'brk', 'brl', 'bvc', 'bvs', 'byte', 'clc', 'cld', 'cli', 'clv', 'cmp', 
    'cop', 'cpx', 'cpy', 'dec', 'dex', 'dey', 'eor', 'inc', 'include', 'inx', 
    'iny', 'jml', 'jmp', 'jsl', 'jsr', 'lda', 'ldx', 'ldy', 'lsr', 'mvn', 'mvp', 
    'nop', 'ora', 'pea', 'pei', 'per', 'pha', 'phb', 'phd', 'phk', 'php', 'phx', 
    'phy', 'pla', 'plb', 'pld', 'plp', 'plx', 'ply', 'rep', 'rol', 'ror', 'rti', 
    'rtl', 'rts', 'sbc', 'sec', 'sed', 'segment', 'sei', 'sep', 'setcpu', 'sta', 
    'stp', 'stx', 'sty', 'stz', 'tax', 'tay', 'tcd', 'tcs', 'tdc', 'trb', 'tsb', 
    'tsc', 'tsx', 'txa', 'txs', 'txy', 'tya', 'tyx', 'wai', 'wdm', 'xba', 'xce' 
  );

  KeyIndices: array[0..358] of Integer = (
    -1, 64, -1, -1, -1, -1, -1, -1, -1, -1, -1, 93, -1, -1, 8, -1, -1, -1, -1, 
    -1, -1, 39, 40, -1, -1, -1, -1, -1, -1, -1, 7, -1, 32, 58, -1, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, 31, -1, -1, -1, -1, -1, -1, -1, -1, 56, -1, 
    -1, -1, 89, -1, -1, -1, -1, -1, 90, -1, 48, 38, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, 42, 17, -1, -1, 23, 30, -1, -1, -1, -1, -1, -1, -1, -1, -1, 50, -1, 
    -1, -1, 3, -1, 83, -1, 65, -1, 61, 47, 37, -1, -1, 73, -1, -1, -1, 63, -1, 
    66, -1, 16, -1, 70, 22, -1, -1, -1, -1, 94, 34, -1, -1, -1, 55, -1, 19, -1, 
    -1, -1, 81, -1, -1, -1, -1, -1, -1, 28, -1, -1, 9, -1, -1, -1, -1, 26, -1, 
    -1, -1, -1, -1, -1, -1, -1, 60, -1, -1, -1, -1, -1, -1, 54, -1, -1, -1, -1, 
    95, 29, -1, -1, -1, 12, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 25, -1, 20, 
    -1, -1, -1, -1, -1, -1, -1, -1, 86, 15, 43, -1, -1, -1, 82, -1, -1, -1, -1, 
    -1, -1, -1, 13, 11, -1, -1, -1, -1, 71, -1, 21, -1, -1, 4, 10, -1, -1, -1, 
    -1, 87, -1, -1, -1, 0, -1, -1, -1, 44, 36, -1, 62, 79, 69, 33, -1, -1, 24, 
    -1, -1, -1, -1, -1, -1, 18, -1, -1, -1, 85, -1, -1, 77, -1, 35, -1, 27, -1, 
    -1, 51, -1, -1, -1, 74, -1, -1, -1, -1, -1, -1, 78, 6, -1, 88, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, 91, 92, 53, 84, -1, -1, 76, -1, -1, 45, -1, -1, 68, 
    -1, -1, -1, 41, -1, 72, -1, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, -1, 46, -1, 5, 57, 52, 80, -1, -1, 75, -1, -1, -1, 14, -1, 67, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 49, -1, -1, 59, -1, -1, -1 
  );

procedure TSynSampleSyn.InitIdent;
var
  i: Integer;
begin
  for i := Low(fIdentFuncTable) to High(fIdentFuncTable) do
    if KeyIndices[i] = -1 then
      fIdentFuncTable[i] := AltFunc;

  fIdentFuncTable[233] := FuncAdc;
  fIdentFuncTable[351] := FuncAnd;
  fIdentFuncTable[312] := FuncAsl;
  fIdentFuncTable[97] := FuncBcc;
  fIdentFuncTable[223] := FuncBcs;
  fIdentFuncTable[328] := FuncBeq;
  fIdentFuncTable[279] := FuncBit;
  fIdentFuncTable[30] := FuncBmi;
  fIdentFuncTable[14] := FuncBne;
  fIdentFuncTable[145] := FuncBpl;
  fIdentFuncTable[224] := FuncBra;
  fIdentFuncTable[213] := FuncBrk;
  fIdentFuncTable[176] := FuncBrl;
  fIdentFuncTable[212] := FuncBvc;
  fIdentFuncTable[338] := FuncBvs;
  fIdentFuncTable[199] := FuncByte;
  fIdentFuncTable[116] := FuncClc;
  fIdentFuncTable[79] := FuncCld;
  fIdentFuncTable[253] := FuncCli;
  fIdentFuncTable[131] := FuncClv;
  fIdentFuncTable[189] := FuncCmp;
  fIdentFuncTable[220] := FuncCop;
  fIdentFuncTable[119] := FuncCpx;
  fIdentFuncTable[82] := FuncCpy;
  fIdentFuncTable[246] := FuncDec;
  fIdentFuncTable[187] := FuncDex;
  fIdentFuncTable[150] := FuncDey;
  fIdentFuncTable[264] := FuncEor;
  fIdentFuncTable[142] := FuncInc;
  fIdentFuncTable[172] := FuncInclude;
  fIdentFuncTable[83] := FuncInx;
  fIdentFuncTable[46] := FuncIny;
  fIdentFuncTable[32] := FuncJml;
  fIdentFuncTable[243] := FuncJmp;
  fIdentFuncTable[125] := FuncJsl;
  fIdentFuncTable[262] := FuncJsr;
  fIdentFuncTable[238] := FuncLda;
  fIdentFuncTable[105] := FuncLdx;
  fIdentFuncTable[68] := FuncLdy;
  fIdentFuncTable[21] := FuncLsr;
  fIdentFuncTable[22] := FuncMvn;
  fIdentFuncTable[307] := FuncMvp;
  fIdentFuncTable[78] := FuncNop;
  fIdentFuncTable[200] := FuncOra;
  fIdentFuncTable[237] := FuncPea;
  fIdentFuncTable[300] := FuncPei;
  fIdentFuncTable[326] := FuncPer;
  fIdentFuncTable[104] := FuncPha;
  fIdentFuncTable[67] := FuncPhb;
  fIdentFuncTable[352] := FuncPhd;
  fIdentFuncTable[93] := FuncPhk;
  fIdentFuncTable[267] := FuncPhp;
  fIdentFuncTable[330] := FuncPhx;
  fIdentFuncTable[293] := FuncPhy;
  fIdentFuncTable[166] := FuncPla;
  fIdentFuncTable[129] := FuncPlb;
  fIdentFuncTable[55] := FuncPld;
  fIdentFuncTable[329] := FuncPlp;
  fIdentFuncTable[33] := FuncPlx;
  fIdentFuncTable[355] := FuncPly;
  fIdentFuncTable[159] := FuncRep;
  fIdentFuncTable[103] := FuncRol;
  fIdentFuncTable[240] := FuncRor;
  fIdentFuncTable[112] := FuncRti;
  fIdentFuncTable[1] := FuncRtl;
  fIdentFuncTable[101] := FuncRts;
  fIdentFuncTable[114] := FuncSbc;
  fIdentFuncTable[340] := FuncSec;
  fIdentFuncTable[303] := FuncSed;
  fIdentFuncTable[242] := FuncSegment;
  fIdentFuncTable[118] := FuncSei;
  fIdentFuncTable[218] := FuncSep;
  fIdentFuncTable[309] := FuncSetcpu;
  fIdentFuncTable[108] := FuncSta;
  fIdentFuncTable[271] := FuncStp;
  fIdentFuncTable[334] := FuncStx;
  fIdentFuncTable[297] := FuncSty;
  fIdentFuncTable[260] := FuncStz;
  fIdentFuncTable[278] := FuncTax;
  fIdentFuncTable[241] := FuncTay;
  fIdentFuncTable[331] := FuncTcd;
  fIdentFuncTable[135] := FuncTcs;
  fIdentFuncTable[204] := FuncTdc;
  fIdentFuncTable[99] := FuncTrb;
  fIdentFuncTable[294] := FuncTsb;
  fIdentFuncTable[257] := FuncTsc;
  fIdentFuncTable[198] := FuncTsx;
  fIdentFuncTable[229] := FuncTxa;
  fIdentFuncTable[281] := FuncTxs;
  fIdentFuncTable[59] := FuncTxy;
  fIdentFuncTable[65] := FuncTya;
  fIdentFuncTable[291] := FuncTyx;
  fIdentFuncTable[292] := FuncWai;
  fIdentFuncTable[11] := FuncWdm;
  fIdentFuncTable[124] := FuncXba;
  fIdentFuncTable[171] := FuncXce;
end;

{$Q-}
function TSynSampleSyn.HashKey(Str: PWideChar): Cardinal;
begin
  Result := 0;
  while IsIdentChar(Str^) do
  begin
    Result := Result * 606 + Ord(Str^) * 322;
    inc(Str);
  end;
  Result := Result mod 359;
  fStringLen := Str - fToIdent;
end;
{$Q+}

function TSynSampleSyn.FuncAdc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncAnd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncAsl(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBcc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBcs(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBeq(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBit(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBmi(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBne(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBpl(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBra(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBrk(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBrl(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBvc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncBvs(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncByte(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkDirectives
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncClc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncCld(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncCli(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncClv(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncCmp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncCop(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncCpx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncCpy(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncDec(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncDex(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncDey(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncEor(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncInc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncInclude(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkDirectives
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncInx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncIny(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncJml(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncJmp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncJsl(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncJsr(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncLda(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncLdx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncLdy(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncLsr(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncMvn(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncMvp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncNop(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncOra(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPea(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPei(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPer(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPha(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPhb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPhd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPhk(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPhp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPhx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPhy(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPla(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPlb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPld(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPlp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPlx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncPly(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncRep(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncRol(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncRor(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncRti(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncRtl(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncRts(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSbc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSec(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSed(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSegment(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkDirectives
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSei(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSep(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSetcpu(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkDirectives
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSta(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncStp(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncStx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncSty(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncStz(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTax(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTay(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTcd(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTcs(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTdc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTrb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTsb(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTsc(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTsx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTxa(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTxs(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTxy(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTya(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncTyx(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncWai(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncWdm(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncXba(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.FuncXce(Index: Integer): TtkTokenKind;
begin
  if IsCurrentToken(KeyWords[Index]) then
    Result := tkOpcodes
  else
    Result := tkIdentifier;
end;

function TSynSampleSyn.AltFunc(Index: Integer): TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynSampleSyn.IdentKind(MayBe: PWideChar): TtkTokenKind;
var
  Key: Cardinal;
begin
  fToIdent := MayBe;
  Key := HashKey(MayBe);
  if Key <= High(fIdentFuncTable) then
    Result := fIdentFuncTable[Key](KeyIndices[Key])
  else
    Result := tkIdentifier;
end;

procedure TSynSampleSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while (FLine[Run] <= #32) and not IsLineEnd(Run) do inc(Run);
end;

procedure TSynSampleSyn.NullProc;
begin
  fTokenID := tkNull;
  inc(Run);
end;

procedure TSynSampleSyn.CRProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TSynSampleSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynSampleSyn.BraceCommentOpenProc;
begin
  Inc(Run);
  fRange := rsBraceComment;
  fTokenID := tkComment;
end;

procedure TSynSampleSyn.BraceCommentProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    begin
      fTokenID := tkComment;
      repeat
        if (fLine[Run] = '}') then
        begin
          Inc(Run, 1);
          fRange := rsUnKnown;
          Break;
        end;
        if not IsLineEnd(Run) then
          Inc(Run);
      until IsLineEnd(Run);
    end;
  end;
end;

procedure TSynSampleSyn.CStyleCommentOpenProc;
begin
  Inc(Run);
  if (fLine[Run] = '*') then
  begin
    Inc(Run, 1);
    fRange := rsCStyleComment;
    fTokenID := tkComment;
  end
  else
    fTokenID := tkIdentifier;
end;

procedure TSynSampleSyn.CStyleCommentProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    begin
      fTokenID := tkComment;
      repeat
        if (fLine[Run] = '*') and
           (fLine[Run + 1] = '/') then
        begin
          Inc(Run, 2);
          fRange := rsUnKnown;
          Break;
        end;
        if not IsLineEnd(Run) then
          Inc(Run);
      until IsLineEnd(Run);
    end;
  end;
end;

procedure TSynSampleSyn.AsmCommentOpenProc;
begin
  Inc(Run);
  fRange := rsAsmComment;
  AsmCommentProc;
  fTokenID := tkComment;
end;

procedure TSynSampleSyn.AsmCommentProc;
begin
  fTokenID := tkComment;
  while not IsLineEnd(Run) do
      Inc(Run);
end;

procedure TSynSampleSyn.StringOpenProc;
begin
  Inc(Run);
  fRange := rsString;
  StringProc;
  fTokenID := tkString;
end;

procedure TSynSampleSyn.StringProc;
begin
  fTokenID := tkString;
  repeat
    if (fLine[Run] = '"') then
    begin
      Inc(Run, 1);
      fRange := rsUnKnown;
      Break;
    end;
    if not IsLineEnd(Run) then
      Inc(Run);
  until IsLineEnd(Run);
end;

procedure TSynSampleSyn.String1OpenProc;
begin
  Inc(Run);
  fRange := rsString1;
  String1Proc;
  fTokenID := tkString;
end;

procedure TSynSampleSyn.String1Proc;
begin
  fTokenID := tkString;
  repeat
    if (fLine[Run] = '''') then
    begin
      Inc(Run, 1);
      fRange := rsUnKnown;
      Break;
    end;
    if not IsLineEnd(Run) then
      Inc(Run);
  until IsLineEnd(Run);
end;

constructor TSynSampleSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCaseSensitive := False;

  fCommentAttri := TSynHighLighterAttributes.Create(SYNS_AttrComment, SYNS_FriendlyAttrComment);
  fCommentAttri.Style := [fsItalic];
  fCommentAttri.Foreground := $808080;
  AddAttribute(fCommentAttri);

  fDirectivesAttri := TSynHighLighterAttributes.Create(SYNS_AttrDirectives, SYNS_FriendlyAttrDirectives);
  fDirectivesAttri.Foreground := $FF6060;
  AddAttribute(fDirectivesAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrIdentifier, SYNS_FriendlyAttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fNumberAttri := TSynHighLighterAttributes.Create(SYNS_AttrNumber, SYNS_FriendlyAttrNumber);
  fNumberAttri.Foreground := clPurple;
  AddAttribute(fNumberAttri);

  fOpcodesAttri := TSynHighLighterAttributes.Create(SYNS_AttrOpcodes, SYNS_FriendlyAttrOpcodes);
  fOpcodesAttri.Style := [fsBold];
  fOpcodesAttri.Foreground := clBlue;
  AddAttribute(fOpcodesAttri);

  fSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpace, SYNS_FriendlyAttrSpace);
  AddAttribute(fSpaceAttri);

  fStringAttri := TSynHighLighterAttributes.Create(SYNS_AttrString, SYNS_FriendlyAttrString);
  fStringAttri.Foreground := clRed;
  AddAttribute(fStringAttri);

  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  fDefaultFilter := SYNS_Filter;
  fRange := rsUnknown;
end;

procedure TSynSampleSyn.IdentProc;
begin
  fTokenID := IdentKind(fLine + Run);
  inc(Run, fStringLen);
  while IsIdentChar(fLine[Run]) do
    Inc(Run);
end;

procedure TSynSampleSyn.NumberProc;
begin
  inc(Run);
  fTokenID := tkNumber;
  while not IsLineEnd(Run) do
    case fLine[Run] of
      '0'..'9','A'..'F', 'a'..'f': inc(Run);
    else
      //inc(Run);
      break;
    end;
end;

procedure TSynSampleSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynSampleSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsBraceComment: BraceCommentProc;
    rsCStyleComment: CStyleCommentProc;
  else
    case fLine[Run] of
      #0: NullProc;
      #10: LFProc;
      #13: CRProc;
      '{': BraceCommentOpenProc;
      '/': CStyleCommentOpenProc;
      ';': AsmCommentOpenProc;
      '"': StringOpenProc;
      '''': String1OpenProc;
      #1..#9, #11, #12, #14..#32: SpaceProc;
      'A'..'Z', 'a'..'z', '_': IdentProc;
      '$': NumberProc;
    else
      UnknownProc;
    end;
  end;
  inherited;
end;

function TSynSampleSyn.GetDefaultAttribute(Index: Integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_STRING: Result := fStringAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
  else
    Result := nil;
  end;
end;

function TSynSampleSyn.GetEol: Boolean;
begin
  Result := Run = fLineLen + 1;
end;

function TSynSampleSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynSampleSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkComment: Result := fCommentAttri;
    tkDirectives: Result := fDirectivesAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkNumber: Result := fNumberAttri;
    tkOpcodes: Result := fOpcodesAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkUnknown: Result := fIdentifierAttri;
  else
    Result := nil;
  end;
end;

function TSynSampleSyn.GetTokenKind: Integer;
begin
  Result := Ord(fTokenId);
end;

function TSynSampleSyn.IsIdentChar(AChar: WideChar): Boolean;
begin
  case AChar of
    '_', '0'..'9', 'a'..'z', 'A'..'Z':
      Result := True;
    else
      Result := False;
  end;
end;

function TSynSampleSyn.GetSampleSource: UnicodeString;
begin
  Result := 
    '{ Sample source for the demo highlighter }'#13#10 +
    #13#10 +
    'This highlighter will recognize the words Hello and'#13#10 +
    'World as keywords. It will also highlight "Strings".'#13#10 +
    #13#10 +
    'And a special keyword type: SynEdit'#13#10 +
    '/* This style of comments is also highlighted */';
end;

function TSynSampleSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_Filter;
end;

class function TSynSampleSyn.GetFriendlyLanguageName: UnicodeString;
begin
  Result := SYNS_FriendlyLang;
end;

class function TSynSampleSyn.GetLanguageName: string;
begin
  Result := SYNS_Lang;
end;

procedure TSynSampleSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynSampleSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynSampleSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

initialization
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynSampleSyn);
{$ENDIF}
end.
