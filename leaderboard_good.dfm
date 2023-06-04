object Form3: TForm3
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsDialog
  Caption = 'Saving'
  ClientHeight = 85
  ClientWidth = 270
  Color = 2105376
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object DBEdit_Score: TDBEdit
    Left = 184
    Top = 64
    Width = 121
    Height = 23
    TabOrder = 1
    Visible = False
  end
  object DBEdit_Name: TDBEdit
    Left = 72
    Top = 48
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object StaticText1: TStaticText
    Left = 42
    Top = 8
    Width = 186
    Height = 33
    Caption = 'Enter your name'
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
  end
end
