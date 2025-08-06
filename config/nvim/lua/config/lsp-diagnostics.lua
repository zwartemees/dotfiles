-- Default configuration
require("tiny-inline-diagnostic").setup({
    preset = "modern",
    transparent_bg = false,
    transparent_cursorline = true,
    hi = {
        error = "DiagnosticError", -- Highlight group for error messages
        warn = "DiagnosticWarn", -- Highlight group for warning messages
        info = "DiagnosticInfo", -- Highlight group for informational messages
        hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
        arrow = "NonText", -- Highlight group for diagnostic arrows
        background = "None",
        mixing_color = "None",
    },

    options = {
	show_source = {
	    enabled = false,
	    if_many = false,
	},
        use_icons_from_diagnostic = false,
        set_arrow_to_diag_color = true,
        add_messages = true,
        throttle = 0,
        softwrap = 30,
        multilines = {
            enabled = false,
            always_show = false,
        },
        show_all_diags_on_cursorline = false,
        enable_on_insert = true,
        enable_on_select = true,
        overflow = {
            mode = "wrap",
            padding = 0,
        },

        break_line = {
            enabled = false,
            after = 30,
        },
        format = nil,
        virt_texts = {
            priority = 2048,
        },
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },
        overwrite_events = nil,
    },
    disabled_ft = {}
})
