# Docker Unoserver

A file format conversion service based on Unoserver.


## How to use

```
docker pull chanmo/unoserver
```

Start http server
```
docker run -p 5000:5000 chanmo/unoserver
```

convert a docx file to the pdf format
```
http -f POST :5000/convert/pdf file@/path/to/demo.docx -o demo.pdf
```

If you just want to refresh the TOC in a docx file.
```
http -f POST :5000/convert/docx file@/path/to/demo.docx -o demo.docx
```
