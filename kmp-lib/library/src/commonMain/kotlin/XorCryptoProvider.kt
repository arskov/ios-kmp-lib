package io.github.arskov

class XorCryptoProvider : CryptoProvider {
    override fun encrypt(op: EncryptOp, key: ByteArray, data: ByteArray): ByteArray {
        // Ensure the key is not empty
        require(key.isNotEmpty()) { "Key must not be empty" }
        // Create a result array of the same size as the data
        val result = ByteArray(data.size)
        // XOR each byte of the data with the corresponding byte in the key
        for (i in data.indices) {
            result[i] = (data[i].toInt() xor key[i % key.size].toInt()).toByte()
        }
        return result
    }
}