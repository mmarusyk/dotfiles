import Foundation
import AppKit
import UserNotifications

// PRNotifier — notification helper on the modern UserNotifications framework.
// Runs as a proper (accessory) NSApplication so macOS delivers click responses
// via the UNUserNotificationCenterDelegate. Posting mode: PRNotifier <title>
// <message> <url>. Click mode: macOS relaunches with no args and we open the URL
// carried in the notification's userInfo.

let logURL = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent("Library/Logs/PRNotifier.log")

func logLine(_ s: String) {
    let line = "\(ProcessInfo.processInfo.processIdentifier) \(s)\n"
    if let data = line.data(using: .utf8) {
        if let fh = try? FileHandle(forWritingTo: logURL) {
            fh.seekToEndOfFile(); fh.write(data); try? fh.close()
        } else {
            try? data.write(to: logURL)
        }
    }
    FileHandle.standardError.write(line.data(using: .utf8)!)
}

final class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    let args = Array(CommandLine.arguments.dropFirst())

    func applicationDidFinishLaunching(_ notification: Notification) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let openAction = UNNotificationAction(identifier: "OPEN_PR", title: "Open PR",
                                              options: [.foreground])
        let category = UNNotificationCategory(identifier: "PR_REVIEW", actions: [openAction],
                                              intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])

        if args.count >= 3 {
            let (title, body, urlStr) = (args[0], args[1], args[2])
            logLine("post: \(title)")
            center.requestAuthorization(options: [.alert, .sound]) { granted, err in
                if let err = err { logLine("auth error: \(err)") }
                guard granted else { logLine("auth NOT granted"); exit(2) }
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.categoryIdentifier = "PR_REVIEW"
                content.userInfo = ["url": urlStr]
                let req = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content, trigger: nil)
                center.add(req) { addErr in
                    if let addErr = addErr { logLine("add error: \(addErr)") }
                    else { logLine("posted ok") }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { exit(addErr == nil ? 0 : 1) }
                }
            }
        } else {
            logLine("launched with no args (click delivery expected)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                logLine("no click delivered within 10s; exiting"); exit(0)
            }
        }
    }

    func userNotificationCenter(_ c: UNUserNotificationCenter, willPresent n: UNNotification,
                                withCompletionHandler h: @escaping (UNNotificationPresentationOptions) -> Void) {
        h([.banner, .list, .sound])
    }

    func userNotificationCenter(_ c: UNUserNotificationCenter, didReceive r: UNNotificationResponse,
                                withCompletionHandler h: @escaping () -> Void) {
        let action = r.actionIdentifier
        let urlStr = r.notification.request.content.userInfo["url"] as? String ?? "<none>"
        logLine("didReceive action=\(action) url=\(urlStr)")
        if let s = r.notification.request.content.userInfo["url"] as? String,
           let url = URL(string: s) {
            let ok = NSWorkspace.shared.open(url)
            logLine("NSWorkspace.open -> \(ok)")
        }
        h()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { exit(0) }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)
app.run()
