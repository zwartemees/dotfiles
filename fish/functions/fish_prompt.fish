function fish_prompt
        if test -n "$SSH_TTY"
                echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
        end
    
	  	render_segment blue black test
        set_color -o
        if fish_is_root_user
                echo -n (set_color red)'# '
        end
        echo -n (set_color red)'❯'(set_color yellow)'❯' #(set_color green)'❯ '
        set_color normal
end

function render_segment
	# args background color, text color, text
	echo -n (set_color $argv[1])""(set_color -b $argv[1] -o $argv[2])$argv[3](set_color normal)(set_color $argv[1])"" (set_color normal)
end
