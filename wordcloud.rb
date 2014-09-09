require 'json'

def read_file(file)
  file = File.open(file, "r")
  data = file.read
  file.close
  data
end

def whitespace_split(data)
  all_words = []
  data.each_value do |v|
    v.each do |phrase|
      individual_words = phrase.split(" ")
      individual_words.each {|word| all_words << word.downcase}
    end
  end
  all_words.uniq!
  all_words
end

def build_output(all_words, data)
  output = {}
  all_words.each do |word|
    count = 0
    name_arr = []
    data.each_pair do |name,phrases|
      phrases.each do |phrase|
        if phrase.downcase.include?(word)
          count += 1
          unless name_arr.include?(name)
            name_arr << name
          end
        end
      end
    end
    output[word] = { :count => count, :people => name_arr}
  end
  output
end

def word_cloud(data)
  all_words = whitespace_split(data)
  build_output(all_words, data)
end

file = read_file("data/quotes.json")
data = JSON.parse(file)
output =  word_cloud(data)
output.each {|w| p w}
