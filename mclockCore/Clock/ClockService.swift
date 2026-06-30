import Foundation

/// Formats and publishes time updates for the menu bar display.
@MainActor
public final class ClockService: ClockServiceProtocol, ObservableObject {
    @Published public private(set) var currentTime: String = ""
    @Published public private(set) var isRunning = false

    private let settings: SettingsServiceProtocol
    private let dateProvider: () -> Date
    private var updateTask: Task<Void, Never>?

    private lazy var twelveHourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale.current
        return formatter
    }()

    private lazy var twentyFourHourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale.current
        return formatter
    }()

    public init(
        settings: SettingsServiceProtocol,
        dateProvider: @escaping () -> Date = Date.init
    ) {
        self.settings = settings
        self.dateProvider = dateProvider
        updateCurrentTime()
    }

    public func startUpdating(every interval: TimeInterval) {
        guard interval > 0 else { return }

        stopUpdating()
        isRunning = true
        updateCurrentTime()

        updateTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(interval))
                await self?.updateCurrentTime()
            }
        }
    }

    public func stopUpdating() {
        updateTask?.cancel()
        updateTask = nil
        isRunning = false
    }

    private func updateCurrentTime() {
        let date = dateProvider()
        switch settings.timeFormat {
        case .twelveHour:
            currentTime = twelveHourFormatter.string(from: date)
        case .twentyFourHour:
            currentTime = twentyFourHourFormatter.string(from: date)
        }
    }
}
