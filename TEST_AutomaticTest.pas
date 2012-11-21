//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 15.10.2009
//
// *Test Automatic Test
// *verwaltet die anzeigenmaske
// *pruefling wird mit testsoftware geimpft
// *pruefling wird nach ende mit finalen software geimpft
// *ruft die einzelnen test auf
// *ggf. wird voher initialisiert
// *ergebnisse werden ausgewertet
// *ergebnisse werden protokolliert
// *Folgende test sind hier implementiert:
// - Test_ExterneClockTest
//====================================



unit TEST_AutomaticTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TEST_BitMusterTest, TEST_GLobaleVariaben, BitShiftClass,
  UnitMil,TEST_TimingTEST,TEST_SelectTest, Menus, TEST_ExpertSingelShiftTest;

type
  TTest_AutomaticTesTForm = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Bevel1: TBevel;
    Test2Shape: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    Test3Shape: TShape;
    Label8: TLabel;
    Bevel3: TBevel;
    Test4Shape: TShape;
    Bevel4: TBevel;
    Label9: TLabel;
    Test1Shape: TShape;
    Label10: TLabel;
    Bevel5: TBevel;
    Test1Label: TLabel;
    Test2Label: TLabel;
    Bevel6: TBevel;
    Test3Label: TLabel;
    Bevel7: TBevel;
    Test4Label: TLabel;
    Bevel8: TBevel;
    Label1: TLabel;
    LfdNrPanel: TPanel;
    NextIFKButton: TButton;
    EndTesTButton: TButton;
    Label2: TLabel;
    Bevel9: TBevel;
    Test5Shape: TShape;
    Test5Label: TLabel;
    Bevel10: TBevel;
    Label4: TLabel;
    Bevel11: TBevel;
    Test6Shape: TShape;
    Test6Label: TLabel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Label3: TLabel;
    Test7Shape: TShape;
    Test7Label: TLabel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label5: TLabel;
    Test8Shape: TShape;
    Test8Label: TLabel;
    Bevel16: TBevel;
    ProgramFinalVerPanel: TPanel;
    ProgramFinalVerLabel: TLabel;
    ProgramTestVerPanel: TPanel;
    ProgramTestVerLabel: TLabel;
    Legende_ListBox: TListBox;
    Label11: TLabel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Label12: TLabel;
    Test9Shape: TShape;
    Test9Label: TLabel;
    MainMenu1: TMainMenu;
    Debug1: TMenuItem;
    Enabel1: TMenuItem;
    Disabel1: TMenuItem;
    Test1_Start: TButton;
    Test1_Detail: TButton;
    Test2_Start: TButton;
    Test2_Detail: TButton;
    Test3_Start: TButton;
    Test3_Detail: TButton;
    Test4_Start: TButton;
    Test4_Detail: TButton;
    Test5_Start: TButton;
    Test5_Detail: TButton;
    Test6_Detail: TButton;
    Test6_Start: TButton;
    Test7_Start: TButton;
    Test7_Detail: TButton;
    Test8_Start: TButton;
    Test8_Detail: TButton;
    Test9_Start: TButton;
    Test9_Detail: TButton;
    ProgTesTVers: TButton;
    PrgFinaleVers: TButton;
    troubleshooting1: TMenuItem;
    V1: TMenuItem;
    PiggySteckershifttest1: TMenuItem;

    procedure EndTesTButtonClick(Sender: TObject);
    function  Test_AutomaticTest():boolean;
    function  Test_ShiftBitTest(InitZero:boolean; MasterOut:boolean;VGTesT:boolean;ErrorListe:TStrings):boolean;
    function  Test_TimingKanalTest(ErrorListe:TStrings):boolean;
    function  Test_DrqDryInlTest(ErrorListe:TStrings):boolean;
    function  Test_ExterneClockTest(ErrorListe:TStrings):boolean;
    function  Test_DirectionTest(ErrorListe:TStrings):boolean;
    function  Test_ManchesterTest(ErrorListe:TStrings):boolean;
    procedure Test_InitTestAnzeige();
    procedure Test_FailureTestAnzeige();

    function Test_Test1(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test2(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test3(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test4(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test5(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test6(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test7(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test8(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_Test9(AutoTest:boolean;ErrorListe:TStrings):boolean;

    function Test_ProgTesTVers(AutoTest:boolean;ErrorListe:TStrings):boolean;
    function Test_ProgFinalVers(AutoTest:boolean;ErrorListe:TStrings):boolean;
    procedure Test_SetSlaveAdress();

    procedure FormShow(Sender: TObject);
    procedure Test_StartAutomaticTest();
    procedure NextIFKButtonClick(Sender: TObject);
    procedure Enabel1Click(Sender: TObject);
    procedure Disabel1Click(Sender: TObject);
    procedure Test1_StartClick(Sender: TObject);
    procedure Test2_StartClick(Sender: TObject);
    procedure Test3_StartClick(Sender: TObject);
    procedure Test4_StartClick(Sender: TObject);
    procedure Test5_StartClick(Sender: TObject);
    procedure Test6_StartClick(Sender: TObject);
    procedure Test7_StartClick(Sender: TObject);
    procedure Test8_StartClick(Sender: TObject);
    procedure Test9_StartClick(Sender: TObject);

    procedure ProgTesTVersClick(Sender: TObject);
    procedure ProgFinalVersClick(Sender: TObject);
    function  AktManchesterEncDec():boolean;
    procedure DisabelAllDrivers();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure V1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

  procedure Test_SetInit(var Config: TConfigRec);

var
  Test_AutomaticTesTForm: TTest_AutomaticTesTForm;
  BitShiftConfig:TConfigRec;
  TestResultString:string;
  TestResultBool:boolean;
  LfdNrDWord:_DWORD;
  JumperHD6408Set:boolean;
  

implementation

uses TEST_ProtokollShow, TEST_SRNummerEingabe,TEST_InterruptTest,
  TEST_IFKProgrammierung, TEST_RichtungsTest, TEST_Debug, TEST_BitteWarten,
  TEST_SingelBitMusterForm;

{$R *.DFM}

function TTest_AutomaticTesTForm.Test_AutomaticTest():boolean;

var AutoTesT:boolean;
    ErrStatus:_DWORD;
    ErrorListe:TStrings;

begin
     ErrorListe:= TStringList.Create;
     AutoTesT:=true;

     // Grunderscheinungsbild erstellen
     NextIFKButton.Enabled:= False;
     LfdNrPanel.Caption:= TestLfdNr;

     Test_InitTestAnzeige();

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 250, 1, ErrStatus);

     TestResultBool:=true;

       //-----------------------------------------
      // Test 1: Visueller Test (D)
     //-----------------------------------------
     Test_Test1(AutoTesT,ErrorListe);

       //-----------------------------------------
      //Test 2: VG Leisten shift test (A1)
     //-----------------------------------------
     Test_Test2(AutoTesT,ErrorListe);

       //-----------------------------------------
      //Test 3: Select-Signal Test  (A2)
     //-----------------------------------------
     Test_Test3(AutoTesT,ErrorListe);

       //-----------------------------------------
      //Test 4: Direction Test  (A3)
     //-----------------------------------------
     Test_Test4(AutoTesT,ErrorListe);

       //-----------------------------------------
      //Test 5: Piggy shift test (B)
     //-----------------------------------------
     Test_Test5(AutoTesT,ErrorListe);

       //-----------------------------------------
      //Test 6: Timing Test  (C)
     //-----------------------------------------
     Test_Test6(AutoTesT,ErrorListe);

       //-----------------------------------------
      //Test 7: DRQ DRY INTRL Test
     //-----------------------------------------
     Test_Test7(AutoTesT,ErrorListe);

       //-----------------------------------------
      //Test 8: Externe Clock Test
     //-----------------------------------------
     Test_Test8(AutoTest,ErrorListe);

       //-----------------------------------------
      //Test 9: Manchaster test
     //-----------------------------------------
     Test_Test9(AutoTest,ErrorListe);

       //-----------------------------------------
      // Test ende
     //-----------------------------------------
     NextIFKButton.Enabled:= True;
     result:= TestResultBool;
     ErrorListe.Free;
end;

function TTest_AutomaticTesTForm.Test_Test1(AutoTest:boolean;ErrorListe:TStrings):boolean;

var Button:_WORD;
    Status:boolean;

begin
     //Alle Treiber auschalten
     DisabelAllDrivers();

     Button:= Application.MessageBox('Funktionieren alle LEDs auf der Frontseite ?','Frage',36);
     if(Button = IDYES) then begin
        Test1Shape.Brush.Color:= clLime;
        Test1Label.Caption := '    OK';
        if(AutoTest=true) then begin
          TestResultArray[1]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
        Status:=true;
     end else begin
        Test1Shape.Brush.Color:= clRed;
        Test1Label.Caption := '  FALSE';
        if(AutoTest=true) then begin
          TestResultArray[1]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
        Status:=false;
     end;
     Application.ProcessMessages();
     result:=Status;
end;

function TTest_AutomaticTesTForm.Test_Test2(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;
    ErrorFound:boolean;

begin
     ErrorFound:=false;

    //Alle Treiber auschalten
     DisabelAllDrivers();

     //Beim VG-Leisten shift test duerfen nur die treiber von A nach Srest
     //auf output geschaltet werden, da es sonst zu einen kurzschluss mit den
     //piggy treibern kommt
     BitShiftConfig.DirectOut:=DirectOutA_I;

     // VG-Leisten Test: 1 shift Master Out, Slave In
     ErrorListe.Add('Shift 1; Master Out; Slave IN');
     status:= Test_ShiftBitTest(true, true, true, ErrorListe);
     if(status = false) then ErrorFound:=true;

     // VG-Leisten Test: 1 shift Master In, Slave Out
     ErrorListe.Add('Shift 1; Master IN; Slave OUT');
     status:= Test_ShiftBitTest(true, false, true, ErrorListe);
     if(status = false) then ErrorFound:=true;

     // VG-Leisten Test: 0 shift Master Out, Slave In
     ErrorListe.Add('Shift 0; Master Out; Slave IN');
     status:= Test_ShiftBitTest(false,true, true, ErrorListe);
     if(status = false) then ErrorFound:=true;

     // VG-Leisten Test: 0 shift Master In, Slave Out
     ErrorListe.Add('Shift 0; Master IN; Slave OUT');
     status:= Test_ShiftBitTest(false, false, true, ErrorListe);
     if(status = false) then ErrorFound:=true;

     if(ErrorFound = false) then begin
        Test2Shape.Brush.Color:= clLime;
        Test2Label.Caption := '    OK';
        ErrorListe.Add('Shift Bit TesT: OK');
        if(AutoTest=true) then begin
          TestResultArray[2]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
      end else begin
        Test2Shape.Brush.Color:= clRed;
        Test2Label.Caption := '  FALSE';
        ErrorListe.Add('Shift Bit TesT: ERROR !');
        if(AutoTest=true) then begin
          TestResultArray[2]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
      end;

     //wieder brav auf den ursprungswert
     BitShiftConfig.DirectOut:=DirectOut;

     Application.ProcessMessages();

     result:=not(ErrorFound);
end;

function TTest_AutomaticTesTForm.Test_Test3(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;
    ErrorFound:boolean;
    SelectTesT:TSelectTesT;

begin
     ErrorFound:=false;

    //Alle Treiber auschalten
     DisabelAllDrivers();

     SelectTesT:=TSelectTesT.Create;
     status:=SelectTesT.IFKSelectTest(ErrorListe);
     if(status = false) then ErrorFound:= true;

     if(ErrorFound = false) then begin
        Test3Shape.Brush.Color:= clLime;
        Test3Label.Caption := '    OK';
        ErrorListe.Add('Select Test: OK');
        if(AutoTest=true) then begin
          TestResultArray[3]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
     end else begin
        Test3Shape.Brush.Color:= clRed;
        Test3Label.Caption := '  FALSE';
        ErrorListe.Add('Select Test: ERROR !');
        if(AutoTest=true) then begin
          TestResultArray[3]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
     end;

     SelectTesT.Free;
     Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_Test4(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;
    ErrorFound:boolean;

begin
     ErrorFound:=false;

    //Alle Treiber auschalten
     DisabelAllDrivers();

     status:= Test_DirectionTest(ErrorListe);

     if(status = false) then ErrorFound:= true;

     if(ErrorFound = false) then begin
        Test4Shape.Brush.Color:= clLime;
        Test4Label.Caption := '    OK';
        ErrorListe.Add('Select Test: OK');
        if(AutoTest=true) then begin
          TestResultArray[4]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
     end else begin
        Test4Shape.Brush.Color:= clRed;
        Test4Label.Caption := '  FALSE';
        ErrorListe.Add('Select Test: ERROR !');
        if(AutoTest=true) then begin
          TestResultArray[4]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
     end;
end;

function TTest_AutomaticTesTForm.Test_Test5(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;
    ErrorFound:boolean;

begin
    ErrorFound:=false;

    //Alle Treiber auschalten
     DisabelAllDrivers();

     //Beim PG-Stecker shift test werden nur die der benoetigte treiber (P)
     //auf out geschaltet und die anderen treiber (A-Srest) auf input um
     //kurzschluesse zu vermeiden
     BitShiftConfig.DirectOut:=DirectOutP;

     // Pgy-Leisten Test: 1 shift Master Out, Slave In
     status:= Test_ShiftBitTest(true, true, false,ErrorListe);
     if(status = false) then ErrorFound:= true;
     // Pgy-Leisten Test: 1 shift Master In, Slave Out
     status:= Test_ShiftBitTest(true, false, false,ErrorListe);
     if(status = false) then ErrorFound:= true;
     // Pgy-Leisten Test: 0 shift Master Out, Slave In
     status:= Test_ShiftBitTest(false,true, false,ErrorListe);
     if(status = false) then ErrorFound:= true;
     // Pgy-Leisten Test: 0 shift Master In, Slave Out
     status:= Test_ShiftBitTest(false, false, false,ErrorListe);
     if(status = false) then ErrorFound:= true;

     if(ErrorFound = false) then begin
        Test5Shape.Brush.Color:= clLime;
        Test5Label.Caption:= '    OK';
        ErrorListe.Add('Pgy-Bit TesT: OK');
        if(AutoTest=true) then begin
          TestResultArray[5]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
     end else begin
        Test5Shape.Brush.Color:= clRed;
        Test5Label.Caption:= '  FALSE';
        ErrorListe.Add('Pgy-Bit TesT: ERROR !');
        if(AutoTest=true) then begin
          TestResultArray[5]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
     end;

     //wieder brav auf den ursprungswert
     BitShiftConfig.DirectOut:=DirectOut;

     Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_Test6(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;

begin
    //Alle Treiber auschalten
     DisabelAllDrivers();

     status:= Test_TimingKanalTest(ErrorListe);

     if(status = true) then begin
        Test6Shape.Brush.Color:= clLime;
        Test6Label.Caption:= '    OK';
        ErrorListe.Add('TimingKanal Test: OK');
        if(AutoTest=true) then begin
          TestResultArray[6]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
      end else begin
        Test6Shape.Brush.Color:= clRed;
        Test6Label.Caption:= '  FALSE';
        ErrorListe.Add('TimingKanal Test: ERROR !');
        if(AutoTest=true) then begin
         TestResultArray[6]:= false;
         TestResultBool:=false;
         TestResultString:= TestResultString + ProtListeFail
        end;
      end;
      Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_Test7(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;

begin
    //Alle Treiber auschalten
     DisabelAllDrivers();

     status:= Test_DrqDryInlTest(ErrorListe);

     if(status = true) then begin
        Test7Shape.Brush.Color:= clLime;
        Test7Label.Caption:= '    OK';
        ErrorListe.Add('Drq Dry Inl Test: OK');
        if(AutoTest=true) then begin
          TestResultArray[6]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
      end else begin
        Test7Shape.Brush.Color:= clRed;
        Test7Label.Caption:= '  FALSE';
        ErrorListe.Add('Drq Dry Inl Test: ERROR !');
        if(AutoTest=true) then begin
          TestResultArray[7]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
      end;
      Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_Test8(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;

begin
    //Alle Treiber auschalten
     DisabelAllDrivers();

     status:= Test_ExterneClockTest(ErrorListe);

     if(status = true) then begin
        Test8Shape.Brush.Color:= clLime;
        Test8Label.Caption:= '    OK';
        ErrorListe.Add('Externe Clock Test: OK');
        if(AutoTest=true) then begin
          TestResultArray[8]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
      end else begin
        Test8Shape.Brush.Color:= clRed;
        Test8Label.Caption:= '  FALSE';
        ErrorListe.Add('Externe Clock Test: ERROR !');
        if(AutoTest=true) then begin
          TestResultArray[8]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
      end;
      Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_Test9(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;

begin
    //Alle Treiber auschalten
     DisabelAllDrivers();

     // wurde der jumper nicht am anfang gezogen -> fehler
     if(JumperHD6408Set = false) then begin
       status:= Test_ManchesterTest(ErrorListe);
     end else begin
         status:= false;
         ErrorListe.Add('Jumper HD6408 permanently set');
     end;

     if(status = true) then begin
        Test9Shape.Brush.Color:= clLime;
        Test9Label.Caption := '    OK';
        ErrorListe.Add('Manchester Test: OK');
        if(AutoTest=true) then begin
          TestResultArray[9]:= true;
          TestResultString:= TestResultString + ProtListeOK
        end;
     end else begin
        Test9Shape.Brush.Color:= clRed;
        Test9Label.Caption := '  FALSE';
        ErrorListe.Add('Manchester Test: ERROR !');
        if(AutoTest=true) then begin
          TestResultArray[9]:= false;
          TestResultBool:=false;
          TestResultString:= TestResultString + ProtListeFail
        end;
      end;
      Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_ProgTesTVers(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;

begin
    //Alle Treiber auschalten
     DisabelAllDrivers();

     IFKProgrammierungForm.Show;
     status:=IFKProgrammierungForm.IFKProgrammierung(true,ErrorListe);

     if(status = true) then begin
          ProgramTestVerPanel.Color:= clLime;
          Test_ProgTesTVers:=true;
          ErrorListe.Add('Programmieren der Testsoft.: OK');
          if(AutoTest=true) then begin
            TestResultString:= TestResultString+ProtListeOK
          end;
     end else begin
          ProgramTestVerPanel.Color:= clRed;
          Test_ProgTesTVers:=false;
          ErrorListe.Add('Programmieren der Testsoft.: ERROR');
          if(AutoTest=true) then begin
            Test_FailureTestAnzeige();
            ProgramFinalVerPanel.Color:= clRed;
            Application.MessageBox('Prüfling konnte nicht mit der Testsoftware prog. werden. Der Test wird abgebrochen','Mist', 16);
            TestResultString:= TestResultString+ProtListeFail;
          end;
     end;
     Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_ProgFinalVers(AutoTest:boolean;ErrorListe:TStrings):boolean;

var status:boolean;
    ErrStatus:_DWORD;

begin
    //Alle Treiber auschalten
     DisabelAllDrivers();

     IFKProgrammierungForm.Show;
     status:=IFKProgrammierungForm.IFKProgrammierung(false,ErrorListe);

     if(status = true) then begin
          ProgramFinalVerPanel.Color:= clLime;
          Test_ProgFinalVers:=true;
          ErrorListe.Add('Programmieren der Final-soft.: OK');
          if(AutoTest=true) then begin
            TestResultString:= TestResultString+ProtListeOK
          end;
     end else begin
          ProgramFinalVerPanel.Color:= clRed;
          Test_ProgFinalVers:=false;
          ErrorListe.Add('Programmieren der Final-soft.: ERROR');
          if(AutoTest=true) then begin
            Test_FailureTestAnzeige();
            ProgramFinalVerPanel.Color:= clRed;
            Application.MessageBox('Prüfling konnte nicht mit der Finalen Version prog. werden. Der Test ist fehlgeschlagen','Mist', 16);
            TestResultString:= TestResultString+ProtListeFail;
          end;
     end;

     //ausgang master disable
     //PCI_IfkWrite(Cardauswahl, IFKAdressMaster, FCWR_EnabelTreiber, DisableTreiber, ErrStatus);
     Application.ProcessMessages();
end;

function TTest_AutomaticTesTForm.Test_ShiftBitTest(InitZero:boolean;
                                                   MasterOut:boolean;
                                                   VGTesT:boolean;
                                                   ErrorListe:TStrings):boolean;

var ErrStatus:_DWORD;
    BitMusterTesT:TBitMusterTest;
    myBitShift:TBitShift;
    index:byte;
    IndexBit:_Word;
    IndexArray:_Word;
    MaxIndexArray:_Byte;
    MaxIndexBit:_Byte;
    TestSuccess:boolean;
    ErrFound:boolean;


begin
     index:=0;
     IndexBit:=1;
     ErrStatus:=0;
     IndexArray:=1;
     TestSuccess:= true;
     ErrFound:= false;

     //---------------Test 1: VG-Leisten bit shift test ------------

     // object für das ein & auslesen der VGL erzeugen
     BitMusterTesT:= TBitMusterTest.Create;

     BitMusterTesT.Init(BitShiftConfig);

     // richtunge festlegen
     if (MasterOut = true) then begin
        BitMusterTesT.SetMasterOutSlaveIn(ErrStatus);
        if(ErrStatus<> StatusOK) then begin
          ErrorListe.Add('Err.SetMasterOutSlaveIn: $'+IntToHex(ErrStatus, 4));
          ErrFound:=true;
        end;
     end else begin
         BitMusterTesT.SetMasterInSlaveOut(ErrStatus);
         if(ErrStatus<> StatusOK) then begin
           ErrorListe.Add('Err.SetMasterInSlaveOut: $'+IntToHex(ErrStatus, 4));
           ErrFound:=true;
         end;
     end;

     ErrStatus:=StatusOK;

     // object für das shiften anlegen
     myBitShift:= TBitShift.Create;

     // mit 1 shiften oder mit 0
     if (VGTesT = true) then begin
        myBitShift.InitBitShift(InitZero, VglMaxword, VglMaxBit);
        MaxIndexArray:= VglMaxword;
        MaxIndexBit:= VglMaxBit;
     end else begin
        myBitShift.InitBitShift(InitZero, PgyMaxword, PgyMaxBit);
        MaxIndexArray:= PgyMaxword;
        MaxIndexBit:= PgyMaxBit;
     end;

     myBitShift.resetBitShift();

     while(IndexBit <= MaxIndexBit) do begin

         // ums eins shiften und lesen
         myBitShift.ShiftBitShift(index);
         myBitShift.readBitShift(SetBitShiftArray);

         if(MasterOut = true) then begin
            // An die Master-VG leiste oder Piggy versenden
            if (VGTesT = true) then begin
               BitMusterTesT.WrBitVGMaster(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.WrBitVGMaster: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
            end else begin
               BitMusterTesT.WrPgyMaster(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.WrPgyMaster: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
            end;
         end else begin
            if (VGTesT = true) then begin
               BitMusterTesT.WrBitVGSlave(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.WrBitVGSlave: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
           end else begin
               BitMusterTesT.WrPgySlave(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.WrPgySlave: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
           end;
         end;

         ErrStatus:=StatusOK;

         if(MasterOut = true) then begin
            // Vom Slave-VG leiste oder Piggy lesen
            if (VGTesT = true) then begin
               BitMusterTesT.RdBitVGSlave(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.RdBitVGSlave: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
            end else begin
               BitMusterTesT.RdPgySlave(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.RdPgySlave: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
            end;
         end else begin
             if(VGTesT = true) then begin
               BitMusterTesT.RdBitVGMaster(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.RdBitVGMaster: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
             end else begin
               BitMusterTesT.RdPgyMaster(ErrStatus);
               if(ErrStatus <> StatusOK) then begin
                 ErrorListe.Add('Err.RdPgyMaster: $'+IntToHex(ErrStatus, 4));
                 ErrFound:=true;
               end;
             end;
         end;

         ErrStatus:=StatusOK;

         // Wenn Master In gesetzt ist muss bei der VG-Leiste
         // das Bit D1 ignoriert werden
         if((MasterOut = false) and (VGTesT = true)) then begin
           SetBitShiftArray [2]:= SetBitShiftArray [2] and $FFFE;
           ReadBitShiftArray[2]:= ReadBitShiftArray[2] and $FFFE;
         end;

         // Wird mit einsen init. dann mus das 6ste wort angepasst werden
         // da es ja nur bis D88 geht
         if((InitZero = false) and (VGTesT = true)) then begin
           SetBitShiftArray[6]:= SetBitShiftArray[6] and $1FF;
         end;

         // wird der piggy-stecker getestet & mit einsen init.
         //dann muss das 3te wort angepasst werden da es ja nur
         //bis D45 geht
         if((InitZero = false) and (VGTesT = false)) then begin
           SetBitShiftArray[3]:= SetBitShiftArray[3] and $3FFF;
         end;

         while(IndexArray <= MaxIndexArray) do begin
           if(SetBitShiftArray[IndexArray] <> ReadBitShiftArray[IndexArray]) then begin
             TestSuccess:= false;
             ErrFound:=true;

             ErrorListe.Add('Error  SetBitShiftArray['+IntToStr(IndexArray)+
                            '] $'+IntToHex(SetBitShiftArray[IndexArray],4)+
                            ' -D[15..0] '+intToBinary(SetBitShiftArray[IndexArray],16));

             ErrorListe.Add('      ReadBitShiftArray['+IntToStr(IndexArray)+
                            '] $'+IntToHex(ReadBitShiftArray[IndexArray],4)+
                            ' -D[15..0] '+intToBinary(ReadBitShiftArray[IndexArray],16));


             {
             ErrorListe.Add('Err.SetBitShiftArray['+IntToStr(IndexArray)+
                            '] <>ReadBitShiftArray['+IntToStr(IndexArray)+
                            ']: $'+IntToHex(SetBitShiftArray[IndexArray],4)+
                            ' <> $'+IntToHex( ReadBitShiftArray[IndexArray],4))}
           end;
           IndexArray:= IndexArray + 1;
         end;

         IndexBit:= IndexBit+1;
         IndexArray:= 1;
     end;

     // Objecte wieder freigeben
     myBitShift.Free();
     BitMusterTesT.Free();

     if(ErrFound<> false) or (TestSuccess <> true) then result:=false
     else result:=true;
end;

function TTest_AutomaticTesTForm.Test_TimingKanalTest(ErrorListe:TStrings):boolean;

var TimingTest:TTimingTest;
    Status:boolean;

begin
     TimingTest:= TTimingTest.Create;
     Status:= TimingTesT.TimingKanalTest(ErrorListe);
     TimingTesT.Free;
     result:= status;
end;

function TTest_AutomaticTesTForm.Test_DrqDryInlTest(ErrorListe:TStrings):boolean;

var DrqDryInlTest:TInterruptTest;
    status:boolean;

begin
    DrqDryInlTest:= TInterruptTest.Create;
    status:= DrqDryInlTest.InterruptTest(ErrorListe);
    DrqDryInlTest.Free;

    result:=status;
end;

function TTest_AutomaticTesTForm.Test_ExterneClockTest(ErrorListe:TStrings):boolean;

var ErrStatus:_DWORD;
    RdInpRegIFK:_WORD;
    ErrorFound:boolean;


begin
     ErrStatus:= StatusOK;
     ErrorFound:= false;

     //An den Master wird ein INL auf das output-reg geschrieben
     PCI_IfkWrite (Cardauswahl, IFKAdressMaster, IntIFKWR, IntIFKINL, ErrStatus);
     if(ErrStatus <> StatusOK)then begin
       ErrorListe.Add('Err.Set on master output-reg. a INL: $'+ IntToHex(ErrStatus,4));
       ErrorFound:=true;
       ErrStatus:=StatusOK;
     end;

     //Slave auslesen. Im register sollte ext-clk gesetzt werden
     PCI_IfkRead (Cardauswahl, IFKAdressSlave, IntputIFKRegRd, RdInpRegIFK, ErrStatus);
     if(ErrStatus <> StatusOK)then begin
       ErrorListe.Add('Err.Read slave input-reg. ext-clk: $'+ IntToHex(ErrStatus,4));
       ErrorFound:=true;
       ErrStatus:=StatusOK;
     end;

     //prüfen
     if((RdInpRegIFK  and ExtClk) <> ExtClk) then begin
       ErrorListe.Add('Err.Read slave input-reg. <> ext-clk: $'+
                      IntToHex(RdInpRegIFK,4)+'<> $'+IntToHex(ExtClk,4));
       ErrorFound:= true;
     end;

     //Master output-reg löschen
     PCI_IfkWrite (Cardauswahl, IFKAdressMaster, IntIFKWR, $0, ErrStatus);
     if(ErrStatus <> StatusOK)then begin
       ErrorListe.Add('Err.reset master output-reg: $'+ IntToHex(ErrStatus,4));
       ErrorFound:=true;
       ErrStatus:=StatusOK;
     end;

     //Slave auslesen. Im register sollte ext-clk nicht gesetzt werden
     PCI_IfkRead (Cardauswahl, IFKAdressSlave, IntputIFKRegRd, RdInpRegIFK, ErrStatus);
     if(ErrStatus <> StatusOK)then begin
       ErrorListe.Add('Err.read slave input-reg: $'+ IntToHex(ErrStatus,4));
       ErrorFound:=true;
       ErrStatus:=StatusOK;
     end;

     //prüfen
     if((RdInpRegIFK  and ExtClk) <> $0) then begin
       ErrorListe.Add('Err.Read slave input-reg. <> ext-clk: $'+
                       IntToHex(RdInpRegIFK,4)+'<> $'+IntToHex(ExtClk,4));
       ErrorFound:= true;
     end;


     if(ErrorFound  = true) then result:= false
     else  result:= true;
end;

function  TTest_AutomaticTesTForm.Test_DirectionTest(ErrorListe:TStrings):boolean;

var RichtungsTesT:TRichtungsTesT;
    status:boolean;

begin
     RichtungsTesT:=TRichtungsTesT.Create;
     status:=RichtungsTesT.DirectionTesT(ErrorListe);
     RichtungsTesT.Free;
     result:=status;
end;

function  TTest_AutomaticTesTForm.Test_ManchesterTest(ErrorListe:TStrings):boolean;

var index:_WORD;
    senddata:_WORD;
    readdata:_WORD;
    status:_DWORD;
    ErrStatus:_DWORD;
    ErrFound:boolean;
    ExManchSet:boolean;
    button:_WORD;

begin
     index:= 0;
     ErrFound:=false;
     ExManchSet:= false;

     //-------------------------------------------------------------
     //--------------- Der jumper muss gesteckt sein----------
     //-------------------------------------------------------------
     while(ExManchSet = false) do begin
       ExManchSet:=AktManchesterEncDec();
       if(ExManchSet= false) then begin
         button:= Application.MessageBox('Bitte den Jumper HD6408 aufstecken !','Es kann ja nicht immer regnen',69);
          case button of
             IDCANCEL:begin
                     ExManchSet:=true;
                     ErrFound:= true;
                     end;
           end;
       end;
     end;

     if(ErrFound = false) then begin

      BitteWartenForm.Show;
      Application.ProcessMessages();

      while (index < 32767)  do begin
        // inverse oder normal als daten
        if(index mod (2)=0) then senddata:= not(index)
        else senddata:=index;
        // daten an den slave versenden
        status:= PCI_IfkWrite(PCIAdress, IFKAdressSlave, EchoRegWR, senddata, ErrStatus);
        if(status <> StatusOK) then begin
          ErrorListe.Add('Err.SendDataToSlaveEchoReg :$'+IntToHex(status,4));
          ErrFound:=true;
        end;
        // daten vom slave lesen
        status:= PCI_IfkRead(PCIAdress, IFKAdressSlave, EchoRegRD, readdata, ErrStatus);
        if(status <> StatusOK) then begin
          ErrorListe.Add('Err.ReadDataToSlaveEchoReg :$'+IntToHex(status,4));
          ErrFound:=true;
        end;
        // daten vergleichen
        if(senddata <> readdata) then begin
          ErrorListe.Add('Err.SendData <> ReadData :$'+IntToHex(senddata,4)+'<>$'+
                         IntToHex(readdata,4));
          ErrFound:=true;
        end;

        index:=index+1;
      end;

      BitteWartenForm.Close;
      Application.ProcessMessages();
     end;

     //-------------------------------------------------------------
     //--------------- Der jumper darf nicht gesteckt sein----------
     //-------------------------------------------------------------
     ExManchSet:=true;
     while(ExManchSet = true) do begin
       ExManchSet:=AktManchesterEncDec();
       if(ExManchSet= true) then begin
         button:= Application.MessageBox('Bitte den Jumper HD6408 entfernen !','Es kann ja nicht immer regnen',69);
          case button of
             IDCANCEL:begin
                     ExManchSet:=false;
                     ErrFound:= true;
                     end;
           end;
       end;
     end;
     result:=not(ErrFound);
end;

procedure TTest_AutomaticTesTForm.EndTesTButtonClick(Sender: TObject);

begin
     Test_AutomaticTesTForm.Close;
{     button:= Application.MessageBox('Prüfung beenden ?','Feierabend',36);
     if (button = IDYES) then Test_AutomaticTesTForm.Close;       }
end;

procedure TTest_AutomaticTesTForm.Test_InitTestAnzeige();

begin
     Test1Shape.Brush.Color:= clWhite;
     Test2Shape.Brush.Color:= clWhite;
     Test3Shape.Brush.Color:= clWhite;
     Test4Shape.Brush.Color:= clWhite;
     Test5Shape.Brush.Color:= clWhite;
     Test6Shape.Brush.Color:= clWhite;
     Test7Shape.Brush.Color:= clWhite;
     Test8Shape.Brush.Color:= clWhite;
     Test9Shape.Brush.Color:= clWhite;

     Test1Label.Caption := '..ready..';
     Test2Label.Caption := '..ready..';
     Test3Label.Caption := '..ready..';
     Test4Label.Caption := '..ready..';
     Test5Label.Caption := '..ready..';
     Test6Label.Caption := '..ready..';
     Test7Label.Caption := '..ready..';
     Test8Label.Caption := '..ready..';
     Test8Label.Caption := '..ready..';
     Test9Label.Caption := '..ready..';

     Application.ProcessMessages();
end;

procedure TTest_AutomaticTesTForm.Test_FailureTestAnzeige();
begin
     Test1Shape.Brush.Color:= clRed;
     Test2Shape.Brush.Color:= clRed;
     Test3Shape.Brush.Color:= clRed;
     Test4Shape.Brush.Color:= clRed;
     Test5Shape.Brush.Color:= clRed;
     Test6Shape.Brush.Color:= clRed;
     Test7Shape.Brush.Color:= clRed;
     Test8Shape.Brush.Color:= clRed;
     Test9Shape.Brush.Color:= clRed;

     Test1Label.Caption := '..ready..';
     Test2Label.Caption := '..ready..';
     Test3Label.Caption := '..ready..';
     Test4Label.Caption := '..ready..';
     Test5Label.Caption := '..ready..';
     Test6Label.Caption := '..ready..';
     Test7Label.Caption := '..ready..';
     Test8Label.Caption := '..ready..';
     Test9Label.Caption := '..ready..';

     Application.ProcessMessages();
end;

procedure TTest_AutomaticTesTForm.FormShow(Sender: TObject);
begin
     //------------------------------------------------
     // Grunderscheinungsbild erstellen

     NextIFKButton.Caption:= 'START TEST';
     LfdNrPanel.Caption:= TestLfdNr;

     Test_InitTestAnzeige();
     ProgramTestVerPanel.Color:= clBtnFace;
     ProgramFinalVerPanel.Color:= clBtnFace;

     Legende_ListBox.Clear;
     Legende_ListBox.Items.Add(ProtListeLegende1);
     Legende_ListBox.Items.Add(ProtListeLegende2);
     Legende_ListBox.Items.Add(ProtListeLegende3);
     Legende_ListBox.Items.Add(ProtListeLegende4);
     Legende_ListBox.Items.Add(ProtListeLegende5);
     Legende_ListBox.Items.Add(ProtListeLegende6);
     //---------------------------------------------------
     // variable initi.
     LfdNrDontShow:=false;
     Test_SetInit(BitShiftConfig);
end;


// Hier wird der Test_AutomaticTest gestartet, protokolliert,
// die anzeigen gesteuert etc..
procedure TTest_AutomaticTesTForm.Test_StartAutomaticTest();

var i:integer;
    abbruch:boolean;
    ExManchSet:boolean;
    ErrorFound:boolean;
    status:_DWORD;
    StatusBool:boolean;
    IFKAntwort:_WORD;
    ErrStatus:_DWORD;
    button:_WORD;
    myTestLfdNr:string;
    ErrorOut:TStrings;

begin
     ErrorFound:= false;
     abbruch:= false;
     ErrorOut:= TStringList.Create;
     ExManchSet:=true;

     //Anzeige rücksetzten
     Test_InitTestAnzeige();
     ProgramTestVerPanel.Color:= clBtnFace;
     ProgramFinalVerPanel.Color:= clBtnFace;

     //Beim ersten durchlauf darf die Lfd nicht geändert werden
     if(NextIFKButton.Caption= 'NEXT IFK') then begin
        LfdNrDWord:= StrToInt(TestLfdNr);
        LfdNrDWord:= LfdNrDWord + 1;
        TestLfdNr:= IntToStr(LfdNrDWord);
     end;

     //Beim ersten durchlauf darf die änderung der Lfd
     //nicht angezeigt werden
     if((NextIFKButton.Caption= 'NEXT IFK') and (LfdNrDontShow = false))then SRNummerEingabe.ShowModal;

     //Ausgabe LfdNr
     LfdNrPanel.Caption:= TestLfdNr;

     //-----------------------------------------
     // für das protokoll
     myTestLfdNr:= TestLfdNr;

     // mit Leerzeichen auffüllen
     while length(myTestLfdNr) < AbstandLfdTest do begin
          myTestLfdNr:= myTestLfdNr+' ';
     end;

     TestResultString:=myTestLfdNr;
     IsTestPast:=true;

     //-------- Pgrogrammtestfelder rücksetzten----------
     ProgramTestVerPanel.Color:= clBtnFace;
     ProgramFinalVerPanel.Color:= clBtnFace;
     Application.ProcessMessages();

     //-------------------------------------------------------------
     //------ Prüfling mit testsoftware impfen ---
     //-------------------------------------------------------------
     IFKProgrammierungForm.Show;


     //Alle Treiber auschalten
     DisabelAllDrivers();

     StatusBool:= Test_ProgTesTVers(true, ErrorOut);
     if(StatusBool =  false) then begin
       ErrorFound:= true;
       abbruch:=true;
     end;

     //-------------------------------------------------------------
     //---------- SLAVE suchen --------------
     //-------------------------------------------------------------
      while (abbruch = false) do begin
       status:= PCI_IfkRead (Cardauswahl, IFKAdressSlave, FktRead, IFKAntwort, ErrStatus);
       if((status <> StatusOK) or (IFKAntwort <> IFKAdressSlave)) then begin
         button:= Application.MessageBox(TestBoxNotFoundTXT,'Erfahrung ist die Belohnung des Schmerzes',69);
         case button of
           IDRETRY: begin
                     abbruch:=false;
                      IFKAntwort:=0;
                     ErrStatus:=0;
                    end;

           IDCANCEL:begin
                     abbruch:=true;
                     ErrorFound:= true;
                     Test_FailureTestAnzeige();
                    end;
         end;
       end else Abbruch:= true;
     end;

     //-------------------------------------------------------------
     //--------------- Der jumper darf nicht gesteckt sein----------
     //-------------------------------------------------------------
     JumperHD6408Set:=false;
     while(ExManchSet = true) do begin
       ExManchSet:=AktManchesterEncDec();
       if(ExManchSet= true) then begin
         button:= Application.MessageBox(TestTesteeNotFoundTXT,'Wer kriecht, kann nicht stolpern',69);
          case button of
             IDCANCEL:begin
                     ExManchSet:=false;
                     JumperHD6408Set:=true;
                     ErrorFound:=true;
                     Test_FailureTestAnzeige();
                     end;
            end;
       end;
     end;

     //-------------------------------------------------------------
     //---------------Test 1 bis 9 ---------------
     //-------------------------------------------------------------
     //Ist vorher kein fehler aufgetreten wir soll der test 1-9
     //durchgeführt werden.  Ansonsten wird abgebrochen
     if(ErrorFound= false) then StatusBool:= Test_AutomaticTest()
     else begin
       for i:=1 to 10 do begin
        TestResultString:= TestResultString+ProtListeNA;
       end;
     end;

     //-------------------------------------------------------------
     //----------Prüfling mit der finalen firmware impfen-----------
     //-------------------------------------------------------------

    //Alle Treiber auschalten
     DisabelAllDrivers();

     //Adresse setzten
     Test_SetSlaveAdress();

     if(ErrorFound= false) then begin
      IFKProgrammierungForm.Show;
       if (Test_ProgFinalVers(true, ErrorOut)= false) then begin
          ErrorFound:= true;
       end;

        //---------- SLAVE suchen --------------
        if(ErrorFound= false) then  abbruch:= false
        else  abbruch:= true;

        while (abbruch = false) do begin
          status:= PCI_IfkRead (Cardauswahl, IFKAdressSlave, FktRead, IFKAntwort, ErrStatus);
          if((status <> StatusOK) or (IFKAntwort <> IFKAdressSlave)) then begin
            button:= Application.MessageBox('Der Prüfling meldet sich nicht, bitte überprüfen Sie die Verkabelung ','Oh...Oh...',69);
            case button of
             IDRETRY: begin
                       Test_SetSlaveAdress();
                       abbruch:=false;
                       IFKAntwort:=0;
                       ErrStatus:=0;
                      end;

             IDCANCEL:begin
                       abbruch:=true;
                       ErrorFound:= true;
                       Application.MessageBox('Prüfling konnte nicht nach dem prog. der F-Version angesprochen werden. Der Test ist fehlgeschlagen','Fuck', 16);
                      end;
            end;
          end else Abbruch:= true;
        end;
     end;

     //-------------------------------------------------------------
     //------- Protokoll vervollstaendigen und rausschreiben--------
     //-------------------------------------------------------------
     //Sind die test erfolgreich gewesen
     if((StatusBool= true) and (ErrorFound= false)) then TestResultString:=TestResultString+ ProtLiaResSucs
     else TestResultString:=TestResultString+ ProtLiaResFail;

     //Rauschreiben
     TEST_ProtokollShowForm.WriteToProtokoll(TestResultString);
     TestResultString:='';
     // Next
     NextIFKButton.Caption:= 'NEXT IFK';

     //Alle Treiber auschalten
     DisabelAllDrivers();

//     IFKProgrammierungForm.FailSaveEnable()
end;


// setzt die init fuer bitshift
procedure Test_SetInit(var Config:TConfigRec);
begin
     Config.PCI_CardAdress:= Cardauswahl;
     Config.IFKMasterAdr:= IFKAdressMaster;
     Config.IFKSlaveAdr:=  IFKAdressSlave;

     Config.FCWR_EnabelDriver:= FCWR_EnabelTreiber;
     Config.FCRD_EnabelDriver:= FCRD_EnabelTreiber;

     Config.FCWR_DirectDriver:= FCWR_DirectTreiber;
     Config.FCRD_DirectDriver:= FCRD_DirectTreiber;

     Config.EnableDriver:= EnableTreiber;
     Config.DisableDriver:= DisableTreiber;

     Config.DirectOut:= DirectOut;
     Config.DirectIn:=  DirectIn;

     Config.WrVgl1:= WrVgl1;
     Config.WrVgl2:= WrVgl2;
     Config.WrVgl3:= WrVgl3;
     Config.WrVgl4:= WrVgl4;
     Config.WrVgl5:= WrVgl5;
     Config.WrVgl6:= WrVgl6;

     Config.RdVgl1:= RdVgl1;
     Config.RdVgl2:= RdVgl2;
     Config.RdVgl3:= RdVgl3;
     Config.RdVgl4:= RdVgl4;
     Config.RdVgl5:= RdVgl5;
     Config.RdVgl6:= RdVgl6;

     Config.WrPgy1:= WrPgy1;
     Config.WrPgy2:= WrPgy2;
     Config.WrPgy3:= WrPgy3;

     Config.RdPgy1:= RdPgy1;
     Config.RdPgy2:= RdPgy2;
     Config.RdPgy3:= RdPgy3;

     Config.MaxArry:=6;
     Config.MaxBit:= 89;
     Config.ZeroOneShift:=false;
end;

// Hier wird der test getsartet, vorher wird geprueft ob
// die pruefbox(MasterIFK) sich meldet
procedure TTest_AutomaticTesTForm.NextIFKButtonClick(Sender: TObject);

var status:_DWORD;
    ErrorFound:boolean;
    Abbruch:boolean;
    IFKAntwort:_WORD;
    ErrStatus:_DWORD;
    button:_WORD;

begin
    ErrorFound:=false;
    abbruch:=false;

     //Master suchen
     while (abbruch = false) do begin
       status:= PCI_IfkRead (Cardauswahl, IFKAdressMaster, FktRead, IFKAntwort, ErrStatus);
       if((status <> StatusOK) or (IFKAntwort <> IFKAdressMaster)) then begin
         button:= Application.MessageBox(TestBoxNotFoundTXT,'Die Ente quakt gleich doppelt so laut, wenn man ihr auf den Bürzel haut',69);
           case button of
            IDRETRY: begin
                     abbruch:=false;
                     IFKAntwort:=0;
                     ErrStatus:=0;
                     end;

            IDCANCEL:begin
                     abbruch:=true;
                     ErrorFound:= true;
                     end;
            end;
       end else Abbruch:= true;
     end;

     if(ErrorFound) = false then Test_StartAutomaticTest;
end;

procedure TTest_AutomaticTesTForm.Enabel1Click(Sender: TObject);
begin
     Test1_Start.Visible := true;
     Test2_Start.Visible := true;
     Test3_Start.Visible := true;
     Test4_Start.Visible := true;
     Test5_Start.Visible := true;
     Test6_Start.Visible := true;
     Test7_Start.Visible := true;
     Test8_Start.Visible := true;
     Test9_Start.Visible := true;

     ProgTestVers.Visible:= true;
     PrgFinaleVers.Visible:= true;

     Test1_Detail.Visible := true;
     Test2_Detail.Visible := true;
     Test3_Detail.Visible := true;
     Test4_Detail.Visible := true;
     Test5_Detail.Visible := true;
     Test6_Detail.Visible := true;
     Test7_Detail.Visible := true;
     Test8_Detail.Visible := true;
     Test9_Detail.Visible := true;

     DebugForm.Show;
end;

procedure TTest_AutomaticTesTForm.Disabel1Click(Sender: TObject);
begin
     Test1_Start.Visible := false;
     Test2_Start.Visible := false;
     Test3_Start.Visible := false;
     Test4_Start.Visible := false;
     Test5_Start.Visible := false;
     Test6_Start.Visible := false;
     Test7_Start.Visible := false;
     Test8_Start.Visible := false;
     Test9_Start.Visible := false;

     ProgTestVers.Visible:= false;
     PrgFinaleVers.Visible:= false;

     Test1_Detail.Visible := false;
     Test2_Detail.Visible := false;
     Test3_Detail.Visible := false;
     Test4_Detail.Visible := false;
     Test5_Detail.Visible := false;
     Test6_Detail.Visible := false;
     Test7_Detail.Visible := false;
     Test8_Detail.Visible := false;
     Test9_Detail.Visible := false;

     DebugForm.Close;
end;

procedure TTest_AutomaticTesTForm.Test1_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test1Shape.Brush.Color:= clWhite;
     Test1Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test1(false, ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test2_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test2Shape.Brush.Color:= clWhite;
     Test2Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test2(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test3_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test3Shape.Brush.Color:= clWhite;
     Test3Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test3(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test4_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test4Shape.Brush.Color:= clWhite;
     Test4Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test4(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test5_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test5Shape.Brush.Color:= clWhite;
     Test5Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test5(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test6_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test6Shape.Brush.Color:= clWhite;
     Test6Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test6(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test7_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test7Shape.Brush.Color:= clWhite;
     Test7Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test7(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test8_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test8Shape.Brush.Color:= clWhite;
     Test8Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test8(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test9_StartClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     Test9Shape.Brush.Color:= clWhite;
     Test9Label.Caption := '..ready..';

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_Test9(false,ErrorListe);

     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.Test_SetSlaveAdress();

var ErrStatus:_DWORD;

begin
       //================================================================
       //                  Adresse fuer slave anlegen
       //================================================================

       //als erstes muss beim master die treiberrichtung
       //S0-S15 auf out gesetzt werden
       PCI_IfkWrite(Cardauswahl, IFKAdressMaster, FCWR_DirectTreiber, ProgSetMasterOut, ErrStatus);

       //Slave muss seine adresse ueber den master bekommen
       //dazu wird d0-15 die adresse vom slvae (2) angelegt
       PCI_IfkWrite(Cardauswahl, IFKAdressMaster, WrVgl1, IFKAdressSlave, ErrStatus);

       //mastertreiber anablen
       PCI_IfkWrite(Cardauswahl, IFKAdressMaster, FCWR_EnabelTreiber, EnableTreiber, ErrStatus);
end;

procedure TTest_AutomaticTesTForm.ProgTesTVersClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     ProgramTestVerPanel.Color:= clBtnFace;

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_ProgTesTVers(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

procedure TTest_AutomaticTesTForm.ProgFinalVersClick(Sender: TObject);

var ErrorListe:TStrings;
    ErrStatus:DWORD;

begin
     ErrorListe:= TStringList.Create;

     ProgramFinalVerPanel.Color:= clBtnFace;

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 500, 1, ErrStatus);

     Test_ProgFinalVers(false,ErrorListe);
     DebugForm.DebugListBox.Items:=ErrorListe;
     ErrorListe.Free;
end;

// Prüft slave input-reg ob manchester decoder extern  oder intern
function TTest_AutomaticTesTForm.AktManchesterEncDec():boolean;

var ErrStatus:DWORD;
    RdInpRegIFK:WORD;

begin
     ErrStatus:=StatusOK;
     //Slave input register auslesen
     PCI_IfkRead (Cardauswahl, IFKAdressSlave, IntputIFKRegRd, RdInpRegIFK, ErrStatus);

     if(ErrStatus = StatusOK) then begin
       //prüfen
       if((RdInpRegIFK  and AktManchDec) = AktManchDec) then result:=true
       else result:=false;
     end else result:=false;
end;

procedure TTest_AutomaticTesTForm.DisabelAllDrivers();

var ErrStatus:_DWORD;

begin
     //Master teiber ausschalten
     PCI_IfkWrite(PCIAdress, IFKAdressMaster,FCWR_EnabelTreiber,DisableTreiber,ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster,IntIFKWR,DisIFKDRQYINL,ErrStatus);

     //Slave teiber auschalten
     PCI_IfkWrite(PCIAdress, IFKAdressSlave,FCWR_EnabelTreiber,DisableTreiber,ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressSlave,IntIFKWR,DisIFKDRQYINL,ErrStatus);

     //Master treiberrichtung  auf in
     PCI_IfkWrite(PCIAdress, IFKAdressMaster,FCWR_DirectTreiber,DirectIn ,ErrStatus);
     //Slave treiberrichtung  auf in
     PCI_IfkWrite(PCIAdress, IFKAdressSlave,FCWR_DirectTreiber,DirectIn ,ErrStatus);

     // Master VG-Leiste nullen
     PCI_IfkWrite(PCIAdress, IFKAdressMaster, WrVgl1,$0000, ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster, WrVgl2,$0000, ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster, WrVgl3,$0000, ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster, WrVgl4,$0000, ErrStatus);

     // Slave VG-Leiste nullen
     PCI_IfkWrite(PCIAdress, IFKAdressSlave, WrVgl1,$0000, ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressSlave, WrVgl2,$0000, ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressSlave, WrVgl3,$0000, ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressSlave, WrVgl4,$0000, ErrStatus);
end;

procedure TTest_AutomaticTesTForm.FormClose(Sender: TObject; var Action: TCloseAction);

var button:_WORD;

begin
    button:= Application.MessageBox('Prüfung beenden ?','Feierabend',36);
    if (button = IDNO) then Action:=caNone;
end;

procedure TTest_AutomaticTesTForm.V1Click(Sender: TObject);
begin
     SingelShiftTest:= TExpertSingelShiftTest.Create;
     SingelBitMusterForm.ShowModal;
end;

end.
