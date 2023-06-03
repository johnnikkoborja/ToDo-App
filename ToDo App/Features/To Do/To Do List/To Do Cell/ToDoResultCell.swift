//
//  ToDoResultCell.swift
//

import Foundation
import UIKit
import EventKit

class ToDoResultCell: UITableViewCell {
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var setName: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var season: UILabel!
    
    fileprivate static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: Setup
    func cellSetup() {
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        layoutMargins = .zero
        selectionStyle = .default;
        
        // Selected cell background
        let backgroundView = UIView()
        backgroundView.backgroundColor = R.color.global_yellow()
        backgroundView.cornerRadius = 42
        selectedBackgroundView = backgroundView
    }
    
    func configure(with task: Task) {
        
        playerName.text = task.title
        setName.text = task.subTasks
        year.text = task.dueDate
    }
}
