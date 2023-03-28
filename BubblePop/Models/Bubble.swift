//
//  Bubble.swift
//  BubblePop
//
//  Created by Mostafa Rahinuzzaman on 26/4/2023.
//

import Foundation
import UIKit

class Bubble: UIButton {
  // Properties
  var points: Int;
  var colour: UIColor;
  
  // Constants
  public static let MAX_BUBBLE_SIZE = 50;
  
  /**
   Mapping of colours and points
   */
  static let colours: Dictionary<ClosedRange<Int>, (UIColor, Int)> = [
    0...40: (UIColor.red, 1),
    41...70: (UIColor.systemPink, 2),
    71...85: (UIColor.green, 5),
    86...95: (UIColor.blue, 8),
    96...100: (UIColor.black, 10)
  ];
  
  /**
   Red coloured Bubble is the default
   */
  init(_ points: Int = 1, _ colour: UIColor = UIColor.red) {
    // Set Bubble properties
    self.points = points
    self.colour = colour
    
    // Set Button properties
    super.init(frame: CGRect(x: 0, y: 0, width: Bubble.MAX_BUBBLE_SIZE, height: Bubble.MAX_BUBBLE_SIZE));
    self.backgroundColor = colour;
    self.layer.cornerRadius = self.bounds.size.width / 2
    self.transform = CGAffineTransform(scaleX: 0, y: 0)
    UIView.animate(withDuration: 1.0, animations: {
      self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    })
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func changePosition(x: Int, y: Int) {
    self.frame.origin.x = CGFloat(x);
    self.frame.origin.y = CGFloat(y);
  }
  
  func isOverlapping(bubble: Bubble) -> Bool {
    return self.frame.intersects(bubble.frame);
  }
  
  // Animate the popping of the Bubble
  func pop() {
    UIView.animate(withDuration: 0.3, animations: {
      self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
      self.alpha = 0.0
    })
  }
  
  @objc func remove() {
       // Animate the fading away of the bubble view
       UIView.animate(withDuration: 1.0, animations: {
           self.alpha = 0.0
           self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
       })
   }
    
  /**
   Generate a random coloured Bubble
   */
  static func create() -> Bubble {
    let randomPercentage = Int.random(in: 1...100);
    for (key, value) in colours {
      if (key.contains(randomPercentage)) {
        let (colour, points) = value;
        return Bubble(points, colour);
      }
    }
    return Bubble();
  }
}
