# module vlq

# vlq

Encode and decode the Base64-encoded [VLQ](https://en.wikipedia.org/wiki/Variable-length_quantity) encoding. Note that there are several variants of VLQ. This only implements the variant used by [source maps](https://github.com/mozilla/source-map).

## Installation


```sh
v install aheissenberger.vlq
```

## Usage

### Encoding

The methode expects a signed integer and will create a VLQ and write the base64 encoded data to the provide IO stream.

```v
data = 123
encode(data,output) // '2H'
```
### Decoding

Decode a single VLQ value from the input stream, returning the value.

```v
/* input IO stream: '2H' */
res := decode(input) or { panic('panic') } 
println(res) // 123
```

## API Documentation

[auto generated documentation](https://github.com/aheissenberger/vlang-vlq/blob/main/_docs/vlq.md#contents)
(created `v doc -f md -m . -o .`)

### Roadmap

 - [ ] additional tests
 - [ ] performance benchmark

### Contribution

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are greatly appreciated.

1. Fork the Project
1. Create your Feature Branch (git checkout -b feature/AmazingFeature)
1. Commit your Changes (git commit -m 'Add some AmazingFeature')
1. Push to the Branch (git push origin feature/AmazingFeature)
1. Open a Pull Request

### License

Distributed under the "bsd-2-clause" License. See [LICENSE.txt](LICENSE.txt) for more information.
 

## Contents
- [decode](#decode)
- [encode](#encode)

## decode
```v
fn decode(mut input io.Reader) ?i64
```
 Decode a single VLQ value from the input stream, returning the value.   # Range   Supports all numbers that can be represented by a sign bit and a 63 bit  absolute value: `[-(2^63 - 1), 2^63 - 1]`.   Note that `i64::MIN = -(2^63)` cannot be represented in that form, and this  NOT IMPLEMENTED: function will return `Error::Overflowed` when attempting to decode it. 

[[Return to contents]](#Contents)

## encode
```v
fn encode(value i64, mut output io.Writer) ?
```
 Encode a value as Base64 VLQ, sending it to the writer 

[[Return to contents]](#Contents)

#### Powered by vdoc. Generated on: 9 Jun 2021 12:58:53
