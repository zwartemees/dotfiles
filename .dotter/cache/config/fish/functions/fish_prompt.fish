source ~/.config/fish/functions/prompt_segment.fish

function fish_prompt
    if test -n "$SSH_TTY"
        render_segment "#ebbcba" "#575279" (whoami)
		render_segment "#c4a7e7" "#575279" (prompt_hostname)
    end

    if test -n "$VIRTUAL_ENV"
        set parts (string split "/" "$VIRTUAL_ENV")
        render_segment "#ebbcba" "#575279" $parts[-1]
    end
	if test "$USER" != "mees"
		render_segment "#ebbcba" "#575279" "$USER"
	end
    
	if fish_is_root_user
         render_segment "#f6c177" "#575279" "root"
        end

	render_final_segment_left "#ebbcba" "#575279" (prompt_pwd)
        set_color normal
end


