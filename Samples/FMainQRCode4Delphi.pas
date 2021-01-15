unit FMainQRCode4Delphi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    imgQrCode: TImage;
    mmoBase64: TMemo;
    edtText: TEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  QRCode4D.Interfaces;

procedure TForm1.FormCreate(Sender: TObject);
var
  generator: IQRCode4DGenerator;
  qrCode: IQRCode4D;
begin
  ReportMemoryLeaksOnShutdown := True;
  generator := QRCodeGenerator;
  qrCode := generator
              .AddData(edtText.Text)
              .GenerateQRCode;

  qrCode.SaveToPicture(imgQrCode.Picture);
  mmoBase64.Lines.Text := qrCode.Base64;
//  qrCode.SaveToFile('qrcode4d.bmp');
end;

end.
