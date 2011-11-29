=begin

  implements a matrix concept

=end

class ColorMatrix #< Hash
  @@version  = "0.1" 
  
  @@colors = {
    :white  => 'O',
  }
  
  # attr_accessor :name, :domain, :about
  attr_accessor :x,  :y
  
  def self.initialize(x,y)
    #pviola "Initialize: #{@@log_file}" # = "~/svn/carlesso/tmp/backupmagic.log" # TODO implementa log
  end
    
  def initialize(x,y)

  end
  #alias :I :initialize
  
  def validate
    # mockup
    return true
  end
  
  def valid?
    validate rescue false
  end
  
  
=begin
 CLASS methods !!!
=end 
  def self.about
    "This class is useful for backups. To understand its use, try bin/backup.rb and etc/hosts.yml :)"
  end 
  
  #alias :find_all :find
  

  def to_s(opts={})
    :TODO
  end

end #/RicBackupResource class
