function layout() {
    return {
        name: "Custom2Pane",
        initialState: {
            fillScreen: false,
        },
        commands: {
            command3: {
                description: "Enlarge layout to fill (mostly) fill the screen",
                updateState: (state) => {
                    return { ...state, fillScreen: !state.fillScreen }
                }
            },
        },
        getFrameAssignments: (windows, screenFrame, state) => {
            // Layout
            //
            // [---------------]
            // [--[---] [---]--]
            // [--[-1-] [-2-]--]
            // [--[---] [---]--]
            // [---------------]
            //
            const SLOTS = [
                { x: 0.17, y: 0.10, width: 0.33, height: 0.80 },
                { x: 0.50, y: 0.10, width: 0.33, height: 0.80 },
            ]

            let slots = [...SLOTS]

            // enlarge layout to fill the screen height and width
            //   - centre window fills to 70% width
            //   - centre window fills height with 5% margins
            //   - left   window fills left  half with 2% margins
            //   - right  window fills right half with 2% margins
            if (state.fillScreen) {
                slots[0] = { x: 0.05, y: 0.05, width: 0.45, height: 0.90 }
                slots[1] = { x: 0.50, y: 0.05, width: 0.45, height: 0.90 }
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
