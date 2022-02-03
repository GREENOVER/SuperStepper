//
//  SuperStepperView.swift
//  SuperStepper_Example
//
//  Created by Chanwoo Cho on 2022/02/03.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import SuperStepper

struct ContentView: View {
  @State var count: Int = 1
  
  var body: some View {
    VStack {
      SuperStepperView(count: $count)
      Text("count number is \(count)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
