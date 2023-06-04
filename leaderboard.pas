unit leaderboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Score1: TLabel;
    Name1: TLabel;
    Name2: TLabel;
    Name3: TLabel;
    Name4: TLabel;
    Name5: TLabel;
    Name6: TLabel;
    Name7: TLabel;
    Name8: TLabel;
    Score2: TLabel;
    Score3: TLabel;
    Score4: TLabel;
    Score5: TLabel;
    Score6: TLabel;
    Score7: TLabel;
    Score8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses game2048, leaderadd;

procedure TForm2.FormCreate(Sender: TObject);
begin

  Form1.ADOQuery1.RecNo:= 1;
  Name1.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score1.Caption := Form1.ADOQuery1.Fields[2].AsString;

  Form1.ADOQuery1.RecNo:= 2;
  Name2.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score2.Caption := Form1.ADOQuery1.Fields[2].AsString;

  Form1.ADOQuery1.RecNo:= 3;
  Name8.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score3.Caption := Form1.ADOQuery1.Fields[2].AsString;

  Form1.ADOQuery1.RecNo:= 4;
  Name7.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score4.Caption := Form1.ADOQuery1.Fields[2].AsString;

  Form1.ADOQuery1.RecNo:= 5;
  Name6.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score5.Caption := Form1.ADOQuery1.Fields[2].AsString;

  Form1.ADOQuery1.RecNo:= 6;
  Name5.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score6.Caption := Form1.ADOQuery1.Fields[2].AsString;

  Form1.ADOQuery1.RecNo:= 7;
  Name4.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score7.Caption := Form1.ADOQuery1.Fields[2].AsString;

  Form1.ADOQuery1.RecNo:= 8;
  Name3.Caption := Form1.ADOQuery1.Fields[1].AsString;
  Score8.Caption := Form1.ADOQuery1.Fields[2].AsString;

end;

end.
