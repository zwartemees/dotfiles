function render_segment
        # args background color, text color, text
        echo -n (set_color $argv[1])""(set_color -b $argv[1] -o $argv[2])$argv[3](set_color normal)(set_color $argv[1])"" (set_color normal)
end
