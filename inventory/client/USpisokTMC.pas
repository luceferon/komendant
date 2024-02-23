unit USpisokTMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFMSpisokTMC = class(TForm)
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMSpisokTMC: TFMSpisokTMC;

implementation

uses
  USelect;

{$R *.dfm}

procedure TFMSpisokTMC.FormShow(Sender: TObject);
begin
  if pomechenie<>'' then
    if pomechenie='balok1' then
      Label1.Caption:='balok1'
    else
    if pomechenie='balok2' then
      Label1.Caption:='balok2'
    else
    if pomechenie='balok3' then
      Label1.Caption:='balok3'
    else
    if pomechenie='balok4' then
      Label1.Caption:='balok4'
    else
    if pomechenie='balok5' then
      Label1.Caption:='balok5'
    else
    if pomechenie='balok6' then
      Label1.Caption:='balok6'
    else
    if pomechenie='balok7' then
      Label1.Caption:='balok7'
    else
    if pomechenie='balok8' then
      Label1.Caption:='balok8'
    else
    if pomechenie='balok9' then
      Label1.Caption:='balok9'
    else
    if pomechenie='balok10' then
      Label1.Caption:='balok10'
    else
    if pomechenie='balok11' then
      Label1.Caption:='balok11'
    else
    if pomechenie='balok12' then
      Label1.Caption:='balok12'
    else
    if pomechenie='balok13' then
      Label1.Caption:='balok13'
    else
    if pomechenie='balok14' then
      Label1.Caption:='balok14'
    else
    if pomechenie='balok15' then
      Label1.Caption:='balok15'
    else
    if pomechenie='balok16' then
      Label1.Caption:='balok16'
    else
    if pomechenie='balok17' then
      Label1.Caption:='balok17'
    else
    if pomechenie='balok18' then
      Label1.Caption:='balok18'
    else
    if pomechenie='balok19' then
      Label1.Caption:='balok19'
    else
    if pomechenie='balok20' then
      Label1.Caption:='balok20'
    else
    if pomechenie='balok21' then
      Label1.Caption:='balok21'
    else
    if pomechenie='balok22' then
      Label1.Caption:='balok22'
    else
    if pomechenie='balok23' then
      Label1.Caption:='balok23'
    else
    if pomechenie='balok24' then
      Label1.Caption:='balok24'
    else
    if pomechenie='balok25' then
      Label1.Caption:='balok25'
    else
    if pomechenie='balok26' then
      Label1.Caption:='balok26'
    else
    if pomechenie='nachuch' then
      Label1.Caption:='nachuch'
    else
    if pomechenie='chopik' then
      Label1.Caption:='chopik'
    else
    if pomechenie='remka' then
      Label1.Caption:='remka'
    else
    if pomechenie='balok1-1' then
      Label1.Caption:='balok1-1'
    else
    if pomechenie='mark' then
      Label1.Caption:='mark'
    else
    if pomechenie='balok-b-n' then
      Label1.Caption:='balok-b-n'
    else
    if pomechenie='vip' then
      Label1.Caption:='vip'
    else
    if pomechenie='komnata1' then
      Label1.Caption:='komnata1'
    else
    if pomechenie='komnata2' then
      Label1.Caption:='komnata2'
    else
    if pomechenie='komnata3' then
      Label1.Caption:='komnata3'
    else
    if pomechenie='komnata4' then
      Label1.Caption:='komnata4'
    else
    if pomechenie='komnata5' then
      Label1.Caption:='komnata5'
    else
    if pomechenie='komnata6' then
      Label1.Caption:='komnata6'
    else
    if pomechenie='komnata7' then
      Label1.Caption:='komnata7'
    else
    if pomechenie='komnata8' then
      Label1.Caption:='komnata8'
    else
    if pomechenie='komnata9' then
      Label1.Caption:='komnata9'
    else
    if pomechenie='komnata10' then
      Label1.Caption:='komnata10'
    else
    if pomechenie='ITR' then
      Label1.Caption:='ITR'
    else
    if pomechenie='prachechnaiy' then
      Label1.Caption:='prachechnaiy'
    else
    if pomechenie='sportzal' then
      Label1.Caption:='sportzal'
    else
    if pomechenie='kotelnaiy1' then
      Label1.Caption:='kotelnaiy1'
    else
    if pomechenie='kotelnaiy2' then
      Label1.Caption:='kotelnaiy2'
    else
    if pomechenie='kotelnaiy3' then
      Label1.Caption:='kotelnaiy3'
    else
    if pomechenie='bana' then
      Label1.Caption:='bana';
end;

end.
