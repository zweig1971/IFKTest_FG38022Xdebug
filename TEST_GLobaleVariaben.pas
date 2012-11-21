//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 15.10.2009
//
// *programm definitionen
//=====================================


unit TEST_GLobaleVariaben;

interface

uses Classes,Windows,UnitMil,SysUtils;

const
    ProtListenKopfZ1= '                          Testprotokoll IFK FG380.221';
    ProtListenKopfZ2= '                          ===========================';
    ProtListenKopfZ3= '             Testergebnis';
    ProtListenKopfZ4= 'Lfd.Nr       PT   1    2    3    4    5    6    7    8    9    PF   Ergebnis';
    ProtListenKopfZ5= '----------------------------------------------------------------------------';

    ProtListeDatum= 'Datum: ';
    ProtListeTime= 'Uhrzeit: ';
    ProtListeTester= 'Prüfer: ';

    ProtListeUnterschrift1= '-------------------------------';
    ProtListeUnterschrift2= '          Unterschrift';
    ProtListeTestEnde= 'Testende : ';

    ProtListeLegende1= 'PT: Flash Testprogr.             5 : Piggy-Stecker shift test';
    ProtListeLegende2= '1 : Visueller LED Test           6 : Timing Test';
    ProtListeLegende3= '2 : VG-Leisten shift Test        7 : DRQ DRY INTRL Test';
    ProtListeLegende4= '3 : VG-Leisten select Test       8 : Externe Clock Test';
    ProtListeLegende5= '4 : VG-Leisten direction Test    9 : Externer Manchesterdec.Test';
    ProtListeLegende6= '                                 PF: Flash Finale Version';

    ProtListeOK    = '   OK';
    ProtListeFail  = '    X';
    ProtListeNA    = '   NA';
    ProtLiaResFail = '   FEHLER';
    ProtLiaResSucs = '   -OK-';

    TestBoxNotFoundTXT ='Die Prüfbox meldet sich nicht, bitte überprüfen Sie :'+#10#13+
                        '-> Ist die Prüfbox eingeschaltet ?'         +#10#13+
                        '-> Ist die Prüfbox richtig angeschlossen ?' +#10#13+
                        '-> Wurde mit Altera Quartus der Prüfling voher programmiert ?';

    TestTesteeNotFoundTXT = 'Der Prüfling meldet sich nicht korrekt, bitte überprüfen Sie :'+#10#13+
                            '-> Wurde der Jumper HD6408 abgezogen      ?' +#10#13+
                            '-> Ist der Adapter-Stecker JTAG abgezogen ?' +#10#13+
                            '-> Wurde der Jumper LD_FAILSAVE abgezogen ?' +#10#13+
                            '-> Schalten Sie die Prüfbox Aus/Ein !';


    AbstandLfdTest = 10;
    DruckLinkerRand = '        ';
    //--------------------------------
    PCIAdress      = 1;
    IFKAdressMaster= 1;
    IFKAdressSlave = 2;
    //--------------------------------
    FCWR_EnabelTreiber = $39;
    FCRD_EnabelTreiber = $A9;
    //--------------------------------
    FCWR_DirectTreiber = $3A;
    FCRD_DirectTreiber = $AA;
    //--------------------------------
    EnableTreiber = $FFFF;   
    DisableTreiber= $0000;
    //--------------------------------
    DirectOut    = $FFFF;
    DirectIn     = $0000;
    DirectOutA_I = $07FF;
    DirectOutP   = $0800;
    //--------------------------------
    WrVgl1= $30;//VG leiste
    WrVgl2= $31;
    WrVgl3= $32;
    WrVgl4= $33;
    WrVgl5= $34;
    WrVgl6= $35;

    RdVgl1= $A0;
    RdVgl2= $A1;
    RdVgl3= $A2;
    RdVgl4= $A3;
    RdVgl5= $A4;
    RdVgl6= $A5;
    //--------------------------------
    WrPgy1= $36;// Piggy Stecker
    WrPgy2= $37;
    WrPgy3= $38;

    RdPgy1= $A6;
    RdPgy2= $A7;
    RdPgy3= $A8;
    //--------------------------------
    WrTiming= $3C;// Timing eingang test
    RdTiming= $AC;
    //--------------------------------
    VglMaxword= 6;
    VglMaxBit = 89;
    //--------------------------------
    PgyMaxword= 3;
    PgyMaxBit = 46;
    //--------------------------------
    FktRead   = $C0;//  IFK echot ihre Nr
    //--------------------------------
    IntIFKDRQ    = $2000;// Interrupts
    IntIFKDRY    = $4000;
    IntIFKINL    = $8000;
    IntIFKDRQYINL= $E000;
    DisIFKDRQYINL= $0000;

    IntIFKWR     = $3B;
    IntIFKRD     = $AB;

    IntrWaitTime = 5; // wartezeit zwischen senden/lesen des intr. in 10us
    //--------------------------------
    ExtClk         = $8000; // für den ext-clk test
    AktManchDec    = $4000; // Aktiver Manchester Encoder/Decoder 1:=extern 0:= intern
    IntputIFKRegRd = $AD;
    //--------------------------------
    SelectTestA6 = $0100;// fuer den select test die maskierung
    SelectTestB5 = $0FFF;
    SelectTestC5 = $FF00;
    SelectTestD5 = $80FF;
    SelectTestE4 = $FF07;
    SelectTestF5 = $FCFF;
    SelectTestG5 = $F3FF;
    SelectTestH4 = $7FFF;
    SelectTestI6 = $00FF;
    SelectTestS4 = $FFF8;

    EnabelDriverA = $0001;
    EnabelDriverB = $0002;
    EnabelDriverC = $0004;
    EnabelDriverD = $0008;
    EnabelDriverE = $0010;
    EnabelDriverF = $0020;
    EnabelDriverG = $0040;
    EnabelDriverH = $0080;
    EnabelDriverI = $0100;
    EnabelDriverS = $0200;
    EnabelDriverSr= $0400;
    //--------------------------------
    EchoRegWR = $13;
    EchoRegRD = $89;
    //--------------------------------
    AuswahlKickerKarte = false;
    DateiTestFlash = '\FlashFiles\IFA_LP_Test.rbf';
    DateiTestFinal = '\FlashFiles\IFA_LP_Final.rbf';
    DateiSaveProtVerz = 'SOPFiles';
    DateiSaveProtName = 'SOP';
    DateiUserProtVerz = 'UserProt';
    DateiUserProtName = 'Prot';

    ProgSetMasterOut = $200;

    //--------------------------------
    SerienNrTrennzeichen = ' ';

    //-----Zeiten fuer die programmierung----
    ProgUserFlashDelCnt  = 256;   // Schleifenzähler für das löschen des User  Flash
    ProgFiFoUserCnt      = 2000; // Schleifenzähler für die datenübernahme fifo-user
    ProgRdUserFDataValid = 2000; // Schleifenzähler für die prüfung wann die daten im userflash gültig sind
    UserSaveEnableTimeMS = 1500; // Zeit fuer das umschalten zwischen User/Save in ms

Type
    TTestResultArray = array [1..20] of boolean;

    function delChar(value:string; c:char):string;
    procedure WriteToProtDatei(dateiname:string; s:string);

var
   Anwendungsverzeichnis:string;
   TestDatum:string;
   TestUhrzeit:string;
   TestLfdNr:string;
   Bearbeiter:string;
   TestResultArray:TTestResultArray;
   LfdNrDontShow:boolean;

   Dateiname :string;
   buffer    :string;
   FileByte  :file of Byte;
   ConfigFileSize    :integer;

   LoopCounter:longint;
   SendCounter:longint;

   IsTestPast:boolean;

   MBKAdress:byte;

   MBKOnline: TStrings;
   MBKOnlineNr:TStrings;
   MBKCount:integer;
   MBKOnlineIndex:integer;
   MDK_IDCODE:TStrings;

   ReadWord:RECORD CASE BYTE OF
                1:(r: PACKED RECORD
                        lb: BYTE;
                        hb: BYTE;
                       END;);
                2:(w:WORD);
                END;


implementation

// Löscht unerwünschte Zeichen aus einen string
function delChar(value:string; c:char):string;
begin
     while Pos(c,value) <> 0 do delete(value,Pos(c,value),1);
     result:= value;
end;


// Protokollzeile in prot-datei schreiben
procedure WriteToProtDatei(dateiname:string; s:string);

var mbfv:textfile;

begin
     assignfile(mbfv,dateiname);
     if FileExists(dateiname) then begin
       Append(mbfv);
       writeln(mbfv,s);
       Flush(mbfv);
     end else begin
       rewrite(mbfv);
       writeln(mbfv,s);
       Flush(mbfv);
     end;
     CloseFile(mbfv);
end;


end.
