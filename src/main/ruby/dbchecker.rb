require "java"

#puts("#{File.expand_path(__FILE__)}")

#["#{File.dirname __FILE__}", "#{File.dirname __FILE__}/lib/"].concat(Dir["#{File.dirname __FILE__}/lib/*.jar"]).each { |jar| $CLASSPATH << jar }
  
java_package 'ch.sag.dbchecker'
java_import 'java.sql.DriverManager'
java_import 'java.lang.System'
java_import 'ch.sag.dbchecker.App'
java_import 'java.util.Properties'
class DBChecker
  def initialize
    @driverClass =  nil ? ENV['DRIVER_CLASS'] : System.getProperty('DRIVER_CLASS')
    @url = nil ? ENV['DB_URL'] :System.getProperty('DB_URL')
    @userName = nil ? ENV['DB_USERNAME'] : System.getProperty('DB_USERNAME')
    @pass = nil ? ENV['DB_PASSWORD'] : System.getProperty('DB_PASSWORD')
    
    
    if @driverClass  == nil
        raise Exception.new("NO DRIVER_CLASS property or env var found !")
    else
      puts "driverClass: #{@driverClass}"
    end

    if  @url== nil
      raise Exception.new("NO DB_URL property found !")
    else
      @url 
      puts "connection URL: #{@url}"
    end

    if @userName == nil
      raise Exception.new("NO DB_USERNAME property found !")
    else
      puts "username: #{@userName}"
    end
   
    
  
    if @pass == nil
          puts("NO DB_PASSWORD property found  set empty one !")
          @pass=''
    end
    
    
   

    puts("start testing  connection .... ")
    connection = nil
    begin
      puts("loading driver")
      Java::JavaClass.for_name(@driverClass)
      puts("start connection")
      #Java::ChSagDbchecker::App:Class

      #App.new.connect(@driverClass,@url,@userName,@pass) 
      info = Properties.new
      info.setProperty("user", @userName);
      info.setProperty("password", @pass);
      con = DriverManager.getConnection(@url,info)
      puts("connected...")
      databaseName= con.getMetaData().getDatabaseProductName()
      databaseVersion =con.getMetaData().getDatabaseMajorVersion()
      puts " database name: #{databaseName} version: #{databaseVersion}"
    ensure
      if connection != nil
        conneciton.close()
        puts("connection closed...")
      end
    end 
    puts("... done testing  connection")
  end

  java_signature 'void main(String[] args)'
  def self.main(args)
    dbChecker = DBChecker.new()
  end

end