require 'csv'

class MovieImportJob < ApplicationJob
  queue_as :default

  def perform(import_id)
    import = Import.find(import_id)
    process_import(import)
  rescue CSV::MalformedCSVError
    fail_import(import, I18n.t('movie_import.errors.malformed_csv'))
  rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
    fail_import(import, I18n.t('movie_import.errors.encoding'))
  rescue StandardError => e
    fail_import(import, I18n.t('movie_import.errors.unexpected', message: e.message))
  end

  private

  def process_import(import)
    user = import.user
    update_status(import, :processing)

    csv = parse_csv(import)

    ActiveRecord::Base.transaction do
      import_movies(csv, user)
      update_status(import, :completed)
    end

    notify_user(import)
  end

  def parse_csv(import)
    content = import.file.download.force_encoding('UTF-8')
    csv = CSV.parse(content, headers: true)
    raise I18n.t('movie_import.errors.no_headers') if csv.headers.blank?

    csv
  end

  def import_movies(csv, user)
    csv.each_with_index { |row, index| import_movie_row(row, index, user) }
  end

  def import_movie_row(row, index, user)
    director = Director.find_or_create_by!(name: row['director'])
    category = Category.find_by!(name: row['category'])
    attrs = build_movie_attributes(row, director, category, user)
    create_movie!(attrs, index)
  rescue ActiveRecord::RecordNotFound => e
    raise I18n.t('movie_import.errors.not_found', line: index + 2, message: e.message)
  end

  def build_movie_attributes(row, director, category, user)
    {
      title: row['title'],
      description: row['description'],
      release_year: row['release_year'].to_i,
      duration: row['duration'].to_i,
      director: director,
      category: category,
      user: user
    }
  end

  def create_movie!(attrs, index)
    Movie.create!(attrs)
  rescue ActiveRecord::RecordInvalid => e
    raise I18n.t('movie_import.errors.invalid_record', line: index + 2,
                                                       messages: e.record.errors.full_messages.join(', '))
  end

  def update_status(import, status)
    import.update!(status: status)
  end

  def notify_user(import)
    ImportMailer.with(import: import).notify_user.deliver_later
  end

  def fail_import(import, message)
    update_status(import, :failed)
    import.update!(error_message: message)
    notify_user(import)
  end
end
