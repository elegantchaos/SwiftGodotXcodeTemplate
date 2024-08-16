# SwiftGodot Xcode Example

This is an example showing how to set up a SwiftGodot project for debugging in Xcode.

There are three folders at the root of the project:

- `Godot`: contains the Godot project containing normal scenes, resources, etc
- `Swift`: contains the Swift code for controlling Godot
- `Xcode`: the Xcode project for the shell apps that host the godot, for running/debugging everything

This repo uses the SwiftGodot "Simple Runner" as an example project.

It should be fairly easy to clone and customise this setup, and swap in your own Godot and Swift files.


## Xcode Shell

The Xcode shell ties together the Godot project, your own SwiftGodot package(s), and the other libraries and frameworks needed to run.

### Targetted Platforms

This initial project contains two targets:

- `iOS`: this works for a physical iOS device. In theory it should also be possible to set it up to work for the simulator, but I haven't quite figured it out yet -- it will need to have the correct architectures present in the MoltenVK.xcframework and the Godot.xcframework.
- `macOS`: This works for macOS, using SwiftGodotKit to embed the project

In both cases, Xcode will build the correct versions of your SwiftGodot code, and of the SwiftGodot package itself.

You can run from Xcode, and can breakpoint your Swift code. 


### Bundling The Swift

The SwiftPackage is set as a local package dependency of the project, and is explicitly added to the iOS and macOS schemes, to ensure that Xcode knows about it*.
 

(* this second part shouldn't be necessary as in theory Xcode can auto-detect it, but I find that to be flaky and so adding it explicitly is a belt-and-braces step.)

It is then added to the Target Dependencies of the iOS and macOS targets, which ensures that Xcode will build it first.

The output is added to the Link Binary With Libraries phase (for linking), and the Embed Frameworks phase (to copy it into the final application bundle).


### Bundling The Godot

The entire Godot project is linked into the Xcode project by reference, and added into the Copy Bundle Resources phase of the targets. This causes it to be copied into the final application bundle. 

#### iOS

The `godot_path` entry in the `Info.plist` file is set to `Godot` to tell Godot where to find it at run time.

Two other frameworks are referenced by the Xcode project, but are too large to commit to Git:

- MoltenVK.xcframework
- Godot.xcframework

Up to date copies of these can be obtained by running an iOS export from within Godot, into a temporary location.

For your own project you should also be able to set things up so that they are built from source by Xcode as part of the overall build, or you could add a build phase to copy them in from a known location on your local machine.

#### macOS

Copying the project into the app bundle is enough for this version. At runtime we discover the path to it, and call the SwiftGodotKit entrypoint passing it in as an argument.


### SwiftGodot Versions

I have used my own forks of SwiftGodot and SwiftGodotKit for this example. This is mostly to ensure that the versions are consistent. I have tweaked a couple of things in them, but I don't believe that there is anything that would prevent you from changing back to the main versions.

If you do discover something that I've changed which is essential, please let me know and we can try to raise a PR to get it merged.
