module CommentsHelper
    def comment_custom_path(comment,entity,question)
        if comment.commentable_type == 'Question'
            question_comment_path(entity.published_token,comment)
        elsif comment.commentable_type == 'Answer'
            question_answer_comment_path(question.published_token,entity.id,comment)
        end 
    end

end
