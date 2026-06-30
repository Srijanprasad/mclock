import AppKit
import mclockCore
import SwiftUI

@main
struct MClockApp: App {
    @StateObject private var container = ServiceContainer()

    var body: some Scene {
        MenuBarExtra("mclock", systemImage: "clock") {
            MenuBarMenuView(container: container)
        } label: {
            MenuBarClockLabel(clockService: container.clockService)
        }
        .menuBarExtraStyle(.menu)
    }

}

private struct MenuBarClockLabel: View {
    @ObservedObject var clockService: ClockService

    var body: some View {
        Text(clockService.currentTime)
            .monospacedDigit()
            .accessibilityLabel("mclock")
            .accessibilityIdentifier("menuBarClock")
            .onAppear {
                clockService.startUpdating(every: 1.0)
            }
    }
}

private struct MenuBarMenuView: View {
    @ObservedObject var container: ServiceContainer

    var body: some View {
        Group {
            Text("mclock v0.1.0")
                .font(.headline)

            Divider()

            Picker("Time Format", selection: timeFormatBinding) {
                Text("12 Hour").tag(TimeFormat.twelveHour)
                Text("24 Hour").tag(TimeFormat.twentyFourHour)
            }

            Divider()

            Button("Quit mclock") {
                container.stopServices()
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
    }

    private var timeFormatBinding: Binding<TimeFormat> {
        Binding(
            get: { container.settings.timeFormat },
            set: { newValue in
                container.settings.timeFormat = newValue
                container.clockService.startUpdating(every: 1.0)
            }
        )
    }
}
