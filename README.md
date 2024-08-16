# SwiftGodot Xcode Example

This is an example showing how to set up a SwiftGodot project for debugging in Xcode.


The basic strategy is to place three folders at the root of the project:

- the Godot project containing normal scenes, resources, etc
- the SwiftGodot project containing the Swift code for controlling Godot
- the Xcode project for hosting, running and debugging everything


## Xcode Shell

The Xcode shell ties together the Godot project, your own SwiftGodot package(s), and the other libraries and frameworks needed to run.

### Building The Swift

The SwiftPackage is set as a local package dependency, and is explicitly added to the Simple Runner scheme, to ensure that Xcode knows about it. This second part shouldn't be necessary as in theory Xcode can auto-detect it, but I find that to be flaky and so adding it explicitly is a belt-and-braces step.

It is then added to the Target Dependencies of the Simple Runner target, which ensures that Xcode will build it first.

The output is added to the Link Binary With Libraries phase (for linking), and the Embed Frameworks phase (to copy it into the final application bundle).


### Bundling The Godot

The entire Godot project is linked into the Xcode project by reference, and added into the Copy Bundle Resources phase. This causes it to be copied into the final application bundle. 

The `godot_path` entry in the `Simple Runner-Info.plist` file is set to `Godot` to tell Godot where to find it at run time.

Two other frameworks are referenced by the Xcode project, but are too large to commit to Git:

- MoltenVK.xcframework
- Godot.xcframework

Up to date copies of these can be obtained by running an iOS export from within Godot, into a temporary location.

For your own project you should also be able to set things up so that they are built from source by Xcode as part of the overall build, or you could add a build phase to copy them in from a known location on your local machine.

### Targetted Platforms

This initial project contains two targets.

One works for a physical iOS device. In theory it should also be possible to set it up to work for the simulator, but I haven't quite figured it out yet -- it will need to have the correct architectures present in the MoltenVK.xcframework and the Godot.xcframework.

The other works for macOS, using SwiftGodotKit.

In both cases, Xcode will build the correct versions of your SwiftGodot code, and of the SwiftGodot package itself. 
