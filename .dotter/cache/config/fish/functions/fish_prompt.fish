source ~/.config/fish/functions/prompt_segment.fish

function fish_prompt
    if test -n "$SSH_TTY"
        render_segment "#89b4fa" "#1e1e2e" (whoami)
		render_segment "#89dceb" "#1e1e2e" (prompt_hostname)
    end

    if test -n "$VIRTUAL_ENV"
        set parts (string split "/" "$VIRTUAL_ENV")
        render_segment "#fab387" "#1e1e2e" $parts[-1]
    end
	if test "$USER" != "mees"
		render_segment "#89b4fa" "#1e1e2e" "$USER"
	end
    
	if fish_is_root_user
         render_segment "#eba0ac" "#1e1e2e" "root"
        end

	render_final_segment_left "#89b4fa" "#1e1e2e" (prompt_pwd)
        set_color normal
end


