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

  def build_progress(choice)
    "<div class='percentage bg-warning' style='width: #{choice.percentage}%'></div>".html_safe
  end

  def show_result? question
    current_user && current_user.answered(question) || current_user == question.user
  end
end
