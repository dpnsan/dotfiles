Pry.config.editor = 'vim'

# pry-nav aliases
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

# Use Array.toy to get an array to play with
class Array
  def self.toy(n = 10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n) { |i| i+1 }
  end
end

# Use Hash.toy to get an hash to play with
class Hash
  def self.toy(n = 10)
    Hash[Array.toy(n).zip(Array.toy(n){ |c| (96+(c+1)).chr })]
  end
end

# redirect Rails log to stdout
if defined?(Rails) && Rails.env
  require 'logger'

  if defined?(ActiveRecord)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.clear_active_connections!
  end

  if defined?(DataMapper)
    DataMapper::Logger.new($stdout, :debug)
  end

end
