FactoryGirl.define do
  factory :user do
  	sequence(:name) {|n| "Person #{n}"}
  	sequence(:email) {|n| "person_#{n}@site.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
    	admin true
    end
  end

  factory :property do
  	sequence(:name) {|n| "property #{n}"}
  	description "Lorem ipsum"
  	beds (1..5).to_a.sample
  	baths (1..3).to_a.sample
  	rent [500, 750, 1000, 1500].sample
  end
end