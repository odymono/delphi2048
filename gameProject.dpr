program gameProject;

uses
  Vcl.Forms,
  game2048 in 'game2048.pas' {Form1},
  leaderboard in 'leaderboard.pas' {Form2},
  leaderadd in 'leaderadd.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
