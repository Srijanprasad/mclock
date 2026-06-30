// PomodoroPlugin.example.swift
// Example Plugin that integrates a Pomodoro timer with the clock display.
//
// See docs/plugin-development.md for the full plugin authoring guide.
//
// Installation:
//   Place in ~/Library/Application Support/mclock/Plugins/com.example.pomodoro/

// import mclockCore

// struct PomodoroPlugin: Plugin {
//     var id: String { "com.example.pomodoro" }
//     var name: String { "Pomodoro Timer" }
//     var version: String { "1.0.0" }
//
//     private var timer: Timer?
//     private var isWorkPhase = true
//
//     func activate(in context: PluginContext) {
//         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
//             // Update clock display with remaining time
//         }
//     }
//
//     func deactivate() {
//         timer?.invalidate()
//         timer = nil
//     }
// }
