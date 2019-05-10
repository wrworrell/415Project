FactoryBot.define do
  sequence :email do |i|
    "student#{i}@colgate.edu"
  end

  factory :user, aliases: [:student] do
    email { generate(:email) }
    password { "password"} 
    admin { false }
    password_confirmation { "password" }
  end

  factory :admin, class: User do
    email { "jsommers@colgate.edu" }
    password { "password"} 
    admin { true }
    password_confirmation { "password" }
  end

  factory :course do
    name { "A Course" }
    daytime { "TR 8:30-9:55" }

    transient do
      student_count { 10 }
    end

    after(:create) do |course, evaluator|
      create_list(:student, evaluator.student_count, courses: [course])
      course.questions.create(attributes_for(:question)) do |quest|
        quest.type = 'NumericQuestion'
      end
    end
  end

  factory :free_response_question do
    qname { "Gimme a free response" }
    type { "FreeResponseQuestion" }
    qcontent { "" }
    course
  end

  factory :numeric_question do
    qname { "Gimme a number" }
    type { "NumericQuestion" }
    qcontent { "" }
    course
  end

  factory :multi_choice_question do
    qname { "Choose an option" }
    type { "MultiChoiceQuestion" }
    qcontent { ['opt1', 'opt2', 'opt3']}
    course
  end

  sequence :responsenum do 
    rand * 10
  end

  factory :numeric_poll_response do
    type { "NumericPollResponse" }
    response { generate(:responsenum) }
    numeric_question
  end

  factory :multi_choice_poll_response do
    type { "MultiChoicePollResponse" }
    multi_choice_question
    response { 2 }
  end

  factory :free_response_poll_response do
    type { "FreeResponsePollResponse" }
    free_response_question
    response { "random text" }
  end
end