function layout() {
    return {
        name: "Custom3Pane",
        initialState: {
            removeLeftOverlap: false,
            removeRightOverlap: false,
            fillScreen: false,
        },
        commands: {
            command1: {
                description: "Toggle left window overlap",
                updateState: (state) => {
                    return { ...state, removeLeftOverlap: !state.removeLeftOverlap }
                }
            },
            command2: {
                description: "Toggle right window overlap",
                updateState: (state) => {
                    return { ...state, removeRightOverlap: !state.removeRightOverlap }
                }
            },
            command3: {
                description: "Enlarge layout to fill (mostly) fill the screen",
                updateState: (state) => {
                    return { ...state, fillScreen: !state.fillScreen }
                }
            },
            command4: {
                description: "Reset layout configuration to default slots",
                updateState: (state) => {
                    return {
                        ...state,
                        removeLeftOverlap: false,
                        removeRightOverlap: false,
                        fillScreen: false,
                    }
                }
            },
        },
        getFrameAssignments: (windows, screenFrame, state) => {
            // Primary Layout:
            // [-----]   [-----]
            // [---[-------]---]
            // [-2-[---1---]-3-]
            // [---[-------]---]
            // [-----]   [-----]
            //
            // TODO: Background layout:
            // [4]  [5]  [6]  [7]
            // [                ]
            // [                ]
            // [                ]
            // [8]  [9]  [.]  [.]
            //
            // const PRIMARY_SLOTS = [
            //     { x: 0.20, y: 0.075, width: 0.60, height: 0.85 },
            //     { x: 0.05, y: 0.05,  width: 0.30, height: 0.90 },
            //     { x: 0.65, y: 0.05,  width: 0.30, height: 0.90 },
            // ]
            const PRIMARY_SLOTS = [
                { x: 0.20, y: 0.10, width: 0.60, height: 0.80 },
                { x: 0.05, y: 0.08, width: 0.30, height: 0.84 },
                { x: 0.65, y: 0.08, width: 0.30, height: 0.84 },
            ]
            const SECONDARY_SLOTS = [
                { x: 0.00, y: 0.00, width: 0.25, height: 0.25 },
                { x: 0.25, y: 0.00, width: 0.25, height: 0.25 },
                { x: 0.50, y: 0.00, width: 0.25, height: 0.25 },
                { x: 0.75, y: 0.00, width: 0.25, height: 0.25 },
            ]

            let slots = [...PRIMARY_SLOTS]

            // remove left overlap
            //   - centre window shrinks by 10% screen width
            //   - centre window shifts  to 30% screen width
            //   - left   window shrinks to 25% screen width
            //   - left   window remains at  5% screen width
            if (state.removeLeftOverlap) {
                slots[0].width -= 0.10
                slots[0].x = 0.30
                slots[1].width = 0.25
            }

            // remove right overlap
            //   - centre window shrinks by 10% screen width
            //   - centre window remains at 20% screen width
            //   - right  window shrinks to 25% screen width
            //   - right  window shifts  to 70% screen width
            if (state.removeRightOverlap) {
                slots[0].width -= 0.10
                slots[2].x = 0.70
                slots[2].width = 0.25
            }

            // enlarge layout to fill the screen height and width
            //   - centre window fills to 70% width
            //   - centre window fills height with 5% margins
            //   - left   window fills left  half with 2% margins
            //   - right  window fills right half with 2% margins
            if (state.fillScreen) {
                slots[0] = { x: 0.15, y: 0.03, width: 0.70, height: 0.94 }
                slots[1] = { x: 0.02, y: 0.02, width: 0.48, height: 0.96 }
                slots[2] = { x: 0.50, y: 0.02, width: 0.48, height: 0.96 }
            }

            return windows.reduce((frames, window, index) => {
                let slot = slots[index % slots.length]
                return {
                    ...frames,
                    [window.id]: {
                        x: screenFrame.x + slot.x * screenFrame.width,
                        y: screenFrame.y + slot.y * screenFrame.height,
                        width: slot.width * screenFrame.width,
                        height: slot.height * screenFrame.height,
                    }
                }
            }, {})
        },
    }
}
