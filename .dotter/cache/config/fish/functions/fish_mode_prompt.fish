source ~/.config/fish/functions/prompt_segment.fish

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      render_segment "#a6e3a1" "#cdd6f4" 'N'
    case insert
      render_segment "#89b4fa" "#cdd6f4" 'I'
    case replace_one
      render_segment "#eba0ac" "#cdd6f4" 'R'
    case visual
      render_segment "#fab387" "#cdd6f4" 'V'
    case '*'
      render_segment "#f38ba8" "#cdd6f4" '?'
  end
end
