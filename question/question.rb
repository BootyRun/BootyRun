require 'mysql'
require 'optparse'
require 'json'
# json examples
# incoming => {"id":8}
# outgoing => {"q":"questiontext","answers":[{"id":33,"answer":"answertext1"},{"id":34,"answer":"answertext2"}]}

option = {}
mysqlaccess = "192.168.1.4", "booty", "booty", "brquestions"

OptionParser.new do |opts|
	opts.banner = "Commands for addquestion script"
	opts.separator "----"
	
	opts.on("-q STRING", "--question STRING", "The question to add.") do |value|
		option[:question] = value
	end
	
	opts.on("-a NUMBER:BOOLEAN", "--set_active NUMBER:BOOLEAN", "Changes the active state of the question with the id given.") do |value|
		argvalue = value.split(':');
		option[:activeid] = argvalue[0]
		option[:activestate] = argvalue[1]
		if option[:activeid] == nil || option[:activeid] == nil || argvalue[2] != nil
			puts "Argument has incorrect format."
			exit
		elsif option[:activestate].downcase != "true" && option[:activestate].downcase != "false"
			puts "Secondary item is not a boolean value."
			exit
		end
	end
	
	opts.on("-g NUMBER", "--get_question NUMBER", "Looks up the question with the id given.") do |value|
		option[:questionid] = value
	end
	
	opts.on("-G NUMBER", "--get_answers NUMBER", "Looks up the answers to the question with the id given.") do |value|
		option[:answerid] = value
	end
	
	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end
end.parse!

	
def getquestion(id, conn)
	result = conn.query("select questiontext from question where id='#{id}';")
	result.each_hash{|h| puts h['questiontext']}
end

def getanswers(id, conn)
	getquestion(id, conn)
	result = conn.query("select answertext,correct from answer where questionid='#{id}';")
	result.each_hash{|h| puts "#{h['answertext']} : #{h['correct']}"}
end

def sendquestion(question, conn)
	conn.query("insert into question (questiontext) values ('#{conn.escape_string(question)}');")
end

def setquestionstatus(id, state, conn)
	conn.query("update question set active=#{state} where id='#{id}';")
end

connection = Mysql.new(*mysqlaccess)

if option[:question]
	sendquestion(option[:question], connection)
	puts "Question successfully added."
end

if option[:questionid]
	getquestion(option[:questionid], connection)
end

if option[:answerid]
	getanswers(option[:answerid], connection)
end

if option[:activeid]
	setquestionstatus(option[:activeid], option[:activestate], connection)
end

connection.close
