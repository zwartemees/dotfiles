source ~/.config/fish/functions/prompt_segment.fish

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      render_segment "#56949f" "#575279" 'N'
    case insert
      render_segment "#ebbcba" "#575279" 'I'
    case replace_one
      render_segment "#f6c177" "#575279" 'R'
    case visual
      render_segment "#9ccfd8" "#575279" 'V'
    case '*'
      render_segment "#eb6f92" "#575279" '?'
  end
end
