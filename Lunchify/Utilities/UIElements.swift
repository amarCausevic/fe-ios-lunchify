import SwiftUI

final class UIElements {
    func profileImage(imgUrl: String, size: CGFloat) -> some View {
        return Image(imgUrl)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .background(Color.clear)
    }
    
    func text(text: String) -> some View {
        return Text(text)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func label(text: String, iconName: String, size: CGFloat = 20) -> some View {
        return Label(text, systemImage: iconName).foregroundStyle(.black).labelStyle(.titleAndIcon).font(.system(size: size))
    }
    
}
