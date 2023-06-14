//
//  ImageService.swift
//  ALUM
//
//  Created by Philip Zhang on 6/13/23.
//

import Foundation
import SwiftUI

class ImageService {
    static let shared = ImageService()

    func getImage(imageId: String) async throws -> UIImage {
        let route = APIRoute.getImage(imageId: imageId)
        let request = try await route.createURLRequest()
        let responseData = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)

        guard let image = UIImage(data: responseData) else {
            DispatchQueue.main.async {
                CurrentUserModel.shared.showInternalError.toggle()
            }
            throw AppError.internalError(.unknownError, message: "Error creating image")
        }

        return image
    }

    func createImage(image: UIImage) async throws {
        let route = APIRoute.postImage
        var request = try await route.createURLRequest()

        var multipart = MultipartRequest()

        multipart.add(
            key: "image",
            fileName: "upload.jpg",
            fileMimeType: "image/png",
            fileData: image.jpegData(compressionQuality: 0.8)!
        )

        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody

        _ = try await ServiceHelper.shared.sendRequestWithSafety(route: route, request: request)
        print("SUCCESS - \(route.label)")
    }
}
