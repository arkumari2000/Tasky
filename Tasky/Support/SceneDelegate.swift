import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // Ensure we have a valid UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create a new window for the scene
        window = UIWindow(windowScene: windowScene)

        // Set the initial root view controller
        window?.rootViewController = createNavigationController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called when the scene is released by the system
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart any tasks that were paused
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Sent when moving from active to inactive state
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as part of transitioning from background to foreground
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as part of transitioning from foreground to background
    }
}

extension SceneDelegate {
    
    func createTaskListVC() -> UIViewController {
        let taskListVC = TaskListVC()
        taskListVC.title = "Tasky"
        return taskListVC
    }

    func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: createTaskListVC())
        navigationController.navigationBar.tintColor = .orange
        return navigationController
    }
    
}
