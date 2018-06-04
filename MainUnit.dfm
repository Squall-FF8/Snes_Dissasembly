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
    TabOrder = 0
    object Label1: TLabel
      Left = 112
      Top = 8
      Width = 50
      Height = 13
      Caption = 'File Offset:'
    end
    object Label2: TLabel
      Left = 208
      Top = 8
      Width = 69
      Height = 13
      Caption = 'ROM Address:'
    end
    object Label3: TLabel
      Left = 296
      Top = 8
      Width = 25
      Height = 13
      Caption = 'Num:'
    end
    object bLoad: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 37
      Caption = 'Load'
      TabOrder = 0
      OnClick = bLoadClick
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
      Left = 208
      Top = 24
      Width = 73
      Height = 21
      TabOrder = 2
      Text = '$C00000'
    end
    object bStart: TButton
      Left = 472
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 3
      OnClick = bStartClick
    end
    object seLen: TSpinEdit
      Left = 296
      Top = 24
      Width = 49
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 10
    end
    object cbAcc16: TCheckBox
      Left = 368
      Top = 16
      Width = 89
      Height = 17
      Caption = '16-bit A'
      TabOrder = 5
    end
    object cbInd16: TCheckBox
      Left = 368
      Top = 32
      Width = 81
      Height = 17
      Caption = '16-bit X/Y'
      TabOrder = 6
    end
  end
  object Memo: TMemo
    Left = 0
    Top = 53
    Width = 828
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
  object dOpen: TOpenDialog
    Filter = 'ALL (*.*)|*.*'
    Left = 144
    Top = 224
  end
end
