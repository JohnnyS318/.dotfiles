local handlers = require('gobidev.lsp.handlers')

local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then return end

null_ls.setup {
    on_attach = handlers.on_attach,
    sources = {
        null_ls.builtins.code_actions.gitsigns, -- Code actions for git
        null_ls.builtins.code_actions.shellcheck, -- Code actions to disable shellcheck warnings

        null_ls.builtins.diagnostics.actionlint, -- GitHub Actions workflow
        null_ls.builtins.diagnostics.gitlint.with {
            extra_args = { '--ignore', 'body-is-missing' },
        }, -- Commit messages
        null_ls.builtins.diagnostics.markdownlint, -- Markdown files
        null_ls.builtins.diagnostics.todo_comments, -- Warn at TODO commments
        null_ls.builtins.diagnostics.trail_space, -- Warn at trailing spaces
        null_ls.builtins.diagnostics.zsh, -- Very basic zsh linting

        null_ls.builtins.formatting.blue, -- Better python formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with(require('gobidev.lsp.prettier')),
        null_ls.builtins.formatting.shfmt.with {
            -- Does not support zsh specific things, but enable it anyway
            extra_filetypes = { 'bash', 'zsh' },
            extra_args = { '--indent', '4', '--binary-next-line', '--case-indent', '--space-redirects' },
        }, -- Shell scripts
        null_ls.builtins.formatting.trim_newlines, -- Trim trailing newlines
        null_ls.builtins.formatting.trim_whitespace, -- Trim trailing whitespace

        null_ls.builtins.hover.printenv, -- Show value of env variable
    },
}
