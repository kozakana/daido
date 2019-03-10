# daido
This application makes grayscale PDF file which is excepted the first page and the last page.
([Daido Moriyama](https://en.wikipedia.org/wiki/Daid%C5%8D_Moriyama) is a wonderful photographer who takes pictures of color and monochrome.)

* The recommended usage is E-book of PDF.
* Reduce file size to about 37%
* Daido can convert while maintaining OCR character information.

## Usage
### Prepare
Put the PDF files in `pdf/input`.
```
docker pull gkmr/daido
```

### Execute
```
docker run -v $PWD/pdf:/pdf gkmr/daido
```

### Output
The converted file is output to `pdf/output`.

## Build
```
docker build . -t daido
```
