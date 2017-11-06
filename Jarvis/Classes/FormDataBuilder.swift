//
//  FormDataBuilder.swift
//  Pods
//
//  Created by Max Mashkov on 9/29/16.
//
//

import Foundation
import Alamofire

public protocol FormDataBuilder {

    func fillFormData(_ formData: Alamofire.MultipartFormData, for request: Request)
}

public struct DefaultFormDataBuilder: FormDataBuilder {

    public init() {

    }

    public func fillFormData(_ formData: Alamofire.MultipartFormData, for request: Request) {

        if let parameters = request.parameters {

            for (key, value) in parameters {
                formData.append(String(describing: value).data(using: .utf8, allowLossyConversion: false)!, withName: key)
            }
        }

        if let files = request.multipartData {
            for file in files {

                switch file.data {
                case .data(let data):
                    formData.append(data, withName: file.parameterName, fileName: file.fileName, mimeType: file.mimeType)
                case .url(let URL):
                    formData.append(URL, withName: file.parameterName, fileName: file.fileName, mimeType: file.mimeType)
                case .stream(let stream, let length):
                    formData.append(stream, withLength: length, name: file.parameterName, fileName: file.fileName, mimeType: file.mimeType)
                }
            }
        }
    }
}
