object FMNew: TFMNew
  Left = 0
  Top = 0
  Caption = #1047#1072#1089#1077#1083#1077#1085#1080#1077
  ClientHeight = 299
  ClientWidth = 566
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
    Width = 127
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1091#1076#1072' '#1079#1072#1089#1077#1083#1080#1090#1100
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 168
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1041#1072#1083#1082#1072'('#1082#1086#1084#1085#1072#1090#1099')'
  end
  object Label3: TLabel
    Left = 8
    Top = 119
    Width = 191
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1060#1048#1054' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
  end
  object Label4: TLabel
    Left = 8
    Top = 165
    Width = 109
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091' '#1079#1072#1077#1079#1076#1072
  end
  object Label5: TLabel
    Left = 8
    Top = 211
    Width = 102
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
  end
  object Label6: TLabel
    Left = 178
    Top = 165
    Width = 196
    Height = 13
    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081'. '#1053#1072#1087#1088#1080#1084#1077#1088': '#1042#1072#1093#1090#1072' - '#1044#1077#1085#1100
  end
  object Label7: TLabel
    Left = 248
    Top = 8
    Width = 310
    Height = 13
    Caption = #1042' '#1074#1099#1073#1088#1072#1085#1085#1086#1084' '#1073#1072#1083#1082#1077'('#1082#1086#1084#1085#1072#1090#1077') '#1085#1072' '#1076#1072#1085#1085#1099#1081' '#1084#1086#1084#1077#1085#1090' '#1087#1088#1086#1078#1080#1074#1072#1102#1090':'
  end
  object Label8: TLabel
    Left = 483
    Top = 119
    Width = 6
    Height = 13
    Caption = '8'
  end
  object Label9: TLabel
    Left = 248
    Top = 119
    Width = 212
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1084#1077#1089#1090' '#1074' '#1074#1099#1073#1088#1072#1085#1085#1086#1084' '#1073#1072#1083#1082#1077'('#1082#1086#1084#1085#1072#1090#1077')'
  end
  object Label10: TLabel
    Left = 178
    Top = 211
    Width = 120
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
  end
  object Label11: TLabel
    Left = 8
    Top = 251
    Width = 163
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1085#1090#1072#1082#1090#1085#1099#1077' '#1090#1077#1083#1077#1092#1086#1085#1099
  end
  object CBkuda: TComboBox
    Left = 8
    Top = 27
    Width = 145
    Height = 21
    TabOrder = 0
    Text = #1041#1072#1083#1082#1080', '#1086#1073#1097#1072#1075#1072' '#1080#1083#1080' '#1048#1058#1056
    OnChange = CBkudaChange
    Items.Strings = (
      #1041#1072#1083#1082#1080
      #1054#1073#1097#1072#1075#1072)
  end
  object CBnomer: TComboBox
    Left = 8
    Top = 73
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 1
    OnChange = CBnomerChange
  end
  object Efio: TEdit
    Left = 8
    Top = 138
    Width = 550
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = #1060#1048#1054
    OnChange = EfioChange
    OnClick = EfioClick
  end
  object DPzaezd: TDatePicker
    Left = 8
    Top = 184
    Width = 121
    Height = 21
    Date = 45037.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxYear = 2040
    MinYear = 2023
    TabOrder = 3
  end
  object CBprof: TComboBox
    Left = 8
    Top = 230
    Width = 145
    Height = 21
    Enabled = False
    TabOrder = 4
    Text = #1044#1086#1083#1078#1085#1086#1089#1090#1100
    OnChange = CBprofChange
    Items.Strings = (
      #1052#1072#1096#1080#1085#1080#1089#1090' '#1073#1091#1083#1100#1076#1086#1079#1077#1088#1072
      #1052#1072#1096#1080#1085#1080#1089#1090' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072
      #1043#1086#1088#1085#1099#1081' '#1084#1072#1089#1090#1077#1088
      #1057#1083#1077#1089#1072#1088#1100'-'#1088#1077#1084#1086#1085#1090#1085#1080#1082
      #1042#1072#1083#1100#1097#1080#1082
      #1042#1086#1076#1080#1090#1077#1083#1100
      #1043#1080#1076#1088#1086#1084#1086#1085#1080#1090#1086#1088#1097#1080#1082
      #1050#1091#1093'. '#1056#1072#1073#1086#1095#1080#1081
      #1042#1086#1076#1080#1090#1077#1083#1100' '#1087#1086#1075#1088#1091#1079#1095#1080#1082#1072
      #1057#1074#1072#1088#1097#1080#1082
      #1043#1086#1089#1090#1100
      #1055#1086#1074#1072#1088
      #1042#1086#1076#1080#1090#1077#1083#1100' '#1040#1058#1047
      #1052#1086#1090#1086#1088#1080#1089#1090
      #1058#1086#1082#1072#1088#1100
      #1050#1083#1072#1076#1086#1074#1097#1080#1082' '#1043#1057#1052
      #1050#1083#1072#1076#1086#1074#1097#1080#1082' '#1058#1052#1062
      #1043#1077#1086#1083#1086#1075
      #1052#1072#1088#1082#1096#1077#1081#1076#1077#1088
      #1057#1090#1072#1088#1096#1080#1081' '#1087#1086#1074#1072#1088
      #1042#1086#1076#1080#1090#1077#1083#1100' '#1082#1088#1072#1085#1072)
  end
  object Ecomment: TEdit
    Left = 178
    Top = 184
    Width = 196
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object ListBox1: TListBox
    Left = 248
    Top = 27
    Width = 310
    Height = 86
    Enabled = False
    ItemHeight = 13
    TabOrder = 8
  end
  object Button1: TButton
    Left = 483
    Top = 211
    Width = 75
    Height = 25
    Caption = #1047#1072#1089#1077#1083#1080#1090#1100
    Enabled = False
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 483
    Top = 266
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 7
    OnClick = Button2Click
  end
  object CBOrganization: TComboBox
    Left = 178
    Top = 230
    Width = 196
    Height = 21
    Enabled = False
    TabOrder = 9
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1102
    Items.Strings = (
      #1054#1054#1054' "'#1045#1076#1072'"'
      #1054#1054#1054' "'#1040'-'#1057#1077#1088#1074#1080#1089'"'
      #1054#1054#1054' "'#1057#1087#1077#1094#1087#1086#1076#1088#1103#1076'"'
      #1054#1054#1054' "'#1050#1086#1084#1087#1083#1077#1082#1090#1089#1077#1088#1074#1080#1089'"'
      #1054#1054#1054' "'#1057#1080#1089#1080#1084'"'
      #1054#1054#1054' "'#1052#1086#1090#1086#1088#1089#1077#1088#1074#1080#1089'"')
  end
  object Phone1: TMaskEdit
    Left = 8
    Top = 270
    Width = 119
    Height = 21
    Enabled = False
    EditMask = '!\8(999\)000-0000;1;_'
    MaxLength = 14
    TabOrder = 10
    Text = '8(   )   -    '
    OnChange = Phone1Change
  end
  object Phone2: TMaskEdit
    Left = 135
    Top = 270
    Width = 119
    Height = 21
    Enabled = False
    EditMask = '!\8(999\)000-0000;1;_'
    MaxLength = 14
    TabOrder = 11
    Text = '8(   )   -    '
    OnChange = Phone2Change
  end
  object Phone3: TMaskEdit
    Left = 262
    Top = 270
    Width = 119
    Height = 21
    Enabled = False
    EditMask = '!\8(999\)000-0000;1;_'
    MaxLength = 14
    TabOrder = 12
    Text = '8(   )   -    '
    OnChange = Phone3Change
  end
  object UniQuery1: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      '')
    Left = 432
    Top = 256
  end
  object UniQuery2: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      '')
    Left = 432
    Top = 216
  end
  object UniQuery3: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      '')
    Left = 432
    Top = 176
  end
end
