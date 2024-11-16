import SwiftUI

struct Theme {
  static let primaryDarkColor = makeColor(r: 48, g: 13, b: 56)
  
  private static func makeColor(r: Int, g: Int, b: Int) -> Color {
    return Color(red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255)
  }
}

struct TertiaryCTA: View {
  var title: String
  var buttonAction: VoidCompletion?
  
  init(title: String, action: VoidCompletion?) {
    self.title = title
    self.buttonAction = action
  }
  
  var body: some View {
    Button {
      buttonAction?()
    } label: {
      buttonLabel()
    }
    .frame(alignment: .trailing)
  }
  
  @ViewBuilder
  private func buttonLabel() -> some View {
    Text(title)
      .font(Font.system(size: 16.0, weight: .medium))
      .foregroundStyle(Theme.primaryDarkColor)
  }
  
}

//Reused/adapted from personal project
struct PrimaryCTA: View {
  var title: String
  var buttonAction: VoidCompletion?
  
  init(title: String, action: VoidCompletion?) {
    self.title = title
    self.buttonAction = action
  }
  
  var body: some View {
    button()
      .frame(maxWidth: .infinity)
      .padding(8)
  }
  
  @ViewBuilder
  private func button() -> some View {
    Button {
      buttonAction?()
    } label: {
      HStack(content: {
        Text(title)
          .foregroundStyle(Color.white)
          .font(.body)
      })
      .padding(EdgeInsets(top: 8, leading: 32, bottom: 8, trailing: 32))
      .frame(maxWidth: .infinity, minHeight: 40)
      .background(Theme.primaryDarkColor)
      .clipShape(RoundedRectangle(cornerRadius: 5))
      .shadow(radius: 3.0, x: 1, y: 2)
    }
    .buttonStyle(PlainButtonStyle())
    
  }
}
