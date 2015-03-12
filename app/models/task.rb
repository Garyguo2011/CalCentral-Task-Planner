class MyValidator < ActiveModel::Validator
  def validate(record)
    unless record.due > record.release
      record.errors[:Due] << 'date must be after the Release date!'
    end
  end
end
class Task < ActiveRecord::Base
  attr_accessible :due, :status, :title, :course, :kind, :release, :user_id
  belongs_to :user
  has_many :subtasks
  validates :title, :presence => true
  validates :status, :presence => true
  validates :due, :presence => true
  validates :kind, :presence => true
  validates :course, :presence => true
  validates_with MyValidator
  def self.all_kinds
    ["Project", "Homework", "Paper", "Exam", "Other"]
  end
end
