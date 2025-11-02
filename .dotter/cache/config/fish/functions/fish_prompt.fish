source ~/.config/fish/functions/prompt_segment.fish

function fish_prompt
    if test -n "$SSH_TTY"
        render_segment "#89B4FA" "#FFFFFF" (whoami)
		render_segment "#F5C2E7" "#FFFFFF" (prompt_hostname)
    end

    if test -n "$VIRTUAL_ENV"
        set parts (string split "/" "$VIRTUAL_ENV")
        render_segment "#A6E3A1" "#FFFFFF" $parts[-1]
    end
	if test "$USER" != "mees"
		render_segment "#CDD6F4" "#FFFFFF" "$USER"
	end
    
	if fish_is_root_user
         render_segment "#F38BA8" "#FFFFFF" "root"
        end

	render_final_segment_left "#BAC2DE" "#FFFFFF" (prompt_pwd)
        set_color normal
end


