object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 793
  ClientWidth = 701
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 701
    Height = 732
    Align = alClient
    MultiLine = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 732
    Width = 701
    Height = 61
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    object Button2: TButton
      Left = 95
      Top = 7
      Width = 82
      Height = 50
      Caption = 'Button2'
      TabOrder = 0
    end
    object Button1: TButton
      Left = 8
      Top = 14
      Width = 81
      Height = 47
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1080#1085#1074'. '#1085#1086#1084#1077#1088#1072
      TabOrder = 1
      WordWrap = True
      OnClick = Button1Click
    end
  end
  object UniConnection1: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    Left = 600
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 600
    Top = 48
  end
end
