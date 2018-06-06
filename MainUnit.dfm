object fmMain: TfmMain
  Left = 404
  Top = 119
  Width = 844
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 828
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 112
      Top = 8
      Width = 50
      Height = 13
      Caption = 'File Offset:'
    end
    object Label2: TLabel
      Left = 200
      Top = 8
      Width = 69
      Height = 13
      Caption = 'ROM Address:'
    end
    object Label3: TLabel
      Left = 280
      Top = 8
      Width = 25
      Height = 13
      Caption = 'Num:'
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
      Left = 112
      Top = 24
      Width = 81
      Height = 21
      TabOrder = 1
      Text = '$0'
    end
    object eAddress: TEdit
      Left = 200
      Top = 24
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '$C00000'
    end
    object bParseCmd: TButton
      Tag = 1
      Left = 424
      Top = 12
      Width = 65
      Height = 33
      Hint = 'Parse '#39'Num'#39' instructions'
      Caption = 'Parse (instruction)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      WordWrap = True
      OnClick = bParseCmdClick
    end
    object seLen: TSpinEdit
      Left = 280
      Top = 24
      Width = 49
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 10
    end
    object cbAcc16: TCheckBox
      Left = 344
      Top = 16
      Width = 89
      Height = 17
      Caption = '16-bit A'
      TabOrder = 5
    end
    object cbInd16: TCheckBox
      Left = 344
      Top = 32
      Width = 81
      Height = 17
      Caption = '16-bit X/Y'
      TabOrder = 6
    end
    object bParseByte: TButton
      Tag = 2
      Left = 496
      Top = 12
      Width = 65
      Height = 33
      Hint = 'Parse '#39'Num'#39' bytes'
      Caption = 'Parse (bytes)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      WordWrap = True
      OnClick = bParseCmdClick
    end
    object bParseCode: TButton
      Tag = 3
      Left = 568
      Top = 12
      Width = 65
      Height = 33
      Hint = 'Parse until special opcodes occur (RTS, RTL, RTI, JMP, BRA)'
      Caption = 'Parse (special)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      WordWrap = True
      OnClick = bParseCmdClick
    end
    object bAddSub: TButton
      Left = 648
      Top = 16
      Width = 33
      Height = 25
      Hint = 'Add a Subroutine to the List'
      Caption = 'Add'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = bAddSubClick
    end
    object bLoad: TButton
      Left = 712
      Top = 4
      Width = 56
      Height = 20
      Hint = 'Load a List from a File'
      Caption = 'Load'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = bLoadClick
    end
    object bSave: TButton
      Left = 712
      Top = 26
      Width = 56
      Height = 20
      Hint = 'Save the List in a File'
      Caption = 'Save'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = bSaveClick
    end
  end
  object Memo: TMemo
    Left = 185
    Top = 53
    Width = 643
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
    Width = 185
    Height = 471
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object lbSub: TListBox
      Left = 0
      Top = 41
      Width = 185
      Height = 430
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 30
      TabOrder = 0
      OnClick = lbSubClick
      OnDrawItem = lbSubDrawItem
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 41
      Align = alTop
      BevelOuter = bvNone
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
end
