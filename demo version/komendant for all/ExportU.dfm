object FMExport: TFMExport
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1069#1082#1089#1087#1086#1088#1090' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
  ClientHeight = 132
  ClientWidth = 177
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 100
    Width = 75
    Height = 25
    Caption = #1069#1082#1089#1087#1086#1088#1090
    TabOrder = 0
    OnClick = Button1Click
  end
  object CheckListBox1: TCheckListBox
    Left = 8
    Top = -24
    Width = 156
    Height = 118
    ItemHeight = 13
    Items.Strings = (
      ''
      ''
      #1060#1048#1054
      #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      #1044#1072#1090#1072' '#1079#1072#1077#1079#1076#1072' ('#1086#1090#1087#1091#1089#1082#1072')'
      #1055#1088#1086#1092#1077#1089#1089#1080#1103
      #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      #1058#1077#1083#1077#1092#1086#1085#1099)
    TabOrder = 1
  end
  object StringGrid4: TStringGrid
    Left = 136
    Top = 8
    Width = 33
    Height = 30
    TabOrder = 2
    Visible = False
  end
  object Button2: TButton
    Left = 89
    Top = 100
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
end
