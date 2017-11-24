unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, Vcl.StdCtrls,
  FireDAC.VCLUI.Login, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.UI,
  FireDAC.VCLUI.Wait, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Vcl.DBCtrls,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Vcl.ComCtrls,
  Vcl.DBCGrids, Data.Bind.Controls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Bind.Navigator;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Button1: TButton;
    Label1: TLabel;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDUpdateSQL1: TFDUpdateSQL;
    DataSource1: TDataSource;
    BindSourceDB1: TBindSourceDB;
    TreeView1: TTreeView;
    BindingsList1: TBindingsList;
    LinkFillControlToField: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    ListView1: TListView;
    FDQuery2: TFDQuery;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    LinkPropertyToFieldCaption2: TLinkPropertyToField;
    StringGrid1: TStringGrid;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    BindNavigator1: TBindNavigator;
    Timer1: TTimer;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
     ultcambio:TDateTime;
     procedure RefrescarDataSet;
     function EstadoInsertEdit:boolean;
    { Public declarations }
  end;

var
Form1:TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
FDConnection1.Connected:=true;
end;

procedure TForm1.FDConnection1AfterConnect(Sender: TObject);
begin
label1.caption:='conectado';
end;

procedure TForm1.FormCreate(Sender: TObject);
var qry: TFDQuery;
begin
     qry:=TFDQuery.Create(Application);
     qry.Connection:=FDConnection1;
     qry.SQL.Clear;
     qry.SQL.Add('Select Max(fechahora) from cambios');
     qry.Open;
     //qry.ExecSQL;
     ultcambio:=qry.Fields[0].AsDateTime;
     qry.Close;
     qry.Destroy;
     label2.Caption:=DateToStr(ultcambio);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var qry: TFDQuery;   cambios:boolean;
begin
     qry:=TFDQuery.Create(Application);
     qry.Connection:=FDConnection1;
     qry.SQL.Clear;
     qry.SQL.Add('Select tabla,fechahora from cambios where fechahora > :ultcambio');
     qry.Params.ParamByName('ultcambio').AsDateTime:=ultcambio;
     qry.Params.ParamByName('ultcambio').ParamType:=ptInput;
     qry.Params.ParamByName('ultcambio').DataType:=ftDateTime;
     qry.Params.ParamByName('ultcambio').asDateTime:=ultcambio;
     qry.Open;
     cambios:=(qry.RecordCount > 0);
     if cambios then ultcambio:=qry.Fields[1].AsDateTime;
     qry.Close;
     qry.destroy;
     if cambios then
     begin
          timer1.enabled:=false;
          RefrescarDataSet;
     end;



end;

function TForm1.EstadoInsertEdit:boolean;
var i:integer; enestado:boolean;
begin
     i:=0;
     enestado:=false;
     while (i < FDConnection1.DataSetCount) and (not enestado) do
     begin
          if (FDConnection1.DataSets[i].State in [dsInsert,dsEdit]) then
          enestado:=true;
          i:=i+1;
     end;
     Result:=enestado;

end;

procedure TForm1.RefrescarDataSet;
var i: integer;
begin
     try
     i:=0;
     if not EstadoInsertEdit then
        while (i < FDConnection1.DataSetCount) do
         begin
          //if not (FDConnection1.DataSets[i].State in [dsInsert,dsEdit]) then
          FDConnection1.DataSets[i].Refresh;

          i:=i+1;
         end;

     finally
     timer1.Enabled:=true;
     end;
end;

end.
