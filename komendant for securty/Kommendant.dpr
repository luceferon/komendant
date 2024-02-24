program Kommendant;

uses
  Vcl.Forms,
  ZaselenieU in 'ZaselenieU.pas' {FMZaselenie},
  ExportU in 'ExportU.pas' {FMExport};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMZaselenie, FMZaselenie);
  Application.CreateForm(TFMExport, FMExport);
  Application.Run;
end.
