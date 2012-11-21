//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// *Test Timing Test
// *Testet timing reg.
// *reg wird mit zero und eins shift beschrieben & gelesen
// *daten werden verglichen muessen gleich sein
// *die klasse TBitShift wird benoetigt
//====================================

unit TEST_TimingTEST;

interface

uses TEST_GLobaleVariaben,UnitMil,BitShiftClass,Classes,Sysutils;


type TTimingTest = class

 private
  BitShift:TBitShift;
  BitShiftArray:TBitShiftArray;

  function WriteReadCheck(daten:_WORD; ErrorListe:TStrings; var ErrStatus:_DWORD):boolean;
  function TimingTest(ZeroInit:boolean; ErrorListe:TStrings):boolean;

 public
  function TimingKanalTest(ErrorListe:TStrings):boolean;

 end;

implementation
// ---------------- Private---------------------
function TTimingTest.WriteReadCheck(daten:_WORD; ErrorListe:TStrings; var ErrStatus:_DWORD):boolean;

var status:_DWORD;
    antwort:_WORD;

begin

     status:= PCI_IFKWrite(PCIAdress, IFKAdressSlave, WrTiming, daten, ErrStatus);
     if(status <> StatusOK) then begin
       ErrorListe.Add('Err.Write data to Slave: $'+IntToHex(status,4));
       status:=StatusOK;
     end;

     status:= PCI_IFKRead(PCIAdress, IFKAdressSlave, RdTiming, antwort, ErrStatus);
     if(status <> StatusOK) then begin
       ErrorListe.Add('Err.Read data from Slave: $'+IntToHex(status,4));
       status:=StatusOK;
     end;

     result:= true;

     if(daten <> antwort) then begin
       ErrorListe.Add('Err.Write <> Read: $'+IntToHex(daten,4)+'<>$'+IntToHex(antwort,4));
       result:= false
     end;

     if(ErrStatus <> StatusOK) then result:= false;
end;

function TTimingTest.TimingTest(ZeroInit:boolean; ErrorListe:TStrings):boolean;

var TestStatus:boolean;
    ErrStatus:_DWORD;
    index:_WORD;
    Bitindex:_BYTE;

begin
     index:=0;
     ErrStatus:=StatusOK;
     BitShift:= TBitShift.Create;
     BitShift.resetBitShift();
     BitShift.InitBitShift(ZeroInit, 1, 16);

     while(index <=16) do begin
        BitShift.readBitShift(BitShiftArray);
        TestStatus:=WriteReadCheck(BitShiftArray[1], ErrorListe,ErrStatus);
        BitShift.ShiftBitShift(Bitindex);
        index:=index+1;
     end;

     BitShift.Free;
     result:= TestStatus;
end;

// ---------------- public---------------------
function TTimingTest.TimingKanalTest(ErrorListe:TStrings):boolean;

var TestStatus:boolean;
    ErrorFound:boolean;

begin
    ErrorFound:= false;

    TestStatus:= TimingTest(true,ErrorListe);
    if(TestStatus = false) then ErrorFound:=true;

    TestStatus:= TimingTest(false,ErrorListe);
    if(TestStatus = false) then ErrorFound:=true;
    result:=not(ErrorFound);
end;


end.
