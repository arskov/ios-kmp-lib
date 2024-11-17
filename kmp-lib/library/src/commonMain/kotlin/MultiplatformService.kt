package io.github.arskov

class MultiplatformService(
    private val cryptoProvider: CryptoProvider,
    private val storeProvider: StoreProvider
) {

    @Throws(StoreException::class, EncryptionException::class)
    fun storeData(data: PlainData, encryptionKey: ByteArray?) {
        if (!data.encrypted && encryptionKey != null) {
            val encryptedData =
                cryptoProvider.encrypt(op = EncryptOp.ENCRYPT, key = encryptionKey, data = data.content)
            val encryptedPlainData =
                PlainData(id = data.id, encrypted = true, updated = 0L, content = encryptedData)
            storeProvider.store(encryptedPlainData)
        } else {
            storeProvider.store(data)
        }
    }

    @Throws(StoreException::class, EncryptionException::class)
    fun loadData(id: Long, encryptionKey: ByteArray?): PlainData {
        val data = storeProvider.load(id)
        if (data.encrypted && encryptionKey != null) {
            val decryptedData = cryptoProvider.encrypt(op = EncryptOp.DECRYPT, key = encryptionKey, data = data.content)
            return PlainData(id = data.id, encrypted = false, updated = 0L, content = decryptedData)
        }
        return data
    }
}