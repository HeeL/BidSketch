class Template

  ROOT_PATH = "#{Rails.root}"
  
  def initialize(path)
    @path = path
  end

  def add_variables(variables)
    @variables ||= {}
    @variables.merge!(variables)
  end

  def render
    output = File.read("#{ROOT_PATH}#{@path}")
    @variables.each{|variable, value| output.gsub!("{#{variable.to_s}}", value.to_s)}
    output
  end

end