unit EditCommentU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFMEditComment = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMEditComment: TFMEditComment;

implementation

{$R *.dfm}

uses ZaselenieU;

procedure TFMEditComment.Button1Click(Sender: TObject);
begin
  case chekgrid of
    1: FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row]:= Edit1.Text;
    2: FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row]:= Edit1.Text;
  end;

  FMEditComment.Close;
end;

procedure TFMEditComment.Button2Click(Sender: TObject);
begin
   Close;
end;

procedure TFMEditComment.FormShow(Sender: TObject);
begin
  case chekgrid of
    1: Edit1.Text := FMZaselenie.advStringGrid1.Cells[FMZaselenie.advStringGrid1.Col, FMZaselenie.advStringGrid1.Row];
    2: Edit1.Text := FMZaselenie.advStringGrid3.Cells[FMZaselenie.advStringGrid3.Col, FMZaselenie.advStringGrid3.Row];
  end;
end;

end.
