unit Records;

interface
  uses Classes, SysUtils, dbf ,db;

  type
    TPlayerName = String[40];
    TPlayer = record
      Name: TPlayerName;
      Score: integer;
    end;
    TRecordTable = class(TObject)
      private
        _Size:integer;
        _Players:array [1..8] of TPlayer;
        function _GetPlayer(i:integer):TPlayer;
        function _GetPlayerPos(score:integer):integer;
        procedure _CreateDataBase(path:String);
      public
        const Empty : TPlayer = (Name: ''; Score: 0);
        constructor Create;
        property Players[i:integer]: TPlayer read _GetPlayer;
        property Size: integer read _Size;
        function IsNewRecord(score:integer):boolean;
        procedure WriteNewRecord(Name:TPlayerName;score:integer);
        procedure LoadFromFile(path:string);
        procedure SaveToFile(path:string);

    end;
implementation
  constructor TRecordTable.Create;
  var i:integer;
  begin
    _Size := 8;
    for i := 1 to Size do
      _Players[i] := Empty;
  end;

  function TRecordTable._GetPlayer(i: Integer): TPlayer;
    begin
      if (i >= 1) and (i <= Size) then
        _GetPlayer := _Players[i]
      else
        _GetPlayer := Empty;
    end;

   function TRecordTable.IsNewRecord(score: Integer): Boolean;
    begin
      IsNewRecord := _GetPlayerPos(score) <= Size;
    end;

   procedure TRecordTable.WriteNewRecord(Name: TPlayerName; score: Integer);
   var i,p : integer;
    begin
      p:= _GetPlayerPos(score);
      for i := size downto p + 1 do
        _Players[i] := _PLayers[i - 1];
      _Players[p].Name := name;
      _Players[p].Score := score;
    end;

   procedure TRecordTable._CreateDataBase(path: string);
   var
    dbase: Tdbf;
    i:integer;
    begin
      dbase:= Tdbf.Create(nil);
      try
        dbase.TableLevel := 7;
        dbase.Exclusive := True;
        dbase.TableName := path;
        with dbase.FieldDefs do
          begin
            Add('Id', ftAutoInc, 0, True);
            Add('Name', ftString, 40, True);
            Add('Score', ftInteger);
          end;
        with dbase do
          begin
            CreateTable;
            Open;
            for i := 1 to Size do
              begin
                Append;
                Fields[1].AsString := '';
                Fields[2].AsString := 0;
                Post;
              end;
            Close;
          end;
        finally
          dbase.Free;
      end;
    end;

    procedure TRecordTable.LoadFromFile(path: string);
    var
      source: TDbf;
      i: integer;
    begin
      if FileExists(path) then
        begin
          source := TDbf.Create(nil);
          try
            with source do
            begin
              TableLevel := 7;
              Exclusive := True;
              TableName := path;
              Open;
              Active := True;
              First;
              for i := 1 to Size do
                begin
                  _Players[i].Name := Fields[1].AsString;
                  _Players[i].Score := Fields[2].AsInteger;
                  Next;
                end;
              Active := False;
              Close;
            end;
          finally
            source.Free;
          end;
        end;
    end;

    procedure TRecordTable.SaveToFile(path: string);
    var
      dest: TDbf;
      i: integer;
    begin
      if not FileExists(path) then
            _CreateDataBase(path);
          dest := TDbf.Create(nil);
          try
            with dest do
            begin
              TableLevel := 7;
              Exclusive := True;
              TableName := path;
              Open;
              Active := True;
              First;
              for i := 1 to Size do
                begin
                  Edit;
                  FieldValues['Name'] := Players[i].Name;
                  FieldValues['Score'] := Players[i].Score;
                  Post;
                  Next;
                end;
              Active := False;
              Close;
            end;
          finally
            dest.Free;
          end;
        end;
    end;

    function TRecordTable._GetPlayerPos(score: Integer): Integer;
    var i:integer;
    begin
      _GetPlayerPos := Size + 1;
        for i := 1 to Size do
          if score > Players[i].Score then
            begin
              _GetPlayerPos := i;
              break;
            end;
    end;

end.
