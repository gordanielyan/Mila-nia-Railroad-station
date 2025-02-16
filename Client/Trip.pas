unit Trip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids;

type
  TfmTrip = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N4Click(Sender: TObject);
  //  procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTrip: TfmTrip;

implementation

uses Unit2, NewTrip, NewTicket, NewTrain, TMP;

{$R *.dfm}

procedure TfmTrip.FormActivate(Sender: TObject);
begin
  DataSource1.DataSet:=dm.cdsTrip;
end;

procedure TfmTrip.N1Click(Sender: TObject);

  var k, s:integer;
begin
 fmNewTrip.eRoute.Text:= '';
 fmNewTrip.RadioButton1.Checked := FALSE;
 fmNewTrip.RadioButton2.Checked := FALSE;
 fmNewTrip.RadioButton3.Checked := FALSE;
 fmNewTrip.RadioButton4.Checked := FALSE;
 fmNewTrip.ShowModal;
 if fmNewTrip.ModalResult = mrOk then
 begin
   if fmNewTrip.RadioButton1.Checked = TRUE then
    s := 0
    else
    if fmNewTrip.RadioButton2.Checked = TRUE then
      s := 1
      else
      if fmNewTrip.RadioButton3.Checked = TRUE then
       s:= 2
       else
        s := 3;

 { if fmNewTrip.RadioButton1.Checked = TRUE then
  s := 0
  else
  s := 1;
  if (fmNewEmpl.eKolChild.Text = '') then
  k:=0
  else
  k:= StrToInt(fmNewEmpl.eKolChild.Text);    }
  try
    dm.DCOMConnection1.AppServer.smAddTrip(0,fmNewTrip.route_id , s);
  except
  MessageDlg('������ ������', mtError, [mbOk],0);
  end;
  dm.cdsTrip.Refresh;
  end;
end;

procedure TfmTrip.N2Click(Sender: TObject);
Var id_order, s:integer;
begin
  id_order := dm.cdsTripID_ROUTE.Value;
 if ( dm.cdsTripSTATUS.Value = 0 ) then
 fmNewTrip.RadioButton1.Checked := True
 else
 if ( dm.cdsTripSTATUS.Value = 1 ) then
  fmNewTrip.RadioButton2.Checked := True
  else
   if ( dm.cdsTripSTATUS.Value = 2 ) then
    fmNewTrip.RadioButton3.Checked := True
    else
    fmNewTrip.RadioButton4.Checked := True;
 fmNewTrip.eRoute.Text:= dm.cdsTripROUTE_NAME.Value;
 fmNewTrip.eAr.Text:= dm.cdsTripROUTE_AR.Value;
 fmNewTrip.ShowModal;
 if fmNewTrip.ModalResult = mrOk then
 begin
  if fmNewTrip.RadioButton2.Checked = TRUE then
   if fmNewTrip.RadioButton1.Checked = TRUE then
    s := 0
    else
    if fmNewTrip.RadioButton2.Checked = TRUE then
      s := 1
      else
      if fmNewTrip.RadioButton3.Checked = TRUE then
       s:= 2
       else
        s := 3;
  try
  if fmNewTrip.route_id <> 0 then
  id_order := fmNewTrip.route_id;
    dm.DCOMConnection1.AppServer.smAddTrip(dm.cdsTripID_TRIP.Value,id_order, s);
  except
  MessageDlg('������ ������', mtError, [mbOk],0);
  end;
  dm.cdsTrip.Refresh;
end;

end;

procedure TfmTrip.N3Click(Sender: TObject);
begin
  if MessageDlg('������� ���� ' +'' + IntToStr(dm.cdsTripID_TRIP.Value)+ '' +'?',
    mtConfirmation, [mbYes, mbNo],0) = mrYes then
 begin
  try
  dm.DCOMConnection1.AppServer.smDeleteTrip(dm.cdsTripID_TRIP.Value,
  dm.cdsTripID_ROUTE.Value);
  except
  MessageDlg('������ ��������', mtError, [mbOk],0);
  end;
  dm.cdsTrip.Refresh;

end;
end;

procedure TfmTrip.FormClose(Sender: TObject; var Action: TCloseAction);
begin
       fmNewTicket.trip_id := dm.cdsTripID_TRIP.Value;
       fmNewTicket.route_name := dm.cdsTripROUTE_NAME.Value;
       fmNewTicket.route_ar := dm.cdsTripROUTE_AR.Value;
       fmNewTicket.route_id := dm.cdsTripID_ROUTE.Value;

       fmNewTrain.trip_id := dm.cdsTripID_TRIP.Value;
       fmNewTrain.route_name := dm.cdsTripROUTE_NAME.Value;
       fmNewTrain.route_ar := dm.cdsTripROUTE_AR.Value;
       fmNewTrain.route_id := dm.cdsTripID_ROUTE.Value;

       fmTMP.trip_id :=  dm.cdsTripID_TRIP.Value;

end;

procedure TfmTrip.N4Click(Sender: TObject);
begin
 fmTrip.Close;
end;

end.
