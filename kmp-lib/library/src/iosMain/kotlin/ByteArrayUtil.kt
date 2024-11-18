package io.github.arskov

import kotlinx.cinterop.ByteVar
import kotlinx.cinterop.CPointer
import kotlinx.cinterop.ExperimentalForeignApi
import kotlinx.cinterop.addressOf
import kotlinx.cinterop.pin
import kotlinx.cinterop.readBytes
import kotlinx.cinterop.usePinned
import platform.posix.memcpy

@OptIn(ExperimentalForeignApi::class)
fun byteArrayFromPtrReadBytes(data: CPointer<ByteVar>, size: Int): ByteArray =
    data.readBytes(size)

@OptIn(ExperimentalForeignApi::class)
fun byteArrayFromPtrMemcpy(data: CPointer<ByteVar>, size: Int): ByteArray {
    return ByteArray(size).also {
        it.usePinned { pinned ->
            memcpy(pinned.addressOf(0), data, size.toULong())
        }
    }
}

@OptIn(ExperimentalForeignApi::class)
fun ByteArray.bytesPtr(byteArray: ByteArray): CPointer<ByteVar> =
    byteArray.pin().addressOf(0)

