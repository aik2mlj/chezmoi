function cc-deepseek --description "Switch Claude Code to DeepSeek"
    if not set -q DEEPSEEK_API_KEY
        echo "✗ DEEPSEEK_API_KEY is not set"
        return 1
    end

    set -gx ANTHROPIC_BASE_URL "https://api.deepseek.com/anthropic"
    set -gx ANTHROPIC_AUTH_TOKEN $DEEPSEEK_API_KEY
    set -gx ANTHROPIC_MODEL "deepseek-v4-pro[1m]"
    set -gx ANTHROPIC_DEFAULT_OPUS_MODEL "deepseek-v4-pro[1m]"
    set -gx ANTHROPIC_DEFAULT_SONNET_MODEL "deepseek-v4-pro[1m]"
    set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL deepseek-v4-flash
    set -gx CLAUDE_CODE_SUBAGENT_MODEL deepseek-v4-flash
    set -gx CLAUDE_CODE_EFFORT_LEVEL max

    echo "✓ Switched to DeepSeek  (base: $ANTHROPIC_BASE_URL)"
end
