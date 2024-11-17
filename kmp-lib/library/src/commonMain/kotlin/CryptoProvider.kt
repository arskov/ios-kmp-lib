package io.github.arskov

interface CryptoProvider {
    /**
     * The method serves both encrypt and decrypt options depending on the EncryptOp
     */
    @Throws(EncryptionException::class)
    fun encrypt(op: EncryptOp, key: ByteArray, data: ByteArray): ByteArray
}

enum class EncryptOp {
    ENCRYPT, DECRYPT
}
