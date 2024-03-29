unit DateU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPickers;

type
  TFMDate = class(TForm)
    Button2: TButton;
    Button1: TButton;
    DatePicker1: TDatePicker;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMDate: TFMDate;

implementation

{$R *.dfm}

uses ZaselenieU;

procedure TFMDate.Button1Click(Sender: TObject);
begin
  case chekgrid of
    1: FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= DateToStr(DatePicker1.Date);
    2: FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row]:= DateToStr(DatePicker1.Date);
  end;

  FMDate.Close;
end;

procedure TFMDate.Button2Click(Sender: TObject);
begin
  FMDate.Close;
end;

procedure TFMDate.FormShow(Sender: TObject);
var
  UserInput, FirstDateStr, SecondDateStr: string;
  FirstDate, SecondDate: TDate;
  SeparatorPos: Integer;
begin
  case chekgrid of
    1:
    begin
       UserInput :=  FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row];
       SeparatorPos := Pos('-', UserInput); // ����� ������� �����������

       if SeparatorPos > 0 then
       begin
    // ������ ���� "��.��.���� - ��.��.����"
          FirstDateStr := Trim(Copy(UserInput, 1, SeparatorPos - 1));
          SecondDateStr := Trim(Copy(UserInput, SeparatorPos + 1, Length(UserInput) - SeparatorPos));

    // �������������� ������ ����
          try
            FirstDate := StrToDate(FirstDateStr);
          except
            on EConvertError do
            begin
                ShowMessage('������������ ������ ����!');
                Exit;
            end;
          end;

    // �������������� ������ ����
          try
            SecondDate := StrToDate(SecondDateStr);
          except
            on EConvertError do
            begin
              ShowMessage('������������ ������ ����!');
              Exit;
            end;
          end;

    // ��������� ������ ���� � ��������� DatePicker (� ������ DatePicker1)
          DatePicker1.Date := SecondDate;
       end
      else
      begin
    // ������ ���� "��.��.����"
        try
          FirstDate := StrToDate(UserInput);
          SecondDate := FirstDate;
        except
          on EConvertError do
          begin
            ShowMessage('������������ ����!');
            Exit;
          end;
        end;

    // ��������� ���� � ��������� DatePicker (� ������ DatePicker1)
      DatePicker1.Date := FirstDate;
      end;
    end;
    2:
    begin
       UserInput :=  FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row];
       SeparatorPos := Pos('-', UserInput); // ����� ������� �����������

       if SeparatorPos > 0 then
       begin
    // ������ ���� "��.��.���� - ��.��.����"
          FirstDateStr := Trim(Copy(UserInput, 1, SeparatorPos - 1));
          SecondDateStr := Trim(Copy(UserInput, SeparatorPos + 1, Length(UserInput) - SeparatorPos));

    // �������������� ������ ����
          try
            FirstDate := StrToDate(FirstDateStr);
          except
            on EConvertError do
            begin
                ShowMessage('������������ ������ ����!');
                Exit;
            end;
          end;

    // �������������� ������ ����
          try
            SecondDate := StrToDate(SecondDateStr);
          except
            on EConvertError do
            begin
              ShowMessage('������������ ������ ����!');
              Exit;
            end;
          end;

    // ��������� ������ ���� � ��������� DatePicker (� ������ DatePicker1)
          DatePicker1.Date := SecondDate;
       end
      else
      begin
    // ������ ���� "��.��.����"
        try
          FirstDate := StrToDate(UserInput);
          SecondDate := FirstDate;
        except
          on EConvertError do
          begin
            ShowMessage('������������ ����!');
            Exit;
          end;
        end;

    // ��������� ���� � ��������� DatePicker (� ������ DatePicker1)
        DatePicker1.Date := FirstDate;
      end;
    end;
  end;
end;

end.
