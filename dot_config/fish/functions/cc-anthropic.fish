function cc-anthropic --description "Switch Claude Code to Anthropic (subscription/OAuth)"
    set -e ANTHROPIC_BASE_URL
    set -e ANTHROPIC_AUTH_TOKEN
    set -e ANTHROPIC_MODEL
    set -e ANTHROPIC_DEFAULT_OPUS_MODEL
    set -e ANTHROPIC_DEFAULT_SONNET_MODEL
    set -e ANTHROPIC_DEFAULT_HAIKU_MODEL
    set -e CLAUDE_CODE_SUBAGENT_MODEL
    set -e CLAUDE_CODE_EFFORT_LEVEL

    echo "✓ Switched to Anthropic (subscription / OAuth)"
end
