# Define global variables for handling the command and its output
typeset -g last_command_output=""
typeset -g last_command=""
typeset -g stdout_tmp=""
typeset -g stderr_tmp=""
# Hook function to be run before every command
#
function preexec() {
  last_command="$1"
  last_command_output=$(mktemp /tmp/zsh-llm-resolver.XXXXX)
  exec 3>&2
  export CLICOLOR_FORCE=1
  exec 2> >(tee "$last_command_output" >&2)
}

function ask_yes_no() {
    local prompt="$1"
    local default="n"
    local response
    local timeout=5

    # Print the prompt with options
    echo -n "${prompt} (y/n, default is ${default}): "

    # Use read with a timeout
    read -t $timeout response
    
    # Check if the user input is empty (timed out)
    if [ -z "$response" ]; then
        response=${default}
    fi

    # Validate the response
    while [[ ! "$response" =~ ^[yYnN]$ ]]; do
        echo "Invalid input. Please enter 'y' or 'n' (default is ${default}): "
        read response
        # if input is empty, set to default
        if [ -z "$response" ]; then
            response=${default}
            break
        fi
    done

    # Return the response in a lowercase format
    [ "$response" = "y" ] && return 0 || return 1 
}

function ask_ai_prompt() {
 ask_yes_no "Ask AI?" && ai_ask
}

function get_os_info() {
    OS="$(uname)"
    
    case $OS in
        "Linux")
            # Check for the existence of /etc/os-release
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                echo "Linux. $NAME $VERSION_ID"
            elif [ -f /etc/lsb-release ]; then
                . /etc/lsb-release
                echo "Linux. $DISTRIB_ID $DISTRIB_RELEASE"
            elif [ -f /etc/redhat-release ]; then
                echo "Linux. $(cat /etc/redhat-release | cut -d' ' -f1,3)"
            else
                echo "Linux. Unknown Distribution"
            fi
            ;;
        "Darwin")
            OS_VERSION=$(sw_vers -productVersion)
            echo "macOS ver. $OS_VERSION"
            ;;
        *)
            echo "Unknown Operating System"
            ;;
    esac
}

last_3_commands() {
    history | tail -n 3 | sed 's/^[ ]*[0-9]*[ ]*//'
}

function ai_ask() {
    # Read the output from the temporary file
    local output=$(<"$last_command_output")

    ai_request="I'm trying to run \`${last_command}\` on $(get_os_info) and faced with issue: 
\`\`\`
${output}
\`\`\`

Context:
* PWD = \`${PWD}\`

Please help with resolving. Write answer briefly with only important details, don't repeat question."
    ai_response=$(mktemp /tmp/zsh-llm-resolver.XXXXX)
    ai --model "gpt-4o" "${ai_request}" > ${ai_response}
    glow ${ai_response}
    rm ${ai_response}
    # Your custom code here...
}

function ask_ai_prompt() {
 ask_yes_no "Ask AI?" && ai_ask
}
# Hook function to be run before the prompt is redisplayed
function precmd() {
  # Check the exit status of the last command
  local exit_status=$?
# Close file descriptors
# exec 1>&3 2>&4
  if [ -e /proc/$$/fd/3 ]; then
    exec 2>&3
    exec 3>&-
  fi

  if (( exit_status != 0 && exit_status != 130 )); then
   # local output=$(<"$last_command_output")
   # echo $output
    
	ask_ai_prompt
  fi

  # Clean up the temporary file
  if [ -e $last_command_output ]; then
    rm -f "$last_command_output"
  fi
}

# Register the hooks
