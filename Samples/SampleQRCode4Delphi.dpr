program SampleQRCode4Delphi;

uses
  Vcl.Forms,
  FMainQRCode4Delphi in 'FMainQRCode4Delphi.pas' {Form1},
  DelphiZXIngQRCode in '..\Source\DelphiZXIngQRCode.pas',
  QRCode4D.Interfaces in '..\Source\QRCode4D.Interfaces.pas',
  QRCode4D.Generator.Base in '..\Source\QRCode4D.Generator.Base.pas',
  QRCode4D.ZXIngQRCode in '..\Source\QRCode4D.ZXIngQRCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
