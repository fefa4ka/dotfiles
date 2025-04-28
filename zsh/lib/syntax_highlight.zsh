# Simple syntax highlighting function for ZSH
# This provides basic highlighting similar to zsh-syntax-highlighting

highlight_command() {
  local cmd="$1"
  local highlighted=""
  
  # Keywords to highlight
  local keywords=("if" "then" "else" "elif" "fi" "for" "while" "do" "done" "case" "esac" "function" "in" "select" "until" "repeat" "time" "coproc")
  local keyword_color="$fg[yellow]"
  
  # Commands/executables to highlight
  local commands_color="$fg[green]"
  
  # Options (starting with - or --) to highlight
  local options_color="$fg[blue]"
  
  # Strings to highlight
  local string_color="$fg[red]"
  
  # Variables to highlight
  local variable_color="$fg[cyan]"
  
  # Pipe and redirection operators
  local operator_color="$fg[magenta]"
  local operators=("|" ">" ">>" "<" "<<" "&&" "||" ";")
  
  # Split the command into words
  local words=("${(z)cmd}")
  local in_string=0
  local string_char=""
  
  # Process each word
  for word in $words; do
    # Check if it's a keyword
    if (( ${keywords[(I)$word]} )); then
      highlighted+="${keyword_color}${word}${reset_color} "
    # Check if it's the first word (command) or looks like a command
    elif [[ $word == $words[1] || $word == "sudo" || $word =~ ^[a-zA-Z0-9_\-]+$ && ! $word =~ ^[0-9]+$ ]]; then
      highlighted+="${commands_color}${word}${reset_color} "
    # Check if it's an option
    elif [[ $word == -* ]]; then
      highlighted+="${options_color}${word}${reset_color} "
    # Check if it's an operator
    elif (( ${operators[(I)$word]} )); then
      highlighted+="${operator_color}${word}${reset_color} "
    # Check if it contains a variable
    elif [[ $word == *\$* ]]; then
      # Simple variable highlighting - not perfect but gives the idea
      local processed_word=""
      local i=0
      while (( i < ${#word} )); do
        local char="${word:$i:1}"
        local next_char="${word:$i+1:1}"
        
        if [[ $char == '$' && $next_char == '{' ]]; then
          # Find the closing brace
          local var_start=$i
          local j=$((i+2))
          while (( j < ${#word} )) && [[ "${word:$j:1}" != "}" ]]; do
            ((j++))
          done
          
          if (( j < ${#word} )); then
            processed_word+="${variable_color}${word:$var_start:$j-$var_start+1}${reset_color}"
            i=$((j+1))
          else
            processed_word+="$char"
            ((i++))
          fi
        elif [[ $char == '$' && $next_char =~ [a-zA-Z0-9_] ]]; then
          # Find the end of the variable name
          local var_start=$i
          local j=$((i+1))
          while (( j < ${#word} )) && [[ "${word:$j:1}" =~ [a-zA-Z0-9_] ]]; do
            ((j++))
          done
          
          processed_word+="${variable_color}${word:$var_start:$j-$var_start}${reset_color}"
          i=$j
        else
          processed_word+="$char"
          ((i++))
        fi
      done
      
      highlighted+="$processed_word "
    # Check if it's a string
    elif [[ $word == \"*\" || $word == \'*\' ]]; then
      highlighted+="${string_color}${word}${reset_color} "
    else
      highlighted+="$word "
    fi
  done
  
  echo "${highlighted% }"  # Remove trailing space
}
