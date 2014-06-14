require 'nokogiri'

def booknumber (bookname)
	case bookname
	when "Быт."
		1
	when "Исх."
		2
	when "Лев."
		3
	when "Чис."
		4
	when "Втор."
		5
	when "Ис.Нав."
		6
	when "Суд."
		7
	when "Руфь"
		8
	when "1Цар."
		9
	when "2Цар."
		10
	when "3Цар."
		11
	when "4Цар."
		12
	when "1Пар."
		13
	when "2Пар."
		14
	when "Езд."
		15
	when "Неем."
		16
	when "Есф."
		17
	when "Иов"
		18
	when "Пс."
		19
	when "Пр."
		20
	when "Еккл."
		21
	when "П.Песней"
		22
	when "Ис."
		23
	when "Иерем."
		24
	when "Пл.Иер."
		25
	when "Иез."
		26
	when "Дан."
		27
	when "Осия"
		28
	when "Иоиль"
		29
	when "Амос"
		30
	when "Авдий"
		31
	when "Иона"
		32
	when "Михея"
		33
	when "Наума"
		34
	when "Аввакум"
		35
	when "Софония"
		36
	when "Аггей"
		37
	when "Зах."
		38
	when "Малахия"
		39
	when "Мтф."
		40
	when "Марк."
		41
	when "Лук."
		42
	when "Иоан."
		43
	when "Деян."
		44
	when "Иакова"
		45
	when "1Петр."
		46
	when "2Петр."
		47
	when "1Иоан."
		48
	when "2Иоан."
		49
	when "3Иоан."
		50
	when "Иуды"
		51
	when "Рим."
		52
	when "1Кор."
		53
	when "2Кор."
		54
	when "Гал."
		55
	when "Ефесянам"
		56
	when "Филип."
		57
	when "Колос."
		58
	when "1Фес."
		59
	when "2Фес."
		60
	when "1Тим."
		61
	when "2Тим."
		62
	when "Титу"
		63
	when "Филимону"
		64
	when "Евр."
		65
	when "Откр."
		66
	else
		1
	end	
end

@testament = 1
@book = 1
@realbook = 1
@chapter =1

if ARGV
	@realbook, @chapter = ARGV[0].to_i, ARGV[1].to_i
	if ARGV[0].to_i > 39
		@testament = 2
		@book = @realbook - 39
	else
		@book = @realbook
	end
	@chapter =1 unless ARGV[1]
end

def printchapter doc
	doc.css("body:nth-of-type(#{@testament}) > section:nth-of-type(#{@book}) > section:nth-of-type(#{@chapter}) > p").each do |paragraph|
		# remove emphasis tags
		paragraph.css("emphasis").each do |em| 
			em.replace em.inner_html 
		end 
		print "    "
		paragraph.to_s.scan(/sup> ([^<]*)</){|verse| print verse}
		puts
	end
end

def printchapternl doc # each verse from new line
	doc.css("body:nth-of-type(#{@testament}) > section:nth-of-type(#{@book}) > section:nth-of-type(#{@chapter}) > p").each do |paragraph|
		# remove emphasis tags
		paragraph.css("emphasis").each do |em| 
			em.replace em.inner_html 
		end
		paragraph.to_s.scan(/sup> ([^<]*)</){|verse| puts verse}
	end
end

def printbook doc # for books of one chapter
	doc.css("body:nth-of-type(#{@testament}) > section:nth-of-type(#{@book}) > p").each do |paragraph|
		# remove emphasis tags
		paragraph.css("emphasis").each do |em| 
			em.replace em.inner_html 
		end 
		print "    "
		paragraph.to_s.scan(/sup> ([^<]*)</){|verse| print verse}
		puts
	end
end

def printplace
	f = File.open("/Users/phil/my/todaybible/Bible_par.fb2")
	doc = Nokogiri::XML(f)
	case @realbook
	when 31, 49, 50, 51, 64
		printbook(doc)
	when 19, 20
		printchapternl(doc)
	else
		printchapter(doc)
	end
	f.close
end

printplace
