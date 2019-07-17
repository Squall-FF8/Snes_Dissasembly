object fmSubroutine: TfmSubroutine
  Left = 412
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Subroutine Property'
  ClientHeight = 280
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object Label2: TLabel
    Left = 16
    Top = 51
    Width = 56
    Height = 13
    Caption = 'Description:'
  end
  object Label3: TLabel
    Left = 16
    Top = 83
    Width = 69
    Height = 13
    Caption = 'ROM Address:'
  end
  object Label4: TLabel
    Left = 16
    Top = 115
    Width = 50
    Height = 13
    Caption = 'File Offset:'
  end
  object Label5: TLabel
    Left = 16
    Top = 147
    Width = 36
    Height = 13
    Caption = 'Length:'
  end
  object lDataCol: TLabel
    Left = 16
    Top = 203
    Width = 67
    Height = 13
    Caption = 'Bytes per row:'
  end
  object Label6: TLabel
    Left = 16
    Top = 171
    Width = 36
    Height = 13
    Caption = 'Length:'
  end
  object eSubName: TEdit
    Left = 88
    Top = 16
    Width = 185
    Height = 21
    MaxLength = 20
    TabOrder = 0
  end
  object eDescr: TEdit
    Left = 88
    Top = 48
    Width = 217
    Height = 21
    MaxLength = 255
    TabOrder = 1
  end
  object bOK: TButton
    Left = 64
    Top = 240
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object bCancel: TButton
    Left = 176
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object eAddress: TEdit
    Left = 88
    Top = 80
    Width = 113
    Height = 21
    MaxLength = 20
    TabOrder = 4
  end
  object eOffset: TEdit
    Left = 88
    Top = 112
    Width = 113
    Height = 21
    MaxLength = 20
    TabOrder = 5
  end
  object cbAcc16: TCheckBox
    Left = 88
    Top = 192
    Width = 153
    Height = 17
    Caption = '16 bit Accumulator (A)'
    TabOrder = 6
  end
  object cbInd16: TCheckBox
    Left = 88
    Top = 216
    Width = 169
    Height = 17
    Caption = '16-bit Index Registers (X/Y)'
    TabOrder = 7
  end
  object eDataCol: TEdit
    Left = 88
    Top = 200
    Width = 65
    Height = 21
    TabOrder = 8
  end
  object seBytes: TSpinEdit
    Left = 88
    Top = 144
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 9
    Value = 0
  end
  object seLines: TSpinEdit
    Left = 88
    Top = 168
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 10
    Value = 0
  end
end
