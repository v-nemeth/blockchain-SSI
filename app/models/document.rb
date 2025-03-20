class Document < ApplicationRecord
  has_one_attached :pdf

  after_save_commit :calculate_sha256, if: -> { pdf.attached? }

  private

  def calculate_sha256
    pdf.attachment.open do |tempfile|
      digest = Digest::SHA2.file(tempfile.path).hexdigest
      update_column(:sha256, digest)
    end
  end
end
