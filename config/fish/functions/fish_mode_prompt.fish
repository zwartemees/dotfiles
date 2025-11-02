source ~/.config/fish/functions/prompt_segment.fish

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      render_segment "{{prompt_normal_mode}}" "{{foreground_text}}" 'N'
    case insert
      render_segment "{{prompt_insert_mode}}" "{{foreground_text}}" 'I'
    case replace_one
      render_segment "{{prompt_replacement_mode}}" "{{foreground_text}}" 'R'
    case visual
      render_segment "{{prompt_visual_mode}}" "{{foreground_text}}" 'V'
    case '*'
      render_segment "{{prompt_unknown_mode}}" "{{foreground_text}}" '?'
  end
end
