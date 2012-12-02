require 'nokogiri'

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
    @output = File.read("#{ROOT_PATH}#{@path}")
    replace_variables
    @output
  end

  private 

  def replace_variables
    @variables.each do |variable, value|
      if variable == :partial
        replace_partial(value)
      else
        @output.gsub!("{#{variable.to_s}}", value.to_s)
      end
    end
  end

  def replace_partial(partial_arr)
    partial_arr.each do |element_id, variables|
      partial = get_partial(element_id)
      partial_output = ''
      variables.each do |variable|
        partial_content = ''
        variable.each do |key, value|
          if(partial_content.empty?)         
            partial_content = partial.gsub("{#{key}}", value)
          else
            partial_content = partial_content.gsub("{#{key}}", value)
          end
        end
        partial_output += partial_content
      end
      @output.gsub!(partial, partial_output)
    end
  end

  def get_partial(element_id)
    Nokogiri::HTML(@output).xpath("//div[@id='#{element_id}']").inner_html
  end

end