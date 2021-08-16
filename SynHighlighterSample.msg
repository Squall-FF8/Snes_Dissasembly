TSynSampleSyn   {first Identifier is considered to be the Class Name }
tk              {second Identifier is considered to be the Identifier Prefix }
IdentStart '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

TOKENTYPES
Identifier
Comment Style=[fsItalic]|Foreground=$808080
Space
String Foreground=clRed
Opcodes Style=[fsBold]|Foreground=clBlue
Directives Foreground=$FF6060
Number Foreground=clPurple
|><|

KEYS Opcodes
ADC
AND
ASL
BCC
BCS
BEQ
BIT
BMI
BNE
BPL
BRK
BVC
BVS
CLC
CLD
CLI
CLV
CMP
CPX
CPY
DEC
DEX
DEY
EOR
INC
INX
INY
JMP
JSR
LDA
LDX
LDY
LSR
NOP
ORA
PHA
PHP
PLA
PLP
ROL
ROR
RTI
RTS
SBC
SEC
SED
SEI
STA
STX
STY
TAX
TAY
TSX
TXA
TXS
TYA

BRA
PHX
PHY
PLX
PLY
STZ
TRB
TSB

BRL
COP
JML
JSL
MVN
MVP
PEA
PEI
PER
PHB
PHD
PHK
PLB
PLD
REP
RTL
SEP
STP
TCD
TCS
TDC
TSC
TXY
TYX
WAI
WDM
XBA
XCE

|><|

KEYS Directives
include
segment
SetCPU
byte
|><|

CHARS
'$'::Number
BeginProc
  inc(Run);
  fTokenID := tkNumber;
  while not IsLineEnd(Run) do
    case fLine[Run] of
      '0'..'9','A'..'F', 'a'..'f': inc(Run);
    else
      //inc(Run);
      break;
    end;
EndProc

'A'..'Z', 'a'..'z', '_':: Ident
BeginProc
  fTokenID := IdentKind(fLine + Run);
  inc(Run, fStringLen);
  while IsIdentChar(fLine[Run]) do
    Inc(Run);
EndProc

|><|

ENCLOSEDBY

Comment,BraceComment,{,},MultiLine
Comment,CStyleComment,/*,*/,MultiLine
Comment,AsmComment,;,
String,String,","
String,String1,','
|><|

SAMPLESOURCE
{ Sample source for the demo highlighter }

This highlighter will recognize the words Hello and
World as keywords. It will also highlight "Strings".

And a special keyword type: SynEdit

/* This style of comments is also highlighted */
|><|

