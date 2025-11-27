source ~/.config/fish/functions/prompt_segment.fish

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      render_segment "#a6e3a1" "#1e1e2e" 'N'
    case insert
      render_segment "#89b4fa" "#1e1e2e" 'I'
    case replace_one
      render_segment "#eba0ac" "#1e1e2e" 'R'
    case visual
      render_segment "#fab387" "#1e1e2e" 'V'
    case '*'
      render_segment "#f38ba8" "#1e1e2e" '?'
  end
end
