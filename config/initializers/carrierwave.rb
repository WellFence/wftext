CarrierWave.configure do |config|
  config.permissions = 0666
  config.directory_permissions = 0777
  config.storage = :file
  config.enable_processing = false
  #config.root = "#{app/assets/images}/tmp"
  #config.cache_directory = "#{Desktop/root}/tmp/uploads"
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
