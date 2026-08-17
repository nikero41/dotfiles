import AppKit
import Foundation

let aerospacePath = "/opt/homebrew/bin/aerospace"
let gameBundleID = "com.riotgames.LeagueofLegends.GameClient"

var aerospaceEnabled: Bool?

func log(_ message: String) {
    FileHandle.standardOutput.write(Data("\(message)\n".utf8))
}

func setAerospaceEnabled(_ enabled: Bool) {
    guard aerospaceEnabled != enabled else { return }

    let task = Process()
    task.executableURL = URL(fileURLWithPath: aerospacePath)
    task.arguments = ["enable", enabled ? "on" : "off"]
    task.standardOutput = FileHandle.nullDevice
    task.standardError = FileHandle.nullDevice

    do {
        try task.run()
        task.waitUntilExit()

        guard task.terminationStatus == 0 else {
            log("aerospace enable \(enabled ? "on" : "off") failed with status \(task.terminationStatus)")
            return
        }

        aerospaceEnabled = enabled
        log("AeroSpace \(enabled ? "enabled" : "disabled")")
    } catch {
        log("Unable to run AeroSpace: \(error)")
    }
}

func updateAerospace(for app: NSRunningApplication?) {
    setAerospaceEnabled(app?.bundleIdentifier != gameBundleID)
}

let workspace = NSWorkspace.shared

updateAerospace(for: workspace.frontmostApplication)

workspace.notificationCenter.addObserver(
    forName: NSWorkspace.didActivateApplicationNotification,
    object: nil,
    queue: .main
) { notification in
    let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication
    updateAerospace(for: app)
}

workspace.notificationCenter.addObserver(
    forName: NSWorkspace.didTerminateApplicationNotification,
    object: nil,
    queue: .main
) { notification in
    let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication

    guard app?.bundleIdentifier == gameBundleID else { return }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        updateAerospace(for: workspace.frontmostApplication)
    }
}

RunLoop.main.run()
