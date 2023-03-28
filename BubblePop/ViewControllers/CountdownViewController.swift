import Foundation
import UIKit

class CountdownViewController: UIViewController {
  
  // Set via prepare() in MainViewController
  var gameSettings: GameSettings? = nil;
  
  @IBOutlet var backNavigation: UINavigationItem!
  
  @IBOutlet weak var countdownLabel: UILabel!
  var countdownTimer: Timer? = nil;
  var timeRemaining: Int = 3 {
    didSet {
      countdownLabel.text = String(timeRemaining);
      if (timeRemaining == 0) {
        countdownTimer?.invalidate();
        performSegue(withIdentifier: "GameScreenSegue", sender: nil)
      }
    }
  };
  
  /**
   Initialise the countdown timer
   */
  override func viewDidLoad() {
    backNavigation.hidesBackButton = true;
    countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
      guard let self = self else {
          timer.invalidate()
          return
      }
      
      // Animate the countdown label
       UIView.transition(with: self.countdownLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
           self.countdownLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
       }) { (_) in
           UIView.animate(withDuration: 0.5, animations: {
               self.countdownLabel.transform = .identity
           })
       }
      self.timeRemaining -= 1;
    })
  }
  
  /**
   Prepare to start the game and pass on the Game Settings
   */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "GameScreenSegue") {
      let viewController = segue.destination as! GameViewController;
      viewController.gameSettings = gameSettings;
    }
  }
}
