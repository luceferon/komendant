object FMOrganization: TFMOrganization
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
  ClientHeight = 45
  ClientWidth = 410
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 225
    Height = 21
    TabOrder = 0
    Text = #1053#1072#1079#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
    OnChange = ComboBox1Change
    Items.Strings = (
      #1054#1054#1054' "'#1045#1076#1072'"'
      #1054#1054#1054' "'#1040'-'#1057#1077#1088#1074#1080#1089'"'
      #1054#1054#1054' "'#1057#1087#1077#1094#1087#1086#1076#1088#1103#1076'"'
      #1054#1054#1054' "'#1050#1086#1084#1087#1083#1077#1082#1090#1089#1077#1088#1074#1080#1089'"'
      #1054#1054#1054' "'#1057#1080#1089#1080#1084'"'
      #1054#1054#1054' "'#1052#1086#1090#1086#1088#1089#1077#1088#1074#1080#1089'"')
  end
  object Button1: TButton
    Left = 239
    Top = 8
    Width = 75
    Height = 25
    Caption = #1054#1082
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 320
    Top = 8
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = Button2Click
  end
end
