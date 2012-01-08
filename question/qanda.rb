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
  answers = {"text" => []}
  result = conn.query("select answertext from answer where questionid='#{id}';")
  result.each_hash do |h|
    answers["text"] << h['answertext']
  end
  return answers
end

request = CGI.new()

json = {"qid" => [{"id" => 1},{"id"=>2}]}
#json = JSON.parse(request.params["json"])

# json examples
# incoming => {"qid":[{"id":8},{"id":32}]}
# outgoing => {"q":"questiontext","answers":[{"id":33,"answer":"answertext1"},{"id":34,"answer":"answertext2"}]}

mysqlaccess = "192.168.1.4", "booty", "booty", "brquestions"
connection = Mysql.new(*mysqlaccess)
size = json["qid"].size
questions = Array.new(size)
answers = Array.new(size)
counter = 0
json["qid"].each do |id|
  questions[counter] = get_question(id["id"],connection)
  answers[counter] = get_answers(id["id"],connection)
  counter = counter + 1
end
# ["Question A", "Question B", "Question C", "Question D"]

mysqlaccess1 = "192.168.1.4", "booty", "booty", "brquestions"
#[["Answer W","Answer X","Answer Y","Answer Z"],
#["Answer W","Answer X","Answer Y","Answer Z"],
#["Answer W","Answer X","Answer Y","Answer Z"],
#["Answer W","Answer X","Answer Y","Answer Z"]]

page = T_qanda.new(questions,answers)

page.get_page