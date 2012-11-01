unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, ActnList, ComCtrls, StdCtrls, ToolWin,FileCtrl,
  ExtCtrls;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    Memo1: TMemo;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ActionList1: TActionList;
    ApplicationEvents1: TApplicationEvents;
    aOpen: TAction;
    aDelete: TAction;
    aClear: TAction;
    aClose: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    Panel1: TPanel;
    Edit1: TEdit;         
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    ComboBox3: TComboBox;
    Panel2: TPanel;
    Panel3: TPanel;
    ComboBox4: TComboBox;
    CheckBox2: TCheckBox;
    aCheck2: TAction;
    aCheck3: TAction;
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure aOpenExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aClearUpdate(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure poverca(list:TStringList);
    procedure poverca2();
    procedure poverca3();
    procedure print_repetition;
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure aDeleteUpdate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
    pDirList:TStringList;
    pFileList:TList;
  public
    { Public declarations }
    property DirList:TStringList read pDirList;
    property FileList:TList read pFileList;
    procedure clearstec;
    procedure SORT;
    procedure PositionNext(var mas:array of integer);
    function compare(n,size:integer;
        AlikeSize:array of integer):integer;
    procedure deleteDuplicates;
  end;

  PFileInfo=^TFileInfo;
  TFileInfo=packed record
    name:string;
    ext:string;
    size:cardinal;
    Duplicate:boolean;
    NamDup:integer;
    PointMap:Pointer;
  end;

var
  Form1: TForm1;
  size:real;
  size2:integer;

implementation

{$R *.dfm}

procedure TForm1.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
statusBar1.Panels[0].Text:='Открыто дирректорий : '+intToStr(memo1.Lines.Count);
statusBar1.Panels[1].Text:='Всего: '+intToStr(FileList.Count)+' файлов ';
end;

procedure TForm1.aOpenExecute(Sender: TObject);
  procedure getDirList(const Dir:string;searchRec:TSearchRec);
    procedure AddDirectory(var DirListing:TStringList;const
    dirOld:string; const FindData:TWin32FindData);
    var name:string;
    begin
    name:=FindData.cFileName;
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY<>0)
        and (name<>'.') and (name<>'..')
        then DirListing.Add(DirOld+name+'\*.*');
    end;
  var s:string;DList:TStringList;i:integer;
  begin
   s:=ExtractFilePath(Dir);
   DirList.Add(s);
   DList:=TStringList.Create;
   DList.Clear;
   searchRec.Attr:=faDirectory;
   searchRec.ExcludeAttr:=faHidden+faVolumeID+faSysFile+faAnyFile;
   if FindFirst(Dir,faDirectory,searchRec)=0 then
   try
    AddDirectory(DList,s,searchRec.FindData);
    searchRec.Attr:=faDirectory;
    searchRec.ExcludeAttr:=faHidden+faVolumeID+faSysFile+faAnyFile;
    while FindNext(searchRec)=0 do
     AddDirectory(DList,s,searchRec.FindData);
   finally
    FindClose(SearchRec);
   end;
   for i:=0 to DList.Count-1 do
     getDirList(DList[i],searchRec);
   DList.Free;
  end;
var Dir:string; searchRec:tSearchRec;
begin
 Dir:='';
 application.ProcessMessages;
 if SelectDirectory(Dir,[],0) then
 begin
  statusbar1.Panels[1].Text:='Построение списка дирректорий ';
  screen.Cursor:=crHourGlass;
  enabled:=false;
  try
   if Dir[length(Dir)]<>'\' then Dir:=Dir+'\';
   GetDirList(Dir+'*.*',searchRec);
  finally
   screen.Cursor:=crDefault;
   enabled:=true;
   statusbar1.Panels[1].Text:='';
   refresh;
  end;
  DirList.AddStrings(memo1.Lines);
  memo1.Lines.Assign(DirList);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 pDirList:=TStringList.Create;
 pDirList.Sorted:=true;
 pFileList:=TList.Create;
 size:=-1;
 size2:=-1;
end;

procedure TForm1.aCloseExecute(Sender: TObject);
begin
 close;
end;

procedure TForm1.aClearUpdate(Sender: TObject);
begin
 (sender as Taction).Enabled:=memo1.Lines.Count>0;
end;

procedure TForm1.aClearExecute(Sender: TObject);
begin
 memo1.Clear;
 clearstec;
 pDirList.Clear;
 DirList.Clear;
 pFileList.Clear;
 FileList.Clear;
end;

procedure TForm1.aDeleteExecute(Sender: TObject);
  procedure SerchFil(Dir:string;SearchRec:TSearchRec);
    procedure FindFils(const Dir:string;const FindData:TWin32FindData);
     function chekin_size(SizeNuw:cardinal):boolean;
     begin
      result:=true;
      if CheckBox1.Checked then
      begin
       case comboBox2.ItemIndex of
        0:if SizeNuw<>size then result:=false;
        1:if CheckBox2.Checked then
          begin
           if (SizeNuw<size)or(sizenuw>size2) then result:=false;
          end
          else if SizeNuw<=size then result:=false;
        2:if SizeNuw>=size then result:=false;
        3:if SizeNuw=size then result:=false;
       end;
      end;
     end;
     var STEC:PFileInfo;S,ext:string;
    begin
     if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY=0)then begin
       s:=FindData.cFileName;
       if (s<>'.') and (s<>'..') then begin
         ext:=ansilowercase(ExtractFileExt(s));
         if (ext<>'.lnk') and (ext<>'.pif')and
           chekin_size(FindData.nFileSizeLow)then
         begin
          try
           new(STEC);
           STEC.name:=Dir+s; //extractPath - уже используем
           STEC.ext:=ext;
           STEC.Duplicate:=false;
           STEC.NamDup:=0;
           STEC.size:=FindData.nFileSizeLow;
           FileList.Add(STEC);
          except
           dispose(STEC);
          end;
         end;
       end;
     end;
    end;
  var Dirrs:string;
  begin
   if Dir[Length(Dir)]<>'\' then Dir:=Dir+'\';
   Dirrs:=Dir+'*.*';
   searchRec.Attr:= faAnyFile;
   searchRec.ExcludeAttr:=faSysFile+faDirectory+faVolumeID;
   try
    if FindFirst(Dirrs,faAnyFile,SearchRec)=0 then
     FindFils(Dir,SearchRec.FindData);
    searchRec.Attr:=faAnyFile;
    searchRec.ExcludeAttr:=faSysFile+faDirectory+FaVolumeID;
    while FindNext(SearchRec)=0 do
     FindFils(Dir,SearchRec.FindData);
   finally
    FindClose(SearchRec);
   end;
  end;
  procedure lenghts(var Sizes:integer;const count:integer);
  var i,prev:integer;
  begin
   i:=1;
   repeat
    prev:=i;
    while (i<count)and(PFileInfo(FileList[i-1]).size=
        PFileInfo(FileList[i]).size) do inc(i);
    if i-prev>0 then inc(Sizes,2);
    inc(i);
   until i>count;
  end;
var SearchRec:TSearchRec;
i,count,Sizes,prev:integer;
Dir:string; mas:array of integer;
begin
 setlength(mas,0);
 if CheckBox1.Checked then
 begin
   if size=-1 then
   begin
    showmessage('введите число');
    edit1.SetFocus;
    exit;
   end;
   if CheckBox2.Checked then
     if size>=size2 then
   begin
    showmessage('размер '+inttostr(size2)+' байт'+
    ' должен быть больше '+FloatToStr(size)+' байт');
    Edit2.Text:=IntToStr(StrToInt(Edit1.Text)+1);
    Edit2.SetFocus;
    exit;
   end;
 end;
 Dir:='';
 clearStec;
 FileList.Clear;
 statusbar1.Panels[1].Text:='Построение списка файлов ';
 screen.Cursor:=crHourGlass;
 enabled:=false;
  try
    for i:=0 to DirList.Count-1 do // получение информации о
    SerchFil(DirList[i],SearchREc); // каждом файле
    //////////
    SORT; // сортировка
    ////////////////////// массив размещения схожих файлов
    count:=FileList.Count; // база  count
    Sizes:=0; //
    i:=1;
    Lenghts(Sizes,count); // длина массива
    setlength(mas,Sizes);
    Sizes:=0;
    repeat
     prev:=i;
     while (i<count)and(PFileInfo(FileList[i-1]).size=
      PFileInfo(FileList[i]).size) do inc(i);
     if i-prev>0 then begin
     inc(Sizes,2);
     mas[Sizes-1]:=i-1;
     mas[Sizes-2]:=prev-1;
     end;
     inc(i);
    until i>count;
    ////////// массив готов
    if compare(0,high(mas),mas)=1then
    begin// сравнение (поиск) одинаковых фалов
     showmessage(' повторов не найдено ');
     exit;
    end;
    //deleteDuplicates;        //  для версии 12 не переходим к удалению
    //print_in_memo_repetition; // а выводим на экран повторы
    print_repetition;
    memo1.Lines.Assign(DirList);
 finally
    mas:=nil;
    screen.Cursor:=crDefault;
    statusbar1.Panels[1].Text:='';
    enabled:=true;
 end;
 clearstec;
 pDirList.Clear;
 DirList.Clear;
 pFileList.Clear;
 FileList.Clear;
end;

procedure TForm1.SORT;
  function toPFInf(importance:integer):PFileInfo;
  begin
   result:=PFileInfo(FileList[importance]);
  end;
var
 max,N,NN,II,I,gap:integer;temp:PFileInfo;b:boolean;
begin
 N:=0;
 max:=FileList.Count;
 if max>1 then
 while N+1<max do
 begin  /// метод qwert11
 NN:=N;
    for ii:=N+1 to max-1 do
    begin
     if (toPFInf(N).ext=toPFInf(II).ext)and(N+1<ii) then
     begin
      temp:=FileList[N+1];
      FileList[N+1]:=FileList[II];
      FileList[II]:=temp;
     end;
     if toPFInf(N).ext=toPFInf(N+1).ext then inc(N);
    end;
 ///////////////////////////////// метод шелла сортировка
 gap:=N div 2;
  repeat
   repeat
    b:=true;
    for i:=NN to (N-gap)do
      if toPFInf(I).size>toPFInf(I+gap).size then begin
      temp:=FileList[I];
      FileList[I]:=FileList[I+gap];
      FileList[I+gap]:=temp;
      b:=false;
      end;
   until b;
   gap:=gap div 2;
  until gap=0;
  /////////////////////////////// конец сортировки
  inc(N);
 end;
end;

procedure TForm1.PositionNext(var mas:array of integer);
var count,Sizes,i,prev:integer;
begin
 Sizes:=0;
 i:=1;
 count:=FileList.Count; // база  count
 repeat
  prev:=i;
  while (i<count)and(PFileInfo(FileList[i-1]).size=
      PFileInfo(FileList[i]).size) do inc(i);
  if i-prev>0 then begin
  inc(Sizes,2);
  mas[Sizes-1]:=i-1;
  mas[Sizes-2]:=prev-1;
  end;
  inc(i);
 until i>count;
end;



function TForm1.compare(n,size:integer;
    AlikeSize:array of integer):integer;
  procedure PointMap(var NumDup,v_back:integer;
      const begining,next:integer;const size:cardinal);
    procedure compares(var NumDup:integer;const finish,
        begining:integer;const size:cardinal);
    var i:integer;Duplicate,b:boolean;DuplList:TStringList;
    begin
      Duplicate:=false;
      b:=true;
      for i:=finish-1 downto begining do begin
        if not(PFileInfo(FileList[i]).Duplicate) then
            begin
          if compareMem(PFileInfo(FileList[finish]).PointMap,
            PFileInfo(FileList[i]).PointMap,size)then begin
            PFileInfo(FileList[i]).Duplicate:=true;
            PFileInfo(FileList[i]).NamDup:=NumDup;
            Duplicate:=true;
            if b then begin
            DuplList:=TStringList.Create;
            DuplList.Sorted:=true;
            DuplList.Clear;
            b:=false;
            end;
            DuplList.Add(PFileInfo(FileList[i]).name);
          end;
        end;
      end;
      if Duplicate then begin
        PFileInfo(FileList[finish]).Duplicate:=true;
        PFileInfo(FileList[finish]).NamDup:=NumDup;
        inc(NumDup);
        DuplList.Add(PFileInfo(FileList[finish]).name);
        DirList.AddStrings(DuplList);
        DirList.Add('');
        DuplList.Free;
      end;
    end;
  var finish:integer;h,hm:cardinal;
  begin
   finish:=v_back;
   hm:=0;
   h:=CreateFile(pChar(PFileInfo(FileList[v_back]).name),
      GENERIC_READ,FILE_SHARE_READ,nil,OPEN_EXISTING,0,0);
   try
    if (h<>INVALID_HANDLE_VALUE)then
      begin
        try
          hm:=CreateFileMapping(h,nil,PAGE_READONLY,0,0,nil);
          PFileInfo(FileList[v_back]).PointMap:=
            MapViewOfFile(hm,FILE_MAP_READ,0,0,0);
          while v_back<next do begin
            inc(v_back);
            PointMap(NumDup,v_back,begining,next,size);
          end;
          if not(PFileInfo(FileList[finish]).Duplicate) then
              compares(NumDup,finish,begining,size);
        finally
         UnMapViewOfFile(PFileInfo(FileList[finish]).PointMap);
         CloseHandle(hm);
        end;
    end;
   finally
    CloseHandle(h);
   end;
  end;
var
  b:boolean;NumDup:integer;
begin
  DirList.Clear;
  DirList.Sorted:=false;
  NumDup:=1;
  while n<size do
  begin
    inc(n,2);
    b:=false;
  //    if n+10>size then showmessage('a');
    PointMap(NumDup,AlikeSize[n-2],AlikeSize[n-2],AlikeSize[n-1],
        PFileInfo(FileList[AlikeSize[n-2]]).size);
  end;
  result:=NumDup;
end;

procedure TForm1.deleteDuplicates;
  procedure SORTtoName(max,N:integer);
    function toPFInf(importance:integer):PFileInfo;
    begin
      result:=PFileInfo(FileList[importance]);
    end;
    var II:integer;b:boolean;temp:PFileInfo;
  begin
    while N+1<max do begin  /// метод qwert11
      for ii:=N+1 to max-1 do begin
        if (toPFInf(N).NamDup=toPFInf(II).NamDup)and(N+1<ii)then
        begin
          temp:=FileList[N+1];
          FileList[N+1]:=FileList[II];
          FileList[II]:=temp;
        end;
        if toPFInf(N).NamDup=toPFInf(N+1).NamDup then inc(N);
      end;
      inc(N);
    end;
  end;
  function item(s:string;i:integer):string;
  begin
    setlength(s,i);
    result:=s;
  end;
  procedure delexecute(var TotSise:real;size:cardinal);
  begin
    TotSise:=TotSise+size;
  end;
  const
    sizeOf:array [0..4] of string =('kB','mB','gB','tB','MNOGGOOO');
  var
    i,ii,iii:integer;dir,t:string;incDir:TStringList;b,bb:boolean;
    TotSize:real;
begin
  TotSize:=0;
  for i:=FileList.Count-1 downto 0 do
      if not PFileInfo(FileList[i]).Duplicate then
        dispose(PFileInfo(pFileList.Extract(pFileList.Items[i])));
  FileList.Pack;
  //poverca3();
  SORTtoNAme(FileList.Count,0);
  i:=-1;
  b:=false;
  incDir:=TStringList.Create;
  try
    ShowMessage('Выберите папки из которых удаление произойдет в последнюю очередь');
    while selectdirectory(dir,[],0)do begin
    incDir.Add(Dir+'\'); // выбор папок из которых
    end;
    // файлы будут удалятся в последнюю очередь
    ////////////////////////////////////
    while i<FileList.Count-1 do begin/////процес удаления папок по выбору (см.выше)
      bb:=true;
      repeat                       /////если таковые имеются
        inc(i);
        b:=false;
        ii:=0;
        if not(b)then begin
          b:=true;
          while((b)and(ii<incDir.Count))do begin  // incDir - здесь храняться директории
            if incDir[ii]=item(PFileInfo(FileList[i]).name, // из которых файлы
                length(incDir.Strings[ii]))then begin // удаляются в последнюю
              b:=false;                                // очередь
              bb:=false;
              iii:=i;
            end;
            inc(ii);
          end;
          if not(b) then while(i+1<FileList.Count)and
            (PFileInfo(FileList[i]).NamDup=PFileInfo(FileList[i+1]).NamDup)do
            inc(i);
        end;
        //poverca2();
        if not(b)then PFileInfo(FileList[iii]).Duplicate:=false;
        //FileList.Pack;
        //poverca2;
      until (i+1>=FileList.Count)or(PFileInfo(FileList[i]).NamDup<>
          PFileInfo(FileList[i+1]).NamDup)or(not(bb));
        //poverca3;
        if bb then PFileInfo(FileList[i]).Duplicate:=false;
        //FileList.Pack;
        //poverca2;
    end;  ////////////
    for i:=FileList.Count-1 downto 0 do
      if not PFileInfo(FileList[i]).Duplicate then
        dispose(PFileInfo(pFileList.Extract(pFileList.Items[i])));
    FileList.Pack;
    //poverca2;
  finally
    incDir.Free;
  end;
  //////////////////конец исключений
  DirList.Sorted:=true;
  //poverca(DirList);
  DirList.Duplicates:=DupIgnore;
  DirList.Clear;
  //FileList.Pack;
  for i:=0 to FileList.Count-1do begin
    try
      if deletefile(PFileInfo(FileList[i]).name) then begin
        DelExecute(TotSize,PFileInfo(FileList[i]).size);
      end
      else begin
        ii:=FileGetAttr(PFileInfo(FileList[i]).name); // атрибуты файла
        if (ii and faReadOnly)>0 then
        begin
         fileSetAttr(PFileInfo(FileList[i]).name,ii and not faReadOnly);
         if deletefile(PFileInfo(FileList[i]).name)then
            DelExecute(TotSize,PFileInfo(FileList[i]).size);
        end
        else begin
         abort;
        end;
      end;
      DirList.Add('/ Файл удален '+PFileInfo(FileList[i]).name);
    except
      DirList.Add('не возможно удалить файл '+PFileInfo(FileList[i]).name);
    end;
  end;
  //DirList.Add(' Удалено '+format('%d байт ',[totSize]));
  i:=0;
  while (i<5) and (totSize>=1024) do
  begin
   totSize:=totSize/1024;
   inc(i)
  end;
  totSize:=int(totSize);
  if i>0 then dec(i);
  showmessage('Удалено '+floatToStr(totSize)+' '+sizeOf[i]);
end;


procedure TForm1.clearstec;
var i:integer;
begin
for i:=pFileList.Count-1 downto 0 do
  dispose(PFileInfo(pFileList.Extract(pFileList.Items[i])));
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
pDirList.Free;
clearStec;
pFileList.Free;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
showmessage(' Игорь Плотников '+
  #10#13+'        &&'+#10#13+'   qwert11'+#10#13+'20.09.2009-...');
end;

procedure TForm1.poverca(list: TStringList);
begin
 memo1.Lines.Assign(list);
end;

procedure TForm1.poverca2;
  var
   i:integer;
   s:string;
begin
 memo1.Clear;
 s:='';
 for i := 0 to pFileList.Count-1 do
   begin
     s:=PFileInfo(FileList[i]).name;
     memo1.Lines.Add(PFileInfo(FileList[i]).name);
   end;
end;

procedure TForm1.poverca3;
 var
  i:integer;
begin
 memo1.Clear;
 for i := 0 to pFileList.Count-1 do
   begin
     memo1.Lines.Add(IntToStr(PFileInfo(FileList[i]).NamDup));
   end;
end;

procedure TForm1.print_repetition;
 var
   i:integer;
begin
 for i:=FileList.Count-1 downto 0 do
  if not PFileInfo(FileList[i]).Duplicate then
    dispose(PFileInfo(pFileList.Extract(pFileList.Items[i])));
 FileList.Pack;
end;

procedure TForm1.Edit1Change(Sender: TObject);
 var
  b:integer;
  a:real;
begin
 val(edit1.Text,a,b);
 if (b=0) and (a>0) then
 begin
  case ComboBox1.ItemIndex of
   0: size:=a;
   1: size:=a*1024;
   2: size:=a*1024*1024;
  end;
 end else
 begin
  edit1.Text:='';
  size:=-1;
 end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 Edit1Change(Sender);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
 procedure nil_size_size2;
 begin
  size:=-1;
  size2:=-1;
  edit1.Text:='';
  edit2.Text:='';
  panel2.Enabled:=false;
  CheckBox2.Checked:=false;
 end;
 procedure nil_size2;
 begin
  size2:=-1;
  edit2.Text:='';
  panel3.Enabled:=false;
 end;
begin
 if CheckBox1.Checked then
   begin
    panel2.Enabled:=true;
    Edit1Change(Sender);
    if ComboBox2.ItemIndex=1 then
    begin
     CheckBox2.Enabled:=true;
     if CheckBox2.Checked then
     begin
      panel3.Enabled:=true;
      Edit2Change(Sender);
     end else
     begin
      nil_size2;
     end;
    end else
    begin
     CheckBox2.Enabled:=false;
     panel3.Enabled:=false;
    end;
   end
 else
   begin
    nil_size_size2;
   end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
 var
  a,b:integer;
begin
 val(edit2.Text,a,b);
 if (b=0) and (a>0) then
 begin
  case ComboBox4.ItemIndex of
   0: size2:=a;
   1: size2:=a*1024;
   2: size2:=a*1024*1024;
  end;
 end else
 begin
  edit2.Text:='';
  size2:=-1;
 end;

end;

procedure TForm1.aDeleteUpdate(Sender: TObject);
begin
 (Sender as TAction).Enabled:=DirList.Count>0;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
 if CheckBox1.Checked then
  CheckBox1.Checked:=false
 else
  CheckBox1.Checked:=true;
 CheckBox1Click(Sender);
end;

end.
