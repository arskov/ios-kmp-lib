//
//  Conversion.swift
//  ios-kmp
//
//  Created by Arseni Kavalchuk on 17.11.24.
//
import KmpLib

extension KotlinByteArray {

    /// Converts the KotlinByteArray to a UTF-8 String
    func toString() -> String {
        let bytes = (0..<self.size).map { self.get(index: $0) }
        return String(bytes: bytes.map { UInt8($0) }, encoding: .utf8) ?? ""
    }

    /// Converts the KotlinByteArray to a hexadecimal String
    func toHexString() -> String {
        let bytes = (0..<self.size).map { self.get(index: $0) }
        return bytes.map { String(format: "%02X", UInt8($0)) }.joined()
    }
}

extension String {

    func toKotlinByteArrayLoopCopy() -> KotlinByteArray {
        let utf8Bytes = Array(self.utf8)
        let kotlinByteArray = KotlinByteArray(size: Int32(utf8Bytes.count))
        for (index, byte) in utf8Bytes.enumerated() {
            kotlinByteArray.set(
                index: Int32(index), value: Int8(bitPattern: byte))
        }
        return kotlinByteArray
    }

    func toKotlinByteArrayDataPtrReadBytes() -> KotlinByteArray {
        var data = Array(self.utf8)
        let size = Int32(data.count)
        return data.withUnsafeMutableBytes {
            ptr -> KotlinByteArray in
            let addr = ptr.baseAddress!
            return ByteArrayUtilKt.byteArrayFromPtrReadBytes(
                data: addr, size: size)
        }
    }

    func toKotlinByteArrayDataPtrMemcpy() -> KotlinByteArray {
        var data = Array(self.utf8)
        let size = Int32(data.count)
        return data.withUnsafeMutableBytes {
            ptr -> KotlinByteArray in
            let addr = ptr.baseAddress!
            return ByteArrayUtilKt.byteArrayFromPtrMemcpy(
                data: addr, size: size)
        }
    }

    func toKotlinByteArrayUtf8CStringReadBytes() -> KotlinByteArray {
        var data = self.utf8CString
        return data.withUnsafeMutableBufferPointer {
            ptr -> KotlinByteArray in
            let addr = ptr.baseAddress!
            let len = strlen(addr)
            return ByteArrayUtilKt.byteArrayFromPtrReadBytes(
                data: addr, size: Int32(len))
        }
    }

    func toKotlinByteArrayUtf8CStringMemcpy() -> KotlinByteArray {
        var data = self.utf8CString
        return data.withUnsafeMutableBufferPointer {
            ptr -> KotlinByteArray in
            let addr = ptr.baseAddress!
            let len = strlen(addr)
            return ByteArrayUtilKt.byteArrayFromPtrMemcpy(
                data: addr, size: Int32(len))
        }
    }

    func fromHexToKotlinByteArray() -> KotlinByteArray {
        // Ensure the string has an even number of characters
        guard self.count % 2 == 0 else {
            fatalError(
                "Invalid hexadecimal string. It must have an even number of characters."
            )
        }

        // Split the string into byte-sized substrings (2 characters each)
        let bytes = stride(from: 0, to: self.count, by: 2).compactMap {
            index -> UInt8? in
            let start = self.index(self.startIndex, offsetBy: index)
            let end = self.index(start, offsetBy: 2)
            let hexByte = String(self[start..<end])
            return UInt8(hexByte, radix: 16)
        }

        // Create a KotlinByteArray and populate it with the parsed bytes
        let kotlinByteArray = KotlinByteArray(size: Int32(bytes.count))
        for (index, byte) in bytes.enumerated() {
            kotlinByteArray.set(
                index: Int32(index), value: Int8(bitPattern: byte))
        }

        return kotlinByteArray

    }
}
