object FMPereselenie: TFMPereselenie
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = #1055#1077#1088#1077#1089#1077#1083#1077#1085#1080#1077' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
  ClientHeight = 158
  ClientWidth = 376
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
    Top = 8
    Width = 142
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1086#1090#1082#1091#1076#1072' '#1074#1099#1089#1077#1083#1080#1090#1100
  end
  object Label2: TLabel
    Left = 8
    Top = 61
    Width = 128
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1086#1075#1086' '#1074#1099#1089#1077#1083#1080#1090#1100
  end
  object Label3: TLabel
    Left = 192
    Top = 61
    Width = 172
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1086#1084#1085#1072#1090#1091' '#1076#1083#1103' '#1079#1072#1089#1077#1083#1077#1085#1080#1103
  end
  object Label4: TLabel
    Left = 192
    Top = 8
    Width = 127
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1091#1076#1072' '#1079#1072#1089#1077#1083#1080#1090#1100
  end
  object CBOtkuda: TComboBox
    Left = 8
    Top = 32
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'CBOtkuda'
    OnChange = CBOtkudaChange
    Items.Strings = (
      #1041#1072#1083#1082#1080
      #1054#1073#1097#1072#1075#1072)
  end
  object CBKogo: TComboBox
    Left = 8
    Top = 80
    Width = 145
    Height = 21
    Enabled = False
    TabOrder = 1
    Text = 'CBKogo'
    OnChange = CBKogoChange
  end
  object CBKuda1: TComboBox
    Left = 192
    Top = 32
    Width = 172
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = 'CBKuda1'
    OnChange = CBKuda1Change
    Items.Strings = (
      #1041#1072#1083#1082#1080
      #1054#1073#1097#1072#1075#1072)
  end
  object CBKomnata: TComboBox
    Left = 192
    Top = 80
    Width = 172
    Height = 21
    Enabled = False
    TabOrder = 3
    Text = 'CBKomnata'
    OnChange = CBKomnataChange
  end
  object Button1: TButton
    Left = 48
    Top = 120
    Width = 75
    Height = 25
    Caption = #1054#1082
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 120
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = Button2Click
  end
  object UniQuery1: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      'SELECT * FROM balki')
    Left = 328
    Top = 104
  end
  object UniQuery2: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      'SELECT * FROM balki')
    Left = 176
    Top = 104
  end
end
