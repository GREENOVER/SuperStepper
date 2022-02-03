import SwiftUI

@available(iOS 13.0, *)
public struct SuperStepperView: View {
  @Binding public var count: Int
  
  public var decreaseTitleText: String
  public var increaseTitleText: String
  public var decreaseTitleColor: Color
  public var minimumDecreaseTitleColor: Color
  public var increaseTitleColor: Color
  public var separatorColor: Color
  public var separatorHeight: Double
  public var backgroundColor: Color
  public var cornerRadius: Double
  
  public init(
    count: Binding<Int>,
    decreaseTitleText: String = "-",
    increaseTitleText: String = "+",
    decreaseTitleColor: Color = .gray,
    minimumDecreaseTitleColor: Color = .red,
    increaseTitleColor: Color = .gray,
    separatorColor: Color = .black,
    separatorHeight: Double = 15,
    backgroundColor: Color = .yellow,
    cornerRadius: Double = 10
  ) {
    _count = count
    self.decreaseTitleText = decreaseTitleText
    self.increaseTitleText = increaseTitleText
    self.decreaseTitleColor = decreaseTitleColor
    self.minimumDecreaseTitleColor = minimumDecreaseTitleColor
    self.increaseTitleColor = increaseTitleColor
    self.separatorColor = separatorColor
    self.separatorHeight = separatorHeight
    self.backgroundColor = backgroundColor
    self.cornerRadius = cornerRadius
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      StepperView(
        title: decreaseTitleText,
        color: count == 1 ? minimumDecreaseTitleColor : decreaseTitleColor
      ) {
        if count > 1 {
          count -= 1
        }
      }
      Rectangle().foregroundColor(separatorColor)
        .frame(width: 1, height: separatorHeight)
      StepperView(
        title: increaseTitleText,
        color: increaseTitleColor
      ) {
        count += 1
      }
    }
    .background(backgroundColor.edgesIgnoringSafeArea(.all))
    .cornerRadius(cornerRadius)
  }
}

@available(iOS 13.0, *)
public struct StepperView: View {
  @State public var timer: Timer?
  @State public var isLongPressing = false
  
  public var title: String
  public var color: Color = .gray
  public var action: () -> Void = {}
  
  public init(
    title: String,
    color: Color = .gray,
    action: @escaping () -> Void = {}
  ) {
    self.title = title
    self.color = color
    self.action = action
  }
  
  public var body: some View {
    Button(
      action: {
        if self.isLongPressing {
          self.isLongPressing.toggle()
          self.timer?.invalidate()
        } else {
          self.action()
        }
      },
      label: {
        HStack(spacing: 0) {
          Text(title)
            .font(.largeTitle)
            .padding(.horizontal, 16)
            .padding(.vertical, 9)
        }
        .foregroundColor(color)
        .frame(height: 30)
      }
    )
      .padding(.horizontal, 30)
      .simultaneousGesture(
        LongPressGesture(minimumDuration: 0.5)
          .onEnded { _ in
            self.isLongPressing = true
            self.timer = Timer.scheduledTimer(
              withTimeInterval: 0.1,
              repeats: true,
              block: { _ in
                self.action()
              }
            )
          }
      )
      .simultaneousGesture(
        DragGesture()
          .onEnded { _ in
            self.isLongPressing.toggle()
            self.timer?.invalidate()
          }
      )
  }
}
