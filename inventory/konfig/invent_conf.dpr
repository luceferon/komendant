program invent_conf;

uses
  Vcl.Forms,
  invent_confU in 'invent_confU.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
