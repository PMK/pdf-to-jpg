# Convert PDF documents to JPG files

## Dependencies

- [ImageMagick](https://github.com/ImageMagick/ImageMagick) >= 7
- GhostScript >= 9
- awk
- xargs

## Usage

```
$ ./pdf-to-jpg.sh file.pdf
```

```
$ for doc in file-1.pdf file-2.pdf file-3.pdf; do ./pdf-to-jpg.sh $doc; done
```

### Show help

```
$ ./pdf-to-jpg.sh --help
```

### Show version

```
$ ./pdf-to-jpg.sh --version
```
