require './html_util'

class T_qanda

  public
  #questions => [{"text" => string,...]
  #answers => [[{"text" => string,...],...]
  def initialize(questions, answers)
    @questions = questions
    @answers = answers
    @html = HTML.new("Questions")
    build_page
  end
  
  def get_page
    @html.make_page
  end

  private
  def build_page
    
    @html.add_header '<link rel="stylesheet" type="text/css" href="BootyRun.css" />'
    
    @html << '<div id="pageW">'
    @html << '  <header>'
    @html << '    <div class="logo">'
    @html << '      <img src="logo.png" alt="Booty Run" />'
    @html << '    </div>'
    @html << '    <div class="Timer">'
    @html << '      <p><strong>Time:</strong> 00:00:00 </p>'
    @html << '    </div>'
    @html << '  </header>'
    @html << '  <div id="form">'
    @html << '    <form action="PAULS_CODE.rb" method="post">'
    (0..@questions.length-1).each do |count|
      questionbox(@questions[count], @answers[count], count + 1)
    end
    @html << '      <div class="button">'
    @html << '        <input type="submit" value="Submit Answers">'
    @html << '        <input type="reset" value="Reset Answers">'
    @html << '      </div>'
    @html << '    </form>'
    @html << '  </div>'
    @html << '  <footer>'
    @html << '    <p>'
    @html << '      Template created by Clayton Headley as part of the Booty Run enhancment project.'
    @html << '    </p>'
    @html << '  </footer>'
    @html << '</div>'
  end
  def nl
    return "\n"
  end
  
  #question => string
  #answers => [string,...]
  #id => string
  def questionbox(question,answers,id)
    @html << '      <div class="qbox">' + nl
    @html << '        <fieldset>' + nl
    @html << '          <legend> <strong>Question ' + id.to_s + ':</strong> </legend>' + nl
    @html << '          <p class="question">' + question["text"] + '</p>' + nl
    answer_count = 1
    (answers["text"]).each do |answer|
      question = '        <input type="radio" name="questionid'
      question << id.to_s
      question << '" value="answerval'
      question << answer_count.to_s
      question << '" /> <span class="answer">'
      question << answer
      question << '</span> <br />'
      question << nl
      
      @html << question
      answer_count = answer_count + 1
    end
    @html << '        </fieldset>' + nl
    @html << '      </div>' + nl
  end
end
