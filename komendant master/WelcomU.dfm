object FMWelcom: TFMWelcom
  Left = 0
  Top = 0
  Caption = #1050#1086#1084#1084#1077#1085#1076#1072#1085#1090
  ClientHeight = 288
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 34
    Top = 8
    Width = 168
    Height = 15
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1078#1077#1083#1072#1077#1084#1086#1077' '#1076#1077#1081#1089#1090#1074#1080#1077':'
  end
  object Button1: TButton
    Left = 43
    Top = 29
    Width = 150
    Height = 40
    Caption = #1047#1072#1089#1077#1083#1080#1090#1100' '#1095#1077#1083#1086#1074#1077#1082#1072
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 43
    Top = 75
    Width = 150
    Height = 40
    Caption = #1042#1099#1089#1080#1083#1080#1090#1100' '#1095#1077#1083#1086#1074#1077#1082#1072
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 43
    Top = 121
    Width = 150
    Height = 40
    Caption = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1079#1072#1089#1077#1083#1077#1085#1085#1099#1093
    TabOrder = 0
    WordWrap = True
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 43
    Top = 240
    Width = 150
    Height = 40
    Caption = #1042#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
    TabOrder = 3
    WordWrap = True
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 43
    Top = 167
    Width = 150
    Height = 40
    Caption = #1055#1077#1088#1077#1089#1077#1083#1077#1085#1080#1077' '#1095#1077#1083#1086#1074#1077#1082#1072
    TabOrder = 4
    WordWrap = True
    OnClick = Button5Click
  end
  object UniConnection1: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    Left = 177
    Top = 208
  end
end
