import Foundation
import SwiftUI
import UIKit

public enum PopPositionType {
    case first, last
}

public protocol Router: AnyObject {

    func presentView<T: View>(
        view: T,
        transitionStyle: UIModalTransitionStyle,
        presentStyle: UIModalPresentationStyle,
        isAnimated: Bool
    )

    func presentView(
        viewController: UIViewController,
        transitionStyle: UIModalTransitionStyle,
        presentStyle: UIModalPresentationStyle,
        isAnimated: Bool
    )

    func pushToView<T: View>(view: T, isAnimated: Bool)
    func pushToView(viewController: UIViewController, isAnimated: Bool)

    func dismiss(isAnimated: Bool, completion: (() -> Void)?)

    func pop(isAnimated: Bool)

    func popToView<T: View>(
        _ viewType: T.Type,
        isAnimated: Bool,
        inPosition: PopPositionType
    )

    func popToRootView(isAnimated: Bool)

    func presentAlert(controller: UIAlertController, isAnimated: Bool)
}

public extension Router {

    func presentView<T: View>(
        view: T,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        presentStyle: UIModalPresentationStyle = .automatic,
        isAnimated: Bool = true
    ) {
        presentView(
            view: view,
            transitionStyle: transitionStyle,
            presentStyle: presentStyle,
            isAnimated: isAnimated
        )
    }

    func presentView(
        viewController: UIViewController,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        presentStyle: UIModalPresentationStyle = .automatic,
        isAnimated: Bool = true
    ) {
        presentView(
            viewController: viewController,
            transitionStyle: transitionStyle,
            presentStyle: presentStyle,
            isAnimated: isAnimated
        )
    }

    func pushToView<T: View>(view: T, isAnimated: Bool = true) {
        pushToView(view: view, isAnimated: isAnimated)
    }

    func pushToView(viewController: UIViewController, isAnimated: Bool = true) {
        pushToView(viewController: viewController, isAnimated: isAnimated)
    }

    func dismiss(isAnimated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(isAnimated: isAnimated, completion: completion)
    }

    func pop(isAnimated: Bool = true) {
        pop(isAnimated: isAnimated)
    }

    func popToView<T: View>(
        _ viewType: T.Type,
        isAnimated: Bool = true,
        inPosition: PopPositionType = .last
    ) {
        popToView(
            viewType,
            isAnimated: isAnimated,
            inPosition: inPosition
        )
    }

    func popToRootView(isAnimated: Bool = true) {
        popToRootView(isAnimated: isAnimated)
    }

    func presentAlert(controller: UIAlertController, isAnimated: Bool = true) {
        presentAlert(controller: controller, isAnimated: isAnimated)
    }
}
