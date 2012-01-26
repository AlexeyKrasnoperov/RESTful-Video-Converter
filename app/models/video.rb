class Video < ActiveRecord::Base
	
	has_attached_file :uploaded_video, :styles => {
			:preview => { :geometry => "100x100#", :format => 'jpg', :time => 1 },
      :flv => { :geometry => "640x480", :format => 'flv' }
    }, :processors => [:ffmpeg]
    before_post_process :start_converting
    after_post_process :end_converting
		validates_attachment_content_type :uploaded_video, :content_type => ['video/x-msvideo','video/avi','video/quicktime','video/3gpp','video/x-ms-wmv','video/mp4','video/mpeg']
		validates_attachment_presence :uploaded_video
    process_in_background :uploaded_video
    

	def as_json(options={})
		# :only (explicit list of attributes)
		# :except (attribute exclusion list)
		# :methods (list of methods the execute and include their content)
		# :include (relations)
	  super(:methods => [:preview_url, :flv_url])
	end
	
	def preview_url
		uploaded_video.url(:preview)
	end
	
	def flv_url
		uploaded_video.url(:flv)
	end
	
	def start_converting
# 		puts "*" * 100000 # <--------  I NEVER SEE THIS
# 		self.update_attributes!(:flv_converted => "started")
		self.convertation_status = "started"
	end
	
	def end_converting
# 		update_attributes(:flv_converted => "ended")
# 		puts "ol" * 100000 # <--------  I NEVER SEE THIS
		self.convertation_status = "ended"
	end
end