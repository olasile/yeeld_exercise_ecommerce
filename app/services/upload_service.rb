require 'csv'

class UploadService
  attr_accessor :results

  def initialize(upload)
    @upload = upload
    @results = []
  end

  def perform
    return unless file.present?

    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        next if blank_row?(row)

        process_row(row)
      end
    end

    @results
  rescue CSV::MalformedCSVError => e
    raise(UploadError, e.message)
  end


  private

  def file
    @upload.file
  end

  def blank_row?(row)
    row['name'].blank? && row['password'].blank?
  end

  def process_row(row)
    user = User.new(name: row['name'], password: row['password'])

    if user.save
      @results << { name: user.name, result: 'success' }
    else
      @results << { name: row['name'], result: user.errors.full_messages.join(', ') }
    end
  end
end
