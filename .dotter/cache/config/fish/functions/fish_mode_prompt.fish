source ~/.config/fish/functions/prompt_segment.fish

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      render_segment "#98C379" "#ABB2BF" 'N'
    case insert
      render_segment "#61AFEF" "#ABB2BF" 'I'
    case replace_one
      render_segment "#E06C75" "#ABB2BF" 'R'
    case visual
      render_segment "#C678DD" "#ABB2BF" 'V'
    case '*'
      render_segment "#E5C07B" "#ABB2BF" '?'
  end
end
