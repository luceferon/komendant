object FMDel: TFMDel
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = #1042#1099#1089#1077#1083#1077#1085#1080#1077
  ClientHeight = 163
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 21
    Width = 128
    Height = 13
    Caption = #1042#1077#1088#1080#1090#1077' '#1086#1090#1082#1091#1076#1072' '#1074#1099#1089#1077#1083#1080#1090#1100
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 128
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1086#1075#1086' '#1074#1099#1089#1077#1083#1080#1090#1100
  end
  object CBOtkuda: TComboBox
    Left = 8
    Top = 40
    Width = 185
    Height = 21
    AutoCloseUp = True
    ExtendedUI = True
    TabOrder = 1
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1084#1077#1089#1090#1086' '#1087#1088#1086#1078#1080#1074#1072#1085#1080#1103
    OnChange = CBOtkudaChange
    Items.Strings = (
      #1041#1072#1083#1082#1080
      #1054#1073#1097#1072#1075#1072)
  end
  object CBKogo: TComboBox
    Left = 8
    Top = 88
    Width = 255
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = #1060#1048#1054' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103
  end
  object Button1: TButton
    Left = 8
    Top = 115
    Width = 75
    Height = 25
    Caption = #1054#1082
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 188
    Top = 115
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 0
    OnClick = Button2Click
  end
  object UniQuery1: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      'SELECT * FROM balki')
    Left = 144
    Top = 112
  end
  object UniQuery2: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      'SELECT * FROM itr')
    Left = 88
    Top = 112
  end
end
