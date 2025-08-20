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
        TaggedTaskListData(symbolImage: UIImage(systemName: "house.circle.fill"), taskCount: 0, label: "Home Tasks"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "bell.circle.fill"), taskCount: 0, label: "News"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "lightbulb.circle.fill"), taskCount: 0, label: "To work on Ideas"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "wifi.circle.fill"), taskCount: 0, label: "Wifi fixing"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "sun.max.circle.fill"), taskCount: 0, label: "Documentations"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "play.circle.fill"), taskCount: 0, label: "Kids Chores"),
        TaggedTaskListData(symbolImage: UIImage(systemName: "pencil.circle.fill"), taskCount: 0, label: "Reading & Writing")
    ]
}

