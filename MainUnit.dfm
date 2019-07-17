object fmMain: TfmMain
  Left = 404
  Top = 119
  Width = 923
  Height = 563
  Caption = 'Disassembly'
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
    Width = 907
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lOffset: TLabel
      Left = 104
      Top = 27
      Width = 50
      Height = 13
      Caption = 'File Offset:'
    end
    object lAddress: TLabel
      Left = 104
      Top = 5
      Width = 69
      Height = 13
      Caption = 'ROM Address:'
    end
    object lBytes: TLabel
      Left = 312
      Top = 5
      Width = 29
      Height = 13
      Caption = 'Bytes:'
    end
    object lLines: TLabel
      Left = 312
      Top = 27
      Width = 28
      Height = 13
      Caption = 'Lines:'
    end
    object bHeader: TSpeedButton
      Left = 240
      Top = 2
      Width = 42
      Height = 15
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Header'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Serif'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
    end
    object bLoRom: TSpeedButton
      Left = 240
      Top = 17
      Width = 42
      Height = 15
      AllowAllUp = True
      GroupIndex = 2
      Caption = 'LoROM'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Serif'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
    end
    object bHiRom: TSpeedButton
      Left = 240
      Top = 32
      Width = 42
      Height = 15
      AllowAllUp = True
      GroupIndex = 2
      Down = True
      Caption = 'HiROM'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Serif'
      Font.Style = []
      Layout = blGlyphBottom
      ParentFont = False
    end
    object cbAcc16: TCheckBox
      Left = 408
      Top = 8
      Width = 81
      Height = 17
      Caption = '16-bit A'
      TabOrder = 4
    end
    object cbInd16: TCheckBox
      Left = 408
      Top = 24
      Width = 81
      Height = 17
      Caption = '16-bit X/Y'
      TabOrder = 5
    end
    object bLoadROM: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 37
      Hint = 'Load an SNES ROM'
      Caption = 'Load ROM'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = bLoadROMClick
    end
    object eOffset: TEdit
      Left = 176
      Top = 24
      Width = 57
      Height = 21
      TabOrder = 1
      Text = '$0'
      OnKeyPress = eOffsetKeyPress
    end
    object eAddress: TEdit
      Left = 176
      Top = 2
      Width = 57
      Height = 21
      TabOrder = 2
      Text = '$C00000'
      OnKeyPress = eAddressKeyPress
    end
    object bParseCmd: TButton
      Tag = 1
      Left = 480
      Top = 12
      Width = 48
      Height = 33
      Hint = 'Parse '#39'Num'#39' instructions'
      Caption = 'Parse (lines)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      WordWrap = True
      OnClick = bParseCmdClick
    end
    object bParseByte: TButton
      Tag = 2
      Left = 536
      Top = 12
      Width = 48
      Height = 33
      Hint = 'Parse '#39'Num'#39' bytes'
      Caption = 'Parse (bytes)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      WordWrap = True
      OnClick = bParseCmdClick
    end
    object bParseCode: TButton
      Tag = 3
      Left = 592
      Top = 12
      Width = 48
      Height = 33
      Hint = 'Parse until special opcodes occur (RTS, RTL, RTI, JMP, BRA)'
      Caption = 'Parse (special)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      WordWrap = True
      OnClick = bParseCmdClick
    end
    object bAddSub: TButton
      Tag = 1
      Left = 720
      Top = 12
      Width = 41
      Height = 33
      Hint = 'Add a Subroutine to the List'
      Caption = 'Add (sub)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      WordWrap = True
      OnClick = bAddSubClick
    end
    object bLoad: TButton
      Left = 824
      Top = 4
      Width = 56
      Height = 20
      Hint = 'Load a List from a File'
      Caption = 'Load'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = bLoadClick
    end
    object bSave: TButton
      Left = 824
      Top = 26
      Width = 56
      Height = 20
      Hint = 'Save the List in a File'
      Caption = 'Save'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = bSaveClick
    end
    object bAddData: TButton
      Tag = 2
      Left = 768
      Top = 12
      Width = 41
      Height = 33
      Hint = 'Add a Subroutine to the List'
      Caption = 'Add (data)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      WordWrap = True
      OnClick = bAddSubClick
    end
    object seBytes: TSpinEdit
      Left = 344
      Top = 2
      Width = 49
      Height = 22
      AutoSize = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 12
      Value = 0
      OnKeyUp = seBytesKeyUp
    end
    object seLines: TSpinEdit
      Left = 344
      Top = 24
      Width = 49
      Height = 22
      AutoSize = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 13
      Value = 0
      OnKeyUp = seLinesKeyUp
    end
    object Button1: TButton
      Tag = 4
      Left = 648
      Top = 12
      Width = 48
      Height = 33
      Hint = 'Parse until special opcodes occur (RTS, RTL, RTI, JMP, BRA)'
      Caption = 'Parse Next'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      WordWrap = True
      OnClick = bParseCmdClick
    end
  end
  object Memo: TMemo
    Left = 241
    Top = 53
    Width = 467
    Height = 471
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 53
    Width = 241
    Height = 471
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object lbSub: TListBox
      Left = 0
      Top = 41
      Width = 241
      Height = 430
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
    Left = 708
    Top = 53
    Width = 199
    Height = 471
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel4'
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 0
      Top = 293
      Width = 199
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object lbCalls: TListBox
      Left = 0
      Top = 296
      Width = 199
      Height = 175
      Align = alBottom
      ItemHeight = 13
      PopupMenu = popCalls
      TabOrder = 0
      OnDblClick = lbCallsDblClick
    end
    object mParams: TMemo
      Left = 0
      Top = 0
      Width = 199
      Height = 293
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object dOpenROM: TOpenDialog
    Filter = 'SNES ROM (*.smc, *.sfc)|*.smc;*.sfc|ALL (*.*)|*.*'
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
    Left = 768
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
end
