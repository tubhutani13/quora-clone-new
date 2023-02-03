class HomeController < ApplicationController
  def index
    @topics = Topic.all
    @q = Question.published_questions.ransack(ransack_params)
    @q.sorts = "title desc" if @q.sorts.empty?
    @feed_questions = @q.result(distinct: true)
  end

  def ransack_params
    { topics_name_in: (params[:query] || current_user&.topic_list)}
  end
end
