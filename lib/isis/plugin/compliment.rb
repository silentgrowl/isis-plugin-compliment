require "nokogiri"

module Isis
  module Plugin
    class Compliment < Isis::Plugin::Base
      TRIGGERS = ['!compliment', '!comp']

      def respond_to_msg?(msg, speaker)
        @commands = msg.downcase.split
        TRIGGERS.include? @commands[0]
      end

      private

      def response_text
        subject = @commands[1].gsub('@', '')
        compliment = case rand(0..1)
                    when 0
                      toykeeper
                    when 1
                      multicomp
                    end
        "@#{subject} #{compliment}"
      end

      def toykeeper
        page = Nokogiri.HTML(open('http://toykeeper.net/programs/mad/compliments'))
        page.css('.blurb_title_1').text.strip
      end

      def multicomp
        page = Nokogiri.HTML(open('http://www.supersilly.com/cgi/multicomp.cgi?num=1'))
        page.css('body').text.split('Give me')[0].strip
      end
    end
  end
end
