object FMTelefon: TFMTelefon
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1085#1090#1072#1082#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
  ClientHeight = 179
  ClientWidth = 240
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
  object Button1: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = #1054#1082
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 150
    Top = 146
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = Button2Click
  end
  object Phone1: TMaskEdit
    Left = 8
    Top = 8
    Width = 215
    Height = 21
    EditMask = '!\8(999\)000-0000;1;_'
    MaxLength = 14
    TabOrder = 0
    Text = '8(   )   -    '
    OnChange = Phone1Change
  end
  object Phone2: TMaskEdit
    Left = 8
    Top = 48
    Width = 215
    Height = 21
    Enabled = False
    EditMask = '!\8(999\)000-0000;1;_'
    MaxLength = 14
    TabOrder = 1
    Text = '8(   )   -    '
    OnChange = Phone2Change
  end
  object Phone3: TMaskEdit
    Left = 8
    Top = 88
    Width = 215
    Height = 21
    Enabled = False
    EditMask = '!\8(999\)000-0000;1;_'
    MaxLength = 14
    TabOrder = 2
    Text = '8(   )   -    '
    OnChange = Phone3Change
  end
end
