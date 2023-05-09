vim.api.nvim_create_user_command("Gcom", function()
    vim.cmd("silent! Gwrite");
    vim.cmd.Git('commit');
end, {});

