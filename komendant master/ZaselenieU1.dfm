object FMZaselenie: TFMZaselenie
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1086#1082' '#1079#1072#1089#1077#1083#1077#1085#1080#1103
  ClientHeight = 536
  ClientWidth = 853
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  DefaultMonitor = dmPrimary
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 853
    Height = 456
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    OnChanging = PageControl1Changing
    object TabSheet1: TTabSheet
      Caption = #1041#1072#1083#1082#1080
      OnShow = TabSheet1Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 845
        Height = 426
        Align = alClient
        Color = clBtnFace
        DefaultColAlignment = taCenter
        DoubleBuffered = False
        DrawingStyle = gdsGradient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goFixedRowDefAlign]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 0
        OnDblClick = StringGrid1DblClick
        OnDrawCell = StringGrid1DrawCell
        OnSelectCell = StringGrid1SelectCell
        RowHeights = (
          24
          24
          24
          24
          24)
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1048#1058#1056
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StringGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 845
        Height = 426
        Align = alClient
        Color = clBtnFace
        DefaultColAlignment = taCenter
        DoubleBuffered = False
        DrawingStyle = gdsGradient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goFixedRowDefAlign]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 0
        OnDblClick = StringGrid2DblClick
        RowHeights = (
          24
          24
          24
          24
          24)
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1054#1073#1097#1072#1075#1072
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StringGrid3: TStringGrid
        Left = 0
        Top = 0
        Width = 845
        Height = 426
        Align = alClient
        Color = clBtnFace
        DefaultColAlignment = taCenter
        DoubleBuffered = False
        DrawingStyle = gdsGradient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goFixedRowDefAlign]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 0
        OnDblClick = StringGrid3DblClick
        OnDrawCell = StringGrid3DrawCell
        OnSelectCell = StringGrid3SelectCell
        RowHeights = (
          24
          24
          24
          24
          24)
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 456
    Width = 853
    Height = 80
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      853
      80)
    object Label1: TLabel
      Left = 424
      Top = 2
      Width = 104
      Height = 15
      Caption = #1055#1086#1080#1089#1082' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072':'
    end
    object Button1: TButton
      Left = 753
      Top = 18
      Width = 80
      Height = 35
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 155
      Top = 2
      Width = 205
      Height = 35
      Caption = #1055#1077#1095#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1076#1083#1103' '#1086#1090#1087#1091#1089#1082#1072
      TabOrder = 1
      OnClick = Button2Click
    end
    object Edit1: TEdit
      Left = 424
      Top = 23
      Width = 289
      Height = 23
      AutoSelect = False
      TabOrder = 2
      OnChange = Edit1Change
    end
    object Button3: TButton
      Left = 4
      Top = 2
      Width = 145
      Height = 35
      Caption = #1069#1082#1089#1087#1086#1088#1090'  '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 4
      Top = 43
      Width = 356
      Height = 25
      Caption = #1055#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1080' '#1087#1077#1095#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1085#1072' '#1047#1055' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
      TabOrder = 4
      OnClick = Button4Click
    end
  end
  object UniQuery1: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      'SELECT * FROM balki')
    Left = 592
    Top = 64
  end
  object UniQuery2: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      'SELECT * FROM itr')
    Left = 592
    Top = 160
  end
  object UniQuery3: TUniQuery
    Connection = FMWelcom.UniConnection1
    SQL.Strings = (
      'SELECT * FROM obchaga')
    Left = 592
    Top = 112
  end
end
