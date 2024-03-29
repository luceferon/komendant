unit TelefoneU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type
  TFMTelefon = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Phone1: TMaskEdit;
    Phone2: TMaskEdit;
    Phone3: TMaskEdit;
    procedure Button2Click(Sender: TObject);
    procedure Phone1Change(Sender: TObject);
    procedure Phone2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Phone3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMTelefon: TFMTelefon;

implementation

{$R *.dfm}

uses ZaselenieU;
var
  zap:integer;

procedure TFMTelefon.Button1Click(Sender: TObject);
begin
  if zap=0 then
    ShowMessage('������� ���������� ������� ����������')
  else
  if zap=1 then
  begin
    case chekgrid of
    1:
      begin
        FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= phone1.Text;
      end;
    2:
      begin
        FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row]:= phone1.Text;
      end;
    end;
    close;
  end;
  if zap=2 then
  begin
    case chekgrid of
    1:
      begin
        FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= phone1.Text;
        if phone2.Enabled then
          FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= phone1.Text+', '+phone2.Text;
      end;
    2:
      begin
        FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row]:= phone1.Text;
        if phone2.Enabled then
          FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= phone1.Text+', '+phone2.Text;
      end;
    end;
    close;
  end;
  if zap=3 then
  begin
    case chekgrid of
    1:
      begin
        FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= phone1.Text;
        if phone2.Enabled then
          FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= phone1.Text+', '+phone2.Text;
        if phone3.Enabled then
          FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:=
            phone1.Text+', '+phone2.Text+', '+phone3.Text;
      end;
    2:
      begin
        FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row]:= phone1.Text;
        if phone2.Enabled then
          FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= phone1.Text+', '+phone2.Text;
        if phone3.Enabled then
          FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:=
            phone1.Text+', '+phone2.Text+', '+phone3.Text;
      end;
    end;
    close;
  end;
end;

procedure TFMTelefon.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFMTelefon.FormShow(Sender: TObject);
begin
  phone1.Text:='';
  phone2.Text:='';
  phone3.Text:='';
  phone2.Enabled:=false;
  phone3.Enabled:=false;
  zap:=0;
end;

procedure TFMTelefon.Phone1Change(Sender: TObject);
begin
  phone2.Enabled:=true;
  zap:=1;
end;

procedure TFMTelefon.Phone2Change(Sender: TObject);
begin
  phone3.Enabled:=true;
  zap:=2;
end;

procedure TFMTelefon.Phone3Change(Sender: TObject);
begin
  zap:=3;
end;

end.
