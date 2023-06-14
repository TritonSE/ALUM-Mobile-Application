//
//  EditProfileImage.swift
//  ALUM
//
//  Created by Philip Zhang on 5/21/23.
//

import SwiftUI

struct EditProfileImage: View {
    @Binding var imageId: String
    @State var loading = false
    @State private var showChooseSheet = false
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack {
            HStack {
                Text("Profile Picture")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color("ALUM Dark Blue"))
                Spacer()
                Button(action: {
                    showChooseSheet = true
                }, label: {
                    Text("Edit")
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Dark Blue"))
                })
                .sheet(isPresented: $showChooseSheet) {
                    if #available(iOS 16.0, *) {
                        choosePictureSheet
                            .presentationDetents([.fraction(0.4)])
                    } else {
                        choosePictureSheet
                    }
                }
            }
            .padding(.top, 25)
            .padding(.leading, 16)
            .padding(.trailing, 16)

            profilePicture
        }.onAppear(perform: {
            Task {
                /// Get user's current image
                do {
                    loading = true
                    image = try await ImageService.shared.getImage(imageId: imageId)
                    loading = false
                } catch {
                    CurrentUserModel.shared.showInternalError.toggle()
                }
            }
        })
    }

    var profilePicture: some View {
        HStack {
            if loading {
                ProgressView()
                    .frame(width: 112, height: 112)
            } else if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: 112, height: 112)
                    .clipShape(Circle())
            } else {
                Image("DefaultProfileImage")
            }
        }
        .padding(20)
    }

    func handleDone() {
        Task {
            guard let selectedImage = image else { return }
            do {
                /// Upload image
                loading = true
                imageId = try await ImageService.shared.createImage(image: selectedImage)
                loading = false
            } catch {
                CurrentUserModel.shared.showInternalError.toggle()
            }
            showChooseSheet = false
        }
    }

    var choosePictureSheet: some View {
        VStack {
            HStack {
                Button(action: {showChooseSheet = false}, label: {
                    Text("Cancel")
                        .font(.custom("Metropolis-Regular", size: 13))
                        .foregroundColor(Color("ALUM Dark Blue"))
                })
                Text("Profile Picture")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color.black)
                Button(action: handleDone, label: {
                    Text("Done")
                        .font(.custom("Metropolis-Regular", size: 13))
                        .foregroundColor(Color("ALUM Dark Blue"))
                })
            }

            profilePicture

            Button(action: {
                sourceType = .photoLibrary
                showImagePicker = true
            }, label: {
                Image("LibraryIcon")
                Text("Choose from library")
                    .font(.custom("Metropolis-Regular", size: 17))
                    .foregroundColor(Color.black)
                Spacer()
            })

            Button(action: {
                sourceType = .camera
                showImagePicker = true
            }, label: {
                HStack {
                    Image("CameraIcon")
                    Text("Take photo")
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color.black)
                    Spacer()
                }
            })
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, sourceType: $sourceType)
            }

            Button(action: {
                image = nil
            }, label: {
                HStack {
                    Image("TrashIcon")
                    Text("Remove current profile picture")
                        .font(.custom("Metropolis-Regular", size: 17))
                        .foregroundColor(Color("ALUM Alert Red"))
                    Spacer()
                }
            })

            Spacer()
        }
        .padding(16)
        .padding(.top, 20)
    }
}

// Image Library/Camera code credit to:
// https://medium.com/swlh/how-to-open-the-camera-and-photo-library-in-swiftui-9693f9d4586b

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePicker

    init(picker: ImagePicker) {
        self.picker = picker
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.image = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    @Environment(\.presentationMode) var isPresented
    @Binding var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

struct EditProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        @State var imageId = "640b86513c48ef1b07904241"

        return EditProfileImage(imageId: $imageId)
    }
}
