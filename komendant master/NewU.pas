unit NewU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls, Data.DB,
  MemDS, DBAccess, Uni, Vcl.Mask;

type
  TFMNew = class(TForm)
    Label1: TLabel;
    CBkuda: TComboBox;
    Label2: TLabel;
    CBnomer: TComboBox;
    Efio: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    DPzaezd: TDatePicker;
    Label5: TLabel;
    CBprof: TComboBox;
    Label6: TLabel;
    Ecomment: TEdit;
    ListBox1: TListBox;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    UniQuery1: TUniQuery;
    Label8: TLabel;
    UniQuery2: TUniQuery;
    Label9: TLabel;
    UniQuery3: TUniQuery;
    CBOrganization: TComboBox;
    Phone1: TMaskEdit;
    Phone2: TMaskEdit;
    Phone3: TMaskEdit;
    Label10: TLabel;
    Label11: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure CBkudaChange(Sender: TObject);
    procedure EfioClick(Sender: TObject);
    procedure CBnomerChange(Sender: TObject);
    procedure EfioChange(Sender: TObject);
    procedure CBprofChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Phone1Change(Sender: TObject);
    procedure Phone2Change(Sender: TObject);
    procedure Phone3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMNew: TFMNew;


implementation
uses
  welcomu;

var
  tabl:string;
  zap: integer;
{$R *.dfm}

procedure TFMNew.Button1Click(Sender: TObject);
var
  query: TUniQuery;
  buttonSelected : Integer;
begin

  if ListBox1.Items.Count >= StrToInt(Label8.Caption) then
  begin
    buttonSelected := MessageDlg('Предупреждение: в данном помещении кол-во проживающих равно либо больше указанного количества мест. '+
    'Действительно желаете заселить человека сюда?',mtError, mbYesNo, 0);
    if buttonSelected = mrNo then
      Exit;
    if buttonSelected = mrYes then
    begin
      try
// создание объекта запроса
        query := TUniQuery.Create(nil);

        query.Connection := FMWelcom.UniConnection1;

// открытие таблицы с именем из глобальной переменной tabl
        query.SQL.Text := 'SELECT * FROM ' + tabl;
        query.Open;

// добавление новой строки в таблицу
        query.Append;
        if (tabl = 'balki') then
        begin
          query.FieldByName('Номер').AsString := CBnomer.Text;
          query.FieldByName('Кол_во_мест').AsString := Label8.Caption;
          query.FieldByName('Организация').AsString := CBOrganization.Text;
          if zap=1 then
            query.FieldByName('Контактный_телефон').AsString := Phone1.Text;
          if zap=2 then
            query.FieldByName('Контактный_телефон').AsString :=Phone1.Text+', '+ Phone2.Text;
          if zap=3 then
            query.FieldByName('Контактный_телефон').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
        end else
          if (tabl = 'obchaga') then
          begin
            query.FieldByName('Номер').AsString := CBnomer.Text;
            query.FieldByName('Кол_во_мест').AsString := Label8.Caption;
            query.FieldByName('Организация').AsString := CBOrganization.Text;
            if zap=1 then
              query.FieldByName('Контактный_телефон').AsString := Phone1.Text;
            if zap=2 then
              query.FieldByName('Контактный_телефон').AsString :=Phone1.Text+', '+ Phone2.Text;
            if zap=3 then
              query.FieldByName('Контактный_телефон').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
          end;

        query.FieldByName('ФИО_сотрудника').AsString := Efio.Text;
        query.FieldByName('Комментарий').AsString := Ecomment.Text;
        query.FieldByName('Дата_заезда_отпуска').AsString :=datetostr(DPzaezd.Date);
        query.FieldByName('Должность').AsString := CBprof.Text;
        query.Post;

// закрытие окна приложения
        Close;
        except
        on E: Exception do
        begin
          ShowMessage('Ошибка выполнения запроса: ' + E.Message);
        end;
      end;
    end;
  end
  else
    begin
      try
// создание объекта запроса
        query := TUniQuery.Create(nil);

        query.Connection := FMWelcom.UniConnection1;

// открытие таблицы с именем из глобальной переменной tabl
        query.SQL.Text := 'SELECT * FROM ' + tabl;
        query.Open;

// добавление новой строки в таблицу
        query.Append;
        if (tabl = 'balki') then
        begin
          query.FieldByName('Номер').AsString := CBnomer.Text;
          query.FieldByName('Кол_во_мест').AsString := Label8.Caption;
          query.FieldByName('Организация').AsString := CBOrganization.Text;
          if zap=1 then
            query.FieldByName('Контактный_телефон').AsString := Phone1.Text;
          if zap=2 then
            query.FieldByName('Контактный_телефон').AsString :=Phone1.Text+', '+ Phone2.Text;
          if zap=3 then
            query.FieldByName('Контактный_телефон').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
        end else
          if (tabl = 'obchaga') then
          begin
            query.FieldByName('Номер').AsString := CBnomer.Text;
            query.FieldByName('Кол_во_мест').AsString := Label8.Caption;
            query.FieldByName('Организация').AsString := CBOrganization.Text;
            if zap=1 then
              query.FieldByName('Контактный_телефон').AsString := Phone1.Text;
            if zap=2 then
              query.FieldByName('Контактный_телефон').AsString :=Phone1.Text+', '+ Phone2.Text;
            if zap=3 then
              query.FieldByName('Контактный_телефон').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
          end;

        query.FieldByName('ФИО_сотрудника').AsString := Efio.Text;
        query.FieldByName('Комментарий').AsString := Ecomment.Text;
        query.FieldByName('Дата_заезда_отпуска').AsString :=datetostr(DPzaezd.Date);
        query.FieldByName('Должность').AsString := CBprof.Text;
        query.Post;

// закрытие окна приложения
        Close;
        except
        on E: Exception do
        begin
          ShowMessage('Ошибка выполнения запроса: ' + E.Message);
        end;
      end;
    end;
end;

procedure TFMNew.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFMNew.CBkudaChange(Sender: TObject);
var
  UniQuery1: TUniQuery;
begin
  CBnomer.Enabled:=true;
  case CBkuda.ItemIndex of
   0: begin
    tabl:='balki';
    Label2.Visible:=true;
    CBnomer.Visible:=true;
    Efio.Enabled:=false;
    // Подключение к базе данных MySQL
    FMWelcom.UniConnection1.Connect;

    // Выборка уникальных значений из таблицы "balki"
     UniQuery1 := TUniQuery.Create(nil);
     UniQuery1.Connection := FMWelcom.UniConnection1;
     UniQuery1.SQL.Text := 'SELECT DISTINCT `Номер` FROM `balki`';
     UniQuery1.Open;

     // Заполнение ComboBox2 полученными значениями
     CBnomer.Clear;
     while not UniQuery1.Eof do
     begin
       CBnomer.Items.Add(UniQuery1.FieldByName('Номер').AsString);
       UniQuery1.Next;
     end;

   end;
   1: begin
    tabl:='obchaga';
    Label2.Visible:=true;
    CBnomer.Visible:=true;
    Efio.Enabled:=false;
    // Подключение к базе данных MySQL
    FMWelcom.UniConnection1.Connect;

     // Выборка уникальных значений из таблицы "obchaga"
     UniQuery1 := TUniQuery.Create(nil);
     UniQuery1.Connection := FMWelcom.UniConnection1;
     UniQuery1.SQL.Text := 'SELECT DISTINCT `Номер` FROM `obchaga`';
     UniQuery1.Open;

     // Заполнение ComboBox2 полученными значениями
     CBnomer.Clear;
     while not UniQuery1.Eof do
     begin
       CBnomer.Items.Add(UniQuery1.FieldByName('Номер').AsString);
       UniQuery1.Next;
     end;

   end;
  end;

end;

procedure TFMNew.CBnomerChange(Sender: TObject);
var
  UniQuery1: TUniQuery;
begin
// Подключение к базе данных MySQL
  //con;

// Выборка значений из таблицы в зависимости от выбранного пункта в ComboBox2
  case CBkuda.ItemIndex of
  0: begin
    UniQuery1 := TUniQuery.Create(nil);
    UniQuery1.Connection := FMWelcom.UniConnection1;
    UniQuery1.SQL.Text := 'SELECT `ФИО_сотрудника` FROM `balki` WHERE `Номер` = :nomer';
    UniQuery1.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery1.Open;
    Efio.Enabled:=true;

    UniQuery2 := TUniQuery.Create(nil);
    UniQuery2.Connection := FMWelcom.UniConnection1;
    UniQuery2.SQL.Text := 'SELECT `Кол_во_мест` FROM `balki` WHERE `Номер` = :nomer';
    UniQuery2.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery2.Open;

    UniQuery3 := TUniQuery.Create(nil);
    UniQuery3.Connection := FMWelcom.UniConnection1;
    UniQuery3.SQL.Text := 'SELECT `Комментарий` FROM `balki`';
    UniQuery3.Open;

  if not UniQuery2.Eof then
    Label8.Caption := UniQuery2.FieldByName('Кол_во_мест').AsString
  else
    Label8.Caption := '';

//  UniQuery2.Free;
  end;
  1: begin
    UniQuery1 := TUniQuery.Create(nil);
    UniQuery1.Connection := FMWelcom.UniConnection1;
    UniQuery1.SQL.Text := 'SELECT `ФИО_сотрудника` FROM `obchaga` WHERE `Номер` = :nomer';
    UniQuery1.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery1.Open;
    Efio.Enabled:=true;

    UniQuery2 := TUniQuery.Create(nil);
    UniQuery2.Connection := FMWelcom.UniConnection1;
    UniQuery2.SQL.Text := 'SELECT `Кол_во_мест` FROM `obchaga` WHERE `Номер` = :nomer';
    UniQuery2.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery2.Open;
    if not UniQuery2.Eof then
      Label8.Caption := UniQuery2.FieldByName('Кол_во_мест').AsString
    else
      Label8.Caption := '';
    end;
  end;

// Заполнение ListBox1 полученными значениями
  ListBox1.Clear;
  while not UniQuery1.Eof do
  begin
    ListBox1.Items.Add(UniQuery1.FieldByName('ФИО_сотрудника').AsString+' ');
    UniQuery1.Next;
  end;
  if ListBox1.Items.Count >= StrToInt(Label8.Caption) then
  begin
    label8.Font.Color:=clRed;
    label9.Font.Color:=clRed;
  end
  else
  begin
    label8.Font.Color:=clWindowText;
    label9.Font.Color:=clWindowText;
  end;

end;

procedure TFMNew.CBprofChange(Sender: TObject);
begin
  Button1.Enabled:=true;
end;

procedure TFMNew.EfioChange(Sender: TObject);
begin
  DPzaezd.Enabled:=true;
  Ecomment.Enabled:=true;
  CBprof.Enabled:=true;
  CBOrganization.Enabled:=true;
  Phone1.Enabled:=true;
end;

procedure TFMNew.EfioClick(Sender: TObject);
begin
  Efio.SelectAll;
end;

procedure TFMNew.FormShow(Sender: TObject);
begin
  // выбор места заселения
  CBkuda.ItemIndex := -1; // Установка значения "по умолчанию" (-1)
  //номер балка(комнаты)
  CBnomer.Clear;
  CBnomer.Enabled := False;
  //Профессии
  CBprof.ItemIndex := -1;
  CBprof.Enabled := False;
  // ФИО
  Efio.Text := 'ФИО';
  Efio.Enabled := False;
  //дата заезда
  DPzaezd.Date := Now;
  DPzaezd.Enabled := False;
  //графа комментария
  Ecomment.Text := '';
  Ecomment.Enabled := False;
  //список кто живет
  ListBox1.Clear;
  //кол-во мест
  Label8.Caption := '0';
  //Кнопка заселить
  Button1.Enabled := False;
  Phone2.Enabled:=false;
  Phone3.Enabled:=false;
  zap:=0;
end;

procedure TFMNew.Phone1Change(Sender: TObject);
begin
   zap:=1;
   Phone2.Enabled:=true;
end;

procedure TFMNew.Phone2Change(Sender: TObject);
begin
   zap:=2;
   Phone3.Enabled:=true;
end;

procedure TFMNew.Phone3Change(Sender: TObject);
begin
   zap:=3;
end;

end.

