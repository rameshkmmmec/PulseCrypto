//
//  Bundle+Extensions.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type,
                              from filename: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        
        // 1. File path dhundhna
        guard let url = self.url(forResource: filename, withExtension: nil) else {
            throw JSONParseError.fileNotFound(filename)
        }

        // 2. Data load karna
        guard let data = try? Data(contentsOf: url) else {
            throw JSONParseError.dataCorrupted(filename)
        }

        // 3. Decoder configure aur decode karna
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw JSONParseError.decodingFailed(error)
        }
    }
}


// Custom error handling ke liye
enum JSONParseError: LocalizedError {
    case fileNotFound(String)
    case dataCorrupted(String)
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let file):
            return "File nahi mili: \(file)"
        case .dataCorrupted(let file):
            return "\(file) se data read nahi ho paya."
        case .decodingFailed(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
}
