require 'rails_helper'

RSpec.feature "PollActivates", type: :feature do
  include Devise::Test::IntegrationHelpers
  
  describe "active poll visibility for student" do
    it "an active numeric poll should be visible" do
      c = FactoryBot.create(:course)
      q = FactoryBot.build(:numeric_question, :qname => "Q1", :course => c)
      c.questions << q
      q.save
      p = q.new_poll(:isopen => true, :round => 1)
      p.save

      student = FactoryBot.create(:student)
      c.students << student
      sign_in student
      visit course_path(c)
      expect(page.text).to match(/Q1/)
    end

    it "an active free response should be visible" do
      c = FactoryBot.create(:course)
      q = FactoryBot.build(:free_response_question, :qname => "Q1", :course => c)
      c.questions << q
      q.save
      p = q.new_poll(:isopen => true, :round => 1)
      p.save

      student = FactoryBot.create(:student)
      c.students << student
      sign_in student
      visit course_path(c)
      expect(page.text).to match(/Q1/)
    end

    it "an active multiple choice question should be visible" do
      c = FactoryBot.create(:course)
      q = FactoryBot.build(:multi_choice_question, :qname => "Q1", :qcontent => %w{one two three four}, :course => c)
      c.questions << q
      q.save
      p = q.new_poll(:isopen => true, :round => 1)
      p.save

      student = FactoryBot.create(:student)
      c.students << student
      sign_in student
      visit course_path(c)
      expect(page.text).to match(/Q1/)
    end

    it "no poll should be visible if none are active" do
      c = FactoryBot.create(:course)
      q = FactoryBot.build(:numeric_question, :qname => "Q1", :course => c)
      c.questions << q
      q.save
      p = q.new_poll(:isopen => false, :round => 1)
      p.save

      student = FactoryBot.create(:student)
      c.students << student
      sign_in student
      visit course_path(c)
      expect(page.text).to match(/no current/i)
    end      
  end
end
