local options = {

	-- the key mapping will mess up with other plugins
	-- check [here](https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/986)

	prompts = {
		ExplainZh = {
			prompt = "为所选代码撰写解释说明，采用段落形式的文本描述.",
			system_prompt = "COPILOT_EXPLAIN",
		},
		ReviewZh = {
			prompt = "审查所选代码",
			system_prompt = "COPILOT_REVIEW",
		},
		FixZh = {
			prompt = "这段代码存在问题，找出问题所在，并在修复的基础上重写代码。解释出错的地方以及你的修改是如何解决这些问题的。",
		},
		OptimizeZh = {
			prompt = "优化所选代码以提升性能和可读性。解释你的优化策略以及你所做更改的好处。",
		},
		DocsZh = {
			prompt = "为所选代码添加文档注释。",
		},
		Tests = {
			prompt = "请为我的代码生成测试用例。",
		},
		Commit = {
			prompt = "请按照 commitizen 规范为该更改编写提交信息。请确保标题不超过 50 个字符，并在 72 个字符处换行格式化，格式采用 gitcommit 代码块",
			context = "git:staged",
		},
	},
}

return options
