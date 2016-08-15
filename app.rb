require 'sinatra'
require 'rubygems'
require 'tilt/erb'
require 'bcrypt'
require 'pony'
require 'bcrypt'
require 'pg'

load "./local_env.rb" if File.exists?("./local_env.rb")
db_params={
   host: "lockerroom.c4iif5msrrmw.us-west-2.rds.amazonaws.com",
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
post '/contact' do
  name = params[:firstname]
  lname= params[:lastname]
  from = params[:email]
  @to = "#{from}"                   
  comments = params[:message]
  subject= params[:subject]
 Pony.mail(
    :to => @to, 
    :from => ENV['from'],
    :subject => "The Locker Room", 
    :content_type => 'text/html', 
    :body => erb(:email2,:layout=>false),
    :via => :smtp, 
    :via_options => {
    :address              => 'email-smtp.us-east-1.amazonaws.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name           => ENV['a3smtpuser'],
    :password            => ENV['a3smtppass'],
    :authentication       => :plain, 
    :domain               => "localhost.localdomain" 
        }
      )

  erb :submit
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