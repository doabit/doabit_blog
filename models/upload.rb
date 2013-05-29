require 'carrierwave/orm/activerecord'
class Upload < ActiveRecord::Base

   mount_uploader :file, Uploader
   validates_presence_of :file
end
