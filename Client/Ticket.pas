unit Ticket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids;

type
  TfmTicket = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTicket: TfmTicket;

implementation

uses Unit2, NewTicket;

{$R *.dfm}

procedure TfmTicket.FormActivate(Sender: TObject);
begin
 DataSource1.DataSet := dm.cdsTicket;
end;

procedure TfmTicket.N1Click(Sender: TObject);
var k, s:integer;
begin
 fmNewTicket.eCarriage.Text:= '';
 fmNewTicket.eSpot.Text:= '';
 fmNewTicket.ePass.Text:= '';
 fmNewTicket.RadioButton1.Checked := FALSE;
 fmNewTicket.RadioButton2.Checked := FALSE;
 fmNewTicket.ePrice.Text:= '';
 fmNewTicket.eRoute.Text:= '';
 fmNewTicket.eAr.Text:= '';
 fmNewTicket.eTrip.Text:= '';
 fmNewTicket.DateTimePicker1.Date:=Now;
 fmNewTicket.DateTimePicker2.Time:= Now;
 fmNewTicket.ShowModal;
 if fmNewTicket.ModalResult = mrOk then
 begin
 if fmNewTicket.RadioButton2.Checked = TRUE then
  s := 0
  else
  s := 1;
  try
    dm.DCOMConnection1.AppServer.smAddTicket(0,fmNewTicket.DateTimePicker1.Date,
    fmNewTicket.eCarriage.Text, fmNewTicket.eSpot.Text, fmNewTicket.pass_id,s, fmNewTicket.ePrice.Text,
    fmNewTicket.route_id, fmNewTicket.trip_id, TimeToStr(fmNewTicket.DateTimePicker2.Time));
  except
  MessageDlg('������ ������', mtError, [mbOk],0);
  end;
  dm.cdsTicket.Refresh;

 end;
end;

procedure TfmTicket.N2Click(Sender: TObject);
   var id_trip, id_pass, id_route,k, s:integer;

begin
 id_trip := dm.cdsTicketID_TRIP.Value;
 id_route := dm.cdsTicketID_ROUTE.Value;
 id_pass := dm.cdsTicketID_PASS.Value;

  fmNewTicket.eCarriage.Text:= dm.cdsTicketCARRIAGE.Text;
 fmNewTicket.eSpot.Text:= dm.cdsTicketSPOT.Text;
 fmNewTicket.ePass.Text:= dm.cdsTicketPASS_NAME.Text;
 if dm.cdsTicketSTATUS.Value = 0 then
 fmNewTicket.RadioButton2.Checked := TRUE
 else
 fmNewTicket.RadioButton1.Checked := TRUE;
 fmNewTicket.ePrice.Text:= dm.cdsTicketPRICE.Text;
 fmNewTicket.eRoute.Text:= dm.cdsTicketROUTE_NAME.Text;
 fmNewTicket.eAr.Text:= dm.cdsTicketROUTE_AR.Text;
 fmNewTicket.eTrip.Text:= dm.cdsTicketID_TRIP.Text;
 fmNewTicket.DateTimePicker1.Date :=dm.cdsTicketDATA.Value;
 fmNewTicket.DateTimePicker2.Time:= StrToTime(dm.cdsTicketDEPARTURES.Value);

 fmNewTicket.ShowModal;
 if fmNewTicket.ModalResult = mrOk then
 begin
   if fmNewTicket.RadioButton2.Checked = TRUE then
  s := 0
  else
  s := 1;
  try
  if fmNewTicket.pass_id <> 0 then
  id_pass := fmNewTicket.pass_id;
  if fmNewTicket.route_id <> 0 then
  id_route := fmNewTicket.route_id;
  if fmNewTicket.trip_id <> 0 then
  id_trip := fmNewTicket.trip_id;
    dm.DCOMConnection1.AppServer.smAddTicket(dm.cdsTicketID_TIC.Value,fmNewTicket.DateTimePicker1.Date,
    fmNewTicket.eCarriage.Text, fmNewTicket.eSpot.Text, id_pass,s, fmNewTicket.ePrice.Text,
  id_route, id_trip, TimeToStr(fmNewTicket.DateTimePicker2.Time));
  except
  MessageDlg('������ ������', mtError, [mbOk],0);
  end;
  dm.cdsTicket.Refresh;
end;
end;

procedure TfmTicket.N3Click(Sender: TObject);
begin
  if MessageDlg('������� �����' +'' + IntToStr(dm.cdsTicketID_TIC.Value)+ '' +'?',
    mtConfirmation, [mbYes, mbNo],0) = mrYes then
 begin
  try
  dm.DCOMConnection1.AppServer.smDeleteTicket(dm.cdsTicketID_TIC.Value);
  except
  MessageDlg('������ ��������', mtError, [mbOk],0);
  end;
  dm.cdsTicket.Refresh;
end;
end;

procedure TfmTicket.N4Click(Sender: TObject);
begin
Close;
end;

end.
