unit mestaU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls, Uni, UniProvider, MySQLUniProvider;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function GetArrayValuesAsString1: string;
    function GetArrayValuesAsString2: string;
  private
    arr, arr2: array of array of Integer;
    spinEdit1, spinEdit2: array of TSpinEdit;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  ServerU;

{$R *.dfm}

function TForm3.GetArrayValuesAsString1: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to balki - 1 do
  begin
    Result := Result + '����� �' + IntToStr(arr[i, 0]) + ': ' + IntToStr(arr[i, 1]) + #13#10;
  end;
end;

function TForm3.GetArrayValuesAsString2: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to obchaga - 1 do
  begin
    Result := Result + '������� �' + IntToStr(arr2[i, 0]) + ': ' + IntToStr(arr2[i, 1]) + #13#10;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  i: Integer;
  connection: TUniConnection;
  query1, query2: TUniQuery;
begin
  SetLength(arr, balki, 2); // ������������� ������ �������
  for i := 0 to balki - 1 do
  begin
    arr[i, 0] := i + 1; // ��������� ���������� �����
    arr[i, 1] := spinEdit1[i].Value; // ��������� �������� SpinEdit �� ������� spinEdit
  end;
  SetLength(arr2, obchaga, 2); // ������������� ������ �������
  for i := 0 to obchaga - 1 do
  begin
    arr2[i, 0] := i + 1; // ��������� ���������� �����
    arr2[i, 1] := spinEdit2[i].Value; // ��������� �������� SpinEdit �� ������� spinEdit
  end;

  if MessageDlg('����������� ��������� ������'+#13#10+GetArrayValuesAsString1+' ' +GetArrayValuesAsString2,
       mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    //������������� ��������� ����������� � ���� ������ MySQL
    connection := TUniConnection.Create(nil);
    try
      connection.ProviderName := 'MySQL';
      connection.Server := serverDB;
      connection.Username := userDB;
      connection.Password := passDB;
      Connection.Database := DB;
    // ��������� ���������� � ����� ������
      connection.Connect;

    // ������� � ��������� ������ ��� ���������� ������ � ���� ������
      query1 := TUniQuery.Create(nil);
      try
        query1.Connection := connection;
        query1.SQL.Text := 'INSERT INTO balki (�����, "���_��_����") VALUES (:�����, :���������)';

        for i := 0 to balki - 1 do
        begin
          query1.ParamByName('�����').AsInteger := arr[i, 0];
          query1.ParamByName('���������').AsInteger := arr[i, 1];
          query1.ExecSQL;
        end;
      finally
        query1.Free;
      end;
      if obchaga>0 then
      begin
    //������� � ��������� ������ ��� ���������� ������ � ���� ������
        query2 := TUniQuery.Create(nil);
        try
          query2.Connection := connection;
          query2.SQL.Text := 'INSERT INTO obchaga (�����, "���_��_����") VALUES (:�����, :���������)';

          for i := 0 to obchaga - 1 do
          begin
            query2.ParamByName('�����').AsInteger := arr2[i, 0];
            query2.ParamByName('���������').AsInteger := arr2[i, 1];
            query2.ExecSQL;
          end;
        finally
          query2.Free;
        end;
      end
      else
      begin
        query2 := TUniQuery.Create(nil);
        try
          query2.Connection := connection;
          query2.SQL.Text := 'INSERT INTO obchaga (�����, "���_��_����", "���_����������") VALUES (:�����, :���������, :���)';

          query2.ParamByName('�����').AsString :='0';
          query2.ParamByName('���������').AsString :='0';
          query2.ParamByName('���').AsString :='����';
          query2.ExecSQL;

        finally
          query2.Free;
        end;
      end;
    finally
    // ��������� ���������� � ����� ������
      connection.Disconnect;
      connection.Free;
    end;

  Form1.Button4.Enabled:=false;
  Form3.Close;
  end
  else
  begin
    exit;
  end;

end;

procedure TForm3.FormShow(Sender: TObject);
var
  i: Integer;
  labelNum: TLabel;
begin
  SetLength(spinEdit1, balki); // ������������� ������ ������� spinEdit1
  SetLength(spinEdit2, obchaga);
  for i := 0 to balki - 1 do
  begin
    spinEdit1[i] := TSpinEdit.Create(Self); // �������� ������ �������� SpinEdit
    spinEdit1[i].Parent := Panel1; // ��������� ����� ��� ������������� ��������
    spinEdit1[i].Left := 0; // ��������� ������� �����
    spinEdit1[i].Top := 10 + i * (spinEdit1[i].Height + 10); // ������� ������ ��� �������� ��������
    spinEdit1[i].Width := 40; // ������
    spinEdit1[i].Height := 20; // ������
    labelNum := TLabel.Create(Self); // �������� ������ �������� Label
    labelNum.Parent := Panel1; // ��������� ����� ��� ������������� ��������
    labelNum.Left := spinEdit1[i].Left + spinEdit1[i].Width + 10; // ������� ����� ��� �������� ��������
    labelNum.Top := spinEdit1[i].Top; // ��������� ������� ������ � SpinEdit
    labelNum.Caption := '����� �' + IntToStr(i + 1); // ��������� ����������� ������ � ��������� Label
  end;
  for i := 0 to obchaga - 1 do
  begin
    spinEdit2[i] := TSpinEdit.Create(Self); // �������� ������ �������� SpinEdit
    spinEdit2[i].Parent := Panel2; // ��������� ����� ��� ������������� ��������
    spinEdit2[i].Left := 0; // ��������� ������� �����
    spinEdit2[i].Top := 10 + i * (spinEdit2[i].Height + 10); // ������� ������ ��� �������� ��������
    spinEdit2[i].Width := 40; // ������
    spinEdit2[i].Height := 20; // ������
    labelNum := TLabel.Create(Self); // �������� ������ �������� Label
    labelNum.Parent := Panel2; // ��������� ����� ��� ������������� ��������
    labelNum.Left := spinEdit2[i].Left + spinEdit2[i].Width + 10; // ������� ����� ��� �������� ��������
    labelNum.Top := spinEdit2[i].Top; // ��������� ������� ������ � SpinEdit
    labelNum.Caption := '�������' + IntToStr(i + 1); // ��������� ����������� ������ � ��������� Label
  end;
end;

end.
