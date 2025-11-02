# SSH agent setup for Fish shell
if test -z "$SSH_AUTH_SOCK"
    # Check if ssh-agent is already running
    set -l ssh_agent_pid_file "$HOME/.ssh-agent-pid"
    
    if test -f $ssh_agent_pid_file
        source $ssh_agent_pid_file > /dev/null 2>&1
    end
    
    # Verify the agent is actually running
    if not ps -p $SSH_AGENT_PID > /dev/null 2>&1
        # Start a new agent
        eval (ssh-agent -c) > /dev/null
        echo "set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK; set -x SSH_AGENT_PID $SSH_AGENT_PID;" > $ssh_agent_pid_file
    end
end

# Automatically add SSH keys if not already added
if test -n "$SSH_AUTH_SOCK"
    if not ssh-add -l > /dev/null 2>&1
        # No keys loaded, add default key silently
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
    end
end
