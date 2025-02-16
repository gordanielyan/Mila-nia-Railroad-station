unit Empl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids;

type
  TfmEmpl = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    MainMenu1: TMainMenu;
    L1: TMenuItem;
    N1: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEmpl: TfmEmpl;

implementation

uses Unit2, Route, NewEmpl, NewDep_Team, NewEm_Team;

{$R *.dfm}

procedure TfmEmpl.FormActivate(Sender: TObject);

begin
DataSource1.DataSet := dm.cdsEmpl;
end;

procedure TfmEmpl.L1Click(Sender: TObject);
var k, s:integer;
begin
 fmNewEmpl.eName.Text:= '';
 fmNewEmpl.RadioButton2.Checked := FALSE;
 fmNewEmpl.RadioButton3.Checked := FALSE;
 fmNewEmpl.DateTimePicker1.DateTime:=Now;
 fmNewEmpl.DateTimePicker2.DateTime:= Now;
 fmNewEmpl.eKolChild.Text := '';
 fmNewEmpl.ShowModal;
 if fmNewEmpl.ModalResult = mrOk then
 begin
  if fmNewEmpl.RadioButton2.Checked = TRUE then
  s := 0
  else
  s := 1;
  if (fmNewEmpl.eKolChild.Text = '') then
  k:=0
  else
  k:= StrToInt(fmNewEmpl.eKolChild.Text);
  try
    dm.DCOMConnection1.AppServer.smAddEmpl(0,fmNewEmpl.eName.Text, s,   fmNewEmpl.DateTimePicker2.Date ,
    k, fmNewEmpl.DateTimePicker1.Date, fmNewEmpl.empl_id);
  except
  MessageDlg('������ ������', mtError, [mbOk],0);
  end;
  dm.cdsEmpl.Refresh;

end;
end;

procedure TfmEmpl.N1Click(Sender: TObject);
 var id_order,k, s:integer;

begin
 id_order := dm.cdsEmplID_Post.Value;
 fmNewEmpl.eName.Text:= dm.cdsEmplFIO.Value;
 if ( dm.cdsEmplSEX.Value = 0 ) then
 fmNewEmpl.RadioButton2.Checked := True
 else
 fmNewEmpl.RadioButton3.Checked := True;
 fmNewEmpl.DateTimePicker1.DateTime:=dm.cdsEmplDATA_EMPL.Value;
 fmNewEmpl.DateTimePicker2.DateTime:= dm.cdsEmplDATA.Value;
 if dm.cdsEmplCHILD.Value = 0 then
 fmNewEmpl.eKolChild.Text := ''
 else
 fmNewEmpl.eKolChild.Text :=  IntToStr(dm.cdsEmplCHILD.Value);
 fmNewEmpl.ePost.Text:= dm.cdsEmplEMPL_NAME.Value;
 fmNewEmpl.ShowModal;
 if fmNewEmpl.ModalResult = mrOk then
 begin
  if fmNewEmpl.RadioButton2.Checked = TRUE then
  s := 0
  else
  s := 1;
  if (fmNewEmpl.eKolChild.Text = '') then
  k:=0
  else
  k:= StrToInt(fmNewEmpl.eKolChild.Text);
  try
  if fmNewEmpl.empl_id <> 0 then
  id_order := fmNewEmpl.empl_id;
    dm.DCOMConnection1.AppServer.smAddEmpl(dm.cdsEmplID_EMPL.Value,fmNewEmpl.eName.Text, s,
   fmNewEmpl.DateTimePicker2.Date,  k, fmNewEmpl.DateTimePicker1.Date, id_order );
  except
  MessageDlg('������ ������', mtError, [mbOk],0);
  end;
  dm.cdsEmpl.Refresh;

end;
end;

procedure TfmEmpl.N2Click(Sender: TObject);
begin
     if MessageDlg('������� ��������� ' +'' + dm.cdsEmplFIO.Value + '' +'?',
    mtConfirmation, [mbYes, mbNo],0) = mrYes then
 begin
  try
  dm.DCOMConnection1.AppServer.smDeleteEmpl(dm.cdsEmplID_EMPL.Value);
  except
  MessageDlg('������ ��������', mtError, [mbOk],0);
  end;
  dm.cdsEmpl.Refresh;
end;
//dm.cdsPass.Refresh;
end;


procedure TfmEmpl.N3Click(Sender: TObject);
begin
  fmEmpl.Close;
end;

procedure TfmEmpl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
fmNewE_T.empl_id := dm.cdsEmplID_EMPL.Value;
 fmNewE_T.empl_name := dm.cdsEmplFIO.Value;
end;

end.
