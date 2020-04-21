class Record < ApplicationRecord
  has_and_belongs_to_many :hostnames
  accepts_nested_attributes_for :hostnames

  validates :ip, presence: true, uniqueness: true

  before_save :find_or_create_hostname

  private

  def find_or_create_hostname
    self.hostnames = self.hostnames.map do |hostname|
      Hostname.find_or_create_by(name: hostname.name)
    end
  end
end
