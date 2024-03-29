unit ZpU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ComCtrls,
  Vcl.StdCtrls, AdvUtil, AdvObj, BaseGrid, AdvGrid, ComObj;

type
  TFMZP = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Button1: TButton;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Button2: TButton;
    Label1: TLabel;
    procedure DelStringFromGrid(const Value: string; Grid: TAdvStringGrid);
    procedure DelStringFromGrid2(const Value: string; Grid: TStringGrid);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure UpdateLabel;
    procedure AdvStringGrid1CheckBoxChange(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMZP: TFMZP;

implementation

{$R *.dfm}

uses
   ZaselenieU;

   //���������� ���������� �������������� � ������
procedure TFMZP.Button2Click(Sender: TObject);
var
  newrow:integer;
begin
  AdvStringGrid1.AddRow;
  newRow := AdvStringGrid1.RowCount - 1;
  advStringGrid1.Cells[0, newRow] := IntToStr(newRow);
  AdvStringGrid1.AddCheckBox(4,newrow,false,false);
end;

procedure TFMZP.CheckBox1Click(Sender: TObject);
begin

end;

//�������� ������ ���������� ����� Value
procedure TFMZP.DelStringFromGrid(const Value: string; Grid: TAdvStringGrid);
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

procedure TFMZP.DelStringFromGrid2(const Value: string; Grid: TStringGrid);
var
   RowIndex, i, j:integer;
begin
// ����� ������ � �������� ��������� � Grid
  RowIndex := -1;
  for i := Grid.RowCount - 1 downto 0 do
  begin
    if Grid.Cells[0, i] = Value then
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
      for i := RowIndex to Grid.RowCount - 1 do
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


function StringGrid_DeleteCol(SG : TStringGrid; ACol : integer) : boolean;
//������� �������� ������� �� TStringGrid
//SG - ���������� ���� TStringGrid
//ACol - ����� (������ �������, ������� � ����), ������� ����� �������
//������������ �������� - ��������� ��������
Var
  N1,N2,i : integer;
begin
  Result:=FALSE;
  if SG<>NIL then begin
     N1:=ACol;
     N2:=(SG.ColCount-2);
     if (SG.ColCount-1)>SG.FixedCols then begin
        for i:=N1 to N2 do
         begin
           SG.Cols[i].Assign(SG.Cols[i+1]);
        end;
        SG.Cols[SG.ColCount-1].Clear;
        SG.ColCount:=SG.ColCount-1;
        Result:=TRUE;
     end
     else begin
        SG.Cols[SG.FixedCols].Clear;
        Result:=TRUE;
     end;
  end;
end;

function advStringGrid_DeleteRow(SG : TAdvStringGrid; ARow : integer) : boolean;
//������� �������� ������ �� TStringGrid
//SG - ���������� ���� TStringGrid
//ARow - ����� (������ ������, ������� � ����), ������� ����� �������
//������������ �������� - ��������� ��������
Var
  N1,N2,i : integer;
begin
  Result:=FALSE;
  if SG<>NIL then begin
     N1:=ARow;
     N2:=(SG.RowCount-2);
     if (SG.RowCount-1)>SG.FixedRows then begin
        for i:=N1 to N2 do
         begin
           SG.Rows[i].Assign(SG.Rows[i+1]);
        end;
        SG.Rows[SG.RowCount-1].Clear;
        SG.RowCount:=SG.RowCount-1;
        Result:=TRUE;
     end
     else begin
        SG.Rows[SG.FixedRows].Clear;
        Result:=TRUE;
     end;
  end;
end;

function StringGrid_DeleteRow1(SG : TStringGrid; ARow : integer) : boolean;
//������� �������� ������ �� TStringGrid
//SG - ���������� ���� TStringGrid
//ARow - ����� (������ ������, ������� � ����), ������� ����� �������
//������������ �������� - ��������� ��������
Var
  N1,N2,i : integer;
begin
  Result:=FALSE;
  if SG<>NIL then begin
     N1:=ARow;
     N2:=(SG.RowCount-2);
     if (SG.RowCount-1)>SG.FixedRows then begin
        for i:=N1 to N2 do
         begin
           SG.Rows[i].Assign(SG.Rows[i+1]);
        end;
        SG.Rows[SG.RowCount-1].Clear;
        SG.RowCount:=SG.RowCount-1;
        Result:=TRUE;
     end
     else begin
        SG.Rows[SG.FixedRows].Clear;
        Result:=TRUE;
     end;
  end;
end;

//����� ��������� � ��������
procedure RemoveDuplicates(Grid: TadvStringGrid);
var
  i, j: Integer;
begin
  for i := Grid.RowCount - 1 downto 1 do
  begin
    for j := i - 1 downto 0 do
    begin
      if Grid.Cells[1, i] = Grid.Cells[1, j] then
      begin
        advStringGrid_DeleteRow(grid,i);
        Break;
      end;
    end;
  end;
end;

//������� � ����� ���-�� ��������� �����������
//����� 1 ����� 42 ��������
procedure TFMZP.UpdateLabel;
var
  i, count: Integer;
begin
  count := 0;
  for i := 1 to AdvStringGrid1.RowCount do
  begin
    if AdvStringGrid1.IsChecked(4, i) then
      Inc(count);
  end;
  Label1.Caption := '�������� ����������� '+IntToStr(count);
  if count>42 then
  begin
    Label1.Font.Color:=clRed;
    Label1.Font.Height:=20;
  end
  else
  begin
    Label1.Font.Color:=clWindowText;
    Label1.Font.Height:=11;
  end;
end;

procedure TFMZP.FormShow(Sender: TObject);
var
  Data1, Data3, Data4: TStringGrid;
  i, j, q, PO : Integer;
begin
  UpdateLabel;
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
    AdvStringGrid1.RowCount := Data4.RowCount;
    AdvStringGrid1.ColCount := Data4.ColCount;
    for i := 0 to Data4.RowCount - 1 do
      for j := 0 to Data4.ColCount - 1 do
      begin
        AdvStringGrid1.Cells[j, i] := Data4.Cells[j, i];
        //������ ��������
        with AdvStringGrid1 do
        begin
          Options:= Options+[goediting];
          AddCheckBoxColumn(9);
          AddCheckBox(9,i,false,false);
          MouseActions.CheckAllCheck:=true;
        end;
      end;

  finally
    // ����������� ��������� ����������
    Data1.Free;
    Data3.Free;
    Data4.Free;
  end;
  //������� ��� ��� � �������
  for q := 1 to advStringGrid1.RowCount  do // ���������� ��� ������ ����� ���������
    if Pos('������', advStringGrid1.Cells[3, q]) > 0 then // ���� � ������ ������� "�����������" ���������� ����� "������"
      advStringGrid_DeleteRow(advStringGrid1, q);
  //������� ������ ������
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('����', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('��� ����������', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('������', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('��� �����', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('���', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('������ �������������', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('�����', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);
  for q := 1 to advStringGrid1.RowCount  do
    if Pos('���_����������', advStringGrid1.Cells[2, q]) > 0 then
      advStringGrid_DeleteRow(advStringGrid1, q);

  //������� ������ �������
  StringGrid_DeleteCol(advStringGrid1, 1);
  StringGrid_DeleteCol(advStringGrid1, 2);
  StringGrid_DeleteCol(advStringGrid1, 2);
  StringGrid_DeleteCol(advStringGrid1, 3);
  StringGrid_DeleteCol(advStringGrid1, 3);

  //��������� ������� �����
  advStringGrid1.Cells[3, 0]:='�����';
  for q := 1 to advStringGrid1.RowCount - 1 do
    advStringGrid1.Cells[3, q] := '100%';

  //������� ��������� ���� ����
  RemoveDuplicates(advStringGrid1);

  //��������� ���.��. ��� �/�
  AdvStringGrid1.AddRow;
  PO := AdvStringGrid1.RowCount - 1;
  advStringGrid1.Cells[0, PO] := IntToStr(PO);
  advStringGrid1.Cells[1, PO] := NachUch;
  advStringGrid1.Cells[2, PO] := '��������� �������';
  advStringGrid1.Cells[3, PO] := '�/� 50 �.�.';
  AdvStringGrid1.AddCheckBox(4,PO,false,false);

  //��������� ������ �� ��������
  AdvStringGrid1.SortByColumn(1);

  //��������� ���������� ������
  advStringGrid1.Cells[0, 0]:='� �/�';
  for q := 1 to advStringGrid1.RowCount - 1 do
    advStringGrid1.Cells[0, q] := IntToStr(q);

  //����������� ������ �����
  AdvStringGrid1.AutoSize:=true;

  //������� ������ �������
  AdvStringGrid1.ColCount:=5;
end;

procedure TFMZP.AdvStringGrid1CheckBoxChange(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
   UpdateLabel;
end;

procedure TFMZP.Button1Click(Sender: TObject);
var
  i, j, q, row: Integer;
  Ap : Variant;
  currentDate: TDateTime;
  previousMonth: TDateTime;
  formattedDate: string;
begin
  currentDate := Now;  // ������� ���� � �����
  previousMonth := IncMonth(currentDate, -1);  // ���������� �����
  formattedDate := FormatDateTime('mmmm yyyy', previousMonth);  // �������������� ���� � ���� "����� ���"

  //������� ��������� ��� �������� ������
  StringGrid1.Visible := false;
  for i:=0 to 1000 do
     StringGrid_DeleteRow1(StringGrid1, i);

  //������� ������
  StringGrid_DeleteRow1(StringGrid1, 1);
  StringGrid_DeleteRow1(StringGrid1, 2);
  StringGrid_DeleteRow1(StringGrid1, 3);

  //��������� ��������� ��������� �������
  for i := 0 to AdvStringGrid1.RowCount - 1 do
  begin
    if AdvStringGrid1.IsChecked(4, i)then
    begin
      for j := 0 to AdvStringGrid1.ColCount - 1 do
      begin
        StringGrid1.Cells[j, StringGrid1.RowCount - 1] := AdvStringGrid1.Cells[j, i];
      end;
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
    end;
  end;
  StringGrid_DeleteRow1(StringGrid1, 1);

  //��������� ������� ������ ���������� ����������
  StringGrid1.Cells[0, 0]:='� �/�';
  for q := 1 to StringGrid1.RowCount - 1 do
    StringGrid1.Cells[0, q] := IntToStr(q);
  StringGrid1.Cells[1, 0]:='��� ����������';
  StringGrid1.Cells[2, 0]:='���������';
  StringGrid1.Cells[3, 0]:='�����';
  row:=StringGrid1.RowCount;
  StringGrid_DeleteRow1(StringGrid1, row);
  //
  //�������������� ������
  try
    Ap := CreateOleObject('Excel.Application');
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\��.xlsx');
    if StringGrid1.RowCount - 1 > 42 then
    begin
      ShowMessage('���������� ��������� ����������� ��������� ���������� ������ �����'+char(10)+char(13)+'�������� �� ����� 42-� ����������� �� ���');
      Exit;
    end;
    Ap.Cells[1,1] := '������ ���������� �� �\����� �� '+ formattedDate +'�. ';
    Ap.Cells[3,3] := '"'+Uchastok+'"';
    Ap.Cells[48,3] :=NachUch;

  //������ ������ �� StringGrid � Excel, ������� � 4 ������
    for i := 0 to StringGrid1.RowCount - 1 do
    begin
      for j := 0 to StringGrid1.ColCount - 1 do
      begin
        Ap.Cells[i + 4, j + 1].Value := StringGrid1.Cells[j, i];
      end;
    end;
    Ap.Visible := false;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    Ap.Quit;
  except
    on E: Exception do
    begin
      ShowMessage('��������� ������ ��� �������� �������: ' + E.Message);
    end;
  end;

end;

end.

