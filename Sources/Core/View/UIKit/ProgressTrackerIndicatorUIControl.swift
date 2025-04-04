//
//  ProgressTrackerIndicatorUIControl.swift
//  SparkProgressTracker
//
//  Created by Michael Zimmermann on 26.01.24.
//  Copyright © 2024 Leboncoin. All rights reserved.
//

import Combine
import Foundation
import UIKit
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// The round small indicator on the progress tracker
final class ProgressTrackerIndicatorUIControl: UIControl {

    private let viewModel: ProgressTrackerIndicatorViewModel<ProgressTrackerUIIndicatorContent>

    var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    var intent: ProgressTrackerIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    var content: ProgressTrackerUIIndicatorContent {
        get {
            return self.viewModel.content
        }
        set {
            self.viewModel.content = newValue
        }
    }

    var size: ProgressTrackerSize {
        get {
            return self.viewModel.size
        }
        set {
            self.viewModel.size = newValue
        }
    }

    var variant: ProgressTrackerVariant {
        get {
            return self.viewModel.variant
        }
        set {
            self.viewModel.variant = newValue
        }
    }

    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.adjustsFontForContentSizeCategory = true
        label.isHidden = true
        label.numberOfLines = 1
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        imageView.isUserInteractionEnabled = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true

        imageView.setContentCompressionResistancePriority(.required,
                                                          for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required,
                                                          for: .vertical)

        return imageView
    }()

    private var cancellables = Set<AnyCancellable>()
    private var heightConstraint: NSLayoutConstraint?
    private var imageHeightConstraint: NSLayoutConstraint?

    @ScaledUIMetric var scaleFactor: CGFloat = 1.0

    private var borderWidth: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.borderWidth
    }

    private var imageHeight: CGFloat {
        return self.scaleFactor * ProgressTrackerConstants.iconHeight
    }

    override var isHighlighted: Bool {
        didSet {
            self.viewModel.set(highlighted: self.isHighlighted)
        }
    }

    override var isEnabled: Bool {
        didSet {
            self.viewModel.set(enabled: self.isEnabled)
            if self.isEnabled {
                self.accessibilityTraits.remove(.notEnabled)
            } else {
                self.accessibilityTraits.insert(.notEnabled)
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            self.viewModel.set(selected: self.isSelected)
            if self.isSelected {
                self.accessibilityTraits.insert(.selected)
            } else {
                self.accessibilityTraits.remove(.selected)
            }
        }
    }

    // MARK: - Initialization
    convenience init(
        theme: Theme,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        size: ProgressTrackerSize,
        content: ProgressTrackerUIIndicatorContent) {
            let viewModel = ProgressTrackerIndicatorViewModel<ProgressTrackerUIIndicatorContent>(

                theme: theme,
                intent: intent,
                variant: variant,
                size: size,
                content: content,
                state: .normal
            )

            self.init(viewModel: viewModel)
        }

    init(viewModel: ProgressTrackerIndicatorViewModel<ProgressTrackerUIIndicatorContent>) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        self.setupView()
        self.update(colors: self.viewModel.colors)
        self.update(content: self.viewModel.content)
        self.update(font: self.viewModel.font)
        self.updateBorderWidth()
        self.setupSubscriptions()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self._scaleFactor.update(traitCollection: self.traitCollection)

        if self.traitCollection.hasDifferentSizeCategory(comparedTo: previousTraitCollection) {
            self.sizesChanged()
        }
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.updateBorderColor()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private functions
    private func setupView() {
        self.addSubviewSizedEqually(self.indicatorView)
        self.indicatorView.addSubviewCentered(self.imageView)
        self.indicatorView.addSubviewCentered(self.label)

        self.indicatorView.layer.cornerRadius = (self.viewModel.size.rawValue * self.scaleFactor) / 2
        self.alpha = self.viewModel.opacity

        let heightConstraint = self.indicatorView.heightAnchor.constraint(equalToConstant: self.viewModel.size.rawValue * self.scaleFactor)

        let imageHeightConstraint =
        self.imageView.heightAnchor.constraint(equalToConstant: self.imageHeight)

        NSLayoutConstraint.activate([
            heightConstraint,
            imageHeightConstraint,
            self.imageView.widthAnchor
                .constraint(equalTo: self.imageView.heightAnchor),
            self.indicatorView.widthAnchor.constraint(equalTo: self.indicatorView.heightAnchor)
        ])
        self.imageHeightConstraint = imageHeightConstraint
        self.heightConstraint = heightConstraint
    }

    private func setupSubscriptions() {
        self.viewModel.$colors.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] colors in
            self?.update(colors: colors)
        }
        self.viewModel.$size.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] size in
            self?.update(size: size)
        }
        self.viewModel.$content.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] content in
            self?.update(content: content)
        }
        self.viewModel.$font.removeDuplicates(by: { $0.uiFont == $1.uiFont }).subscribe(in: &self.cancellables) { [weak self] font in
            self?.update(font: font)
        }
        self.viewModel.$opacity.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] opacity in
            self?.alpha = opacity
        }
    }

    private func updateBorderWidth() {
        self.indicatorView.setBorderWidth(self.borderWidth)
    }

    private func update(font: TypographyFontToken) {
        self.label.font = font.uiFont
    }

    private func update(colors: ProgressTrackerColors) {
        self.indicatorView.backgroundColor = colors.background.uiColor
        self.imageView.tintColor = colors.content.uiColor
        self.label.textColor = colors.content.uiColor
        self.updateBorderColor(colors.outline)
    }

    private func updateBorderColor() {
        self.updateBorderColor(self.viewModel.colors.outline)
    }

    private func updateBorderColor(_ color: any ColorToken) {
        self.indicatorView.setBorderColor(from: color)
    }

    private func update(content: ProgressTrackerUIIndicatorContent) {
        self.update(content: content, andSize: self.viewModel.size)
    }

    private func update(content: ProgressTrackerUIIndicatorContent, andSize size: ProgressTrackerSize) {
        if size == .small {
            self.imageView.isHidden = true
            self.label.isHidden = true
        } else if let image = content.indicatorImage {
            self.imageView.image = image
            self.imageView.isHidden = false
            self.label.isHidden = true
        } else if let text = content.label {
            self.label.text = String(text)
            self.label.isHidden = false
            self.imageView.isHidden = true
        } else {
            self.imageView.isHidden = true
            self.label.isHidden = true
        }
    }

    private func update(size: ProgressTrackerSize) {
        self.update(content: self.viewModel.content, andSize: size)
        self.heightConstraint?.constant = size.rawValue * self.scaleFactor
        self.indicatorView.layer.cornerRadius = (size.rawValue * self.scaleFactor) / 2
    }

    private func sizesChanged() {
        self.update(size: self.viewModel.size)
        self.imageHeightConstraint?.constant = self.imageHeight
        self.indicatorView.setBorderWidth(self.borderWidth)
    }

    // MARK: Modifier
    /// Change the size of the indicator
    func set(size: ProgressTrackerSize) {
        self.viewModel.size = size
    }
}
