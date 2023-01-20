class HomeController < ApplicationController
  def index
    @q = Question.ransack(ransack_params)
    @q.sorts = "title desc" if @q.sorts.empty?
    @feed_questions = @q.result(distinct: true)
  end

  def ransack_params
    { topics_name_in: (params[:query] || current_user&.topic_list), published_true: 1 }
  end
end
