source ~/.config/fish/functions/prompt_segment.fish

function fish_prompt
    if test -n "$SSH_TTY"
        render_segment "#89b4fa" "#cdd6f4" (whoami)
		render_segment "#89dceb" "#cdd6f4" (prompt_hostname)
    end

    if test -n "$VIRTUAL_ENV"
        set parts (string split "/" "$VIRTUAL_ENV")
        render_segment "#fab387" "#cdd6f4" $parts[-1]
    end
	if test "$USER" != "mees"
		render_segment "#89b4fa" "#cdd6f4" "$USER"
	end
    
	if fish_is_root_user
         render_segment "#eba0ac" "#cdd6f4" "root"
        end

	render_final_segment_left "#89b4fa" "#cdd6f4" (prompt_pwd)
        set_color normal
end


