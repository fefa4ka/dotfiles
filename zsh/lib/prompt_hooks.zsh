# Prompt configuration
PROMPT_LINES=2
typeset -g _LAST_COMMAND=""
typeset -gi _LAST_COMMAND_LINES=0

# Function to count lines of a command more accurately
count_lines() {
  if [[ -z "$1" ]]; then
    echo 0
    return
  fi
  # Count visible lines (handling wrapped lines correctly)
  local term_width=$(tput cols)
  local count=0
  local IFS=$'\n'
  for line in ${(f)1}; do
    # Calculate how many terminal lines this will take
    local line_length=${#line}
    local line_count=$(( (line_length + term_width - 1) / term_width ))
    # Ensure at least 1 line per actual line
    (( line_count = line_count > 0 ? line_count : 1 ))
    (( count += line_count ))
  done
  echo $count
}

# Function to overwrite the previous prompt and command
overwrite_previous() {
  # Safety check for empty input
  if [[ -z "$1" ]]; then
    return
  fi

  # Count the number of lines in the previous command
  local cmd_lines=$(count_lines "$1")
  
  # Store for potential recovery
  _LAST_COMMAND="$1"
  _LAST_COMMAND_LINES=$cmd_lines

  # Calculate the total lines to move up (command lines + prompt lines)
  local total_lines=$((cmd_lines + PROMPT_LINES))

  # Safety check to avoid excessive cursor movement
  if (( total_lines > 50 )); then
    total_lines=50
  fi

  # Move the cursor up and clear each line
  for ((i = 0; i < total_lines; i++)); do
    print -n "\e[1A\e[K"
  done
}

# Function to be called just before executing a command
preexec_function() {
  # Trim trailing newlines for consistent behavior
  local cmd="${1%"${1##*[![:space:]]}"}"
  
  # Skip empty commands
  if [[ -z "$cmd" ]]; then
    return
  fi
  
  # Try to overwrite previous prompt, with error handling
  {
    overwrite_previous "$cmd"
    echo "$fg[blue]❯$reset_color $cmd"
  } 2>/dev/null || {
    # If something goes wrong, just print the command normally
    echo "$fg[blue]❯$reset_color $cmd"
  }
}

# Function to be called just before showing the prompt
precmd_function() {
  # Reset terminal if needed (for recovery from errors)
  if [[ -n "$_LAST_COMMAND" && $_LAST_COMMAND_LINES -gt 50 ]]; then
    # For very long commands, we might need to reset the terminal state
    tput sgr0
  fi
  
  # Clear the stored command after it's been processed
  _LAST_COMMAND=""
  _LAST_COMMAND_LINES=0
}

# Register hooks for preexec and precmd
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_function
add-zsh-hook precmd precmd_function
