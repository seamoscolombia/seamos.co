FactoryGirl.define do
  factory :debate_vote do
    usuario {FactoryGirl.create(:usuario)}
    debate { FactoryGirl.create(:debate_with_questions)}
    question { debate.questions.last }
  end
end
