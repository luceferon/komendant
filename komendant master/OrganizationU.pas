unit OrganizationU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFMOrganization = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMOrganization: TFMOrganization;

implementation

{$R *.dfm}

uses ZaselenieU;
var
  i:integer;

procedure TFMOrganization.Button1Click(Sender: TObject);
begin
  if i=1 then
  begin
    case chekgrid of
      1: FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= ComboBox1.Text;
      2: FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row]:= ComboBox1.Text;
    end;
    Close;
  end
  else ShowMessage('�������� ����������� � ������� �������� ���������');
end;

procedure TFMOrganization.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFMOrganization.ComboBox1Change(Sender: TObject);
begin
   i:=1;
end;

procedure TFMOrganization.FormShow(Sender: TObject);
begin
  ComboBox1.Text:='�������� �����������';
  ComboBox1.ItemIndex:=-1;
  i:=0;
end;

end.
