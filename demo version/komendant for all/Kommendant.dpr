program Kommendant;

uses
  Vcl.Forms,
  ZaselenieU in 'ZaselenieU.pas' {FMZaselenie},
  OtpuskU in 'OtpuskU.pas' {FMDokument},
  DownloadDocU in 'DownloadDocU.pas' {FMDownloadDoc},
  ExportU in 'ExportU.pas' {FMExport},
  ZpU in 'ZpU.pas' {FMZP};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMZaselenie, FMZaselenie);
  Application.CreateForm(TFMDokument, FMDokument);
  Application.CreateForm(TFMDownloadDoc, FMDownloadDoc);
  Application.CreateForm(TFMExport, FMExport);
  Application.CreateForm(TFMZP, FMZP);
  Application.Run;
end.
