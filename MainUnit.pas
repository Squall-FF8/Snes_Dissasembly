unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Menus, Buttons,
  SynEdit, SynEditHighlighter, SynHighlighterSample;

type
  tName = string[20];
  tDescription = string[255];
  tKind = (Code = 1, Data = 2);

  tData = packed record
    Kind:  byte;
    Name:  tName;
    Descr: tDescription;
    Addr,
    Off,
    Bytes: integer;
    case tKind of
      Code: (
        Lines: integer;
        Acc16,
        Ind16: byte; );
      Data: (
        RowBytes: byte);
  end;
  pData = ^tData;

  tAddress = record
    Addr,
    Off: integer;
    Acc16,
    Ind16: byte;
  end;
  pAddress = ^tAddress;

  tMapping = record
    Name: string;
    Header,
    Address,
    Offset,
    Diff:   integer;
  end;
  pMapping = ^tMapping;


type
  TfmMain = class(TForm)
    Panel1: TPanel;
    bLoadROM: TButton;
    dOpenROM: TOpenDialog;
    lOffset: TLabel;
    eOffset: TEdit;
    lAddress: TLabel;
    eAddress: TEdit;
    cbAcc16: TCheckBox;
    cbInd16: TCheckBox;
    Panel2: TPanel;
    lbSub: TListBox;
    Panel3: TPanel;
    bAddData: TButton;
    bLoad: TButton;
    bSave: TButton;
    dSave: TSaveDialog;
    dOpen: TOpenDialog;
    Panel4: TPanel;
    lbCalls: TListBox;
    Splitter1: TSplitter;
    popCalls: TPopupMenu;
    miCalls_Delete: TMenuItem;
    miCalls_Use: TMenuItem;
    miCalls_SortAsc: TMenuItem;
    miCalls_SortDesc: TMenuItem;
    N1: TMenuItem;
    popSub: TPopupMenu;
    miSub_Del: TMenuItem;
    N2: TMenuItem;
    miSub_SortName: TMenuItem;
    SortbyAddress1: TMenuItem;
    seBytes: TSpinEdit;
    seLines: TSpinEdit;
    lBytes: TLabel;
    lLines: TLabel;
    bParseNext: TButton;
    Memo: TSynEdit;
    cbMapping: TComboBox;
    Label1: TLabel;
    lbParams: TListBox;
    popParams: TPopupMenu;
    miParam_Add: TMenuItem;
    miParam_Del: TMenuItem;
    miParam_Load: TMenuItem;
    miParam_Save: TMenuItem;
    N3: TMenuItem;
    miParam_Edit: TMenuItem;
    seBytesPerRow: TSpinEdit;
    bCode: TSpeedButton;
    bData: TSpeedButton;
    niSub_AddNext: TMenuItem;
    miSub_Edit: TMenuItem;
    bGenDoc: TButton;
    miParam_Import: TMenuItem;
    procedure bLoadROMClick(Sender: TObject);
    procedure bAddDataClick(Sender: TObject);
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
    procedure eAddressKeyPress(Sender: TObject; var Key: Char);
    procedure eOffsetKeyPress(Sender: TObject; var Key: Char);
    procedure seBytesChange(Sender: TObject);
    procedure seLinesChange(Sender: TObject);
    procedure cbMappingChange(Sender: TObject);
    procedure lbParamsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure miParam_DelClick(Sender: TObject);
    procedure miParam_AddClick(Sender: TObject);
    procedure miParam_EditClick(Sender: TObject);
    procedure miParam_SaveClick(Sender: TObject);
    procedure miParam_LoadClick(Sender: TObject);
    procedure bCodeClick(Sender: TObject);
    procedure bParseNextClick(Sender: TObject);
    procedure niSub_AddNextClick(Sender: TObject);
    procedure miSub_EditClick(Sender: TObject);
    procedure seBytesPerRowChange(Sender: TObject);
    procedure bGenDocClick(Sender: TObject);
    procedure miParam_ImportClick(Sender: TObject);
    procedure lbParamsDblClick(Sender: TObject);
  private
    procedure Parse(Method: integer; Data: pData = nil);
    procedure ParseData(Col: integer);
    procedure EmptyList;
    function  AddrInList(Addr: integer): boolean;
    procedure EnableControls(State: boolean);
    procedure RefreshParams;
    procedure ChangeKind;
    procedure ImportSymolFile;
  public
    Kind: byte;
    Diff: integer;
    CanChange: boolean;
    HL: TSynSampleSyn;
    Params: TStringList;
  end;

var
  fmMain: TfmMain;


implementation
{$R *.dfm}

uses IniFiles, StrUtils, uSubroutine, uParam;


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
    ' #%.2x',      //#const
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
  cMthLine = 1;
  cMthByte = 2;
  cMthCode = 3;
  cMthNext = 4;

  cSubCodes: set of byte = [$20, $22, $FC];




var
  ROM: array of byte;


procedure TfmMain.FormCreate(Sender: TObject);
  const cSettings = 'Settings';
  var i, p, b: integer;
      Header, Address, Offset: integer;
      s, sName: string;
      ini: tIniFile;

  function GetParam: string;
  begin
    b := p + 1;
    p := PosEx(',', s, b);
    Result := Copy(s, b, p - b);
  end;

  procedure ReadAttrib(Attribute: TSynHighlighterAttributes; const Ident: string);
    var Style: TFontStyles;
  begin
    s := ini.ReadString(cSettings, Ident, ',,,');
    p := 0;
    Attribute.Background := StrToIntDef(GetParam, Attribute.Background);
    Attribute.Foreground := StrToIntDef(GetParam, Attribute.Foreground);
    Style := [];
    while p < (Length(s) - 1) do begin
      sName := GetParam;
      if UpperCase(sName) = 'BOLD' then Style := Style + [fsBold];
      if UpperCase(sName) = 'ITALIC' then Style := Style + [fsItalic];
      if UpperCase(sName) = 'UNDERLINE' then Style := Style + [fsUnderline];
      if UpperCase(sName) = 'STRIKEOUT' then Style := Style + [fsStrikeOut];
    end;
    Attribute.Style := Style;
  end;
begin
  CanChange := true;
  EnableControls(false);

  HL := TSynSampleSyn.Create(Self);
  Memo.Highlighter := HL;

  ini := tIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  Params := tStringList.Create;
  ini.ReadSectionValues('MemoryMapping', Params);
  for i := 0 to Params.Count - 1 do begin
    s := Params.ValueFromIndex[i];
    p := 0;
    sName   := GetParam;
    Header  := StrToIntDef(GetParam, 0);
    Address := StrToIntDef(GetParam, 0);
    Offset  := StrToIntDef(GetParam, 0);
    cbMapping.AddItem(sName, tObject(Address - Offset - Header));
  end;
  cbMapping.ItemIndex := ini.ReadInteger(cSettings, 'MemMapIndex', -1);
  cbMappingChange(nil);

  ReadAttrib(HL.OpcodesAttri, 'OpcodesAttribute');
  ReadAttrib(HL.NumberAttri,  'NumberAttribute');
  ReadAttrib(HL.CommentAttri, 'CommentAttribute');

  s := ini.ReadString(cSettings, 'Dictionary', '');
  if FileExists(s) then
    lbParams.Items.LoadFromFile(s);
  ini.Free;

  // Lets start with showing Code
  bCode.Down := true;
  Kind := 1;

  RefreshParams;
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

  dOpen.FileName := ChangeFileExt(dOpenROM.FileName, '.sym');
  if FileExists(dOpen.FileName) then
    ImportSymolFile;
end;


function ParseParam(Prm, Len: byte; Off, Addr: integer; List: tStrings): string;
  function Param: string;
    const cMask: array[1..3] of cardinal = ($FF, $FFFF, $FFFFFF);
    var n: cardinal;
  begin
    n := pCardinal(@ROM[Off])^ and cMask[Len];
    Result := List.Values[IntToStr(n)];
    if Result = '' then
      Result := '$' + IntToHex(n, Len * 2);
  end;

  var c: shortint;
      b: smallint;
begin
  Result := '';
  case Prm of
    1: Result := format(cFmtAddr[Prm], [ ROM[Off] ]);
    2..21: Result := format(cFmtAddr[Prm], [Param]);
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


procedure TfmMain.Parse(Method: integer; Data: pData = nil);
  var i, j: integer;
      o, a, bank, off: integer;
      s: string;
      c, l, b,
      Acc16, Ind16: byte;  // 0 - 8 bit; 1 - 16 bit
      Num, NumLine, NumByte: integer;
      v: pAddress;
      f: boolean;
      dat: tData;
begin
  Num := 0;
  c := 0;

  if Data <> nil then dat := Data^
  else begin
    dat.Addr  := StrToInt(eAddress.Text);
    dat.Off   := StrToInt(eOffset.Text);
    dat.Bytes := seBytes.Value;
    dat.Lines := seLines.Value;
    dat.Acc16 := ord(cbAcc16.Checked);
    dat.Ind16 := ord(cbInd16.Checked);
  end;

  if Method = cMthByte then Num := dat.Bytes;
  if Method = cMthLine then Num := dat.Lines;

  Acc16 := dat.Acc16;
  Ind16 := dat.Ind16;

  o    := dat.Off;
  a    := dat.Addr;
  off  := a-o;
  bank := a and $FF0000;

  if Method = cMthNext then begin
    NumLine := dat.Lines;
    NumByte := dat.Bytes;
    inc(a, NumByte);
    inc(o, NumByte);
  end else begin
    NumLine := 0;
    NumByte := 0;
    if Data = nil then
      Memo.Clear;
  end;

  while ( (Method = cMthLine) and (NumLine < Num) ) or
        ( (Method = cMthByte) and (NumByte < Num) ) or
        ( (Method >= cMthCode) and not (c in [$60, $6B, $40, $4C, $80]) ) do begin
    s := Params.Values[IntToStr(a)];
    if s <> '' then Memo.Lines.Add('  ' + s + ':');

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
    s := s + ' ' + CPU[c].Name;
    s := s + ParseParam(CPU[c].Addr, l-1, o+1, a and $FFFF, Params);

    b := ROM[o+1];
    if c = $C2 then begin                 // REP
      if (b and $20) > 0 then Acc16 := 1;
      if (b and $10) > 0 then Ind16 := 1;
    end else if c = $E2 then begin        // SEP
      if (b and $20) > 0 then Acc16 := 0;
      if (b and $10) > 0 then Ind16 := 0;
    end;

    if (Data = nil) and (c in cSubCodes) then begin          // JSR
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
    inc(NumLine);
    inc(NumByte, l);
    Memo.Lines.Add(s);
  end;

  if Data = nil then begin
    if Method <> cMthByte then seBytes.Value := NumByte;
    if Method <> cMthLine then seLines.Value := NumLine;
  end;
end;


procedure TfmMain.ParseData(Col: integer);
  var i, j: integer;
      o, a, Num: integer;
      s, d: string;
begin
  o   := StrToInt(eOffset.Text);
  a   := StrToInt(eAddress.Text);
  Num := seBytes.Value;
  Memo.Clear;

  i := 0;
  while i < Num do begin
    s := format('%.6x:  ', [a+i]);
    d := ' .BYTE ';
    for j := 1 to Col do begin
      if i >= Num then break;
      s := s + format('%.2x ', [ROM[o + i]]);
      d := d + format('$%.2x, ', [ROM[o + i]]);
      inc(i);
    end;

    Delete(d, Length(d)-1, 1);
    while Length(s) < (9 + 3*Col) do
      s := s + ' ';
    Memo.Lines.Add(s + d);
  end;
end;


procedure TfmMain.bAddDataClick(Sender: TObject);
  var v: pData;
begin
  fmSubroutine.SetKind(Kind);

  fmSubroutine.eAddress.Text   := eAddress.Text;
  fmSubroutine.eOffset.Text    := eOffset.Text;
  fmSubroutine.seBytes.Value   := seBytes.Value;
  fmSubroutine.seLines.Value   := seLines.Value;
  fmSubroutine.cbAcc16.Checked := cbAcc16.Checked;
  fmSubroutine.cbInd16.Checked := cbInd16.Checked;
  fmSubroutine.sePerRow.Value  := seBytesPerRow.Value;

  if fmSubroutine.ShowModal <> mrOK then exit;

  New(v);
  FillChar(v^, Sizeof(v^), 0);
  v.Kind  := Kind;
  v.Addr  := StrToInt(fmSubroutine.eAddress.Text);
  v.Off   := StrToInt(fmSubroutine.eOffset.Text);
  v.Bytes := fmSubroutine.seBytes.Value;
  v.Lines := fmSubroutine.seLines.Value;
  v.Acc16 := ord(fmSubroutine.cbAcc16.Checked);
  v.Ind16 := ord(fmSubroutine.cbInd16.Checked);
  v.Name  := fmSubroutine.eSubName.Text;
  v.Descr := fmSubroutine.eDescr.Text;
  if Kind = 2 then
    v.RowBytes := fmSubroutine.sePerRow.Value;

  lbSub.AddItem(v.Name, tObject(v));
  lbSub.ItemIndex := lbSub.Count -1;
  //lbSub.Selected[lbSub.Count -1] := true;
  //if Kind = 2 then lbSubClick(Self);
end;


procedure TfmMain.lbSubDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
  var v: pData;
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
      f: file of tData;
begin
  dSave.Filter := 'Disassembly Files|*.sda|All Files (*.*)|*.*';
  if not dSave.Execute then exit;

  AssignFile(f, dSave.FileName);
  Rewrite(f);
  for i := 0 to lbSub.Count -1 do
    Write(f, pData(lbSub.Items.Objects[i])^);
  CloseFile(f);
end;


procedure TfmMain.bLoadClick(Sender: TObject);
  var i, n: integer;
      f: file of tData;
      v: pData;
begin
  dOpen.Filter := 'Disassembly Files|*.sda|All Files (*.*)|*.*';
  if not dOpen.Execute then exit;

  AssignFile(f, dOpen.FileName);
  Reset(f);
  n := FileSize(f);  // return   number of records, no size in bytes
  EmptyList;
  for i := 1 to n do begin
    New(v);
    Read(f, v^);
    lbSub.AddItem(v.Name, tObject(v));
  end;
  CloseFile(f);
  RefreshParams;
end;


procedure TfmMain.lbSubClick(Sender: TObject);
  var v: pData;
begin
  if lbSub.ItemIndex < 0 then exit;
  v := pointer(lbSub.Items.Objects[lbSub.ItemIndex]);

  CanChange := false;
  eOffset.Text    := format('$%x',[v.Off]);
  eAddress.Text   := format('$%x',[v.Addr]);
  seBytes.Value   := v.Bytes;
  seLines.Value   := v.Lines;
  cbAcc16.Checked := v.Acc16 = 1;
  cbInd16.Checked := v.Ind16 = 1;
  seBytesPerRow.Value := v.RowBytes;
  CanChange := true;

  Kind := v.Kind;
  ChangeKind;
  if Kind = 1 then Parse(cMthByte)
              else ParseData(v.RowBytes);
end;


procedure TfmMain.lbSubDblClick(Sender: TObject);
  var v: pData;
      Kind: byte;
begin
  if lbSub.ItemIndex < 0 then exit;
  v := pointer(lbSub.Items.Objects[lbSub.ItemIndex]);
  Kind := v.Kind;
  fmSubroutine.SetKind(Kind);

  fmSubroutine.eSubName.Text   := v.Name;
  fmSubroutine.eDescr.Text     := v.Descr;
  fmSubroutine.eAddress.Text   := format('$%x',[v.Addr]);
  fmSubroutine.eOffset.Text    := format('$%x',[v.Off]);
  fmSubroutine.seBytes.Value   := v.Bytes;
  fmSubroutine.seLines.Value   := v.Lines;
  fmSubroutine.cbAcc16.Checked := v.Acc16 = 1;
  fmSubroutine.cbInd16.Checked := v.Ind16 = 1;
  fmSubroutine.sePerRow.Value  := v.RowBytes;

  if fmSubroutine.ShowModal <> mrOK then exit;

  FillChar(v^, Sizeof(v^), 0);
  v.Kind  := Kind;
  v.Addr  := StrToInt(fmSubroutine.eAddress.Text);
  v.Off   := StrToInt(fmSubroutine.eOffset.Text);
  v.Bytes := fmSubroutine.seBytes.Value;
  v.Lines := fmSubroutine.seLines.Value;
  v.Acc16 := ord(fmSubroutine.cbAcc16.Checked);
  v.Ind16 := ord(fmSubroutine.cbInd16.Checked);
  v.Name  := fmSubroutine.eSubName.Text;
  v.Descr := fmSubroutine.eDescr.Text;
  if Kind = 2 then v.RowBytes := fmSubroutine.sePerRow.Value;
  lbSub.Repaint;
end;


procedure TfmMain.EnableControls(State: boolean);
begin
  bAddData.Enabled   := State;
  bParseNext.Enabled := State;
  bLoad.Enabled      := State;
  bSave.Enabled      := State;
  lbSub.Enabled      := State;
  cbAcc16.Enabled    := State;
  cbInd16.Enabled    := State;
  seBytes.Enabled    := State;
  seLines.Enabled    := State;
  lBytes.Enabled     := State;
  lLines.Enabled     := State;
  eAddress.Enabled   := State;
  eOffset.Enabled    := State;
  lAddress.Enabled   := State;
  lOffset.Enabled    := State;
  bCode.Enabled      := State;
  bData.Enabled      := State;
  seBytesPerRow.Enabled := State;
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
    if pData(lbSub.Items.Objects[i])^.Addr = Addr then
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
  eAddress.Text   := format('$%x',[v.Addr]);
  eOffset.Text    := format('$%x',[v.Addr - v.Off]);
  cbAcc16.Checked := v.Acc16 = 1;
  cbInd16.Checked := v.Ind16 = 1;

  Kind := 1;
  ChangeKind;
  Parse(cMthCode);
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


procedure TfmMain.eAddressKeyPress(Sender: TObject; var Key: Char);
  var a: integer;
begin
  if Key = #13 then begin
    Key := #0;
    a := StrToInt(eAddress.Text) + Diff * TEdit(Sender).Tag;
    eOffset.Text := '$' + IntToHex(a, 1);
    if Kind = 1 then Parse(cMthCode)
                else ParseData(seBytesPerRow.Value);
  end;
end;

procedure TfmMain.eOffsetKeyPress(Sender: TObject; var Key: Char);
  var a: integer;
begin
  if Key = #13 then begin
    Key := #0;
    a := StrToInt(eOffset.Text) + Diff;
    //if bHiRom.Down  then a := a or $C00000;
    //if bHeader.Down then dec(a, $200);
    eAddress.Text := '$' + IntToHex(a, 1);
  end;
end;

procedure TfmMain.seBytesChange(Sender: TObject);
begin
  if CanChange then
    if Kind = 1 then Parse(cMthByte)
                else ParseData(seBytesPerRow.Value);
end;

procedure TfmMain.seLinesChange(Sender: TObject);
begin
  if CanChange then
    Parse(cMthLine);
end;


procedure TfmMain.cbMappingChange(Sender: TObject);
  var ind: integer;
begin
  ind := cbMapping.ItemIndex;
  if ind >= 0 then begin
    Diff := Integer(cbMapping.Items.Objects[ind]);
    eOffset.Text := '$' + IntToHex(StrToInt(eAddress.Text) - Diff, 1);
  end;
end;


// ==========================
// Know Memory Address Handling (aka Params)
// ==========================
procedure TfmMain.lbParamsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
  const dX = 65;
  var s: string;
      r: tRect;
begin
  with lbParams.Canvas do begin
    FillRect(Rect);

    s := lbParams.Items.Names[Index];
    if Trim(s) = '' then exit;
    r := Rect;
    r.Right := dX;
    Font.Color := clBlue;
    DrawText(Handle, pChar(s), -1, r, DT_SINGLELINE or DT_VCENTER or DT_RIGHT);

    r := Rect;
    r.Left := dX;
    s := ' = ' + lbParams.Items.ValueFromIndex[Index];
    Font.Color := clWindowText;
    DrawText(Handle, pChar(s), -1, r, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
  end;
end;


procedure TfmMain.RefreshParams;
  var i, n: integer;
      v: pData;
begin
  Params.Clear;
  for i:= 0 to lbParams.Count - 1 do begin
    n := StrToIntDef(lbParams.Items.Names[i], -1);
    if n >= 0 then
      Params.Add(format('%d=%s', [n, lbParams.Items.ValueFromIndex[i]]));
  end;

  for i:= 0 to lbSub.Count - 1 do begin
    v := pData(lbSub.Items.Objects[i]);
    Params.Add(format('%d=%s', [v.Addr, v.Name]));
  end;
end;


procedure TfmMain.miParam_DelClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbParams.ItemIndex;
  if ind < 0 then exit;
  lbParams.Items.Delete(ind);
  RefreshParams;
end;


procedure TfmMain.miParam_AddClick(Sender: TObject);
begin
  fmParam.eAddress.Text := '';
  fmParam.eName.Text    := '';
  if fmParam.ShowModal <> mrOK then exit;
  lbParams.Items.Add(fmParam.eAddress.Text + '=' + fmParam.eName.Text);
  RefreshParams;
end;

procedure TfmMain.miParam_EditClick(Sender: TObject);
  var ind: integer;
begin
  ind := lbParams.ItemIndex;
  if ind < 0 then exit;

  fmParam.eAddress.Text := lbParams.Items.Names[ind];
  fmParam.eName.Text    := lbParams.Items.ValueFromIndex[ind];
  if fmParam.ShowModal <> mrOK then exit;
  lbParams.Items[ind] := fmParam.eAddress.Text + '=' + fmParam.eName.Text;
  RefreshParams;
end;

procedure TfmMain.miParam_SaveClick(Sender: TObject);
begin
  dSave.Filter := 'Disassembly Dictionary|*.dic|All Files (*.*)|*.*';
  if dSave.Execute then
    lbParams.Items.SaveToFile(dSave.FileName);
end;

procedure TfmMain.miParam_LoadClick(Sender: TObject);
begin
  dOpen.Filter := 'Disassembly Dictionary|*.dic|All Files (*.*)|*.*';
  if not dOpen.Execute then exit;

  lbParams.Items.LoadFromFile(dOpen.FileName);
  RefreshParams;
end;


procedure TfmMain.ChangeKind;
begin
  cbAcc16.Visible       := Kind = 1;
  cbInd16.Visible       := Kind = 1;
  bParseNext.Visible    := Kind = 1;
  seBytesPerRow.Visible := Kind = 2;
  if Kind = 1 then lLines.Caption := 'Lines'
              else lLines.Caption := 'Per Row';
  if Kind = 1 then bCode.Down := true
              else bData.Down := true;
end;


procedure TfmMain.bCodeClick(Sender: TObject);
begin
  Kind := tSpeedButton(Sender).Tag;
  ChangeKind;
  if Kind = 1 then Parse(cMthByte)
              else ParseData(seBytesPerRow.Value);
end;

procedure TfmMain.bParseNextClick(Sender: TObject);
begin
  Parse(cMthNext);
end;


procedure TfmMain.niSub_AddNextClick(Sender: TObject);
  var a: integer;
      v: pData;
begin
  if lbSub.ItemIndex < 0 then exit;
  v := pointer(lbSub.Items.Objects[lbSub.ItemIndex]);
  a := v.Addr + v.Bytes;

  eAddress.Text := format('$%x',[a]);
  eOffset.Text  := format('$%x',[a - Diff]);
  if Kind = 1 then Parse(cMthCode)
              else ParseData(seBytesPerRow.Value);
end;

procedure TfmMain.miSub_EditClick(Sender: TObject);
begin
  lbSubDblClick(Self);
end;

procedure TfmMain.seBytesPerRowChange(Sender: TObject);
begin
  if CanChange then
    ParseData(seBytesPerRow.Value);
end;

procedure TfmMain.bGenDocClick(Sender: TObject);
  var i: integer;
      v: pData;
begin
  Memo.Clear;
  for i := 0 to lbSub.Count - 1 do begin
    v := pointer(lbSub.Items.Objects[i]);
    Memo.Lines.Add('');
    Memo.Lines.Add('  ; ' + v.Name);
    Memo.Lines.Add('  ; ' + v.Descr);
    if v.Kind = 1 then Parse(cMthByte, v)
                  else ParseData(v.RowBytes);
  end;
end;


procedure TfmMain.miParam_ImportClick(Sender: TObject);
begin
  dOpen.Filter := 'VICE symbol file|*.sym|All Files (*.*)|*.*';
  if not dOpen.Execute then exit;
  ImportSymolFile;
end;


procedure TfmMain.ImportSymolFile;
  var i, p, e: integer;
      s, s1, s2: string;
      list: TStringList;

  function GetParam: string;
  begin
    Result := '';
    e := p;
    while (e <= length(s)) and (s[e] <> ' ') do inc(e);
    Result := Copy(s, p, e-p);
    p := e + 1;
  end;

begin
  lbParams.Clear;
  list := TStringList.Create;
  list.LoadFromFile(dOpen.FileName);
  for i := 0 to list.Count - 1 do begin
    s := list[i];
    if s = '' then continue;
    p := 1;
    if GetParam <> 'al' then continue;
    s1 := GetParam;
    s2 := GetParam;
    if s2[1] = '.' then Delete(s2, 1, 1);
    if Copy(s2, 1, 2) = '__' then continue;
    lbParams.Items.Add('$' + s1 + '=' + s2);
    //lbParams.Items.Add(s1 + '=' + s2);
  end;
  list.Free;

  lbParams.Sorted := true;
  lbParams.Sorted := false;
  RefreshParams;
end;


procedure TfmMain.lbParamsDblClick(Sender: TObject);
  var n: integer;
      c: char;
begin
  n := lbParams.ItemIndex;
  if n < 0 then exit;

  eAddress.Text := lbParams.Items.Names[n];
  c := #13;
  eAddressKeyPress(eAddress, c);
end;

end.
