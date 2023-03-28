//
//  GameSettings.swift
//  BubblePop
//
//  Created by Mostafa Rahinuzzaman on 26/4/2023.
//

import Foundation

class GameSettings {
  let name: String
  let timer: Int
  let maxBubbles: Int
  
  init(_ name: String, _ timer: Int, _ maxBubbles: Int) {
    self.name = name
    self.timer = timer
    self.maxBubbles = maxBubbles
  }
}
