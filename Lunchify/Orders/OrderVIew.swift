import SwiftUI
import OSLog

struct OrderView: View{
    var uiElements: UIElements = UIElements()

    var body: some View {
        VStack {
            uiElements.label(text: "UNDER CONSTRUCTION", iconName: "lock.trianglebadge.exclamationmark.fill", size: 40)
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
