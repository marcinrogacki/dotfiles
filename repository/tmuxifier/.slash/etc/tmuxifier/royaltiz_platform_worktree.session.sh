#if initialize_session "0_root"; then
#    load_window "terminal"
#fi
if initialize_session "1_terminal"; then
    load_window "terminal"
    load_window "nvim"
    select_window 0
fi
#if initialize_session "2_worktree"; then
#    export ROY_CLI=true
#    export PROJECT=~/workspace/royaltiz/platform/worktree
#    session_root ~/workspace/royaltiz/platform/worktree
#    load_window "terminal"
#    load_window "nvim"
#    load_window "llm"
#    new_window "job"
#    new_window "logs"
#    new_window "db"
#    select_window 0
#fi
finalize_and_go_to_session
