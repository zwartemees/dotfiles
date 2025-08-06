alias close-window "~/dotfiles/niri/scripts/close.sh" 
if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    echo " "
    echo " Welcome $(whoami) you have logged in at $hostname"
    echo " Today it's $(date "+%A, %B %eXX"  | sed -e 's/11XX/11th/' -e 's/12XX/12th/' -e 's/13XX/13th/' -e 's/1XX/1st/' -e ' s/2XX/2nd/' -e 's/3XX/3rd/' -e 's/XX/th/'). It's curently $(get_time)"
    echo " "
end

function get_time
    set -f min_number (date '+%-M')
    set -f hour_number (date '+%-I')
    set hour_name (get_hour_name $hour_number)
    set next_hour_name (get_hour_name (math "$hour_number +1"))

    if test $min_number -lt 2.5
        echo -n $hour_name o\'clock
    else if test $min_number -lt 7.5
        echo -n five past $hour_name
    else if test $min_number -lt 12.5
        echo -n ten past $hour_name
    else if test $min_number -lt 17.5
        echo -n a quarter past $hour_name
    else if test $min_number -lt 22.5
        echo -n twenty past $hour_name
    else if test $min_number -lt 27.5
        echo -n twenty-five past $hour_name
    else if test $min_number -lt 32.5
        echo -n half past $hour_name
    else if test $min_number -lt 37.5
        echo -n twenty-five to $next_hour_name
    else if test $min_number -lt 42.5
        echo -n twenty to $next_hour_name
    else if test $min_number -lt 47.5
        echo -n a quarter to $next_hour_name
    else if test $min_number -lt 52.5
        echo -n ten to $next_hour_name
    else if test $min_number -lt 57.5
        echo -n five to $next_hour_name
    else
        echo -n $next_hour_name o\'clock
    end
end

function get_hour_name
    #input hour as time between 1 and 12
    switch $argv[1]
        case 1
            echo one
        case 2
            echo two
        case 3
            echo three
        case 4
            echo four
        case 5
            echo five
        case 6
            echo six
        case 7
            echo seven
        case 8
            echo eight
        case 9
            echo nine
        case 10
            echo ten
        case 11
            echo eleven
        case '*'
            echo twelve
    end
end

zoxide init fish | source
