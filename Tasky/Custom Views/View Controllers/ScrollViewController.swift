//
//  ScrollViewController.swift
//  Tasky
//
//  Created by Archana Kumari on 21/08/25.
//

import UIKit

class ScrollViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureScrollViewAndContentView()
        configureConstraints()
    }
    
    func configureScrollViewAndContentView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func configureConstraints() {
        // Pin scrollView edges to safe area
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Pin contentView edges to scrollView and equal width
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Important for vertical scroll
        ])
    }
}
