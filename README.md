# QRCode4D
Generator QRCode in Delphi
Based in DelphiZXingQRCode project https://github.com/foxitsoftware/DelphiZXingQRCode

#### Add Uses
```delphi
uses
  QRCode4D.Interfaces;
```

#### Generate QRCode and save to file
```delphi
var
  qrCode: IQRCode4DGenerator;
begin
  qrCode := QRCodeGenerator;
  qrCode
    .AddData('https://github.com/gabrielbaltazar')
    .GenerateQRCode
    .SaveToFile('qrcode.bmp');
end;
```

#### Generate QRCode and return base64 
```delphi
var
  qrCode: IQRCode4DGenerator;
  content: String;
begin
  qrCode := QRCodeGenerator;
  content := qrCode
              .AddData('https://github.com/gabrielbaltazar')
              .GenerateQRCode
              .Base64;
end;
```
#### Generate QRCode and return TBitmap 
```delphi
var
  qrCode: IQRCode4DGenerator;
  bmp: TBitmap;
begin
  qrCode := QRCodeGenerator;
  bmp := qrCode
          .AddData('https://github.com/gabrielbaltazar')
          .GenerateQRCode
          .Bitmap;
  try
    // ...
  finally
    bmp.Free;
  end;
end;
```

#### Generate QRCode and save in TImage
```delphi
var
  qrCode: IQRCode4DGenerator;
begin
  qrCode := QRCodeGenerator;
  qrCode
    .AddData('https://github.com/gabrielbaltazar')
    .GenerateQRCode
    .SaveToPicture(imgForm.Picture);
end;
```
