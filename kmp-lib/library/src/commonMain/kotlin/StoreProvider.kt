package io.github.arskov

interface StoreProvider {

    @Throws(StoreException::class)
    fun store(data: PlainData)

    @Throws(StoreException::class)
    fun load(id: Long): PlainData

}