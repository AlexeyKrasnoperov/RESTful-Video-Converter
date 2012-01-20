class Video < ActiveRecord::Base
	
	has_attached_file :uploaded_video, :styles => { 
      :flv => { :geometry => "640x480", :format => 'flv' },
      :mp4 => { :geometry => '640x480', :format => 'mp4',
        :convert_options => { :output => { :vcodec => 'libx264',
          :vpre => 'ipod640', :b => '250k', :bt => '50k',
          :acodec => 'libfaac', :ab => '56k', :ac => 2 } } },
      :ogg => { :geometry => '640x480', :format => 'ogg',
        :convert_options => { :output => { :vcodec => 'libtheora',
          :b => '250k', :bt => '50k', :acodec => 'libvorbis',
          :ab => '56k', :ac => 2 } } },
      :preview => { :geometry => "100x100#", :format => 'jpg', :time => 1 }
    }, :processors => [:ffmpeg]
		validates_attachment_content_type :uploaded_video, :content_type => ['video/x-msvideo','video/avi','video/quicktime','video/3gpp','video/x-ms-wmv','video/mp4','video/mpeg']
    process_in_background :uploaded_video
end
