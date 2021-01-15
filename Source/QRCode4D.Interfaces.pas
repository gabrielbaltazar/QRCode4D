unit QRCode4D.Interfaces;

interface

/////////////////////////////////////////////////////////////////
///  Gabriel Baltazar
///  Based on DelphiZXingQRCode project
///  https://github.com/foxitsoftware/DelphiZXingQRCode
////////////////////////////////////////////////////////////////

uses
  DelphiZXIngQRCode,
  System.Classes,
  Vcl.Graphics;

type
  TQRCodeEncoding = DelphiZXIngQRCode.TQRCodeEncoding;

  IQRCode4D = interface;

  IQRCode4DGenerator = interface
    ['{1106CA50-86E5-405D-B71B-B294484B6B2B}']
    function Clear: IQRCode4DGenerator;
    function AddData(Value: String): IQRCode4DGenerator; overload;
    function AddData(Value: string; const Args: array of const): IQRCode4DGenerator; overload;
    function Encoding(Value: TQRCodeEncoding): IQRCode4DGenerator; overload;
    function QuietZone(Value: Integer): IQRCode4DGenerator; overload;
    function Width(Value: Integer): IQRCode4DGenerator; overload;
    function Height(Value: Integer): IQRCode4DGenerator; overload;

    function Encoding: TQRCodeEncoding; overload;
    function QuietZone: Integer; overload;
    function Width: Integer; overload;
    function Height: Integer; overload;
    function Data: WideString; overload;

    function GenerateQRCode: IQRCode4D;
  end;

  IQRCode4D = interface
    ['{EEEC87A1-7CC7-4303-9339-AA93060B80D0}']
    function  Bitmap: TBitmap;
    procedure SaveToFile(AFileName: String);
    procedure SaveToPicture(APicture: TPicture);
    procedure SaveToStream(AStream: TStream); overload;
    function  SaveToStream: TMemoryStream; overload;
    function  Base64: String;
  end;

function QRCodeGenerator: IQRCode4DGenerator;

implementation

uses
  QRCode4D.Generator.Base;

function QRCodeGenerator: IQRCode4DGenerator;
begin
  result := TQRCode4DGeneratorBase.New;
end;

end.
