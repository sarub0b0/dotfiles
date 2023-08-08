-- ------------------------------------------------
-- プロジェクト固有の設定をロードする
-- ------------------------------------------------

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
	pattern = { '*' },
	callback = function()
		if vim.fn.filereadable('.vimrc.local') == 1 then
			vim.cmd.source('.vimrc.local')
		end
	end,
	group = vim.g.augroup_names.my_filetypes
})
