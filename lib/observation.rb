module Observation
  class Mail
    include Observation
    require 'gmail'

    def initialize(account, password)
      @account = account
      @password = password
    end

    def observe
      got_mails = []
      Gmail.new(@account, @password) do |gmail|
        gmail.label('[Gmail]/&MFkweTBmMG4w4TD8MOs-').emails(:unread).each do |mail|
          got_mail = {}
          got_mail[:subject] = mail.subject
          got_mail[:from] = mail.from.join ', '
          got_mail[:body] = trim_body mail
          got_mails << got_mail
          mail.mark :unread
        end
      end
      got_mails
    end

    private

    def trim_body(mail)
      if !mail.text_part && !mail.html_part
        body = mail.body.decoded.encode('UTF-8', mail.charset)
      elsif mail.text_part
        body = mail.text_part.decoded
      elsif mail.html_part
        body = mail.html_part.decoded
      end
      body.gsub(/\r\n|\r|\n/, ' ').gsub(/[　\s]+/, ' ')[0..50]
    end
  end
end
