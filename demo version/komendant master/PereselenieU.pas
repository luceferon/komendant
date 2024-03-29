unit PereselenieU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  Uni;

type
  TFMPereselenie = class(TForm)
    CBOtkuda: TComboBox;
    CBKogo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    CBKuda1: TComboBox;
    CBKomnata: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    UniQuery1: TUniQuery;
    UniQuery2: TUniQuery;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBOtkudaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBKogoChange(Sender: TObject);
    procedure CBKuda1Change(Sender: TObject);
    procedure CBKomnataChange(Sender: TObject);
    procedure UpdateAndMoveRecord(const FIOSotrud: string; const FTableName: string;
      const FTableNameKuda: string; const komnata: string);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FMPereselenie: TFMPereselenie;


implementation

{$R *.dfm}

uses
  welcomu;

var
  fiosotrud, komnata:string;
  FTableName, FtableNamekuda: string;

procedure TFMPereselenie.UpdateAndMoveRecord(const FIOSotrud: string; const FTableName: string;
  const FTableNameKuda: string; const komnata: string);
var
  UniQuery: TUniQuery;
begin
  UniQuery := TUniQuery.Create(nil);
  try
    UniQuery.Connection := FMWelcom.UniConnection1;
    UniQuery.SQL.Text := 'SELECT * FROM ' + FTableName + ' WHERE `���_����������` = :fio';
    UniQuery.Params.ParamByName('fio').AsString := FIOSotrud;
    UniQuery.Open;

    if not UniQuery.IsEmpty then
    begin
      var Comment := UniQuery.FieldByName('�����������').AsString;
      var Datazaezda := UniQuery.FieldByName('����_������_�������').AsString;
      var Dolznost := UniQuery.FieldByName('���������').AsString;
      var Org := UniQuery.FieldByName('�����������').AsString;
      var Tel := UniQuery.FieldByName('����������_�������').AsString;
      var KolvoMest := UniQuery.FieldByName('���_��_����').AsString;

      UniQuery.Close;
      UniQuery.SQL.Text := 'DELETE FROM ' + FTableName + ' WHERE `���_����������` = :fio';
      UniQuery.Params.ParamByName('fio').AsString := FIOSotrud;
      UniQuery.ExecSQL;

      UniQuery.SQL.Text := 'INSERT INTO ' + FTableNameKuda +
        ' (`���_����������`, `�����������`, `����_������_�������`, `���������`, `�����������`, ' +
        '`����������_�������`, `���_��_����`, `�����`) VALUES (:fio, :comment, :datazaezda, :dolznost, :org, :tel, :kolvoMest, :komnata)';
      UniQuery.Params.ParamByName('fio').AsString := FIOSotrud;
      UniQuery.Params.ParamByName('comment').AsString := Comment;
      UniQuery.Params.ParamByName('datazaezda').AsString := Datazaezda;
      UniQuery.Params.ParamByName('dolznost').AsString := Dolznost;
      UniQuery.Params.ParamByName('org').AsString := Org;
      UniQuery.Params.ParamByName('tel').AsString := Tel;
      UniQuery.Params.ParamByName('kolvoMest').AsString := KolvoMest;
      UniQuery.Params.ParamByName('komnata').AsString := komnata;
      UniQuery.ExecSQL;
    end;
  finally
    UniQuery.Free;
  end;
end;

procedure TFMPereselenie.Button1Click(Sender: TObject);
begin
  UpdateAndMoveRecord(CBKogo.Text,FTableName,FtableNamekuda,komnata);
  CBKogo.Enabled := false;
  CBKogo.Items.Clear;
  CBKogo.Text := '��� ���������� ��� ��������';
  Close;
end;

procedure TFMPereselenie.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFMPereselenie.CBKogoChange(Sender: TObject);
begin
  CBKuda1.Enabled:= true;
  fiosotrud:=CBKogo.Text;
end;

procedure TFMPereselenie.CBKomnataChange(Sender: TObject);
begin
  komnata:=CBKomnata.Text;
end;

procedure TFMPereselenie.CBKuda1Change(Sender: TObject);
var
  UniQuery1: TUniQuery;
begin
   CBKomnata.Enabled:=true;
  FtableNamekuda:='';
  case CBkuda1.ItemIndex of
   0: begin
    FtableNamekuda:='balki';
    // ����������� � ���� ������ MySQL
    FMWelcom.UniConnection1.Connect;

    // ������� ���������� �������� �� ������� "balki"
     UniQuery1 := TUniQuery.Create(nil);
     UniQuery1.Connection := FMWelcom.UniConnection1;
     UniQuery1.SQL.Text := 'SELECT DISTINCT `�����` FROM `balki`';
     UniQuery1.Open;

     // ���������� ComboBox2 ����������� ����������
     CBKomnata.Clear;
     while not UniQuery1.Eof do
     begin
       CBKomnata.Items.Add(UniQuery1.FieldByName('�����').AsString);
       UniQuery1.Next;
     end;

   end;
   1: begin
    FtableNamekuda:='obchaga';
    // ����������� � ���� ������ MySQL
    FMWelcom.UniConnection1.Connect;

     // ������� ���������� �������� �� ������� "obchaga"
     UniQuery1 := TUniQuery.Create(nil);
     UniQuery1.Connection := FMWelcom.UniConnection1;
     UniQuery1.SQL.Text := 'SELECT DISTINCT `�����` FROM `obchaga`';
     UniQuery1.Open;

     // ���������� ComboBox2 ����������� ����������
     CBKomnata.Clear;
     while not UniQuery1.Eof do
     begin
       CBKomnata.Items.Add(UniQuery1.FieldByName('�����').AsString);
       UniQuery1.Next;
     end;

   end;
  end;
end;

procedure TFMPereselenie.CBOtkudaChange(Sender: TObject);
var
  Query: TUniQuery;
  List: TStringList;
begin
  Query:=nil;
  CBKogo.Enabled:=true;
  FTableName := '';
  case CBOtkuda.ItemIndex of
    0:
    begin
      // ������ ������ �����, ������� ������ �� ������� balki
      Query := UniQuery2;
      Query.SQL.Text := 'SELECT `���_����������` FROM `balki`';
      FTableName := 'balki';
    end;
    1:
    begin
      // ������ ������ �����, ������� ������ �� ������� obchaga
      Query := UniQuery2;
      Query.SQL.Text := 'SELECT `���_����������` FROM `obchaga`';
      FTableName := 'obchaga';
    end;
  end;

  List := TStringList.Create;
  try
    if Assigned(Query) then
    begin
      Query.Connection := FMWelcom.UniConnection1;
      Query.Open;
      while not Query.Eof do
      begin
        List.Add(Query.FieldByName('���_����������').AsString);
        Query.Next;
      end;
      List.Sort;
      CBKogo.Items.Assign(List);
      Query.Close;
    end;
  finally
    List.Free;
  end;
end;

procedure TFMPereselenie.FormShow(Sender: TObject);
begin
  CBOtkuda.ItemIndex:=-1;
  CBOtkuda.Text:='�������� ����� ����������';
  CBKogo.Text:='';
  CBKuda1.Text:='';
  CBKomnata.Text:='';
end;

end.
