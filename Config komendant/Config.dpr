program Config;

uses
  Vcl.Forms,
  ServerU in 'ServerU.pas' {Form1},
  ProzivanieU in 'ProzivanieU.pas' {Form2},
  mestaU in 'mestaU.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
