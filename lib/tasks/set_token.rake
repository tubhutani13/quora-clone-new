namespace :question do
  desc "Question"
  task create_token: :environment do
    Question.all.each do |question|
      if question.permalink.nil?
        question.generate_token(:permalink)
        question.save(:validate => false)
      end
    end
    p "done"
  end
end
