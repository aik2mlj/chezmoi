function deepclaude --description "Use DeepSeek in Claude Code"
    if not set -q DEEPSEEK_API_KEY
        echo "✗ DEEPSEEK_API_KEY is not set"
        return 1
    end

    set -x ANTHROPIC_BASE_URL "https://api.deepseek.com/anthropic"
    set -x ANTHROPIC_AUTH_TOKEN $DEEPSEEK_API_KEY
    set -x ANTHROPIC_MODEL "deepseek-v4-pro[1m]"
    set -x ANTHROPIC_DEFAULT_OPUS_MODEL "deepseek-v4-pro[1m]"
    set -x ANTHROPIC_DEFAULT_SONNET_MODEL "deepseek-v4-pro[1m]"
    set -x ANTHROPIC_DEFAULT_HAIKU_MODEL deepseek-v4-flash
    set -x CLAUDE_CODE_SUBAGENT_MODEL deepseek-v4-flash
    set -x CLAUDE_CODE_EFFORT_LEVEL max

    claude $argv
end
