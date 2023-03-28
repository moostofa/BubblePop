import Foundation
import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
  
  // User input fields
  var name: String = "" {
    didSet {
      startGameButton.isEnabled = name.count > 0
    }
  };
  
  var timer: Int = 60 {
    didSet {
      timerLabel.text = "\(String(timer)) seconds"
    }
  };
  
  var maxBubbles: Int = 15 {
    didSet {
      maxBubblesLabel.text = "\(String(maxBubbles)) bubbles"
    }
  };
  
  // UI Labels
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var timerSlider: UISlider!
  @IBOutlet weak var maxBubblesLabel: UILabel!
  @IBOutlet weak var maxBubblesSlider: UISlider!
  @IBOutlet weak var startGameButton: UIButton!
  @IBOutlet var backNavigation: UINavigationItem!
  
  override func viewDidLoad() {
    super.viewDidLoad();
    backNavigation.hidesBackButton = true;
    self.nameTextField.delegate = self;
  }
  
  // Update UI with user input values
  @IBAction func onNameChange() {
    name = nameTextField.text ?? "";
  }
  
  @IBAction func onTimerChange() {
    timer = Int(timerSlider.value);
    
  }
  @IBAction func onMaxBubblesChange() {
    maxBubbles = Int(maxBubblesSlider.value);
  }
  
  /**
   Prepare to go to the countdown screen
   */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "CountdownScreenSegue") {
      let viewController = segue.destination as! CountdownViewController;
      let gameSettings = GameSettings(name, timer, maxBubbles);
      viewController.gameSettings = gameSettings;
    }
  }
}
