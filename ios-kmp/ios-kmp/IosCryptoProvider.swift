//
//  IosCryptoProvider.swift
//  ios-kmp
//
//  Created by Arseni Kavalchuk on 17.11.24.
//

import KmpLib

class IosCryptoProvider: CryptoProvider {
    func encrypt(op: EncryptOp, key: KotlinByteArray, data: KotlinByteArray)
        throws -> KotlinByteArray
    {
        // Ensure the key is not empty
        guard key.size > 0 else {
            throw NSError(
                domain: "CryptoError", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Key must not be empty"])
        }
        // Create a result array of the same size as the data
        let result = KotlinByteArray(size: data.size)
        // Perform XOR encryption
        for i in 0..<data.size {
            let dataByte = data.get(index: i)
            let keyByte = key.get(index: i % key.size)
            result.set(index: i, value: dataByte ^ keyByte)
        }
        return result
    }

}
