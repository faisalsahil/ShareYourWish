require 'fileutils'
module Common
  
  # add clear files functionality to model
  def clear_files(*args)
    before = args.map{|x| (':clear_' << x.to_s)}.join(', ') 
    accessor = args.map{|x| (':delete_' << x.to_s)}.join(', ') 
    self.class_eval("before_validation #{before}")
    self.class_eval("attr_accessor #{accessor}")
    args.each do |arg|
      name = arg.to_s
      self.class_eval("def delete_#{name}?; @delete_#{name}.to_i.zero? ? false : true; end")
      self.class_eval("def clear_#{name}; self.#{name}.clear if delete_#{name}?; end")
    end
  end
  
  def create_directory_if_not_exists(directory_name)
    FileUtils.mkdir_p(directory_name) unless Dir.exists?(directory_name)
  end
  
  def delete_directory_if_exists(directory_name)
    FileUtils.rm_rf(directory_name) if Dir.exists?(directory_name)
  end

end