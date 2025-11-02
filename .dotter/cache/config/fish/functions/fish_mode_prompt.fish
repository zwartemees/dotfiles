source ~/.config/fish/functions/prompt_segment.fish

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      render_segment "#A6E3A1" "#FFFFFF" 'N'
    case insert
      render_segment "#89B4FA" "#FFFFFF" 'I'
    case replace_one
      render_segment "#F38BA8" "#FFFFFF" 'R'
    case visual
      render_segment "#F5C2E7" "#FFFFFF" 'V'
    case '*'
      render_segment "#F9E2AF" "#FFFFFF" '?'
  end
end
