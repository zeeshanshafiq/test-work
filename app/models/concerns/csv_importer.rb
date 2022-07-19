require 'csv'
module CsvImporter
  extend ActiveSupport::Concern

  class_methods do
    def import(file_path)
      insert_all(CSV.foreach(file_path, headers: true).map{|row| row.to_hash})
    end
  end
end