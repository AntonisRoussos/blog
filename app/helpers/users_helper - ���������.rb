module UsersHelper
 
 require 'net/smtp'
 
 def sendmail
   
smtp = Net::SMTP.new('smtp.gmail.com', 587)
smtp.enable_starttls
smtp.start('localhost', 'antonioroussos', 'onlyar12', 'login') do |s|
  hdr = "From: Antonis Roussos <antonioroussos@gmail.com>\n"
  hdr += "To: Antonis Roussos <grtramp@yahoo.gr>\n"
  hdr += "Subject: test\n\n"
  msg = hdr + "http://localhost:3000"
  s.send_message(msg, 'antonioroussos@gmail.com', 'grtramp@yahoo.gr')
end 

 end

  def gravatar_for(user, options = { :size => 150 })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end