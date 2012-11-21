//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// Test Daten Eingabe
// *Eingabe von datum, uhrzeit, SerienNr, Bearbeiter
// *Datum, Uhrzeit wird automatisch vom systemgenommen
// *protokoll wird vorbereitet
//====================================

unit TEST_DatenEingabe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask;

type
  TTEST_DatenEingabeForm = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DatenBenutzerEdit: TEdit;
    OK_Button: TButton;
    DateMaskEdit: TMaskEdit;
    TimeMaskEdit: TMaskEdit;
    LfdNrMaskEdit: TMaskEdit;
    procedure FormShow(Sender: TObject);
    function LfdNrTest(TesTString:string; var CheckedString:string):boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OK_ButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TEST_DatenEingabeForm: TTEST_DatenEingabeForm;

implementation

uses TEST_GLobaleVariaben, TEST_ProtokollShow, UnitMil;

{$R *.DFM}

procedure TTEST_DatenEingabeForm.FormShow(Sender: TObject);

begin
     // system datum & uhrzeit übernehemen
     DateMaskEdit.Text:= DateToStr(Date);
     TimeMaskEdit.Text:= FormatDateTime('hh:nn',Time);
end;


function TTEST_DatenEingabeForm.LfdNrTest(TesTString:string; var CheckedString:string):boolean;

var TestLfdNrTemp: string;
    LfdNrInt:_WORD;
    PosTrennzeichen:_WORD;

begin
     TestLfdNrTemp:='';

     if (TesTString = '')  then TestLfdNrTemp:= '1'
     else begin

       TestLfdNrTemp:= TesTString;

       try
          LfdNrInt:= StrToInt(TesTString);
       except
        // Keine zahl eingegeben und weniger als 4 zeichen -> tschuess
        if (Length(TesTString) < 4) then begin result:=false; exit end;

        // position des leerzeichen suchen
        PosTrennzeichen:= Pos(SerienNrTrennzeichen,TesTString);

        //keins gefunden -> tschuess
        if (PosTrennzeichen =0) then begin result:=false; exit end;

        TestLfdNrTemp:='';

        //alles was hinter dem leerzeichen ist kopieren
        while (PosTrennzeichen <= Length(TesTString)) do begin
              TestLfdNrTemp:=  TestLfdNrTemp + TesTString[PosTrennzeichen];
              PosTrennzeichen:= PosTrennzeichen + 1;
        end;
       end;

       try
        LfdNrInt:= StrToInt(TestLfdNrTemp);
       except
        // die ziffern hinter dem trennzeichen sind ungueltig->tschuess
        result:=false; exit;
       end;
     end;
     CheckedString:= TestLfdNrTemp;
     result:=true;
end;


procedure TTEST_DatenEingabeForm.FormClose(Sender: TObject; var Action: TCloseAction);

var testLfdboll: boolean;
     button:_WORD;

begin
      // EingabeDaten übernehmen
     //---------------------------
     TestDatum  := DateMaskEdit.Text;
     TestUhrzeit:= TimeMaskEdit.Text;

    // Eingabe der seriennummer
    testLfdboll:= LfdNrTest(LfdNrMaskEdit.Text, TestLfdNr);
    if(testLfdboll <> true) then begin
      button:=Application.MessageBox('Ungültige Seriennummer, bitte wiederholen Sie die Eingabe'
                                    ,'Es kann ja nicht immer regnen..',69);
      case button of
      IDRETRY  : begin
                 testLfdboll:=false;
                 Action:= caNone;
                 end;

      IDCANCEL : begin
                 TestLfdNr:='1';
                 LfdNrMaskEdit.Text:= '1';
                 testLfdboll:= true;
                 end;
      end;
    end;

     // wurde eine sinvolle seriennummer eingegeben
     if (testLfdboll = true) then begin
       //die Leerzeichen müssen raus
       TestLfdNr:= delChar(TestLfdNr, ' ');

       LfdNrMaskEdit.Text:=TestLfdNr;

       Bearbeiter := DatenBenutzerEdit.Text;

       // ProtokollKopf erstellen
       //-----------------------------------
       TEST_ProtokollShowForm.WriteToProtokollClear();
       TEST_ProtokollShowForm.WriteToProtokoll(ProtListenKopfZ1);
       TEST_ProtokollShowForm.WriteToProtokoll(ProtListenKopfZ2);

       // Datum + Uhrzeit
       TEST_ProtokollShowForm.WriteToProtokoll('');
       TEST_ProtokollShowForm.WriteToProtokoll(ProtListeDatum + TestDatum+'    '+ProtListeTime+TestUhrzeit);
       // Bearbeiter
       TEST_ProtokollShowForm.WriteToProtokoll(ProtListeTester+Bearbeiter);

       // Spalten beschriftung
       TEST_ProtokollShowForm.WriteToProtokoll('');
       TEST_ProtokollShowForm.WriteToProtokoll(ProtListenKopfZ3);
       TEST_ProtokollShowForm.WriteToProtokoll(ProtListenKopfZ4);
       TEST_ProtokollShowForm.WriteToProtokoll(ProtListenKopfZ5);
     end;
end;

procedure TTEST_DatenEingabeForm.OK_ButtonClick(Sender: TObject);
begin
      TEST_DatenEingabeForm.Close;
end;

end.
