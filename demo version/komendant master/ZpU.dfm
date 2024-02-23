object FMZP: TFMZP
  Left = 0
  Top = 0
  Caption = 'FMZP'
  ClientHeight = 582
  ClientWidth = 902
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
  object AdvStringGrid1: TAdvStringGrid
    Left = 0
    Top = 0
    Width = 902
    Height = 528
    Cursor = crDefault
    Align = alClient
    Color = clWhite
    DrawingStyle = gdsClassic
    Options = [goVertLine, goHorzLine, goRangeSelect, goFixedRowDefAlign]
    ScrollBars = ssBoth
    TabOrder = 0
    GridLineColor = 15987699
    GridFixedLineColor = 15987699
    HoverRowCells = [hcNormal, hcSelected]
    OnCheckBoxChange = AdvStringGrid1CheckBoxChange
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HoverButtons.Position = hbLeftFromColumnLeft
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.AlwaysHighLight = True
    SearchFooter.ColorTo = clWhite
    SearchFooter.FindNextCaption = #1055#1086#1080#1089#1082' '#1074#1087#1077#1088#1077#1076
    SearchFooter.FindPrevCaption = #1055#1086#1080#1089#1082' '#1085#1072#1079#1072#1076
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = #1055#1086#1089#1074#1077#1095#1080#1074#1072#1090#1100
    SearchFooter.HintClose = #1057#1087#1088#1103#1090#1072#1090#1100
    SearchFooter.HintFindNext = #1055#1086#1080#1089#1082' '#1074#1087#1077#1088#1077#1076
    SearchFooter.HintFindPrev = #1055#1086#1080#1089#1082' '#1085#1072#1079#1072#1076
    SearchFooter.HintHighlight = #1055#1086#1089#1074#1077#1095#1080#1074#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
    SearchFooter.MatchCaseCaption = #1058#1086#1095#1085#1086#1077' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1077
    SearchFooter.ResultFormat = '(%d of %d)'
    SearchFooter.ShowClose = False
    SearchFooter.ShowHighLight = False
    SearchFooter.ShowResults = True
    SearchFooter.ShowMatchCase = False
    SearchFooter.Visible = True
    SortSettings.DefaultFormat = ssAutomatic
    Version = '8.4.7.0'
  end
  object Panel1: TPanel
    Left = 0
    Top = 528
    Width = 902
    Height = 54
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 432
      Top = 16
      Width = 3
      Height = 13
    end
    object Button1: TButton
      Left = 800
      Top = 6
      Width = 75
      Height = 35
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 0
      Top = 6
      Width = 225
      Height = 43
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1090#1089#1091#1089#1090#1074#1091#1102#1097#1077#1075#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object StringGrid1: TStringGrid
    Left = 549
    Top = 24
    Width = 345
    Height = 367
    TabOrder = 2
    Visible = False
  end
end
