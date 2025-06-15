# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      task = Task.new(
        title: "Learn Figma",
        description: "Practice UI design",
        completed: false
      )
      expect(task).to be_valid
    end

    it "is invalid without a title" do
      task = Task.new(
        title: nil,
        description: "No title",
        completed: false
      )
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it "allows completed to be true or false" do
      task_true = Task.new(title: "Task 1", completed: true)
      task_false = Task.new(title: "Task 2", completed: false)
      expect(task_true).to be_valid
      expect(task_false).to be_valid
    end
  end
end
