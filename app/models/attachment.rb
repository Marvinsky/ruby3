class Attachment < ActiveRecord::Base
  belongs_to :post
  after_save :store_image

  PATH_FILE = File.join Rails.root, "public", "files"

  #file == false attribute and that is the reason we can use it in the view
  def file=(file)
  	unless file.blank?
  		@file = file
  		self.name = file.original_filename
  		self.extension = file.original_filename.split(".").last.downcase
  	end
  end

  def path_image
  	File.join PATH_FILE, "#{self.id}.#{self.extension}"
  end

  def has_file?
  	File.exists? path_image
  end


  private

  def store_image
  	if @file
  		FileUtils.mkdir_p PATH_FILE
  		File.open(path_image, "wb") do |f|
  			f.write(@file.read)
  		end
		@file = nil  		
  	end
   end
end
