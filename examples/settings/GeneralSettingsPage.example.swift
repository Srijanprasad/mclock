// GeneralSettingsPage.example.swift
// Example SettingsPage for general application preferences.
//
// Copy into mclockCore/Settings/Pages/ when implementing v0.4.0.
//
// Registration:
//   settingsService.register(GeneralSettingsPage())

// import mclockCore
// import SwiftUI

// struct GeneralSettingsPage: SettingsPage {
//     var title: String { "General" }
//     var icon: String { "gear" }
//
//     func makeView() -> AnyView {
//         AnyView(GeneralSettingsView())
//     }
// }
//
// struct GeneralSettingsView: View {
//     var body: some View {
//         Form {
//             Section("Clock") {
//                 Picker("Time Format", selection: .constant(TimeFormat.twentyFourHour)) {
//                     Text("12 Hour").tag(TimeFormat.twelveHour)
//                     Text("24 Hour").tag(TimeFormat.twentyFourHour)
//                 }
//             }
//             Section("Lock Screen") {
//                 Toggle("Auto-lock on idle", isOn: .constant(true))
//             }
//         }
//         .padding()
//     }
// }
