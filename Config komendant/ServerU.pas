unit ServerU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, DBAccess, Uni, Vcl.StdCtrls, MySQLUniProvider,
  MemDS, inifiles, cabfiles;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    UniConnection1: TUniConnection;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    Button4: TButton;
    UniQuery1: TUniQuery;
    Button5: TButton;
    CABFile1: TCABFile;
    Edit5: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Edit8: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  conn:boolean;
  balki, obchaga:integer;
  serverDB, userDB, passDB, DB, FileServer: string;
  Con: TUniConnection;
  Query: TUniQuery;

implementation

uses
  prozivanieU, mestaU;


{$R *.dfm}

procedure CreateHiddenFolder(const Path: string);
var
  SecurityAttributes: TSecurityAttributes;
  Folder: string;
begin
  Folder := IncludeTrailingPathDelimiter(Path) + 'komendant';

  // ��������� ���������, ����� ����� ���� �������
  SecurityAttributes.nLength := SizeOf(SecurityAttributes);
  SecurityAttributes.lpSecurityDescriptor := nil;
  SecurityAttributes.bInheritHandle := True;

  // �������� ����� � �������������� ����������
  CreateDirectory(PChar(Folder), @SecurityAttributes);
  SetFileAttributes(PChar(Folder), FILE_ATTRIBUTE_HIDDEN);
end;

procedure CreateMariaDBDatabase(const Server, UserName, Password: string; const DatabaseName: string);
var
  Connection: TUniConnection;
  Query: TUniQuery;
begin
  Connection := TUniConnection.Create(nil);
  try
    Connection.ProviderName := 'MySQL';
    Connection.Server := Server;
    Connection.Username := UserName;
    Connection.Password := Password;
    Connection.Database := '';

    Query := TUniQuery.Create(nil);
    try
      Query.Connection := Connection;

      // �������� ���� ������
      Query.SQL.Text := 'CREATE DATABASE ' + DatabaseName;
      Query.ExecSQL;

      ShowMessage('���� ������ ������� �������!');
    finally
      Query.Free;
    end;
  finally
    Connection.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     // ������������� ��������� ����������� � ���� ������
  UniConnection1.Server := Edit1.Text;
  UniConnection1.Username := Edit2.Text;
  UniConnection1.Password := Edit3.Text;

  try
    // �������� ���������� ���������� � ����� ������
    UniConnection1.Connected := True;

    // ���� ���������� ����������� �������, ������� ���������
    ShowMessage('���������� �����������');
    conn:=true;
    Button2.Enabled:=true;
    Edit1.Enabled:=false;
    Edit2.Enabled:=false;
    Edit3.Enabled:=false;
  except
    // ���� ��������� ������ ��� �����������, ������� ���������
    ShowMessage('������ ��� ��������� ����������');
    conn:=false;
    Button2.Enabled:=false;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   DB:='komendant';
   CreateMariaDBDatabase(Edit1.Text, Edit2.Text, Edit3.Text, DB);
   Button1.Enabled:=false;
   Button3.Enabled:=true;
   serverDB:=edit1.Text;
   userDB:=edit2.Text;
   passDB:=Edit3.Text;

   // ������� � ����������� ������ �����������
   Con := TUniConnection.Create(nil);
   Con.ProviderName := 'MySQL';
   Con.Server := serverDB;
   Con.Database := DB;
   Con.Username := userDB;
   Con.Password := passDB;
   Con.Connect;

   try
    // ������� ������� "balki"
    Query := TUniQuery.Create(nil);
    Query.Connection := Con;
    Query.SQL.Text := 'CREATE TABLE IF NOT EXISTS balki (' +
                      '����� VARCHAR(255), ' +
                      '���_��_���� VARCHAR(255), ' +
                      '���_���������� VARCHAR(255), ' +
                      '����������� VARCHAR(255), ' +
                      '����_������_������� VARCHAR(255), ' +
                      '��������� VARCHAR(255), ' +
                      '����������� VARCHAR(255), ' +
                      '����������_������� VARCHAR(255))';
    Query.ExecSQL;
        // ������� ������� "obchaga"
    Query.SQL.Text := 'CREATE TABLE IF NOT EXISTS obchaga (' +
                      '����� VARCHAR(255), ' +
                      '���_��_���� VARCHAR(255), ' +
                      '���_���������� VARCHAR(255), ' +
                      '����������� VARCHAR(255), ' +
                      '����_������_������� VARCHAR(255), ' +
                      '��������� VARCHAR(255), ' +
                      '����������� VARCHAR(255), ' +
                      '����������_������� VARCHAR(255))';
    Query.ExecSQL;
   finally
    Con.Close;
   end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form2.ShowModal;
  Button4.Enabled:=true;
  Edit4.Enabled:=false;
  Button2.Enabled:=false;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   Form3.ShowModal;
   Button5.Enabled:=true;
   Button3.Enabled:=false;
   Edit6.Enabled:=true;
   Edit7.Enabled:=true;
   Edit8.Enabled:=true;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  Ini, Ini2: Tinifile;
begin
  CreateHiddenFolder('\\'+ Edit5.Text + '\smb_share');

  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'conf.ini');
  Ini.WriteString('Uchastok','FileServ',Edit5.Text);
  Ini.Free;

  Ini2:=TiniFile.Create('\\'+ Edit5.Text + '\smb_share\komendant\conf.ini');
  ini2.WriteBool('FirstRun','FirstRun',true);
  Ini2.WriteString('Uchastok','Kladovchik',Edit6.Text);
  Ini2.WriteString('Uchastok','SysAdmin',Edit7.Text);
  Ini2.WriteString('Uchastok','NachUch',Edit8.Text);
  Ini2.WriteString('Connection','Server',Edit1.Text);
  Ini2.WriteString('Connection','User',Edit2.Text);
  Ini2.WriteString('Connection','Password',Edit3.Text);
  Ini2.WriteString('Connection','DB','komendant');
  Ini2.WriteString('Uchastok','Uchastok',Edit4.Text);
  Ini2.Free;

  CABFile1.CABFile:=extractfilepath(paramstr(0))+'conf.cab';
  CABFile1.GetContents;
  CABFile1.TargetPath:='\\'+ Edit5.Text + '\smb_share\komendant\';
  CABFile1.ExtractAll;
  Application.Terminate;
end;

end.
