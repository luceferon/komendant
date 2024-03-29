unit ExportU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, ComObj,
  Vcl.Grids, ShellAPI, ShlObj, ActiveX;

type
  TFMExport = class(TForm)
    Button1: TButton;
    CheckListBox1: TCheckListBox;
    StringGrid4: TStringGrid;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DelStringFromGrid(const Value: string; Grid: TStringGrid);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMExport: TFMExport;

implementation

{$R *.dfm}
uses
  ZaselenieU;

procedure OpenFolderAndSelectFile(const folderPath, fileName: string);
var
  folderItem: IShellFolder;
  folderPidl: PItemIDList;
  filePidl: PItemIDList;
  folderPathWide, filePathWide: WideString;
begin
  folderPathWide := WideString(folderPath);
  filePathWide := WideString(folderPath + '\' + fileName);

  if Succeeded(SHGetDesktopFolder(folderItem)) then
  begin
    if Succeeded(folderItem.ParseDisplayName(0, nil, PWideChar(folderPathWide), ULONG(nil^), folderPidl, ULONG(nil^))) then
    begin
      if Succeeded(folderItem.ParseDisplayName(0, nil, PWideChar(filePathWide), ULONG(nil^), filePidl, ULONG(nil^))) then
      begin
        SHOpenFolderAndSelectItems(folderPidl, 1, @filePidl, 0);
        CoTaskMemFree(filePidl);
      end;
      CoTaskMemFree(folderPidl);
    end;
  end;
end;

procedure TFMExport.DelStringFromGrid(const Value: string; Grid: TStringGrid);
var
   RowIndex, i, j:integer;
begin
// ����� ������ � �������� ��������� � Grid
  RowIndex := -1;
  for i := Grid.RowCount - 1 downto 0 do
  begin
    if Grid.Cells[2, i] = Value then
    begin
      RowIndex := i;
      Break;
    end;
  end;

// ������� ��������� ������ �� Grid
  if RowIndex >= 0 then
  begin
    Grid.BeginUpdate;
    try
      for i := RowIndex to Grid.RowCount - 2 do
      begin
        for j := 0 to Grid.ColCount - 1 do
        begin
          Grid.Cells[j, i] := Grid.Cells[j, i + 1];
        end;
      end;
      Grid.RowCount := Grid.RowCount - 1;
    finally
      Grid.EndUpdate;
    end;
  end;
end;

procedure TFMExport.Button1Click(Sender: TObject);
const
  M = 7;
  N = 10;

  //��������� Excel.

  //������ �������� XlBordersIndex. ����� ������������ �����.
  //
  //����� �� ��������� ������ - ����.
  xlDiagonalDown = 5;
  //����� �� ��������� ����� - �����.
  xlDiagonalUp = 6;
  //�����, ����������� �������� �����.
  xlEdgeBottom = 9;
  //�����, ����������� �������� �����.
  xlEdgeLeft = 7;
  //�����, ����������� �������� ������.
  xlEdgeRight = 10;
  //�����, ����������� �������� ������.
  xlEdgeTop = 8;
  //��� �������������� ����� ������ ���������.
  xlInsideHorizontal = 12;
  //��� ������������ ����� ������ ���������.
  xlInsideVertical = 11;

  //������ �������� XlBorderWeight. ����� ����� �����.
  //
  //(_________) �����������.
  xlContinuous = 1;
  //(_ _ _ _ _) � ���� ������������������ ����.
  xlDash = -4115;
  //(_._._._._) � ���� ���� � �����.
  xlDashDot = 4;
  //(_.._.._..) � ���� ���� � ������� �����.
  xlDashDotDot = 5;
  //(.........) � ���� �����.
  xlDot = -4118;
  //(=========) � ���� ������� �����.
  xlDouble = -4119;
  //(         ) ���������� �����.
  xlLineStyleNone = -4142;
  //(/././././) � ���� ��������� ���� � �����.
  xlSlantDashDot = 13;

  //������ �������� XlBorderWeight. ����� ������� �����.
  //
  //����� ������.
  xlHairline = 1;
  //������
  xlThin = 2;
  //�������.
  xlMedium = -4138;
  //�������.
  xlThick = 4;
var
  Data1, Data3, Data4, Data: TStringGrid;
  ChooseColumns: array of Boolean;
  i, j, k, LastColumn, Column, iRow : Integer;
  ExcelApp, Sheet, Range: OleVariant;
  EmptyColumn: Boolean;
  folderPath, fileName: string;
begin
  // ������� ��������� ���������� ��� �������� ������
  Data1 := TStringGrid.Create(nil);
  Data3 := TStringGrid.Create(nil);
  Data4 := TStringGrid.Create(nil);
  try
    // �������� ���������� StringGrid1 � Data1
    Data1.RowCount := FMZaselenie.advStringGrid1.RowCount;
    Data1.ColCount := FMZaselenie.advStringGrid1.ColCount;
    for i := 0 to FMZaselenie.advStringGrid1.RowCount - 1 do
      for j := 0 to FMZaselenie.advStringGrid1.ColCount - 1 do
        Data1.Cells[j, i] := FMZaselenie.advStringGrid1.Cells[j, i];

    // �������� ���������� StringGrid3 � Data3
    Data3.RowCount := FMZaselenie.advStringGrid3.RowCount;
    Data3.ColCount := FMZaselenie.advStringGrid3.ColCount;
    for i := 0 to FMZaselenie.advStringGrid3.RowCount - 1 do
      for j := 0 to FMZaselenie.advStringGrid3.ColCount - 1 do
        Data3.Cells[j, i] := FMZaselenie.advStringGrid3.Cells[j, i];

    // ���������� ����� ������ ��������� ���������� Data4
    Data4.RowCount := Data1.RowCount + Data3.RowCount;
    Data4.ColCount := Data1.ColCount + Data3.ColCount;

    // �������� ���������� Data1 � Data4
    for i := 0 to Data1.RowCount - 1 do
      for j := 0 to Data1.ColCount - 1 do
        Data4.Cells[j, i] := Data1.Cells[j, i];

    // �������� ���������� Data3 � Data4
    for i := 0 to Data3.RowCount - 1 do
      for j := 0 to Data3.ColCount - 1 do
        Data4.Cells[j, i + Data1.RowCount] := Data3.Cells[j, i];

    // ��������� ���������� Data4 � StringGrid4
    StringGrid4.RowCount := Data4.RowCount;
    StringGrid4.ColCount := Data4.ColCount;
    for i := 0 to Data4.RowCount - 1 do
      for j := 0 to Data4.ColCount - 1 do
        StringGrid4.Cells[j, i] := Data4.Cells[j, i];

  //������� ������ ������
  DelStringFromGrid('���_����������', StringGrid4);
  DelStringFromGrid('', StringGrid4);
  DelStringFromGrid('����', StringGrid4);
  DelStringFromGrid('��� ����������', StringGrid4);
  DelStringFromGrid('������', StringGrid4);
  DelStringFromGrid('��� �����', StringGrid4);
  DelStringFromGrid('���', StringGrid4);
  DelStringFromGrid('������ �������������', StringGrid4);

  finally
    // ����������� ��������� ����������
    Data1.Free;
    Data3.Free;
    Data4.Free;
  end;

    // ������� ��������� ���������� Excel
  ExcelApp := CreateOleObject('Excel.Application');
  ExcelApp.Visible := True;

  // ��������� ����� �����
  ExcelApp.Workbooks.Add;

  // ������������ ���������� StringGrid1
  Data := StringGrid4;
  SetLength(ChooseColumns, Data.ColCount);


  // �������� ��������� ������� ��� �������� �� ComboBox1
  for k := 0 to CheckListBox1.Items.Count - 1 do
  begin
    if CheckListBox1.Checked[k] then
      ChooseColumns[k] := True
    else
      ChooseColumns[k] := False;
  end;

  Sheet := ExcelApp.Workbooks[1].WorkSheets[1];
  for i := 0 to Data.RowCount - 1 do
    for j := 2 to Data.ColCount - 1 do
      if ChooseColumns[j] then
        Sheet.Cells[i+1, j-1].Value := Data.Cells[j, i];

  //Rows:=ExcelApp.ActiveSheet.UsedRange.Rows.Count;
  //Columnss:=ExcelApp.ActiveSheet.UsedRange.Columns.Count;

  // ����������� ��������� ����������� �������
  Range := ExcelApp.ActiveSheet.UsedRange;
  LastColumn := Range.Columns.Count;

  // ������� ���� �������� � �������� �������
  for Column := LastColumn downto 1 do
  begin
    EmptyColumn := True;
    // ������� ���� ����� � ������� ��� �������� �� ������� ��������
    for iRow := 1 to Range.Rows.Count do
    begin
      if not VarIsEmpty(Range.Cells[iRow, Column].Value) then
      begin
        EmptyColumn := False;
        Break;
      end;
    end;
    // ���� ������� ������, �� ��� ����� �������
    if EmptyColumn then
      sheet.Columns[Column].Delete;
  end;

  //������� �������
  Range.rows.autofit;
  Range.Columns.AutoFit;
  ExcelApp.rows[1].Font.Bold:=true;
  Range.Borders[xlInsideHorizontal].LineStyle := xlContinuous;
  Range.Borders[xlInsideHorizontal].Weight := xlThin;
  Range.Borders[xlInsideVertical].LineStyle := xlContinuous;
  Range.Borders[xlInsideVertical].Weight := xlThin;
  //���������� ��������� ��������� ��������� �������� �������.
  Range.Borders[xlEdgeTop].LineStyle := xlContinuous;
  Range.Borders[xlEdgeTop].Weight := xlThick;
  Range.Borders[xlEdgeBottom].LineStyle := xlContinuous;
  Range.Borders[xlEdgeBottom].Weight := xlThick;
  Range.Borders[xlEdgeLeft].LineStyle := xlContinuous;
  Range.Borders[xlEdgeLeft].Weight := xlThick;
  Range.Borders[xlEdgeRight].LineStyle := xlContinuous;
  Range.Borders[xlEdgeRight].Weight := xlThick;


    // ��������� ����
  if not DirectoryExists('C:\���������\') then
    CreateDir('C:\���������\');
  ExcelApp.Workbooks[1].SaveAs('C:\���������\���������� ������� '+Uchastok+'.xlsx');
  ExcelApp.Workbooks[1].Close;
  ExcelApp.Quit;
  ShowMessage('���� �������� �� ����� C:\���������\���������� ������� '+Uchastok);

  // ������� ���� � ����� � ��� �����, ������� ����� ��������
  folderPath := 'C:\���������';
  fileName := '���������� ������� '+Uchastok+'.xlsx';

  OpenFolderAndSelectFile(folderPath, fileName);

  Close;
end;

procedure TFMExport.Button2Click(Sender: TObject);
begin
  close;
end;

end.
