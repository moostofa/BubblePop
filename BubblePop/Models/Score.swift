import Foundation

class Score {
  let name: String;
  let points: Int;
  
  init(name: String, points: Int) {
    self.name = name
    self.points = points
  }
  
  static func getAllScores() -> [Score] {
      let userDefaults = UserDefaults.standard
      let scoresDictionary = userDefaults.object(forKey: "highScores") as? Dictionary<String, Int> ?? Dictionary<String, Int>()
  
      var scores: [Score] = []
      for (key, value) in scoresDictionary {
          scores.append(Score(name: key, points: value))
      }
      let scoreSorted = scores.sorted { (scoreA, scoreB) -> Bool in
          scoreA.points > scoreB.points
      }
      return scoreSorted
  }
  
  func registerScore() -> Void {
      let userDefaults = UserDefaults.standard
      var scoresDictionary = userDefaults.object(forKey: "highScores") as? Dictionary<String, Int> ?? Dictionary<String, Int>()
      let currentHighScore: Int = scoresDictionary[name] ?? 0
      userDefaults.removeObject(forKey: "")
      userDefaults.setValue(nil, forKey: "")
      if (points > currentHighScore) {
          scoresDictionary[name] = points
          userDefaults.setValue(scoresDictionary, forKey: "highScores")
      }
  }
}
