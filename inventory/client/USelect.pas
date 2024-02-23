unit USelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ToolPanels, Vcl.ExtCtrls,
  AdvPageControl, Vcl.ComCtrls, AdvGlowButton, Vcl.StdCtrls;

type
  TFMSelect = class(TForm)
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    AdvTabSheet3: TAdvTabSheet;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    AdvGlowButton7: TAdvGlowButton;
    AdvGlowButton8: TAdvGlowButton;
    AdvGlowButton9: TAdvGlowButton;
    AdvGlowButton10: TAdvGlowButton;
    AdvGlowButton12: TAdvGlowButton;
    AdvGlowButton13: TAdvGlowButton;
    AdvGlowButton14: TAdvGlowButton;
    AdvGlowButton15: TAdvGlowButton;
    AdvGlowButton16: TAdvGlowButton;
    AdvGlowButton17: TAdvGlowButton;
    AdvGlowButton18: TAdvGlowButton;
    AdvGlowButton19: TAdvGlowButton;
    AdvGlowButton20: TAdvGlowButton;
    AdvGlowButton21: TAdvGlowButton;
    AdvGlowButton22: TAdvGlowButton;
    AdvGlowButton23: TAdvGlowButton;
    AdvGlowButton24: TAdvGlowButton;
    AdvGlowButton25: TAdvGlowButton;
    AdvGlowButton26: TAdvGlowButton;
    AdvGlowButton27: TAdvGlowButton;
    AdvGlowButton28: TAdvGlowButton;
    AdvGlowButton29: TAdvGlowButton;
    AdvGlowButton30: TAdvGlowButton;
    AdvGlowButton31: TAdvGlowButton;
    AdvGlowButton32: TAdvGlowButton;
    AdvGlowButton33: TAdvGlowButton;
    AdvGlowButton34: TAdvGlowButton;
    AdvGlowButton36: TAdvGlowButton;
    AdvGlowButton37: TAdvGlowButton;
    AdvGlowButton39: TAdvGlowButton;
    AdvGlowButton40: TAdvGlowButton;
    AdvGlowButton41: TAdvGlowButton;
    AdvGlowButton43: TAdvGlowButton;
    AdvGlowButton54: TAdvGlowButton;
    AdvGlowButton59: TAdvGlowButton;
    AdvGlowButton61: TAdvGlowButton;
    AdvGlowButton69: TAdvGlowButton;
    AdvGlowButton71: TAdvGlowButton;
    AdvGlowButton72: TAdvGlowButton;
    AdvGlowButton73: TAdvGlowButton;
    AdvGlowButton75: TAdvGlowButton;
    AdvGlowButton86: TAdvGlowButton;
    AdvGlowButton91: TAdvGlowButton;
    AdvGlowButton11: TAdvGlowButton;
    procedure AdvGlowButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AdvGlowButton18Click(Sender: TObject);
    procedure AdvGlowButton3Click(Sender: TObject);
    procedure AdvGlowButton17Click(Sender: TObject);
    procedure AdvGlowButton16Click(Sender: TObject);
    procedure AdvGlowButton4Click(Sender: TObject);
    procedure AdvGlowButton14Click(Sender: TObject);
    procedure AdvGlowButton13Click(Sender: TObject);
    procedure AdvGlowButton10Click(Sender: TObject);
    procedure AdvGlowButton6Click(Sender: TObject);
    procedure AdvGlowButton15Click(Sender: TObject);
    procedure AdvGlowButton30Click(Sender: TObject);
    procedure AdvGlowButton26Click(Sender: TObject);
    procedure AdvGlowButton31Click(Sender: TObject);
    procedure AdvGlowButton22Click(Sender: TObject);
    procedure AdvGlowButton20Click(Sender: TObject);
    procedure AdvGlowButton25Click(Sender: TObject);
    procedure AdvGlowButton23Click(Sender: TObject);
    procedure AdvGlowButton12Click(Sender: TObject);
    procedure AdvGlowButton24Click(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure AdvGlowButton33Click(Sender: TObject);
    procedure AdvGlowButton19Click(Sender: TObject);
    procedure AdvGlowButton21Click(Sender: TObject);
    procedure AdvGlowButton27Click(Sender: TObject);
    procedure AdvGlowButton29Click(Sender: TObject);
    procedure AdvGlowButton8Click(Sender: TObject);
    procedure AdvGlowButton9Click(Sender: TObject);
    procedure AdvGlowButton7Click(Sender: TObject);
    procedure AdvGlowButton28Click(Sender: TObject);
    procedure AdvGlowButton5Click(Sender: TObject);
    procedure AdvGlowButton32Click(Sender: TObject);
    procedure AdvGlowButton11Click(Sender: TObject);
    procedure AdvGlowButton43Click(Sender: TObject);
    procedure AdvGlowButton40Click(Sender: TObject);
    procedure AdvGlowButton37Click(Sender: TObject);
    procedure AdvGlowButton41Click(Sender: TObject);
    procedure AdvGlowButton39Click(Sender: TObject);
    procedure AdvGlowButton36Click(Sender: TObject);
    procedure AdvGlowButton54Click(Sender: TObject);
    procedure AdvGlowButton59Click(Sender: TObject);
    procedure AdvGlowButton34Click(Sender: TObject);
    procedure AdvGlowButton61Click(Sender: TObject);
    procedure AdvGlowButton75Click(Sender: TObject);
    procedure AdvGlowButton72Click(Sender: TObject);
    procedure AdvGlowButton73Click(Sender: TObject);
    procedure AdvGlowButton71Click(Sender: TObject);
    procedure AdvGlowButton86Click(Sender: TObject);
    procedure AdvGlowButton91Click(Sender: TObject);
    procedure AdvGlowButton69Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMSelect: TFMSelect;
  pomechenie: string;

implementation

uses
  USpisokTMC;

{$R *.dfm}

procedure TFMSelect.AdvGlowButton10Click(Sender: TObject);
begin
  pomechenie:='balok9';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton11Click(Sender: TObject);
begin
  pomechenie:='vip';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton12Click(Sender: TObject);
begin
  pomechenie:='balok19';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton13Click(Sender: TObject);
begin
  pomechenie:='balok8';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton14Click(Sender: TObject);
begin
  pomechenie:='balok7';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton15Click(Sender: TObject);
begin
  pomechenie:='balok11';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton16Click(Sender: TObject);
begin
  pomechenie:='';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton17Click(Sender: TObject);
begin
  pomechenie:='balok4';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton18Click(Sender: TObject);
begin
  pomechenie:='balok2';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton19Click(Sender: TObject);
begin
  pomechenie:='balok23';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton1Click(Sender: TObject);
begin
  pomechenie:='balok21';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton20Click(Sender: TObject);
begin
  pomechenie:='balok16';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton21Click(Sender: TObject);
begin
  pomechenie:='balok24';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton22Click(Sender: TObject);
begin
  pomechenie:='balok15';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton23Click(Sender: TObject);
begin
  pomechenie:='balok18';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton24Click(Sender: TObject);
begin
  pomechenie:='balok20';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton25Click(Sender: TObject);
begin
  pomechenie:='balok17';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton26Click(Sender: TObject);
begin
  pomechenie:='balok13';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton27Click(Sender: TObject);
begin
  pomechenie:='balok25';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton28Click(Sender: TObject);
begin
  pomechenie:='balok1-1';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton29Click(Sender: TObject);
begin
  pomechenie:='balok26';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton2Click(Sender: TObject);
begin
  pomechenie:='balok1';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton30Click(Sender: TObject);
begin
  pomechenie:='balok12';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton31Click(Sender: TObject);
begin
  pomechenie:='balok14';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton32Click(Sender: TObject);
begin
  pomechenie:='balok-b-n';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton33Click(Sender: TObject);
begin
  pomechenie:='balok22';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton34Click(Sender: TObject);
begin
  pomechenie:='komnata9';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton36Click(Sender: TObject);
begin
  pomechenie:='komnata6';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton37Click(Sender: TObject);
begin
  pomechenie:='komnata3';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton39Click(Sender: TObject);
begin
  pomechenie:='komnata5';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton3Click(Sender: TObject);
begin
  pomechenie:='balok3';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton40Click(Sender: TObject);
begin
  pomechenie:='komnata2';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton41Click(Sender: TObject);
begin
  pomechenie:='komnata4';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton43Click(Sender: TObject);
begin
  pomechenie:='komnata1';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton4Click(Sender: TObject);
begin
  pomechenie:='balok6';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton54Click(Sender: TObject);
begin
  pomechenie:='komnata7';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton59Click(Sender: TObject);
begin
  pomechenie:='komnata8';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton5Click(Sender: TObject);
begin
  pomechenie:='mark';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton61Click(Sender: TObject);
begin
  pomechenie:='komnata10';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton69Click(Sender: TObject);
begin
  pomechenie:='kotelnaiy3';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton6Click(Sender: TObject);
begin
  pomechenie:='balok10';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton71Click(Sender: TObject);
begin
  pomechenie:='kotelnaiy1';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton72Click(Sender: TObject);
begin
  pomechenie:='bana';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton73Click(Sender: TObject);
begin
  pomechenie:='prachechnaiy';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton75Click(Sender: TObject);
begin
  pomechenie:='ITR';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton7Click(Sender: TObject);
begin
  pomechenie:='remka';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton86Click(Sender: TObject);
begin
  pomechenie:='sportzal';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton8Click(Sender: TObject);
begin
  pomechenie:='nachuch';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton91Click(Sender: TObject);
begin
  pomechenie:='kotelnaiy2';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.AdvGlowButton9Click(Sender: TObject);
begin
  pomechenie:='chopik';
  FMSpisokTMC.ShowModal;
end;

procedure TFMSelect.FormCreate(Sender: TObject);
begin
  pomechenie:='';
end;

end.
