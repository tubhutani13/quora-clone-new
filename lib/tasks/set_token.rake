namespace :question do
    desc "Question"
    task create_token: :environment do
        Question.all.each do |question|
            if question.published_token.nil?
                question.generate_token(:published_token)
                question.save(:validate => false)
            end
        end
        p "done"
    end
end
