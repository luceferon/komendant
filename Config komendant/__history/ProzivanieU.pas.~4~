unit ProzivanieU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TForm2 = class(TForm)
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  serverU;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
   balki:=SpinEdit1.Value;
   obchaga:=SpinEdit2.Value;
   Form2.Close;
end;

end.
