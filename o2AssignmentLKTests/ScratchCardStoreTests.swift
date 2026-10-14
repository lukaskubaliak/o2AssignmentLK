import Foundation
import Testing
@testable import o2AssignmentLK

@MainActor
struct ScratchCardStoreTests {
    @Test("Successful scratch reveals a code")
    func successfulScratch() async {
        let store = makeStore()

        await store.scratch()

        guard case let .scratched(code) = store.card.state else {
            Issue.record("Expected a scratched card")
            return
        }

        #expect(!code.uuidString.isEmpty)
    }

    @Test("Cancelling scratch leaves the card unscratched")
    func cancelledScratch() async {
        let store = makeStore(scratchDuration: .seconds(1))
        let task = Task { await store.scratch() }

        while store.state != .scratching {
            await Task.yield()
        }

        task.cancel()
        await task.value

        #expect(store.card.state == .unscratched)
        #expect(store.error == nil)
    }

    @Test("Version above 6.1 activates the card")
    func successfulActivation() async {
        let store = makeStore(iosVersion: "6.24")
        await store.scratch()

        guard case let .scratched(code) = store.card.state else {
            Issue.record("Expected a scratched card")
            return
        }

        await store.activate()

        #expect(store.card.state == .activated(code: code))
    }

    @Test(
        "Version 6.1 or lower does not activate the card",
        arguments: ["6.1", "6.0"]
    )
    func unsuccessfulActivation(iosVersion: String) async {
        let store = makeStore(iosVersion: iosVersion)
        await store.scratch()

        guard case let .scratched(code) = store.card.state else {
            Issue.record("Expected a scratched card")
            return
        }

        await store.activate()

        #expect(store.card.state == .scratched(code: code))

        guard let error = store.error,
              case .domain(.activationError) = error else {
            Issue.record("Expected an activation error")
            return
        }
    }

    @Test("Activation continues after its screen disappears")
    func activationContinuesAfterLeavingScreen() async {
        let store = makeStore(
            iosVersion: "6.24",
            activationDelay: .milliseconds(50)
        )
        await store.scratch()

        let activationTask = Task { await store.activate() }
        await Task.yield()

        #expect(store.state == .activating)

        // ActivateView disappearing does not cancel this task.
        await activationTask.value

        guard case .activated = store.card.state else {
            Issue.record("Expected activation to finish")
            return
        }
    }
}

private extension ScratchCardStoreTests {
    func makeStore(
        iosVersion: String = "6.24",
        activationDelay: Duration = .zero,
        scratchDuration: Duration = .milliseconds(1)
    ) -> ScratchCardStore {
        ScratchCardStore(
            activationService: MockActivationService(
                iosVersion: iosVersion,
                delay: activationDelay
            ),
            scratchDuration: scratchDuration
        )
    }
}
