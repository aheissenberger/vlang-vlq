module bytereader

import io

pub type ByteReader = io.BufferedReader

pub fn (mut br ByteReader) next() ?byte {
    mut buf := []byte{len: 1}
    if br.read(mut buf)? == 0 {
        return none
    }
    return buf[0]
}