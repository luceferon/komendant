unit OtpuskU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TFMDokument = class(TForm)
    Label1: TLabel;
    DniEdit: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    DPOtpuskNachalo: TDatePicker;
    Label3: TLabel;
    DPOtpuskKonec: TDatePicker;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    CBObhodnoy: TCheckBox;
    CBOtpusk: TCheckBox;
    CBDengi: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FMDokument: TFMDokument;
  otpusk, obhodnoy, dengi:integer;

implementation

{$R *.dfm}

uses
  ZaselenieU, DownloadDocU;

procedure TFMDokument.Button1Click(Sender: TObject);
begin
   if CBOtpusk.Checked=true then
      otpusk:=1
   else
      otpusk:=0;
   if CBObhodnoy.Checked=true then
      obhodnoy:=1
   else
      obhodnoy:=0;
   if CBDengi.Checked=true then
      dengi:=1
   else
      dengi:=0;

   dni:= DniEdit.Text;
   otpusknachalo:= datetostr(DPOtpuskNachalo.Date);
   otpuskkonec:= datetostr(DPOtpuskKonec.Date);
   FMDownloadDoc.Show;
   FMDownloadDoc.ProgressBar1.Position:=10;
   if CheckBox1.Checked then
     FMZaselenie.PrintDocUval
   else
     FMZaselenie.PrintDocObhod;
   FMDownloadDoc.ProgressBar1.Position:=20;
   Close;
end;

procedure TFMDokument.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFMDokument.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    DPOtpuskNachalo.Visible:=false;
    DPOtpuskKonec.Visible:=false;
    label2.Visible:=false;
    label3.Visible:=false;
    GroupBox1.Visible:=false;
  end
  else
  begin
    DPOtpuskNachalo.Visible:=true;
    DPOtpuskKonec.Visible:=true;
    label2.Visible:=true;
    label3.Visible:=true;
    GroupBox1.Visible:=true;
  end;
end;

procedure TFMDokument.FormShow(Sender: TObject);
begin
  DniEdit.Text:='';
  DPOtpuskNachalo.Date:=now;
  DPOtpuskKonec.Date:=now;
end;

end.
