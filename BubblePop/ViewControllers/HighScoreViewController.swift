import Foundation
import UIKit

class TwoColumnTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8),
            
            detailLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 8),
            detailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
}

class HighScoreViewController: UIViewController {
  
  @IBOutlet weak var scoreBoardTable: UITableView!
  var highScores: [Score] = [];
  
  override func viewDidLoad() {
    super.viewDidLoad();
    scoreBoardTable.register(TwoColumnTableViewCell.self, forCellReuseIdentifier: "TwoColumnCell");
    scoreBoardTable.delegate = self;
    scoreBoardTable.dataSource = self;
    highScores = Score.getAllScores();
  }
}

extension HighScoreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoColumnCell", for: indexPath) as! TwoColumnTableViewCell
        
        let score = highScores[indexPath.row]
        cell.configure(title: score.name, detail: "\(score.points)")
        
        return cell
    }
}
