FactoryGirl.define do
    factory :user do
        id 1
        email "aabsdfb@hh.de1212312"
        password "12345678"
        first_name "Xinran"
        last_name "Guo"
    end
    
    factory :admin do
        email "xguo@berkeley.edu"
        password "12345678"
        first_name "Gary"
        last_name "Guo"
    end

    factory :task do
        id 1
        title 'Midterm1'
        course 'CS164'
        kind 'Exam'
        release '4/Mar/2015 23:59:00 -0800'
        due '6/Mar/2015 23:59:00 -0800'
        status 'New'
        user_id 1
        rate 3
    end

    factory :subtask do
        id 1
        description 'how to create a model'
        is_done false
        task nil
    end    

end
