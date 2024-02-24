object FMDokument: TFMDokument
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = #1059#1090#1086#1095#1085#1077#1085#1080#1077' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
  ClientHeight = 301
  ClientWidth = 223
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
    Width = 185
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1083'-'#1074#1086' '#1086#1090#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1076#1085#1077#1081
  end
  object Label2: TLabel
    Left = 45
    Top = 78
    Width = 115
    Height = 13
    Caption = #1057' '#1082#1072#1082#1086#1075#1086' '#1095#1080#1089#1083#1072' '#1086#1090#1087#1091#1089#1082
  end
  object Label3: TLabel
    Left = 45
    Top = 124
    Width = 116
    Height = 13
    Caption = #1055#1086' '#1082#1072#1082#1086#1077' '#1095#1080#1089#1083#1086' '#1086#1090#1087#1091#1089#1082
  end
  object DniEdit: TEdit
    Left = 40
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 268
    Width = 75
    Height = 25
    Caption = #1054#1082
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 140
    Top = 268
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = Button2Click
  end
  object DPOtpuskNachalo: TDatePicker
    Left = 56
    Top = 97
    Width = 97
    Height = 21
    Date = 45060.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 3
  end
  object DPOtpuskKonec: TDatePicker
    Left = 56
    Top = 143
    Width = 97
    Height = 21
    Date = 45060.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 4
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 54
    Width = 169
    Height = 17
    Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1085#1072' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1077'?'
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 170
    Width = 177
    Height = 92
    Caption = #1050#1072#1082#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1087#1077#1095#1072#1090#1072#1090#1100':'
    TabOrder = 6
    object CBObhodnoy: TCheckBox
      Left = 16
      Top = 24
      Width = 145
      Height = 17
      Caption = #1054#1073#1093#1086#1076#1085#1086#1081' '#1083#1080#1089#1090
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CBOtpusk: TCheckBox
      Left = 16
      Top = 47
      Width = 145
      Height = 17
      Caption = #1047#1072#1103#1074#1083#1077#1085#1080#1077' '#1085#1072' '#1086#1090#1087#1091#1089#1082
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CBDengi: TCheckBox
      Left = 16
      Top = 70
      Width = 137
      Height = 17
      Caption = #1047#1072#1103#1074#1083#1077#1085#1080#1077' '#1085#1072' '#1076#1077#1085#1100#1075#1080
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
end
