module QuestionsHelper
  def build_option(choice, mcq)
    if mcq
      tag :input, type: 'checkbox', name: 'question[answer][]',
        value: choice.id, class: 'custom-control-input'
    else
      tag :input, type: 'radio', name: 'question[answer]',
        value: choice.id, class: 'custom-control-input', required: true
    end
  end
  
  def show_result? question
    current_user == question.user ||
    question.expired? ||
    current_user.present? && current_user.answered?(question)
  end

  def expiry_at_options
    []
  end
end
