# NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# upload or store files but allows test to pass as if files were stored and
# the use of fixtures.
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  # Retrieve a blank file that can be used your app
  # Put a blank image in your test/fixtures/files folder
  # Use a copy of that image from tmp folder
  def retrieve!(_identifier)
    file = Rails.root.join('test', 'fixtures', 'files', 'blank.jpg')
    tmp = Rails.root.join('tmp', 'blank_tmp.jpg')
    FileUtils.cp(file, tmp)
    CarrierWave::SanitizedFile.new(tmp)
  end
  
end



CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
      :region                 => ENV['S3_REGION']
    }
    config.fog_directory      = ENV['S3_BUCKET']
  elsif Rails.env.test?
    config.storage NullStorage
    config.enable_processing = false
  end
end



# # NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# # upload or store files but allows test to pass as if files were stored and
# # the use of fixtures.
# class NullStorage
#   attr_reader :uploader

#   def initialize(uploader)
#     @uploader = uploader
#   end

#   def identifier
#     uploader.filename
#   end

#   def store!(_file)
#     true
#   end

#   def retrieve!(_identifier)
#     true
#   end
# end

# CarrierWave.configure do |config|
#   # Make the tmp dir work on Heroku
#   config.cache_dir = "#{Rails.root}/tmp/uploads"

#   if Rails.env.production? || Rails.env.staging?
#     config.storage :fog
#     config.fog_credentials = {
#       provider:               "AWS",
#       # When precompiling assets Fog will be initialized and needs to be
#       # initialized (even though it will never touch S3), provide some values
#       # to prevent Fog gem from crashing during initialize wihtout actually
#       # giving away the keys.
#       aws_access_key_id:      ENV["S3_KEY"] || "S3_KEY",
#       aws_secret_access_key:  ENV["S3_SECRET"] || "S3_SECRET"
#     }

#     config.fog_directory  = ENV["S3_BUCKET"]
#     # App requires explicit protocol to be specified for uploaded assets
#     # Do not change to "//..." like we are doing with the other asset hosts
#     config.asset_host     = "https://#{ENV["S3_CDN_HOST"]}"
#     config.fog_attributes = { "Cache-Control" => "max-age=315576000" }

#   elsif Rails.env.development?
#     config.storage :file
#     config.asset_host = "http://#{ENV["S3_CDN_HOST"] || ENV["HOST"]}"

#   elsif Rails.env.test?
#     config.storage NullStorage
#     # Required to prevent FactoryGirl from giving an infuriating exception
#     # ArgumentError: wrong exec option
#     # It also speeds up tests so it's a good idea
#     config.enable_processing = false
#   end
# end

# # https://gist.github.com/1058477
# module CarrierWave::MiniMagick
#   def quality(percentage)
#     manipulate! do |img|
#       img.quality(percentage.to_s)
#       img = yield(img) if block_given?
#       img
#     end
#   end
# end