
import Foundation
import SwiftGodotKit
import SwiftGodot
import SimpleRunnerDriver

func loadSettings(settings: ProjectSettings) {
    
}

func loadScene (scene: SceneTree) {
}

func registerTypes (level: GDExtension.InitializationLevel) {
    switch level {
        case .scene:
            register (type: SimpleRunnerDriver.PlayerController.self)
        default:
            break
    }
}

@main
class Startup {
    static func main () {
        let path = Bundle.main.url(forResource: "Godot", withExtension: nil)!.path()
        runGodot(args: ["--path", path], initHook: registerTypes, loadScene: loadScene, loadProjectSettings: loadSettings)
    }
}
