//
//  ProfileImage.swift
//  ALUM
//
//  Created by Philip Zhang on 6/13/23.
//

import SwiftUI

struct ProfileImage: View {
    @State var loading = false
    @Binding var imageId: String?
    @Binding var image: UIImage?
    var size: CGFloat

    init(image: Binding<UIImage?> = .constant(nil), imageId: Binding<String?> = .constant(nil), size: CGFloat = 100) {
        _image = image
        _imageId = imageId
        self.size = size
    }

    var body: some View {
        Group {
            if loading {
                ProgressView()
                    .frame(width: size, height: size)
            } else if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                Image("DefaultProfileImage")
            }
        }.onAppear(perform: {
            Task {
                if imageId != nil {
                    do {
                        loading = true
                        image = try await ImageService.shared.getImage(imageId: imageId!)
                        loading = false
                    } catch {
                        CurrentUserModel.shared.showInternalError.toggle()
                    }
                }
            }
        })
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        @State var imageId: String? = "64893922bc50c5db8870cc59"

        return ProfileImage(imageId: $imageId, size: 100)
    }
}
