# Prompt configuration
PROMPT_LINES=2

# Function to count lines of a command
count_lines() {
  echo "$1" | wc -l
}

# Function to overwrite the previous prompt and command
overwrite_previous() {
  # Count the number of lines in the previous command
  local cmd_lines=$(count_lines "$1")

  # Calculate the total lines to move up (command lines + prompt lines)
  local total_lines=$((cmd_lines + PROMPT_LINES))

  # Move the cursor up and clear each line
  echo ${total_lines}
  for ((i = 0; i < total_lines; i++)); do
    print -n "\e[1A\e[K"
  done
}

# Function to be called just before executing a command
preexec_function() {
  overwrite_previous "$1"
  echo "$fg[blue]❯$reset_color $1"
}

# Function to be called just before showing the prompt
precmd_function() {
  # Empty placeholder, used to trigger the prompt refresh if needed
  :
}

# Register hooks for preexec and precmd
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_function
add-zsh-hook precmd precmd_function
