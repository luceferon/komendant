unit ZaselenieU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Data.DB, Data.SqlExpr, Data.FMTBcd, MemDS, DBAccess, Uni, MySQLUniProvider,
  Vcl.ComCtrls, Vcl.TabNotBk, System.UITypes, ComObj, AdvUtil,
  AdvObj, BaseGrid, AdvGrid, Vcl.CheckLst;

type
  TFMZaselenie = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    UniQuery1: TUniQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    UniQuery3: TUniQuery;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    AdvStringGrid1: TAdvStringGrid;
    AdvStringGrid3: TAdvStringGrid;
    procedure UpdateTable;
    procedure advStringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure advStringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure zaptabl;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure advStringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure advStringGrid3SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure PrintDocObhod;
    procedure PrintDocUval;
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure AdvStringGrid1HoverButtonClick(Sender: TObject; ARow: Integer;
      AButton: THoverButtonsCollectionItem);
    procedure AdvStringGrid3HoverButtonClick(Sender: TObject; ARow: Integer;
      AButton: THoverButtonsCollectionItem);
    procedure advStringGrid1DblClick(Sender: TObject);
    procedure advStringGrid3DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMZaselenie: TFMZaselenie;
  chekgrid, newdatecol, newdaterow, newstatuscol, newstatusrow :integer;
  fio, org, dni, prof, data, otpusknachalo, otpuskkonec, newdate, newstatus: string;

implementation

{$R *.dfm}

uses EditCommentU, DateU, OrganizationU, TelefoneU, OtpuskU, DownloadDocU,
      welcomu, ExportU, ZpU;

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

procedure TFMZaselenie.PrintDocUval;
Var
  Ap : Variant;
begin
  data:=datetostr(now);
  FMDownloadDoc.ProgressBar1.Position:=30;
  Ap := CreateOleObject('Excel.Application');
  Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�������� ���� 2022�.xlsx');
  Ap.Cells[3,2] := Uchastok;
  Ap.Cells[3,5] := '���� '+data+' �.';
  Ap.Cells[6,5] := fio;
  Ap.Cells[5,5] := prof;
  Ap.Cells[6,3] := '����������';
  Ap.Cells[12,4] := Kladovchik;
  Ap.Cells[23,4] := Kladovchik;
  Ap.Cells[33,4] := SysAdmin;
  Ap.Cells[41,4] := NachUch;
  Ap.Cells[36,7] := dni+' - ����';
  Ap.Visible := False;
  Ap.Worksheets[1].PrintOut;
  Ap.DisplayAlerts := False;
  FMDownloadDoc.ProgressBar1.Position:=40;

  if org='��� "���"' then
  begin
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\���������� ���.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Cells[15,1] := '� '+otpusknachalo;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    FMDownloadDoc.ProgressBar1.Position:=70;
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� ���.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    Ap.Quit;
    FMDownloadDoc.ProgressBar1.Position:=99;
    FMDownloadDoc.Close;
  end;

  if org='��� "�-������"' then
  begin
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\���������� �-������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Cells[15,1] := '� '+otpusknachalo;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    FMDownloadDoc.ProgressBar1.Position:=70;
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� �-������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    Ap.Quit;
    FMDownloadDoc.ProgressBar1.Position:=99;
    FMDownloadDoc.Close;
  end;

  if org='��� "����������"' then
  begin
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\���������� ����������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Cells[15,1] := '� '+otpusknachalo;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    FMDownloadDoc.ProgressBar1.Position:=70;
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� ����������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    Ap.Quit;
    FMDownloadDoc.ProgressBar1.Position:=99;
    FMDownloadDoc.Close;
  end;

  if org='��� "�����"' then
  begin
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\���������� �����.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Cells[15,1] := '� '+otpusknachalo;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    FMDownloadDoc.ProgressBar1.Position:=70;
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� �����.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    Ap.Quit;
    FMDownloadDoc.ProgressBar1.Position:=99;
    FMDownloadDoc.Close;
  end;

  if org='��� "��������������"' then
  begin
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\���������� ��������������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Cells[15,1] := '� '+otpusknachalo;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    FMDownloadDoc.ProgressBar1.Position:=70;
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� ��������������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    Ap.Quit;
    FMDownloadDoc.ProgressBar1.Position:=99;
    FMDownloadDoc.Close;
  end;

  if org='��� "�����������"' then
  begin
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\���������� �����������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Cells[15,1] := '� '+otpusknachalo;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    FMDownloadDoc.ProgressBar1.Position:=70;
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� �����������.xlsx');
    Ap.Cells[5,1] := '�� '+prof;
    Ap.Cells[6,1] := fio;
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    Ap.Quit;
    FMDownloadDoc.ProgressBar1.Position:=99;
    FMDownloadDoc.Close;
  end;

  Ap.Quit;
end;

procedure TFMZaselenie.PrintDocObhod;
Var
  Ap : Variant;
begin

  newdate:= otpusknachalo +' - ' + otpuskkonec;

  case chekgrid of
    1: advStringGrid1.Cells[newdatecol, newdaterow]:= newdate;
    2: advStringGrid3.Cells[newdatecol, newdaterow]:= newdate;
  end;
  case chekgrid of
    1: advStringGrid1.Cells[newstatuscol, newstatusrow]:= '������';
    2: advStringGrid3.Cells[newstatuscol, newstatusrow]:= '������';
  end;
  if obhodnoy=1 then
  begin
    data:=datetostr(now);
    FMDownloadDoc.ProgressBar1.Position:=30;
    Ap := CreateOleObject('Excel.Application');
    Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�������� ���� 2022�.xlsx');
    Ap.Cells[3,2] := Uchastok;
    Ap.Cells[3,5] := '���� '+data+' �.';
    Ap.Cells[6,5] := fio;
    Ap.Cells[5,5] := prof;
    Ap.Cells[6,3] := '������';
    Ap.Cells[12,4] := Kladovchik;
    Ap.Cells[23,4] := Kladovchik;
    Ap.Cells[33,4] := SysAdmin;
    Ap.Cells[41,4] := NachUch;
    Ap.Cells[36,7] := dni+' - ����';
    Ap.Visible := False;
    Ap.Worksheets[1].PrintOut;
    Ap.DisplayAlerts := False;
    FMDownloadDoc.ProgressBar1.Position:=40;
  end;

  if otpusk=1 then
  begin
     if org='��� "���"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\������ ���.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Cells[15,1] := '� '+otpusknachalo;
        Ap.Cells[15,4] := '�� '+otpuskkonec;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=70;
     end;

     if org='��� "�-������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\������ �-������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Cells[15,1] := '� '+otpusknachalo;
        Ap.Cells[15,4] := '�� '+otpuskkonec;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=70;
     end;

     if org='��� "����������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\������ ����������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Cells[15,1] := '� '+otpusknachalo;
        Ap.Cells[15,4] := '�� '+otpuskkonec;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=70;
     end;

     if org='��� "�����"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\������ �����.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Cells[15,1] := '� '+otpusknachalo;
        Ap.Cells[15,4] := '�� '+otpuskkonec;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=70;
     end;

     if org='��� "��������������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant�\������ ��������������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Cells[15,1] := '� '+otpusknachalo;
        Ap.Cells[15,4] := '�� '+otpuskkonec;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=70;
     end;

     if org='��� "�����������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\������ �����������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Cells[15,1] := '� '+otpusknachalo;
        Ap.Cells[15,4] := '�� '+otpuskkonec;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=70;
     end;
  end;

  if dengi=1 then
  begin
     if org='��� "���"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� ���.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=99;
        FMDownloadDoc.Close;
     end;
     if org='��� "�-������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� �-������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=99;
        FMDownloadDoc.Close;
     end;

     if org='��� "����������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� ����������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=99;
        FMDownloadDoc.Close;
     end;

     if org='��� "�����"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� �����.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=99;
        FMDownloadDoc.Close;
     end;

     if org='��� "��������������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� ��������������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=99;
        FMDownloadDoc.Close;
     end;

     if org='��� "�����������"' then
     begin
        Ap := CreateOleObject('Excel.Application');
        Ap.Workbooks.Open('\\'+FileServ+'\smb_share\komendant\�� �����������.xlsx');
        Ap.Cells[5,1] := '�� '+prof;
        Ap.Cells[6,1] := fio;
        Ap.Visible := False;
        Ap.Worksheets[1].PrintOut;
        Ap.DisplayAlerts := False;
        Ap.Quit;
        FMDownloadDoc.ProgressBar1.Position:=99;
        FMDownloadDoc.Close;
     end;
  end;

  Ap.Quit;
  FMDownloadDoc.Close;
end;

procedure TFMZaselenie.UpdateTable;
var
  i, j: Integer;
  s: string;
begin
  // ������� ������� "balki"
  UniQuery1.SQL.Text := 'DELETE FROM balki';
  UniQuery1.ExecSQL;
  // ���������� ������� "balki" ������� �� StringGrid1
  for i := 1 to advStringGrid1.RowCount - 1 do
  begin
    s := '';
    for j := 0 to advStringGrid1.ColCount - 1 do
      s := s + QuotedStr(advStringGrid1.Cells[j, i]) + ',';
    Delete(s, Length(s), 1);
    UniQuery1.SQL.Text := Format('INSERT INTO balki VALUES (%s)', [s]);
    UniQuery1.ExecSQL;
  end;

    // ������� ������� "obchaga"
  UniQuery3.SQL.Text := 'DELETE FROM obchaga';
  UniQuery3.ExecSQL;
  // ���������� ������� "obchaga" ������� �� StringGrid1
  for i := 1 to advStringGrid3.RowCount - 1 do
  begin
    s := '';
    for j := 0 to advStringGrid3.ColCount - 1 do
      s := s + QuotedStr(advStringGrid3.Cells[j, i]) + ',';
    Delete(s, Length(s), 1);
    UniQuery3.SQL.Text := Format('INSERT INTO obchaga VALUES (%s)', [s]);
    UniQuery3.ExecSQL;
  end;
end;

//���������� �����
procedure SortStringGridByColumn(advStringGrid: TStringGrid; ColumnIndex: Integer);
var
  i, j, MinRowIndex: Integer;
  temp: string;
  MinValue, CurrValue: Extended;
begin
  for i := 1 to advStringGrid.RowCount - 2 do
  begin
    MinRowIndex := i;
    try
      MinValue := StrToFloat(advStringGrid.Cells[ColumnIndex, i]);
    except
      on E: EConvertError do
        MinValue := 0;
    end;
    for j := i + 1 to advStringGrid.RowCount - 1 do
    begin
      try
        CurrValue := StrToFloat(advStringGrid.Cells[ColumnIndex, j]);
      except
        on E: EConvertError do
          CurrValue := 0;
      end;
      if CurrValue < MinValue then
      begin
        MinRowIndex := j;
        MinValue := CurrValue;
      end;
    end;

    if MinRowIndex <> i then
    begin
      for j := 0 to advStringGrid.ColCount - 1 do
      begin
        temp := advStringGrid.Cells[j, i];
        advStringGrid.Cells[j, i] := advStringGrid.Cells[j, MinRowIndex];
        advStringGrid.Cells[j, MinRowIndex] := temp;
      end;
    end;
  end;
end;

//���������� �������
procedure TFMZaselenie.zaptabl;
var
  i,j, row, row3: Integer;
 begin
  UniQuery1.SQL.Text := 'SELECT * FROM balki';
  UniQuery1.ExecSQL;
  UniQuery3.SQL.Text := 'SELECT * FROM obchaga';
  UniQuery3.ExecSQL;

   //���������� ������� ������
  UniQuery1.Open;
  advStringGrid1.RowCount := UniQuery1.RecordCount + 1; // ��������� ���������� �����
  advStringGrid1.ColCount := UniQuery1.FieldCount; // ��������� ���������� ��������

  // ���������� ����� �������
  i := 1;
  while not UniQuery1.Eof do
  begin
    for j := 0 to UniQuery1.FieldCount - 1 do
    begin
      advStringGrid1.Cells[j, i] := UniQuery1.Fields[j].AsString;
    end;
    Inc(i);
    UniQuery1.Next;
  end;

  //���������� ������� ������
  UniQuery3.Open;
  advStringGrid3.RowCount := UniQuery3.RecordCount + 1; // ��������� ���������� �����
  advStringGrid3.ColCount := UniQuery3.FieldCount; // ��������� ���������� ��������
  // ���������� ����� �������
  i := 1;
  while not UniQuery3.Eof do
  begin
    for j := 0 to UniQuery3.FieldCount - 1 do
    begin
      advStringGrid3.Cells[j, i] := UniQuery3.Fields[j].AsString;
    end;
    Inc(i);
    UniQuery3.Next;
  end;
  //����������
  SortStringGridByColumn(advStringGrid1, 0);
  SortStringGridByColumn(advStringGrid3, 0);

// ���������� ���������� ��������
  for i := 0 to UniQuery1.FieldCount - 1 do
  begin
    advStringGrid1.Cells[i, 0] := UniQuery1.Fields[i].FieldName;
  end;
  for i := 0 to UniQuery3.FieldCount - 1 do
  begin
    advStringGrid3.Cells[i, 0] := UniQuery3.Fields[i].FieldName;
  end;
  //������ ������ ������

  AdvStringGrid1.AutoSize:=true;
  AdvStringGrid1.ColWidths[0]:=120;
  row:=AdvStringGrid1.RowCount;
  AdvStringGrid1.FilterEdit.Row:=row;

  AdvStringGrid3.AutoSize:=true;
  AdvStringGrid3.ColWidths[0]:=50;
  row3:=AdvStringGrid3.RowCount;
  AdvStringGrid3.FilterEdit.Row:=row3;

  UniQuery1.Close;
  UniQuery3.Close;

   // ���������� ������ ����� �����
  for I := AdvStringGrid1.RowCount - 1 downto 1 do
  begin
    // ���������, �������� �� ������ ������� �����
    if AdvStringGrid1.Cells[2, I] = '' then
    begin
      // ������ ������
      AdvStringGrid1.HideRow(i);
    end;
  end;

     // ���������� ������ ����� �����
  for I := AdvStringGrid3.RowCount - 1 downto 1 do
  begin
    // ���������, �������� �� ������ ������� �����
    if AdvStringGrid3.Cells[2, I] = '' then
    begin
      // ������ ������
      AdvStringGrid3.HideRow(i);
    end;
  end;
 end;

//�������� ����
procedure TFMZaselenie.Button1Click(Sender: TObject);
begin
  FMZaselenie.Close;
end;

procedure TFMZaselenie.Button2Click(Sender: TObject);
begin
  FMDokument.ShowModal;
end;

procedure TFMZaselenie.Button3Click(Sender: TObject);
begin
  FMExport.ShowModal;
end;

procedure TFMZaselenie.Button4Click(Sender: TObject);
begin
  FMZP.Show;
end;

procedure TFMZaselenie.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=false;
  UpdateTable;
  CanClose:=true;
end;

procedure TFMZaselenie.FormCreate(Sender: TObject);
begin
  chekgrid:=0;
  org:='';
end;

procedure TFMZaselenie.FormShow(Sender: TObject);
begin
   zaptabl;
end;

procedure TFMZaselenie.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if PageControl1.ActivePage=TabSheet1 then
    chekgrid:=1;
  if PageControl1.ActivePage=TabSheet3 then
    chekgrid:=2;
   UpdateTable;
end;

procedure TFMZaselenie.advStringGrid1DblClick(Sender: TObject);
var
  Col: Integer;
begin
  chekgrid:=1;
  Col := advStringGrid1.Col;
  if advStringGrid1.Cells[Col, 0] = '�����������' then
    FMEditComment.showmodal;
  if advStringGrid1.Cells[Col, 0] = '����_������_�������' then
    FMDate.showmodal;
  if advStringGrid1.Cells[Col, 0] = '�����������' then
    FMOrganization.showmodal;
  if advStringGrid1.Cells[Col, 0] = '����������_�������' then
    FMTelefon.showmodal
  else
  Exit;
end;


procedure TFMZaselenie.advStringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Value: string;
  DateOtpusskOpozdanie: TDateTime;
  CellText: string;
begin
  // �������� ����� ������
  CellText := AdvStringGrid1.Cells[ACol, ARow];

  // ���������, �������� �� ����� ������ ����� "������"
  if Pos('������', CellText) > 0 then
  begin
    // �������� ������ ������ ������
    AdvStringGrid1.Canvas.Brush.Color := clYellow;
    AdvStringGrid1.Canvas.FillRect(Rect);

    // ������ ����� ������
    AdvStringGrid1.Canvas.Font.Color := clBlack;
    AdvStringGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
  end;
  Value := AdvStringGrid1.Cells[ACol, ARow]; // �������� �������� ��������� ������
  if (Pos('-', Value) > 0) and (Length(Value) >= 11) then
  begin
    Value := Trim(Copy(Value, Pos('-', Value) + 1, 11)); // �������� ������ �������� ����
    DateOtpusskOpozdanie := StrToDateDef(Value, 0); // ��������������� ������ � ����
    if (DateOtpusskOpozdanie <> 0) and (DateOtpusskOpozdanie < Now) then
    begin
      advStringGrid1.Canvas.Font.Color := clRed; // ������������� ���� ������ ��� ������
      AdvStringGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
    end;
  end;
end;

procedure TFMZaselenie.advStringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Value: string;
  DateOtpusskOpozdanie: TDateTime;
  CellText: string;
begin
  // �������� ����� ������
  CellText := AdvStringGrid3.Cells[ACol, ARow];

  // ���������, �������� �� ����� ������ ����� "������"
  if Pos('������', CellText) > 0 then
  begin
    // �������� ������ ������ ������
    AdvStringGrid3.Canvas.Brush.Color := clYellow;
    AdvStringGrid3.Canvas.FillRect(Rect);

    // ������ ����� ������
    AdvStringGrid3.Canvas.Font.Color := clBlack;
    AdvStringGrid3.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
  end;
  Value := AdvStringGrid3.Cells[ACol, ARow]; // �������� �������� ��������� ������
  if (Pos('-', Value) > 0) and (Length(Value) >= 11) then
  begin
    Value := Trim(Copy(Value, Pos('-', Value) + 1, 11)); // �������� ������ �������� ����
    DateOtpusskOpozdanie := StrToDateDef(Value, 0); // ��������������� ������ � ����
    if (DateOtpusskOpozdanie <> 0) and (DateOtpusskOpozdanie < Now) then
    begin
      advStringGrid3.Canvas.Font.Color := clRed; // ������������� ���� ������ ��� ������
      AdvStringGrid3.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
    end;
  end;
end;

procedure TFMZaselenie.advStringGrid3DblClick(Sender: TObject);
var
  Col: Integer;
begin
  chekgrid:=2;
  Col := advStringGrid3.Col;
  if advStringGrid3.Cells[Col, 0] = '�����������' then
    FMEditComment.showmodal;
  if advStringGrid3.Cells[Col, 0] = '����_������_�������' then
    FMDate.showmodal;
  if advStringGrid3.Cells[Col, 0] = '�����������' then
    FMOrganization.showmodal;
  if advStringGrid3.Cells[Col, 0] = '����������_�������' then
    FMTelefon.showmodal
  else
  Exit;
end;

procedure TFMZaselenie.AdvStringGrid1HoverButtonClick(Sender: TObject;
  ARow: Integer; AButton: THoverButtonsCollectionItem);
begin
  Button2Click(sender);
end;

procedure TFMZaselenie.AdvStringGrid3HoverButtonClick(Sender: TObject;
  ARow: Integer; AButton: THoverButtonsCollectionItem);
begin
  Button2Click(sender);
end;


procedure TFMZaselenie.advStringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  chekgrid:=1;
  fio:= advStringGrid1.Cells[acol,arow];
  prof:= advStringGrid1.Cells[acol+3,arow];
  org:= advStringGrid1.Cells[acol+4,arow];
  newdatecol:=acol+2;
  newdaterow:=arow;
  newstatuscol:=acol+1;
  newstatusrow:=arow;
end;

procedure TFMZaselenie.advStringGrid3SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  chekgrid:=2;
  fio:= advStringGrid3.Cells[acol,arow];
  prof:= advStringGrid3.Cells[acol+3,arow];
  org:= advStringGrid3.Cells[acol+4,arow];
  newdatecol:=acol+2;
  newdaterow:=arow;
  newstatuscol:=acol+1;
  newstatusrow:=arow;
end;

//����������� ������� � ��������
procedure TFMZaselenie.TabSheet1Show(Sender: TObject);
begin
   zaptabl;
end;

end.
