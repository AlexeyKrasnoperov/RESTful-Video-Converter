class Video < ActiveRecord::Base
	
	has_attached_file :uploaded_video, :styles => { 
      :medium => { :geometry => "640x480", :format => 'flv' },
      :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
    }, :processors => [:ffmpeg]
    process_in_background :uploaded_video
# 	has_attached_file :uploaded_video, :default_style => :view, :processors => [:ffmpeg],
#     :url => '/system/:class/:attachment/:id/:style/:basename.:extension',
#     :path => ':rails_root/public/system/:class/:attachment/:id/:style' \
#       + '/:basename.:extension',
#     :default_url => '/images/en/processing.png',
#     :styles => {
#       :mp4video => { :geometry => '520x390', :format => 'mp4',
#         :convert_options => { :output => { :vcodec => 'libx264',
#           :vpre => 'ipod640', :b => '250k', :bt => '50k',
#           :acodec => 'libfaac', :ab => '56k', :ac => 2 } } },
#       :oggvideo => { :geometry => '520x390', :format => 'ogg',
#         :convert_options => { :output => { :vcodec => 'libtheora',
#           :b => '250k', :bt => '50k', :acodec => 'libvorbis',
#           :ab => '56k', :ac => 2 } } },
#       :view => { :geometry => '520x390', :format => 'jpg', :time => 1 },
#       :preview => { :geometry => '160x120', :format => 'jpg', :time => 1 }
#     }
#   validates_attachment_content_type :file, :content_type => VIDEOTYPES,
#     :if => Proc.new { |upload| upload.file.file? }
#   process_in_background :file

end
