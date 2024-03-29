unit DelU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.SqlExpr, Data.FMTBcd,
  MemDS, DBAccess, Uni, MySQLUniProvider;

type
  TFMDel = class(TForm)
  CBOtkuda: TComboBox;
  CBKogo: TComboBox;
  Label1: TLabel;
  Label2: TLabel;
  Button1: TButton;
  Button2: TButton;
  UniQuery1: TUniQuery;
  UniQuery2: TUniQuery;
  procedure Button2Click(Sender: TObject);
  procedure CBOtkudaChange(Sender: TObject);
  procedure Button1Click(Sender: TObject);
  procedure FormShow(Sender: TObject);
private
{ Private declarations }
  FTableName: string;
public
{ Public declarations }
end;

var
  FMDel: TFMDel;

implementation

{$R *.dfm}
uses
  welcomu;

//�������� � �������� ����
procedure TFMDel.Button1Click(Sender: TObject);
begin
  UniQuery1.SQL.Text := 'DELETE FROM `' + FTableName + '` WHERE `���_����������` = :fio';
  UniQuery1.Params.ParamByName('fio').AsString := CBKogo.Text;
  UniQuery1.Execute;
  CBKogo.Enabled:=false;
  CBKogo.Items.Clear;
  CBKogo.Text:='��� ���������� ��� ��������';
  Close;
end;

//������ �������� ����
procedure TFMDel.Button2Click(Sender: TObject);
begin
  Close;
end;

//���������� ������ ����������� � ����������� �� ������ ������ ���������
procedure TFMDel.CBOtkudaChange(Sender: TObject);
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

procedure TFMDel.FormShow(Sender: TObject);
begin
  CBOtkuda.ItemIndex:=-1;
  CBOtkuda.Text:='�������� ����� ����������';
end;

end.
