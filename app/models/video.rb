class Video < ActiveRecord::Base
	
	has_attached_file :uploaded_video, :styles => {
			:preview => { :geometry => "100x100#", :format => 'jpg', :time => 1 },
      :flv => { :geometry => "640x480", :format => 'flv' }
    }, :processors => [:ffmpeg]
		validates_attachment_content_type :uploaded_video, :content_type => ['video/x-msvideo','video/avi','video/quicktime','video/3gpp','video/x-ms-wmv','video/mp4','video/mpeg']
		validates_attachment_presence :uploaded_video
		validates_presence_of :name
		before_uploaded_video_post_process :start_converting
    after_uploaded_video_post_process :end_converting
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
		self.convertation_status = "started"
	end
	
	def end_converting
		self.convertation_status = "ended"
	end
	
	def self.convert(id)
		video = find(id)
		video.update_attributes(:convertation_status => "started")
		videos_path = File.expand_path("public/system/uploaded_videos") + "/#{video.id}/original"
		begin
			system "ffmpeg -i #{videos_path}/#{video.uploaded_video_file_name} -f mp4 -vcodec copy -acodec copy #{videos_path}/output.mp4"
			video.update_attributes(:convertation_status => "ended")
		rescue
			video.updare_attributes(:convertation_status => "error: #{$!}")
		end
		
	end

end