function llm-status --description "Show current Claude Code provider"
    echo "BASE_URL   : "(set -q ANTHROPIC_BASE_URL && echo $ANTHROPIC_BASE_URL || echo "(default Anthropic)")
    echo "MODEL      : "(set -q ANTHROPIC_MODEL && echo $ANTHROPIC_MODEL || echo "(claude default)")
    echo "OPUS MODEL : "(set -q ANTHROPIC_DEFAULT_OPUS_MODEL && echo $ANTHROPIC_DEFAULT_OPUS_MODEL || echo "(claude default)")
    echo "SONNET MDL : "(set -q ANTHROPIC_DEFAULT_SONNET_MODEL && echo $ANTHROPIC_DEFAULT_SONNET_MODEL || echo "(claude default)")
    echo "HAIKU MDL  : "(set -q ANTHROPIC_DEFAULT_HAIKU_MODEL && echo $ANTHROPIC_DEFAULT_HAIKU_MODEL || echo "(claude default)")
    echo "SUBAGENT   : "(set -q CLAUDE_CODE_SUBAGENT_MODEL && echo $CLAUDE_CODE_SUBAGENT_MODEL || echo "(claude default)")
    echo "EFFORT     : "(set -q CLAUDE_CODE_EFFORT_LEVEL && echo $CLAUDE_CODE_EFFORT_LEVEL || echo "(claude default)")

    if set -q ANTHROPIC_BASE_URL && string match -q "*deepseek*" $ANTHROPIC_BASE_URL
        echo "→ Active provider: DeepSeek"
    else
        echo "→ Active provider: Anthropic (subscription)"
    end
end
