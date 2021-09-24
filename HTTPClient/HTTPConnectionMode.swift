//
//  HTTPConnectionMode.swift
//  HTTPClient
//
//  Created by Ernest Babayan on 25.09.2021.
//

public enum HTTPConnectionMode {
    case inMemory

    case toFile(URL)

    public enum UploadingObject {
        case data(Data)
        case file(URL)
    }

    case upload(UploadingObject)
}
