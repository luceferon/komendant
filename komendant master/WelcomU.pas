unit WelcomU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, DBAccess, Uni, inifiles;

type
  TFMWelcom = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Button4: TButton;
    Button5: TButton;
    UniConnection1: TUniConnection;
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMWelcom: TFMWelcom;
  Uchastok, FileServ, Kladovchik, SysAdmin, NachUch: string;
  FirstRun, obchagaTUT:boolean;
  LockFileHandle: THandle;
  LockFileName: string;

implementation

{$R *.dfm}

uses ZaselenieU, NewU, DelU, OtpuskU, PereselenieU;



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
  close;
end;

procedure TFMWelcom.Button5Click(Sender: TObject);
begin
  FMPereselenie.ShowModal;
end;

procedure TFMWelcom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Удаляем файл блокировки при закрытии формы
  if LockFileHandle <> INVALID_HANDLE_VALUE then
  begin
    CloseHandle(LockFileHandle); // Закрываем дескриптор файла
    LockFileHandle := INVALID_HANDLE_VALUE; // Обнуляем дескриптор
    DeleteFile(PChar(LockFileName)); // Удаляем файл
  end;
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
end;

procedure TFMWelcom.FormShow(Sender: TObject);
begin
  if FirstRun=true then
  begin
     Button3.Enabled:=false;
  end;

  // Путь к файлу блокировки на удаленном компьютере
  LockFileName := '\\'+FileServ+'\smb_share\komendant\LockFile.lck';

  // Попытка создать или открыть файл блокировки для записи
  LockFileHandle := CreateFile(PChar(LockFileName), GENERIC_WRITE, 0, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);

  // Если файл уже существует и заблокирован другой программой
  if LockFileHandle = INVALID_HANDLE_VALUE then
  begin
    if GetLastError = ERROR_FILE_EXISTS then
    begin
      ShowMessage('Программа уже запущена на другом компьютере.');
      Application.Terminate;
      Exit; // Выходим из процедуры, не запуская программу
    end
    else
      RaiseLastOSError; // Другая ошибка, выбрасываем исключение
  end;

  // Если мы дошли до этой точки, значит программа не запущена на другом компьютере
  //ShowMessage('Программа запущена успешно.');

  // Здесь можно запустить основную логику программы
  // ...

end;

end.
