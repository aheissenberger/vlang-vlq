module vlq

fn test_decode_encode_64() {
	for i := 0; i < 64; i++ {
		assert decode64(encode64(byte(i))) == i
	}
}
