package io.github.arskov

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotEquals

class MultiplatformServiceTest {

    @Test
    fun serviceTest() {
        val cryptoProvider = XorCryptoProvider()
        val storeProvider = InMemoryStoreProvider()
        val service =
            MultiplatformService(cryptoProvider = cryptoProvider, storeProvider = storeProvider)

        val originalData = PlainData(
            id = 1,
            encrypted = false,
            updated = 0L,
            content = "Hello World".encodeToByteArray()
        )

        val encryptionKey = "my_secret_key".encodeToByteArray()

        service.storeData(data = originalData, encryptionKey = encryptionKey)
        val retrievedData = service.loadData(id = 1L, encryptionKey = encryptionKey)

        assertEquals(originalData, retrievedData)

        val retrievedDataWithWrongKey = service.loadData(id = 1L, encryptionKey = "wrong".encodeToByteArray())
        assertNotEquals(originalData, retrievedDataWithWrongKey)
    }
}