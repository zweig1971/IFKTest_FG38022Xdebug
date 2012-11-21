//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte �nderung : 05.09.2008
//
// TEST Richtungs test
// * pr�ft funktion des selektierte treibers
// und auf beeinflussung der benachtbarten treiber
// *
//====================================


unit TEST_SelectTest;

interface

uses SysUtils,TEST_GLobaleVariaben,UnitMil,BitShiftClass,
     TEST_Debug,TEST_BitMusterTest,classes;

type TTestDriver = record
       MaskWord:array[1..6] of _WORD;
     end;

     TSelectTesT = class

private
 procedure SetArray();

public
 function IFKSelectTest(ErrorListe:TStrings):boolean;

end;

var TestDriver:array[1..10] of TTestDriver;
    DriverArray:array[1..10] of _WORD;
    SelectConfig:TConfigRec;


implementation

uses TEST_AutomaticTest;

//-------------- private ------------------
procedure TSelectTesT.SetArray();

var i:byte;
    x:byte;

begin

     //Test matrix zusammenfrickeln
     for i:= 1 to 10 do begin
       for x:=1 to 6 do begin
         if(x=1) then TestDriver[i].MaskWord[x]:=$00FF
         else if(x=2) then TestDriver[i].MaskWord[x]:=$FFFE
          else if(x=6) then TestDriver[i].MaskWord[x]:=$01FF
           else TestDriver[i].MaskWord[x]:=$FFFF;
       end;
     end;

     TestDriver[1].MaskWord[6]:= SelectTestA6;
     TestDriver[2].MaskWord[5]:= SelectTestB5;
     TestDriver[3].MaskWord[5]:= SelectTestC5;
     TestDriver[4].MaskWord[4]:= SelectTestD5;
     TestDriver[5].MaskWord[4]:= SelectTestE4;
     TestDriver[6].MaskWord[5]:= SelectTestF5;
     TestDriver[7].MaskWord[5]:= SelectTestG5;
     TestDriver[8].MaskWord[4]:= SelectTestH4;
     TestDriver[9].MaskWord[6]:= SelectTestI6;
     TestDriver[10].MaskWord[4]:=SelectTestS4;

     //das zu sendende array nullen
     for  i:= 1 to 6  do begin
          SetBitShiftArray[i]:=0;
     end;


     DriverArray[1]:= EnabelDriverA;
     DriverArray[2]:= EnabelDriverB;
     DriverArray[3]:= EnabelDriverC;
     DriverArray[4]:= EnabelDriverD;
     DriverArray[5]:= EnabelDriverE;
     DriverArray[6]:= EnabelDriverF;
     DriverArray[7]:= EnabelDriverG;
     DriverArray[8]:= EnabelDriverH;
     DriverArray[9]:= EnabelDriverI;
     DriverArray[10]:= EnabelDriverS;
end;


function TSelectTesT.IFKSelectTest(ErrorListe:TStrings):boolean;

var ErrStatus:_DWORD;
    IFKSelectTesT:TBitMusterTest;
    TreiberIndex:_WORD;
    index:_WORD;
    NoErrorFound:boolean;

begin
     ErrStatus:=0;
     TreiberIndex:= 1;
     IFKSelectTesT:= TBitMusterTest.Create;
     Test_SetInit(SelectConfig);
     IFKSelectTesT.Init(SelectConfig);
     NoErrorFound:= true;

     SetArray();

     //Master treiber auf input
     PCI_IfkWrite(PCIAdress, IFKAdressMaster,FCWR_DirectTreiber,DirectIn,ErrStatus);
     if(ErrStatus <> StatusOK) then  begin
       ErrorListe.Add('Err.SetMasterDriverInput: $'+IntToHex(ErrStatus, 4));
       ErrStatus:= StatusOK;
     end;

     //Master teiber einschalten
     PCI_IfkWrite(PCIAdress, IFKAdressMaster,FCWR_EnabelTreiber,EnableTreiber,ErrStatus);
     if(ErrStatus <> StatusOK) then  begin
       ErrorListe.Add('Err.SetMasterDriverEnabel: $'+IntToHex(ErrStatus, 4));
       ErrStatus:= StatusOK;
     end;

      //Slave treiber auf output
     PCI_IfkWrite(PCIAdress, IFKAdressSlave,FCWR_DirectTreiber,DirectOut,ErrStatus);
     if(ErrStatus <> StatusOK) then  begin
       ErrorListe.Add('Err.SetSlaveDriverOutput: $'+IntToHex(ErrStatus, 4));
       ErrStatus:= StatusOK;
     end;


     //die IO der VG-leiste des slaves definieren
     IFKSelectTesT.WrBitVGSlave(ErrStatus);
     if(ErrStatus <> StatusOK) then  begin
       ErrorListe.Add('Err.WrSlaveVG: $'+IntToHex(ErrStatus, 4));
       ErrStatus:= StatusOK;
     end;


     while(TreiberIndex <= 10) do begin

       //slave treiber ausschalten
       PCI_IfkWrite(PCIAdress, IFKAdressSlave,FCWR_EnabelTreiber,DisableTreiber,ErrStatus);
       if(ErrStatus <> StatusOK) then  begin
         ErrorListe.Add('Err.SetSlaveDriverDisable: $'+IntToHex(ErrStatus, 4));
         ErrStatus:= StatusOK;
       end;

        //treiber von A...S durchschalten
       PCI_IfkWrite(PCIAdress, IFKAdressSlave,FCWR_EnabelTreiber,DriverArray[TreiberIndex],ErrStatus);
       if(ErrStatus <> StatusOK) then  begin
         ErrorListe.Add('Err.SlaveDriverSwitch[$'+IntToHex(DriverArray[TreiberIndex],4)+']: $'+IntToHex(ErrStatus, 4));
         ErrStatus:= StatusOK;
       end;

       //daten vom Master lesen
       IFKSelectTesT.RdBitVGMaster(ErrStatus);
       if(ErrStatus <> StatusOK) then  begin
         ErrorListe.Add('Err.RdMasterVG: $'+IntToHex(ErrStatus, 4));
         ErrStatus:= StatusOK;
       end;

       //daten miteinander vergleichen
       for index:=4 to 6 do begin
         if(ReadBitShiftArray[index] <> TestDriver[TreiberIndex].MaskWord[index]) then begin
            ErrorListe.Add('Error Treiber $'+IntToHex(DriverArray[TreiberIndex],4));
            ErrorListe.Add('      ReadVG  '+'['+IntToStr(index)+'] $'+
                           IntToHex(ReadBitShiftArray[index], 4)+
                           ' -D[15..0] '+intToBinary(ReadBitShiftArray[index],16));

            ErrorListe.Add('      ShouldBe'+'['+IntToStr(index)+'] $'
                           +IntToHex(TestDriver[TreiberIndex].MaskWord[index],4)+
                           ' -D[15..0] '+intToBinary(TestDriver[TreiberIndex].MaskWord[index],16));
            NoErrorFound:= false;
         end;
       end;
       TreiberIndex:=TreiberIndex+1;

     end;

    IFKSelectTesT.Free;
    result:= NoErrorFound;
end;


end.
