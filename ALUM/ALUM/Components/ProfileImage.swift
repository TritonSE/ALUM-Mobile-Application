//
//  ProfileImage.swift
//  ALUM
//
//  Created by Philip Zhang on 6/13/23.
//

import SwiftUI

struct ProfileImage: View {
    let imageId: String
    let size: CGFloat
    @State var loading = false
    @State var image: UIImage?

    var body: some View {
        Group {
            if loading {
                ProgressView()
                    .frame(width: size, height: size)
            } else {
                (
                    image != nil ? Image(uiImage: image!) : Image("DefaultProfileImage")
                )
                .resizable()
                .clipShape(Circle())
                .frame(width: size, height: size)
            }
        }.onAppear(perform: {
            Task {
                do {
                    loading = true
                    image = try await ImageService.shared.getImage(imageId: imageId)
                    loading = false
                } catch {
                    /// User has no image
                    loading = false
                }
            }
        })
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        @State var imageId = "64893922bc50c5db8870cc59"

        return ProfileImage(imageId: imageId, size: 100)
    }
}
