class ServicesBase
  def success(data = {})
    OpenStruct.new(success?: true, data: data)
  end

  def error(data = {})
    OpenStruct.new(success?: false, data: data)
  end
end
