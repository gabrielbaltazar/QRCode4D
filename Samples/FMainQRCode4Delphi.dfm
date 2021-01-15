object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgQrCode: TImage
    Left = 416
    Top = 16
    Width = 209
    Height = 105
    Center = True
    Proportional = True
  end
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 22
    Height = 13
    Caption = 'Text'
  end
  object mmoBase64: TMemo
    Left = 0
    Top = 136
    Width = 635
    Height = 163
    Align = alBottom
    Lines.Strings = (
      'mmoBase64')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object edtText: TEdit
    Left = 8
    Top = 32
    Width = 345
    Height = 21
    TabOrder = 1
    Text = 'https://github.com/gabrielbaltazar'
  end
end
