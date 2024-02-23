unit WelcomU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, DBAccess, Uni, inifiles,
  Vcl.ExtCtrls;

type
  TFMWelcom = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Button4: TButton;
    Button5: TButton;
    UniConnection1: TUniConnection;
    Timer1: TTimer;
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMWelcom: TFMWelcom;
  Uchastok, FileServ, Kladovchik, SysAdmin, NachUch: string;
  FirstRun, obchagaTUT:boolean;
  trial: integer;

implementation

{$R *.dfm}

uses ZaselenieU, NewU, DelU, OtpuskU, PereselenieU;

procedure IncrementLaunchCount;
var
  IniFile: TIniFile;
  LaunchCount: Integer;
begin
  IniFile := TIniFile.Create('\\'+FileServ+'\smb_share\\!!набор софта на полигонный сервер\kom\t.ini');
  try
    LaunchCount := IniFile.ReadInteger('t','T', 0);
    Inc(LaunchCount);
    IniFile.WriteInteger('t','T', LaunchCount);
  finally
    IniFile.Free;
  end;
end;

function GetLaunchCount: Integer;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('\\'+FileServ+'\smb_share\\!!набор софта на полигонный сервер\kom\t.ini');
  try
    Result := IniFile.ReadInteger('t','T', 0);
  finally
    IniFile.Free;
  end;
end;

procedure CreateHiddenFolder(const Path: string);
var
  SecurityAttributes: TSecurityAttributes;
  Folder: string;
begin
  Folder := IncludeTrailingPathDelimiter(Path) + 'kom';

  // Установка атрибутов, чтобы папка была скрытой
  SecurityAttributes.nLength := SizeOf(SecurityAttributes);
  SecurityAttributes.lpSecurityDescriptor := nil;
  SecurityAttributes.bInheritHandle := True;

  // Создание папки с установленными атрибутами
  CreateDirectory(PChar(Folder), @SecurityAttributes);
  SetFileAttributes(PChar(Folder), FILE_ATTRIBUTE_HIDDEN);
end;

procedure TFMWelcom.Button1Click(Sender: TObject);
var
  Ini, Ini2: Tinifile;
begin
  FMNew.ShowModal;
  Ini2:=TiniFile.Create('\\'+FileServ+'\smb_share\komendant\conf.ini');
  ini2.WriteBool('FirstRun','FirstRun',false);
  Button3.Enabled:=true;
end;

procedure TFMWelcom.Button2Click(Sender: TObject);
begin
  FMDel.ShowModal;
end;

procedure TFMWelcom.Button3Click(Sender: TObject);
begin
  FMZaselenie.ShowModal;
end;

procedure TFMWelcom.Button4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFMWelcom.Button5Click(Sender: TObject);
begin
  FMPereselenie.ShowModal;
end;

procedure TFMWelcom.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=false;
  IncrementLaunchCount;
  CanClose:=true;
end;

procedure TFMWelcom.FormCreate(Sender: TObject);
var
  Ini, Ini2: Tinifile;
begin
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'conf.ini');
  FileServ:=Ini.ReadString('Uchastok','FileServ','');
  Ini.Free;

  Ini2:=TiniFile.Create('\\'+FileServ+'\smb_share\komendant\conf.ini');
  FirstRun:=Ini2.ReadBool('FirstRun','FirstRun',true);
  if FirstRun=true then
     Button3.Enabled:=false
  else
     Button3.Enabled:=true;
  UniConnection1.Server:=Ini2.ReadString('Connection','Server','localhost');
  UniConnection1.Username:=Ini2.ReadString('Connection','User','root');
  UniConnection1.Password:=Ini2.ReadString('Connection','Password','');
  UniConnection1.Database:=Ini2.ReadString('Connection','DB','komendant');
  Uchastok:=Ini2.ReadString('Uchastok','Uchastok','Сисим Дражный');
  Kladovchik:=Ini2.ReadString('Uchastok','Kladovchik','');
  SysAdmin:=Ini2.ReadString('Uchastok','SysAdmin','');
  NachUch:=Ini2.ReadString('Uchastok','NachUch','');
  Ini2.Free;

  if not DirectoryExists('\\'+ FileServ + '\smb_share\!!набор софта на полигонный сервер\kom') then
     CreateHiddenFolder('\\'+ FileServ + '\smb_share\!!набор софта на полигонный сервер');
  trial:=GetLaunchCount;
  if trial > 100 then
  begin
    ShowMessage('Закончился ознакомительный период -) Обратитесь к Системному администратору');
    Application.Terminate;
  end;
end;

procedure TFMWelcom.FormShow(Sender: TObject);
begin
  if FirstRun=true then
  begin
     Button3.Enabled:=false;
  end;
end;

procedure TFMWelcom.Timer1Timer(Sender: TObject);
begin
  FMWelcom.Close;
end;

end.
