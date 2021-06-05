module vlq
import bytereader
import io
struct Buf {
pub:
	bytes []byte
mut:
	i int
}

fn (mut b Buf) read(mut buf []byte) ?int {
	if !(b.i < b.bytes.len) {
		return none
	}
	n := copy(buf, b.bytes[b.i..])
	b.i += n
	return n
}
fn test_decode_encode_64(){

	for i := 0; i < 64; i++ {
		assert i==decode64(encode64(byte(i)))
	}
}

fn test_decode_a() {
	buf := Buf {
		bytes: 'A'.bytes()
	}

	mut input :=bytereader.ByteReader(
    *io.new_buffered_reader(reader: buf)
)

	res := decode(mut input) or {
		panic('panic')
	}
	assert res == 0
}

fn test_decode_c() {
	buf := Buf {
		bytes: 'C'.bytes()
	}

	mut input :=bytereader.ByteReader(
    *io.new_buffered_reader(reader: buf)
)

	res := decode(mut input) or {
		panic('panic')
	}
	assert res == 1
}

fn test_decode_d() {
	buf := Buf {
		bytes: 'D'.bytes()
	}

	mut input :=bytereader.ByteReader(
    *io.new_buffered_reader(reader: buf)
)

	res := decode(mut input) or {
		panic('panic')
	}
	assert res == -1
}

fn test_decode_2h() {
	buf := Buf {
		bytes: '2H'.bytes()
	}

	mut input :=bytereader.ByteReader(
    *io.new_buffered_reader(reader: buf)
)

	res := decode(mut input) or {
		panic('panic')
	}
	assert res == 123
}

fn test_decode_qxmvrh() {
	buf := Buf {
		bytes: 'qxmvrH'.bytes()
	}

	mut input :=bytereader.ByteReader(
    *io.new_buffered_reader(reader: buf)
)

	res := decode(mut input) or {
		panic('panic')
	}
	assert res == 123456789
}

// fn test_decode_max() {
// 	buf := Buf {
// 		bytes: 'zzzzzzzzzz'.bytes()
// 	}

// 	mut input :=bytereader.ByteReader(
//     *io.new_buffered_reader(reader: buf)
// )

// 	res := decode(mut input) or {
// 		panic('panic')
// 	}
// 	assert res == 123456789
// }