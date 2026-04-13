class FileAsset < ApplicationRecord
  belongs_to :file_type

  validates :file_name, :content_type, :size, :storage_path, presence: true
  validates :size, numericality: { greater_than: 0 }
end
