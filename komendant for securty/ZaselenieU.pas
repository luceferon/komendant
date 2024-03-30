﻿unit ZaselenieU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Data.DB, Data.SqlExpr, Data.FMTBcd, MemDS, DBAccess, Uni, MySQLUniProvider,
  Vcl.ComCtrls, Vcl.TabNotBk, System.UITypes, ComObj, Vcl.CheckLst, AdvUtil,
  AdvObj, BaseGrid, AdvGrid, inifiles;

type
  TFMZaselenie = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    UniQuery1: TUniQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    UniQuery3: TUniQuery;
    Button3: TButton;
    UniConnection1: TUniConnection;
    AdvStringGrid1: TAdvStringGrid;
    AdvStringGrid3: TAdvStringGrid;

    procedure advStringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure advStringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure zaptabl;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure advStringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure advStringGrid3SelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMZaselenie: TFMZaselenie;
  chekgrid, newdatecol, newdaterow, newstatuscol, newstatusrow :integer;
  fio, org, dni, prof, data, otpusknachalo, otpuskkonec, newdate, newstatus,
  Uchastok, FileServ, Kladovchik, SysAdmin, NachUch: string;
  FirstRun:boolean;

implementation

{$R *.dfm}

uses ExportU;

function advStringGrid_DeleteRow(SG : TAdvStringGrid; ARow : integer) : boolean;
//удалить заданную строку из TStringGrid
//SG - переменная типа TStringGrid
//ARow - номер (индекс строки, начиная с нуля), которую нужно удалить
//Возвращаемое значение - результат операции
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

//сортировка строк
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

//Заполнение таблицы
//Заполнение таблицы
procedure TFMZaselenie.zaptabl;
var
  i,j, row, row3: Integer;
 begin
  UniQuery1.SQL.Text := 'SELECT * FROM balki';
  UniQuery1.ExecSQL;
  UniQuery3.SQL.Text := 'SELECT * FROM obchaga';
  UniQuery3.ExecSQL;

   //Заполнение таблицы балков
  UniQuery1.Open;
  advStringGrid1.RowCount := UniQuery1.RecordCount + 1; // установка количества строк
  advStringGrid1.ColCount := UniQuery1.FieldCount; // установка количества столбцов

  // заполнение ячеек таблицы
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

  //Заполнение таблицы Общаги
  UniQuery3.Open;
  advStringGrid3.RowCount := UniQuery3.RecordCount + 1; // установка количества строк
  advStringGrid3.ColCount := UniQuery3.FieldCount; // установка количества столбцов
  // заполнение ячеек таблицы
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
  //сортировка
  SortStringGridByColumn(advStringGrid1, 0);
  SortStringGridByColumn(advStringGrid3, 0);

// заполнение заголовков столбцов
  for i := 0 to UniQuery1.FieldCount - 1 do
  begin
    advStringGrid1.Cells[i, 0] := UniQuery1.Fields[i].FieldName;
  end;
  for i := 0 to UniQuery3.FieldCount - 1 do
  begin
    advStringGrid3.Cells[i, 0] := UniQuery3.Fields[i].FieldName;
  end;
  //Подюор длинны строки

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

   // Перебираем строки снизу вверх
  for I := AdvStringGrid1.RowCount - 1 downto 1 do
  begin
    // Проверяем, содержит ли второй столбец текст
    if AdvStringGrid1.Cells[2, I] = '' then
    begin
      // прячим строку
      AdvStringGrid1.HideRow(i);
    end;
  end;

     // Перебираем строки снизу вверх
  for I := AdvStringGrid3.RowCount - 1 downto 1 do
  begin
    // Проверяем, содержит ли второй столбец текст
    if AdvStringGrid3.Cells[2, I] = '' then
    begin
      // прячим строку
      AdvStringGrid3.HideRow(i);
    end;
  end;
 end;

procedure TFMZaselenie.Button1Click(Sender: TObject);
begin
  FMZaselenie.Close;
end;

procedure TFMZaselenie.Button3Click(Sender: TObject);
begin
  FMExport.ShowModal;
end;

procedure TFMZaselenie.FormCreate(Sender: TObject);
var
  ini, Ini2: Tinifile;
begin
  chekgrid:=0;
  org:='';
  //Считываем настройки с сервера
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'conf.ini');
  FileServ:=Ini.ReadString('Uchastok','FileServ','');
  Ini.Free;
  Ini2:=TiniFile.Create(extractfilepath(paramstr(0))+'conf.ini');
  UniConnection1.Server:=Ini2.ReadString('Connection','Server','localhost');
  UniConnection1.Username:=Ini2.ReadString('Connection','User','root');
  UniConnection1.Password:=Ini2.ReadString('Connection','Password','');
  UniConnection1.Database:=Ini2.ReadString('Connection','DB','komendant');
  Ini2.Free;
end;

procedure TFMZaselenie.FormShow(Sender: TObject);
begin
  zaptabl;
end;

procedure TFMZaselenie.advStringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Value: string;
  DateOtpusskOpozdanie: TDateTime;
  CellText: string;
begin
  // Получаем текст ячейки
  CellText := AdvStringGrid1.Cells[ACol, ARow];

  // Проверяем, содержит ли текст ячейки слово "Отпуск"
  if Pos('Отпуск', CellText) > 0 then
  begin
    // Выделяем ячейку другим цветом
    AdvStringGrid1.Canvas.Brush.Color := clYellow;
    AdvStringGrid1.Canvas.FillRect(Rect);

    // Рисуем текст ячейки
    AdvStringGrid1.Canvas.Font.Color := clBlack;
    AdvStringGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
  end;
  Value := AdvStringGrid1.Cells[ACol, ARow]; // получаем значение следующей ячейки
  if (Pos('-', Value) > 0) and (Length(Value) >= 11) then
  begin
    Value := Trim(Copy(Value, Pos('-', Value) + 1, 11)); // выделяем второе значение даты
    DateOtpusskOpozdanie := StrToDateDef(Value, 0); // преобразовываем строку в дату
    if (DateOtpusskOpozdanie <> 0) and (DateOtpusskOpozdanie < Now) then
    begin
      advStringGrid1.Canvas.Font.Color := clRed; // устанавливаем цвет шрифта для ячейки
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
  // Получаем текст ячейки
  CellText := AdvStringGrid3.Cells[ACol, ARow];

  // Проверяем, содержит ли текст ячейки слово "Отпуск"
  if Pos('Отпуск', CellText) > 0 then
  begin
    // Выделяем ячейку другим цветом
    AdvStringGrid3.Canvas.Brush.Color := clYellow;
    AdvStringGrid3.Canvas.FillRect(Rect);

    // Рисуем текст ячейки
    AdvStringGrid3.Canvas.Font.Color := clBlack;
    AdvStringGrid3.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
  end;
  Value := AdvStringGrid3.Cells[ACol, ARow]; // получаем значение следующей ячейки
  if (Pos('-', Value) > 0) and (Length(Value) >= 11) then
  begin
    Value := Trim(Copy(Value, Pos('-', Value) + 1, 11)); // выделяем второе значение даты
    DateOtpusskOpozdanie := StrToDateDef(Value, 0); // преобразовываем строку в дату
    if (DateOtpusskOpozdanie <> 0) and (DateOtpusskOpozdanie < Now) then
    begin
      advStringGrid3.Canvas.Font.Color := clRed; // устанавливаем цвет шрифта для ячейки
      AdvStringGrid3.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
    end;
  end;
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

//Отображение вкладки с таблицей
procedure TFMZaselenie.TabSheet1Show(Sender: TObject);
begin
   zaptabl;
end;

end.
