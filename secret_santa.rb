#!/usr/bin/env ruby
require 'rubygems'
require 'pony'

DEBUG = true # false send emails, true just console output
SUBJECT = "Amigo invisible 2009" # for the emails

# --------------------------------------------------------------------

if $0 == __FILE__
  if ARGV.size < 3
    puts "\t $ #{$0} gmail_user gmail_password email1 email2"
    exit 1
  end
end

# it doesn't matther, the gmail's user will be used instead
FROM = "Amigo invisible <secretsanta@warp.es>"
# Send with gmail smtp
SMTP = {
  :host     => 'smtp.gmail.com',
  :port     => '587',
  :tls      => true,
  :auth     => :plain,
  :user     => ARGV.shift,
  :password => ARGV.shift
}

# -------------------------------------------------------------------

class SecretSanta
  def initialize(from, subject, *emails)
    @from, @subject, @emails = from, subject, emails
    puts "There are an amount of #{@emails.size} emails"
  end

  def send_emails!
    i = 1
    each_pair_off do |to, friend|
      body = "¡Te ha tocado #{friend} chavalote!"
      if DEBUG
        puts "#{to} -> #{body}"
      else
        i += 1
        puts "#{"%02d" % i}) Sending mail to #{to}..."
        Pony.mail(
          :to      => to,
          :from    => @from,
          :subject => @subject,
          :body    => body,
          :via     => :smtp,
          :smtp    => SMTP
        )
      end
    end
  end

protected

  def pair_off
    buyers     = @emails.dup
    receivers  = @emails.dup
    check_list = proc {
      # it's ok only if there is no equal elements on same index
      (0..(buyers.size-1)).detect{|i| buyers[i] == receivers[i] } == nil
    }
    while ! check_list.call do
      buyers    = buyers.sort_by { rand }
      receivers = receivers.sort_by { rand }
    end
    # return as array of array[2]
    buyers.zip receivers
  end

  def each_pair_off
    pair_off.each {|pair| yield pair }
  end
end

# -------------------------------------------------------------------

if $0 == __FILE__
  SecretSanta.new(FROM, SUBJECT, *ARGV).send_emails!
end
