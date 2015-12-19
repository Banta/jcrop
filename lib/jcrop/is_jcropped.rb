module Jcrop
  module ActiveRecord
    module InstanceMethods
      def views(action=nil)
        if action
          pageviews.where(action_name: action).count
        else
          pageviews.count
        end
      end
    end
  end
end

class ActiveRecord::Base
  def self.is_jcropped(*attr_names)
    include Pageviews::ActiveRecord::InstanceMethods
    before_save :process_cropped_images

    define_method 'process_cropped_images' do
      attr_names.each do |attr|
        if eval("self.#{attr}")
          image = Paperclip.io_adapters.for(eval("self.#{attr}"))
          image.original_filename = "cropped_file_#{Time.now.to_f.to_s.gsub('.','')}"
          eval("self.#{attr} = image")
        end
      end
    end
  end
end

