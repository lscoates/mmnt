class UploadedImageOptimizer
  def self.call(path)
    ImageProcessing::MiniMagick.source(path)
      .resize_to_limit(1200, 1200)
      .call(destination: path)
  end
end
