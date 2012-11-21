//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// TEST Protokoll Show
// * zeigt alles was protokolliert worden ist an
// * ermöglicht das zusaetzliche  speichern
// * ermöglicht das ausdrucken
// * zangsspeicher des protokolls
//====================================


unit TEST_ProtokollShow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers;

type
  TTEST_ProtokollShowForm = class(TForm)
    Panel1: TPanel;
    ProtokollListBox: TListBox;
    PrintButton: TButton;
    SaveButton: TButton;
    ButtonClose: TButton;
    PrintDialog1: TPrintDialog;
    SaveDialog1: TSaveDialog;
    function DirExists(s:string):boolean;
    procedure WriteToProtokoll(s:string);
    procedure WriteToProtokollClear();
    procedure GenerateProtName(var VerzProtSOPName:string; var VerzProtUserName:string; var DateiID:string);
    procedure ButtonCloseClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TEST_ProtokollShowForm: TTEST_ProtokollShowForm;
  PrintButtonPress:boolean;
  SaveButtonPress:boolean;
  VerzProtUserName:string;
  VerzProtSOPName:string;

implementation

uses TEST_GLobaleVariaben, UnitMil, TEST_STOPForm;

{$R *.DFM}


function TTEST_ProtokollShowForm.DirExists(s:string):boolean;

var i:integer;

begin
     i:= GetFileAttributes(PChar(s));
     Result:= (i<> -1) and (FILE_ATTRIBUTE_DIRECTORY and i <> 0);
end;

// Loescht die protokoll-listbox und generiert einen neuen dateinamen
procedure TTEST_ProtokollShowForm.WriteToProtokollClear();

var ProtDateiName:string;
    DateiID:string;

begin
     //Listbox loeschen
     TEST_ProtokollShowForm.ProtokollListBox.Items.Clear;
     //dateinamen generieren
     TEST_ProtokollShowForm.GenerateProtName(VerzProtSOPName,VerzProtUserName, DateiID);
end;

//schreibt daten in die protokoll-listbox und in die prot-datei
procedure TTEST_ProtokollShowForm.WriteToProtokoll(s:string);
begin
     TEST_ProtokollShowForm.ProtokollListBox.Items.Add(s);
     WriteToProtDatei(VerzProtSOPName, s);
end;

//Generiert aus verzeichnis+datum+uhrzeit einen dateinamen
procedure TTEST_ProtokollShowForm.GenerateProtName(var VerzProtSOPName:string;
                                                   var VerzProtUserName:string;
                                                   var DateiID:string);

var DateiSaveProtokollUserVerzeichnis:string;
    DateiSaveProtokollSOPVerzeichnis:string;
    myDate:string;
    myTime:string;

begin
     // Verzeichnis fuer die protokolle ggf erstellen
     DateiSaveProtokollUserVerzeichnis:=Anwendungsverzeichnis+DateiUserProtVerz;
     DateiSaveProtokollSOPVerzeichnis:= Anwendungsverzeichnis+DateiSaveProtVerz;

     //aus dem datum das zeichen '.' entfernen
     mydate:= delChar(TestDatum,'.');

     //aus der uhrzeit das zeichen ':' entfernen
     mytime:= delChar(TestUhrzeit,':');

     //Name für die datei zusammenbasteln, datum+uhrzeit
     VerzProtUserName:= DateiSaveProtokollUserVerzeichnis+ '\'+ DateiUserProtName+ myDate+'_'+ myTime +'.txt';
     VerzProtSOPName := DateiSaveProtokollSOPVerzeichnis + '\'+ DateiSaveProtName+ myDate+'_'+ myTime +'.sav';

     DateiID:= myDate +'_' + myTime;
end;

procedure TTEST_ProtokollShowForm.ButtonCloseClick(Sender: TObject);

var button:_WORD;

begin
     TEST_ProtokollShowForm.Close;


{
     if(PrintButtonPress = false) and (SaveButtonPress =  false) then begin
       button:= Application.MessageBox('Protokoll ohne zu drucken/speichern schliessen ?' +#10#13+
                                       'Alle Daten gehen dann verloren !','Unwissenheit ist ein Segen...',36);
       if (button = IDYES) then TEST_ProtokollShowForm.Close;
     end else TEST_ProtokollShowForm.Close;
}
end;

procedure TTEST_ProtokollShowForm.PrintButtonClick(Sender: TObject);

var Line:Integer;
    PrintText:TextFile;

begin
     if PrintDialog1.Execute then begin
        AssignPrn(PrintText);
        Rewrite(PrintText);
        Printer.Canvas.Font := ProtokollListBox.Font;
        for Line := 0 to ProtokollListBox.items.Count - 1 do
            Writeln(PrintText,DruckLinkerRand, ProtokollListBox.items[Line]);
        CloseFile(PrintText);
     end;

     PrintButtonPress:= true;
end;

procedure TTEST_ProtokollShowForm.SaveButtonClick(Sender: TObject);

var dateiname:string;
    DateiID:string;
    VerzProtSOPName:string;
    VerzProtUserName:string;


begin
  dateiname:='';
  SaveButtonPress:=true;

  //Protokoll namen erstellen
  GenerateProtName(VerzProtSOPName,VerzProtUserName, DateiID);

  dateiname:= DateiUserProtName+DateiID +'.txt';

  SaveDialog1.FileName:= dateiname;
  SaveDialog1.Filter:= '.txt';
  SaveDialog1.DefaultExt:= '.txt';
  SaveDialog1.InitialDir:= Anwendungsverzeichnis+DateiUserProtVerz;

  if SaveDialog1.Execute then begin
        dateiname := SaveDialog1.FileName;
        if FileExists(dateiname) then begin
          messagebox(0,'Datei existiert bereits, anderen Namen wählen !','Uffbasse',16);
          dateiname :='';
  end;

  if (dateiname<> '') then
    ProtokollListBox.Items.SaveToFile(dateiname);
  end;
end;

procedure TTEST_ProtokollShowForm.FormShow(Sender: TObject);

var DateiSaveProtokollVerzeichnis:string;
    myDate:string;
    myTime:string;
    mySaveProtDatei:string;

begin
     PrintButtonPress:= false;
     SaveButtonPress:= false;
{
     // Verzeichnis fuer die protokolle ggf erstellen
     DateiSaveProtokollVerzeichnis:=Anwendungsverzeichnis+DateiSaveProtVerz;
     if not DirExists(DateiSaveProtokollVerzeichnis) then begin
        mkdir(DateiSaveProtokollVerzeichnis);
     end;

     //aus dem datum das zeichen '.' entfernen
     mydate:= delChar(TestDatum,'.');

     //aus der uhrzeit das zeichen ':' entfernen
     mytime:= delChar(TestUhrzeit,':');

     //Name für die datei zusammenbasteln, datum+uhrzeit
     mySaveProtDatei:= DateiSaveProtokollVerzeichnis+ '\'+ DateiSaveProtName+ myDate+'_'+ myTime +'.txt';

     //falls dern name schon existiert dialog öffnen
     if FileExists(mySaveProtDatei) then begin
       //dialog öffnen
       SaveDialog1.FileName:= mySaveProtDatei;
       if SaveDialog1.Execute then begin
         mySaveProtDatei := SaveDialog1.FileName;
         if FileExists(mySaveProtDatei) then begin
           messagebox(0,'Datei existiert bereits, anderen Namen wählen !','Uffbasse',16);
           dateiname :='';
         end;
       end;
     end;
     ProtokollListBox.Items.SaveToFile(mySaveProtDatei);
     //SaveButton.Click();    }
end;

procedure TTEST_ProtokollShowForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if(PrintButtonPress = false) and (SaveButtonPress =  false) then begin
       STOP_FORM.ShowModal;
       if(TEST_STOPForm.Abbruch = true) then Action:=caNone
    end;
end;

end.
