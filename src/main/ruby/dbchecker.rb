require "java"

#puts("#{File.expand_path(__FILE__)}")

#["#{File.dirname __FILE__}", "#{File.dirname __FILE__}/lib/"].concat(Dir["#{File.dirname __FILE__}/lib/*.jar"]).each { |jar| $CLASSPATH << jar }
  
java_package 'ch.sag.dbchecker'
java_import 'java.sql.DriverManager'
java_import 'java.lang.System'
java_import 'java.util.Properties'
class DBChecker



  def initialize
    @driverClass =  nil ? ENV['DRIVER_CLASS'] : System.getProperty('DRIVER_CLASS')
    @url = nil ? ENV['DB_URL'] :System.getProperty('DB_URL')
    @userName = nil ? ENV['DB_USERNAME'] : System.getProperty('DB_USERNAME')
    @pass = nil ? ENV['DB_PASSWORD'] : System.getProperty('DB_PASSWORD')
    # how long to try to connect to database - default is unlimited
    @maxtry =  nil ?  ENV['MAX_TRY'] : System.getProperty('MAX_TRY')
    
    
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
    
    begin
      if @maxtry == nil
        @maxtry = 4611686018427387903

      end
      @maxtry = Integer(@maxtry)
      puts("maximum retry attempts for connection is #{ @maxtry} " )
    rescue  ArgumentError => e
      #puts("MAX_TRY should be an integer value")
      raise RuntimeError.new("MAX_TRY should be an integer value")
    end
      
    
   

    puts("start testing  connection .... ")
    connection = nil
    n = 0
    mutex = Mutex.new
    #how long to sleep before attemts
    sleepsec = 10

    while true
      begin
      
        puts("loading driver #{@driverClass}")
        Java::JavaClass.for_name(@driverClass)
      
          puts("start connection")
        
          info = Properties.new
          info.setProperty("user", @userName);
          info.setProperty("password", @pass);
          con = DriverManager.getConnection(@url,info)
          puts("A connection was successfully established with the server #{@url} ")
          databaseName= con.getMetaData().getDatabaseProductName()
          databaseVersion =con.getMetaData().getDatabaseMajorVersion()
          puts " database name: #{databaseName} version: #{databaseVersion}"
          puts " "
          n += 1
          mutex.synchronize{n}
          break if n >= @maxtry.to_i
          
          puts("sleep #{sleepsec} sec befor next attempt to connect")
          sleep(sleepsec)
          
      rescue => e
        puts(e)
        # works for postgresql 
        if e.message.include? "The connection attempt failed"
          n += 1
          mutex.synchronize{n}
          break if n >= @maxtry.to_i
          puts("sleep #{sleepsec} sec befor next attempt to connect")
         sleep(sleepsec)
         puts("") # do nothing  
        else
          break
        end

      ensure
        if connection != nil
          conneciton.close()
          puts("connection closed...")
        end
      
     end

    end 
    puts("... done testing  connection")
  end

  java_signature 'void main(String[] args)'
  def self.main(args)
    dbChecker = DBChecker.new()
  end


  
end