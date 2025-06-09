source ~/.config/fish/functions/prompt_segment.fish

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      render_segment red brblack 'N'
    case insert
      render_segment green brblack 'I'
    case replace_one
      render_segment green brblack 'R'
    case visual
      render_segment brmagenta brblack 'V'
    case '*'
      render_segment red brblack '?'
  end
end
