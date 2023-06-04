object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 87
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object StaticText1: TStaticText
    Left = 80
    Top = 8
    Width = 173
    Height = 26
    Caption = 'ENTER YOUR NAME'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Montserrat ExtraBold'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 160
    Top = 46
    Width = 73
    Height = 25
    Caption = 'Add'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 239
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object DBEdit_Score: TDBEdit
    Left = 112
    Top = 72
    Width = 42
    Height = 23
    DataField = 'Score'
    DataSource = Form1.DataSource1
    TabOrder = 4
    Visible = False
  end
  object DBEdit_Name: TDBEdit
    Left = 8
    Top = 47
    Width = 137
    Height = 23
    DataField = 'Name'
    DataSource = Form1.DataSource1
    TabOrder = 1
  end
end
