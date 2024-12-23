return {
	"seblj/roslyn.nvim",
	ft = "cs",
	opts = {
		-- We set it like this because we use roslyn-ls from nvim
		exe = "Microsoft.CodeAnalysis.LanguageServer",
	},
}
