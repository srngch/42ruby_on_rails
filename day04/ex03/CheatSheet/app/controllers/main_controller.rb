# This is a class MainController
class MainController < ApplicationController
  # This is a class MainController
  layout "main"

  def initialize
    super
    @data_get = []
    @read = []
  end

  def convention
  end

  def console
  end

  def ruby
  end

  def ruby_concepts
  end

  def ruby_numbers
  end

  def ruby_strings
  end

  def ruby_arrays
  end

  def ruby_hashes
  end

  def rails_folder_structure
  end

  def rails_commands
  end

  def rails_erb
  end

  def editor
  end

  def help
  end

  def quick_search
  end
	
  def log_book
    @data_get = params[:text]
    file_name = "#{Rails.root}/entry_log.txt"
    read_file_data(file_name)
    if @data_get
      file_appead = File.new(file_name, "a+")
      file_appead.puts "#{Time.now.strftime("%d/%m/%Y %H:%M:%S")} : #{@data_get}"
      redirect_to action: :log_book
    end
  end  
  
  private
    
  def read_file_data(file_name)
    @read = []
    if (File.exist?(file_name))
      file_read = File.open(file_name, "r")
      file_read.each do |line|
        @read.push(line)
      end
      file_read.close
    end
  end
	
end
