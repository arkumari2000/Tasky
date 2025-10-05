//
//  TaskyRadioButton.swift
//  Tasky
//
//  Created by Archana Kumari on 21/08/25.
//

import UIKit

class TaskyRadioButton: UIControl {
    private let outerCircle = UIView()
    private let innerCircle = UIView()

    var isChecked: Bool = false {
        didSet {
            updateUI()
        }
    }

    var outerCircleColor: UIColor = .lightGray {
        didSet { outerCircle.layer.borderColor = outerCircleColor.cgColor }
    }

    var innerCircleColor: UIColor = .systemBlue {
        didSet { innerCircle.backgroundColor = innerCircleColor }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        // Outer circle styling
        outerCircle.translatesAutoresizingMaskIntoConstraints = false
        outerCircle.layer.borderWidth = 2
        outerCircle.layer.borderColor = outerCircleColor.cgColor
        outerCircle.backgroundColor = .clear
        outerCircle.isUserInteractionEnabled = false
        addSubview(outerCircle)

        // Inner circle styling
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        innerCircle.backgroundColor = innerCircleColor
        innerCircle.isHidden = true
        innerCircle.isUserInteractionEnabled = false
        addSubview(innerCircle)

        // Layout constraints
        NSLayoutConstraint.activate([
            outerCircle.widthAnchor.constraint(equalToConstant: 28),
            outerCircle.heightAnchor.constraint(equalTo: outerCircle.widthAnchor),
            outerCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            outerCircle.centerYAnchor.constraint(equalTo: centerYAnchor),

            innerCircle.centerXAnchor.constraint(equalTo: outerCircle.centerXAnchor),
            innerCircle.centerYAnchor.constraint(equalTo: outerCircle.centerYAnchor),
            innerCircle.widthAnchor.constraint(equalTo: outerCircle.widthAnchor, multiplier: 0.55),
            innerCircle.heightAnchor.constraint(equalTo: outerCircle.heightAnchor, multiplier: 0.55)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        outerCircle.layer.cornerRadius = outerCircle.frame.width / 2
        innerCircle.layer.cornerRadius = innerCircle.frame.width / 2
    }

    private func updateUI() {
        innerCircle.isHidden = !isChecked
    }

    // Optional: Toggle on tap
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isChecked.toggle()
        sendActions(for: .valueChanged)
    }
}
