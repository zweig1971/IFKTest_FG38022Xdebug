unit TEST_STOPForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg;

type
  TSTOP_Form = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Schliessen_Button: TButton;
    Abbruch_Button: TButton;
    procedure Abbruch_ButtonClick(Sender: TObject);
    procedure Schliessen_ButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  STOP_Form: TSTOP_Form;
  Abbruch:boolean;

implementation

uses TEST_ProtokollShow;

{$R *.DFM}

procedure TSTOP_Form.Abbruch_ButtonClick(Sender: TObject);
begin
     Abbruch:=true;
     STOP_FORM.Close;
end;

procedure TSTOP_Form.Schliessen_ButtonClick(Sender: TObject);
begin
     Abbruch:=false;
     STOP_FORM.Close;
end;

end.
