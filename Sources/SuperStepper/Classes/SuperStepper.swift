import SwiftUI

@available(iOS 14.0, *)
public struct SuperStepperView: View {
  @Binding public var count: Int
  public var steppingCount: Int
  public var minimumCount: Int
  public var maximumCount: Int
  public var decreaseTitleText: String
  public var increaseTitleText: String
  public var decreaseTitleColor: Color
  public var minimumDecreaseTitleColor: Color
  public var increaseTitleColor: Color
  public var maximumIncreaseTitleColor: Color
  public var decreaseTitleFont: Font
  public var increaseTitleFont: Font
  public var separatorColor: Color
  public var seperatorWidth: Double
  public var separatorHeight: Double
  public var backgroundColor: Color
  public var borderColor: Color
  public var borderLineWidth: Double
  public var cornerRadius: Double
  public var stepperSpacing: Double
  public var onIncrement: (() -> Void)?
  public var onDecrement: (() -> Void)?
  
  public init(
    count: Binding<Int>,
    steppingCount: Int = 1,
    minimumCount: Int = 1,
    maximumCount: Int = Int.max,
    decreaseTitleText: String = "-",
    increaseTitleText: String = "+",
    decreaseTitleColor: Color = Color(red: 64/255, green: 64/255, blue: 65/255),
    minimumDecreaseTitleColor: Color = Color(red: 178/255, green: 178/255, blue: 179/255),
    increaseTitleColor: Color = Color(red: 64/255, green: 64/255, blue: 65/255),
    maximumIncreaseTitleColor: Color = Color(red: 178/255, green: 178/255, blue: 179/255),
    decreaseTitleFont: Font = .title,
    increaseTitleFont: Font = .title,
    separatorColor: Color = Color(red: 220/255, green: 220/255, blue: 221/255),
    seperatorWidth: Double = 1,
    separatorHeight: Double = 15,
    backgroundColor: Color = Color(red: 238/255, green: 238/255, blue: 239/255),
    borderColor: Color = .white,
    borderLineWidth: Double = 0,
    cornerRadius: Double = 10,
    stepperSpacing: Double = 0,
    onIncrement: (() -> Void)? = nil,
    onDecrement: (() -> Void)? = nil
  ) {
    _count = count
    self.steppingCount = steppingCount
    self.minimumCount = minimumCount
    self.maximumCount = maximumCount
    self.decreaseTitleText = decreaseTitleText
    self.increaseTitleText = increaseTitleText
    self.decreaseTitleColor = decreaseTitleColor
    self.minimumDecreaseTitleColor = minimumDecreaseTitleColor
    self.increaseTitleColor = increaseTitleColor
    self.maximumIncreaseTitleColor = maximumIncreaseTitleColor
    self.decreaseTitleFont = decreaseTitleFont
    self.increaseTitleFont = increaseTitleFont
    self.separatorColor = separatorColor
    self.seperatorWidth = seperatorWidth
    self.separatorHeight = separatorHeight
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
    self.borderLineWidth = borderLineWidth
    self.cornerRadius = cornerRadius
    self.stepperSpacing = stepperSpacing
    self.onIncrement = onIncrement
    self.onDecrement = onDecrement
  }
  
  public var body: some View {
    HStack(spacing: stepperSpacing) {
      StepperView(
        disabled: .constant(count <= minimumCount),
        title: decreaseTitleText,
        titleFont: decreaseTitleFont,
        color: count == minimumCount ? minimumDecreaseTitleColor : decreaseTitleColor
      ) {
        if let onDecrement = onDecrement {
          onDecrement()
        } else if count > minimumCount {
          count -= steppingCount
        }
      }
      Rectangle().foregroundColor(separatorColor)
        .frame(width: seperatorWidth, height: separatorHeight)
      StepperView(
        disabled: .constant(count >= maximumCount),
        title: increaseTitleText,
        titleFont: increaseTitleFont,
        color: count == maximumCount ? maximumIncreaseTitleColor : increaseTitleColor
      ) {
        if let onIncrement = onIncrement {
          onIncrement()
        } else if count < maximumCount {
          count += steppingCount
        }
      }
    }
    .background(backgroundColor.edgesIgnoringSafeArea(.all))
    .cornerRadius(cornerRadius)
    .overlay(
      RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(borderColor, lineWidth: borderLineWidth)
    )
  }
}

@available(iOS 14.0, *)
public struct StepperView: View {
  @Binding var disabled: Bool
  @State public var timer: Timer?
  @State public var isLongPressing = false
  public var title: String
  public var titleFont: Font
  public var color: Color
  public var action: () -> Void
  public var labelHorizontalPadding: Double
  public var labelVerticalPadding: Double
  public var labelHeight: Double
  public var buttonPadding: Double
  public var minimumDuration: Double
  public var timeInterval: Double
  
  public init(
    disabled: Binding<Bool> = .constant(false),
    title: String,
    titleFont: Font,
    color: Color,
    action: @escaping () -> Void = {},
    labelHorizontalPadding: Double = 16,
    labelVerticalPadding: Double = 9,
    labelHeight: Double = 30,
    buttonPadding: Double = 5,
    minimumDuration: Double = 0.5,
    timeInterval: Double = 0.1
  ) {
    _disabled = disabled
    self.title = title
    self.titleFont = titleFont
    self.color = color
    self.action = action
    self.labelHorizontalPadding = labelHorizontalPadding
    self.labelVerticalPadding = labelVerticalPadding
    self.labelHeight = labelHeight
    self.buttonPadding = buttonPadding
    self.minimumDuration = minimumDuration
    self.timeInterval = timeInterval
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
            .font(titleFont)
            .padding(.horizontal, labelHorizontalPadding)
            .padding(.vertical, labelVerticalPadding)
        }
        .foregroundColor(color)
        .frame(height: labelHeight)
      }
    )
      .padding(.horizontal, buttonPadding)
      .simultaneousGesture(
        LongPressGesture(minimumDuration: minimumDuration)
          .onEnded { _ in
            self.isLongPressing = true
            self.timer = Timer.scheduledTimer(
              withTimeInterval: timeInterval,
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
      .onChange(
        of: disabled,
        perform: { newValue in
          if newValue {
            self.timer?.invalidate()
          }
        }
      )
      .disabled(disabled)
  }
}
