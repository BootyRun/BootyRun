require './html_util'

class T_qanda

  public
  def initialize (questions, answers)
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
      @html << questionbox(@questions[count], @answers[count], ("questionid" + (count + 1).to_s))
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
  
  def questionbox(question,answers,id)
    q = '    <div class="qbox">' + nl
    q << '      <fieldset>' + nl
    q << '        <legend> <strong>Question ' + id.to_str + ':</strong> </legend>' + nl
    q << '        <p class="question">' + question + '</p>' + nl
    (0..(answers.length-1)).each do |count|
      question = '        <input type="radio" name="'
      question << id
      question << '" value="answerval'
      question << (count + 1).to_s
      question << '" /> <span class="answer">'
      question << answers[count]
      question << '</span> <br />'
      question << nl
      
      q << question
    end
    q << '      </fieldset>' + nl
    q << '    </div>' + nl
    return q
  end
end
