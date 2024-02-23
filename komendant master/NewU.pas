unit NewU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPickers, Vcl.StdCtrls, Data.DB,
  MemDS, DBAccess, Uni, Vcl.Mask;

type
  TFMNew = class(TForm)
    Label1: TLabel;
    CBkuda: TComboBox;
    Label2: TLabel;
    CBnomer: TComboBox;
    Efio: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    DPzaezd: TDatePicker;
    Label5: TLabel;
    CBprof: TComboBox;
    Label6: TLabel;
    Ecomment: TEdit;
    ListBox1: TListBox;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    UniQuery1: TUniQuery;
    Label8: TLabel;
    UniQuery2: TUniQuery;
    Label9: TLabel;
    UniQuery3: TUniQuery;
    CBOrganization: TComboBox;
    Phone1: TMaskEdit;
    Phone2: TMaskEdit;
    Phone3: TMaskEdit;
    Label10: TLabel;
    Label11: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure CBkudaChange(Sender: TObject);
    procedure EfioClick(Sender: TObject);
    procedure CBnomerChange(Sender: TObject);
    procedure EfioChange(Sender: TObject);
    procedure CBprofChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Phone1Change(Sender: TObject);
    procedure Phone2Change(Sender: TObject);
    procedure Phone3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMNew: TFMNew;


implementation
uses
  welcomu;

var
  tabl:string;
  zap: integer;
{$R *.dfm}

procedure TFMNew.Button1Click(Sender: TObject);
var
  query: TUniQuery;
  buttonSelected : Integer;
begin

  if ListBox1.Items.Count >= StrToInt(Label8.Caption) then
  begin
    buttonSelected := MessageDlg('��������������: � ������ ��������� ���-�� ����������� ����� ���� ������ ���������� ���������� ����. '+
    '������������� ������� �������� �������� ����?',mtError, mbYesNo, 0);
    if buttonSelected = mrNo then
      Exit;
    if buttonSelected = mrYes then
    begin
      try
// �������� ������� �������
        query := TUniQuery.Create(nil);

        query.Connection := FMWelcom.UniConnection1;

// �������� ������� � ������ �� ���������� ���������� tabl
        query.SQL.Text := 'SELECT * FROM ' + tabl;
        query.Open;

// ���������� ����� ������ � �������
        query.Append;
        if (tabl = 'balki') then
        begin
          query.FieldByName('�����').AsString := CBnomer.Text;
          query.FieldByName('���_��_����').AsString := Label8.Caption;
          query.FieldByName('�����������').AsString := CBOrganization.Text;
          if zap=1 then
            query.FieldByName('����������_�������').AsString := Phone1.Text;
          if zap=2 then
            query.FieldByName('����������_�������').AsString :=Phone1.Text+', '+ Phone2.Text;
          if zap=3 then
            query.FieldByName('����������_�������').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
        end else
          if (tabl = 'obchaga') then
          begin
            query.FieldByName('�����').AsString := CBnomer.Text;
            query.FieldByName('���_��_����').AsString := Label8.Caption;
            query.FieldByName('�����������').AsString := CBOrganization.Text;
            if zap=1 then
              query.FieldByName('����������_�������').AsString := Phone1.Text;
            if zap=2 then
              query.FieldByName('����������_�������').AsString :=Phone1.Text+', '+ Phone2.Text;
            if zap=3 then
              query.FieldByName('����������_�������').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
          end;

        query.FieldByName('���_����������').AsString := Efio.Text;
        query.FieldByName('�����������').AsString := Ecomment.Text;
        query.FieldByName('����_������_�������').AsString :=datetostr(DPzaezd.Date);
        query.FieldByName('���������').AsString := CBprof.Text;
        query.Post;

// �������� ���� ����������
        Close;
        except
        on E: Exception do
        begin
          ShowMessage('������ ���������� �������: ' + E.Message);
        end;
      end;
    end;
  end
  else
    begin
      try
// �������� ������� �������
        query := TUniQuery.Create(nil);

        query.Connection := FMWelcom.UniConnection1;

// �������� ������� � ������ �� ���������� ���������� tabl
        query.SQL.Text := 'SELECT * FROM ' + tabl;
        query.Open;

// ���������� ����� ������ � �������
        query.Append;
        if (tabl = 'balki') then
        begin
          query.FieldByName('�����').AsString := CBnomer.Text;
          query.FieldByName('���_��_����').AsString := Label8.Caption;
          query.FieldByName('�����������').AsString := CBOrganization.Text;
          if zap=1 then
            query.FieldByName('����������_�������').AsString := Phone1.Text;
          if zap=2 then
            query.FieldByName('����������_�������').AsString :=Phone1.Text+', '+ Phone2.Text;
          if zap=3 then
            query.FieldByName('����������_�������').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
        end else
          if (tabl = 'obchaga') then
          begin
            query.FieldByName('�����').AsString := CBnomer.Text;
            query.FieldByName('���_��_����').AsString := Label8.Caption;
            query.FieldByName('�����������').AsString := CBOrganization.Text;
            if zap=1 then
              query.FieldByName('����������_�������').AsString := Phone1.Text;
            if zap=2 then
              query.FieldByName('����������_�������').AsString :=Phone1.Text+', '+ Phone2.Text;
            if zap=3 then
              query.FieldByName('����������_�������').AsString := Phone1.Text+', '+ Phone2.Text+', '+ Phone3.Text;
          end;

        query.FieldByName('���_����������').AsString := Efio.Text;
        query.FieldByName('�����������').AsString := Ecomment.Text;
        query.FieldByName('����_������_�������').AsString :=datetostr(DPzaezd.Date);
        query.FieldByName('���������').AsString := CBprof.Text;
        query.Post;

// �������� ���� ����������
        Close;
        except
        on E: Exception do
        begin
          ShowMessage('������ ���������� �������: ' + E.Message);
        end;
      end;
    end;
end;

procedure TFMNew.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TFMNew.CBkudaChange(Sender: TObject);
var
  UniQuery1: TUniQuery;
begin
  CBnomer.Enabled:=true;
  case CBkuda.ItemIndex of
   0: begin
    tabl:='balki';
    Label2.Visible:=true;
    CBnomer.Visible:=true;
    Efio.Enabled:=false;
    // ����������� � ���� ������ MySQL
    FMWelcom.UniConnection1.Connect;

    // ������� ���������� �������� �� ������� "balki"
     UniQuery1 := TUniQuery.Create(nil);
     UniQuery1.Connection := FMWelcom.UniConnection1;
     UniQuery1.SQL.Text := 'SELECT DISTINCT `�����` FROM `balki`';
     UniQuery1.Open;

     // ���������� ComboBox2 ����������� ����������
     CBnomer.Clear;
     while not UniQuery1.Eof do
     begin
       CBnomer.Items.Add(UniQuery1.FieldByName('�����').AsString);
       UniQuery1.Next;
     end;

   end;
   1: begin
    tabl:='obchaga';
    Label2.Visible:=true;
    CBnomer.Visible:=true;
    Efio.Enabled:=false;
    // ����������� � ���� ������ MySQL
    FMWelcom.UniConnection1.Connect;

     // ������� ���������� �������� �� ������� "obchaga"
     UniQuery1 := TUniQuery.Create(nil);
     UniQuery1.Connection := FMWelcom.UniConnection1;
     UniQuery1.SQL.Text := 'SELECT DISTINCT `�����` FROM `obchaga`';
     UniQuery1.Open;

     // ���������� ComboBox2 ����������� ����������
     CBnomer.Clear;
     while not UniQuery1.Eof do
     begin
       CBnomer.Items.Add(UniQuery1.FieldByName('�����').AsString);
       UniQuery1.Next;
     end;

   end;
  end;

end;

procedure TFMNew.CBnomerChange(Sender: TObject);
var
  UniQuery1: TUniQuery;
begin
// ����������� � ���� ������ MySQL
  //con;

// ������� �������� �� ������� � ����������� �� ���������� ������ � ComboBox2
  case CBkuda.ItemIndex of
  0: begin
    UniQuery1 := TUniQuery.Create(nil);
    UniQuery1.Connection := FMWelcom.UniConnection1;
    UniQuery1.SQL.Text := 'SELECT `���_����������` FROM `balki` WHERE `�����` = :nomer';
    UniQuery1.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery1.Open;
    Efio.Enabled:=true;

    UniQuery2 := TUniQuery.Create(nil);
    UniQuery2.Connection := FMWelcom.UniConnection1;
    UniQuery2.SQL.Text := 'SELECT `���_��_����` FROM `balki` WHERE `�����` = :nomer';
    UniQuery2.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery2.Open;

    UniQuery3 := TUniQuery.Create(nil);
    UniQuery3.Connection := FMWelcom.UniConnection1;
    UniQuery3.SQL.Text := 'SELECT `�����������` FROM `balki`';
    UniQuery3.Open;

  if not UniQuery2.Eof then
    Label8.Caption := UniQuery2.FieldByName('���_��_����').AsString
  else
    Label8.Caption := '';

//  UniQuery2.Free;
  end;
  1: begin
    UniQuery1 := TUniQuery.Create(nil);
    UniQuery1.Connection := FMWelcom.UniConnection1;
    UniQuery1.SQL.Text := 'SELECT `���_����������` FROM `obchaga` WHERE `�����` = :nomer';
    UniQuery1.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery1.Open;
    Efio.Enabled:=true;

    UniQuery2 := TUniQuery.Create(nil);
    UniQuery2.Connection := FMWelcom.UniConnection1;
    UniQuery2.SQL.Text := 'SELECT `���_��_����` FROM `obchaga` WHERE `�����` = :nomer';
    UniQuery2.ParamByName('nomer').AsString := CBnomer.Text;
    UniQuery2.Open;
    if not UniQuery2.Eof then
      Label8.Caption := UniQuery2.FieldByName('���_��_����').AsString
    else
      Label8.Caption := '';
    end;
  end;

// ���������� ListBox1 ����������� ����������
  ListBox1.Clear;
  while not UniQuery1.Eof do
  begin
    ListBox1.Items.Add(UniQuery1.FieldByName('���_����������').AsString+' ');
    UniQuery1.Next;
  end;
  if ListBox1.Items.Count >= StrToInt(Label8.Caption) then
  begin
    label8.Font.Color:=clRed;
    label9.Font.Color:=clRed;
  end
  else
  begin
    label8.Font.Color:=clWindowText;
    label9.Font.Color:=clWindowText;
  end;

end;

procedure TFMNew.CBprofChange(Sender: TObject);
begin
  Button1.Enabled:=true;
end;

procedure TFMNew.EfioChange(Sender: TObject);
begin
  DPzaezd.Enabled:=true;
  Ecomment.Enabled:=true;
  CBprof.Enabled:=true;
  CBOrganization.Enabled:=true;
  Phone1.Enabled:=true;
end;

procedure TFMNew.EfioClick(Sender: TObject);
begin
  Efio.SelectAll;
end;

procedure TFMNew.FormShow(Sender: TObject);
begin
  // ����� ����� ���������
  CBkuda.ItemIndex := -1; // ��������� �������� "�� ���������" (-1)
  //����� �����(�������)
  CBnomer.Clear;
  CBnomer.Enabled := False;
  //���������
  CBprof.ItemIndex := -1;
  CBprof.Enabled := False;
  // ���
  Efio.Text := '���';
  Efio.Enabled := False;
  //���� ������
  DPzaezd.Date := Now;
  DPzaezd.Enabled := False;
  //����� �����������
  Ecomment.Text := '';
  Ecomment.Enabled := False;
  //������ ��� �����
  ListBox1.Clear;
  //���-�� ����
  Label8.Caption := '0';
  //������ ��������
  Button1.Enabled := False;
  Phone2.Enabled:=false;
  Phone3.Enabled:=false;
  zap:=0;
end;

procedure TFMNew.Phone1Change(Sender: TObject);
begin
   zap:=1;
   Phone2.Enabled:=true;
end;

procedure TFMNew.Phone2Change(Sender: TObject);
begin
   zap:=2;
   Phone3.Enabled:=true;
end;

procedure TFMNew.Phone3Change(Sender: TObject);
begin
   zap:=3;
end;

end.

