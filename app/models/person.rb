class Person < ApplicationRecord
  default_scope { order(created_at: :desc) }
  scope :incomplete, -> { where("completed IS NULL or completed = ?", false)}
  scope :completed, -> { where(completed: true)}

  mount_uploader :document, DocumentUploader
  serialize :avatars, JSON

  def self.search(search)
    if search
      person = Person.find_by(first_name: search)
      if person
        self.where(id: person)
      else
        Person.all
      end
    else
      Person.all
    end
  end

end
