class FileAsset < ApplicationRecord
  belongs_to :file_type

  validates :original_file_name, :mime_type, :size_bytes, :storage_path_or_url, presence: true
  validates :size_bytes, numericality: { greater_than: 0 }
end
