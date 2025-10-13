source ~/.config/fish/functions/prompt_segment.fish

function fish_prompt
    if test -n "$SSH_TTY"
        render_segment blue black (whoami)
		render_segment blue black (prompt_hostname)
    end

    if test -n "$VIRTUAL_ENV"
        set parts (string split "/" "$VIRTUAL_ENV")
        render_segment cyan black $parts[-1]
    end
	if test "$USER" != "mees"
		render_segment blue black "$USER"
	end
    
	if fish_is_root_user
         render_segment red black "root"
        end

	render_final_segment_left blue black (prompt_pwd)
        set_color normal
end


