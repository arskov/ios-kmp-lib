package io.github.arskov

class InMemoryStorageProvider : StoreProvider {
    private val internalStore = mutableMapOf<Long, PlainData>()

    @Throws(StoreException::class)
    override fun store(data: PlainData) {
        internalStore[data.id] = data
    }

    @Throws(StoreException::class)
    override fun load(id: Long): PlainData {
        return internalStore[id] ?: throw StoreException("Not Found")
    }

}