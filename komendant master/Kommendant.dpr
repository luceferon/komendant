program Kommendant;

uses
  Vcl.Forms,
  WelcomU in 'WelcomU.pas' {FMWelcom},
  ZaselenieU in 'ZaselenieU.pas' {FMZaselenie},
  NewU in 'NewU.pas' {FMNew},
  DelU in 'DelU.pas' {FMDel},
  EditCommentU in 'EditCommentU.pas' {FMEditComment},
  DateU in 'DateU.pas' {FMDate},
  OrganizationU in 'OrganizationU.pas' {FMOrganization},
  TelefoneU in 'TelefoneU.pas' {FMTelefon},
  OtpuskU in 'OtpuskU.pas' {FMDokument},
  DownloadDocU in 'DownloadDocU.pas' {FMDownloadDoc},
  PereselenieU in 'PereselenieU.pas' {FMPereselenie},
  ExportU in 'ExportU.pas' {FMExport},
  ZpU in 'ZpU.pas' {FMZP};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMWelcom, FMWelcom);
  Application.CreateForm(TFMZaselenie, FMZaselenie);
  Application.CreateForm(TFMNew, FMNew);
  Application.CreateForm(TFMDel, FMDel);
  Application.CreateForm(TFMEditComment, FMEditComment);
  Application.CreateForm(TFMDate, FMDate);
  Application.CreateForm(TFMOrganization, FMOrganization);
  Application.CreateForm(TFMTelefon, FMTelefon);
  Application.CreateForm(TFMDokument, FMDokument);
  Application.CreateForm(TFMDownloadDoc, FMDownloadDoc);
  Application.CreateForm(TFMPereselenie, FMPereselenie);
  Application.CreateForm(TFMExport, FMExport);
  Application.CreateForm(TFMZP, FMZP);
  Application.Run;
end.
