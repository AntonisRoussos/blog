module UsersHelper
 
require 'net/smtp'
 
def sendmail(email, name, id)
# logger.debug "id: #{id}"
smtp = Net::SMTP.new('smtp.gmail.com', 587)
smtp.enable_starttls

smtp.start('localhost', 'antonioroussos', 'onlyar12', 'login') do |s|
hdr = "From: Antonis Roussos <antonioroussos@gmail.com>\n"
hdr += "To:"
hdr += name 
hdr += "<"
hdr += email
hdr += ">\n"
hdr += "Subject: e-mail confirmation\n\n"
hdr += url_for(:only_path => false, :protocol => 'http')
# hdr += "http://localhost:3000/user/activateuser/"
hdr += "/activateuser/"
msg = hdr + id.to_s

s.send_message(msg, 'antonioroussos@gmail.com', email)

end

end 

  def gravatar_for(user, options = { :size => 150 })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end