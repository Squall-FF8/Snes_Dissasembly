object fmParam: TfmParam
  Left = 796
  Top = 401
  BorderStyle = bsDialog
  Caption = 'Add New Memory Location'
  ClientHeight = 213
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 43
    Height = 13
    Caption = 'Address:'
  end
  object Label2: TLabel
    Left = 16
    Top = 91
    Width = 60
    Height = 13
    Caption = 'Short Name:'
  end
  object Label3: TLabel
    Left = 40
    Top = 40
    Width = 257
    Height = 25
    AutoSize = False
    Caption = 
      'Address in memory. Use digits for integers values. Start with $ ' +
      'for hexadecimal values.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 40
    Top = 112
    Width = 257
    Height = 25
    AutoSize = False
    Caption = 
      'The short name will be used in the disassembly to replace known ' +
      'addresses.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object eAddress: TEdit
    Left = 88
    Top = 16
    Width = 137
    Height = 21
    MaxLength = 20
    TabOrder = 0
    OnKeyPress = eAddressKeyPress
  end
  object eName: TEdit
    Left = 88
    Top = 88
    Width = 193
    Height = 21
    MaxLength = 255
    TabOrder = 1
    OnKeyPress = eAddressKeyPress
  end
  object bOK: TButton
    Left = 64
    Top = 170
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object bCancel: TButton
    Left = 176
    Top = 170
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
