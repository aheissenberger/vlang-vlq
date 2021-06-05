module vlq
//import bytereader
import io
struct Buf {
pub:
	bytes []byte
mut:
	i int
}

struct TestData {
	decode_val string
	expected i64
}

type TestDataList = []TestData

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

	decode_values := [
		TestData{ 'A',0},
		TestData{ 'C',1},
		TestData{ 'D',-1},
		TestData{ '2H',123},
		TestData{ 'qxmvrH',123456789},
	]

	for _, test_data in decode_values {
		
	
	mut input := make_test_reader(test_data.decode_val)

	res := decode(mut &input) or {
		panic('panic')
	}
	assert res == test_data.expected
	}
}

fn make_test_reader(data string) io.Reader {
	buf := Buf {
		bytes: data.bytes()
	}

	return  io.new_buffered_reader(reader: buf)
}