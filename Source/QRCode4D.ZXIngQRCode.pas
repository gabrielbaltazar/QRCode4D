unit QRCode4D.ZXIngQRCode;

interface

/////////////////////////////////////////////////////////////////
///  Gabriel Baltazar
///  Based on DelphiZXingQRCode project
///  https://github.com/foxitsoftware/DelphiZXingQRCode
////////////////////////////////////////////////////////////////

uses
  QRCode4D.Interfaces,
  DelphiZXIngQRCode,
  EncdDecd,
  System.SysUtils,
  System.Classes,
  System.Types,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Vcl.Forms, System.NetEncoding;

type TQRCode4DZXIngQRCode = class(TInterfacedObject, IQRCode4D)

  private
    FForm     : TForm;
    FPaintBox : TPaintBox;
    FQRCode   : TDelphiZXingQRCode;
    FWidth    : Integer;
    FHeight   : Integer;

    procedure CreateFormQRCode;
    function CreateBitmapBase: TBitmap;
    function CreateBitmap: TBitmap;
    procedure CreatePaintBox;

    procedure PaintBoxRepant(Sender: TObject);
  protected
    function  Bitmap: TBitmap;
    procedure SaveToFile(AFileName: String);
    procedure SaveToPicture(APicture: TPicture);
    procedure SaveToStream(AStream: TStream); overload;
    function  SaveToStream: TMemoryStream; overload;
    function  Base64: String;

  public
    constructor create(QRCode: IQRCode4DGenerator);
    class function New(QRCode: IQRCode4DGenerator): IQRCode4D;
    destructor Destroy; override;
end;

implementation

{ TQRCode4DZXIngQRCode }

function TQRCode4DZXIngQRCode.Base64: String;
var
  stream: TMemoryStream;
begin
  stream := SaveToStream;
  try
    Result := TNetEncoding.Base64.EncodeBytesToString(stream.Memory, stream.Size);
  finally
    stream.Free;
  end;
end;

function TQRCode4DZXIngQRCode.Bitmap: TBitmap;
begin
  result := CreateBitmap;
end;

constructor TQRCode4DZXIngQRCode.create(QRCode: IQRCode4DGenerator);
begin
  FQRCode           := TDelphiZXingQRCode.Create;
  FQRCode.Data      := QRCode.Data;
  FQRCode.Encoding  := QRCode.Encoding;
  FQRCode.QuietZone := QRCode.QuietZone;
  FWidth            := QRCode.Width;
  FHeight           := QRCode.Height;

  createFormQRCode;
end;

function TQRCode4DZXIngQRCode.CreateBitmap: TBitmap;
begin
  CreatePaintBox;
  try
    FPaintBox.Align := alNone;
    FForm.Width := FWidth - 35;
    result := FForm.GetFormImage;
  finally
    FForm.Width := FWidth;
    FPaintBox.Align := alClient;
  end;
end;

function TQRCode4DZXIngQRCode.CreateBitmapBase: TBitmap;
var
  row    : Integer;
  column : Integer;
begin
  result := TBitmap.Create;
  try
    result.SetSize(FQRCode.Rows, FQRCode.Columns);
    for row := 0 to Pred(FQRCode.Rows) do
    begin
      for column := 0 to Pred(FQRCode.Columns) do
      begin
        if (FQRCode.IsBlack[Row, Column]) then
          result.Canvas.Pixels[Column, Row] := clBlack
        else
          result.Canvas.Pixels[Column, Row] := clWhite;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TQRCode4DZXIngQRCode.CreateFormQRCode;
begin
  FForm             := TForm.Create(nil);
  FForm.BorderStyle := bsNone;
  FForm.Width       := FWidth;
  FForm.Height      := FHeight;
  FPaintBox         := TPaintBox.Create(FForm);
  FPaintBox.SetParentComponent(FForm);
  FPaintBox.Align := Talign.alClient;
end;

procedure TQRCode4DZXIngQRCode.CreatePaintBox;
begin
  FPaintBox.SetParentComponent(FForm);
  FPaintBox.Width := FWidth;
  FPaintBox.Height := FHeight;

  FPaintBox.OnPaint := PaintBoxRepant;
  FPaintBox.Repaint;
end;

destructor TQRCode4DZXIngQRCode.Destroy;
begin
  FQRCode.Free;
  FForm.Free;
  inherited;
end;

class function TQRCode4DZXIngQRCode.New(QRCode: IQRCode4DGenerator): IQRCode4D;
begin
  result := Self.create(QRCode);
end;

procedure TQRCode4DZXIngQRCode.PaintBoxRepant(Sender: TObject);
var
  scale: Double;
  bitmap: TBitmap;
begin
  bitmap := CreateBitmapBase;
  try
    FPaintBox := TPaintBox(Sender);
    FPaintBox.Canvas.Brush.Color := clWhite;
    FPaintBox.Canvas.FillRect(Rect(0, 0, FPaintBox.Width, FPaintBox.Height));
    if ((bitmap.Width > 0) and (bitmap.Height > 0)) then
    begin
      if (FPaintBox.Width < FPaintBox.Height) then
      begin
        Scale := FPaintBox.Width / bitmap.Width;
      end else
      begin
        Scale := FPaintBox.Height / bitmap.Height;
      end;
      FPaintBox.Canvas.StretchDraw(Rect(0, 0, Trunc(Scale * bitmap.Width), Trunc(Scale * bitmap.Height)), bitmap);
    end;
  finally
    bitmap.Free;
  end;
end;

procedure TQRCode4DZXIngQRCode.SaveToFile(AFileName: String);
var
  bitmap: TBitmap;
begin
  bitmap := CreateBitmap;
  try
    bitmap.SaveToFile(AFileName);
  finally
    bitmap.Free;
  end;
end;

procedure TQRCode4DZXIngQRCode.SaveToPicture(APicture: TPicture);
var
  stream: TStream;
begin
  if not Assigned(APicture) then
    Exit;

  stream := SaveToStream;
  try
    stream.Position := 0;
    APicture.LoadFromStream(stream);
  finally
    stream.Free;
  end;
end;

function TQRCode4DZXIngQRCode.SaveToStream: TMemoryStream;
begin
  result := TMemoryStream.Create;
  try
    SaveToStream(result);
  except
    Result.Free;
    raise;
  end;
end;

procedure TQRCode4DZXIngQRCode.SaveToStream(AStream: TStream);
var
  bitmap: TBitmap;
begin
  bitmap := CreateBitmap;
  try
    bitmap.SaveToStream(AStream);
  finally
    bitmap.Free;
  end;
end;

end.
