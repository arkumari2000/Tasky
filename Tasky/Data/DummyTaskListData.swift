//
//  DummyTaskListData.swift
//  Tasky
//
//  Created by Archana Kumari on 18/08/25.
//

import Foundation
import UIKit

struct DummyTaskListData {
    static let dummyDataArray: [TaggedTaskListData] = [
        TaggedTaskListData(symbolImage: UIImage(systemName: "star.circle.fill"), taskCount: 5, label: "Urgent Tasks"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "heart.circle.fill"), taskCount: 10, label: "Completed Tasks"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "flag.circle.fill"), taskCount: 2, label: "Pending Tasks"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "house.circle.fill"), taskCount: 0, label: "Home Tasks")
    ]
}

