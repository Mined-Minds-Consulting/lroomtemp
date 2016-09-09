require 'sinatra'
require 'rubygems'
require 'tilt/erb'
require 'bcrypt'
require 'pony'
require 'bcrypt'
require 'pg'

load "./local_env.rb" if File.exists?("./local_env.rb")
db_params={
   host: "lockerroom.ccar1za80ci4.us-west-2.rds.amazonaws.com",
   port:'5432',
   dbname:'lockerroom',
   user:ENV['user'],
   password:ENV['password'],    
}

db= PG::Connection.new(db_params)

get '/' do
    @title = 'LockerRoom'
    erb :index
end
get '/contact' do
    @title = 'Contact Us'
    erb :contact
end

Mail.defaults do
  delivery_method :smtp, 
  address: "email-smtp.us-east-1.amazonaws.com", 
  port: 587,
  :user_name  => ENV['a3smtpuser'],
  :password   => ENV['a3smtppass'],
  :enable_ssl => true
end
post '/contact' do
  name = params[:firstname]
  lname= params[:lastname]
  email= params[:email]                  
  comments = params[:message]
  subject= params[:subject]
  email_body = erb(:email2,:layout=>false, :locals=>{:subject => subject,:firstname => name, :lastname => lname, :email => email, :message => comments})
  
  mail = Mail.new do
    from         ENV['from']
    to           email
    bcc          ENV['from']
    subject      subject
    
    html_part do
      content_type 'text/html'
      body         email_body
    end
  end

  mail.deliver!
    erb :success, :locals => {:message => "Thanks for contacting us."}
end


post '/subscribe.php' do
    email= params[:email]
    check_email = db.exec("SELECT * FROM mailing_list WHERE email = '#{email}'")
       
    if
        check_email.num_tuples.zero? == false
            erb :mailing_list, :locals => {:message => "You have already joined our mailing list"}
    else
         subscribe=db.exec("insert into mailing_list(email)VALUES('#{email}')")
         erb :mailing_list, :locals => {:message => "Thanks, for joining our mailing list."}
    end

end
post '/submit' do
    erb :submit1
end    
