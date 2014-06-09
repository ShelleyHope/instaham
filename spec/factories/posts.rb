include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :post do
    title "Apple"
    description  "fruit"
    picture { fixture_file_upload 'spec/images/Blue_diamond.png', 'image/png' }
  end
end