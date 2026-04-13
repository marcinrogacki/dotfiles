if initialize_session "0_root" "test"; then
    new_window "terminal"
fi
finalize_and_go_to_session
# if initialize_session "1_terminal"; then
#     new_window "terminal"
#     new_window "nvim"
#     select_window 0
# fi
# finalize_and_go_to_session
# if initialize_session "2_repo"; then
#     export ROY_CLI=true
#     export PROJECT=~/workspace/royaltiz/platform/repo
#     session_root ~/workspace/royaltiz/platform/repo
#     new_window "terminal"
#     new_window "nvim"
#     new_window "llm"
#     new_window "job"
#     new_window "logs"
#     new_window "db"
#     select_window 0
# fi
# finalize_and_go_to_session
