package io.github.arskov

class EncryptionException(override val message: String, override val cause: Throwable? = null) :
    Exception(message, cause)