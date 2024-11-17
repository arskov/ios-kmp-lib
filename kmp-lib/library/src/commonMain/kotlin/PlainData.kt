package io.github.arskov

class PlainData(val id: Long, val encrypted: Boolean, val updated: Long, val content: ByteArray) {

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as PlainData

        if (id != other.id) return false
        if (encrypted != other.encrypted) return false
        if (!content.contentEquals(other.content)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = id.hashCode()
        result = 31 * result + encrypted.hashCode()
        result = 31 * result + content.contentHashCode()
        return result
    }

}