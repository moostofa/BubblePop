import Foundation
import UIKit

class GameViewController: UIViewController {
  
  // Set via prepare() in CountdownViewController
  var gameSettings: GameSettings? = nil;
  
  // UI labels
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var currentScoreLabel: UILabel!
  @IBOutlet weak var highScoreLabel: UILabel!
  @IBOutlet var backNavigation: UINavigationItem!
  
  // Play area
  @IBOutlet weak var playAreaView: UIView!
  var availableWidth: Int = 0;
  var availableHeight: Int = 0;
  
  // Bubbles shown in the UI
  var activeBubbles: [Bubble] = [];
  
  // Game state
  var timer = Timer();
  var removeBubblesTimer = Timer();
  
  var timeRemaining: Int = 60 {
    didSet {
      timerLabel.text = String(timeRemaining);
      if (timeRemaining == 0) {
        // end game
        timer.invalidate();
        removeBubblesTimer.invalidate();
        performSegue(withIdentifier: "FinishGameSegue", sender: nil);
      }
    }
  }
  
  var score: Int = 0 {
    didSet {
      currentScoreLabel.text = String(score);
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad();
    backNavigation.hidesBackButton = true;
    
    // Set boundaries in which Bubbles can exist
    availableWidth = Int(playAreaView.bounds.width) - Bubble.MAX_BUBBLE_SIZE;
    availableHeight = Int(playAreaView.bounds.height) - Bubble.MAX_BUBBLE_SIZE;
    
    // Set countdown timer based on user's settings
    timeRemaining = gameSettings?.timer ?? 60;
    
    // Begin countdown
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
      self.timeRemaining -= 1;
      self.createBubbles();
    });
    
    // Remove Bubbles from screen every 2 seconds
    removeBubblesTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
      self.removeBubbles();
    })
  }
  
  /**
   Add bubbles to the screen periodically
   */
  func createBubbles() -> Void {
    // Decide how many to create
    let maxAddAcount = (gameSettings?.maxBubbles ?? 15) - activeBubbles.count;
    let createCount = Int.random(in: 0...maxAddAcount);
    
    // Exit early if there are no bubbles to be created
    if (createCount == 0) {
      return;
    }
    
    // Create the bubbles
    for _ in 1...createCount {
      let bubble = Bubble.create();
      
      // Handle Bubble pop
      bubble.addTarget(self, action: #selector(popBubble), for: .touchDown);
      
      // Ensure Bubbles do not overlap
      var isOverlapping: Bool;
      repeat {
        bubble.changePosition(
          x: Int.random(in: 0...availableWidth),
          y: Int.random(in: 0...availableHeight)
        );

        isOverlapping = activeBubbles.contains(where: { (_bubble) -> Bool in
          bubble.isOverlapping(bubble: _bubble)
        })
        
      } while (isOverlapping == true)
      
      activeBubbles.append(bubble);
      playAreaView.addSubview(bubble);
    }
  }
  
  /**
   Remove bubbles from the screen periodically
   */
  func removeBubbles() {
    var newBubbles: [Bubble] = [];
    for bubble in activeBubbles {
      let removeBubble = Bool.random();
      if (removeBubble) {
        bubble.remove();
      }
      else {
        newBubbles.append(bubble);
      }
    }
    activeBubbles = newBubbles;
  }
  
  /**
   Handles the event of when a Bubble is tapped, and add points
   */
  @objc func popBubble(_ sender: Bubble) {
    let points = sender.points;
    sender.pop();
    if let index = activeBubbles.firstIndex(of: sender) {
      activeBubbles.remove(at: index)
    }
    score += points;
  }
  
  /**
   Prepare to show the results screen
   */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "FinishGameSegue") {
      let viewController = segue.destination as! GameEndViewController;
      viewController.score = Score(name: gameSettings?.name ?? "", points: score);
    }
  }
}
