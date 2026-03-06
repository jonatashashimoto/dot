if not contains "$HOME/.turso" $PATH
    # Prepending path in case a system-installed binary needs to be overridden
    set -x PATH "$HOME/.turso" $PATH
end
