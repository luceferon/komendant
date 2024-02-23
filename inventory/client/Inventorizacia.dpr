program Inventorizacia;

uses
  Vcl.Forms,
  USelect in 'USelect.pas' {FMSelect},
  USpisokTMC in 'USpisokTMC.pas' {FMSpisokTMC};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMSelect, FMSelect);
  Application.CreateForm(TFMSpisokTMC, FMSpisokTMC);
  Application.Run;
end.
