function render_segment
    # args background color, text color, text
    set bg (string sub -s 1 $argv[1])
    set fg (string sub -s 1 $argv[2])
    set text $argv[3]
    echo -n (set_color $bg)""
	echo -n (set_color $fg -b $bg)$text
	echo -n (set_color normal)(set_color $bg)"" 
	echo -n (set_color normal)" "
end

function render_final_segment_left
    # args background color, text color, text
    set bg (string sub -s 1 $argv[1])
    set fg (string sub -s 1 $argv[2])
    set text $argv[3]

    echo -n (set_color $bg)""
	echo -n (set_color $fg -b $bg)$text
	echo -n (set_color normal)(set_color $bg)""
	echo -n (set_color normal) " "
end
