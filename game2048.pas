unit game2048;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Skia, Skia.Vcl, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls;
const
  RecordFileName: String = 'records.dbf';
type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Memo1: TMemo;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ScoreMain: TLabel;
    Label1: TLabel;
    ScoreCounter: TLabel;
    VictoryAnimation: TSkAnimatedImage;
    LosingAnimation: TSkAnimatedImage;
    MainScreen: TSkAnimatedImage;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    ADOConnection1: TADOConnection;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure moveDown();
    procedure moveUp();
    procedure moveLeft();
    procedure moveRight();
    procedure putTwo(var n:integer);
    procedure startgame();
    procedure startgamekey();
    procedure putBonus(var n:integer);
    procedure putAddBonus(var n:integer);
    procedure bombBonus();
    procedure addBonus();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Buf,WinImg:TBitMap;
  Path:string;
  map:array[0..3,0..3] of integer;
  img:array[0..18] of TBitMap;
  Score,BestScore:integer;

implementation

{$R *.dfm}

uses leaderboard_good, leaderboard, leaderadd;

procedure TForm1.bombBonus();
var i,j,maxI,maxJ,maxNum:integer;
begin
  maxNum := map[0,0];
  for I := 0 to 3 do
      for j := 0 to 3 do
          if (map[i,j] > maxNum) and (map[i,j] <> 100) then
          begin
            maxNum := map[i,j];
            maxI := i;
            maxJ := j;
          end;
  for I := 0 to 3 do
      for j := 0 to 3 do
      begin
        map[i,j] := 0;
      end;
  map[maxI,maxJ] := maxNum;
  Score := maxNum;
end;

procedure TForm1.addBonus();
var
  I: Integer;
  j: Integer;
begin
  for I := 0 to 3 do
    for j := 0 to 3 do
      begin
        if map[i,j] = 102 then
          begin
            map[i,j] := 0;
            Score := Score + 128
          end
        else if map[i,j] = 101 then
          begin
            map[i,j] := 0;
            Score := Score - 128;
          end;
      end;
end;


procedure TForm1.moveDown();
var i,j :integer;
begin
  for i := 0 to 3 do
  for j := 0 to 2 do
      begin
          if (map[i,j] > 0) and (map[i,j+1] = 0) then
        begin
          map[i,j+1] := map[i,j];
          map[i,j] := 0;
        end;
          if (map[i,j] > 0) and (map[i,j+1] = map[i,j]) and (map[i,j+1] <> 100) and (map[i,j+1] <> 101) and (map[i,j+1] <> 102) then
        begin
          Score := Score + map[i,j];
          map[i,j+1] := map[i,j] * 2;
          map[i,j] := 0;
        end
        else if (map[i,j] > 0) and (map[i,j+1] = 100) then
             begin
               bombBonus();
             end
        else if (map[i,j] > 0) and ((map[i,j+1] = 101) or (map[i,j+1] = 102)) then
             begin
              addBonus();
             end;
      end;
end;

procedure TForm1.moveUp();
var i,j:integer;
begin
      for i := 0 to 3 do
      begin
      j := 3;
          while (j > 0) do
          begin
            if (map[i,j] > 0) and (map[i,j-1] = 0) then
              begin
                map[i,j-1] := map[i,j];
                map[i,j] := 0;
              end;
            if (map[i,j] > 0) and (map[i,j-1] = map[i,j]) and (map[i,j-1] <> 100) and (map[i,j-1] <> 101) and (map[i,j-1] <> 102) then
              begin
                Score := Score + map[i,j];
                map[i,j-1] := map[i,j] * 2;
                map[i,j] := 0;
              end
            else if (map[i,j] > 0) and (map[i,j-1] = 100) then
               begin
                 bombBonus();
               end
            else if (map[i,j] > 0) and ((map[i,j-1] = 101) or (map[i,j-1] = 102)) then
              begin
                addBonus();
              end;

          j := j - 1;
        end;
      end;
end;

procedure TForm1.moveLeft();
var i,j:integer;
begin
      for j := 0 to 3 do
      begin
      i := 3;
          while (i > 0) do
          begin
            if (map[i,j] > 0) and (map[i-1,j] = 0) then
            begin
              map[i-1,j] := map[i,j];
              map[i,j] := 0;
            end;
            if (map[i,j] > 0) and (map[i-1,j] = map[i,j]) and (map[i-1,j] <> 100) and (map[i-1,j] <> 101) and (map[i-1,j] <> 102) then
            begin
              Score := Score + map[i,j];
              map[i-1,j] := map[i,j] * 2;
              map[i,j] := 0;
            end
            else if (map[i,j] > 0) and (map[i-1,j] = 100) then
            begin
              bombBonus();
            end
            else if (map[i,j] > 0) and ((map[i-1,j] = 101) or (map[i-1,j] = 102)) then
              begin
                addBonus();
              end;
          i := i - 1;
        end;
      end;
end;

procedure TForm1.moveRight();
var i,j:integer;
begin
      for j := 0 to 3 do
      for i := 0 to 2 do
      begin
      if (map[i,j] > 0) and (map[i+1,j] = 0) then
        begin
          map[i+1,j] := map[i,j];
          map[i,j] := 0;
        end;
      if (map[i,j] > 0) and (map[i+1,j] = map[i,j]) and (map[i+1,j] <> 100) and (map[i+1,j] <> 101) and (map[i+1,j] <> 102) then
        begin
          Score := Score + map[i,j];
          map[i+1,j] := map[i,j] * 2;
          map[i,j] := 0;
        end
      else if (map[i,j] > 0) and (map[i+1,j] = 100) then
        begin
          bombBonus();
        end
      else if (map[i,j] > 0) and ((map[i+1,j] = 101) or (map[i+1,j] = 102)) then
        begin
          addBonus();
        end;
      end;
end;

procedure TForm1.putTwo(var n:integer);
var i,j,twoorfour:integer;
begin
    while (n = 0) do
    begin
    i := random(4);
    j := random(4);
      if map[i,j] = 0 then
        begin
          twoorfour := random(101);
          if twoorfour > 90 then
          begin
            map[i,j] := 4;
            n := 1;
          end
          else
          begin
            map[i,j] := 2;
            n := 1;
          end;
        end;
    end;
end;

procedure TForm1.putBonus(var n:integer);
var i,j:integer;
begin
    while (n = 0) do
    begin
    i := random(4);
    j := random(4);
      if map[i,j] = 0 then
        begin
          map[i,j] := 100;
          n := 1;
        end;
    end;
end;

procedure TForm1.putAddBonus(var n:integer);
var i,j,bonusRandom:integer;
begin
    while (n = 0) do
    begin
    i := random(4);
    j := random(4);
    bonusRandom := random(1000);
    if bonusRandom > 700 then
      begin
        if map[i,j] = 0 then
          begin
            map[i,j] := 101;
            n := 1;
          end;
      end
      else
      begin
        if map[i,j] = 0 then
          begin
            map[i,j] := 102;
            n := 1;
          end;
      end;
    end;
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  begin if MessageDlg ('Are you sure want to exit?', mtConfirmation, [mbYes, mbNo], 0) = idNo then CanClose := False;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  path := ExtractfileDir(Application.ExeName);

  Buf := TBitmap.Create;
  Buf.Width := 512;
  Buf.Height := 512;

  for i := 0 to 18 do
    begin
      Img[i] :=  TBitmap.Create;
      img[i].LoadFromFile(path+'\2048Pictures\'+inttostr(i)+'.bmp');
    end;
  for I := 0 to 3 do
    for j := 0 to 3 do
      map[i,j] := 0;

  randomize;
  Score := 0;
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(path +'\best.txt');
  BestScore := strtoint(memo1.Lines.Strings[0]);
  ADOQuery1.Prepared := true;
end;

procedure TForm1.startgame();
var i,j,n:integer;
begin
  for i := 0 to 3 do
  for j := 0 to 3 do
  map[i,j] := 0;
  Score := 0;
  Timer1.Enabled := True;
  i := random(2);
  j := random(2);
  map[i,j] := 2;
  i := random(2)+2;
  j := random(2)+2;
  map[i,j] := 2;

  LosingAnimation.Visible := False;
  LosingAnimation.Enabled := False;
  VictoryAnimation.Enabled := False;
  VictoryAnimation.Visible := False;
  MainScreen.Visible := False;
  MainScreen.Enabled := False;
end;

procedure TForm1.startgamekey();
var i,j,n:integer;
begin
  for i := 0 to 3 do
  for j := 0 to 3 do
  map[i,j] := 0;
  Score := 0;
  Timer1.Enabled := True;
  i := random(2);
  j := random(2);
  map[i,j] := 2;

  LosingAnimation.Visible := False;
  LosingAnimation.Enabled := False;
  VictoryAnimation.Enabled := False;
  VictoryAnimation.Visible := False;
  MainScreen.Visible := False;
  MainScreen.Enabled := False;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i,j,n,bonus:integer;
begin


  n := 0; // Нет двойки или четверки

  if MainScreen.Visible = True then
    startgameKey();
/////////////////////////////////////////////


  if Key = VK_DOWN then
  begin
    moveDown();
    // Поставить 2
    if not (Score > 128) then
    begin
      putTwo(n);
      n := 1;
    end
    else
    begin
      bonus := random(1000);
        if bonus > 997 then
            begin
              putBonus(n);
              n := 1;
            end
        else if bonus > 950 then
             begin
               putAddBonus(n);
             end
        else
            begin
              putTwo(n);
              n := 1;
            end;
    end;


  end;


/////////////////////////////////////////////


  if Key = VK_UP then
  begin
      moveUP();
    // Поставить 2
    if not (Score > 128) then
    begin
      putTwo(n);
      n := 1;
    end
    else
    begin
      bonus := random(1000);
        if bonus > 997 then
            begin
              putBonus(n);
              n := 1;
            end
        else if bonus > 950 then
             begin
               putAddBonus(n);
             end
        else
            begin
              putTwo(n);
              n := 1;
            end;
    end;
  end;


/////////////////////////////////////////////


  if Key = VK_LEFT then
  begin
      moveLeft();

    // Поставить 2
    if not (Score > 128) then
    begin
      putTwo(n);
      n := 1;
    end
    else
    begin
      bonus := random(1000);
        if bonus > 997 then
            begin
              putBonus(n);
              n := 1;
            end
        else if bonus > 950 then
             begin
               putAddBonus(n);
             end
        else
            begin
              putTwo(n);
              n := 1;
            end;
    end;
  end;


/////////////////////////////////////////////


  if Key = VK_RIGHT then
  begin
    moveRight();
    // Поставить 2
    if not (Score > 128) then
    begin
      putTwo(n);
      n := 1;
    end
    else
    begin
      bonus := random(1000);
        if bonus > 997 then
            begin
              putBonus(n);
              n := 1;
            end
        else if bonus > 950 then
             begin
               putAddBonus(n);
             end
        else
            begin
              putTwo(n);
              n := 1;
            end;
    end;
  end;

end;

/////////////////////////////////////////////


procedure TForm1.Image1Click(Sender: TObject);
begin
  startgame();
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var i,j,buttonSelected:integer;
n:boolean;
begin
  Form1.Caption := 'OdyGames 2048';
  ScoreCounter.Caption := inttostr(Score);
  buf.Canvas.Brush.Color := $00202020;
  buf.Canvas.rectangle(-1,-1,513,513);

  for i := 0 to 3 do
    for j := 0 to 3 do
      begin
        case map[i,j] of
        0:buf.Canvas.Draw(i*128,j*128,img[0]);
        2:buf.Canvas.Draw(i*128,j*128,img[1]);
        4:buf.Canvas.Draw(i*128,j*128,img[2]);
        8:buf.Canvas.Draw(i*128,j*128,img[3]);
        16:buf.Canvas.Draw(i*128,j*128,img[4]);
        32:buf.Canvas.Draw(i*128,j*128,img[5]);
        64:buf.Canvas.Draw(i*128,j*128,img[6]);
        128:buf.Canvas.Draw(i*128,j*128,img[7]);
        256:buf.Canvas.Draw(i*128,j*128,img[8]);
        512:buf.Canvas.Draw(i*128,j*128,img[9]);
        1024:buf.Canvas.Draw(i*128,j*128,img[10]);
        2048:buf.Canvas.Draw(i*128,j*128,img[11]);
        4096:buf.Canvas.Draw(i*128,j*128,img[12]);
        8192:buf.Canvas.Draw(i*128,j*128,img[13]);
        16348:buf.Canvas.Draw(i*128,j*128,img[14]);
        32768:buf.Canvas.Draw(i*128,j*128,img[15]);
        // 100 - бомба, 101 - минус скор, 102 - плюс скор
        100:buf.Canvas.Draw(i*128,j*128,img[16]);
        101:buf.Canvas.Draw(i*128,j*128,img[17]);
        102:buf.Canvas.Draw(i*128,j*128,img[18]);

        end;
      end;


  // Проигрыш?
  n := False;
  for i := 0 to 3 do
  for j := 0 to 3 do
  if map[i,j] = 0 then n := True;

  if n = False then
  begin
      Timer1.Enabled := False;
      ShowMessage('You Died!');
      if MessageDlg('Save record?',
            mtConfirmation, [mbYes, mbNo], 0) = mrYes
            then
            begin
              Form1.ADOQuery1.Append;
              Form3.Show;
            end;
      LosingAnimation.Visible := True;
      LosingAnimation.Enabled := True;

  end;

    // Победа?
  n := False;
  for i := 0 to 3 do
  for j := 0 to 3 do
  if map[i,j] = 2048 then n := True;
  if n = True then
  begin
      Timer1.Enabled := False;
      ShowMessage('You Won!');
      if MessageDlg('Save record?',
            mtConfirmation, [mbYes, mbNo], 0) = mrYes
            then
            begin
              Form1.ADOQuery1.Append;
              Form3.Show;
            end;
      VictoryAnimation.Enabled := True;
      VictoryAnimation.Visible := True;
  end;

  Form1.Canvas.Draw(0,0,Buf);
end;

end.
