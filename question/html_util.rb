class HTML
  
  def initialize(title)
    @title = title
    @body = []
    @header = []
  end
  
 
  def add_body(content)
    content_stuff = content.to_s.split '\n'
    content_stuff.each do |line|
      @body << '    ' + line
    end
  end
  
  def add_header(content)
    content_stuff = content.to_s.split '\n'
    content_stuff.each do |line|
      @header << '    ' + line
    end
  end
  
  def <<(content)
    add_body content
  end
  
  def make_page
    puts '<html>'
    puts '  <head>'
    puts '    <title>' + @title + '</title>'
    @header.each do |line|
      puts line
    end
    puts '  </head>'
    puts '  <body>'
    @body.each do |line|
      puts line
    end
    puts '  </body>'
    puts '</html>'
  end
  
end