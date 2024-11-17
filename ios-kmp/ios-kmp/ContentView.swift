//
//  ContentView.swift
//  ios-kmp
//
//  Created by Arseni Kavalchuk on 17.11.24.
//

import KmpLib
import SwiftUI

struct ContentView: View {
    @State private var encryptionKey = ""
    @State private var plainDataText = ""
    @State private var encryptedDataText = ""
    @State private var loadedDataText = ""

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            Text("Encryption key").font(.title3)
            TextField("Enter key", text: $encryptionKey)
                .textInputAutocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Text to store").font(.title3)
            TextField("Enter text", text: $plainDataText)
                .textInputAutocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                let service = ServiceLocator.sharedInstance
                    .getMultiplatformService()
                let store = ServiceLocator.sharedInstance.getStoreProvider()
                let plainData = PlainData(
                    id: 1,
                    encrypted: false,
                    updated: 0,
                    content: self.plainDataText.toKotlinByteArrayUtf8CStringMemcpy()
                )
                do {
                    try service.storeData(
                        data: plainData,
                        encryptionKey: encryptionKey.toKotlinByteArrayUtf8CStringMemcpy())
                    let storedData = try store.load(id: 1)
                    self.encryptedDataText = storedData.content.toHexString()

                } catch {
                    print("error: \(error)")
                }
            }) {
                Text("Store Data")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Divider()
            Text("Encrypted text").font(.title3)
            TextField("", text: $encryptedDataText)
                .textInputAutocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Divider()
            Button(action: {
                let service = ServiceLocator.sharedInstance
                    .getMultiplatformService()
                do {
                    let loadedData = try service.loadData(
                        id: 1, encryptionKey: encryptionKey.toKotlinByteArrayUtf8CStringMemcpy())
                    self.loadedDataText = loadedData.content.toString()
                } catch {
                    print("error: \(error)")
                }
            }) {
                Text("Load Data")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Text("Loaded text").font(.title3)
            TextField("", text: $loadedDataText)
                .textInputAutocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Divider()
        }.padding().frame(
            maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ContentView()
}
