//
//  UIView+AutoLayout.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

public enum Axis {
    case horizontal
    case vertical
    case baseline
}

public enum Edge {
    case left
    case top
    case right
    case bottom
    case leading
    case trailing
}

public enum Dimension {
    case width
    case height
}

public extension UIView {
    // swiftlint:disable identifier_name
    convenience init(forAutoLayout: ()) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    // swiftlint:enable identifier_name

    @discardableResult
    func centerInSuperview() -> [Axis: NSLayoutConstraint] {
        var constraints = [Axis: NSLayoutConstraint]()
        if let horizontal = self.align(to: .horizontal) {
            constraints[.horizontal] = horizontal
        }
        if let vertical = self.align(to: .vertical) {
            constraints[.vertical] = vertical
        }
        return constraints
    }

    @discardableResult
    func align(to superviewAxis: Axis) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            assertionFailure("Need to have a superview")
            return nil
        }
        return align(to: superviewAxis, of: superview)
    }

    @discardableResult
    func align(to axis: Axis, of otherView: UIView) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            let horizontalConstraint = self.centerYAnchor.constraint(equalTo: otherView.centerYAnchor)
            horizontalConstraint.isActive = true
            return horizontalConstraint
        case .vertical:
            let verticalConstraint = self.centerXAnchor.constraint(equalTo: otherView.centerXAnchor)
            verticalConstraint.isActive = true
            return verticalConstraint
        case .baseline:
            let baselineConstraint = self.lastBaselineAnchor.constraint(equalTo: otherView.lastBaselineAnchor)
            baselineConstraint.isActive = true
            return baselineConstraint
        }
    }

    @discardableResult
    func pinToSuperViewEdges() -> [Edge: NSLayoutConstraint] {
        return self.pinToSuperViewEdges(with: UIEdgeInsets.zero)
    }

    @discardableResult
    func pinToSuperViewEdges(with insets: UIEdgeInsets,
                             excludingEdge: Edge? = nil) -> [Edge: NSLayoutConstraint] {
        var constraints = [Edge: NSLayoutConstraint]()
        if excludingEdge != .top {
            let constraint = self.pin(.top, withInset: insets.top)
            constraints[.top] = constraint
        }

        if excludingEdge != .leading && excludingEdge != .left {
            let constraint = self.pin(.leading, withInset: insets.left)
            constraints[.leading] = constraint
        }

        if excludingEdge != .bottom {
            let constraint = self.pin(.bottom, withInset: insets.bottom)
            constraints[.bottom] = constraint
        }

        if excludingEdge != .trailing && excludingEdge != .right {
            let constraint = self.pin(.trailing, withInset: insets.left)
            constraints[.trailing] = constraint
        }

        return constraints
    }

    @discardableResult
    func pinToTopLayoutGuide(of viewController: UIViewController,
                             withInset inset: CGFloat = 0,
                             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let toAnchor: NSLayoutYAxisAnchor

        if #available(iOS 11.0, *) {
            let guide = viewController.view.safeAreaLayoutGuide
            toAnchor = guide.topAnchor
        } else {
            toAnchor = viewController.topLayoutGuide.bottomAnchor
        }

        return self.pinVertical(from: self.topAnchor, to: toAnchor, withInset: inset, relation: relation)
    }

    @discardableResult
    func pinToBottomLayoutGuide(of viewController: UIViewController,
                                withInset inset: CGFloat = 0,
                                relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let toAnchor: NSLayoutYAxisAnchor

        if #available(iOS 11.0, *) {
            let guide = viewController.view.safeAreaLayoutGuide
            toAnchor = guide.bottomAnchor
        } else {
            toAnchor = viewController.bottomLayoutGuide.topAnchor
        }

        return self.pinVertical(from: self.bottomAnchor, to: toAnchor, withInset: -inset, relation: relation)
    }

    @discardableResult
    private func pinVertical(from anchor: NSLayoutYAxisAnchor,
                             to toAnchor: NSLayoutYAxisAnchor,
                             withInset inset: CGFloat = 0,
                             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {

        switch relation {
        case .equal:
            let constraint = anchor.constraint(equalTo: toAnchor, constant: inset)
            constraint.isActive = true
            return constraint
        case .greaterThanOrEqual:
            let constraint = anchor.constraint(greaterThanOrEqualTo: toAnchor, constant: inset)
            constraint.isActive = true
            return constraint
        case .lessThanOrEqual:
            let constraint = anchor.constraint(lessThanOrEqualTo: toAnchor, constant: inset)
            constraint.isActive = true
            return constraint
        @unknown default:
            fatalError("Check 'Unfrozen' enum with new case")
        }
    }

    @discardableResult
    func pin(_ edge: Edge,
             withInset inset: CGFloat = 0,
             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            assertionFailure("Need to have a superview")
            return nil
        }
        let rel: NSLayoutConstraint.Relation
        let offset: CGFloat
        switch edge {
        case .bottom, .right, .trailing:
            offset = -inset
            if case .lessThanOrEqual = relation {
                rel = .greaterThanOrEqual
            } else if case .greaterThanOrEqual = relation {
                rel = .lessThanOrEqual
            } else {
                rel = relation
            }
        default:
            rel = relation
            offset = inset
        }
        return self.pin(edge, to: edge, of: superview, withOffset: offset, relation: rel)
    }

    @discardableResult
    func pin(_ edge: Edge,
             to toEdge: Edge,
             of otherView: UIView,
             withOffset offset: CGFloat = 0,
             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint? {
        self.translatesAutoresizingMaskIntoConstraints = false

        if let fromAnchor = self.horizontalAnchor(for: edge, of: self),
            let toAnchor = self.horizontalAnchor(for: toEdge, of: otherView) {
            switch relation {
            case .equal:
                let constraint = fromAnchor.constraint(equalTo: toAnchor, constant: offset)
                constraint.isActive = true
                return constraint
            case .greaterThanOrEqual:
                let constraint = fromAnchor.constraint(greaterThanOrEqualTo: toAnchor, constant: offset)
                constraint.isActive = true
                return constraint
            case .lessThanOrEqual:
                let constraint = fromAnchor.constraint(lessThanOrEqualTo: toAnchor, constant: offset)
                constraint.isActive = true
                return constraint
            @unknown default:
                fatalError("Check 'Unfrozen' enum with new case")
            }
        } else if let fromAnchor = self.verticalAnchor(for: edge, of: self),
            let toAnchor = self.verticalAnchor(for: toEdge, of: otherView) {
            switch relation {
            case .equal:
                let constraint = fromAnchor.constraint(equalTo: toAnchor, constant: offset)
                constraint.isActive = true
                return constraint
            case .greaterThanOrEqual:
                let constraint = fromAnchor.constraint(greaterThanOrEqualTo: toAnchor, constant: offset)
                constraint.isActive = true
                return constraint
            case .lessThanOrEqual:
                let constraint = fromAnchor.constraint(lessThanOrEqualTo: toAnchor, constant: offset)
                constraint.isActive = true
                return constraint
            @unknown default:
                fatalError("Check 'Unfrozen' enum with new case")
            }
        } else {
            return nil
        }
    }

    private func horizontalAnchor(for edge: Edge, of view: UIView) -> NSLayoutXAxisAnchor? {
        switch edge {
        case .left:
            return view.leftAnchor
        case .right:
            return view.rightAnchor
        case .leading:
            return view.leadingAnchor
        case .trailing:
            return view.trailingAnchor
        default:
            return nil
        }
    }

    private func verticalAnchor(for edge: Edge, of view: UIView) -> NSLayoutYAxisAnchor? {
        switch edge {
        case .top:
            return view.topAnchor
        case .bottom:
            return view.bottomAnchor
        default:
            return nil
        }
    }

    private func dimensionAnchor(for dimension: Dimension, of view: UIView) -> NSLayoutDimension {
        switch dimension {
        case .width:
            return view.widthAnchor
        case .height:
            return view.heightAnchor
        }
    }

    @discardableResult
    func setDimensions(to size: CGSize) -> [Dimension: NSLayoutConstraint] {
        let widthConstraint = self.setDimension(.width, toSize: size.width)
        let heightConstraint = self.setDimension(.height, toSize: size.height)
        return [.width: widthConstraint, .height: heightConstraint]
    }

    @discardableResult
    func setDimension(_ dimension: Dimension,
                      toSize size: CGFloat,
                      relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch (dimension, relation) {
        case (_, .equal):
            let equalConstraint = self.dimensionAnchor(for: dimension, of: self).constraint(equalToConstant: size)
            equalConstraint.isActive = true
            return equalConstraint
        case (_, .greaterThanOrEqual):
            let greaterThanConstraint = self.dimensionAnchor(for: dimension, of: self).constraint(greaterThanOrEqualToConstant: size)
            greaterThanConstraint.isActive = true
            return greaterThanConstraint
        case (_, .lessThanOrEqual):
            let lessThanOrEqualConstraint = self.dimensionAnchor(for: dimension, of: self).constraint(lessThanOrEqualToConstant: size)
            lessThanOrEqualConstraint.isActive = true
            return lessThanOrEqualConstraint
        @unknown default:
            fatalError("Check 'Unfrozen' enum with new case")
        }
    }

    @discardableResult
    func constrainAttribute(_ dimension: Dimension,
                            to otherDimension: Dimension,
                            of otherView: UIView,
                            withMultiplier multiplier: CGFloat = 1,
                            withOffset offset: CGFloat = 0,
                            relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let fromAnchor = self.dimensionAnchor(for: dimension, of: self)
        let toAnchor = self.dimensionAnchor(for: otherDimension, of: otherView)

        switch relation {
        case .equal:
            let constraint = fromAnchor.constraint(equalTo: toAnchor, multiplier: multiplier, constant: offset)
            constraint.isActive = true
            return constraint
        case .greaterThanOrEqual:
            let constraint = fromAnchor.constraint(greaterThanOrEqualTo: toAnchor, multiplier: multiplier, constant: offset)
            constraint.isActive = true
            return constraint
        case .lessThanOrEqual:
            let constraint = fromAnchor.constraint(lessThanOrEqualTo: toAnchor, multiplier: multiplier, constant: offset)
            constraint.isActive = true
            return constraint
        @unknown default:
            fatalError("Check 'Unfrozen' enum with new case")
        }
    }

    @discardableResult
    func constrainAttribute(_ dimension: Dimension,
                            to otherDimension: Dimension,
                            of otherView: UIView,
                            withOffset offset: CGFloat) -> NSLayoutConstraint? {
        return self.constrainAttribute(dimension, to: otherDimension, of: otherView, withMultiplier: 1, withOffset: offset)
    }

    @discardableResult
    func match(_ dimension: Dimension,
               to otherDimension: Dimension,
               of otherView: UIView,
               withOffset offset: CGFloat = 0,
               withMultiplier multiplier: CGFloat = 1,
               relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return self.constrainAttribute(dimension,
                                       to: otherDimension,
                                       of: otherView,
                                       withMultiplier: multiplier,
                                       withOffset: offset,
                                       relation: relation)
    }

    /// Pins a view to specified edges of its superview, with an inset and relation
    ///
    /// - Parameters:
    ///   - edges: array of edges
    ///   - inset: The inset
    ///   - relation: relation to it's superview edge
    /// - Returns: An array of constraints that were added in order the achieve the pinning
    @discardableResult func pinTo(edges: [Edge] = [.left, .right, .top, .bottom],
                                  inset: CGFloat = 0,
                                  relation: NSLayoutConstraint.Relation? = nil) -> [Edge: NSLayoutConstraint] {
        var constraints: [Edge: NSLayoutConstraint] = [:]
        for edge in edges {
            let constraint: NSLayoutConstraint?
            if let aRelation = relation {
                constraint = self.pin(edge, withInset: inset, relation: aRelation)
            } else {
                constraint = self.pin(edge, withInset: inset)
            }
            if let constraint = constraint {
                constraints[edge] = constraint
            }
        }
        return constraints
    }
}
