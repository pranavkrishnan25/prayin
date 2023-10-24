import SwiftUI
import Firebase
import FirebaseStorage

struct ImageGalleryView: View {
    @State private var imageUrls: [URL] = []

    var body: some View {
        List(imageUrls, id: \.self) { imageUrl in
            FetchableImage(url: imageUrl)
                .frame(width: 100, height: 100)
                .clipped()
        }
        .onAppear(perform: loadImages)  // Ensured this is within the body
    }

    func loadImages() {
        let storageRef = Storage.storage().reference().child("Thelyx_Data")
        
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error fetching image references: \(error)")
                return
            }
            
            // Safely unwrap the result
            guard let unwrappedResult = result else {
                print("Failed to fetch result from Firebase Storage.")
                return
            }
            
            // Using unwrappedResult.items directly
            for item in unwrappedResult.items {
                item.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }
                    
                    if let url = url {
                        DispatchQueue.main.async {  // Update UI on main thread
                            self.imageUrls.append(url)
                        }
                    }
                }
            }
        }
    }
}

struct FetchableImage: View {
    @State private var image: UIImage?
    let url: URL

    var body: some View {
        Group {  // Using Group to ensure that we always return some kind of View
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .onAppear{fetchImage()}
    }

//    func fetchImage() {
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print("Error fetching image from URL: \(error)")
//                return
//            }
//
//            if let data = data, let img = UIImage(data: data) {
//                DispatchQueue.main.async {  // Update UI on main thread
//                    self.image = img
//                }
//            }
//        }.resume()
//    }
    func fetchImage(retries: Int = 3) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = img
                }
            } else if retries > 0 {
                DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { // 1 second delay
                    self.fetchImage(retries: retries - 1)
                }
            } else {
                print("Error fetching image from URL: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

