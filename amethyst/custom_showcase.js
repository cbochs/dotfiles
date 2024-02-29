function layout() {
    return {
        name: "CustomShowcaseNeovim",
        initialState: {},
        commands: {},
        getFrameAssignments: (windows, screenFrame, state) => {
            const PRIMARY_SLOTS = [
                { x: 0.20, y: 0.10, width: 0.60, height: 0.30 },
            ]
            let slots = [...PRIMARY_SLOTS]

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
