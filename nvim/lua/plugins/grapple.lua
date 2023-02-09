return {
    "cbochs/grapple.nvim",
    keys = {
        { "<leader>m", "<cmd>GrappleToggle<cr>", desc = "Grapple toggle tag" },
        { "<leader>k", "<cmd>GrapplePopup tags<cr>", desc = "Grapple popup tags" },
        { "<leader>j", "<cmd>GrappleCycle forward<cr>", desc = "Grapple cycle forward" },
        { "<leader>J", "<cmd>GrappleCycle backward<cr>", desc = "Grapple cycle backward" },
    },
    config = true,
}
