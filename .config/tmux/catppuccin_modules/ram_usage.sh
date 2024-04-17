show_ram_usage() {
  local index=$1
  local icon="$(get_tmux_option "@catppuccin_test_icon" "󰊚 ")"
  local color="$(get_tmux_option "@catppuccin_test_color" "$thm_green")"
  local text="$(get_tmux_option "@catppuccin_test_text" "#(/usr/local/bin/tmux-mem --format '[:spark] :percent')")"
  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
