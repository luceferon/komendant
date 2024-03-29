unit invent_confU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Uni, inifiles,
  Vcl.ComCtrls, UniProvider, MySQLUniProvider, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    UniConnection1: TUniConnection;
    PageControl1: TPageControl;
    MySQLUniProvider1: TMySQLUniProvider;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  FileServ: string;
  spin_holod, spin_tv, spin_moyka, spin_musik, spin_krovat, spin_chay, spin_nout,
    spin_printer, spin_vent, spin_micro, spin_tvpristavka, spin_obogrev, spin_telefone,
    spin_pilesos, spin_utug, spin_gladilka, spin_shkaf, spin_stol, spin_stul,
    spin_kotel, spin_lampa, spin_plita, spin_pech, spin_komod: Tspinedit;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  Query,Query2: TUniQuery;
  TabSheet: TTabSheet;
  Edit: TEdit;
  TabIndex, id_tmc, i, j: Integer;
  lab: Tlabel;
  spin, spin0, spin1, spin2, spin3, spin4, spin5, spin6, spin7, spin8, spin9, spin10,
    spin11, spin12, spin13, spin14, spin15, spin16, spin17, spin18, spin19,
      spin20, spin21, spin22, spin23: TSpinEdit;


{const
  SpinNames: array [1..24] of string = ('holod', 'tv', 'moyka', 'musik', 'krovat',
                                        'chay', 'nout', 'printer', 'vent', 'micro',
                                        'tvpristavka', 'obogrev', 'telefone', 'pilesos',
                                        'utug', 'gladilka', 'shkaf', 'stol', 'stul',
                                        'kotel', 'lampa', 'plita', 'pech', 'komod');}

begin
  Query := TUniQuery.Create(nil);
  Query2 := TUniQuery.Create(nil);
  try
    Query.Connection := UniConnection1;
    Query2.Connection := UniConnection1;
    Query.SQL.Text := 'INSERT INTO invent_num (id, number, inv_number) VALUES (:id, :number, :inv_number)';
    Query2.SQL.Text := 'INSERT INTO tmc_invent (id, id_house, kol_vo_tmc, sn_tmc, foto, type) VALUES (:id, :id_house, :kol_vo_tmc, :sn_tmc, :foto, :type)';
    id_tmc:=0;
    for TabIndex := 0 to PageControl1.PageCount - 1 do
    begin
      TabSheet := PageControl1.Pages[TabIndex];
      //id_tmc:=id_tmc+1;
      //Query2.ParamByName('id').AsInteger := id_tmc;
      // �������� ���������� ����� ������� � ���������� �� ����
      Query.ParamByName('id').AsInteger := TabIndex;
      Query2.ParamByName('id_house').AsInteger := TabIndex;

      // �������� ��� �������
      Query.ParamByName('number').AsString := TabSheet.Caption;

      // �������� ���������� ���������� Edit �� ������ �������
      Edit := TabSheet.FindComponent('Edit' + inttostr(TabIndex + 1)) as TEdit;
      if Assigned(Edit) then
      begin
        Query.ParamByName('inv_number').AsString := Edit.Text;
      end
      else
        Query.ParamByName('inv_number').Clear;

    {for i := 1 to 24 do
        begin
            spin := TabSheet.FindComponent('spin_' + SpinNames[i] + inttostr(TabIndex + 1)) as TSpinEdit;

            if Assigned(spin) and (spin.Value > 0) then
            begin
                for j := 1 to spin.Value do
                begin
                  Query2.ParamByName('kol_vo_tmc').AsInteger := spin.Value;
                  Query2.ParamByName('type').AsInteger := i;
                  id_tmc := id_tmc + 1;
                  Query2.ParamByName('id').AsInteger := id_tmc;
                  Query2.ExecSQL;
                end;
            end;
        end;}






      // �����������
      spin0 := TabSheet.FindComponent('spin_holod' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin0) then
      begin
        if spin0.Value=0 then
        //exit
        //Break
        else
        begin
          for i := 1 to spin0.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin0.Value;
            Query2.ParamByName('type').AsInteger := 1;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //���������
      spin1 := TabSheet.FindComponent('spin_tv' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin1) then
      begin
        if spin1.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin1.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin1.Value;
            Query2.ParamByName('type').AsInteger := 2;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //�����
      spin2 := TabSheet.FindComponent('spin_moyka' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin2) then
      begin
        if spin2.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin2.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin2.Value;
            Query2.ParamByName('type').AsInteger := 3;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //������
      spin3 := TabSheet.FindComponent('spin_musik' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin3) then
      begin
        if spin3.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin3.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin3.Value;
            Query2.ParamByName('type').AsInteger := 4;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //�������
      spin4 := TabSheet.FindComponent('spin_krovat' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin4) then
      begin
      if spin4.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin4.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin4.Value;
            Query2.ParamByName('type').AsInteger := 5;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // ������
      spin5 := TabSheet.FindComponent('spin_chay' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin5) then
      begin
      if spin5.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin5.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin5.Value;
            Query2.ParamByName('type').AsInteger := 6;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // �������
      spin6 := TabSheet.FindComponent('spin_nout' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin6) then
      begin
      if spin6.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin6.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin6.Value;
            Query2.ParamByName('type').AsInteger := 7;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //�������
      spin7 := TabSheet.FindComponent('spin_printer' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin7) then
      begin
      if spin7.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin7.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin7.Value;
            Query2.ParamByName('type').AsInteger := 8;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //����������
      spin8 := TabSheet.FindComponent('spin_vent' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin8) then
      begin
      if spin8.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin8.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin8.Value;
            Query2.ParamByName('type').AsInteger := 9;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // �������������
      spin9 := TabSheet.FindComponent('spin_micro' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin9) then
      begin
      if spin9.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin9.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin9.Value;
            Query2.ParamByName('type').AsInteger := 10;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //��-���������
      spin10 := TabSheet.FindComponent('spin_tvpristavka' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin10) then
      begin
        if spin10.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin10.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin10.Value;
            Query2.ParamByName('type').AsInteger := 11;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // ������������
      spin11 := TabSheet.FindComponent('spin_obogrev' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin11) then
      begin
        if spin11.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin11.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin11.Value;
            Query2.ParamByName('type').AsInteger := 12;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //�������
      spin12 := TabSheet.FindComponent('spin_telefone' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin12) then
      begin
        if spin12.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin12.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin12.Value;
            Query2.ParamByName('type').AsInteger := 13;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // �������
      spin13 := TabSheet.FindComponent('spin_pilesos' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin13) then
      begin
        if spin13.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin13.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin13.Value;
            Query2.ParamByName('type').AsInteger := 14;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // ����
      spin14 := TabSheet.FindComponent('spin_utug' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin14) then
      begin
        if spin14.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin14.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin14.Value;
            Query2.ParamByName('type').AsInteger := 15;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //��������
      spin15 := TabSheet.FindComponent('spin_gladilka' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin15) then
      begin
        if spin15.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin15.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin15.Value;
            Query2.ParamByName('type').AsInteger := 16;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //����
      spin16 := TabSheet.FindComponent('spin_shkaf' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin16) then
      begin
        if spin16.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin16.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin16.Value;
            Query2.ParamByName('type').AsInteger := 17;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // ����
      spin17 := TabSheet.FindComponent('spin_stol' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin17) then
      begin
        if spin17.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin17.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin17.Value;
            Query2.ParamByName('type').AsInteger := 18;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //����
      spin18 := TabSheet.FindComponent('spin_stul' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin18) then
      begin
        if spin18.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin18.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin18.Value;
            Query2.ParamByName('type').AsInteger := 19;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //�����
      spin19 := TabSheet.FindComponent('spin_kotel' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin19) then
      begin
        if spin19.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin19.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin19.Value;
            Query2.ParamByName('type').AsInteger := 20;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //�����
      spin20 := TabSheet.FindComponent('spin_lampa' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin20) then
      begin
        if spin20.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin20.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin20.Value;
            Query2.ParamByName('type').AsInteger := 21;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //������
      spin21 := TabSheet.FindComponent('spin_plita' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin21) then
      begin
        if spin21.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin21.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin21.Value;
            Query2.ParamByName('type').AsInteger := 22;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      //�����
      spin22 := TabSheet.FindComponent('spin_pech' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin22) then
      begin
        if spin22.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin22.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin22.Value;
            Query2.ParamByName('type').AsInteger := 23;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      // �����
      spin23 := TabSheet.FindComponent('spin_komod' + inttostr(TabIndex + 1)) as TSpinEdit;
      if Assigned(spin23) then
      begin
        if spin23.Value=0 then
        //exit
        else
        begin
          for i := 1 to spin23.Value do
          begin
            Query2.ParamByName('kol_vo_tmc').AsInteger := spin23.Value;
            Query2.ParamByName('type').AsInteger := 24;
            id_tmc:=id_tmc+1;
            Query2.ParamByName('id').AsInteger := id_tmc;
            Query2.ExecSQL;
          end;
        end;
      end;

      Query.ExecSQL;
      Query2.ExecSQL;
    end;
  finally
    Query.Free;
    Query2.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  Ini, Ini2: Tinifile;
  Query: TUniQuery;
  TableValues: TStringList;
  i, StartTop, NumSpinedits, SpineditWidth, SpineditHeight, SpineditTop, j: Integer;
  TabSheet: TTabSheet;
  lab, lab2: Tlabel;
  Edit: Tedit;
  Spinedit:Tspinedit;
const
  ItemNames: array[0..23] of string = ('���-�� �������������', '���-�� �����������', '���-�� ������������', '���-�� ���. �������',
   '���-�� ��������', '���-�� ��������(����������)', '���-�� ���������', '���-�� ���������', '���-�� ������������',
   '���-�� ������������� �����', '���-�� ��-���������', '���-�� �������������', '���-�� ���������', '���-�� ���������',
    '���-�� ������', '���-�� ���������� �����', '���-�� ������', '���-�� ������', '���-�� �������(������)', '���-�� ������',
     '���-�� ����(����������)', '���-�� ������(�������, �������)', '���-�� �����(�������)', '���-�� �������');
begin
//��������� ������������ ����������� � ��
  Ini:=TiniFile.Create(extractfilepath(paramstr(0))+'conf.ini');
  FileServ:=Ini.ReadString('Uchastok','FileServ','');
  Ini.Free;
  Ini2:=TiniFile.Create('\\'+FileServ+'\smb_share\komendant\conf.ini');
  UniConnection1.Server:=Ini2.ReadString('Connection','Server','localhost');
  UniConnection1.Username:=Ini2.ReadString('Connection','User','root');
  UniConnection1.Password:=Ini2.ReadString('Connection','Password','');
  UniConnection1.Database:=Ini2.ReadString('Connection','DB','komendant');
  Ini2.Free;

  //������� ��������� ������� ��� ������� �����
  Query := TUniQuery.Create(nil);
  TableValues := TStringList.Create;

  try
    Query.Connection := UniConnection1;
    Query.SQL.Text := 'SELECT DISTINCT ����� FROM balki';
    Query.Open;

    while not Query.EOF do
    begin
      TableValues.Add(Query.FieldByName('�����').AsString);
      Query.Next;
    end;

    for i := 0 to TableValues.Count - 1 do
    begin
      TabSheet := TTabSheet.Create(PageControl1);
      TabSheet.Caption := TableValues[i];
      TabSheet.PageControl := PageControl1;
      Lab := TLabel.Create(TabSheet);
      Lab.Parent := TabSheet;
      Lab.Left := 10;
      Lab.Name:='Lab'+inttostr(i+1);
      lab.Caption:='������� ����������� ����� ���������: '+TableValues[i];

      Edit := TEdit.Create(TabSheet);
      Edit.Parent := TabSheet;
      Edit.top := 20;
      Edit.Left := 10;
      Edit.Name:='Edit'+inttostr(i+1);
      Edit.Text:='';

      // �������� Spinedit
      StartTop := Edit.Top + Edit.Height + 20; // ��������� ������� top ��� Spinedit
      NumSpinedits := 24; // ���������� Spinedit
      SpineditWidth := (TabSheet.ClientWidth - 10) div 3; // ������ Spinedit
      SpineditHeight := (TabSheet.ClientHeight - StartTop - 10) div 8; // ������ Spinedit
      SpineditTop := StartTop;

      for j := 1 to NumSpinedits do
      begin
        Spinedit := TSpinEdit.Create(TabSheet);
        Spinedit.Parent := TabSheet;
        Spinedit.Left := ((j - 1) mod 3) * (SpineditWidth + 5) + 10;
        Spinedit.Top := SpineditTop;
        Spinedit.Width := SpineditWidth;
        Spinedit.Height := SpineditHeight;
        Spinedit.Name := 'spin_' + IntToStr(j);
        Spinedit.Top := SpineditTop + ((j - 1) div 3) * (SpineditHeight + 5);

        case j of
          1: Spinedit.name := 'spin_holod'+inttostr(i+1);
          2: Spinedit.name := 'spin_tv'+inttostr(i+1);
          3: Spinedit.name := 'spin_moyka'+inttostr(i+1);
          4: Spinedit.name := 'spin_musik'+inttostr(i+1);
          5: Spinedit.name := 'spin_krovat'+inttostr(i+1);
          6: Spinedit.name := 'spin_chay'+inttostr(i+1);
          7: Spinedit.name := 'spin_nout'+inttostr(i+1);
          8: Spinedit.name := 'spin_printer'+inttostr(i+1);
          9: Spinedit.name := 'spin_vent'+inttostr(i+1);
          10: Spinedit.name := 'spin_micro'+inttostr(i+1);
          11: Spinedit.name := 'spin_tvpristavka'+inttostr(i+1);
          12: Spinedit.name := 'spin_obogrev'+inttostr(i+1);
          13: Spinedit.name := 'spin_telefone'+inttostr(i+1);
          14: Spinedit.name := 'spin_pilesos'+inttostr(i+1);
          15: Spinedit.name := 'spin_utug'+inttostr(i+1);
          16: Spinedit.name := 'spin_gladilka'+inttostr(i+1);
          17: Spinedit.name := 'spin_shkaf'+inttostr(i+1);
          18: Spinedit.name := 'spin_stol'+inttostr(i+1);
          19: Spinedit.name := 'spin_stul'+inttostr(i+1);
          20: Spinedit.name := 'spin_kotel'+inttostr(i+1);
          21: Spinedit.name := 'spin_lampa'+inttostr(i+1);
          22: Spinedit.name := 'spin_plita'+inttostr(i+1);
          23: Spinedit.name := 'spin_pech'+inttostr(i+1);
          24: Spinedit.name := 'spin_komod'+inttostr(i+1);
        end;

        // �������� Label'� ��� Spinedit'��

        Lab2 := TLabel.Create(TabSheet);
        Lab2.Parent := TabSheet;
        Lab2.Left := Spinedit.Left;
        Lab2.Top := Spinedit.Top - 20;
        Lab2.Caption := ItemNames[j-1];
      end;
    end;
  finally
    Query.Free;
    TableValues.Free;
  end;
end;

end.
