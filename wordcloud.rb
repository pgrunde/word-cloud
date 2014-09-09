require 'json'

def read_file(file)
  file = File.open(file, "r")
  data = file.read
  file.close
  data
end

json = '{
  "Ila Huels": [
    "OPTIMIZE WEB-ENABLED SUPPLY-CHAINS",
    "brand sexy channels",
    "ENVISIONEER ROBUST E-COMMERCE",
    "TRANSFORM WIRELESS ARCHITECTURES",
    "BENCHMARK CROSS-PLATFORM PARTNERSHIPS"
  ],
  "Cristopher Feest": [
    "BENCHMARK CROSS-PLATFORM PARTNERSHIPS",
    "brand sexy channels",
    "BENCHMARK 24/7 PARADIGMS"
  ]
}'


data = JSON.parse(json)

def word_cloud(data)
  output = {}
  all_words = []
  # go over each person, pull out each phrase & split by whitespace
  data.each_value do |v|
    v.each do |phrase|
      individual_words = phrase.split(" ")
      individual_words.each {|word| all_words << word.downcase}
    end
  end
  all_words.uniq!
  # take each word, find out if a person said them and how many times.
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

file = read_file("data/quotes.json")
data = JSON.parse(file)
output =  word_cloud(data)
output.each {|w| p w}
