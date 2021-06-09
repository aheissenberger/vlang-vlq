module vlq

import io

struct TestReader {
pub:
	bytes []byte
mut:
	i int
}

struct TestWriter {
pub mut:
	bytes []byte
}

fn test_max() ? {
	for i in 0 .. 1000 {
		expected_input := i * 100_000_000
		// print('$expected_input, ')
		mut output := TestWriter{}

		encode(expected_input, mut &output) ?

		mut input := make_test_reader(output.bytes)

		res := decode(mut &input) or { panic('panic') }
		assert res == expected_input
	}
}

fn (mut w TestWriter) write(buf []byte) ?int {
	w.bytes << buf
	return buf.len
}

fn (mut b TestReader) read(mut buf []byte) ?int {
	if !(b.i < b.bytes.len) {
		return none
	}
	n := copy(buf, b.bytes[b.i..])
	b.i += n
	return n
}

fn make_test_reader(data []byte) io.Reader {
	buf := TestReader{
		bytes: data
	}

	return io.new_buffered_reader(reader: buf)
}
