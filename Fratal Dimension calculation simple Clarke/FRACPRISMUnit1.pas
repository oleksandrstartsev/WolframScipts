unit FRACPRISMUnit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,math,
  Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.Grids, Vcl.Outline, Vcl.Samples.DirOutln ;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ClearButton: TSpeedButton;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    Swich1: TCheckBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ShowInput: TCheckBox;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    LabeledEdit7: TSpinEdit;
    Label1: TLabel;
    LabeledEdit1: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    LabeledEdit2: TSpinEdit;
    LabeledEdit4: TLabeledEdit;
    procedure ClearButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
MAXROW:integer=1000;  {*Upper size limits of array for DEM }
MAXCOL:integer=1000;  {plus two. Change numbers to suit   }
NUMROW:integer;
NUMCOL:integer;
area,resolution: array of double;
dimension: double;
breakpoint1:boolean;
zmin,zmax: double;
rowmax, colmax, steps, begin_row, end_row,begin_col, end_col, timex:integer;
  selectedFile,selectedsaveFile : string;
  myFile,mysaveFile : TextFile;
  Sarray: array of string;
  Iarray,matrix, fracMTRX: array of array of double;
  precision_total,precision_frac:integer;

  (*FOXVIEWER variables +'1'*)
  selectedFile1,selectedsaveFile1 : string;
  myFile1,mysaveFile1 : TextFile;
  Sarray1: array of string;
  Iarray1: array of array of double;  //end file variables;

implementation

{$R *.dfm}

procedure findPRECISION(firstWord:string);
Var i,j,k: integer;
begin
    if Length(trim(firstWord))>0 then
    begin
     firstWord:=trim(firstWord);  k:=length(firstWord);
     for I :=1 to length(firstWord) do
       begin
       if ord(firstWord[I])=44 then firstWord[I]:='.';
        if ord(firstWord[I])=46 then begin k:=I; continue; end;
       end;
       if length(firstWord)> precision_total then
     precision_total:=length(firstWord);
       if length(firstWord)-k> precision_frac then
     precision_frac:=length(firstWord)-k;
    end else begin
      ShowMessage('Smth is wrong with input data:: precision or dot');

     (* precision_total:=5;precision_frac:=2; *)
      exit;
    end;
end;           

 (*~FOXVIEWER procedures*)
  procedure readExportedTxtThermogramFile();
Var first: string;
i,j,k: integer;
begin
    FormatSettings.DecimalSeparator:='.';
    if VCL.Dialogs.PromptForFileName(selectedFile1,
                       'import TXT file with Temperature matrix|*.txt',
                       '',
                       'Select your data file',
                       GetCurrentDir,
                       False)
  then
        begin


         end;

   if length(selectedFile1)<=3 then begin
    ShowMessage('Warning: you have not selected any files');
          FormatSettings.DecimalSeparator:=','; exit;
        end else   Form1.Memo1.Lines.Add('Selected file1= '+selectedFile1);

  AssignFile(myFile1, selectedFile1);
  Reset(myFile1);
  first:='';     k:=0;
     ReadLn(myfile1,first);
        ReadLn(myfile1,first);
           ReadLn(myfile1,first);
              ReadLn(myfile1,first);
                 ReadLn(myfile1,first);
                    ReadLn(myfile1,first);

  SetLength(Sarray1,320);
  while not Eof(myFile1) do
  begin   inc(k);
    ReadLn(myfile1,first);
       Sarray1[k]:=first;
  //  Form1.Memo1.Lines.Add(first);
  // Form1.Memo1.Lines.Add(InttoStr(k));
  // if (k=320) then    Form1.Memo1.Lines.Add(Sarray[k]);


  end;
  if eof(myFile1) then
   Form1.Memo1.Lines.Add('Reading has been completed already!');

  CloseFile(myFile1);
   FormatSettings.DecimalSeparator:=',';
end;



procedure parseExportedTxtThermogramFile();
Var i,j,p,k: integer;

s,s1,s2: string;
begin
if length(Sarray1)=0 then  exit else
begin  precision_total:=-1000;precision_frac:=-1000;
      SetLength(Iarray1,length(Sarray1),240);
     for j := 0 to Length(Iarray1)-1 do
       for k := 0 to Length(Iarray1[j])-1 do
      Iarray1[j,k]:=0;

    for I := 1 to length(Sarray1) do BEGIN

    Application.ProcessMessages();
    if Form1.CheckBox1.Checked then

    Form1.Memo1.Lines.Add('string= '+Sarray1[i]);
              s1:=''; p:=0;    s2:='';
    for j := Length(InttoStr(i))+1 to length(Sarray1[i]) do
    if (ord(Sarray1[i][j])>=44)and(ord(Sarray1[i][j])<=57) then
    begin
   s1:=s1+Sarray1[i][j]; end
    else begin s:=s+' ';
    if Length(s1)>1 then begin
    findPRECISION(s1);
     Iarray1[i-1,p]:=StrToFloat(s1);inc(p);
     s1:='';
     s2:=s2+' '+FloattoStrf( Iarray1[i-1,p-1],ffFixed,precision_total,precision_frac);
   // Form1.Memo1.Lines.Add('Iarray='+InttoStr(p-1)+' = '+FloattoStr( Iarray[i-1,p-1]));
       end;
     end;
 // Form1.Memo1.Lines.Add('s='+s);
 if Form1.CheckBox1.Checked then
   Form1.Memo1.Lines.Add('Iarray1='+InttoStr(i)+' ='+s2);


                          END;
    Form1.Memo1.Lines.Add('Parsing has been completed already!');
end;


end;



procedure saveExportedTxtThermogramFile();
Var saveDialog : TSaveDialog;
 buttonSelected,i,j : Integer;
 s1:string;
begin
  if Length(Iarray1)<>0 then begin

       buttonSelected := VCL.Dialogs.MessageDlg('Save to new file?',mtCustom,
   [mbYes,mbCancel], 0);

if buttonSelected = mrYes    then begin
  saveDialog := TSaveDialog.Create(Form1);
   saveDialog.Title := 'Save your  data into new file';
 saveDialog.InitialDir := GetCurrentDir;
 saveDialog.Filter := 'Dat file for Wolfram@Math import [x,y,T]|.dat|Txt file [for frac analysis: only T-matrix] |.txt';
 saveDialog.DefaultExt := 'dat';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute
  then ShowMessage('File : '+saveDialog.FileName)
  else begin ShowMessage('Data saving was cancelled'); exit; end;

  selectedsavefile1:=saveDialog.FileName;
saveDialog.Free; end;

 if buttonSelected = mrCancel then exit;

      AssignFile(mysavefile1,selectedsaveFile1); Rewrite(mysavefile1);
       FormatSettings.DecimalSeparator:='.';
       if SaveDialog.FilterIndex=1 then begin

 for I := 0 to Length(Iarray1)-1 do
   for J := 0 to Length(Iarray1[i])-1 do
     begin
    WriteLn(mysavefile1,FloatToStrf(i+1,ffFixed,6,3)+'  '+
    FloatToStrf(j+1,ffFixed,6,3)+'  '+FloatToStrf(Iarray1[i,j],ffFixed,precision_total,precision_frac));

     end;     end;
      if SaveDialog.FilterIndex=2 then begin
 for I := 0 to Length(Iarray1)-1 do
 begin  s1:='';
   for J := 0 to Length(Iarray1[i])-1 do
     begin s1:=s1+'  '+FloatToStrf(Iarray1[i,j],ffFixed,precision_total,precision_frac);


     end;  WriteLn(mysavefile1,s1);   end; end;


          FormatSettings.DecimalSeparator:=',';
       CloseFile(mysaveFile1);

  end;
end;


(*~FRAC3D procedures *)

procedure parse();
Var i,j,p,k: integer;
s,s1,s2: string;
begin
if length(Sarray)=0 then  exit else
begin
precision_total:=-1000;precision_frac:=-1000;
      SetLength(Iarray,NUMROW,NUMCOL);
     for j := 0 to Length(Iarray)-1 do
       for k := 0 to Length(Iarray[j])-1 do
      Iarray[j,k]:=0;

    for I :=0 to length(Sarray)-1 do BEGIN

    Application.ProcessMessages();
     Sarray[i]:='  '+Sarray[i]+'  ';
   { Form1.Memo1.Lines.Add('Sarray['+InttoStr(i)+']= '+Sarray[i]);   }

          s1:=''; p:=0;    s2:='';
    for j := Length(InttoStr(i))+1 to length(Sarray[i]) do
    if (ord(Sarray[i][j])>=44)and(ord(Sarray[i][j])<=57)and(ord(Sarray[i][j])<>47) then
    begin
   s1:=s1+Sarray[i][j]; end
    else begin
    if Length(s1)>1 then begin Iarray[i,p]:=StrToFloat(s1);
     findPRECISION(s1);
     s2:=s2+' '+FloattoStr( Iarray[i,p]);  inc(p);  s1:='';
   // Form1.Memo1.Lines.Add('Iarray='+InttoStr(p-1)+' = '+FloattoStr( Iarray[i-1,p-1]));
       end;   s1:='';
     end;
 // Form1.Memo1.Lines.Add('s='+s);
{    Form1.Memo1.Lines.Add('Iarray='+InttoStr(i)+' ='+s2); }


                          END;
    Form1.Memo1.Lines.Add('Parsing has been completed already!');
end;   

end;

procedure readdem();
Var first: string;
i,j,k: integer;
Begin
if tryStrtoInt(Form1.LabeledEdit1.Text,NUMROW)and(NUMROW>0) then  begin
NUMROW:= StrtoInt(Form1.LabeledEdit1.Text); Form1.LabeledEdit1.Color:=clWhite;
 end else begin
  breakpoint1:=false;
  Form1.LabeledEdit1.Color:=clRed;
  exit;
end;
if tryStrtoInt(Form1.LabeledEdit2.Text,NUMCOL)and(NUMCOL>0) then begin
NUMCOL:= StrtoInt(Form1.LabeledEdit2.Text);Form1.LabeledEdit2.Color:=clWhite;
 end else begin
  breakpoint1:=false;   Form1.LabeledEdit2.Color:=clRed;
  exit;
end;        


    FormatSettings.DecimalSeparator:='.';
    if VCL.Dialogs.PromptForFileName(selectedFile,
                       'TXT files|*.txt',
                       '',
                       'Select your data file',
                       GetCurrentDir,
                       False)
  then
        begin  
         end;

   if length(selectedFile)<=3 then begin
    ShowMessage('Warning: you have not selected any files');
          FormatSettings.DecimalSeparator:=',';
          breakpoint1:=false;
           exit;
        end else   Form1.Memo1.Lines.Add('Selected file= '+selectedFile);

  AssignFile(myFile, selectedFile);
  Reset(myFile);
  first:='';     k:=0;
   {}

  SetLength(Sarray,NUMROW);
  while not Eof(myFile) do
  begin
    ReadLn(myfile,first);
    Sarray[k]:= trim(StringReplace(first, '  ', ' ',
                          [rfReplaceAll, rfIgnoreCase]));
   if Form1.ShowInput.Checked then Form1.Memo1.Lines.Add(Floattostrf(k,ffFixed,4,0)+' :: '+Sarray[k]);
 inc(k);
   end;
  if eof(myFile) then
   Form1.Memo1.Lines.Add('Reading has been completed already!');

  CloseFile(myFile);
   FormatSettings.DecimalSeparator:='.';

  parse();
   SetLength(matrix,NUMROW,NUMCOL);      (*initialize matrix array*)
   matrix:=Iarray;
   SetLength(Iarray,0,0);

   for i := 0 to Length(matrix)-1 do
       for j := 0 to Length(matrix[i])-1 do
       begin
   if((i=0)and(j=0))then begin
		 zmin:=matrix[i,j];
		 zmax:=matrix[i,j];
	 end;
	 if(matrix[i,j]<zmin) then zmin:=matrix[i,j];
	 if(matrix[i,j]>zmax) then zmax:=matrix[i,j];
       end;
{  first:='';
 for i := 0 to Length(matrix)-1 do
       for j := 0 to Length(matrix[i])-1 do
       begin
         first:= first+' '+FloattoStrf(matrix[i][j],ffFixed,precision_total,precision_frac);
         if j=(Length(matrix[i])-1) then
         begin
         Form1.Memo1.Lines.Add(InttoStr(i)+' ::'+ Sarray[i]);
        Form1.Memo1.Lines.Add(InttoStr(i)+' ::'+ first);
         first:='';
              end;
       end;   }  SetLength(Sarray,0);
      Form1.Memo1.Lines.Add('');
   Form1.Memo1.Lines.Add('Minimum elevation :'+FloattoStrf(zmin,ffFixed,precision_total,precision_frac));
    Form1.Memo1.Lines.Add('Maximum elevation :'+FloattoStrf(zmax,ffFixed,precision_total,precision_frac));
    Form1.Memo1.Lines.Add(' ** Data input complete ** ');
    breakpoint1:=true;

End;


(*==================================================*)
(*   function center: calculate area for calculation*)
(*==================================================*)
procedure    center();
Var i,j: integer;
    n:integer;
    size, slop:integer;
Begin   n:=1;

(*Select short side of array*)
rowmax:=numrow; colmax:=numcol;
    if rowmax>colmax then size:=colmax else size:=rowmax;
	 steps:=1;
(*Find power of two which is less than short side *)
     repeat begin
   inc(steps);
   n:=n*2;
		end
     until (n>=size);
     n:=round(n/2);
     dec(steps);
(*Calculate begin and end rows & cols for processing *)
	slop:= round((rowmax-n)/2);
    begin_row:=slop+1;
    end_row:=n+slop+1;
    slop:=round((colmax-n)/2);
    begin_col:=slop+1;
	end_col:=n+slop+1;
   Form1.Memo1.Lines.Add('Processing rows '+InttoStr(begin_row)+' to '+Inttostr(end_row));
   Form1.Memo1.Lines.Add('and columns '+Inttostr(begin_col)+' to '+Inttostr(end_col));
 breakpoint1:=true;

end;

procedure fractal();   //Clarke Method 18-08-1985
Var	 row, col, step,gh: integer;
    side, diag:double;

     a,b,c,d,e,w,x,y,z,o,p,q,r,sa,sb,sc,sd,
           aa,ab,ac,ad, surface_area :double;
 Begin step:= 1;     gh:=0;
       SetLength(area,100);
       SetLength(resolution,100);
(*Repeat for area sequence 1,4,16,64,256 etc. *)

   for timex:=1 to steps do begin
   surface_area:=0.0;
     (*Set length of sides of triangles *)
   side:=step;
   diag:=step*sqrt(2.0)/2.0;
  (*Process whole array at this size *)
    row:=begin_row-1;
   while (row<end_row-1) do begin

   col:=begin_col-1;

   while(col<end_col-1) do begin
   gh:=0;

  (*
    //  Form1.Memo1.Lines.Add(InttoStr(row)+','+InttoStr(col)+' ; '+Inttostr(step));
   if (step=2)and((row-begin_row>0)or(col-begin_col>0)) then  begin
    //   Form1.Memo1.Lines.Add(InttoStr(row)+'>1,'+InttoStr(col)+'>1 ; '
    //   +Inttostr(step));
     if row-begin_row>0 then
         begin  // Form1.Memo1.Lines.Add(InttoStr(row)+'row');
         row:=row-1;//Form1.Memo1.Lines.Add(InttoStr(row)+'row--');
         gh:=1;
         end;
      if col-begin_col>0 then
         begin// Form1.Memo1.Lines.Add(InttoStr(col)+'col ');
         col:=col-1;// Form1.Memo1.Lines.Add(InttoStr(col)+'col--');
         gh:=gh+3;
          end;
  end;
        *)

//     (*if (step=2) then *) if row>11 then                           
// Form1.Memo1.Lines.Add(InttoStr(row)+'.,'+InttoStr(col)+'. ; st:: '+
// Inttostr(step)+ ' ,gh='+Inttostr(gh) );

      a:=matrix[row][col];
      b:=matrix[row][col+step];
	    c:=matrix[row+step][col+step];
      d:=matrix[row+step][col];

(* e is the center point of four pixel values*)
      e:=0.25*(a+b+c+d);
(*w,x,y,z are external sides of the square   *)
	    w:=sqrt((a-b)*(a-b)+side*side);
      x:=sqrt((b-c)*(b-c)+side*side);
      y:=sqrt((c-d)*(c-d)+side*side);
      z:=sqrt((a-d)*(a-d)+side*side);
(* o,p,q,r are internal sides of triangles   *)
	    o:=sqrt((a-e)*(a-e)+diag*diag);
      p:=sqrt((b-e)*(b-e)+diag*diag);
      q:=sqrt((c-e)*(c-e)+diag*diag);
      r:=sqrt((d-e)*(d-e)+diag*diag);
(* Compute values from Heron's formula       *)
	    sa:=0.5*(w+p+o);
      sb:=0.5*(x+p+q);
      sc:=0.5*(y+q+r);
      sd:=0.5*(z+o+r);
(* Solve areas from Heron's formula       *)
	    aa:=sqrt(abs(sa*(sa-w)*(sa-p)*(sa-o)));
      ab:=sqrt(abs(sb*(sb-x)*(sb-p)*(sb-q)));
      ac:=sqrt(abs(sc*(sc-y)*(sc-q)*(sc-r)));
      ad:=sqrt(abs(sd*(sd-z)*(sd-o)*(sd-r)));
(* Add to total surface area                 *)
	  surface_area:= surface_area+aa+ab+ac+ad;




    (*     if gh<>0 then
         begin
           if gh=1 then begin row:=row+1;gh:=0; end;
           if gh=3 then begin col:=col+1; gh:=0; end;
           if gh=4 then begin col:=col+1; row:=row+1; gh:=0; end;
   //      Form1.Memo1.Lines.Add('mod renew::'+InttoStr(row)+','+Inttostr(col)+' gh='+InttoStr(gh));
         end;       *)
          col:=col+step;
      end;

       row:=row+step;



   end;
(*Save area and resolution, increment step size*)
	 area[timex]:= surface_area;
	 resolution[timex]:=step*step;
     step:=step*2;
     end;
   breakpoint1:=true;
ENd;


(*==================================================*)
(*    Function Linefit: Least Squares Log/Log fir   *)
(*==================================================*)
procedure linefit ();
Var
 resavg,areaavg, cross, sumres, sumarea, beta, r: double;
 n:integer;

Begin
   resavg:=0.0; areaavg:=0.0; cross:=0.0; sumres:=0.0;
		  sumarea:=0.0; dimension:=0.0; beta:=0.0; r:=0.0;
//       Form1.Memo1.Lines.Add('');
//   Form1.Memo1.Lines.Add(' Step Resolution Area ');
(*Do log transform and compute means*)
   for n:=1 to steps do begin
//  Form1.Memo1.Lines.Add(InttoStr(n)+'  '+
//   FloattoStr(resolution[n])+'  '+FloattoStr( area[n]));
   resolution[n]:=Ln(resolution[n]);
   area[n]:=Ln(area[n]);
   resavg:=resavg+resolution[n];
   areaavg:=areaavg+area[n];
          end;
	if(steps<3) then begin
    Form1.Memo1.Lines.Add(' Too few calculated data points regression ');
	exit();				  end;
    resavg:=resavg/steps;
	areaavg:=areaavg/steps;
(*Compute sums of squares      *)
    for n:=1 to steps do begin
    cross:= cross+((resolution[n]-resavg)*(area[n]-areaavg));
    sumres:=sumres+((resolution[n]-resavg)*(resolution[n]-resavg));
	sumarea:=sumarea+((area[n]-areaavg)*(area[n]-areaavg));
     end;
(*Compute correlation coefficient and fractal dimension *)
  r:=cross/sqrt(sumres*sumarea);
  beta:=r*sqrt(sumarea)/sqrt(sumres);
  dimension:=2.0-beta;

//  Form1.Memo1.Lines.Add('');
//   Form1.Memo1.Lines.Add(' >> ** Fractional Dimension= '+FloattoStr(dimension));
//   Form1.Memo1.Lines.Add(' >>  r-squared= '+FloattoStr(r*r));
//   Form1.Memo1.Lines.Add(' >> ** with '+FloattoStr(steps)+' observations');
//    Form1.Memo1.Lines.Add('');
//   Form1.Memo1.Lines.Add(' ln(resolution)');
//  for n:=1 to steps do begin
//  Form1.Memo1.Lines.Add('      #'+Inttostr(n)+'  '+FloattoStr(resolution[n]));
 //                        end;
//    Form1.Memo1.Lines.Add('');
//  Form1.Memo1.Lines.Add('ln(area)');
//   for n:=1 to steps do begin
//    Form1.Memo1.Lines.Add('     #'+Inttostr(n)+'  '+FloattoStr( area[n]));
 //                         end;

   breakpoint1:=true;
	End;

procedure TForm1.ClearButtonClick(Sender: TObject);
begin
Form1.Memo1.Lines.Clear;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 Form1.Memo1.Width:=round(Form1.Width*0.7);
Form1.Memo1.Height:=round(Form1.Height*0.7);
 Form1.Memo1.Left:=round(Form1.Height*0.26);
 Form1.SpeedButton1.Width:=round(Form1.Height*0.2);
 Form1.SpeedButton2.Width:=round(Form1.Height*0.2);
 Form1.SpeedButton5.Width:=round(Form1.Height*0.2);
 Form1.ClearButton.Width:=round(Form1.Height*0.06);
  Form1.Panel1.Width:=round(Form1.Height*0.2);
 Form1.Memo1.Font.Size:=round(15*Form1.Width/Screen.Width);
  Form1.LabeledEdit1.Width:=round(Form1.Height*0.08);
  Form1.LabeledEdit2.Width:=round(Form1.Height*0.08);
  Form1.LabeledEdit7.Width:=round(Form1.Height*0.08);
end;

procedure calculateFracDim();
VAr i,j: integer;
dimrowfracMTRX,dimcolfracMTRX: integer;
sliding,boxside:integer;
   frequencyX : Int64;
  startTimeX : Int64;
  endTimeX   : Int64;
  deltaX     : Extended;
Begin
 (*breakpoint1:=false;
readdem();
if breakpoint1 then begin
center();
fractal();
linefit(); end;   *)

(*===========================================*)
(*           test for different matrx szes   *)
(*+++++++++++++++++++++++++++++++++++++++++++*)
 breakpoint1:=false;
 QueryPerformanceFrequency(frequencyX);
  QueryPerformanceCounter(startTimeX);
readdem();
if breakpoint1 then begin
// Form1.Memo1.Lines.Add('bp#1:: passed');
//center();
if Form1.Swich1.Checked then begin
              //   Form1.Memo1.Lines.Add('swch#1:: in');
  (*begin_row:=StrToInt(Form1.LabeledEdit3.Text);
  end_row:=StrtoInt(Form1.LabeledEdit4.Text);
  begin_col:=StrtoInt(Form1.LabeledEdit5.Text);
  end_row:=StrToInt(Form1.LabeledEdit6.Text);*)
  steps:=StrToInt(Form1.LabeledEdit7.Text);
 // Form1.Memo1.Lines.Add('steps:: '+InttoStr(steps));
  (*Define steps:: 1,2,4 -> 1,4,8 frac kernel size*)
  boxside:=1;
   for I := 2 to steps do
     boxside:= boxside*2;
      Form1.Memo1.Lines.Add('boxside:: '+InttoStr(boxside));

     if (NUMROW<boxside) and  (NUMCOL<boxside) then
     begin
       Form1.Memo1.Lines.Add('Not enough elements. Procedure [frac dim] EXIT is activated');
    exit;
     end;

  dimrowfracMTRX:=1+(NUMROW-boxside)-1;
  dimcolfracMTRX:=1+(NUMCOL-boxside)-1;  (*Define size of frac map matrix:: fracMTRX*)
     SetLength(fracMTRX,dimrowfracMTRX,dimcolfracMTRX);
     Form1.Memo1.Lines.Add('  fracMTRX allocated '+Inttostr(dimrowfracMTRX)+ ' , '+InttoStr( dimcolfracMTRX));
     (**)
       for I :=0 to Length(fracMTRX)-1 do
      for j :=0 to Length(fracMTRX[I])-1 do
      fracMTRX[I,j]:=0;


       Form1.Memo1.Lines.Add('');
       Form1.Memo1.Lines.Add('  ** MTRX frac map is calculating...');


      for I :=0 to Length(fracMTRX)-1 do begin
        begin_row:=I+1;
        end_row:= begin_row+boxside;  (*I+boxside*)
           if end_row>NUMROW+1 then begin exit;
             Form1.Memo1.Lines.Add('bp#2:: end_row>NUMROW');
           end;

      for j :=0 to Length(fracMTRX[I])-1 do
    BEGIN
        begin_col:=j+1;
        end_col:= begin_col+boxside; (*j+boxside*)
           if end_col>NUMCOL+1 then begin exit;
             Form1.Memo1.Lines.Add('bp#3:: end_col>NUMCOL');
           end;
// Form1.Memo1.Lines.Add('  I::'+Inttostr(i)+':: row'+Inttostr( begin_row)+','
// +Inttostr(end_row)+'  J::'+Inttostr(j)+':: row'+Inttostr( begin_col)+','
// +Inttostr(end_col));
       fractal();
      linefit();
       SetLength(area,0); SetLength(resolution,0);
        fracMTRX[I][j]:=dimension;
       // Form1.Memo1.Lines.Add(InttoStr(i)+','+Inttostr(j)+
       // '= '+FloattoStr(fracMTRX[I][j]));
     // Form1.Memo1.Lines.Add('  ');
    END;
                                        end;
      (*time perfomance*)
 QueryPerformanceCounter(endTimeX);
  deltaX := (endTimeX - startTimeX) / frequencyX;
   Form1.Memo1.Lines.Add(FloatToStr(deltaX*1000)+' ms');
Form1.Memo1.Lines.Add('');   Form1.Memo1.Lines.Add('Press button "Show FM" to see fractal dimension matrix');
Form1.Memo1.Lines.Add('');
Form1.Memo1.Lines.Add('You can save FRACTAL MAP into file. Press button "SAVE FM"');
end; (*SWICH 1 end*)

end;
(*
for I := 0 to Length(matrix)-1 do
for j := 0 to length(matrix[i])-1 do
  Form1.Memo1.Lines.Add(InttoStr(I)+', '+InttoStr(j)+' ='+floattoStr(matrix[i,j]));
*)

end;


procedure calculateFracDim1();
VAr i,j: integer;
Begin
 (*breakpoint1:=false;
readdem();
if breakpoint1 then begin
center();
fractal();
linefit(); end; *)

(*===========================================*)
(*           test for different matrx szes   *)
(*+++++++++++++++++++++++++++++++++++++++++++*)
 readdem();
 //center();
  breakpoint1:=true;
  begin_row:=StrToInt(Form1.LabeledEdit3.Text);
  end_row:=StrtoInt(Form1.LabeledEdit4.Text);
  begin_col:=StrtoInt(Form1.LabeledEdit5.Text);
  end_row:=StrToInt(Form1.LabeledEdit6.Text);
  steps:=StrToInt(Form1.LabeledEdit7.Text);

 fractal();
linefit();

end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 Form1.Memo1.Lines.Add('');
 Form1.Memo1.Lines.Add('(*========================================*)');
 
   calculateFracDim();
end;


procedure TForm1.SpeedButton2Click(Sender: TObject);
Var sr1: string;

begin
(*
FormatSettings.DecimalSeparator:='.';
 sr1:= '12.101';
findPRECISION(sr1);
Form1.Memo1.Lines.Add('precision_total= '+InttoStr(precision_total));
 Form1.Memo1.Lines.Add('precision_frac= '+InttoStr(precision_frac));
 Form1.Memo1.Lines.Add('12='+FloattoStrf(StrToFloat(sr1),ffFixed,precision_total,precision_frac));
 FormatSettings.DecimalSeparator:=',';
 FormatSettings. DecimalSeparator:='.';
 sr1:= '120.10112';
findPRECISION(sr1);
Form1.Memo1.Lines.Add('precision_total= '+InttoStr(precision_total));
 Form1.Memo1.Lines.Add('precision_frac= '+InttoStr(precision_frac));
 Form1.Memo1.Lines.Add('12='+FloattoStrf(StrToFloat(sr1),ffFixed,precision_total,precision_frac));
 FormatSettings.DecimalSeparator:=',';     *)
  Form1.Memo1.Lines.Add('');
 Form1.Memo1.Lines.Add('(*========================================*)');
 
 precision_total:=-1000;precision_frac:=-1000;
 readExportedTxtThermogramFile();
 parseExportedTxtThermogramFile();
 saveExportedTxtThermogramFile();

 end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
if Form1.Memo1.Font.Size-1>0 then

Form1.Memo1.Font.Size:=Form1.Memo1.Font.Size-1;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
if Form1.Memo1.Font.Size+1<32 then

Form1.Memo1.Font.Size:=Form1.Memo1.Font.Size+1;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
Form1.Memo1.Lines.Add('');
 Form1.Memo1.Lines.Add('(*========================================*)');
 
  breakpoint1:=false;
readdem();
if breakpoint1 then begin
center();
fractal();
linefit(); 
Form1.Memo1.Lines.Add('fract dim='+FloattoStrf(dimension, ffFixed,5,3)+' steps='+Inttostr(steps));
end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
Var saveDialog : TSaveDialog;
 buttonSelected,i,j : Integer;
selectedsaveFile2 : string;
  myFile2,mysaveFile2 : TextFile;
 s1:string;
begin
if Length(fracMTRX)>0 then BEGIN

       buttonSelected := VCL.Dialogs.MessageDlg('Save to new file?',mtCustom,
   [mbYes,mbCancel], 0);

if buttonSelected = mrYes    then begin
  saveDialog := TSaveDialog.Create(Form1);
   saveDialog.Title := 'Save your  data into new file';
 saveDialog.InitialDir := GetCurrentDir;
 saveDialog.Filter := 'Dat file for Wolfram@Math import [x,y,Df]|.dat|Txt file [only Df-matrix] |.txt';
 saveDialog.DefaultExt := 'dat';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute
  then ShowMessage('File : '+saveDialog.FileName)
  else begin ShowMessage('Data saving was cancelled'); exit; end;

  selectedsavefile2:=saveDialog.FileName;
saveDialog.Free; end;

 if buttonSelected = mrCancel then exit;

      AssignFile(mysavefile2,selectedsaveFile2); Rewrite(mysavefile2);
       FormatSettings.DecimalSeparator:='.';
   if saveDialog.FilterIndex=1 then   begin
 for I := 0 to Length(fracMTRX)-1 do
   for J := 0 to Length(fracMTRX[i])-1 do
     begin
    WriteLn(mysavefile2,FloatToStrf(i+1,ffFixed,4,1)+'  '+
    FloatToStrf(j+1,ffFixed,4,1)+'  '+FloatToStrf(fracMTRX[i,j],ffFixed,6,4));

     end; end;
  if saveDialog.FilterIndex=2 then   begin
 for I := 0 to Length(fracMTRX)-1 do
 begin  s1:='';
   for J := 0 to Length(fracMTRX[i])-1 do
     begin s1:=s1+'  '+FloatToStrf(fracMTRX[i,j],ffFixed,6,4);

     end;  WriteLn(mysavefile2,s1);   end;    end;

          FormatSettings.DecimalSeparator:=',';
       CloseFile(mysaveFile2);

                  END;

end;


procedure TForm1.SpeedButton7Click(Sender: TObject);
Var i,j:integer;
st1:string;
begin
     for i := 0 to length(fracMTRX)-1 do   begin
      st1:='';
        for j := 0 to Length(fracMTRX[i])-1 do
        begin
 st1:=st1+' '+FloattoStrf(fracMTRX[i,j],ffFixed,5,3);
        end;
  Form1.Memo1.Lines.Add(st1);
             end;
end;

end.
