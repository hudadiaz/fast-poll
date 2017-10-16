module QuestionsHelper
  def build_option(choice, mcq)
    if mcq
      tag :input, type: 'checkbox', name: 'question[answer][]',
        value: choice.id, checked: current_user ? current_user.answered(choice) : false
    else
      tag :input, type: 'radio', name: 'question[answer]',
        value: choice.id, required: true, checked: current_user ? current_user.answered(choice) : false
    end
  end
end
