require 'commander'

module Commander
  module Config
    %w( add_command command program global_option
        commands alias_command default_command ).each do |meth|
      eval <<-END, binding, __FILE__, __LINE__
        def self.#{meth} *args, &block
          ::Commander::Runner.instance.#{meth} *args, &block
        end
      END
    end
  end
end

$terminal.wrap_at = HighLine::SystemExtensions.terminal_size.first - 5 rescue 80 if $stdin.tty?
at_exit { Commander::Runner.instance.run! }
