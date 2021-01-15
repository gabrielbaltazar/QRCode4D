unit QRCode4D.Generator.Base;

interface

uses
  QRCode4D.Interfaces,
  System.SysUtils,
  System.Classes;

type TQRCode4DGeneratorBase = class(TInterfacedObject, IQRCode4DGenerator)

  private
    FData: WideString;
    FEncoding: TQRCodeEncoding;
    FSeparator: string;
    FQuietZone: Integer;
    FWidth: Integer;
    FHeight: Integer;

  protected
    function Clear: IQRCode4DGenerator;
    function AddData(Value: String): IQRCode4DGenerator; overload;
    function AddData(Value: string; const Args: array of const): IQRCode4DGenerator; overload;
    function Encoding(Value: TQRCodeEncoding): IQRCode4DGenerator; overload;
    function QuietZone(Value: Integer): IQRCode4DGenerator; overload;
    function Separator(Value: String): IQRCode4DGenerator;
    function Width(Value: Integer): IQRCode4DGenerator; overload;
    function Height(Value: Integer): IQRCode4DGenerator; overload;

    function Encoding: TQRCodeEncoding; overload;
    function QuietZone: Integer; overload;
    function Width: Integer; overload;
    function Height: Integer; overload;
    function Data: WideString; overload;

    function GenerateQRCode: IQRCode4D;
  public
    constructor create;
    class function New: IQRCode4DGenerator;
    destructor Destroy; override;
end;

implementation

uses
  QRCode4D.ZXIngQRCode;

{ TQRCode4DGeneratorBase }

function TQRCode4DGeneratorBase.AddData(Value: String): IQRCode4DGenerator;
begin
  result := Self;
  if FData <> EmptyStr then
    FData := FData + FSeparator;
  FData := FData + Value;
end;

function TQRCode4DGeneratorBase.AddData(Value: string; const Args: array of const): IQRCode4DGenerator;
begin
  result := Self;
  AddData(Format(Value, Args));
end;

function TQRCode4DGeneratorBase.Clear: IQRCode4DGenerator;
begin
  result := Self;
  FData  := EmptyStr;
end;

constructor TQRCode4DGeneratorBase.create;
begin
  FSeparator := ';';
  FEncoding  := TQRCodeEncoding.qrAuto;
  FQuietZone := 4;
  FWidth     := 230;
  FHeight    := 190;
end;

function TQRCode4DGeneratorBase.Data: WideString;
begin
  Result := FData;
end;

destructor TQRCode4DGeneratorBase.Destroy;
begin
  inherited;
end;

function TQRCode4DGeneratorBase.Encoding: TQRCodeEncoding;
begin
  result := FEncoding;
end;

function TQRCode4DGeneratorBase.Encoding(Value: TQRCodeEncoding): IQRCode4DGenerator;
begin
  result := Self;
  FEncoding := Value;
end;

function TQRCode4DGeneratorBase.GenerateQRCode: IQRCode4D;
begin
  result := TQRCode4DZXIngQRCode.New(Self);
  Clear;
end;

function TQRCode4DGeneratorBase.Height: Integer;
begin
  result := FHeight;
end;

function TQRCode4DGeneratorBase.Height(Value: Integer): IQRCode4DGenerator;
begin
  result := Self;
  FHeight := Value;
end;

class function TQRCode4DGeneratorBase.New: IQRCode4DGenerator;
begin
  result := Self.create;
end;

function TQRCode4DGeneratorBase.QuietZone: Integer;
begin
  result := FQuietZone;
end;

function TQRCode4DGeneratorBase.QuietZone(Value: Integer): IQRCode4DGenerator;
begin
  result := Self;
  FQuietZone := Value;
end;

function TQRCode4DGeneratorBase.Separator(Value: String): IQRCode4DGenerator;
begin
  result := Self;
  Clear;
  FSeparator := Value;
end;

function TQRCode4DGeneratorBase.Width: Integer;
begin
  result := FWidth;
end;

function TQRCode4DGeneratorBase.Width(Value: Integer): IQRCode4DGenerator;
begin
  result := Self;
  FWidth := Value;
end;

end.
