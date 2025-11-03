source ~/.config/fish/functions/prompt_segment.fish

function fish_prompt
    if test -n "$SSH_TTY"
        render_segment "#61AFEF" "#ABB2BF" (whoami)
		render_segment "#C678DD" "#ABB2BF" (prompt_hostname)
    end

    if test -n "$VIRTUAL_ENV"
        set parts (string split "/" "$VIRTUAL_ENV")
        render_segment "#98C379" "#ABB2BF" $parts[-1]
    end
	if test "$USER" != "mees"
		render_segment "#282C34" "#ABB2BF" "$USER"
	end
    
	if fish_is_root_user
         render_segment "#E06C75" "#ABB2BF" "root"
        end

	render_final_segment_left "#5C6370" "#ABB2BF" (prompt_pwd)
        set_color normal
end


