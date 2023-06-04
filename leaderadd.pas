unit leaderadd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  TForm3 = class(TForm)
    StaticText1: TStaticText;
    DBEdit_Name: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    DBEdit_Score: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses game2048, leaderboard;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Form1.ADOQuery1.FieldByName('Score').asInteger := Score;
  if Form1.ADOQuery1.Modified then Form1.ADOQuery1.Post;
  ShowMessage('Record added!');
  Form1.ADOQuery1.ExecSQL;
  Form3.Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form1.ADOQuery1.Cancel;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Form1.ADOQuery1.Insert;
end;

end.
