class Person < ApplicationRecord
  default_scope { order(created_at: :desc) }
  scope :incomplete, -> { where("completed IS NULL or completed = ?", false)}
  scope :completed, -> { where(completed: true)}

  mount_uploader :document, DocumentUploader
  serialize :avatars, JSON

  def self.search(term)
    if term
      where('first_name LIKE ?', "%#{term}%")
    else
      all
    end
  end

end
