import SwiftUI

struct FullScreenImageView: View {
    let imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .background(Color.black)
        }
    }
}
