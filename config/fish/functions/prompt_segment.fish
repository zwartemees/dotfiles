function render_segment
        # args background color, text color, text
        echo -n (set_color $argv[1])""
	echo -n (set_color -b $argv[1] -o $argv[2])$argv[3]
	echo -n (set_color normal)(set_color $argv[1])"" 
	echo -n (set_color normal)" "
end

function render_final_segment_left
        # args background color, text color, text
        echo -n (set_color $argv[1])""
	echo -n (set_color -b $argv[1] -o $argv[2])$argv[3]
	echo -n (set_color normal)(set_color $argv[1])""
	echo -n (set_color normal) " "
end
