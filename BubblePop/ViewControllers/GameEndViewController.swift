import Foundation
import UIKit

class GameEndViewController: UIViewController {
  
  var score: Score? = nil;
  
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var backNavigation: UINavigationItem!
  
  override func viewDidLoad() {
    backNavigation.hidesBackButton = true;
    let points: Int = score?.points ?? 0;
    scoreLabel.text = String(points);
    score?.registerScore();
  }
}
