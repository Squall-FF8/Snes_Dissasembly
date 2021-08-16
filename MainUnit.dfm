object fmMain: TfmMain
  Left = 404
  Top = 119
  Width = 1017
  Height = 563
  Caption = 'Disassembly - 6502/65c02/65816'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1001
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lOffset: TLabel
      Left = 128
      Top = 27
      Width = 28
      Height = 13
      Caption = 'Offset'
    end
    object lAddress: TLabel
      Left = 315
      Top = 27
      Width = 38
      Height = 13
      Caption = 'Address'
    end
    object lBytes: TLabel
      Left = 376
      Top = 5
      Width = 29
      Height = 13
      Caption = 'Bytes:'
    end
    object lLines: TLabel
      Left = 376
      Top = 27
      Width = 28
      Height = 13
      Caption = 'Lines:'
    end
    object Label1: TLabel
      Left = 128
      Top = 5
      Width = 44
      Height = 13
      Caption = 'Mapping:'
    end
    object bCode: TSpeedButton
      Tag = 1
      Left = 560
      Top = 2
      Width = 38
      Height = 22
      GroupIndex = 1
      Caption = 'Code'
      OnClick = bCodeClick
    end
    object bData: TSpeedButton
      Tag = 2
      Left = 600
      Top = 2
      Width = 38
      Height = 22
      GroupIndex = 1
      Caption = 'Data'
      OnClick = bCodeClick
    end
    object cbAcc16: TCheckBox
      Left = 480
      Top = 8
      Width = 81
      Height = 17
      Caption = '16-bit A'
      TabOrder = 3
    end
    object cbInd16: TCheckBox
      Left = 480
      Top = 24
      Width = 81
      Height = 17
      Caption = '16-bit X/Y'
      TabOrder = 4
    end
    object bLoadROM: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 37
      Hint = 'Load a SNES ROM'
      Caption = 'Load ROM'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = bLoadROMClick
    end
    object eOffset: TEdit
      Tag = 1
      Left = 176
      Top = 24
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '$0'
      OnKeyPress = eOffsetKeyPress
    end
    object eAddress: TEdit
      Tag = -1
      Left = 248
      Top = 24
      Width = 65
      Height = 21
      TabOrder = 2
      Text = '$801'
      OnKeyPress = eAddressKeyPress
    end
    object bAddData: TButton
      Tag = 1
      Left = 696
      Top = 8
      Width = 41
      Height = 33
      Hint = 'Add the parsed data to the List'
      Caption = 'Add'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      WordWrap = True
      OnClick = bAddDataClick
    end
    object bLoad: TButton
      Left = 840
      Top = 2
      Width = 56
      Height = 20
      Hint = 'Load a List from a File'
      Caption = 'Load'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = bLoadClick
    end
    object bSave: TButton
      Left = 840
      Top = 24
      Width = 56
      Height = 20
      Hint = 'Save the List in a File'
      Caption = 'Save'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = bSaveClick
    end
    object seBytes: TSpinEdit
      Left = 416
      Top = 2
      Width = 49
      Height = 22
      Hint = 'Number of bytes to parse'
      AutoSize = False
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Value = 0
      OnChange = seBytesChange
    end
    object seLines: TSpinEdit
      Left = 416
      Top = 24
      Width = 49
      Height = 22
      Hint = 'Number of Instructions to parse (lines)'
      AutoSize = False
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Value = 0
      OnChange = seLinesChange
    end
    object bParseNext: TButton
      Tag = 4
      Left = 560
      Top = 24
      Width = 78
      Height = 21
      Hint = 'Parse until next special opcodes occur (RTS, RTL, RTI, JMP, BRA)'
      Caption = 'Parse Next'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      WordWrap = True
      OnClick = bParseNextClick
    end
    object cbMapping: TComboBox
      Left = 176
      Top = 2
      Width = 153
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      OnChange = cbMappingChange
    end
    object seBytesPerRow: TSpinEdit
      Left = 416
      Top = 24
      Width = 49
      Height = 22
      Hint = 'Bytes per Row'
      AutoSize = False
      Enabled = False
      MaxValue = 255
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Value = 4
      Visible = False
      OnChange = seBytesPerRowChange
    end
    object bGenDoc: TButton
      Tag = 1
      Left = 760
      Top = 8
      Width = 41
      Height = 33
      Hint = 'Generate a document from the list'
      Caption = 'Doc'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      WordWrap = True
      OnClick = bGenDocClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 241
    Height = 475
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object lbSub: TListBox
      Left = 0
      Top = 41
      Width = 241
      Height = 434
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 32
      PopupMenu = popSub
      TabOrder = 0
      OnClick = lbSubClick
      OnDblClick = lbSubDblClick
      OnDrawItem = lbSubDrawItem
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 241
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
    end
  end
  object Panel4: TPanel
    Left = 764
    Top = 49
    Width = 237
    Height = 475
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel4'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 0
      Top = 297
      Width = 237
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object lbCalls: TListBox
      Left = 0
      Top = 300
      Width = 237
      Height = 175
      Hint = 'Possible Subroutine Addresses'
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      ParentShowHint = False
      PopupMenu = popCalls
      ShowHint = True
      TabOrder = 0
      OnDblClick = lbCallsDblClick
    end
    object lbParams: TListBox
      Left = 0
      Top = 0
      Width = 237
      Height = 297
      Hint = 'List of known addresses'
      Style = lbOwnerDrawFixed
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 18
      ParentFont = False
      ParentShowHint = False
      PopupMenu = popParams
      ShowHint = True
      TabOrder = 1
      OnDrawItem = lbParamsDrawItem
    end
  end
  object Memo: TSynEdit
    Left = 241
    Top = 49
    Width = 523
    Height = 475
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 3
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.ShowLineNumbers = True
    FontSmoothing = fsmNone
  end
  object dOpenROM: TOpenDialog
    Filter = 
      'SNES ROM (*.smc, *.sfc)|*.smc;*.sfc|X16 (*.prg)|*.prg|ALL (*.*)|' +
      '*.*'
    FilterIndex = 2
    Left = 248
    Top = 240
  end
  object dSave: TSaveDialog
    DefaultExt = 'sda'
    Filter = 'Disassembly Files|*.sda|All Files (*.*)|*.*'
    Left = 280
    Top = 272
  end
  object dOpen: TOpenDialog
    DefaultExt = 'sda'
    Filter = 'Disassembly Files|*.sda|All Files (*.*)|*.*'
    Left = 248
    Top = 272
  end
  object popCalls: TPopupMenu
    Left = 840
    Top = 392
    object miCalls_Use: TMenuItem
      Caption = 'Use'
      OnClick = miCalls_UseClick
    end
    object miCalls_Delete: TMenuItem
      Caption = 'Delete'
      ShortCut = 46
      OnClick = miCalls_DeleteClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miCalls_SortAsc: TMenuItem
      Caption = 'Sort Ascendent'
      OnClick = miCalls_SortAscClick
    end
    object miCalls_SortDesc: TMenuItem
      Caption = 'Sort Descendent'
      OnClick = miCalls_SortDescClick
    end
  end
  object popSub: TPopupMenu
    Left = 96
    Top = 240
    object niSub_AddNext: TMenuItem
      Caption = 'Add Next'
      Hint = 'aaaaaa'
      OnClick = niSub_AddNextClick
    end
    object miSub_Edit: TMenuItem
      Caption = 'Edit'
      ShortCut = 13
      OnClick = miSub_EditClick
    end
    object miSub_Del: TMenuItem
      Caption = 'Delete'
      ShortCut = 46
      OnClick = miSub_DelClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miSub_SortName: TMenuItem
      Caption = 'Sort by Name'
      OnClick = miSub_SortNameClick
    end
    object SortbyAddress1: TMenuItem
      Caption = 'Sort by Address'
      OnClick = SortbyAddress1Click
    end
  end
  object popParams: TPopupMenu
    Left = 830
    Top = 205
    object miParam_Add: TMenuItem
      Caption = 'Add'
      OnClick = miParam_AddClick
    end
    object miParam_Edit: TMenuItem
      Caption = 'Edit'
      ShortCut = 13
      OnClick = miParam_EditClick
    end
    object miParam_Del: TMenuItem
      Caption = 'Delete'
      ShortCut = 46
      OnClick = miParam_DelClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miParam_Load: TMenuItem
      Caption = 'Load from File'
      OnClick = miParam_LoadClick
    end
    object miParam_Save: TMenuItem
      Caption = 'Save to File'
      OnClick = miParam_SaveClick
    end
  end
end
