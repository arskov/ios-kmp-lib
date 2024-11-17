package io.github.arskov

class StoreException(override val message: String, override val cause: Throwable? = null) :
    Exception(message, cause)