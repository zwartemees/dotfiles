source ~/.config/fish/functions/prompt_segment.fish

function fish_prompt
    if test -n "$SSH_TTY"
        render_segment "{{prompt_ssh_user}}" "{{foreground_text}}" (whoami)
		render_segment "{{prompt_ssh_host}}" "{{foreground_text}}" (prompt_hostname)
    end

    if test -n "$VIRTUAL_ENV"
        set parts (string split "/" "$VIRTUAL_ENV")
        render_segment "{{prompt_venv}}" "{{foreground_text}}" $parts[-1]
    end
	if test "$USER" != "mees"
		render_segment "{{prompt_user}}" "{{foreground_text}}" "$USER"
	end
    
	if fish_is_root_user
         render_segment "{{prompt_root}}" "{{foreground_text}}" "root"
        end

	render_final_segment_left "{{prompt_pwd}}" "{{foreground_text}}" (prompt_pwd)
        set_color normal
end


