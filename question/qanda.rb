require 'cgi'
require 'json'
require 'mysql'
require './template_qanda'

def get_question(id, conn)
  question = {"text" => ""}
  result = conn.query("select questiontext from question where id='#{id}';")
  result.each_hash do |h|
    question["text"] << h['questiontext']
  end
  return question
end

def get_answers(id, conn)
  answers = {"text" => [],"correctness" => []}
  result = conn.query("select answertext,correct from answer where questionid='#{id}';")
  result.each_hash do |h|
     answers["text"] << h['answertext']
     answers["correctness"] << h['correct']
  end
  return answers
end

request = CGI.new()

#json = {"id" => "1"}
json = JSON.parse(request.params["json"])

# json examples
# incoming => {"id":8}
# outgoing => {"q":"questiontext","answers":[{"id":33,"answer":"answertext1"},{"id":34,"answer":"answertext2"}]}

mysqlaccess = "192.168.1.4", "booty", "booty", "brquestions"
connection = Mysql.new(*mysqlaccess)

question = get_question(json["id"],connection)
# ["Question A", "Question B", "Question C", "Question D"]

mysqlaccess1 = "192.168.1.4", "booty", "booty", "brquestions"
answers = get_answers(json["id"],connection)
#[["Answer W","Answer X","Answer Y","Answer Z"],
#["Answer W","Answer X","Answer Y","Answer Z"],
#["Answer W","Answer X","Answer Y","Answer Z"],
#["Answer W","Answer X","Answer Y","Answer Z"]]

page = T_qanda.new([question["text"]],[answers["text"]])

page.get_page